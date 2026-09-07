Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F140390CAD
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761490; cv=none; b=HN1XNdVOR0MWdRPyy4ErrRVDZaYePBUbpefUTNLih9HPX7G5HArKYsn/ZR0Hg70Abx1zzpCgsapNyPB9TPUv4sqjjGw783HA+GnVEC9Et5jHvQ8TcG/4epFYh5YWjSCIcYEG1epEHlrXM1jdNsQgZuRvyAK1OxsKoqqARZ9YaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761490; c=relaxed/simple;
	bh=EkieSjy7FRlRPBEDESYz+5P6FqhvnbWJxAqIHQ65C9w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W38uDlB8eYwd2WFEv0Xr8jcNmVh5vsII2bktb1cMzJbQ9ywiewPsjWH/8Fg8+1nHpOidXWeRybps4PV3AjbHnXf4EEp+FoO2bWV0MooQ6UTzBuFWFmCnAT/z9RTH6Qc62Il6x4am2UPxi54g968Ev+gdVFUwsKWIbyhMPMKcDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/FpGpEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/FpGpEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80271F00A3A;
	Mon,  7 Sep 2026 06:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761488;
	bh=RQNWnXNgkjHuxiarQT0sDoI96uVXY8NdSZPXEzZX3s4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i/FpGpEggn9vxWlPh5+V2RAXtD1+6j9Z1iOO7JSMHMj60uiCWZh0fjps7L5aIw9aj
	 +4s9t7n4AH0l0q6nHSe5fmWVSDuXpoinxc7B/YqYASS1TcQAkm2gKF6zgSBE8ZZMCa
	 R7xSUfdSWypRZ4G05vaH1iGGwvP7jRv8j2xVek1gAJaiiUL8+VHLCbh2j4BwGsWwfF
	 dCN/U97GakSX/ztCtxSGfDJabUE8vUEdnjEIJ1UTqZlapm1mzUL7XKEUWgika/GINz
	 kD7h06vvXeZxcy7hi0tIw3+FC1OtTI2Rul3QYOcTfUGmre6yR3mPcUMuKuVID08cBz
	 1cDFjvE3va4Cw==
Subject: Re: [PATCH net-next 8/9] vxlan: remove default_dst and use
 vxlan_config and lowerdev
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 07 Sep 2026 06:11:27 +0000
Message-ID: <178876148752.219967.12333318074928286446@kernel.org>
In-Reply-To: <20260903120840.1024153-9-edumazet@google.com>
References: <20260903120840.1024153-9-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 3

- [Medium] vxlan_changelink() bundles two undisclosed/untagged
  behavioural repairs into the default_dst refactor.
- [Medium] vxlan_changelink() now keys the default-FDB delete on
  cfg->remote_ifindex, which newly breaks the 'lower device detached,…
- [Low] Unrelated whitespace churn/style regression in
  vxlan_group_used(): the two socket-comparison continuation lines are…
- [Low] Undisclosed functional fix on the drop path of
  vxlan_encap_bypass().
- [Low] `struct vxlan_rdst::remote_dev` (include/net/vxlan.h:207) becomes
  dead after this patch: a tree-wide grep for…

--

vxlan: remove default_dst and use vxlan_config and lowerdev

This removes vxlan->default_dst and reads the default destination
attributes (remote_ip, remote_vni, remote_ifindex) from the RCU protected
vxlan->cfg instead.  A new vxlan->lowerdev pointer, maintained under RTNL,
takes over the upper/lower netdev adjacency tracking that
default_dst.remote_dev used to do.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index c49d55de020f..453cac5dde67 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -2303,7 +2307,14 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
>  	skb->dev = dev;
>  	__skb_pull(skb, skb_network_offset(skb));
>  
> -	if (dst_vxlan->default_dst.remote_ip.sa.sa_family == AF_INET) {
> +	rcu_read_lock();
> +	dst_cfg = rcu_dereference(dst_vxlan->cfg);
> +	if (unlikely(!dst_cfg || !(dev->flags & IFF_UP))) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
> +		goto drop;
> +	}
> +
> +	if (dst_cfg->remote_ip.sa.sa_family == AF_INET) {
>  		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>  		loopback.sa.sa_family =  AF_INET;
>  #if IS_ENABLED(CONFIG_IPV6)

[ ... ]

> @@ -2333,8 +2337,9 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
>  	} else {
>  drop:
>  		dev_dstats_rx_dropped(dev);
> -		vxlan_vnifilter_count(dst_vxlan, dst_cfg, vni, NULL,
> -				      VXLAN_VNI_STATS_RX_DROPS, 0);
> +		if (dst_cfg)
> +			vxlan_vnifilter_count(dst_vxlan, dst_cfg, vni, NULL,
> +					      VXLAN_VNI_STATS_RX_DROPS, 0);
>  	}
>  	rcu_read_unlock();
>  }

[Severity: Low]
Should this if (dst_cfg) guard live in the previous patch of the series
instead?

