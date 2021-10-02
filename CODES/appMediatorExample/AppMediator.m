classdef AppMediator < handle
    %MEDIATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Callback function_handle;
        DialogueCtor;
    end
    
    methods
        function this = AppMediator(dlgCtor)
            this.DialogueCtor = dlgCtor;
        end
        
        function showValueDialogue(this, callback)
            % keep this callback
            this.Callback = callback;
            this.DialogueCtor(this);
        end
        
        function valueChosenCallback(this, action, x, y)
            if strcmpi(action, 'OK')
                if isempty(this.Callback)
                    % do something to throw a fancy error
                end
                
                this.Callback(x, y);
            else
                % clear the callback because the user cancelled the
                % operation
                this.Callback = function_handle.empty();
            end
        end
    end
end

