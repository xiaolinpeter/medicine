$(function(){
	$('#edit-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var id = $tr.attr('data-id');
		var username = $tr.attr('data-username');
		var password = $tr.attr('data-password');
		var nickname= $tr.attr('data-nickname');
		var status = $tr.attr('data-status');
		var roleId = JSON.parse($tr.attr('data-roleIdList'));
		$(':input[name="id"]','#edit-modal-form').val(id);
		$(':input[name="username"]','#edit-modal-form').val(username);
		$(':input[name="nickname"]','#edit-modal-form').val(nickname);
		$(':radio[name="status"]','#edit-modal-form').val([status]);
		$(':input[name="password"]','#edit-modal-form').val(password);
		var data=[{name:"a",age:12},{name:"b",age:11},{name:"c",age:13},{name:"d",age:14}];  
		for(var i=0; i<data.length; i++){
		    console.log("text:"+data[i].name+" value:"+data[i].age );  
		}  
		 var roleIdArray= [];
		for(var i=0; i<roleId.length; i++){
		     roleIdArray.push(roleId[i].id); 
		}  
        $(':checkbox[name="roleId"]','#edit-modal-form').val(roleIdArray);
        
      
	});
	
	
	$('#search-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var id = $tr.attr('data-id');
		var username = $tr.attr('data-username');
		var password = $tr.attr('data-password');
		var nickname= $tr.attr('data-nickname');
		var status = $tr.attr('data-status');
		var roleName = $tr.attr('data-roleName');
		$(':input[name="id"]','#edit-modal-form').val(id);
		$(':input[name="username"]','#edit-modal-form').val(username);
		$(':input[name="nickname"]','#edit-modal-form').val(nickname);
		$(':radio[name="status"]','#edit-modal-form').val([status]);
		$(':input[name="password"]','#edit-modal-form').val(password);
        var roleNames = [];
        roleNames = roleName.split(',');
        $(':checkbox[name="roleName"]','#edit-modal-form').val(roleName);
	});
	
});