class ram_environment;
virtual ram drv_vif;
virtual ram mon_vif;
mailbox #(ram_trans)mbx_gd;
mailbox #(ram_trans)mbx_dr_sb;
mailbox #(ram_trans)m_sb;
ram_generator gen;
ram_driver drv;
ram_monitor mon;
ram_scoreborad scb;
function new(virtual ram drv_vif,virtual ram mon_vif);
this.drv_vif=drv_vif;
this.mon_vif=mon_vif;
endfunction
task build();
mbx_gd=new();
mbx_dr_sb=new();
m_sb=new();
gen=new(mbx_gd);
drv=new(mbx_gd,mbx_dr_sb,drv_vif);
mon=new(mon_vif,m_sb);
scb=new(m_sb,mbx_dr_sb);
endtask
task start();
fork
gen.start();
drv.start();
mon.start();
scb.start();
join
endtask
endclass

