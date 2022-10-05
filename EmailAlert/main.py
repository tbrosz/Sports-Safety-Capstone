from EmailEngine import MailEngine

def main():
    mailer = MailEngine()
    mailer.setupCredentials("nawarajrai557@gmail.com", "unmpgzrzrsynlfex")
    mailer.setSubject("This is demo")
    mailer.setMessage("This is a test email generated from a python program!")
    mailer.send("raidraid972020@gmail.com")
    print("Email send successfully!")

main()
