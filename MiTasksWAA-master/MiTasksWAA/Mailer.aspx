<%@ Page Title="Report Mailer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mailer.aspx.cs" Inherits="MiTasksWAA.Mailer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="mailForm">
    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSubmit">
    <h3><u>Emergency Plan Mailer</u></h3>
    <div class="form-group" runat="server">
        <asp:Label Text="Recipient's Email Address" runat="server"></asp:Label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
            ControlToValidate="YourEmail" ValidationGroup="save" /><br />
        <asp:TextBox ID="YourEmail" runat="server" class="form-control mailFormControlWidth"/>
    </div>
    <div class="form-group" runat="server">
        <asp:Label Text="Subject" runat="server"></asp:Label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
            ControlToValidate="YourSubject" ValidationGroup="save" /><br />
        <asp:TextBox ID="YourSubject" runat="server" class="form-control mailFormControlWidth"/>
    </div>
    <div class="form-group" runat="server">
        <asp:Label Text="School Name" runat="server"></asp:Label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
            ControlToValidate="SchoolName" ValidationGroup="save" /><br />
        <asp:TextBox ID="SchoolName" runat="server" class="form-control mailFormControlWidth"/>
    </div>
    <div class="form-group" runat="server">
        <asp:Label Text="Attach Emergency Action Plan" runat="server"></asp:Label>
        <asp:FileUpload ID="fileUploader" runat="server" AllowMultiple="true" CssClass="form-control mailFormControlWidth"/>
    </div>
    <div class="form-group" runat="server">
        <asp:Label Text="Mail Message" runat="server"></asp:Label>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
            ControlToValidate="Comments" ValidationGroup="save" /><br />
        <asp:TextBox ID="Comments" runat="server" TextMode="MultiLine" Rows="10" class="form-control mailFormControlWidth"/>
     </div>
  



    <div class="form-group" runat="server">
        <asp:Button ID="btnSubmit" runat="server" Text="Send" OnClick="Button1_Click" ValidationGroup="save" class="btn btn-primary"/>
    </div>
</asp:Panel>
<p>
    <asp:Label ID="DisplayMessage" runat="server" Visible="false" />
</p> 
</div>
</asp:Content>