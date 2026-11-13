Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553289;
	b=GZaYgUNSFnrXooCmWuNIYerwUctBDyqPAQhJuuuyp4RLTXDEXfZqZpna/8vqDg0DPzXs
	 HslKHjWhRBHP4w/MSDherAb/3Kt+5+9ZTFaZX3JN4LY6b9pRFyiLDpZSIl2vs3dAY5Rfe
	 vAeb7SF+4w3jB+Sl5TGUQPZPAPrFFN4CWNbWAQymewy307FX7YmZfHYB7xyCqfd2GmjSM
	 qKoFe6HFco5tZUMH6/+bfZdv6ruHtngxxeA+3Z54zi1hvMPqkC6QCCDWFw5MFvL1mutTH
	 dymmDPS/NuOjWMzWfb8WR+eb2nRdm6uom9haVGTze/cb0iXND/zdfnOWRjaeUq/9S3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553289;
	h=DMARC-Filter:Received:Received:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=FX15yL1d6k2xYFvbHMD/Yim2NO+Keql5IqWi6DbNGJM=;
	b=Ndyz9QUYWZnjKLx547aZqjH8urCHp0fI5wGy+nY093L0lz0p+SBGGV6nfcIQd9Ns+z9h
	 b0teWgun/05pjtem33UrpYEPGqTSrASb2B6IE1a3c35CByxGBeq2GvzrGHB4vTo5fWwrD
	 nx7yN3QT5Houwj1L1mTXjkYdlmX89xgRBZSEHR04rRcN3cdBeXXKE1jqy4OfknpeDU9dt
	 zO720hzq0ChIVfbBAMSGs7eZk8COQeTQWGKgZ1jK9XlDPMhTV2wRXo7LOf6T2lpyBk8Cv
	 Qe9QfTGSmhd44uNseAovf/S7kZY+Fhq/rx9sdUzYR0CM/TpFA/l0LceuBxlaAaqKZ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=idosch.org;
	spf=none smtp.mailfrom=idosch.org;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AaZLRAW0;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2A606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E2A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AaZLRAW0
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DAAE1D0029D;
	Fri, 13 Nov 2026 02:01:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Nov 2026 02:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794553287; x=
	1794639687; bh=FX15yL1d6k2xYFvbHMD/Yim2NO+Keql5IqWi6DbNGJM=; b=A
	aZLRAW0vjXahAMvhpuZrDzMBGRTLQ/HsP0R+pkLlX9f2e1WhedV1WZPcZz0c9Fe4
	yhnN1bspW696TEQj+ugmvKCTsY2wTJ8AizjKvbgdXmwhfKwfvunD5IZi9x1dGyrD
	YXXiB9tWtm9xvy5AaKhOltn7DDKVnfjuQfJF9hKZJ6yyXDzJrc5QNpx0X9PQiRqS
	1/M90I14BL/2K3tTbHL4AG2mOXgzN+ZgCRGCJrYMe4F+k5EoVpOihRKge15e7obZ
	1wP7VFabY32z0GMldqM7r33Jmk4kp6AmdO5xsghMOjPDZfWy5rJ/ashLchlBWS30
	+E68nC2WrJ2FX4Pe44W6Q==
X-ME-Sender: <xms:xrX2alJmMpF6CDw4Tk9p2Mo8Ferf87J5JTH9RnqUkjdlbCRCoqAPmQ>
    <xme:xrX2apVNbUzmmvkCYcsAPHQu1imylYZlpnUxE3Zh04_0Np2iK5rhckr5RkLWHpRmW
    8zH04REL0svikOGUOxTlPPvkOTh0guPYvpZZV94WW7oFwVgrGg>
