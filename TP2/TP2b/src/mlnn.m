function mlnn(X, T, varargin)
    % Default Values
    network = "feedforwardnet";
    hidden = [10];
    delay = 1:2;
    fn = "trainlm";
    
    % Optional Arguments
    while ~isempty(varargin)
        switch lower(varargin{1})
            case "network"
                network = varargin{2};
            case "hidden"
                hidden = varargin{2};
            case "fn"
                fn = varargin{2};
            case "delays"
                delay = varargin{2};
            otherwise
                error(["Unknown Option: " varargin{1}]);
        end
        varargin(1:2) = [];
    end

    X = num2cell(X, 1);
    T = num2cell(T, 1);
    if network == "layrecnet"
        net = layrecnet(delay, hidden, fn);
        [Xs,Xi,Ai,Ts] = preparets(net,X,T);
        net = train(net,Xs,Ts,Xi,Ai);
        Y = net(Xs,Xi,Ai);
        perf = perform(net,Y,Ts);
        disp(perf);
    else
       net = feedforwardnet(hidden, fn);
       net = train(net, X, T);
       Y = net(X);
       perf = perform(net, Y, T);
       disp(perf);
    end
end