import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


class MailEngine:
    def __init__(self):
        self.__sender = ""
        self.__password = "pjcrbldsqrjzeuzz"
        self.__port = 465
        self.__subject = "This is a test email"
        self.__message = "This is a sample message"

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
    
    #send a simple plain text email to the recipient
    def send(self, recipient):
                
        message = MIMEMultipart("alternative")
        message["Subject"] = self.__subject
        message["From"] = self.__sender
        message["To"] = recipient

        textMail = MIMEText(self.__message, "plain")
        message.attach(textMail)

        # Create secure connection with server and send email
        connection = ssl.create_default_context()
        with smtplib.SMTP_SSL("smtp.gmail.com", self.__port, context=connection) as server:
            server.login(self.__sender, self.__password)
            server.sendmail(
                self.__sender, recipient, message.as_string()
            )