In the parent commit ("vxlan: convert configuration to RCU protection") the
goto drop taken when rcu_dereference(dst_vxlan->cfg) returns NULL lands on
the drop: label which calls vxlan_vnifilter_count() unconditionally, and
that helper dereferences cfg on its very first statement:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vnifilter_count() {
	if (!(cfg->flags & VXLAN_F_VNIFILTER))
		return;

So the parent commit has a NULL dereference on the same path (reachable
when vxlan_free_dev() has already done RCU_INIT_POINTER(vxlan->cfg, NULL)
while a local-bypass transmit is in flight), and this patch quietly repairs
it while only describing the default_dst removal.  Would it make sense to
move the guard into the commit that opened the NULL window so bisection
does not land on a broken intermediate commit?

[ ... ]

> @@ -3997,7 +4007,6 @@ static void vxlan_config_apply(struct net_device *dev,
>  			       bool changelink)
>  {
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
> -	struct vxlan_rdst *dst = &vxlan->default_dst;
>  	unsigned short needed_headroom = ETH_HLEN;
>  	struct vxlan_config *old_cfg;
>  	int max_mtu = ETH_MAX_MTU;
> @@ -4015,13 +4024,7 @@ static void vxlan_config_apply(struct net_device *dev,
>  		vxlan->net = src_net;
>  	}
>  
> -	dst->remote_vni = new_cfg->vni;
> -
> -	memcpy(&dst->remote_ip, &new_cfg->remote_ip, sizeof(new_cfg->remote_ip));
> -
>  	if (lowerdev) {
> -		dst->remote_ifindex = new_cfg->remote_ifindex;
> -
>  		netif_inherit_tso_max(dev, lowerdev);
>  
>  		needed_headroom = lowerdev->hard_header_len;

[Severity: Medium]
Can this change the MTU of an existing device as a side effect of an
unrelated changelink?

Before this patch, vxlan_changelink() set lowerdev to NULL whenever the
lower device was unchanged, so this if (lowerdev) block never ran on a
plain attribute update.  Now the real lowerdev is always passed in, so
netif_inherit_tso_max(), the needed_headroom/needed_tailroom recomputation
and the following clamp all run on every changelink:

	max_mtu = lowerdev->mtu - vxlan_headroom(flags);
	...
	if (dev->mtu > max_mtu)
		dev->mtu = max_mtu;

Concretely: create a vxlan over a 9000 byte lower device (vxlan mtu 8950),
then shrink the lower device to 1500.  Today the vxlan mtu stays 8950;
after this patch any unrelated changelink (for instance changing only ttl
or tos) silently drops dev->mtu to 1450.

The commit message mentions only "avoid clobbering lowerdev to NULL when
unchanged" - could it spell out this user visible consequence?

[ ... ]

> @@ -4110,7 +4111,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
>  		if (err)
>  			goto unregister;
>  
> -		dst->remote_dev = remote_dev;
> +		vxlan->lowerdev = remote_dev;
>  	}

[Severity: Low]
This was the only user of struct vxlan_rdst::remote_dev, so should that
field be dropped from include/net/vxlan.h in the same patch?

After this hunk a grep for remote_dev in drivers/net/vxlan/ finds only the
local variable in vxlan_dev_create().  FDB remotes are allocated with
kmalloc_obj() in vxlan_fdb_append() and nothing assigns remote_dev, so
every FDB remote now carries an uninitialized struct net_device * inside an
exported struct.

The commit message enumerates remote_port, offloaded, list, rcu and
dst_cache as "completely unused" - those are all still used by FDB remotes,
while remote_dev, the one field that does become dead, is kept.

[ ... ]

> @@ -4565,20 +4566,19 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (!new_cfg)
>  		return -ENOMEM;
>  
> -	if (dst->remote_dev == lowerdev)
> -		lowerdev = NULL;
> -
> -	err = netdev_adjacent_change_prepare(dst->remote_dev, lowerdev, dev,
> -					     extack);
> -	if (err) {
> -		kfree(new_cfg);
> -		return err;
> +	if (vxlan->lowerdev != lowerdev) {
> +		err = netdev_adjacent_change_prepare(vxlan->lowerdev, lowerdev,
> +						     dev, extack);
> +		if (err) {
> +			kfree(new_cfg);
> +			return err;
> +		}
>  	}
>  
> -	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
> +	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &cfg->remote_ip);
>  	change_igmp = vxlan->dev->flags & IFF_UP &&
>  		      (rem_ip_changed ||
> -		       dst->remote_ifindex != conf.remote_ifindex);
> +		       cfg->remote_ifindex != conf.remote_ifindex);

[ ... ]

> -		if (!vxlan_addr_any(&dst->remote_ip))
> +		if (!vxlan_addr_any(&cfg->remote_ip))
>  			__vxlan_fdb_delete(vxlan, all_zeros_mac,
> -					   dst->remote_ip,
> +					   cfg->remote_ip,
>  					   cfg->dst_port,
> -					   dst->remote_vni,
> -					   dst->remote_vni,
> -					   dst->remote_ifindex,
> +					   cfg->vni,
> +					   cfg->vni,
> +					   cfg->remote_ifindex,
>  					   true);
>  		spin_unlock_bh(&vxlan->hash_lock);

[Severity: Medium]
Does keying this delete on cfg->remote_ifindex leave a stale default FDB
remote behind after the lower device has been detached?

Sequence, all via changelink:

  ip link add vxlan0 type vxlan id 10 dev eth0 remote 10.0.0.1
     vxlan_dev_create() creates the all-zeros-MAC remote with
     rdst->remote_ifindex = ifindex(eth0)

  ip link set vxlan0 type vxlan nolink        (IFLA_VXLAN_LINK = 0)
     rem_ip_changed is false, so no FDB refresh happens, but the newly
     published cfg->remote_ifindex is now 0

  ip link set vxlan0 type vxlan remote 10.0.0.2
     rem_ip_changed is true, vxlan_fdb_update() with NLM_F_APPEND appends a
     second rdst, then the __vxlan_fdb_delete() above runs with
     cfg->remote_ifindex == 0

vxlan_fdb_find_rdst() requires an exact ifindex match:

	if (vxlan_addr_equal(&rd->remote_ip, ip) &&
	    rd->remote_port == port &&
	    rd->remote_vni == vni &&
	    rd->remote_ifindex == ifindex)
		return rd;

so rd is NULL, __vxlan_fdb_delete() jumps to out: and returns 0 with no
diagnostic, and the old remote 10.0.0.1 with ifindex(eth0) stays appended.
vxlan_xmit_one() picks the egress interface from rdst->remote_ifindex, so
BUM traffic keeps being replicated to the obsolete remote over the old
lower device.

In the parent commit default_dst.remote_ifindex was only written inside
if (lowerdev) in vxlan_config_apply(), so it still held ifindex(eth0) at
the third step and the delete matched.  Is this detach case expected to
keep working?

[ ... ]

> @@ -4614,30 +4615,36 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
> -	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
> -	if (lowerdev && lowerdev != dst->remote_dev)
> -		dst->remote_dev = lowerdev;
> +	if (vxlan->lowerdev != lowerdev) {
> +		if (lowerdev)
> +			netdev_adjacent_change_commit(vxlan->lowerdev, lowerdev,
> +						      dev);
> +		else
> +			netdev_upper_dev_unlink(vxlan->lowerdev, dev);
> +		vxlan->lowerdev = lowerdev;
> +	}
>  	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true);

