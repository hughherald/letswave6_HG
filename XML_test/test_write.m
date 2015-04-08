clc;clear;
docNode = com.mathworks.xml.XMLUtils.createDocument('function_config');
docRootNode = docNode.getDocumentElement;

form = docNode.createElement('user_interface');

term=docNode.createElement('string');
term.setAttribute('name','hello');
form.appendChild(term);

term=docNode.createElement('input');
term.setAttribute('name','  operation');
term.setAttribute('id','operation');
term.setAttribute('type','select');
option =docNode.createElement('option');
option.setAttribute('value','zscore');
option.appendChild(docNode.createTextNode('zscore'));
term.appendChild(option);
option =docNode.createElement('option');
option.setAttribute('value','erpercent');
option.appendChild(docNode.createTextNode('erpercent'));
term.appendChild(option);
option =docNode.createElement('option');
option.setAttribute('value','divide');
option.appendChild(docNode.createTextNode('divide'));
term.appendChild(option);
option =docNode.createElement('option');
option.setAttribute('value','subtract');
option.appendChild(docNode.createTextNode('subtract'));
term.appendChild(option);
term.setAttribute('defualt','subtract');
form.appendChild(term);

term=docNode.createElement('input');
term.setAttribute('type','number');
term.setAttribute('name','xstart');
term.setAttribute('min','header.xstart');
term.setAttribute('max','header.xend');
term.setAttribute('defualt','0');
form.appendChild(term);


term=docNode.createElement('input');
term.setAttribute('type','number');
term.setAttribute('name','xend');
term.setAttribute('min','header.xstart');
term.setAttribute('max','header.xend');
term.setAttribute('defualt','0');
form.appendChild(term);

docRootNode.appendChild(form);

xmlwrite('LW_baseline.xml',docNode);


% clc;clear;
% docNode = com.mathworks.xml.XMLUtils.createDocument('function_config');
% docRootNode = docNode.getDocumentElement;
% 
% thisElement = docNode.createElement('input_type');
% thisElement.appendChild(docNode.createTextNode('time_amplitude'));
% docRootNode.appendChild(thisElement);
% 
% thisElement = docNode.createElement('output_type');
% thisElement.appendChild(docNode.createTextNode('time_amplitude'));
% docRootNode.appendChild(thisElement);
% 
% thisElement = docNode.createElement('prefix');
% thisElement.appendChild(docNode.createTextNode('avg '));
% docRootNode.appendChild(thisElement);
% 
% thisElement = docNode.createElement('is_save');
% thisElement.appendChild(docNode.createTextNode('1'));
% docRootNode.appendChild(thisElement);
% 
% form = docNode.createElement('form');
% 
% term=docNode.createElement('string');
% term.setAttribute('name','hello');
% form.appendChild(term);
% 
% term=docNode.createElement('input');
% term.setAttribute('type','number');
% term.setAttribute('name','hello');
% term.setAttribute('arg','1');
% term.setAttribute('defualt','1');
% term.setAttribute('min','header.xstart');
% term.setAttribute('max','header.xend');
% form.appendChild(term);
% 
% term=docNode.createElement('input');
% term.setAttribute('type','select');
% term.setAttribute('name','hello');
% term.setAttribute('arg','1');
% term.setAttribute('defualt','1');
% option =docNode.createElement('option');
% option.setAttribute('value','option1');
% option.appendChild(docNode.createTextNode('option1'));
% term.appendChild(option);
% form.appendChild(term);
% 
% docRootNode.appendChild(form);
% 
% xmlwrite('temp.xml',docNode);