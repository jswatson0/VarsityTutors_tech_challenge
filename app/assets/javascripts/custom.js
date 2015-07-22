$( document ).ready(function() {
    var products = [];

    $("#checkout-btn").click(function(event) {
        $("input:checkbox").each(function () {
            if(this.checked){
                products.push(this.name)
            }
        });

        //$.ajax({
        //    url : "/orders/new",
        //    type : "post",
        //    data : { data_value: JSON.stringify(products) }
        //});

    })


});