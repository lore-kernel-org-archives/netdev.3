Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9123AFAEC
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491401; cv=none; b=SogImLxit9/gVzdR2rs1Pe6hGKxYIulrHV9DvrYCzniJICfZAx3iXCxP3sEBZAndxYCBXl+IjfaE8Ntf0Xx1oXI4Z5feryu3e0oqvEHhwrCxvhsg57NiF1wt6hZZoS2olndmpvrzgMc7PSzFme4KmG9gKp/h4R7kLp5DM7LpWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491401; c=relaxed/simple;
	bh=npZoKiIo3s1xll7zET7XhyIlcWGVg4Ig5f5OgaLvEc0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeLS7IC3h8HHGCcxNvJaD9FAjGQ8LjHy7ajOzJaAyUyo01M8n0zCQpKyTnir9eZyjPusCItOH3O/VEf6WdhvaF8FC+4XFpEJFi9GyaulnTIwEE5HcpPS05yP3P87T+mso1gRCq9j8haWft9L1ei/ATemmpAiUxHi0JCztELZTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE4lrTWM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE4lrTWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44581F00A3F;
	Fri,  4 Sep 2026 03:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491399;
	bh=b+G1SfPmb8yBzkoVoo5I47OTpDhYkb78NIEEPtf71GY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AE4lrTWMgF4U6VRiRoioEwome1ljOBAds2WomgrSTiK8UESD5ru/7xzG4st2L4fNp
	 uJj5sdJ2MedeRMMxm75FDdl0EWcyUw95T+Rbj/iMgK+CNdCaY32LoOC6p81INQzHxq
	 YXE3af9Q3iebOJS0Fkog+bNBs4XSRM5NVLclJCfNehUb11smA/Svp4huxHoAnKW8u9
	 p60ZJVrr1oi/eY+7xodXdzOtkGCedCOSQjCklWdY+z7+zo9eNZD/SOA4GaoKZqKzrP
	 DJ/xZ7+XgjW2hsRrD/ZXGqY/7g14+4Vm89mWa7hh/zwBprsq/VSd37eTfHEGW0IgJc
	 Cxz0ec/lr7n9A==
Subject:
 Re: [PATCH v6 net-next 08/15] ipv4: Replace &arp_tbl with arp_table(net).
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 razor@blackwall.org
Date: Fri, 04 Sep 2026 03:09:58 +0000
Message-ID: <178849139822.4131868.12725598676678725342@kernel.org>
In-Reply-To: <20260902203722.926528-9-kuniyu@google.com>
References: <20260902203722.926528-9-kuniyu@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 2

- [High] mlx5e_tc_update_neigh_used_value()
  (drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c) now…
- [Low] Documentation/networking/switchdev.rst still instructs switchdev
  driver authors to resolve nexthops against, and monitor updates to,…
- [Low] The patch introduces new reads of the RCU-protected netns pointer
  dev->nd_net via the non-RCU accessor dev_net() in paths that run only…

