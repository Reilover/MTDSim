function [ nodes ] = nodeini( type )
%NODEINI 此处显示有关此函数的摘要
%   此处显示详细说明
global nodenum
global nodeos
global nodeippool
global nodevulnum
global vullevel
global ipbase
global nodeservice
global Gsr
ipbase=zeros(1,nodenum);

for nodei=1:nodenum
    ipbase(nodei)=round(random('unif',0,255));
    iprandom=round(random('unif',0,nodeippool));
    ip=ipbase(nodei)+iprandom;
    if ip>=256
        nodes(nodei).ip=ip-255;
    else
        nodes(nodei).ip=ip;
    end
    port=round(random('unif',1024,65535));
    for plti=1:size(nodeos,2)
        vulnum=round(random('unif',1,nodevulnum));
        if vulnum>1
            for vnum=1:vulnum
                vuldegree(vnum)= vullevel(round(random('unif',1,size(vullevel,2))));%round(random('unif',1,vullevel));
            end
        else
            vuldegree= vullevel(round(random('unif',1,size(vullevel,2))));
        end
        service=nodeservice(round(random('unif',1,size(nodeservice,2))));
        Gsr(nodei,plti).os=nodeos(plti);
        Gsr(nodei,plti).vulnum=vulnum;
        Gsr(nodei,plti).vuldegree=vuldegree;
        Gsr(nodei,plti).service=service;
    end
    os=nodeos(round(random('unif',1,size(nodeos,2))));
    nodes(nodei).port=port;
    nodes(nodei).os=os;
    nodes(nodei).vulnum=Gsr(nodei,os==nodeos).vulnum;
    nodes(nodei).vuldegree=Gsr(nodei,os==nodeos).vuldegree;
    nodes(nodei).service=Gsr(nodei,os==nodeos).service;
    nodes(nodei).hoststate='up';
    nodes(nodei).hostchangedowntime=-1;
end



end

