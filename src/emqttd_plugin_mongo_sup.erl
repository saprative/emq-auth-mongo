%%--------------------------------------------------------------------
%% Copyright (c) 2015-2016 Feng Lee <feng@emqtt.io>.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

%% @doc MongoDB Plugin Supervisor
%% 
%% @author @lovecc0923
%% @author Feng Lee <feng@emqtt.io>
-module(emqttd_plugin_mongo_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  {ok, Env} = application:get_env(emqttd_plugin_mongo, mongo_pool),
  Pool = ecpool:pool_spec(mongo_pool, mongo_pool, emqttd_mongo_client, Env),
  {ok, {{one_for_all, 10, 100}, [Pool]}}.