X-ME-Received: <xmr:xrX2apSoFANdU8QvJiOhGap2TkMXJsehDsZV_iDwFLoFebLJfeq-B5S_Kynp_aly48T1FWXAumb4CF8i6bGGbbXpOaMnxQ>
X-ME-Proxy-Cause: dmFkZTGgp+uMAD7ngN/Mela/jA/D+MsD19o0z4gFWrUY3BjHOYKtXVonlrpoFzLv4BHRjq
    RB9GVr1lwJuywzgn10cEXRNbACaEWfflZ0CuCyvwpIUkCVLze+vuEWg65c9kZI/Gbh15dq
    rh2K4tS8+9YTUZs8cAN7f/XQE3ijnX96943b6QBqJK7GWPJ4CZ91PyF5bHb8JcjyaoBWR3
    yOKDhM5VZ2CSVOAlIhIVpmOblEK7lcprU7OOM2lJ0F8BaDgkIwL1ZxKueaeiMgfaIDPILk
    NECUQ+OFHfpY0UzXjTpTCMJdKn8SaJo3hJgEq3asbjUT7u8nT90gcu4vo5Xw82K4BZz6Uw
    D6qXI4AvFl9wY3lbGIZqma16vhGDGWfs+wBOaL2E4uAqTjHqkxzdYg20ylTrzvXw1nfzkz
    HhDCFioq2u4puf9RLBkWHdJ98sob6zpE7AHL/HcTX0hdOkgneoKdGJAfRnAnjU6AVboUGo
    IjHxVmHov+3eaD6j+1JAZ/erekLyXQdTDBBlnU/2IE3lvhkRScfOcipz3F0Moy6M27RMZ4
    7OdAPgXFm3VSH54YHVJEr9LD8N8GHld37TW0a4BlYrDnL1PtkcKZ8FbxwDhqaxQ13qum85
    i2TUyBmTzh3PEyv7bRu/+qd+iTyuJLXnH4Igc411ESYGreb02Kn84bJWUtDQ
X-ME-Proxy: <xmx:xrX2ahBFKQLbv4Qshx1siIyip99q0SxwTrKbL2AvAgTMFIN4MVjNBA>
    <xmx:xrX2aoILrYHFBOx4TMtUePlgu3Vr00T0hbTUDw1hY4-BmmhhmDI6wA>
    <xmx:xrX2akCFwf2dXwxBr2qwEHlvqubaI9RqFncyzV-1y06U_a0wYbukHg>
    <xmx:xrX2altX6A8rMXI7YkcMHnw7nqJNseHsVFshec8bx-sKEmwiMISsmQ>
    <xmx:x7X2amwjimTVclgkp2-uL20dPPAhHsg2wffU0H0PYrlFqve6XPfG8rlm>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 02:01:26 -0500 (EST)
Date: Fri, 13 Nov 2026 09:01:24 +0200
From: Ido Schimmel <idosch@idosch.org>
To: netdev-bot+sashiko@kernel.org
Cc: idosch@nvidia.com, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
	jv@jvosburgh.net, andrew+netdev@lunn.ch, razor@blackwall.org,
	aahila@google.com
Subject: Re: [PATCH net-next 2/2] selftests: bonding: Add a test for 802.3ad
 with coupled control disabled
Message-ID: <20261113070124.GB3517282@shredder>
References: <20261111171947.2816258-2-idosch@nvidia.com>
 <179451491828.2199510.10600083511159752831@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179451491828.2199510.10600083511159752831@kernel.org>

tl;dr - I believe the patch is fine as-is.

