<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MiTasksWAA.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(document).ready(function () {
            //var divHeight = jQuery('#div2').height();

            jQuery('#div1').css('min-height', 350 + 'px');
            jQuery('#div3').css('min-height', 350 + 'px');
            jQuery('#div2').css('min-height', 350 + 'px');
        });
       
    </script>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <style>
        @import url(https://fonts.googleapis.com/css?family=Gloria+Hallelujah);

        * {
            box-sizing: border-box;
        }

        body {
            
            background: #E8E8E8;
        }

        .dashboardcard {
            background-color: white;
            width: 100%;
            padding-left: 20px;
            padding-right: 20px;
            margin-top: 10px;
            border: 1px solid silver;
            min-height:100%;
        }

        .cardtitle {
            text-align: left;
            font-size: 25px;
            margin-top: 20px;
        }

        .barchart {
            width: 100% !important;
            height: 100% !important;
        }

        .piechart {
            width: 100% !important;
            height: 100% !important;
        }


        .stickynote {
            background-color: #fdfd96;
            width: 100%;
            max-width: 400px;
            padding-top: min(400px, 100%);
            margin: 10px 10px 10px 0px;
            display: inline-block;
        }


        .stickynotewrapper {
            text-align: center;
           
        }

        .photo {
            border-radius:80px;
            width: 80px;
            height: 80px;
        }


      
            




        @media (max-width: 767px) {
            .hidemobile {
                display: none;
            }
        }


    </style>




    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12">
        <div class="row dashboardcard" id="div1">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 cardtitle" runat="server">
                Greetings<hr />
            </div>
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12" runat="server">
                <img class="photo" src="https://media-exp1.licdn.com/dms/image/C4D03AQH0kp3nHIrpQQ/profile-displayphoto-shrink_200_200/0/1643662138632?e=1652313600&v=beta&t=XVsxH34OQSrKFbFcqQrILpZvzebQ89uLXn29NUcuy1M" />
                <h3>Welcome Back Matthew, to UofL Health Portal!</h3>
                <br />
            </div>
        </div>
    </div>

    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12">
        <div class="row dashboardcard" id="div2">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 cardtitle" runat="server">
                Weather<hr />
            </div>
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12" runat="server">
                <a class="weatherwidget-io" href="https://forecast7.com/en/38d25n85d76/louisville/?unit=us" data-label_1="LOUISVILLE" data-label_2="WEATHER" data-theme="original">LOUISVILLE WEATHER</a>
                <script>
                    !function (d, s, id) { var js, fjs = d.getElementsByTagName(s)[0]; if (!d.getElementById(id)) { js = d.createElement(s); js.id = id; js.src = 'https://weatherwidget.io/js/widget.min.js'; fjs.parentNode.insertBefore(js, fjs); } }(document, 'script', 'weatherwidget-io-js');
                </script>
                <br />
            </div>
        </div>
    </div>

    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12">
        <div class="row dashboardcard" id="div3">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 cardtitle" runat="server">
                Upcoming Events<hr />
            </div>
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12" runat="server">
                <h3>Urban Bourbon - April 1, 2022</h3>
                <h3>Marathon - April 16, 2022</h3>
                <br />
            </div>
        </div>
    </div>



                

<%--                        
        <div class="col-xl-3 col-lg-3 col-md-3 col-sm-12">
            <div class="row dashboardcard" id="div2">
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 cardtitle" runat="server">
                    Statuses<hr />
                </div>
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12" runat="server">
         
               <canvas id="countdown" class="piechart"></canvas>
             
                </div>
            </div>
        </div>

            <div class="col-xl-5 col-lg-5 col-md-5 col-sm-12 hidemobile">
            <div class="row dashboardcard" id="div3">
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 cardtitle" runat="server">
                    Task Categories<hr />
                </div>
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12" runat="server">
                    <canvas id="myChart" class="barchart"></canvas>

                </div>
            </div>
        </div>--%>
                
      




<%--    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <div class="row dashboardcard">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 cardtitle" runat="server">
                Tasks<hr />
            </div>
            <div class="col-xl-1 col-lg-2 col-md-3 col-sm-4 col-xs-12 stickynotewrapper">
                <div class="stickynote">
                    <h1>Find more volunteers</h1>
                </div>
            </div>
                        <div class="col-xl-1 col-lg-2 col-md-3 col-sm-4 col-xs-12 stickynotewrapper">
                <div class="stickynote">
                    Click here to sign up for updates!
                </div>
            </div>
                        <div class="col-xl-1 col-lg-2 col-md-3 col-sm-4 col-xs-12 stickynotewrapper">
                <div class="stickynote">
                    Click here to sign up for updates!
                </div>
            </div>
                        <div class="col-xl-1 col-lg-2 col-md-3 col-sm-4 col-xs-12 stickynotewrapper">
                <div class="stickynote">
                    Click here to sign up for updates!
                </div>
            </div>
                        <div class="col-xl-1 col-lg-2 col-md-3 col-sm-4 col-xs-12 stickynotewrapper">
                <div class="stickynote">
                    Click here to sign up for updates!
                </div>
            </div>
                        <div class="col-xl-1 col-lg-2 col-md-3 col-sm-4 col-xs-12 stickynotewrapper">
                <div class="stickynote">
                    Click here to sign up for updates!
                </div>
            </div>
        </div>
    </div>--%>
 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <script>
        const ctx = document.getElementById('myChart').getContext('2d');
        const myChart = new Chart(ctx, {
            type: 'horizontalBar',
            data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19, 3, 5, 2, 3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ]
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    },
                            xAxes: [{
                        gridLines: {
                            color: "rgba(0, 0, 0, 0)",
                        }
                    }],
                    yAxes: [{
                        gridLines: {
                            color: "rgba(0, 0, 0, 0)",
                        }
                    }]
                }
            }
        });




       

        var ctx1 = document.getElementById("countdown").getContext('2d');
        var myChart1 = new Chart(ctx1, {
            type: 'doughnut',
            data: {
                labels: ["Green", "Blue", "Orange"],
                datasets: [{
                    backgroundColor: [
                        "rgba(75, 192, 192, 1)",
                        "rgba(54, 162, 235, 1)",
                        "rgba(255, 159, 64, 1)"
                    ],
                    data: [12, 19, 3]
                }]
            }
        });

    </script>

</asp:Content>
