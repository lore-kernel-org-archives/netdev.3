Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553657;
	b=jtPbZIWQuOQbS19+ccSJipirr9Li15l8ZEKwHto+5j05j/eIzFqMk4N/KcFtk3rYXUS2
	 h6Q068rlzzYAOm+PdhU3199pxFAl9zYZjNH3PehmaycGxQwqShivwBzHaVa0XqjyxC7vb
	 FdHsmpmQldMCcKGAZFwxQDwox2iOULZ2TCnpwoDD6vP2Gm8fNGnNqGamdgw+y2uaUTCSP
	 bmi82oyEI/51D7YR9nWNR1zzX2yDm1MqRHCA2nOtUAc1mb4WMhRdbTeRzSzyntPaUPWUq
	 5Bg71orxQay4dgOgnUU5Woa/KHjESdXajFEYBjvKbX6vcoyTbPHhiglcbHEDn8MwYIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553657;
	h=DMARC-Filter:Received:Received:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dhFYOPJUaq7lgzIJ8u39NALz8ioOKZ5Tdw4GRW7dXx8=;
	b=RrNxKmn92/3oSBJf42q7e2hCY/udM0yVBl3UoyoZm2sjgVTHon08QGAK7HCLmnp3ry3O
	 qTwtxxOYK4/i2Pi8oRWV5CxlKl7M+u7LtGPT2bajbXHYLB8MjmKg7POyI6R6Ld0UpitVQ
	 nAiTT50FO+JAcoBgjkC+6vZiWQ/cP+hL6ul2Wi6+nLTKjIIez2yvCev0OTzCm8V5vNxC4
	 fkugeQCls/E8AZc1dRpHZkaD9Qw9HRSVL1UQ61s0Fn493NNXoDVGV+bXCAr2c5iwMumVe
	 FPWog7t6i28BkMzNvBDCy2/hvJWc/OiD5T1xmoDixXFn9/NTnxg+ztt6UY98bNprusg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=idosch.org;
	spf=none smtp.mailfrom=idosch.org;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="xcRm2g/7";
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4A606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA4A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xcRm2g/7
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF8087A0318;
	Fri, 13 Nov 2026 02:07:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 13 Nov 2026 02:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794553655; x=1794640055; bh=dhFYOPJUaq7lgzIJ8u39NALz8ioOKZ5Tdw4
	GRW7dXx8=; b=xcRm2g/7joB3JAUawdOg/JE2maok4s8SBvV4ln20+umeqBhahdj
	mQItmvcKomN/xvlUd3I5kRBfQOYXq3v6ulPmB3WNOuL5SWsxkdaIFafUogsoeqC+
	nXCc6nW6oFeTn3X3yBXdFQqT1X37RdVDBUI7NILHSxs5p/+OkIHjJZczslBZAxrU
	kux65vDLWJRK/941pF9zVxAnKjxFFqY+lD2A836etVXpUHNyP6DWFfNdLfH7+vgm
	tLYVj2uYMY4DxsPLZrPLw8Ol+jTXIvNKKbMmPzX8YtS0EUbA/II+qVmeZjAnfDUn
	KLCBGhGIG1fiB0xym59dvGqoRqX+L2I4sOg==
X-ME-Sender: <xms:N7f2ajcJf5PSBtkUBAs6wvpaYseb_Gq5g55F7ihQNeitgp25d-HUKA>
    <xme:N7f2ahZnhOIFRZGmgbBbUvRpFKj_HEj5upz14wiQGoULBbB_722ANRwuckNTVAYwO
    YD0tSPLGAYfGgLY5RJevc0Nyg8-RPjs6GxU-vOUDKjK4JkqRd4>
X-ME-Received: <xmr:N7f2aoFqwAw7-Cm_c5vnSJpWWpLw2k5PZ3soADVWxFQpGUkZQpaKwrVbijPcziTSC_aKHpU8Q9b-kpc1PJC3obYk5J1SCw>
X-ME-Proxy-Cause: dmFkZTEdYcJ4nOryxchnTL05jXVotylDQ7YuUQmlQgFSH/IcyWW7iTBs5CBqO8qxUWZ6jp
    CQkvDKt4HOctQZkJEV9qrurJ4b9dZh09RJJuAH3DByyu6a51dKNoeg/JATnZuQahYnscjU
    EWjN51CB4n8lAtrQczP0fxLrQPkO5/5ubyAiM37BhkczTRmJzXMBec+PC0Ew4mzp/zzk7d
    83Y7hj+Y4NIvCtHUwwUIE5W4ZuBbdLZJwjx4GbU70toNKBeH5GU1uo5jnfdv6XBNPmYVrA
    XxKTw1U8+uo1sp6zN/1Ehoeg04cVEFsnQtgMBbwrJqfWJrZTYX4IgXF2+HOkvPLGRi2pDD
    3eXXFn9gZjTRwQa0q6MoLxiig/KWuwM00ro+KQWM0+OUQrzedPmPUDv8h/8Kw7LSoSxiW/
    sMuI0Gu3LCfC4pjOXNLM7R1gjRuuY5vOodS2G+b6V7ZTtKoyhBR60/5qshXFypv98/y4q0
    nWkPPCF8BmhCJFAnQmb0q4bt/Us1QCnL2fU/H9CaxtZY5ovNmC8j5w1SpNe8S2p7MCEsOy
    j4ygekkcxj4BrRQw7YBUO9AfmsDaffxyGnQt1kKOAfSpGos74S6mmhpAM/p2zYeUZ1K1lJ
    1pUhnCx5Ex42nWbixu+cf25JUUakOOAmZU34rkA2JrR/u30Gu6uCGL+CWuuQ
