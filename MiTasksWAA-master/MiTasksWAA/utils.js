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