Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C43CEBBB
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437675; cv=none; b=qnMAeC8Rey8UMKtwbDGh1bBoB27veVN8CbnirNcujvWADLz14tUdcbpwyY2dot47V9t75hS1Jm0uGPzZQLHXa7mcAFHogdr3gjrcGKQkg6XOYLEBfMFaozjtHhEzj6gUHgIVoFJfBtLJC7corIrLj8iL9X0AaLMZIR24Hu0zgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437675; c=relaxed/simple;
	bh=GnbWK/wVnWLXY9B4VBIAXQpfzf66i4M4pfEm2vx4/oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f34n/mui9DcKRS7EWUc7Ywrf6187JhzJoa0iFHBk4UFPf+uvlWJ80Jphkm4ECF4KCKQ1sPlTtNDcInYrB4xOk60Qe83Xtp3zYJF+qG4DnhcF8Nalw7wb/+9G0ilJo0wnW/Pl9m3taLXI1GJZbyA9q5tW5LDK7imE1/izugVGvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9ZcbdB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9ZcbdB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A581F00893;
	Tue, 15 Sep 2026 02:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437672;
	bh=AdmUARNp9z3YcmQGS5/91rqAEjJ2iZLJS2EG4siqQ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f9ZcbdB70PCv57x5ag2CgWNcWV1pL8/Vg6lwjseSrOPg8vBOC2DGiobQ/4/o502Ov
	 baaBZQ7tSG2Zeoye3aVACbGaCOrIYAfod5Ot4UDql7j5nvRK/vockANg4lfmGN+Y8V
	 D+jJIgGzZn0H0YMm0dq0V1KucafxV8PavO+O+x4dVcBjoQIjgR9sdKa5I0r1vBFMzE
	 yb6mG5x6mL7nJy6ao84lDXgNTdctxnq+sSZamUzdA+tPcyTJJM3hAXkqG7mvAOEZQ8
	 BbeU7N011mNfgKhgrb4mjP6FjRwdLufDY0Kwds3oO26vf9HoFlAuDaaIue372yck0L
	 pws6wsbXDD74A==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	idosch@nvidia.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net-next 5/6] vxlan: remove default_dst and use vxlan_config and lowerdev
Date: Mon, 14 Sep 2026 19:01:11 -0700
Message-ID: <20260915020111.887368-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911062200.231316-6-edumazet@google.com>
References: <20260911062200.231316-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
vxlan: remove default_dst and use vxlan_config and lowerdev

This removes vxlan->default_dst, moving the default destination attributes
(remote_ip, remote_vni, remote_ifindex) over to the RCU-protected
vxlan->cfg, and adds a plain struct net_device *lowerdev to struct
vxlan_dev for upper/lower adjacency tracking under RTNL.  It also drops
the remote_dev field from struct vxlan_rdst and updates
mlx5e_tc_tun_get_remote_ifindex() to read remote_ifindex from vxlan->cfg.

