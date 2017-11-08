function [ result ] = usrmove( type,missionstate,id )
%USRMOVE 此处显示有关此函数的摘要
%任务类型type：ftp，http和multimedia
%任务状态missionstate：“<=0”已完成，“>0”还剩余多少需要完成
%id目标对象id标志符
%   此处显示详细说明
global usrview
global usrchange
global usrcost
global usrhold
global nodes
BW=100/8;
switch type
    case 'ftp'
        if missionstate>0
            if usrview(id).ip==nodes(id).ip && strcmp(nodes(id).hoststate,'up') %&& usrview(id).os==nodes(id).os
                missionstate=missionstate-BW;
                result=missionstate;
                usrcost=usrcost+1;
                return
            elseif usrview(id).ip~=nodes(id).ip && strcmp(nodes(id).hoststate,'up')
                usrview(id)=nodes(id);
                result=missionstate;
                usrchange=usrchange+1;
                return
            elseif usrview(id).ip==nodes(id).ip && strcmp(nodes(id).hoststate,'down')
                result=missionstate;
                usrhold=usrhold+1;
                return
            elseif usrview(id).ip~=nodes(id).ip && strcmp(nodes(id).hoststate,'down')
                usrview(id)=nodes(id);
                result=missionstate;
                usrchange=usrchange+1;
                return
            end
        else
            usrcost=usrcost+1;
            result=missionstate;
            return
        end
        
        
        
        
    case 'http'
        
        result=[];
    case 'multimedia'
        result=[];
end


end

