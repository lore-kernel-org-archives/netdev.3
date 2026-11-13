Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536202;
	b=yhhBsniS71Qg/fnebr+US83zet7SS5es7Tjl8LMG5ZXJVyjpdOx2+RZTQ6Zwv+EB/1M5
	 1QcY8For4D6Nwv+vTx479G+P9xgeSSTTnKLamR3dNBx75JX1A3o3cU7+KA+LRkwOENfLl
	 98HqTJieHPj264umPeta31RLKAy7dQUaRR1YhdR6kdFTFhmplp4zE4ckMwfAx2JWg9rXs
	 eFakwtU0FFRV1jPzVRt6oxlYlQQbOz/tJx3AjdNUOyNSnmo9TpOaA5+6FFQcZKhphxSsK
	 YxT6vrP4pCU7a5aR7SOOE58R/1d+VtonY8h3Aul/4Mp2fjVbCkVEgD99ZyWScv4Iwyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536202;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bpQRDrxx2bpL2VvnttbeWwutzp0HVnsNMS4rnwfsbp8=;
	b=ppFixlPPe6i3JpDS/0jwExzli4BjSQt/ZUDnZl5tyD226QfCIAoZFgguOk1KhGKR8WfC
	 o4rPF7gDXt7bS5/Rakeh8qP5ZNnFjXw0WdcdfnmWcn+EfCj9b2smEzsZzgIF6fKBM6H3u
	 n1CmPVBSXsQkSqW1N3XX2hW8ogTuAkDbfQsERAUHg6NYamTSt0oLKlxUSyzikoJg8DCfR
	 IDHRuU23Bl7FhFGxCsH/slnfrQru3lIYAQwj9M1ZSs6J8A9kipGYqh9fuxaya1/XdNCzp
	 PccNnnnBwCYP+dgqKbxcWQ+IAwvBX5h6l7cREeBVLz3NLyJg8fgQ1oeu9tui1HjKUsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i+QQ5ES0;
	arc=none smtp.remote-ip=91.218.175.99
Received: from mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D5606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 658D5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i+QQ5ES0
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GBveLCadS9QGGlTaphsN8yzGhqi5dq+SICTfuAMy8R0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794536199; v=1; x=1795140999;
 b=i+QQ5ES0rHDKnte1cicMTe5YSN5SngMxI3xlFB7tZnDE3SBo0vakj7fQk2FAyWJwOO3sm6St
 Jc9Y41oQsxDL0xzN/wsmuoaX9ZBkjq8NyWG2FJ67gs32H2K7TSX4/o1uLbOpH+VKBYUZWt1y3Wh
 Y79bSpv+JL+VzhWpXigHZz60=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 6b9387c472035193;
	Fri, 13 Nov 2026 02:16:39 +0000
X-Mizu-Trace-ID: 6b9387c472035193
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 10:16:28 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@kernel.org, jv@jvosburgh.net,
	andrew+netdev@lunn.ch, razor@blackwall.org, aahila@google.com
Subject: Re: [PATCH net-next 2/2] selftests: bonding: Add a test for 802.3ad
 with coupled control disabled
Message-ID: <avZy_LUjqfnHJ498@fedora>
References: <20261111171947.2816258-1-idosch@nvidia.com>
 <20261111171947.2816258-2-idosch@nvidia.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111171947.2816258-2-idosch@nvidia.com>

