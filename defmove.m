function [ result ] = defmove( type)
%DEFMOVE 此处显示有关此函数的摘要
%防御动作类型，ip=IP地址变换；host=主机系统变换
%   此处显示详细说明
global nodenum
global nodeos
global nodeippool
global nodevulnum
global edge
global Gsr
global defview
global ipbase
global nodes
global vullevel
switch type
    case 'ip'
        for nodei=1:nodenum
            iprandom=round(random('unif',0,nodeippool));
            ip=ipbase(nodei)+iprandom;
            if ip>255
                nodes(nodei).ip=ip-255;
            else
                nodes(nodei).ip=ip;
            end
        end
        result=nodes;
    case 'host-random'
        for nodei=1:nodenum
            os=nodeos(round(random('unif',1,size(nodeos,2))));
            nodes(nodei).os=os;
            nodes(nodei).vulnum=defview(nodei,os==nodeos).vulnum;
            nodes(nodei).vuldegree=defview(nodei,os==nodeos).vuldegree;
            nodes(nodei).hoststate='down';
        end
        
        result=nodes;
    case 'host-maxdiff'
        for nodei=1:nodenum
            vulnum=round(random('unif',1,nodevulnum));
            os=nodeos(round(random('unif',1,size(nodeos,2))));
            if vulnum>1
                for num=1:vulnum
                    vuldegree(num)= vullevel(round(random('unif',1,size(vullevel,2))));
                end
            else
                vuldegree=vullevel(round(random('unif',1,size(vullevel,2))));
            end
            nodes(nodei).vulnum=vulnum;
            nodes(nodei).os=os;
            nodes(nodei).vuldegree=vuldegree;
            nodes(nodei).hoststate='down';
        end
        result=nodes;
        
end

end

