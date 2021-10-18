$(document).ready(function () {
    $("#modal_form").on("submit", function () {
        $.ajax({
            url: window.CRM.root + "/AssetsAssign.php/" + '$assignment_id',
            method: "POST",
            data: $("product_form").serialize()
        })
    })
});


document.addEventListener("DOMContentLoaded", function () { //Wait for DOM to load

    let returnAsset = document.getElementById('return-asset'); //Selects table body

    let buttons = returnAsset.getElementsByTagName('tr'); //Select table row

    // Loop through all rows and give each row a click event listener
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].addEventListener('click', function (e) {
            if (e.target.nodeName == 'A') {
                let modalInput = document.getElementById('modal_assetID');
                modalInput.value = e.target.id.replace(/[item-]/g, '');
            }
        });        
    }

});