X-ME-Proxy: <xmx:N7f2avnEAb3vpfhUDl2TRKiyNy6v_lq-KexB8qje0a8A34Cbblto7A>
    <xmx:N7f2arfXkosPmVWomVdi9Sv7Jt1JeG_7eZf4apl8HosQlbr9Nn37Yg>
    <xmx:N7f2atEV7eBykgpOEVj_N6-9aBIajS5CnLfQUhYr-i3wkfX9d2yPhQ>
    <xmx:N7f2ahgrA_FlG9V6piAZyttdNEdQI7-xTSrcDHT2ni_NyZLYgkxoFw>
    <xmx:N7f2av9bVStA4pvM9Oe9UrbfN0b5eWoaw1UWfj7PwP38eFCOiWxHqSZQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 02:07:34 -0500 (EST)
Date: Fri, 13 Nov 2026 09:07:32 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
	razor@blackwall.org, aahila@google.com
Subject: Re: [PATCH net-next 2/2] selftests: bonding: Add a test for 802.3ad
 with coupled control disabled
Message-ID: <20261113070732.GC3517282@shredder>
References: <20261111171947.2816258-1-idosch@nvidia.com>
 <20261111171947.2816258-2-idosch@nvidia.com>
 <avZ07oXIXo7xZyCC@fedora>
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
In-Reply-To: <avZ07oXIXo7xZyCC@fedora>