On Thu, Nov 12, 2026 at 08:21:58PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The bonding selftest config fragment
>   (tools/testing/selftests/drivers/net/bonding/config) now asks for…
> - [Low] In bond_lacp_independent_control.sh, collecting() reads the total
>   packet count of the bond1 ingress ICMP echo-request filter (handle…
> 
> --
> 
> selftests: bonding: Add a test for 802.3ad with coupled control disabled
> 
> This adds a VRF based selftest which checks that a bond port with
> coupled_control off receives packets in COLLECTING state. It keeps the
> port in COLLECTING state by clearing the Collecting bit in received
> LACPDUs, and then checks that ping works in DISTRIBUTING state. The
> bonding selftest config fragment gains the VRF, pedit and policy routing
> options the test needs.
> 
> > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> > new file mode 100755
> > index 0000000000000..c29712e01e49e
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> 
> [ ... ]
> 
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
> 
> [ ... ]
> 
> > +collecting()
> > +{
> 
> [ ... ]
> 
> > +	ping_do bond2 192.0.2.1
> > +	pkts=$(tc_rule_handle_stats_get "dev bond1 ingress" 101)
> > +	((pkts >= PING_COUNT))
> > +	check_err $? "Packets not received in COLLECTING state"
> 
> [Severity: Low]
> Can this check pass when no packets were received in COLLECTING state?
> 
> The bond1 ingress filter with handle 101 is installed once by
> h1_create() from setup_prepare(), outside the per-test defer scopes, so
> its counter keeps growing across tests. collecting() compares the
> absolute counter with PING_COUNT and does not take a baseline before
> ping_do.
> 
> tests_run() in net/lib.sh iterates over ${TESTS:-$ALL_TESTS}. Take
> TESTS="distributing collecting" as an example:
> 
> distributing()
>     ping_do bond2 192.0.2.1    <- PING_COUNT echo requests hit filter 101
> collecting()
>     port moved to COLLECTING state
>     ping_do bond2 192.0.2.1    <- nothing received without the fix
>     pkts >= PING_COUNT         <- still true from the earlier test
> 
> The same thing happens if collecting is listed twice. The default
> ALL_TESTS order runs collecting first, so the default run is not
> affected.
> 
> Since the ping_do return value is ignored here, this counter is the only
> check of the fix. Would it make sense to read the counter before ping_do
> and check the delta, or to create the filter inside collecting() with a
> matching defer?

Noise. This is not a problem with the default test order and I don't
think it's worth handling other orders.

> 
> > +
> > +	log_test "Receive in COLLECTING state"
> > +}
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> > index b62c707152930..71c6d69d98a18 100644
> > --- a/tools/testing/selftests/drivers/net/bonding/config
> > +++ b/tools/testing/selftests/drivers/net/bonding/config
> 
> [ ... ]
> 
> > @@ -15,7 +19,9 @@ CONFIG_NETCONSOLE_DYNAMIC=y
> >  CONFIG_NETCONSOLE_EXTENDED_LOG=y
> >  CONFIG_NETDEVSIM=m
> >  CONFIG_NET_IPGRE=y
> > +CONFIG_NET_L3_MASTER_DEV=y
> >  CONFIG_NET_SCH_INGRESS=y
> > +CONFIG_NET_VRF=y
> 
> [Severity: Low]
> Should this fragment also enable CONFIG_IP_ADVANCED_ROUTER=y and
> CONFIG_IP_MULTIPLE_TABLES=y?
> 
> NET_VRF depends on IP_MULTIPLE_TABLES in drivers/net/Kconfig:
> 
> config NET_VRF
> 	tristate "Virtual Routing and Forwarding (Lite)"
> 	depends on IP_MULTIPLE_TABLES
> 	depends on NET_L3_MASTER_DEV
> 	depends on IPV6_MULTIPLE_TABLES || IPV6=n
> 
> and in net/ipv4/Kconfig, IP_MULTIPLE_TABLES depends on IP_ADVANCED_ROUTER
> and has no default:
> 
> config IP_MULTIPLE_TABLES
> 	bool "IP: policy routing"
> 	depends on IP_ADVANCED_ROUTER
> 
> The patch adds the NET_L3_MASTER_DEV and IPV6_MULTIPLE_TABLES
> dependencies but not the IPv4 ones. If the fragment is merged onto a base
> config that lacks them, Kconfig silently drops NET_VRF. arm64 defconfig
> is one example: it sets neither symbol, while x86_64_defconfig sets both.
> 
> In that case setup_prepare()->adf_vrf_prepare()->vrf_prepare() runs:
> 
> 	ip -4 rule add pref 32765 table local
> 
> which needs IPv4 policy routing, and adf_simple_if_init() cannot create
> the VRF devices. The test then fails during setup and never exercises the
> bonding change.
> 
> Several other net selftest fragments have the same gap, while
> net/mptcp/config lists IP_MULTIPLE_TABLES explicitly.

Both options are enabled by x86_64_defconfig and other config files that
enable CONFIG_NET_VRF do not list them either (e.g.,
net/forwarding/config). The test is running fine in the netdev CI.
