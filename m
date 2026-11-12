Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514919;
	b=2tEulE0HDLtyX6YxuzKDScOCAlKNJM0NHWu15Xy0VqoIptjd9SDwqnzivE7kWZVmeSxs
	 BH4ySC1yFIvHNWJCdyTiSL5kH18x4b2IHylE1ZIB6+MDabD1Fz4wPqu/lfpIpBGOsdZQC
	 98JMFJ7vPlQaNlAmLyZDO3YWeLa3vH9fC8rzQDpg9IAqgRpOY1iyBXmAz5+WUaYidc0Pe
	 K1FOucOIezfhkbc8vJq/2pfS7wti1x4IHct0ODQ0RlYOkMFUq8a5X2y6EmcVK3WqmSvkR
	 Uz27sAa49HkqdGRg+qE6FIvL6oYErq9lUmeEuie0oQHWOr+RF+LLdXPIZL7lj750C8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514919;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xQLMtJSqy8FG262aA8N0q0Rpw5hd52l2f1OMCg367UM=;
	b=eWrL9yhxa3whb2t18OphdA3xa/aU9yo7wJh/47fzo+cL20v21yeKeGyuB6ExprGHQbrI
	 TX1TFBZmVXVS2KQLoHOZXPxRdlqOzIShKwLftv5+c4d1YzqA1CZCV8nrRnwz5qfcf/Pfm
	 rT9G1KHIGYJRRokRED5zEIl0k3gR6mfZXSmSxdg6xfZEkapsN7N4U5gRorAj8820XNCkn
	 r876q2iuwBHZMxkxU+F7n3d20OxveQU6yeOp0xkiRpMfUnYX02WQINiyDEbmnfUpLmU8J
	 W+GehyvWajozMfWMhNXGP+R6sf2rphstbMne+yeWwpxTjhX5qLYk0XDTzNIzLBth8tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH1RaPMK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD112606A882
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH1RaPMK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FD81F000C4;
	Thu, 12 Nov 2026 20:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514919;
	bh=xQLMtJSqy8FG262aA8N0q0Rpw5hd52l2f1OMCg367UM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NH1RaPMKN1Qy+y/kj112SpA+0zj+M1t55Rvl7oYZkjnC8fEs1w0YjPGjJ6yuZ0Pfz
	 6rQ6kDULnacLIcRMdLQ50g0WtjRDAbB8iTO4wTgLJ9yUIjylVm8H6IjFnLSmPOSaxy
	 RBlOYSDnHuEjWNurk5X0tPCEb3BJe0kGVYPj8Pwp7TL7vPxKqDdViVZ+gVuQGK1GQL
	 CxKzMclGVMUWqJ3AYA6YU4/wwCm0ICKHKU40WkfKle/pMwUIF+hgO74KUNPCBNWB9x
	 wEHNJFybaxWgNF1gP60X95g8+1+OpbpYEyL54dbE0uxyprsJ7e+SaFNmd5eGHeLt27
	 TsJQxbTm+GBYg==
Subject: Re: [PATCH net-next 2/2] selftests: bonding: Add a test for 802.3ad
 with coupled control disabled
From: netdev-bot+sashiko@kernel.org
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, razor@blackwall.org, aahila@google.com
Date: Thu, 12 Nov 2026 20:21:58 +0000
Message-ID: <179451491828.2199510.10600083511159752831@kernel.org>
In-Reply-To: <20261111171947.2816258-2-idosch@nvidia.com>
References: <20261111171947.2816258-2-idosch@nvidia.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The bonding selftest config fragment
  (tools/testing/selftests/drivers/net/bonding/config) now asks for…
