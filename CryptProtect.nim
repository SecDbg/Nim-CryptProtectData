import winim, base64

var
    inputString = "Hello, World!"
    encryptBlob: DATA_BLOB
    encryptedBlob: DATA_BLOB
    decryptedBlob: DATA_BLOB

# CryptProtectData
encryptBlob.cbData = (int32)inputString.len
encryptBlob.pbData = cast[ptr BYTE](cstring(inputString))

let successProtectData: bool = CryptProtectData(
    pDataIn = addr encryptBlob, 
    szDataDescr = NULL,
    pOptionalEntropy = NULL, 
    pvReserved = NULL, 
    pPromptStruct = NULL, 
    dwFlags = CRYPTPROTECT_UI_FORBIDDEN, 
    pDataOut = addr encryptedBlob
)

if successProtectData:
    var encryptedData: string
    encryptedData.setLen(encryptedBlob.cbData)

    copyMem(&encryptedData, encryptedBlob.pbData, encryptedBlob.cbData)
    echo "> Successfully encrypted data! Output: ", encode(encryptedData)
else:
    echo "> Failed to encrypt data!"

# CryptUnprotectData

let sucessUnprotectData: bool = CryptUnprotectData(
    pDataIn = addr encryptedBlob,
    ppszDataDescr = NULL,
    pOptionalEntropy = NULL, 
    pvReserved = NULL, 
    pPromptStruct = NULL, 
    dwFlags = CRYPTPROTECT_UI_FORBIDDEN, 
    pDataOut = addr decryptedBlob
)

if sucessUnprotectData:
    var decryptedData: string
    decryptedData.setLen(decryptedBlob.cbData)

    copyMem(&decryptedData, decryptedBlob.pbData, decryptedBlob.cbData)
    echo "> Successfully decrypted data! Output: ", decryptedData
else:
    echo "> Failed to decrypt data!"