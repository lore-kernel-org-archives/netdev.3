Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E90390214
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491400; cv=none; b=oFM/rPDD0UXEevB5q8W7tuojWySvuA6FMrm9DBLe94yCKaSYmsbaRk17FFWOF9NJFzZmJtvA6jq5E/pRraGDMfXmAFS61X2pjIHEaYigd6ApWIw+CM8HU1uEtM3JeALEdhmZtEmrd9CSc/XG2KBWIKQ0eV+FYmjT9Tyts8ftTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491400; c=relaxed/simple;
	bh=CKwECb5ko/H/fgxxCm8jSVsdrBlh9b79dau5Nu94Pts=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QCRZV5/xOkmv0sjv0TzaMe06jUUp9IDfbRIjFIHafQ+W8qh1+k5YkLx3/073Ul2mk2tjdUBbOunYffmMH+MvATkbDX1GlB0bFQNKiWKiAdp/HiVpIOLGQAR84t23N4SFIbSoxZDZJxBvEsoBhfcf2AvWDkWHaj3D1+WtbFZco6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU9o8Yc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU9o8Yc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615BB1F00A3E;
	Fri,  4 Sep 2026 03:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491398;
	bh=1PBl3kG2LCI+Yx+ktTBOpnHkLp8lCUgS3UJ7PKZXOdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZU9o8Yc/Jmdw4Oruuk3aoWQhQpKhUNkKT3SGuuK5Nlq3uzKVHRRyXBeYLv5qQMW9p
	 p57wfKXTOQZIuQGX88x+jsxdNZ/gxCrnv2aQeAnn/UBevSgvjJZxVtgF2auyzRX4d9
	 jtStP8QL36/xE0AjNLsahxkBRtegKXDxrYh+UKgSV46TAG0Ex8ksCIfcUvmC5RxB//
	 0JajHDIaa+7z0IaHvlT69mqaG0beG4oPcv4qLK9nj/rPoZ9xxhow9NGjYTwuwWEhLs
	 whCz6brJ63r7OeOrIpSBoWreLo7R0jf9h/XZtWCmk700ER4OUJEJ60I5UHSYXI6ypX
	 JdYK1BwwRikGQ==
Subject: Re: [PATCH v6 net-next 06/15] neighbour: Store arp_tbl and nd_tbl in
 net->neigh_tables[].
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 razor@blackwall.org
Date: Fri, 04 Sep 2026 03:09:56 +0000
Message-ID: <178849139693.4131868.6063380912219450302@kernel.org>
In-Reply-To: <20260902203722.926528-7-kuniyu@google.com>
References: <20260902203722.926528-7-kuniyu@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 0 · Low: 1

- [Low] Commit message rationale for the new `#ifdef CONFIG_PROC_FS`
  guard in arp_net_init() is factually wrong.

Pre-existing issues:
- [High] Concern (verified RESOLVED later in this series): at this
  commit, ndisc_init() (net/ipv6/ndisc.c:2015-2041) calls…

--

neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].

This adds a per-netns neigh_tables[] array to struct net along with
neigh_table_register()/neigh_table_unregister() helpers, and stores
&arp_tbl and &nd_tbl there from arp_net_init() and ndisc_net_init() as
preparation for making neigh_table per-netns.  New arp_table(net) and
nd_table(net) accessors are added.

The commit message says:

    proc_create_net() is guarded with CONFIG_PROC_FS because it
    returns NULL when =n and setup_net() fails and panic()s.

[Severity: Low]
Is the panic() part of this description accurate?

arp_net_ops is registered from arp_init():

net/ipv4/arp.c:arp_init() {
	neigh_table_init(NEIGH_ARP_TABLE, &arp_tbl);

	dev_add_pack(&arp_packet_type);
	register_pernet_subsys(&arp_net_ops);
	...
}

arp_init() runs from inet_init() (fs_initcall), while the only setup_net()
call that panics is setup_net(&init_net) in net_ns_init(), which is a
pure_initcall and has already completed by then.  For an ops registered
later, a failing ->init is handled in __register_pernet_operations():

	error = ops_init(ops, net); /* on failure the ops are undone and the error returned */

and arp_init() is void, so that -ENOMEM is silently discarded.

