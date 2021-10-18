var userNameFlag = false;
var studentNumFlag = false;
var passwordFlag = false;
var emailFlag = false;
var api_keyFlag = false;

//表单完整性提示函数, 用户更改input样式, 以提示用户输入有误

$("#userName").blur(function () {
    var userName = $(this).val();
    if ($.trim(userName).length <= 0) {
        $(this).attr("class", "form-control is-invalid")
        userNameFlag = false;
    } else {
        $(this).attr("class", "form-control")
        userNameFlag = true;
    }
});
$("#studentNum").blur(function () {
    var studentNum = $(this).val();
    if ($.trim(studentNum).length <= 0) {
        $(this).attr("class", "form-control is-invalid")
        studentNumFlag = false;
    } else {
        $(this).attr("class", "form-control")
        studentNumFlag = true;
    }
});
$("#password").blur(function () {
    var password = $(this).val();
    if ($.trim(password).length <= 0) {
        $(this).attr("class", "form-control is-invalid")
        passwordFlag = false;
    } else {
        $(this).attr("class", "form-control")
        passwordFlag = true;
    }
});
$("#api_key").blur(function () {
    var api_key = $(this).val();
    if ($.trim(api_key).length <= 0) {
        $(this).attr("class", "form-control is-invalid")
        api_keyFlag = false;
    } else {
        $(this).attr("class", "form-control")
        api_keyFlag = true;
    }
})


//密码验证功能
function confirmPasswordFun() {
    var password = $("#password").val();
    var confirmPassword = $("#confirmPassword").val();
    console.log("password= " + password);
    console.log("confirmPassword= " + confirmPassword);
    if (password == confirmPassword) {
        $("#confirmPassword").attr("class", "form-control")
    } else {
        $("#confirmPassword").attr("class", "form-control is-invalid")
    }
}

//验证邮箱格式
function checkEmailFormat() {
    var email = $("#email").val();
    console.log("email= " + email);
    //正则验证邮箱
    reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/
    if (!reg.test(email)) {
        $("#email").attr("class", "form-control is-invalid");
        emailFlag = false;
    } else {
        $("#email").attr("class", "form-control");
        emailFlag = true;
    }
}

//检测表单完整性
function checkForm() {
    console.log("submitFun()")
    console.log("userNameFlag=" + userNameFlag)
    console.log("studentNumFlag=" + studentNumFlag)
    console.log("passwordFlag=" + passwordFlag)
    console.log("emailFlag=" + emailFlag)
    console.log("api_keyFlag=" + api_keyFlag)

    if (userNameFlag) {
        $("#userName").attr("class", "form-control")
    } else {
        $("#userName").attr("class", "form-control is-invalid")
    }

    if (studentNumFlag) {
        $("#studentNum").attr("class", "form-control")
    } else {
        $("#studentNum").attr("class", "form-control is-invalid")
    }

    if (passwordFlag) {
        $("#password").attr("class", "form-control")
    } else {
        $("#password").attr("class", "form-control is-invalid")
    }

    if (emailFlag) {
        $("#email").attr("class", "form-control")
    } else {
        $("#email").attr("class", "form-control is-invalid")
    }

    if (api_keyFlag) {
        $("#api_key").attr("class", "form-control")
    } else {
        $("#api_key").attr("class", "form-control is-invalid")
    }

    if (userNameFlag && studentNumFlag && passwordFlag && emailFlag && api_keyFlag) {
        return true;
    } else {
        return false;
    }
}

// 4个按钮对应4个不同的请求函数, 函数作用主要是往表单中添加元素, 用户servlet请求分流的判定

function addOrUpdateToAutoCommitSubmit() {
    if (checkForm()) {
        $("#form").append("<input name=\"addOrUpdateToAutoCommit\" value='addOrUpdateToAutoCommit' type='hidden'>");
        $("#form").submit();
    }
}

function DeleteFromAutoCommitSubmit() {
    if (checkForm()) {
        $("#form").append("<input name=\"DeleteFromAutoCommit\" value='DeleteFromAutoCommit' type='hidden'>");
        $("#form").submit();
    }
}

function CommitNowSubmit() {
    if (checkForm()) {
        // 提交后, 设置所有按钮为不可点击
        // $("#CommitNowButton").attr("class", "btn btn-block btn-success");
        // $("#CommitNowButton").html("Please Wait......");
        $("#addOrUpdateToAutoCommit").attr("disabled", true);

        // $("#CommitNowButton").attr("class", "btn btn-block btn-success");
        // $("#CommitNowButton").html("Please Wait......");
        $("#DeleteFromAutoCommit").attr("disabled", true);

        $("#CommitNowButton").attr("class", "btn btn-block btn-success");
        $("#CommitNowButton").html("Please Wait......");
        $("#CommitNowButton").attr("disabled", true);

        // $("#CommitNowButton").attr("class", "btn btn-block btn-success");
        // $("#CommitNowButton").html("Please Wait......");
        $("#ShowAutoCommitList").attr("disabled", true);

        // alert("suka");

        $("#form").append("<input name=\"CommitNow\" value='CommitNow' type='hidden'>");
        $("#form").submit();
    }
}

function ShowAutoCommitListSubmit() {
    if (checkForm()) {
        $("#form").append("<input name=\"ShowAutoCommitList\" value='ShowAutoCommitList'" +
            " type='hidden'>");
        $("#form").submit();
    }
}

// var DisclaimerShowFlag=false;
function showDisclaimer() {

    // $("#Disclaimer").html('<h>这是个测试信息</h>');
    $("#Disclaimer").html('<div class="alert alert-danger alert-dismissible">\n' +
        '                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>\n' +
        '                  <h5><i class="icon fas fa-ban"></i> Alert!</h5>\n' +
        '                  使用该脚本而可能引起的法律责任和学校追究等责任由使用者个人承担，与开发者无关，请勿滥用。为了您和他人的健康着想，请如实填写信息，在有位置变动和情况变化时手动填写申报! ' +
        '                </div>');
    // if(DisclaimerShowFlag){
    //     $("#Disclaimer").html('');
    //     DisclaimerShowFlag=false;
    // }else{
    //     $("#Disclaimer").html('<div class="alert alert-danger alert-dismissible">\n' +
    //         '                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>\n' +
    //         '                  <h5><i class="icon fas fa-ban"></i> Alert!</h5>\n' +
    //         '                  Danger alert preview. This alert is dismissable. A wonderful serenity has taken possession of my\n' +
    //         '                  entire\n' +
    //         '                  soul, like these sweet mornings of spring which I enjoy with my whole heart.\n' +
    //         '                </div>');
    //     DisclaimerShowFlag=true
    // }
}

// function submitFun(){
//     console.log("submitFun()")
//     console.log("userNameFlag="+userNameFlag)
//     console.log("studentNumFlag="+studentNumFlag)
//     console.log("passwordFlag="+passwordFlag)
//     console.log("emailFlag="+emailFlag)
//     console.log("api_keyFlag="+api_keyFlag)
//     if(userNameFlag && studentNumFlag && passwordFlag && emailFlag && api_keyFlag){
//         // console.error("WDNMD")
//         $("#form").append("<input name=\"addToAutoCommit\" value='addToAutoCommit'>");
//         $("#form").submit();
//
//     }else{
//         // console.error("userNameFlag="+userNameFlag)
//     }
// }

// $("#addToAutoCommit").click(submitFun())