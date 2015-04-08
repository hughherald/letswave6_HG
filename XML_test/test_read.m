clc;clear;
rootNode = xmlread('LW_baseline.xml');
%xmlwrite('LW_baseline.xml',rootNode);
theNode = rootNode.getElementsByTagName('item');
for k=1:theNode.getLength
    item=theNode.item(k-1);
end

theNode = theNode.item(0);

% Recurse over node children.
children = [];
if theNode.hasChildNodes
    childNodes = theNode.getChildNodes;
    numChildNodes = childNodes.getLength;
    allocCell = cell(1, 1);
    
    children = struct('name', allocCell,...
        'id',   allocCell,...
        'type', allocCell,...
        'defualt',allocCell);
    count=0;
    for k = 1:numChildNodes
        theChild = childNodes.item(k-1);
        if ~strcmp(theChild.getNodeName,'#text')
            count=count+1;
            children(count).name= char(theChild.getNodeName);
            children(count).name=theChild.getAttribute('name');
            children(count).id= char(theChild.getNodeName);
        end
    end
end