A few questions below.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 338ecddb9542d..8b7558eac049d 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -4010,7 +4019,6 @@ static void vxlan_config_apply(struct net_device *dev,
>  			       bool changelink)
>  {
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
> -	struct vxlan_rdst *dst = &vxlan->default_dst;
>  	unsigned short needed_headroom = ETH_HLEN;
>  	struct vxlan_config *old_cfg;
>  	int max_mtu = ETH_MAX_MTU;
> @@ -4028,13 +4036,7 @@ static void vxlan_config_apply(struct net_device *dev,
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

[ ... ]

> @@ -4578,23 +4580,23 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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
> +	lowerdev_changed = vxlan->lowerdev != lowerdev;
> +	if (lowerdev_changed) {
> +		err = netdev_adjacent_change_prepare(vxlan->lowerdev, lowerdev,
> +						     dev, extack);
> +		if (err) {
> +			kfree(new_cfg);
> +			return err;
> +		}
>  	}

[Severity: Medium]
Can dropping the "lowerdev = NULL" shortcut here silently shrink the MTU of a
live vxlan device?

Previously, when the lower device was unchanged, lowerdev was set to NULL, so
vxlan_config_apply() skipped its whole "if (lowerdev)" block, max_mtu stayed at
ETH_MAX_MTU and the trailing clamp was a no-op:

	if (lowerdev) {
		...
		max_mtu = lowerdev->mtu - vxlan_headroom(flags);
		if (max_mtu < ETH_MIN_MTU)
			max_mtu = ETH_MIN_MTU;
		...
	}

	if (dev->mtu > max_mtu)
		dev->mtu = max_mtu;

Now the real lower device is always passed on changelink, so max_mtu is
recomputed every time.  vxlan_change_mtu() only validates against lowerdev->mtu
at the time of the request, and vxlan_netdevice_event() handles only
NETDEV_UNREGISTER and the udp tunnel port events, so nothing reacts to a lower
device MTU reduction:

	ip link add vxlan0 type vxlan id 10 dev eth0 dstport 4789 [mtu 1450]
	ip link set eth0 mtu 1000		# vxlan0 mtu unchanged
	ip link set dev vxlan0 type vxlan ageing 100

The last command inherits IFLA_VXLAN_LINK from the old config, so lowerdev is
non-NULL and unchanged, and dev->mtu is clamped down to
1000 - vxlan_headroom(flags).

The commit message describes passing lowerdev only as needed "to preserve
needed_headroom and needed_tailroom" and says nothing about MTU or the TSO
limits from netif_inherit_tso_max().  Was the MTU effect intended?

>  
> -	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
> +	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &cfg->remote_ip);
>  	change_igmp = vxlan->dev->flags & IFF_UP &&
>  		      (rem_ip_changed ||
> -		       dst->remote_ifindex != conf.remote_ifindex);
> +		       cfg->remote_ifindex != conf.remote_ifindex);
>  
>  	/* handle default dst entry */
> -	if (rem_ip_changed) {
> +	if (rem_ip_changed || cfg->remote_ifindex != conf.remote_ifindex) {
>  		spin_lock_bh(&vxlan->hash_lock);
>  		if (!vxlan_addr_any(&conf.remote_ip)) {
>  			err = vxlan_fdb_update(vxlan, all_zeros_mac,

[Severity: Medium]
Should this widened condition come with a Fixes: tag in a separate patch?

Before this change, a changelink that altered only the lower device
(for example "ip link set dev vxlan0 type vxlan group 239.1.1.1 dev eth1")
skipped this block because rem_ip_changed was false, while
vxlan_config_apply() updated dst->remote_ifindex.  The all-zeros-MAC rdst kept
the old ifindex, and vxlan_xmit_one() uses it as the route oif:

	ifindex = rdst->remote_ifindex;

so traffic kept leaving the old device.  The same applies to the
old_ifindex/new_ifindex plumbing added to vxlan_update_default_fdb_entry() in
vxlan_vnifilter.c.  These look like fixes of user-visible misbehaviour bundled
into a refactor, so they will not be picked up for stable.

The same is true of needed_headroom/needed_tailroom no longer being reset to
ETH_HLEN + vxlan_headroom() on changelink, which is mentioned only as an
implementation detail.

There is also an undocumented behaviour change further down in this function:
when IFLA_VXLAN_LINK is explicitly set to 0, the new "else
netdev_upper_dev_unlink(vxlan->lowerdev, dev);" branch now tears down the
old upper/lower adjacency, whereas netdev_adjacent_change_prepare() and
netdev_adjacent_change_commit() returned early for a NULL new device and the
adjacency survived.  Could that be called out in the changelog?

> @@ -4607,19 +4609,20 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  					       NTF_SELF, 0, true, extack);
>  			if (err) {
>  				spin_unlock_bh(&vxlan->hash_lock);
> -				netdev_adjacent_change_abort(dst->remote_dev,
> -							     lowerdev, dev);
> +				if (lowerdev_changed)
> +					netdev_adjacent_change_abort(vxlan->lowerdev,
> +								     lowerdev, dev);
>  				kfree(new_cfg);
>  				return err;
>  			}
>  		}
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
>  
> @@ -4627,30 +4630,39 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  		 * all vnis that were using default remote ip
>  		 */
>  		if (cfg->flags & VXLAN_F_VNIFILTER) {
> -			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
> -							 &conf.remote_ip, extack);
> +			err = vxlan_vnilist_update_group(vxlan, &cfg->remote_ip,
> +							 &conf.remote_ip,
> +							 cfg->remote_ifindex,
> +							 conf.remote_ifindex,
> +							 extack);
>  			if (err) {
> -				netdev_adjacent_change_abort(dst->remote_dev,
> -							     lowerdev, dev);
> +				if (lowerdev_changed)
> +					netdev_adjacent_change_abort(vxlan->lowerdev,
> +								     lowerdev, dev);
>  				kfree(new_cfg);
>  				return err;
>  			}
>  		}
>  	}

