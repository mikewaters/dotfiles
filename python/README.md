This omits password from .pypirc, which is a problem if you are using setuptools (you will get 401, or some other error).
Alternatively, use `twine`, which will prompt you for your password each time you upload, which is way better than storing
your secrets in plaintext.