[Severity: Medium]
Is this new netdev_upper_dev_unlink() call a fix that deserves its own
patch with a Fixes: tag?

Previously, an IFLA_VXLAN_LINK = 0 changelink ended up calling
netdev_adjacent_change_prepare() and netdev_adjacent_change_commit() with
new_dev == NULL, and both of those return immediately in that case, so the
upper/lower adjacency was left in place and default_dst.remote_ifindex
stayed stale.  That means vxlan_fill_info() kept reporting the removed
IFLA_VXLAN_LINK, and a later unregister of the no longer referenced lower
device still tore the vxlan device down via
vxlan_handle_lowerdev_unregister().

This hunk repairs both, but it is bundled into a refactor with no Fixes:
tag, so it cannot be backported on its own.  Would splitting the adjacency
repair out as a separate fix be preferable?

> diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
> index e2cf10da274f..ae0320921c8c 100644
> --- a/drivers/net/vxlan/vxlan_multicast.c
> +++ b/drivers/net/vxlan/vxlan_multicast.c

[ ... ]

> @@ -153,22 +158,22 @@ bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
>  			continue;
>  
>  		if (family == AF_INET &&
> -		    rtnl_dereference(vxlan->vn4_sock) != sock4)
> +			rtnl_dereference(vxlan->vn4_sock) != sock4)
>  			continue;
>  #if IS_ENABLED(CONFIG_IPV6)
>  		if (family == AF_INET6 &&
> -		    rtnl_dereference(vxlan->vn6_sock) != sock6)
> +			rtnl_dereference(vxlan->vn6_sock) != sock6)
>  			continue;
>  #endif

[Severity: Low]
This isn't a bug, but these two continuation lines are re-indented away
from the open parenthesis alignment (checkpatch: "Alignment should match
open parenthesis") and now read like nested statements.  Neither line has
anything to do with removing default_dst - was this intentional?

> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 7eb4f8110a84..8482954bff76 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -296,7 +296,7 @@ struct vxlan_dev {
>  #endif
>  	struct net_device *dev;
>  	struct net	  *net;		/* netns for packet i/o */
> -	struct vxlan_rdst default_dst;	/* default destination */
> +	struct net_device *lowerdev;
>  
>  	struct timer_list age_timer;
>  	spinlock_t	  hash_lock;

[Severity: Low]
With default_dst gone, struct vxlan_rdst::remote_dev in this same header no
longer has any writer or reader.  Should it be removed here too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903120840.1024153-1-edumazet%40google.com