On Fri, Nov 13, 2026 at 10:24:46AM +0800, Hangbin Liu wrote:
> Hi Ido,
> On Wed, Nov 11, 2026 at 07:19:47PM +0200, Ido Schimmel wrote:
> > Test that with coupled control disabled, a port in COLLECTING state
> > receives packets.
> > 
> > In this mode, a port only transitions from COLLECTING to DISTRIBUTING
> > state if its partner sets the Collecting bit in its LACPDUs. Therefore,
> > keep the port in COLLECTING state by clearing the Collecting bit in
> > received LACPDUs.
> > 
> > Also test that ping works once the port moves to DISTRIBUTING state.
> > 
> > Use VRFs rather than network namespaces so that the test could be run
> > with a veth pair or a pair of physically connected ports.
> > 
> > Output without "bonding: 3ad: Receive packets in COLLECTING state":
> > 
> >  # ./bond_lacp_independent_control.sh
> >  TEST: Receive in COLLECTING state                                   [FAIL]
> >          Packets not received in COLLECTING state
> >  TEST: Ping in DISTRIBUTING state                                    [ OK ]
> > 
> > Output with the fix:
> > 
> >  # ./bond_lacp_independent_control.sh
> >  TEST: Receive in COLLECTING state                                   [ OK ]
> >  TEST: Ping in DISTRIBUTING state                                    [ OK ]
> > 
> > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  .../selftests/drivers/net/bonding/Makefile    |   1 +
> >  .../bonding/bond_lacp_independent_control.sh  | 144 ++++++++++++++++++
> >  .../selftests/drivers/net/bonding/config      |   6 +
> >  3 files changed, 151 insertions(+)
> >  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> > 
> > diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> > index e337c099fb40..46d9fede5918 100644
> > --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> > +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> > @@ -7,6 +7,7 @@ TEST_PROGS := \
> >  	bond-eth-type-change.sh \
> >  	bond-lladdr-target.sh \
> >  	bond_ipsec_offload.sh \
> > +	bond_lacp_independent_control.sh \
> >  	bond_lacp_prio.sh \
> >  	bond_lacp_strict.sh \
> >  	bond_macvlan_ipvlan.sh \
> > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> > new file mode 100755
> > index 000000000000..c29712e01e49
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> > @@ -0,0 +1,144 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# +-------------------------+ +-------------------------+
> > +# | H1 (vrf)                | | H2 (vrf)                |
> > +# |  + bond1 (802.3ad)      | |  + bond2 (802.3ad)      |
> > +# |  | coupled_control off  | |  |                      |
> > +# |  | 192.0.2.1/28         | |  | 192.0.2.2/28         |
> > +# |  |                      | |  |                      |
> > +# |  + $h1                  | |  + $h2                  |
> > +# +--|----------------------+ +--|----------------------+
> > +#    |                           |
> > +#    +---------------------------+
> > +
> > +# shellcheck disable=SC2034,SC2329
> > +ALL_TESTS="
> > +	collecting
> > +	distributing
> > +"
> > +NUM_NETIFS=2
> > +REQUIRE_MZ=no
> > +lib_dir=$(dirname "$0")
> > +# shellcheck disable=SC1091
> > +source "$lib_dir"/../../../net/forwarding/lib.sh
> > +
> > +lacp_state_get()
> > +{
> > +	local dev=$1; shift
> > +
> > +	ip -d -j link show dev "$dev" | \
> > +		jq '.[].linkinfo.info_slave_data.ad_actor_oper_port_state'
> > +}
> > +
> > +# The actor state of a port in ATTACHED state is 0x0f: Activity (0x01),
> > +# Timeout (0x02), Aggregation (0x04) and Synchronization (0x08). The
> > +# Collecting (0x10) bit is added in COLLECTING state (0x1f) and the
> > +# Distributing (0x20) bit in DISTRIBUTING state (0x3f).
> > +lacp_state_wait()
> > +{
> > +	local dev=$1; shift
> > +	local state=$1; shift
> > +
> > +	slowwait "$WAIT_TIMEOUT" until_counter_is "== $state" \
> > +		lacp_state_get "$dev" > /dev/null
> > +}
> > +
> > +partner_state_clear()
> > +{
> > +	local bits=$1; shift
> > +
> > +	tc filter replace dev "$h1" ingress pref 1 handle 101 protocol 0x8809 \
> > +		flower skip_hw action pedit munge offset 18 u8 set 0 \
> > +		retain "$bits"
> > +}
> > +
> > +h1_create()
> > +{
> > +	adf_ip_link_add bond1 type bond mode 802.3ad lacp_rate fast \
> > +		coupled_control off
> > +	adf_ip_link_set_master "$h1" bond1
> > +	adf_simple_if_init bond1 192.0.2.1/28
> > +
> > +	tc qdisc add dev "$h1" clsact
> > +	defer tc qdisc del dev "$h1" clsact
> > +
> > +	tc qdisc add dev bond1 clsact
> > +	defer tc qdisc del dev bond1 clsact
> > +
> > +	tc filter add dev bond1 ingress pref 1 handle 101 proto ip \
> > +		flower skip_hw src_ip 192.0.2.2 dst_ip 192.0.2.1 \
> > +		ip_proto icmp type 8 action pass
> > +	defer tc filter del dev bond1 ingress pref 1 handle 101 flower
> > +}
> > +
> > +h2_create()
> > +{
> > +	adf_ip_link_add bond2 type bond mode 802.3ad lacp_rate fast
> > +	adf_ip_link_set_master "$h2" bond2
> > +	adf_simple_if_init bond2 192.0.2.2/28
> > +}
> > +
> > +setup_prepare()
> > +{
> > +	h1=${NETIFS[p1]}
> > +	h2=${NETIFS[p2]}
> > +
> > +	adf_vrf_prepare
> 
> Nit: why we need the vrf prepare? The h1/h2 should be veth interface, no?

No. The VRF usage is intentional. From the commit message:

"Use VRFs rather than network namespaces so that the test could be run
with a veth pair or a pair of physically connected ports."

> 
> > diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> > index b62c70715293..71c6d69d98a1 100644
> > --- a/tools/testing/selftests/drivers/net/bonding/config
> > +++ b/tools/testing/selftests/drivers/net/bonding/config
> > @@ -1,13 +1,17 @@
> >  CONFIG_BONDING=y
> > +CONFIG_BPF_SYSCALL=y
> >  CONFIG_BRIDGE=y
> > +CONFIG_CGROUP_BPF=y
> >  CONFIG_CONFIGFS_FS=y
> >  CONFIG_DUMMY=y
> >  CONFIG_INET_ESP=y
> >  CONFIG_INET_ESP_OFFLOAD=y
> >  CONFIG_IPV6=y
> > +CONFIG_IPV6_MULTIPLE_TABLES=y
> 
> Do we need this config ?

Yes. CONFIG_NET_VRF depends on it when IPv6 is enabled and it's not
enabled by default. Other config files that enable CONFIG_NET_VRF list
it as well.

> 
> >  CONFIG_IPVLAN=y
> >  CONFIG_MACVLAN=y
> >  CONFIG_NET_ACT_GACT=y
> > +CONFIG_NET_ACT_PEDIT=m
> >  CONFIG_NET_CLS_FLOWER=y
> >  CONFIG_NET_CLS_MATCHALL=m
> >  CONFIG_NETCONSOLE=m
> > @@ -15,7 +19,9 @@ CONFIG_NETCONSOLE_DYNAMIC=y
> >  CONFIG_NETCONSOLE_EXTENDED_LOG=y
> >  CONFIG_NETDEVSIM=m
> >  CONFIG_NET_IPGRE=y
> > +CONFIG_NET_L3_MASTER_DEV=y
> >  CONFIG_NET_SCH_INGRESS=y
> > +CONFIG_NET_VRF=y
> 
> If yes, this config could be removed. And the H1 (vrf) description in the
> chart.

See above. VRF is needed.