[Severity: Low]
Can this error path leave forwarding state half applied for an ifindex-only
change?

By the time vxlan_vnilist_update_group() runs, the default destination has
already been appended with the new remote/ifindex and the old one deleted, and
the loop in vxlan_vnilist_update_group() commits each per-VNI update in turn
and returns on the first failure without undoing the earlier ones.
vxlan_fdb_append() can fail:

	rd = kmalloc_obj(*rd, GFP_ATOMIC);
	if (rd == NULL)
		return -ENOMEM;

On that failure this branch only aborts the adjacency change and frees new_cfg,
so vxlan_config_apply() is never reached: vxlan->cfg and vxlan->lowerdev keep
the old values while the default fdb entry and some per-VNI entries already
carry the requested ifindex.  The rdsts allocated for the ifindex that was
never committed stay linked until explicit fdb or device teardown.  The
append-then-delete rollback gap already existed for remote-IP changes, but
ifindex-only changes are newly routed through it.

>  
> -	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
> +	if (change_igmp && vxlan_addr_multicast(&cfg->remote_ip))
>  		err = vxlan_multicast_leave(vxlan);
>  
>  	if (netif_running(dev) && conf.age_interval != cfg->age_interval)
>  		mod_timer(&vxlan->age_timer, jiffies);
>  
> -	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
> -	if (lowerdev && lowerdev != dst->remote_dev)
> -		dst->remote_dev = lowerdev;
> +	if (lowerdev_changed) {
> +		if (lowerdev)
> +			netdev_adjacent_change_commit(vxlan->lowerdev, lowerdev,
> +						      dev);
> +		else
> +			netdev_upper_dev_unlink(vxlan->lowerdev, dev);
> +		vxlan->lowerdev = lowerdev;
> +	}
>  	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true);

