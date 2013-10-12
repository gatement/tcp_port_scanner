-module(tcp_scanner).
-compile(export_all).

start(Host) ->
	io:format("active TCP ports: ", []),
    scan(Host, 1),
	io:format("done.~n", []).


scan(_, 65536) ->
	done;

scan(Host, Port) ->
	Timeout = 300,
	case gen_tcp:connect(Host, Port, [], Timeout) of
		{ok, Sock} -> 
			io:format("~p, ", [Port]),
			gen_tcp:close(Sock);
		_ -> skip
	end,
	scan(Host, Port + 1).
