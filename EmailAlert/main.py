from EmailEngine import MailEngine

credentials = "credentials.txt"

def main():
    mailer = MailEngine(credentials)
    mailer.setSubject("This is demo")
    mailer.setMessage("This is a test email generated from a python program!")
    mailer.setAttachement("demo.pdf")
    mailer.send("raidraid972020@gmail.com")
    print("Email send successfully!")

main()