[ ... ]

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 6a2d0a69d7be1..55a07c20e7649 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -487,24 +487,31 @@ static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
>  };
>  
>  static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
> -					  union vxlan_addr *old_remote_ip,
> -					  union vxlan_addr *remote_ip,
> +					  const union vxlan_addr *old_remote_ip,
> +					  const union vxlan_addr *remote_ip,
> +					  u32 old_ifindex, u32 new_ifindex,
>  					  struct netlink_ext_ack *extack)
>  {
>  	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
> -	struct vxlan_rdst *dst = &vxlan->default_dst;
>  	int err = 0;
>  
> +	if (old_remote_ip && remote_ip &&
> +	    vxlan_addr_equal(old_remote_ip, remote_ip) &&
> +	    old_ifindex == new_ifindex)
> +		return 0;
> +

[ ... ]

> @@ -563,6 +570,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  
>  	ret = vxlan_update_default_fdb_entry(vxlan, vninode->vni,
>  					     oldrip, newrip,
> +					     cfg->remote_ifindex,
> +					     cfg->remote_ifindex,
>  					     extack);
>  	if (ret)
>  		goto out;

[ ... ]

> @@ -616,6 +626,8 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
>  			ret = vxlan_update_default_fdb_entry(vxlan, vent->vni,
>  							     old_remote_ip,
>  							     new_remote_ip,
> +							     old_ifindex,
> +							     new_ifindex,
>  							     extack);
>  			if (ret)
>  				return ret;

[Severity: Medium]
Is the new ifindex refresh complete for VNI entries that carry their own group
address?

The loop in vxlan_vnilist_update_group() only visits nodes whose remote_ip is
"any":

	if (vxlan_addr_any(&vent->remote_ip)) {
		ret = vxlan_update_default_fdb_entry(...);

But vxlan_vni_update_group() creates entries with an explicit group using the
device configuration ifindex, as seen in the hunk above
(cfg->remote_ifindex passed for both old and new), so those rdsts also store
the device's remote_ifindex and are skipped here.  After a changelink that
alters remote_ifindex, vxlan_config_apply() publishes the new cfg while those
rdsts keep the old value.

	bridge vni add vni 100 group 239.1.1.1 dev vx	# rdst ifindex = eth0
	ip link set dev vxlan0 type vxlan dev eth1	# or IFLA_VXLAN_LINK = 0
	bridge vni del vni 100 dev vx

vxlan_vni_delete_group() then calls __vxlan_fdb_delete() with the new
cfg->remote_ifindex, and vxlan_fdb_find_rdst() requires an exact match:

		if (vxlan_addr_equal(&rd->remote_ip, ip) &&
		    rd->remote_port == port &&
		    rd->remote_vni == vni &&
		    rd->remote_ifindex == ifindex)
			return rd;

so no rdst is found, __vxlan_fdb_delete() takes the "goto out; return 0" path
and the all-zeros-MAC entry survives the vni delete.  Re-adding the same vni
appends a second rdst, duplicating transmitted BUM traffic.  Meanwhile
vxlan_xmit_one() keeps using the stale "ifindex = rdst->remote_ifindex" as
route oif, and the vxlan_igmp_leave(vxlan, &vninode->remote_ip, 0) in the same
function resolves rifindex 0 to the new cfg->remote_ifindex although the group
was joined on the old one.

The IFLA_VXLAN_LINK = 0 variant looks newly broken: previously
default_dst.remote_ifindex was left untouched when lowerdev was NULL, so the
delete still matched.  Given the commit message says default fdb entries
"including VNI filter entries" are updated if remote_ifindex changed, should
this loop also handle nodes with their own group?

> @@ -630,20 +642,19 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
>  {
>  	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
>  	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
> -	struct vxlan_rdst *dst = &vxlan->default_dst;
>  
>  	/* if per vni remote_ip not present, delete the
>  	 * default dst remote_ip previously added for this vni
>  	 */
>  	if (!vxlan_addr_any(&vninode->remote_ip) ||
> -	    !vxlan_addr_any(&dst->remote_ip)) {
> +	    !vxlan_addr_any(&cfg->remote_ip)) {
>  		spin_lock_bh(&vxlan->hash_lock);
>  		__vxlan_fdb_delete(vxlan, all_zeros_mac,
>  				   (vxlan_addr_any(&vninode->remote_ip) ?
> -				   dst->remote_ip : vninode->remote_ip),
> +				   cfg->remote_ip : vninode->remote_ip),
>  				   cfg->dst_port,
>  				   vninode->vni, vninode->vni,
> -				   dst->remote_ifindex,
> +				   cfg->remote_ifindex,
>  				   true);
>  		spin_unlock_bh(&vxlan->hash_lock);
>  	}

[ ... ]

> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 7ced743ec8816..c3c9f2ccc3d1b 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -204,7 +204,6 @@ struct vxlan_rdst {
>  	u8			 offloaded:1;
>  	__be32			 remote_vni;
>  	u32			 remote_ifindex;
> -	struct net_device	 *remote_dev;
>  	struct list_head	 list;
>  	struct rcu_head		 rcu;
>  	struct dst_cache	 dst_cache;

[Severity: Low]
The commit message says:

    Furthermore, several fields of struct vxlan_rdst (remote_dev,
    remote_port, offloaded, list, rcu, dst_cache) in default_dst were
    completely unused.

Is that accurate for remote_dev?  In the baseline, default_dst.remote_dev was
the only user of that field: vxlan_dev_create() assigned it
("dst->remote_dev = remote_dev;"), vxlan_changelink() compared it
("if (dst->remote_dev == lowerdev) lowerdev = NULL;") and passed it to
netdev_adjacent_change_prepare()/commit()/abort(), and vxlan_dellink() used it
for netdev_upper_dev_unlink().  The patch moves that active role to
vxlan->lowerdev rather than removing dead state, and changes the surrounding
changelink logic along the way.

> @@ -295,7 +294,7 @@ struct vxlan_dev {
>  #endif
>  	struct net_device *dev;
>  	struct net	  *net;		/* netns for packet i/o */
> -	struct vxlan_rdst default_dst;	/* default destination */
> +	struct net_device *lowerdev;
>  
>  	struct timer_list age_timer;
>  	spinlock_t	  hash_lock;
