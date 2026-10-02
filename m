Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1B48C3E8;
	Fri,  2 Oct 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937149; cv=none; b=uy59BpGv3a3b+Z5FHEVHVKxcB1tcI1cU0Ox8/lBrwCPK0+4rJfGvf51Pef1TzwdpayRZX8KfbPM3MuCJaKKIwOv3SoYDyJOlsjplUHnUyHuXxkAoASXAhX4lzX0kkZbbNHEwNOfyd5a+ywtZgJ5bDExos4mFU8EYUpAGVz/OoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937149; c=relaxed/simple;
	bh=1p+NK3yKjx4htNUmjuDzaw9ENtiJ6sgC3GaWoajhkz8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DX2fWHGh42wb+AN147rrgSopt2Y550AQQOWjGo7bGgyGGSLuBkGsiRLy2JhItLAIwfH+BnepBp5e2rGpKl3SMwNomEYt/JrI73kTByjg0qixPuqhAVVt5a18Uw5+Nicx+4hAaQef6e5nOgkMZkr6f6tLNgysGkWMqU+dMJd7zSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCcEZPPT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCcEZPPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9A91F00893;
	Fri,  2 Oct 2026 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937147;
	bh=5zOSIf4i9mTx8BxAb/WT9K9ZXz8AefiFx+2rmrYrKbk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XCcEZPPTkGmA9s1e8SCmHcRzYOKxBxS47EvpMjyPVtLclCjmoJ5BiiwQYtnWCq6Am
	 O+xtyxYzkDCDWoACPO0PyiTG+s8r3/hPNrbmSx37keDkMr+YiG//viIHecQ9CFJGvs
	 6WbcCIDl60KA+PuWDh1ScWsw4CsIlhsPiRu95DyAfzzFNKpxCDjw8s5FcauHLbUre6
	 I2z21FsuDll8QbLA2ZrxvDLeuXzqz0ny2XCQ1q4r9DDoPqOwTkjYVrH3B84G0Zk4Zk
	 2z0AM1lSaOIii7Fl4/8oI4TNshr1VELGHd65WFWxOClK7xN3fDBcS858elpxMzwiqf
	 Wm+HVt5miJmRQ==
Subject: Re: [PATCH 11/16 net-next v2] ipv4: disable IPv4-only sysctls when
 CONFIG_IPV4=n
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:26 +0000
Message-ID: <179093714642.434549.8365340209471178412@kernel.org>
In-Reply-To: <20260928193046.6698-12-fmancera@suse.de>
References: <20260928193046.6698-12-fmancera@suse.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch moves the `fib_multipath_hash_seed` entry of
  `ipv4_net_table` (net/ipv4/sysctl_net_ipv4.c:1644-1650) into the new…

--

ipv4: disable IPv4-only sysctls when CONFIG_IPV4=n

This commit moves the IPv4-only entries of ipv4_net_table into a new
IS_ENABLED(CONFIG_IPV4) block, so they are not registered when IPv4
support is compiled out. The handlers and limit variables that are now
only used conditionally are marked __maybe_unused.

> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 0e7fef5973db6..6096e9e4d82d8 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c

[ ... ]

> @@ -492,9 +493,9 @@ static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
>  	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_seed);
>  }
>  
> -static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
> -					void *buffer, size_t *lenp,
> -					loff_t *ppos)
> +static int __maybe_unused
> +proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
> +			     void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct sysctl_fib_multipath_hash_seed *mphs;
>  	struct net *net = table->data;

[ ... ]

> @@ -1656,6 +1469,196 @@ static const struct ctl_table ipv4_net_table[] = {
>  		.extra1		= SYSCTL_ONE_THOUSAND,
>  		.extra2		= &tcp_rto_max_max,
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
> +	{
> +		.procname	= "icmp_echo_ignore_all",

[ ... ]

> +#ifdef CONFIG_IP_ROUTE_MULTIPATH
> +	{
> +		.procname	= "fib_multipath_use_neigh",

[ ... ]

> +	{
> +		.procname	= "fib_multipath_hash_seed",
> +		.data		= &init_net,
> +		.maxlen		= sizeof(u32),
> +		.mode		= 0644,
> +		.proc_handler	= proc_fib_multipath_hash_seed,
> +	},
> +#endif

[Severity: Medium]
Is fib_multipath_hash_seed really an IPv4-only sysctl?

The seed is read by the shared helper fib_multipath_hash_from_keys(),
which is gated only by CONFIG_IP_ROUTE_MULTIPATH:

include/net/ip_fib.h:fib_multipath_hash_from_keys() {
    ...
	mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed);
	fib_multipath_hash_construct_key(&hash_key, mp_seed);
    ...
}

The IPv6 datapath calls this helper for every multipath hash, through
rt6_multipath_hash() in net/ipv6/route.c.

net/ipv6/sysctl_net_ipv6.c has its own fib_multipath_hash_policy and
fib_multipath_hash_fields, but it has no seed knob. That makes this entry
the only way to set the seed for either family.
Documentation/networking/ip-sysctl.rst describes it the same way:

    The seed value used when calculating hash for multipath routes. Applies
    to both IPv4 and IPv6 datapath. Only present for kernels built with
    CONFIG_IP_ROUTE_MULTIPATH enabled.

CONFIG_IP_ROUTE_MULTIPATH depends only on IP_ADVANCED_ROUTER, not on
IPV4. After "ipv4: make CONFIG_IPV4 boolean" later in the series,
CONFIG_IPV4 can be disabled when IPV6 is enabled. At the end of the
series this entry is still inside the CONFIG_IPV4 block.

Take a kernel built with CONFIG_IPV4=n, CONFIG_IPV6=y and
CONFIG_IP_ROUTE_MULTIPATH=y. ipv4_sysctl_init_net() still calls
proc_fib_multipath_hash_set_seed(net, 0), so IPv6 ECMP keeps hashing with
the random seed picked at boot. However,
/proc/sys/net/ipv4/fib_multipath_hash_seed no longer exists, so the seed
cannot be set to a fixed value. mlxsw programs its hardware ECMP seed from
user_seed, so it would also always see 0.

Could the fib_multipath_hash_seed entry and proc_fib_multipath_hash_seed()
stay outside the CONFIG_IPV4 block, under CONFIG_IP_ROUTE_MULTIPATH? That
would match how icmp_echo_enable_probe, icmp_msgs_per_sec and
ip_early_demux were left in place. fib_multipath_use_neigh,
fib_multipath_hash_policy and fib_multipath_hash_fields do look IPv4-only
and could stay inside the block.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
