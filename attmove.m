function [ result ] = attmove( type,state,id )
%ATTMOVE �˴���ʾ�йش˺�����ժҪ
%type ������������
%state ����״̬
%����Ŀ��id��־
% result[]
%   �˴���ʾ��ϸ˵��
global nodenum
global nodes
global attview
global attiniip
global attendip
global crafttime
global vullevel
result=[];
switch type
    case 'reconn'
        %˳�򹥻�
        if attiniip>attendip
            attiniip=0;
        end
        
        for nodeid=1:nodenum
            if nodes(nodeid).ip==attiniip || nodes(nodeid).ip == attview.ip
                attview=nodes(nodeid);
                result=true;
            else
                result=false;
            end
        end
        attiniip=attiniip+1;
        
    case 'weapon'
        
        if state>0
            result=state-1;
        elseif state<0
            craft.os=attview.os;
            craft.vulnum=attview.vulnum;
            if craft.vulnum>1
                for vul=size(vullevel,2):-1:1
                    vull=find(attview.vuldegree==vullevel(vul), 1);
                    if ~isempty(vull)
                        craft.vuldegree=attview.vuldegree(vull);
                        break
                    end
                end
            else
                craft.vuldegree=attview.vuldegree;
            end
            switch craft.vuldegree
                case vullevel(1)
                    craft.time=crafttime(1);
                case vullevel(2)
                    craft.time=crafttime(2);
                case vullevel(3)
                    craft.time=crafttime(3);
            end
            result=craft.time;
        elseif state==0
            result=state;
        end
        
    case 'delivery'
        if attview.ip==nodes(id).ip %&& attview.os==nodes(id).os
            result=true;
        else
            result=false;
            attiniip=0;
            
            
        end
        
    case 'exploit'
        if attview.os == nodes(id).os
            result=true;
        else
            result=false;
            attiniip=0;
        end
        
        
        
        
    case 'install'
        if attview.os == nodes(id).os
            result=true;
        else
            result=false;
            attiniip=0;
        end
        
    case 'c2c'
        if attview.ip==nodes(id).ip && attview.os == nodes(id).os
            result=true;
        else
            result=false;
            attiniip=0;
        end
        
        
    case 'aoo'
end




end

