class ram_test;
virtual ram drv_vif;
virtual ram mon_vif;
ram_environment env;
function new(virtual ram drv_vif,virtual ram mon_vif);
this.drv_vif=drv_vif;
this.mon_vif=mon_vif;
endfunction
task run();
env=new(drv_vif,mon_vif);
env.build;
env.start;
endtask;
endclass
class test1 extends ram_test;
ram_trans1 trans;
function new(virtual ram drv_vif,virtual ram mon_vif);
super.new(drv_vif,mon_vif);
endfunction
task run();
$display("write only\n");
env=new(drv_vif,mon_vif);
env.build;
begin
trans=new;
env.gen.t1=trans;
end
env.start;
endtask
endclass
class test2 extends ram_test;
ram_trans2 trans;
function new(virtual ram drv_vif,virtual ram mon_vif);
super.new(drv_vif,mon_vif);
endfunction
task run();
$display("read only\n");
env=new(drv_vif,mon_vif);
env.build;
begin
trans=new;
env.gen.t1=trans;
end
env.start;
endtask
endclass
class test3 extends ram_test;
ram_trans3 trans;
function new(virtual ram drv_vif,virtual ram mon_vif);
super.new(drv_vif,mon_vif);
endfunction
task run();
$display("write and read is zero\n");
env=new(drv_vif,mon_vif);
env.build;
begin
trans=new;
env.gen.t1=trans;
end
env.start;
endtask
endclass
class test4 extends ram_test;
ram_trans4 trans;
function new(virtual ram drv_vif,virtual ram mon_vif);
super.new(drv_vif,mon_vif);
endfunction
task run();
$display("both write and read\n");
env=new(drv_vif,mon_vif);
env.build;
begin
trans=new;
env.gen.t1=trans;
end
env.start;
endtask
endclass
class test_regression extends ram_test;
ram_trans trans0;
ram_trans1 trans1;
ram_trans2 trans2;
ram_trans3 trans3;
ram_trans4 trans4;
function new(virtual ram drv_vif,virtual ram mon_vif);
super.new(drv_vif,mon_vif);
endfunction
task run();
$display("REGRESSION \n");
env=new(drv_vif,mon_vif);
env.build;
begin
trans0=new;
env.gen.t1=trans0;
end
env.start;
begin
trans1=new;
env.gen.t1=trans1;
end
env.start;
begin
trans2=new;
env.gen.t1=trans2;
end
env.start;
begin
trans3=new;
env.gen.t1=trans3;
end
env.start;
begin
trans4=new;
env.gen.t1=trans4;
end
env.start;
endtask
endclass
