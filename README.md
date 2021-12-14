# legacymail
Docker container for handling SSL for older email clients

## Variables
You only need to define either POP3 or IMAP variables, depending on what you are using.

|Variable name|Purpose|Default|
|-------------|-------|-------|
|IMAP_DST_HOST|Hostname of remote IMAP server (i.e. imap.gmail.com)|N/A|
|IMAP_DST_PORT|Port that the remote IMAP server uses|993|
|POP3_DST_HOST|Hostname of remote POP3 server (i.e. pop.gmail.com)|N/A|
|POP3_DST_PORT|Port that the remote IMAP server uses|995|
|SMTP_DST_HOST|Hostname of remote SMTP server (i.e. smtp.gmail.com)|N/A|
|SMTP_DST_PORT|Port that the remote IMAP server uses|465|
