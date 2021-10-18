// var loadData = function (e){
//
// }

// var userList=[];
//
// $.ajax({
//     url: "userServlet",
//     data: {
//         "method": "showUserList",
//         "username": $("#user_name").val(),
//         "studentNum": $("#student_number").val(),
//         "password": $("#password").val(),
//         "email": $("#email").val(),
//         "api_key": $("#api_key").val()
//         // "username": "111",
//         // "studentNum": "111",
//         // "password": "222",
//         // "email": "333@qq.com",
//         // "api_key": "WDNMD"
//     },
//     type: "post",
//     dataType: "json",
//     async: false,
//     success: function (data) {
//         // alert("数据请求成功");
//         console.log(data);
//         // userList=$.parseJSON(data)
//         // var userList=[];
//         for(var i=0;i<2;++i){
//             // userList.
//             userList[i]=data[i];
//         }
//         // userList=data;
//
//
//
//         console.log(userList[0]);
//         console.log(userList[1]);
//     },
//     error: function (data) {
//         alert("数据请求失败");
//         console.log(data)
//     }
// });
// 95336779Aa
//
// $(function () {
//     $("#jsGrid1").jsGrid({
//         height: "100%",
//         width: "100%",
//
//         // sorting: true,
//         // paging: true,
//         autoload: true,
//         controller: {
//             loadData: function (){
//                 return $.ajax({
//                     url: "userServlet",
//                     data: {
//                         "method": "showUserList",
//                         "username": $("#user_name").val(),
//                         "studentNum": $("#student_number").val(),
//                         "password": $("#password").val(),
//                         "email": $("#email").val(),
//                         "api_key": $("#api_key").val()
//                         // "username": "111",
//                         // "studentNum": "111",
//                         // "password": "222",
//                         // "email": "333@qq.com",
//                         // "api_key": "WDNMD"
//                     },
//                     type: "post",
//                     dataType: "json",
//                     // async: false
//                 });
//             },
//             insertItem: $.noop,
//             updateItem: $.noop,
//             deleteItem: $.noop
//         },
//         // data: db.clients,
//
//
//         fields: [
//             {name: "student_number", type: "text", width: 150},
//             {name: "password", type: "text", width: 150},
//             {name: "email", type: "text", width: 150},
//             {name: "api_key", type: "text", width: 150},
//         ]
//
//     });
// });