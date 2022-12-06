using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MiTasksWAA
{
    public partial class Mailer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                //here on button click what will done 
                SendMail();
                DisplayMessage.Text = "Emergency Action Plan Sent Successfully!";
                DisplayMessage.Visible = true;
                YourSubject.Text = "";
                YourEmail.Text = "";
                Comments.Text = "";
            }
            catch (Exception ex) 
            {
                System.Diagnostics.Debug.WriteLine(ex.Message + "\n" + ex.ToString() + "\n" + ex.StackTrace);
                DisplayMessage.Text = ex.Message;
            }
        }

        protected void SendMail()
        {

            // Gmail Address from where you send the mail
            //var fromAddress = "nawarajrai557@gmail.com";

            var senderMail = "nawarajrai557@gmail.com";

            //Password of your gmail address
            //const string fromPassword = "yifrwzulavoeuruf\r\n";
            var Pass = "pctgmtxpvszaismi\r\n";

            // any address where the email will be sending
            var toAddress = YourEmail.Text.ToString().Trim().Split(';');

            foreach(String address in toAddress)
            {
                // Passing the values and make a email formate to display
                string subject = YourSubject.Text.ToString();
                string body = "";
                body += Comments.Text + "";

                MailMessage message = new MailMessage(senderMail, address, subject, body);
                if (fileUploader.HasFiles)
                {
                    foreach (HttpPostedFile uploadedFile in fileUploader.PostedFiles)
                    {
                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        message.Attachments.Add(new Attachment(uploadedFile.InputStream, fileName));
                    }

                }

                // smtp settings
                var smtp = new System.Net.Mail.SmtpClient();
                {
                    if(senderMail.Contains("outlook"))
                    {
                        smtp.Host = "smtp-mail.outlook.com";
                    }
                    else
                    {
                        smtp.Host = "smtp.gmail.com";
                    }
                    smtp.Port = 587;
                    smtp.EnableSsl = true;
                    smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                    smtp.Credentials = new NetworkCredential(senderMail, Pass);
                    smtp.Timeout = 20000;
                }
                // Passing values to smtp object
                smtp.Send(message);
            }

        }
    }
}