On Wed, Nov 11, 2026 at 07:19:47PM +0200, Ido Schimmel wrote:
> Test that with coupled control disabled, a port in COLLECTING state
> receives packets.
> 
> In this mode, a port only transitions from COLLECTING to DISTRIBUTING
> state if its partner sets the Collecting bit in its LACPDUs. Therefore,
> keep the port in COLLECTING state by clearing the Collecting bit in
> received LACPDUs.
> 
> Also test that ping works once the port moves to DISTRIBUTING state.
> 
> Use VRFs rather than network namespaces so that the test could be run
> with a veth pair or a pair of physically connected ports.
> 
> Output without "bonding: 3ad: Receive packets in COLLECTING state":
> 
>  # ./bond_lacp_independent_control.sh
>  TEST: Receive in COLLECTING state                                   [FAIL]
>          Packets not received in COLLECTING state
>  TEST: Ping in DISTRIBUTING state                                    [ OK ]
> 
> Output with the fix:
> 
>  # ./bond_lacp_independent_control.sh
>  TEST: Receive in COLLECTING state                                   [ OK ]
>  TEST: Ping in DISTRIBUTING state                                    [ OK ]
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  .../selftests/drivers/net/bonding/Makefile    |   1 +
>  .../bonding/bond_lacp_independent_control.sh  | 144 ++++++++++++++++++
>  .../selftests/drivers/net/bonding/config      |   6 +
>  3 files changed, 151 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> index e337c099fb40..46d9fede5918 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -7,6 +7,7 @@ TEST_PROGS := \
>  	bond-eth-type-change.sh \
>  	bond-lladdr-target.sh \
>  	bond_ipsec_offload.sh \
> +	bond_lacp_independent_control.sh \
>  	bond_lacp_prio.sh \
>  	bond_lacp_strict.sh \
>  	bond_macvlan_ipvlan.sh \
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> new file mode 100755
> index 000000000000..c29712e01e49
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> @@ -0,0 +1,144 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# +-------------------------+ +-------------------------+
> +# | H1 (vrf)                | | H2 (vrf)                |
> +# |  + bond1 (802.3ad)      | |  + bond2 (802.3ad)      |
> +# |  | coupled_control off  | |  |                      |
> +# |  | 192.0.2.1/28         | |  | 192.0.2.2/28         |
> +# |  |                      | |  |                      |
> +# |  + $h1                  | |  + $h2                  |
> +# +--|----------------------+ +--|----------------------+
> +#    |                           |
> +#    +---------------------------+
> +
> +# shellcheck disable=SC2034,SC2329
> +ALL_TESTS="
> +	collecting
> +	distributing
> +"
> +NUM_NETIFS=2
> +REQUIRE_MZ=no
> +lib_dir=$(dirname "$0")
> +# shellcheck disable=SC1091
> +source "$lib_dir"/../../../net/forwarding/lib.sh
> +
> +lacp_state_get()
> +{
> +	local dev=$1; shift
> +
> +	ip -d -j link show dev "$dev" | \
> +		jq '.[].linkinfo.info_slave_data.ad_actor_oper_port_state'
> +}
> +
> +# The actor state of a port in ATTACHED state is 0x0f: Activity (0x01),
> +# Timeout (0x02), Aggregation (0x04) and Synchronization (0x08). The
> +# Collecting (0x10) bit is added in COLLECTING state (0x1f) and the
> +# Distributing (0x20) bit in DISTRIBUTING state (0x3f).
> +lacp_state_wait()
> +{
> +	local dev=$1; shift
> +	local state=$1; shift
> +
> +	slowwait "$WAIT_TIMEOUT" until_counter_is "== $state" \
> +		lacp_state_get "$dev" > /dev/null
> +}
> +
> +partner_state_clear()
> +{
> +	local bits=$1; shift
> +
> +	tc filter replace dev "$h1" ingress pref 1 handle 101 protocol 0x8809 \
> +		flower skip_hw action pedit munge offset 18 u8 set 0 \
> +		retain "$bits"
> +}
> +
> +h1_create()
> +{
> +	adf_ip_link_add bond1 type bond mode 802.3ad lacp_rate fast \
> +		coupled_control off
> +	adf_ip_link_set_master "$h1" bond1
> +	adf_simple_if_init bond1 192.0.2.1/28
> +
> +	tc qdisc add dev "$h1" clsact
> +	defer tc qdisc del dev "$h1" clsact
> +
> +	tc qdisc add dev bond1 clsact
> +	defer tc qdisc del dev bond1 clsact
> +
> +	tc filter add dev bond1 ingress pref 1 handle 101 proto ip \
> +		flower skip_hw src_ip 192.0.2.2 dst_ip 192.0.2.1 \
> +		ip_proto icmp type 8 action pass
> +	defer tc filter del dev bond1 ingress pref 1 handle 101 flower
> +}
> +
> +h2_create()
> +{
> +	adf_ip_link_add bond2 type bond mode 802.3ad lacp_rate fast
> +	adf_ip_link_set_master "$h2" bond2
> +	adf_simple_if_init bond2 192.0.2.2/28
> +}
> +
> +setup_prepare()
> +{
> +	h1=${NETIFS[p1]}
> +	h2=${NETIFS[p2]}
> +
> +	adf_vrf_prepare
> +
> +	h1_create
> +	h2_create
> +}
> +
> +collecting()
> +{
> +	local pkts
> +
> +	RET=0
> +
> +	# Clear the Synchronization (0x08) and Collecting (0x10) bits in the
> +	# partner's state to move $h1 to ATTACHED state and then only clear
> +	# the Collecting bit to move it to COLLECTING state.
> +	partner_state_clear 0x18
> +	defer tc filter del dev "$h1" ingress pref 1 handle 101 flower
> +	lacp_state_wait "$h1" 0x0f
> +	check_err $? "Port did not reach ATTACHED state"
> +
> +	partner_state_clear 0x10
> +	lacp_state_wait "$h1" 0x1f
> +	check_err $? "Port did not reach COLLECTING state"
> +
> +	# $h1 cannot reply to ARP requests in COLLECTING state.
> +	ip neigh add 192.0.2.1 lladdr "$(mac_get bond1)" dev bond2 \
> +		nud permanent
> +	defer ip neigh del 192.0.2.1 dev bond2
> +
> +	ping_do bond2 192.0.2.1
> +	pkts=$(tc_rule_handle_stats_get "dev bond1 ingress" 101)
> +	((pkts >= PING_COUNT))
> +	check_err $? "Packets not received in COLLECTING state"
> +
> +	log_test "Receive in COLLECTING state"
> +}
> +
> +distributing()
> +{
> +	RET=0
> +
> +	lacp_state_wait "$h1" 0x3f
> +	check_err $? "Port did not reach DISTRIBUTING state"
> +
> +	ping_do bond2 192.0.2.1
> +	check_err $? "Ping failed"
> +
> +	log_test "Ping in DISTRIBUTING state"
> +}
> +
> +trap cleanup EXIT
> +
> +setup_prepare
> +setup_wait
> +
> +tests_run
> +
> +exit "$EXIT_STATUS"
> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index b62c70715293..71c6d69d98a1 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config
> @@ -1,13 +1,17 @@
>  CONFIG_BONDING=y
> +CONFIG_BPF_SYSCALL=y
>  CONFIG_BRIDGE=y
> +CONFIG_CGROUP_BPF=y
>  CONFIG_CONFIGFS_FS=y
>  CONFIG_DUMMY=y
>  CONFIG_INET_ESP=y
>  CONFIG_INET_ESP_OFFLOAD=y
>  CONFIG_IPV6=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
>  CONFIG_IPVLAN=y
>  CONFIG_MACVLAN=y
>  CONFIG_NET_ACT_GACT=y
> +CONFIG_NET_ACT_PEDIT=m
>  CONFIG_NET_CLS_FLOWER=y
>  CONFIG_NET_CLS_MATCHALL=m
>  CONFIG_NETCONSOLE=m
> @@ -15,7 +19,9 @@ CONFIG_NETCONSOLE_DYNAMIC=y
>  CONFIG_NETCONSOLE_EXTENDED_LOG=y
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_IPGRE=y
> +CONFIG_NET_L3_MASTER_DEV=y
>  CONFIG_NET_SCH_INGRESS=y
> +CONFIG_NET_VRF=y
>  CONFIG_NLMON=y
>  CONFIG_VETH=y
>  CONFIG_VLAN_8021Q=m
> -- 
> 2.56.0
> 

Tested-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
