function [ result ] = usrmove( type,missionstate,id )
%USRMOVE �˴���ʾ�йش˺�����ժҪ
%��������type��ftp��http��multimedia
%����״̬missionstate����<=0������ɣ���>0����ʣ�������Ҫ���
%idĿ�����id��־��
%   �˴���ʾ��ϸ˵��
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

