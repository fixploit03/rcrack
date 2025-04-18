#!/usr/bin/env python3
#
# Ekstrak hash file LibreOffice/OpenOffice ODF ke format JTR (John The Ripper)
# dibuat oleh: Rofi (Fixploit03)
# Sumber: https://github.com/pmittaldev/john-the-ripper/blob/master/run/odf2john.py
#
# Ditulis ulang menggunakan python 3

"""
odf2john.py processes ODF files into a format suitable for use with JtR.

Output Format:

filename:$odf*cipher type*checksum type*iterations*key-size*checksum*
iv length*iv*salt length*salt*inline or not*content.xml or its path
"""

from xml.etree.ElementTree import ElementTree
import zipfile
import sys
import base64
import binascii


def process_file(filename):
    try:
        zf = zipfile.ZipFile(filename)
    except zipfile.BadZipfile:
        print("%s is not an OpenOffice file!" % filename, file=sys.stderr)
        return 2
    try:
        mf = zf.open("META-INF/manifest.xml")
    except KeyError:
        print("%s is not an OpenOffice file!" % filename, file=sys.stderr)
        return 3
    tree = ElementTree()
    tree.parse(mf)
    r = tree.getroot()
    elements = list(r.iter())
    is_encrypted = False
    key_size = 16
    for i in range(0, len(elements)):
        element = elements[i]
        if element.get("{urn:oasis:names:tc:opendocument:xmlns:manifest:1.0}full-path") == "content.xml":
            for j in range(i + 1, i + 1 + 3):
                element = elements[j]
                # print element.items()
                data = element.get("{urn:oasis:names:tc:opendocument:xmlns:manifest:1.0}checksum")
                if data:
                    is_encrypted = True
                    checksum = data
                data = element.get("{urn:oasis:names:tc:opendocument:xmlns:manifest:1.0}checksum-type")
                if data:
                    checksum_type = data
                data = element.get("{urn:oasis:names:tc:opendocument:xmlns:manifest:1.0}initialisation-vector")
                if data:
                    iv = data
                data = element.get("{urn:oasis:names:tc:opendocument:xmlns:manifest:1.0}salt")
                if data:
                    salt = data
                data = element.get("{urn:oasis:names:tc:opendocument:xmlns:manifest:1.0}algorithm-name")
                if data:
                    algorithm_name = data
                data = element.get("{urn:oasis:names:tc:opendocument:xmlns:manifest:1.0}iteration-count")
                if data:
                    iteration_count = data
                data = element.get("{urn:oasis:names:tc:opendocument:xmlns:manifest:1.0}key-size")
                if data:
                    key_size = data

    if not is_encrypted:
        print("%s is not an encrypted OpenOffice file!" % filename, file=sys.stderr)
        return 4

    checksum = binascii.hexlify(base64.b64decode(checksum)).decode('ascii')
    iv = binascii.hexlify(base64.b64decode(iv)).decode('ascii')
    salt = binascii.hexlify(base64.b64decode(salt)).decode('ascii')

    # extract and save content.xml, used later by john
    try:
        content = zf.open("content.xml").read()
    except KeyError:
        print("%s is not an encrypted OpenOffice file, content.xml missing!" % filename, file=sys.stderr)
        return 5
    # folder = os.path.dirname(os.path.realpath(filename))
    # handle, fn = tempfile.mkstemp(suffix='-content.xml', dir=folder)
    # fhandle = os.fdopen(handle, "wb")
    # fhandle.write(content)
    # fhandle.close()

    if algorithm_name.find("Blowfish CFB") > -1:
        algorithm_type = 0
    elif algorithm_name.find("aes256-cbc") > -1:
        algorithm_type = 1
    else:
        print("%s uses un-supported encryption!" % filename, file=sys.stderr)
        return 6

    if checksum_type.find("SHA1") > -1:
        checksum_type = 0
    elif checksum_type.find("SHA256") > -1:
        checksum_type = 1
    else:
        print("%s uses un-supported checksum algorithm!" % filename, file=sys.stderr)
        return 7

    print("%s:$odf$*%s*%s*%s*%s*%s*%d*%s*%d*%s*%d*%s" % (filename, algorithm_type,
            checksum_type, iteration_count, key_size, checksum, len(iv) // 2,
            iv, len(salt) // 2, salt, 0, binascii.hexlify(content[:1024]).decode('ascii')))


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: %s <OpenOffice / LibreOffice files>" % sys.argv[0], file=sys.stderr)
        sys.exit(-1)

    for i in range(1, len(sys.argv)):
        process_file(sys.argv[i])
