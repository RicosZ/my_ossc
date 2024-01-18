class Credential {
  static const sheet = r'''{
  "type": "service_account",
  "project_id": "phone-record-gsheet",
  "private_key_id": "d9bb8275bf95b2fbb5512ef1b406235e5fbcfb48",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDe4T/kN4NkGUcx\nlwwB9xBvN85d9caQXtQnnwwZsMeo/WrE1IUlx1vwRMcWrGpAueGoLKDvrO8Td5EH\nWYuxlInz+gd3W10MloWVKLtEa5p5RbCvoDiWjsxXlGS/ZcdQKPuVeqwdZfc61z1w\n07da2yGUNtWAOq82CGrkS4ZmlZRatcF0HfvpztH76R37wynmMiY8oV3D6S/BYrcs\nWucBNpItVI9W0XYP/ya4DKbD0ZTqwbQRJIcHGWpoHQUGr0Sqbitu0+b1xNHYBAY2\n2VdNFsOHHUFHJMgfBu0s3SOqfk1tteqiMNT7mSNp2uaYMV3CE3tSKxpmtt00bBPt\n+CBJ9yj5AgMBAAECggEAF8YCCSdMugwiNm1sp/cBB0P2HLqfE/4xdgp2gXUETwe8\n8ELU8vspWN8VN1trt/y7z7L29anGFJb/3r9T8bys3FvSmQ4jRjj2BbuDAiDSKNZg\nqtMVxiV0MXFQL8Q89tVwRHkBy974+ItF7/d9StEt6z/QFS3tS3+pWzGdI+sXmHcw\nsamYvt3ChAUzDWnyhx5ZqnjdOEUop//8CsNSDocyYgwJDg5zO6C+yJoB+OPd3HwD\nD+huLqsir2X3mC4da8Ojis2vum3wc4HNKPDECMGlGRRS7GrUpLDxFqxbzqlzj9aV\nDCISElWHAIrLNRiENPd+Vn3pA7FZ47pC61t8DQ5cQQKBgQD1hZ53+XwdGtrZ6Ixl\nRr7oX2HC8X6Q2k3sDPWA308PAiyJ7mfEiAk2vB89Z7dbR1kPQ3m1Wzw6ZmaMoI0z\nUvxojd4IsZD3gOr00zJoDg1m1WaMWM96RGfpaRp/EXITU4oxO0AGQzvyXEiaPEFX\nXkMStOmu+ktP+pCSO5NEAlaZ6QKBgQDoZELRuTCUejvpV5E5cRxPnRr+s36QSPbf\nWMSjiIaZCnA3SFBzb+bC31oscbutsjVV+rYmZAUg03Rn81+DqKr4dSOyyvsAwfxZ\n0Sboc8OyGtG2+RJ8lO2TOUeKsAlOsOXpBR8Nb/XfADZVXzmtYgMnhVCGjlYSAubj\n8m321CCckQKBgQDkpv4AKZ6G1H3AtqwZnZspebrn/FOsv0IWdbMlw9Iy3glwo1CM\nXUyHZweI/lBqd7XfWy270i3zDW6vxM37YGulS4nees/RUISAYTfuZDfi7xbD2enP\nqmlDnRiKAktE6GYol093BaKMgZkz2q3XmffJMib3SC5fW7DMHyN1EOBqEQKBgFcK\n7qglCBgk7HnK7b8pKaR8QNczne0nFyiy0/w4r8l0ynE6ab/DIxjMlbbd5qD5hdat\ncDpS7kTMTuZ8lsL2kws6vOND+d3fyshNeZhJe/wi5Xf2NMFq+s1RAAXnR6UsxwCP\nhYD/9YTQTImPgEf71Riha3bqqzxVz+uDK0LvU0OxAoGAVgv8YuLWKojbTkF6G3zN\nZ0VjWmU5yl1mgBb1ftBM7iwbLwR4c2Ypp1tdh32n5ve69c1LF4ObTfqC8FRy/Zpg\nwXqleoCJSXsYyNbmKV2STs3eZTAv7n/LWHjV8CLWEGGyldEYm++E7FuJNipxW7dJ\nBLebBIYxyt7oiIhWPaqQNQU=\n-----END PRIVATE KEY-----\n",
  "client_email": "phone-record-gsheet@phone-record-gsheet.iam.gserviceaccount.com",
  "client_id": "117376338584059239179",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/phone-record-gsheet%40phone-record-gsheet.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

static const drive = r'''{
  "type": "service_account",
  "project_id": "myossc",
  "private_key_id": "46bce3f22a245ca37dd5bc6df2dc0e0fdc857479",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDMUHit1Q2UczkT\ntVmyfvZETvqvYc0AU20lhSYYAxcbPwGE2s2tNUQXo6fcdjeeR8bD2MXxfmLm8Evn\n4Xl0D+86UjM9KdqPoSxY6WjNh7Fv55Q8PlAXCTsqjweF6JI5hhua2ivJaYPVX72t\n2OBDJW21L5gZHvLx4kYkIu3CxsT7v0pZWKvujwDS4G2DoKvAalpijDXgypBJko1K\nZb9Akc7ms5FwKuQBW3Vmi9EGpqbFMxZoZQIpWmKq/QSUMUHZtO7CORclpH0HMMvL\nToXQqgZH+uwp6b+pPHMfP9TWGrNmUeJz7T77cKl79lC4/kyvYW27PrDUIdsUoPCA\nHWF6J2dnAgMBAAECggEARuAxhOfwHou8BJS4CX4Wkwqs1tNACLloFwhx9wl3Zgm8\nzqgSil/8f5DTpdxSnfM7Rew4enZD++XnBwkGF1eBvwMN6E1RFtsr5aoOo6HLUU0N\n9LoPEXav0issymyr8Q2PHPBLGUMjqwzb4WdnIJPm02AvzKMaVwOOHnIJdbR7V/Lb\nwileP0jGBcWKpJRSEu/SkRRBjF2Jy9YHB++wzkWR27phmSyCilei2wyUEgk3eKut\nfHbq83ShpN1qDFPujF3E78fetDRSEkb+bakzWQJ09axWslhWu8DAVgctqGfuJmpa\nJV0WvcedMbYTXRLXhRxmUILjLGS/TA3s37cRiRQ66QKBgQD/j855Laym/SlDB2v8\nAQ/lb3vQEq9rVg1FfTTj5HxPlO58FLB4shu8c+wtRX7ZbIzBG9/lDZG4rSBBflsi\nCSUVua/OAcrSsJtshebeRjY5uM2niwwWymCdNySwSQuh1wpJ416J7OHs/ycHH/W5\nMv3sd9l1PWSsm8vfAcCCCVj83wKBgQDMqiq44VYjaxhyGC4O2w+O4LBlQfJVsvMi\nC7Y6ajp8ga+VZ5IXf/tlywhfGTP9z/mHby+ujh8Hw0j1cd44zzlWEYenMo5btKKp\nqr3Y5JPKTkS2tYV76vyDJpQjt3+Wc4XQkOGgt2Xd6/PgnA365X/+oGMopUhgA7Ls\nAv/6J4JeeQKBgQDN4s8WtQNJLN9XDt2iEkD6OExpHwSP1q2uc+ZuSp8ThgpzkD9z\nnRnXQxTcjAZbp6Xl1U0VPU9OlrtLyD4nN3LXA9dsgekiwAEW9vE91RbOfeHAvrao\njbY0Mj6ufsqOQa4aRMDfISYKRqzsgoT2BOyo2w0n9KPsoz8llEXA/ULhxQKBgFPc\nrmDPRKKCsaOesNC5hmh/PQhgu1HOX73lmqfY+1olMbNAmyYx9OtDBI0jIKCx5YdP\nUfRum9xscqrQG8SfdNkFmdYy6w48uCJZqi0DjGNrKtDLFIUwRoPe/PidqhQWBhDu\nLOXUAFOs6WNxznCuNYI6aicvgraFDX2TxRvVsJ/RAoGBAKbTBAqxiLEaDAxq79gC\nYxkMSSYm3Nuu3sH1m1ll1GEEL9x8U042jY3q3x5qnHaR+3Tk6blmXrCMqY7a992b\nA+PiijaQqffw02EYHS+cqB6t7mS4vH3DHPBQSDIgHI8GtHFquKbg0RPXuQYe0eiB\nJXt5Uckn+0TJ1e4AmH0Y5+VF\n-----END PRIVATE KEY-----\n",
  "client_email": "osscadmin@myossc.iam.gserviceaccount.com",
  "client_id": "109243227624045045420",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/osscadmin%40myossc.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

static const user = '1cOY-AmL2P-jiHencrbjXK8LNiyan9dKvOn2SxdxO88c';//change
static const ossc = '123UA64kwq23qa3pSoJ7mTsAiacwyfC3qZNVqaGDfSRQ';
}
