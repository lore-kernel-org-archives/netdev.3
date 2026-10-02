Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFD305687
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790906638; cv=none; b=XYd6cKX53yQgqWfzjWen74C6/1Zp1yT/wV1grt6X9uJJGwSZYa/7bXBGPXzC3qn2fNaeXG25lA95FuOoXE11m4SEvsGvbCrCyXb4cqYIMrAnAuIgl/zJwN57AG/ou6rR2TnoYCp98iXt8O2pW306vt4etpMJnuYrd0DatyTsViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790906638; c=relaxed/simple;
	bh=mFAkqi7/1VJgfiYGbUUVe2iBvBd7ekIWpOXqOfIGv2E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMIEPIp2BFbgpJIodUyOYLw9TH/m7pTGOjZ3EsZt9wE8knxiPUw02Q+wbekoFBq3QMgYSW+XLRlNuMzLibh2QWLKh4BiuHfAE79Dtjxn9VdU8OAREnbqiMNd4EBvccwKAX0qkPKyu1VUw979xxGO2JaPzJF5/RCyXtzOH/eiYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo4HRir+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo4HRir+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514061F00893;
	Fri,  2 Oct 2026 02:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790906636;
	bh=PmHersQfmvypzXYJvVEiorluUNsk5lrE+6PhS6EdC4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eo4HRir+3RiSsPZvfzuZtVX/D/zvK6990r4DMLvQUtBzP4+GIbC95clYTk4v+l+6g
	 lPwQDFUALHq2sXC5Xii57q4dphse68ivk+HLmrNxfSUvriUqobJkEVlOEu328O6wFM
	 DagnIUINluvW7NNYWcsqRKYvLcOXBC/qBwLgRG5MvvZ6lousYt3Sh1WD8+KPKDjwQj
	 fvLTZi9Eki5mUdjIw1/4P+PNsoe8HZm4lLm3FgeaQRoMnnGvqrAPHDbn5S4WDbDK9W
	 UnHl7TXeVZ5z7lIypGCJe1zwzePwdrgmGEAuvcWt9y0wsEfA2m7XfLPhwm+SjNFhr1
	 xYiEnXhB06jGQ==
Subject:
 Re: [PATCH v1 net-next 7/8] ipv4: Use ipv4_neigh_lookup() and friends.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 enachman@marvell.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, petrm@nvidia.com, jiri@resnulli.us,
 ecree.xilinx@gmail.com, razor@blackwall.org
Date: Fri, 02 Oct 2026 02:03:54 +0000
Message-ID: <179090663487.434549.12882875094494506353@kernel.org>
In-Reply-To: <20260930200326.718459-8-kuniyu@google.com>
References: <20260930200326.718459-8-kuniyu@google.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mlxsw: kernel panic via NULL pointer dereference in hw neighbour
  events

Pre-existing issues:
- [Medium] In mlx5e_ipsec_init_macs()
  (drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c), the…

--

ipv4: Use ipv4_neigh_lookup() and friends.

This commit replaces open-coded neigh_lookup(), neigh_create(),
__neigh_lookup() and __neigh_lookup_errno() calls on the ARP table with
the ipv4_neigh_lookup() and ipv4_neigh_create() helpers. Callers no
longer need to fetch the netns and neigh_table themselves. It touches
several drivers as well as net/ipv4 and the bridge.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index 37a8ddee3ea1e..16edd3263aedf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c

[ ... ]

> @@ -365,10 +364,9 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
>  	return;
>  
>  neigh:
> -	tbl = arp_table(dev_net(netdev));
> -	n = neigh_lookup(tbl, pkey, netdev);
> +	n = ipv4_neigh_lookup(netdev, pkey);
>  	if (!n) {
> -		n = neigh_create(tbl, pkey, netdev);
> +		n = ipv4_neigh_create(netdev, pkey);

[Severity: Medium]
This patch didn't introduce this issue, but the new helper names make
it easier to see. Can this fallback put IPv6 keys into the ARP table?

For AF_INET6 SAs, pkey points at the 16-byte addrs->saddr.a6 or
addrs->daddr.a6. Earlier in mlx5e_ipsec_init_macs(), the IPv6 case
jumps here when CONFIG_IPV6 is disabled or the route lookup fails:

	case AF_INET6:
		if (!IS_ENABLED(CONFIG_IPV6) ||
		    ip6_dst_lookup(dev_net(netdev), NULL, &rt_dst_entry, &fl6))
			goto neigh;

The shared path also jumps here when dst_neigh_lookup() returns NULL.

ipv4_neigh_lookup() and ipv4_neigh_create() always use
arp_table(dev_net(dev)), and its key length is 4. That means the first
32 bits of the IPv6 address are treated as an IPv4 address:

- On a miss, an ARP entry for an unrelated IPv4 address is created on
  netdev, neigh_event_send() sends an ARP request for it, and
  attrs->drop is set.

- On a hit, neigh_ha_snapshot() copies the MAC of an unrelated IPv4
  neighbour into the IPv6 SA's dmac.

The old code used the ARP table here too. The patch only changes how
the table is obtained.

Should this fallback check addrs->family and use ipv6_neigh_lookup()
and ipv6_neigh_create() for AF_INET6, or skip the neighbour fallback
for IPv6?

>  		if (IS_ERR(n))
>  			return;
>  		neigh_event_send(n, NULL);

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> @@ -2432,10 +2430,9 @@ static void mlxsw_sp_router_neigh_ent_ipv4_process(struct mlxsw_sp *mlxsw_sp,
>  		return;
>  	}
>  
> -	tbl = arp_table(net);
>  	dipn = htonl(dip);
>  	dev = mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
> -	n = neigh_lookup(tbl, &dipn, dev);
> +	n = ipv4_neigh_lookup(dev, &dipn);
>  	if (!n)
>  		return;
>  

[Severity: High]
Can dev be NULL here?

mlxsw_sp_rif_dev() returns NULL when the RIF has no crif. That is the
case for the IP-in-IP underlay RIFs, which mlxsw_sp_ul_rif_create()
allocates without a crif. The only check above is that
mlxsw_sp->router->rifs[rif] is non-NULL. If the device reports
neighbour activity on such a RIF through RAUHTD, the delayed neighbour
update work reaches this point with dev == NULL.

Before this patch that case was harmless. The netns came from
mlxsw_sp_net(mlxsw_sp), not from dev, and neigh_lookup() with a NULL
dev simply matched nothing and returned NULL.

ipv4_neigh_lookup() now derives the table itself via
arp_table(dev_net(dev)). That dereferences the NULL dev, so the kernel
oopses in the router's periodic neighbour work instead of skipping the
entry. Routed IP-in-IP setups on Spectrum would hit this during
normal traffic.

The IPv6 counterpart, mlxsw_sp_router_neigh_ent_ipv6_process(),
passes the same possibly-NULL dev to ipv6_neigh_lookup(). It looks
like it has the same problem.

Should both functions return early when dev is NULL, before the
lookup? Or should the new helpers tolerate a NULL dev the way
neigh_lookup() effectively did? Checking in the callers seems simpler
and keeps the helpers strict.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930200326.718459-1-kuniyu%40google.com
