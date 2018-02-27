$(function(){ 
	
	//管理员对话框
	$('#admin-edit-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var id = $tr.attr('data-a-id');
        var userName= $tr.attr('data-a-name');
        var password = $tr.attr('data-a-password');
        var age = $tr.attr('data-a-age');
        $(':input[name="id"]','#admin-edit-modal-form').val(id);
        $(':input[name="userName"]','#admin-edit-modal-form').val(userName);
        $(':input[name="password"]','#admin-edit-modal-form').val(password);
        $(':input[name="age"]','#admin-edit-modal-form').val(age);
	});
	
	
	//学生编辑对话框
    $('#student-edit-modal-form').on('show.bs.modal',function(event){
        var source = event.relatedTarget;
        var $tr = $(source).closest('tr');
        var id = $tr.attr('data-s-id');
        var name = $tr.attr('data-s-name');
        var password = $tr.attr('data-s-password');
        var sex = $tr.attr('data-s-sex');
        var hobby = $tr.attr('data-s-hobby');
        $(':input[name="s_id"]','#student-edit-modal-form').val(id);
        $(':input[name="s_name"]','#student-edit-modal-form').val(name);
        $(':input[name="password"]','#student-edit-modal-form').val(password);
        $(':radio[name="sex"]','#student-edit-modal-form').val([sex]);
        /*if(hobby.indexOf(",") == 0){
        	  $(':checkbox[name="hobby"]','#student-edit-modal-form').val([hobby]);
        }
        else{
        	var hobbys = [];
        	hobbys = hobby.split(',');
            $(':checkbox[name="hobby"]','#student-edit-modal-form').val(hobbys);
        	 for(var i = 0;i < hobbys.length;i++){
        	        $("input[name='hobby']").each(function(){
    	            	// $(':checkbox[name="hobbyo"][value="' + hobbys[i] + '"]','#student-edit-modal-form').prop('checked', true);
    	            	// $(':checkbox[name="hobby"][value!="' + hobbys[i] + '"]','#student-edit-modal-form').prop('checked', false);
       	            if ($(this).val() == hobbys[i]) {
        	            	$(':checkbox[name="hobby"][value!="' + hobbys[i] + '"]','#student-edit-modal-form').prop("checked", true);
       	            }
        	        });  
        	}  
        }*/
    });
    
    //教师编辑对话框
    $('#teacher-edit-modal-form').on('show.bs.modal',function(event){
    	var source = event.relatedTarget;
    	var $tr = $(source).closest('tr');
    	var id = $tr.attr('data-t-id');
        var name = $tr.attr('data-t-name');
        var password = $tr.attr('data-t-password');
         $(':input[name="t_id"]','#teacher-edit-modal-form').val(id);
         $(':input[name="t_name"]','#teacher-edit-modal-form').val(name);
         $(':input[name="password"]','#teacher-edit-modal-form').val(password);
    });
    
    //课程编辑对话框
    $('#course-edit-modal-form').on('show.bs.modal',function(event){
    	var source = event.relatedTarget;
    	var $tr = $(source).closest('tr');
    	var c_id = $tr.attr('data-c-id');
        var c_name = $tr.attr('data-c-name');
        var credit = $tr.attr('data-c-credit');
         $(':input[name="c_id"]','#course-edit-modal-form').val(c_id);
         $(':input[name="c_name"]','#course-edit-modal-form').val(c_name);
         $(':input[name="credit"]','#course-edit-modal-form').val(credit);
    });
    
});