Wouldn't the actual consequence on CONFIG_PROC_FS=n be that arp_net_ops
never gets registered, so net->neigh_tables[NEIGH_ARP_TABLE] stays NULL in
every netns, which would then break arp_table(net) once the follow-up
patches convert the ARP users over?  Could the changelog describe that
instead?

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index caa52bf64a2d..286acb7cd504 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1899,6 +1899,18 @@ int neigh_table_clear(int index, struct neigh_table *tbl)
>  	return 0;
>  }
>  
> +int neigh_table_register(struct net *net, struct neigh_table *tbl, int index)
> +{
> +	net->neigh_tables[index] = tbl;
> +
> +	return 0;
> +}
> +
> +void neigh_table_unregister(struct net *net, int index)
> +{
> +	net->neigh_tables[index] = NULL;
> +}
> +
>  static struct neigh_table *neigh_find_table(int family)
>  {
>  	struct neigh_table *tbl = NULL;
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index d409f606aec0..bad17d5aeafc 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -1495,15 +1495,34 @@ static const struct seq_operations arp_seq_ops = {
>  
>  static int __net_init arp_net_init(struct net *net)
>  {
> +	int err;
> +
> +	err = neigh_table_register(net, &arp_tbl, NEIGH_ARP_TABLE);
> +	if (err)
> +		goto err;
> +
> +#ifdef CONFIG_PROC_FS
>  	if (!proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
> -			sizeof(struct neigh_seq_state)))
> -		return -ENOMEM;
> +			     sizeof(struct neigh_seq_state))) {
> +		err = -ENOMEM;
> +		goto err_proc_create;
> +	}
> +#endif
> +
>  	return 0;
> +
> +#ifdef CONFIG_PROC_FS
> +err_proc_create:
> +	neigh_table_unregister(net, NEIGH_ARP_TABLE);
> +#endif
> +err:
> +	return err;
>  }

[ ... ]

> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 75515fd99383..dc4c083fe27a 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1974,12 +1974,16 @@ static int __net_init ndisc_net_init(struct net *net)
>  	struct sock *sk;
>  	int err;
>  
> +	err = neigh_table_register(net, &nd_tbl, NEIGH_ND_TABLE);
> +	if (err)
> +		goto err;
> +
>  	err = inet_ctl_sock_create(&sk, PF_INET6,
>  				   SOCK_RAW, IPPROTO_ICMPV6, net);
>  	if (err < 0) {
>  		net_err_ratelimited("NDISC: Failed to initialize the control socket (err %d)\n",
>  				    err);
> -		return err;
> +		goto err_sock_create;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while unwinding is being
added here, does the neighbour table in ndisc_init() still leak on the
sysctl failure path?

net/ipv6/ndisc.c:ndisc_init() {
	neigh_table_init(NEIGH_ND_TABLE, &nd_tbl);

#ifdef CONFIG_SYSCTL
	err = neigh_sysctl_register(NULL, &nd_tbl.parms,
				    ndisc_ifinfo_sysctl_change);
	if (err)
		goto out_unregister_pernet;
out:
#endif
	return err;

#ifdef CONFIG_SYSCTL
out_unregister_pernet:
	unregister_pernet_subsys(&ndisc_net_ops);
	goto out;
#endif
}

If neigh_sysctl_register() returns -ENOBUFS (kmemdup or
register_net_sysctl_sz() failure), only the pernet ops are unregistered and
neigh_table_clear(NEIGH_ND_TABLE, &nd_tbl) is never called, so nd_tbl->stats,
nd_tbl->nht, nd_tbl->phash_buckets and the /proc/net/stat/ndisc_cache entry
stay around.

neigh_table_init() also leaves work queued and the proxy timer armed on the
abandoned table:

net/core/neighbour.c:neigh_table_init() {
	INIT_DEFERRABLE_WORK(&tbl->gc_work, neigh_periodic_work);
	queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
			tbl->parms.reachable_time);
	INIT_DEFERRABLE_WORK(&tbl->managed_work, neigh_managed_work);
	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work, 0);
	...
}

inet6_init() jumps to ndisc_fail on ndisc_init() failure and never calls
ndisc_cleanup(), so nothing balances the initialised table.

This does get resolved later in the same series: after "neighbour:
Namespacify neigh_tables." ndisc_init() becomes just
register_pernet_subsys(&ndisc_net_ops), and both neigh_table_register() and
neigh_sysctl_register() move into ndisc_net_init() with full unwinding
through neigh_sysctl_unregister() and neigh_table_unregister().  Noting it
here only for completeness.

>  	net->ipv6.ndisc_sk = sk;
> @@ -1990,11 +1994,17 @@ static int __net_init ndisc_net_init(struct net *net)
>  	inet6_clear_bit(MC6_LOOP, sk);
>  
>  	return 0;
> +
> +err_sock_create:
> +	neigh_table_unregister(net, NEIGH_ND_TABLE);
> +err:
> +	return err;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902203722.926528-1-kuniyu%40google.com
