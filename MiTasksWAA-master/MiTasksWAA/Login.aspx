<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MiTasksWAA.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background: whitesmoke;
            margin: 0 auto 0 auto;
            width: 100%;
            text-align: center;
            margin: 20px 0px 20px 0px;
        }

        p {
            font-size: 12px;
            text-decoration: none;
            color: #ffffff;
        }

        h1 {
            font-size: 1.5em;
            color: #525252;
        }

        .box {
            background: white;
            width: 300px;
            border-radius: 6px;
            margin: 0 auto 0 auto;
            padding: 0px 0px 70px 0px;
        }

        .email {
            background: #ecf0f1;
            border: #ccc 1px solid;
            border-bottom: #ccc 2px solid;
            padding: 8px;
            width: 250px;
            color: #AAAAAA;
            margin-top: 10px;
            font-size: 1em;
            border-radius: 4px;
        }

        .password {
            border-radius: 4px;
            background: #ecf0f1;
            border: #ccc 1px solid;
            padding: 8px;
            width: 250px;
            font-size: 1em;
        }

        .btn {
            background: orange;
            width: 250px;
            padding-top: 5px;
            padding-bottom: 5px;
            color: black;
            border-radius: 4px;
            margin-top: 20px;
            margin-bottom: 20px;
            float: left;
            margin-left: 25px;
            font-weight: 800;
            font-size: 0.8em;
        }


        #btn2 {
            float: left;
            background: #FFD580;
            width: 125px;
            padding-top: 5px;
            padding-bottom: 5px;
            color: black;
            border-radius: 4px;
            margin-top: 20px;
            margin-bottom: 20px;
            margin-left: 10px;
            font-weight: 800;
            font-size: 0.8em;
        }

        .logo {
            height: 50px;
        }

    </style>
    <script>
        $(document).ready(function () {
            jQuery('.navbar').hide();
            jQuery('.menu_btn').hide();
		});

        function populateform(data_results) {
            var data = JSON.stringify(data_results);
            var mydata = jQuery.parseJSON(data);
            jQuery.each(mydata, function (key, value) {
                if ((key.substring(0, 2) == "rb") || (key.substring(0, 3) == "chk")) {
                    if (value == "1") { jQuery("#" + key).get(0).checked = true; }
                    if (value == "0") { jQuery("#" + key).get(0).checked = false; }
                }
                else if (key.substring(0, 6) == "alert_") {
                    var type = key.replace("alert_", "");
                    var message = value;
                    fncAlert(message, type);
                }
                else if (key.substring(0, 3) == "td_") {
                    var id = key;
                    jQuery("#" + id).html(value);
                }
                else if (key.substring(0, 9) == "linktext_") {
                    var id = key.replace("linktext_", "");
                    jQuery("#" + id).text(value);
                }
                else if (key.substring(0, 9) == "linkhref_") {
                    var id = key.replace("linkhref_", "");
                    jQuery("#" + id).attr("href", value);
                }
                else if (key.substring(0, 9) == "onchange_") {
                    var id = key.replace("onchange_", "");
                    jQuery("#" + id).attr("onchange", value);
                }
                else if (key.substring(0, 4) == "src_") {
                    var id = key.replace("src_", "");
                    jQuery("#" + id).attr("src", value);
                }
                else if (key.substring(0, 6) == "select") {
                    var id = key.replace("select", "");
                    jQuery("#" + id).empty();
                    jQuery("#" + id).prepend(value);
                }
                else if (key.substring(0, 7) == "listbox") {
                    var id = key.replace("listbox", "");
                    jQuery("#" + id).empty();
                    jQuery("#" + id).prepend(value);
                }
                else if (key.substring(0, 9) == "lbselect_") {
                    var id = key.replace("lbselect_", "");
                    jQuery('#' + id).val('');
                    var valueArr = value.split(',');
                    for (var i = 0; i <= valueArr.length; i++) {
                        $("#" + id + " option[value='" + valueArr[i] + "']").prop("selected", true);
                    }
                }
                else if (key.substring(0, 7) == "append_") {
                    var id = key.replace("append_", "");
                    jQuery("#" + id).append(value);
                }
                else if (key.substring(0, 4) == "img_") {
                    var id = key.replace("img_", "");
                    $("#" + id).attr('src', value);
                }
                else if (key.substring(0, 6) == "after_") {
                    var id = key.replace("after_", "");
                    $("#" + id).after(value);
                }
                else if (key.substring(0, 7) == "remove_") {
                    var id = key.replace("remove_", "");
                    $("#" + id).remove();
                }
                else if (key.substring(0, 8) == "visible_") {
                    var id = key.replace("visible_", "");
                    if (value == "show") {
                        jQuery("#" + id).attr("display", "block");
                        jQuery("#" + id).show();
                    }
                    if (value == "inline") {
                        jQuery("#" + id).attr("display", "inline");
                        jQuery("#" + id).show();
                    }
                    if (value == "hide") {
                        jQuery("#" + id).attr("display", "none");
                        jQuery("#" + id).hide();
                    }
                }
                else if (key.substring(0, 7) == "toggle_") {
                    var id = key.replace("toggle_", "");
                    if (value == "enabled") {
                        $("#" + id).prop("disabled", false);
                    }
                    if (value == "disabled") {
                        $("#" + id).prop("disabled", true);
                    }
                }
                else if (key.substring(0, 6) == "popup_") {
                    var id = key.replace("popup_", "");
                    try {
                        jQuery('#' + id).foundation('reveal', value);
                    }
                    catch (err) {
                        $('#' + id).foundation(value);
                    }
                    finally {
                    }
                }
                else if (key.substring(0, 10) == "removecss_") {
                    var id = key.replace("removecss_", "");
                    jQuery("#" + id).removeClass(value);
                }
                else if (key.substring(0, 7) == "addcss_") {
                    var id = key.replace("addcss_", "");
                    jQuery("#" + id).addClass(value);
                }
                else if (key.substring(0, 11) == "removeattr_") {
                    var id = key.replace("removeattr_", "");
                    jQuery("#" + id).removeAttr(value);
                }
                else if (key.substring(0, 7) == "before_") {
                    var id = key.replace("before_", "");
                    jQuery("#" + id).before(value);
                }
                else if (key == "DynamicProps") {
                    var data1 = JSON.stringify(value);
                    var mydata1 = jQuery.parseJSON(data1);
                    populateform(mydata1);
                }
                else if (key.indexOf("visiblemultiple_a_") == 0) {
                    var id = key.replace("visiblemultiple_a_", "");
                    if (value == "show") {
                        jQuery("a[id^='" + id + "']").show();
                    }
                    if (value == "hide") {
                        jQuery("a[id^='" + id + "']").hide();
                    }
                }
                else if (key.indexOf("visiblemultiple_input_") == 0) {
                    var id = key.replace("visiblemultiple_input_", "");
                    if (value == "show") {
                        jQuery("input[id^='" + id + "']").show();
                    }
                    if (value == "hide") {
                        jQuery("input[id^='" + id + "']").hide();
                    }
                }
                else {
                    if (document.getElementById(key) != null) {
                        var tagname = document.getElementById(key).tagName;
                        if (tagname == "div" || tagname == "span" || tagname == "DIV" || tagname == "SPAN") {
                            jQuery("#" + key).html(value);
                        }
                        else {
                            jQuery("[id='" + key + "']").val(value);
                        }
                    }
                }
            });

        }

        function objectifyForm(formArray) {
            //serialize data function
            var returnArray = {};
            for (var i = 0; i < formArray.length; i++) {
                returnArray[formArray[i]['name']] = formArray[i]['value'];
            }
            return returnArray;
        }

        function signIn() {
            var arForm = jQuery("#frmcms").serializeArray();
            jQuery.ajax({
                type: "POST",
                url: "/Login.aspx/wmLogin",
                data: JSON.stringify({ formVars: arForm }),
                contentType: "application/json",
                dataType: "json",
                success: function (msg) {
                    populateform(msg.d);
                    if (msg.d.verified == "true") {
                        window.location.replace("/Dashboard.aspx");
                    }
                }
            });
        }


    </script>

    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" runat="server">
                <link href='https://fonts.googleapis.com/css?family=Open+Sans:700,600' rel='stylesheet' type='text/css'>


                <div class="box">
                    <br />
                    <img class="logo" src="	https://uoflhealth.org/wp-content/uploads/2021/10/logo.png" />
                    <br />

                    <input type="email" name="txtusername" id="txtusername" class="email" />

                    <input type="password" name="txtpassword" id="txtpassword" class="email" />

                    <a href="javascript:signIn();">
                        <div class="btn">Sign In</div>
                    </a>


                </div>
            

                <%--<p>Forgot your password? <u style="color: #f1c40f;">Click Here!</u></p>--%>

                <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js" type="text/javascript"></script>
            </div>
        </div>
    </div>


</asp:Content>