- [Low] In bond_lacp_independent_control.sh, collecting() reads the total
  packet count of the bond1 ingress ICMP echo-request filter (handle…

--

selftests: bonding: Add a test for 802.3ad with coupled control disabled

This adds a VRF based selftest which checks that a bond port with
coupled_control off receives packets in COLLECTING state. It keeps the
port in COLLECTING state by clearing the Collecting bit in received
LACPDUs, and then checks that ping works in DISTRIBUTING state. The
bonding selftest config fragment gains the VRF, pedit and policy routing
options the test needs.

> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> new file mode 100755
> index 0000000000000..c29712e01e49e
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh

[ ... ]

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

[ ... ]

> +collecting()
> +{

[ ... ]

> +	ping_do bond2 192.0.2.1
> +	pkts=$(tc_rule_handle_stats_get "dev bond1 ingress" 101)
> +	((pkts >= PING_COUNT))
> +	check_err $? "Packets not received in COLLECTING state"

[Severity: Low]
Can this check pass when no packets were received in COLLECTING state?

The bond1 ingress filter with handle 101 is installed once by
h1_create() from setup_prepare(), outside the per-test defer scopes, so
its counter keeps growing across tests. collecting() compares the
absolute counter with PING_COUNT and does not take a baseline before
ping_do.

tests_run() in net/lib.sh iterates over ${TESTS:-$ALL_TESTS}. Take
TESTS="distributing collecting" as an example:

distributing()
    ping_do bond2 192.0.2.1    <- PING_COUNT echo requests hit filter 101
collecting()
    port moved to COLLECTING state
    ping_do bond2 192.0.2.1    <- nothing received without the fix
    pkts >= PING_COUNT         <- still true from the earlier test

The same thing happens if collecting is listed twice. The default
ALL_TESTS order runs collecting first, so the default run is not
affected.

Since the ping_do return value is ignored here, this counter is the only
check of the fix. Would it make sense to read the counter before ping_do
and check the delta, or to create the filter inside collecting() with a
matching defer?

> +
> +	log_test "Receive in COLLECTING state"
> +}

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index b62c707152930..71c6d69d98a18 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config

[ ... ]

> @@ -15,7 +19,9 @@ CONFIG_NETCONSOLE_DYNAMIC=y
>  CONFIG_NETCONSOLE_EXTENDED_LOG=y
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_IPGRE=y
> +CONFIG_NET_L3_MASTER_DEV=y
>  CONFIG_NET_SCH_INGRESS=y
> +CONFIG_NET_VRF=y

[Severity: Low]
Should this fragment also enable CONFIG_IP_ADVANCED_ROUTER=y and
CONFIG_IP_MULTIPLE_TABLES=y?

NET_VRF depends on IP_MULTIPLE_TABLES in drivers/net/Kconfig:

config NET_VRF
	tristate "Virtual Routing and Forwarding (Lite)"
	depends on IP_MULTIPLE_TABLES
	depends on NET_L3_MASTER_DEV
	depends on IPV6_MULTIPLE_TABLES || IPV6=n

and in net/ipv4/Kconfig, IP_MULTIPLE_TABLES depends on IP_ADVANCED_ROUTER
and has no default:

config IP_MULTIPLE_TABLES
	bool "IP: policy routing"
	depends on IP_ADVANCED_ROUTER

The patch adds the NET_L3_MASTER_DEV and IPV6_MULTIPLE_TABLES
dependencies but not the IPv4 ones. If the fragment is merged onto a base
config that lacks them, Kconfig silently drops NET_VRF. arm64 defconfig
is one example: it sets neither symbol, while x86_64_defconfig sets both.

In that case setup_prepare()->adf_vrf_prepare()->vrf_prepare() runs:

	ip -4 rule add pref 32765 table local

which needs IPv4 policy routing, and adf_simple_if_init() cannot create
the VRF devices. The test then fails during setup and never exercises the
bonding change.

Several other net selftest fragments have the same gap, while
net/mptcp/config lists IP_MULTIPLE_TABLES explicitly.

>  CONFIG_NLMON=y
>  CONFIG_VETH=y
>  CONFIG_VLAN_8021Q=m

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111171947.2816258-1-idosch%40nvidia.com
