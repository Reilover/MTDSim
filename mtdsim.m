clc;clear all;close all;
format bank
global nodenum
global nodeos
global nodeippool
global nodevulnum
global vullevel
global edge
global Gsr
global attview
global defview
global attiniip
global attendip
global attgoal
global crafttime
global attweaponresult
global ipbase
global usrview
global filesizeleave
global usrchange
global usrhold
global usrcost
global nodes
global nodeservice
global maxhostchangedowntime
nodenum=1;
nodeippool=20;
nodeos=['L','W','U'];
nodeservice=['F','H','M'];
nodevulnum=3;
vullevel=['C','S','V'];
crafttime=[10,30,50];%������������ʱ�䣬����©����в�̶ȷ�Ϊ10,30,50���߼�ʱ��T
%Gsr=[node;edge];
attview = [];
defview = [];
attgoal=[];
ipchangfrequency=10;
hostchangfrequency=50;
maxhostchangedowntime=5;
attphase=7;%�����׶η�Ϊ7������顢�����������䡢©�����ÿ�������װ��C2C��AoO
Maxsimtime=100;

Simatttimes=zeros(attphase+1,Maxsimtime);
Simusrchange=zeros(1,Maxsimtime);
Simusrhold=zeros(1,Maxsimtime);
Simusrcost=zeros(1,Maxsimtime);
Simattwinstate=cell(1,Maxsimtime);
Maxipfrequency=300;
Attipreconn=zeros(1,Maxipfrequency);
% for ipfsimtimes=1:Maxipfrequency
%     ipchangfrequency=ipfsimtimes;
Simtime=Maxsimtime;
filesize=2048;%�����ļ���С
    while Simtime>0
        T=1;
        nodes=nodeini('sample');
        usrview = nodes;
        defview=Gsr;
        attiniip=0;
        attendip=255;
        attview.ip=attiniip;
        filesizeleave=filesize;
        wholewin=false;
        atttimes=zeros(1,attphase+1);
        attstarttimes=zeros(1,attphase);
        attweaponresult=-1;
        usrchange=0;
        usrhold=0;
        usrcost=0;
        attwinstate=zeros(1,attphase);
        attwinstate(1,1)=false;
        usrfileend=false;
        sumattwinstate=[];
        while wholewin ~= true
            
%             if mod(T,ipchangfrequency)==0
            if mod(T,ipchangfrequency)==0
                nodes=defmove('ip');%�����߶���
                % usrview = nodes;
            end
            if mod(T,hostchangfrequency)==0
                
                nodes=defmove('host-random');
                
            end
            sysmove('hostchangeup',T);
            if filesizeleave<=0
                usrfileend=true;
            else
                filesizeleave = usrmove('ftp',filesizeleave,1);%ϵͳ�û�����
            end
            
            if ~attwinstate(1,1)
                attreconnresult = attmove('reconn');%��������鶯��
                
                if attreconnresult
                    attwinstate(1,1)=true;
                    atttimes(1,1)=atttimes(1,1)+1;
                    
                else
                    atttimes(1,1)=atttimes(1,1)+1;
                end
                
            end
            if attwinstate(1,1) && ~attwinstate(1,2)
                attweaponresult = attmove('weapon',attweaponresult);%�����߹�����������
                if attweaponresult==0
                    attwinstate(1,2)=true;
                    atttimes(1,2)= atttimes(1,2);
                else
                    atttimes(1,2)= atttimes(1,2)+1;
                end
                
            end
            
            if attwinstate(1,1) && attwinstate(1,2) && ~attwinstate(1,3)
                attdeliveryresult = attmove('delivery',0,1);%�����߷��͹�������
                if attdeliveryresult
                    attwinstate(1,3)=true;
                    atttimes(1,3)=atttimes(1,3)+1;
                    
                else
                    attwinstate(1,1)=false;
                    
                    %attweaponresult=-1;
                    atttimes(1,3)=atttimes(1,3)+1;
                end
            end
            
            if attwinstate(1,1) && attwinstate(1,2) && attwinstate(1,3) && ~attwinstate(1,4)
                attexploitresult = attmove('exploit',0,1);%�����߿�������ϵͳ©��
                if attexploitresult
                    attwinstate(1,4)=true;
                    atttimes(1,4)=atttimes(1,4)+1;
                else
                    attwinstate(1,1)=false;
                    attwinstate(1,2)=false;
                    attweaponresult=-1;
                    attwinstate(1,3)=false;
                    atttimes(1,4)=atttimes(1,4)+1;
                end
            end
            
            if attwinstate(1,1) && attwinstate(1,2) && attwinstate(1,3) && attwinstate(1,4) && ~attwinstate(1,5)
                attinstallresult = attmove('install',0,1);%�����߰�װ��Ӧ�������
                if attinstallresult
                    attwinstate(1,5)=true;
                    atttimes(1,5)=atttimes(1,5)+1;
                else
                    attwinstate(1,1)=false;
                    attwinstate(1,2)=false;
                    attweaponresult=-1;
                    attwinstate(1,3)=false;
                    attwinstate(1,4)=false;
                    
                    atttimes(1,5)=atttimes(1,5)+1;
                end
            end
            
            
            if attwinstate(1,1) && attwinstate(1,2) && attwinstate(1,3) && attwinstate(1,4) && attwinstate(1,5) && ~attwinstate(1,6)
                attc2cresult = attmove('c2c',0,1);%������ʵʩ�������
                if attc2cresult
                    attwinstate(1,6)=true;
                    atttimes(1,6)=atttimes(1,6)+1;
                else
                    attwinstate(1,1)=false;
                    attwinstate(1,2)=false;
                    attweaponresult=-1;
                    attwinstate(1,3)=false;
                    attwinstate(1,4)=false;
                    attwinstate(1,5)=false;
                    atttimes(1,6)=atttimes(1,6)+1;
                end
            end
            
            
            
            
            
            
            
            %usrfileend &&
            if  attwinstate(1,1) && attwinstate(1,2) && attwinstate(1,3) && attwinstate(1,4) && attwinstate(1,5) && attwinstate(1,6)
                wholewin=true;
                atttimes(1,attphase+1)=T;
            end
            
            sumattwinstate=[sumattwinstate;attwinstate];
            
            
            %         astrans('ias',T);
            %         astrans('eas',T);
            
            T=T+1;
        end
        Simusrchange(1,Simtime)=usrchange;
        Simusrcost(1,Simtime)=usrcost;
        Simusrhold(1,Simtime)=usrhold;
        for phase=1:(attphase+1)
            Simatttimes(phase,Simtime)=atttimes(1,phase);
        end
        Simattwinstate{1,Simtime}=sumattwinstate;
        Simtime=Simtime-1;
        
    end
%     attipreconneffort=(size(find(Simatttimes(1,:)>256),2))/Maxsimtime;
%     Attipreconn(1,ipchangfrequency)=attipreconneffort;
    
    
% end
% xdata=1:Maxipfrequency;
% f=fit(xdata',Attipreconn(1,:)','exp2');
% plot(f,'fit');
% hold on
% plot(Attipreconn,'.');

attipreconneffort=(size(find(Simatttimes(1,:)>256),2))/Maxsimtime;
usreffcost=(Simusrchange+Simusrhold)./(Simusrcost+Simusrchange+Simusrhold);
figure(2);
histogram(Simatttimes(1,:));
ylabel('Frequency');
xlabel('Number of Attacks')

minatt=min(Simatttimes(1,:))
meanatt=mean(Simatttimes(1,:))
maxatt=max(Simatttimes(1,:))


meanusr=mean(usreffcost)