Pre-existing issues:
- [Medium] The neighbour fallback path in mlx5e_ipsec_init_macs()
  (drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c, label…

--

ipv4: Replace &arp_tbl with arp_table(net).

In preparation for per-netns neighbour tables, this converts all users of
the global arp_tbl to the arp_table(net) accessor, makes arp_tbl static in
net/ipv4/arp.c and drops its EXPORT_SYMBOL. It also removes some driver
checks that compared n->tbl against &arp_tbl and &nd_tbl.

A few questions below.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> index 8b827201935e..33737a29ab97 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> @@ -393,20 +393,10 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
>  	struct mlx5e_encap_entry *e = NULL;
>  	struct mlx5e_tc_flow *flow;
>  	struct mlx5_fc *counter;
> -	struct neigh_table *tbl;
>  	bool neigh_used = false;
>  	struct neighbour *n;
>  	u64 lastuse;
>  
> -	if (m_neigh->family == AF_INET)
> -		tbl = &arp_tbl;
> -#if IS_ENABLED(CONFIG_IPV6)
> -	else if (m_neigh->family == AF_INET6)
> -		tbl = &nd_tbl;
> -#endif
> -	else
> -		return;
> -
>  	/* mlx5e_get_next_valid_encap() releases previous encap before returning
>  	 * next one.
>  	 */
> @@ -447,12 +437,23 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
>  	trace_mlx5e_tc_update_neigh_used_value(nhe, neigh_used);
>  
>  	if (neigh_used) {
> +		struct net_device *dev = READ_ONCE(nhe->neigh_dev);
> +		struct net *net = dev_net(dev);
> +		struct neigh_table *tbl;

[Severity: High]
Is nhe->neigh_dev safe to dereference here?  As far as I can tell no
reference is taken on it.  It is only stored:

drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c:mlx5e_rep_neigh_entry_create() {
	...
	WRITE_ONCE((*nhe)->neigh_dev, neigh_dev);
	...
}

and there is no netdev_hold()/dev_hold() for it anywhere, and no
NETDEV_UNREGISTER handling in the mlx5 rep neigh code that would clear it.

The rest of the driver only ever compares the field, never dereferences it:

drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c:mlx5e_rep_neigh_update() {
	...
	same_dev = READ_ONCE(nhe->neigh_dev) == n->dev;
	...
}

Before this patch the pointer was only handed to neigh_lookup(), which
never loads from the netdev (arp_hashfn() uses hash32_ptr(dev) and the
lookup only compares n->dev == dev), so a stale pointer was harmless.
Now dev_net(dev) reads dev->nd_net and the result is dereferenced again by
arp_table(net) as net->neigh_tables[NEIGH_ARP_TABLE].

If the cached route egress device (for example a vlan or bond on top of the
uplink) was unregistered and freed while the nhe is still alive, does this
read freed memory and then index a garbage struct net?  The reachable path
is the periodic work:

drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c:mlx5e_rep_neigh_stats_work() {
	...
	while ((nhe = mlx5e_get_next_nhe(rpriv, nhe)) != NULL)
		mlx5e_tc_update_neigh_used_value(nhe);
	...
}

and rtnl_lock() held there does not keep an already-unregistered netdev
alive, since free_netdev() runs from netdev_run_todo() after rtnl_unlock().

Also, note 3 in the changelog says:

  "3. mlx5e_tc_update_neigh_used_value() dereferences nhe->neigh_dev
      in trace_mlx5e_tc_update_neigh_used_value()."

Does that justification hold?  The tracepoint dereference lives in
TP_fast_assign():

drivers/net/ethernet/mellanox/mlx5/core/diag/en_tc_tracepoint.h:
	TP_STRUCT__entry(__string(devname, nhe->neigh_dev->name)

which only runs when the tracepoint is enabled, so it does not show the
pointer is safe to dereference unconditionally.

Would deriving the netns from a refcounted device such as e->out_dev or
priv->netdev work instead?

>  		nhe->reported_lastuse = jiffies;
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +		if (m_neigh->family != AF_INET)
> +			tbl = &nd_tbl;
> +		else
> +#endif
> +			tbl = arp_table(net);
> +
>  		/* find the relevant neigh according to the cached device and
>  		 * dst ip pair
>  		 */
> -		n = neigh_lookup(tbl, &m_neigh->dst_ip, READ_ONCE(nhe->neigh_dev));
> +		n = neigh_lookup(tbl, &m_neigh->dst_ip, dev);
>  		if (!n)
>  			return;
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index db260e3d1412..37a8ddee3ea1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -364,9 +365,10 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
>  	return;
>  
>  neigh:
> -	n = neigh_lookup(&arp_tbl, pkey, netdev);
> +	tbl = arp_table(dev_net(netdev));
> +	n = neigh_lookup(tbl, pkey, netdev);
>  	if (!n) {
> -		n = neigh_create(&arp_tbl, pkey, netdev);
> +		n = neigh_create(tbl, pkey, netdev);
>  		if (IS_ERR(n))
>  			return;
>  		neigh_event_send(n, NULL);

[Severity: Medium]
This isn't a bug introduced by this patch, since the pre-patch code already
used &arp_tbl unconditionally here, but should this fallback pick the table
based on addrs->family?

The AF_INET6 branch above can reach this label with a 16-byte key:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:mlx5e_ipsec_init_macs() {
	...
			pkey = &addrs->saddr.a6;
	...
	case AF_INET6:
		if (!IS_ENABLED(CONFIG_IPV6) ||
		    ip6_dst_lookup(dev_net(netdev), NULL, &rt_dst_entry, &fl6))
			goto neigh;
	...
}

and the ARP table has .family = AF_INET and .key_len = 4, so the lookup
hashes and compares only the first 4 bytes of the IPv6 address.  Can
neigh_create() then install a bogus ARP entry and send an ARP request for
an address made from those 4 bytes, leaving the IPv6 packet-offload SA with
attrs->drop set or an unrelated MAC?  A separate fix using the netns ND
table for AF_INET6 seems needed.

> diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> index ca30702f8878..551db6417405 100644
> --- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> +++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> @@ -235,7 +236,8 @@ void nfp_tunnel_keep_alive(struct nfp_app *app, struct sk_buff *skb)
>  		if (!netdev)
>  			continue;
>  
> -		n = neigh_lookup(&arp_tbl, &ipv4_addr, netdev);
> +		tbl = arp_table(dev_net(netdev));
> +		n = neigh_lookup(tbl, &ipv4_addr, netdev);
>  		if (!n)
>  			continue;
>  

[ ... ]

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 459f19f7071e..03e932744e3e 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1841,11 +1841,12 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
>  
>  static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
>  {
> +	struct neigh_table *tbl = arp_table(dev_net(dev));
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
> +	struct neighbour *n;
>  	struct arphdr *parp;
>  	u8 *arpptr, *sha;
>  	__be32 sip, tip;
> -	struct neighbour *n;

[ ... ]

> diff --git a/include/net/arp.h b/include/net/arp.h
> index f8d18b1f8b28..e932def63d62 100644
> --- a/include/net/arp.h
> +++ b/include/net/arp.h
> @@ -7,8 +7,6 @@
>  #include <linux/hash.h>
>  #include <net/neighbour.h>
>  
> -extern struct neigh_table arp_tbl;
> -
>  static inline struct neigh_table *arp_table(struct net *net)
>  {
>  	return net->neigh_tables[NEIGH_ARP_TABLE];
> @@ -25,10 +23,12 @@ static inline u32 arp_hashfn(const void *pkey, const struct net_device *dev, u32
>  #ifdef CONFIG_INET
>  static inline struct neighbour *__ipv4_neigh_lookup_noref(struct net_device *dev, u32 key)
>  {
> +	struct neigh_table *tbl = arp_table(dev_net(dev));
> +
>  	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
>  		key = INADDR_ANY;
>  
> -	return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn, &key, dev);
> +	return ___neigh_lookup_noref(tbl, neigh_key_eq32, arp_hashfn, &key, dev);
>  }

[Severity: Low]
Should these new netns reads use dev_net_rcu() instead of dev_net()?

possible_net_t holds a struct net __rcu *net published with
rcu_assign_pointer() via write_pnet(), and the two accessors differ:

include/net/net_namespace.h:
	static inline struct net *read_pnet(const possible_net_t *pnet)
	{
		return rcu_dereference_protected(pnet->net, true);
	}
	...
	static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
	{
		return rcu_dereference(pnet->net);
	}

dev_net() goes through read_pnet(), which asserts unconditionally that the
caller holds RTNL or a device reference, so it silently turns off
lockdep/sparse RCU checking on these new dereferences.

The sites added by this patch that run under rcu_read_lock() only are
__ipv4_neigh_lookup_noref() and ip_neigh_gw4() (reached from
ip_finish_output2()), br_do_proxy_suppress_arp(), the vxlan
arp_reduce()/route_shortcircuit() xmit paths, and nfp_tunnel_keep_alive(),
which is called inside its own rcu_read_lock().  None of them held RTNL or
a netns reference before, and none of them read dev->nd_net at all before
this patch.

The dev_net() uses in inetdev_init(), inetdev_destroy() and arp_ifdown()
look fine since RTNL is held there.

> diff --git a/include/net/route.h b/include/net/route.h
> index 45290177a33c..6b55de2e4df8 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -405,8 +405,11 @@ static inline struct neighbour *ip_neigh_gw4(struct net_device *dev,
>  	struct neighbour *neigh;
>  
>  	neigh = __ipv4_neigh_lookup_noref(dev, (__force u32)daddr);
> -	if (unlikely(!neigh))
> -		neigh = __neigh_create(&arp_tbl, &daddr, dev, false);
> +	if (unlikely(!neigh)) {
> +		struct neigh_table *tbl = arp_table(dev_net(dev));
> +
> +		neigh = __neigh_create(tbl, &daddr, dev, false);
> +	}
>  
>  	return neigh;
>  }
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 87a40e2f1c50..92a3abb1e357 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -193,7 +193,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  		return;
>  	}
>  
> -	n = neigh_lookup(&arp_tbl, &tip, vlandev);
> +	n = neigh_lookup(arp_table(dev_net(vlandev)), &tip, vlandev);
>  	if (n) {
>  		struct net_bridge_fdb_entry *f;
>  		u8 ha[ETH_ALEN] __aligned(2);
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 824c65c70408..a44fa68fdd07 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -149,7 +149,7 @@ static const struct neigh_ops arp_direct_ops = {
>  	.connected_output =	neigh_direct_output,
>  };
>  
> -struct neigh_table arp_tbl = {
> +static struct neigh_table arp_tbl = {
>  	.family		= AF_INET,
>  	.key_len	= 4,
>  	.protocol	= cpu_to_be16(ETH_P_IP),
> @@ -182,7 +182,6 @@ struct neigh_table arp_tbl = {
>  	.gc_thresh2	= 512,
>  	.gc_thresh3	= 1024,
>  };
> -EXPORT_SYMBOL(arp_tbl);

[Severity: Low]
Should Documentation/networking/switchdev.rst be updated in this patch too?

Its Nexthop Resolution section still tells switchdev driver authors to use
the symbol that becomes file-local here, in four places:

  "address discovery comes via the ARP (or ND) process and is available via
   the arp_tbl neighbor table."

  "The driver can monitor for updates to arp_tbl using the netevent notifier
   NETEVENT_NEIGH_UPDATE. ... The driver implements ndo_neigh_destroy to know
   when arp_tbl neighbor entries are purged from the port."

At this commit, git grep arp_tbl matches only net/ipv4/arp.c and
Documentation/networking/switchdev.rst, and the doc points at rocker as the
reference implementation while rocker itself is converted to
arp_table(&init_net) here.  The doc also never mentions arp_table(net) or
the new requirement to pick the table belonging to the device's netns (or
init_net for netns-immutable devices).  The text is still unchanged at the
end of the series (d4be111038a59be6217f9b018ec033041ab7bf2a).

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902203722.926528-1-kuniyu%40google.com
