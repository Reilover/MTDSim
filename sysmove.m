function [ result ] = sysmove( type,T)
%SYSMOVE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global nodenum
global nodes
global maxhostchangedowntime
switch type
    case 'hostchangeup'
        for i=1:nodenum
            if strcmp(nodes(i).hoststate,'down') %
                if nodes(i).hostchangedowntime ==-1
                    nodes(i).hostchangedowntime=T;
                    
                end
                if T-nodes(i).hostchangedowntime == maxhostchangedowntime
                    nodes(i).hoststate = 'up';
                    nodes(i).hostchangedowntime=-1;
                end
                
            end
        end
end

end
