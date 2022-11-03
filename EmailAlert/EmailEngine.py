import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email import encoders

"""
    This class sends mails programmically. This requires
    generation of application password from gmail account security
    for remote login to mail servers.
"""
class MailEngine:
    def __init__(self, filename):
        self.__sender = ""
        self.__password = "pjcrbldsqrjzeuzz"
        self.__port = 465
        self.__subject = "This is a test email"
        self.__message = "This is a sample message"
        self.__attachement = None

        file = open(filename, "r")
        data = file.read().splitlines()
        self.__password = data[1] 
        self.__sender = data[0] 
        file.close()

    #Setup credentials for the account from which
    # mail has to be sent
    def setupCredentials(self, email, password):
        self.__sender = email
        self.__password = password

    #Configure SMTP port number
    def configurePort(self, port):
        self.__port = port
    
    #Set subject of the mail
    def setSubject(self, subject):
        self.__subject = subject
    
    #Set message to send
    def setMessage(self, message):
        self.__message = message

    def setAttachement(self, filename):
        self.__attachement = filename
    
    #send a simple plain text email to the recepient
    def send(self, receipent):
                
        message = MIMEMultipart("alternative")
        message["Subject"] = self.__subject
        message["From"] = self.__sender
        message["To"] = receipent

        textMail = MIMEText(self.__message, "plain")

        if self.__attachement != None:
            with open(self.__attachement, "rb") as attachment:
                part = MIMEBase("application", "octet-stream")
                part.set_payload(attachment.read())

            encoders.encode_base64(part)

            part.add_header(
                "Content-Disposition",
                f"attachment; filename= {self.__attachement}",
            )

            message.attach(part)

        message.attach(textMail)

        # Create secure connection with server and send email
        connection = ssl.create_default_context()
        with smtplib.SMTP_SSL("smtp.gmail.com", self.__port, context=connection) as server:
            server.login(self.__sender, self.__password)
            server.sendmail(
                self.__sender, receipent, message.as_string()
            )
