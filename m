Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776D519919
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602945; cv=none; b=nSV3ie3BaiB6bSnDe3mgz1NV7fvPk+K9y1iEUSdJptnDUCxJmoI6l+N2h3Yzuig1BMvYCvCU/5MNfXbp460WYf79cy/nfojLU0kfEPt3mjBLjX5Qfm5D6CMdylgcm05UOeT4kvG4Hp0OWWA7PipwpfMcNY1Rz7iK/SVEIR5UzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602945; c=relaxed/simple;
	bh=8NmioR34iDClDCp1h/rNP7k4nhCiVPz8JDlDxph6n6M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1G9mJ6tTj5WjtvhfCpsVJDXTDmKcrhlSRloeebNDWbSPUC/zhZvg6sS9V8UXqLdeEugeyGkr/Dd6Ao7tE4uvv3IKLxA+HWP/IJXDPXoQ1U5wqWmSOdj+1rQ3qUG5bVIq+n8HWqF0d59uzSS+EbQgaDdr62sLBOj/L2cD73MG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmV/UXW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmV/UXW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06DB1F000FF;
	Wed, 16 Sep 2026 23:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602943;
	bh=kGd69uzc/GssFaa77hCKEg7qAtFTeF07O8VNBlO+KVg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TmV/UXW3MoF8HGJ6YOi4EfKBZ4IWjTwmIS6Ks6dntuebR/SltLFT0VdtfZq0OR6jj
	 aPWKf3TF6HvSxAfMWAGp34VG/8+agF2JmLLFSvTiRfDvdBouWLpKIIBsv1l6IUHDBE
	 CJdEKYg++XR8XJKqZ53CT3Agl5ekATvw1Nj7/nJ17Gy2uwh4xCC6FsbqC7KQOwpzof
	 /ynn2NBiz734UJ6DsCUKSoRUIjHaZHEvps3CU/waLSdMOXkbMR4lNHUV5X9D9XVov1
	 +Nc4O1sNB/TuYyPlAh5piyFCZb6zYGmQLi64+t1ulLA/q1u+hJRw3PAASFdJZRKKQp
	 2eZLp+kQ32eaA==
Subject: Re: [PATCH v4 net-next 7/8] vxlan: remove default_dst and use
 vxlan_config and lowerdev
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 kuniyu@google.com
Date: Wed, 16 Sep 2026 23:55:42 +0000
Message-ID: <178960294227.22033.11226883715041955650@kernel.org>
In-Reply-To: <20260915175501.391567-8-edumazet@google.com>
References: <20260915175501.391567-8-edumazet@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 2 (1)

- [Medium] Clearing IFLA_VXLAN_LINK on a VNIFILTER device desynchronizes
  per-VNI IGMP/MLD memberships from the committed configuration.
- [Low] dev->needed_tailroom is left describing a lower device that is no
  longer attached.
- [Low] The patch is submitted as a refactor ('remove default_dst and use
  vxlan_config and lowerdev') but also changes user-visible changelink…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a failed
  VNI-filter FDB update leaves earlier FDB replacements committed while…
- [Medium] This problem wasn't introduced by this patch, but
  vxlan_changelink() reports failure after having committed the new…
- [Low] This problem wasn't introduced by this patch, but
  vxlan_config_apply() reads and writes dev->mtu with plain accesses,…

--

vxlan: remove default_dst and use vxlan_config and lowerdev

This drops vxlan->default_dst, replaces it with a plain struct net_device
*lowerdev in struct vxlan_dev, and moves all remaining readers of the
default destination attributes over to the RCU-protected vxlan->cfg.
vxlan_config_apply() gains a lowerdev_changed argument, and clearing
IFLA_VXLAN_LINK now commits remote_ifindex 0 and tears down the adjacency.

A few questions on the behaviour changes below.

The commit message says:

    cfg->remote_ifindex is now committed unconditionally, where
    default_dst.remote_ifindex was left untouched when IFLA_VXLAN_LINK was
    cleared, so a changelink dropping the lower device no longer leaves a
    stale ifindex behind.

and:

    In vxlan_changelink(), pass lowerdev to vxlan_config_apply() to preserve
    needed_headroom and needed_tailroom.

[Severity: Low]
Both of those paragraphs describe fixes for pre-existing defects that are
user visible, and both are bundled into a data structure refactor with no
Fixes: tag.

The stale ifindex was reported back through IFLA_VXLAN_LINK, stayed in the
default fdb entry, left the upper/lower adjacency in place (since
netdev_adjacent_change_commit() returns early for a NULL new_dev), and made
a later unregister of the already-detached lower device destroy the vxlan
device via vxlan_handle_lowerdev_unregister().

The needed_headroom loss came from "if (dst->remote_dev == lowerdev)
lowerdev = NULL;" in the old vxlan_changelink(), which made every
changelink recompute dev->needed_headroom without lowerdev->needed_headroom.

Earlier patches in this series carry Fixes: tags. Could these two
corrections get Fixes: tags, or be split out so they can be picked up
independently of the RCU cfg conversion?

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 0e20ef3d2d9ee..dd823d377fd39 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -4007,10 +4016,9 @@ static void vxlan_config_apply(struct net_device *dev,
>  			       struct vxlan_config *new_cfg,
>  			       struct net_device *lowerdev,
>  			       struct net *src_net,
> -			       bool changelink)
> +			       bool changelink, bool lowerdev_changed)
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

[Severity: Low]
Just below this, still inside the "if (lowerdev)" branch,
vxlan_config_apply() has:

		dev->needed_tailroom = lowerdev->needed_tailroom;

while dev->needed_headroom is recomputed unconditionally further down.

This patch makes a changelink commit a NULL lower device for the first
time, so with IFLA_VXLAN_LINK = 0 on a device whose lower device had a
nonzero needed_tailroom, doesn't the vxlan device keep advertising that
needed_tailroom while its needed_headroom is reset to the no-lowerdev
value? Would moving the assignment out of the branch,

	dev->needed_tailroom = lowerdev ? lowerdev->needed_tailroom : 0;

keep the two fields describing the same configuration?

> @@ -4050,7 +4052,8 @@ static void vxlan_config_apply(struct net_device *dev,
>  			dev->mtu = max_mtu;
>  	}
>  
> -	if (dev->mtu > max_mtu)
> +	/* A changelink leaving the lower device alone must not shrink the mtu */
> +	if (lowerdev_changed && dev->mtu > max_mtu)
>  		dev->mtu = max_mtu;

[Severity: Low]
This isn't a bug introduced by this patch, but since this store is being
rewritten anyway: dev->mtu is read and written here with plain accesses,
here and in the "dev->mtu = new_cfg->mtu;" and "dev->mtu = max_mtu;" stores
above.

include/linux/netdevice.h says about mtu:

	/* Note : dev->mtu is often read without holding a lock.
	 * Writers usually hold RTNL.
	 * It is recommended to use READ_ONCE() to annotate the reads,
	 * and to use WRITE_ONCE() to annotate the writes.
	 */

and vxlan_change_mtu() in this same file already does WRITE_ONCE(dev->mtu,
new_mtu). Would adding READ_ONCE()/WRITE_ONCE() here silence the
writer-versus-lockless-reader race that KCSAN would report?

[ ... ]

> @@ -4579,26 +4581,23 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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
>  
> -	/* vxlan_config_apply() only commits remote_ifindex if lowerdev is set */
> -	new_ifindex = lowerdev ? conf.remote_ifindex : dst->remote_ifindex;
> -
> -	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
> +	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &cfg->remote_ip);
>  	change_igmp = vxlan->dev->flags & IFF_UP &&
>  		      (rem_ip_changed ||
> -		       dst->remote_ifindex != new_ifindex);
> +		       cfg->remote_ifindex != conf.remote_ifindex);
>  
>  	/* handle default dst entry */
> -	if (rem_ip_changed || dst->remote_ifindex != new_ifindex) {
> +	if (rem_ip_changed || cfg->remote_ifindex != conf.remote_ifindex) {
>  		spin_lock_bh(&vxlan->hash_lock);
>  		if (!vxlan_addr_any(&conf.remote_ip)) {
>  			err = vxlan_fdb_update(vxlan, all_zeros_mac,

[ ... ]

> @@ -4631,32 +4631,40 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  		 * all vnis
>  		 */
>  		if (cfg->flags & VXLAN_F_VNIFILTER) {
> -			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
> +			err = vxlan_vnilist_update_group(vxlan, &cfg->remote_ip,
>  							 &conf.remote_ip,
> -							 dst->remote_ifindex,
> -							 new_ifindex, extack);
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
>  
> -	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
> +	if (change_igmp && vxlan_addr_multicast(&cfg->remote_ip))
>  		err = vxlan_multicast_leave(vxlan);

[Severity: Medium]
Can clearing IFLA_VXLAN_LINK on a VNIFILTER device leave the per-VNI
multicast memberships pinned to the lower device that was just detached?

cfg->remote_ifindex is now committed unconditionally, and both
vxlan_igmp_join() and vxlan_igmp_leave() resolve the interface from it:

drivers/net/vxlan/vxlan_multicast.c, vxlan_igmp_leave():
	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
	const union vxlan_addr *ip = (rip ? : &cfg->remote_ip);
	int ifindex = (rifindex ? : cfg->remote_ifindex);

But the leave/join pair that would migrate the memberships is gated on the
device level remote_ip being multicast:

	if (change_igmp && vxlan_addr_multicast(&cfg->remote_ip))
		err = vxlan_multicast_leave(vxlan);
	...
	if (!err && change_igmp &&
	    vxlan_addr_multicast(&new_cfg->remote_ip))
		err = vxlan_multicast_join(vxlan);

For a device whose default remote_ip is ANY but whose VNIs carry their own
multicast groups, change_igmp is true (cfg->remote_ifindex !=
conf.remote_ifindex) while neither call runs, so the socket keeps
memberships joined with the old ifindex although the committed config now
says 0.

A later teardown goes vxlan_stop() -> vxlan_multicast_leave() ->
vxlan_multicast_leave_vnigrp() -> vxlan_igmp_leave(vxlan, &v->remote_ip, 0),
which computes ifindex 0 and hands imr_ifindex == 0 to ip_mc_leave_group();
ip_mc_find_dev() then route-resolves the group and rewrites imr_ifindex.
Does that either fail with -EADDRNOTAVAIL, leaving the membership behind on
a possibly shared vxlan_sock, or drop a membership another vxlan device
sharing that socket still needs?

vxlan_group_used() also takes its fallback ifindex from cfg now:

	int ifindex = (rifindex ? : dev_cfg->remote_ifindex);

so can it still spot that other user once the ifindex is 0?

And on the next up, vxlan_multicast_join_vnigrp() re-joins with
imr_ifindex == 0, letting a route lookup choose the interface, which is
what the "Local interface required for multicast remote group" check in
vxlan_process_vni_filter() refuses at add time.

Pre-patch, new_ifindex = lowerdev ? conf.remote_ifindex :
dst->remote_ifindex plus the "if (lowerdev)" guard in
vxlan_config_apply() kept join and leave symmetric across this transition.
Was this delta intended for the VNIFILTER case?

>  
>  	if (netif_running(dev) && conf.age_interval != cfg->age_interval)
>  		mod_timer(&vxlan->age_timer, jiffies);
>  
> -	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
> -	if (lowerdev && lowerdev != dst->remote_dev)
> -		dst->remote_dev = lowerdev;
> -	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true);
> +	if (lowerdev_changed) {
> +		if (lowerdev)
> +			netdev_adjacent_change_commit(vxlan->lowerdev, lowerdev,
> +						      dev);
> +		else
> +			netdev_upper_dev_unlink(vxlan->lowerdev, dev);
> +		vxlan->lowerdev = lowerdev;
> +	}
> +	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true,
> +			   lowerdev_changed);
>  
>  	if (!err && change_igmp &&
> -	    vxlan_addr_multicast(&dst->remote_ip))
> +	    vxlan_addr_multicast(&new_cfg->remote_ip))
>  		err = vxlan_multicast_join(vxlan);
>  
>  	return err;

[Severity: Medium]
This is a pre-existing issue, not something this patch introduces, but the
error handling around the two multicast calls is worth a note while the
surrounding code is being reworked.

If vxlan_multicast_leave() fails, err is nonzero but execution continues:
the adjacency change is committed, new_cfg is published by
vxlan_config_apply(), and then the join is skipped because of the "!err"
test. Does the device end up running with the new configuration but no
membership in its newly configured group, while userspace gets an error
back?

The reverse case has the same shape: a failing vxlan_multicast_join()
(-ENOBUFS once sysctl_igmp_max_memberships is hit, or -ENODEV) returns an
error after the new cfg has already been published, with no rollback.

> diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
> index e2cf10da274f1..6fcc4a3673436 100644
> --- a/drivers/net/vxlan/vxlan_multicast.c
> +++ b/drivers/net/vxlan/vxlan_multicast.c
> @@ -14,11 +14,12 @@
>  /* Update multicast group membership when first VNI on
>   * multicast address is brought up
>   */
> -int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
> +int vxlan_igmp_join(struct vxlan_dev *vxlan, const union vxlan_addr *rip,
>  		    int rifindex)
>  {
> -	union vxlan_addr *ip = (rip ? : &vxlan->default_dst.remote_ip);
> -	int ifindex = (rifindex ? : vxlan->default_dst.remote_ifindex);
> +	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
> +	const union vxlan_addr *ip = (rip ? : &cfg->remote_ip);
> +	int ifindex = (rifindex ? : cfg->remote_ifindex);
>  	int ret = -EINVAL;
>  	struct sock *sk;
>  
> @@ -47,11 +48,12 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
>  	return ret;
>  }
>  
> -int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
> +int vxlan_igmp_leave(struct vxlan_dev *vxlan, const union vxlan_addr *rip,
>  		     int rifindex)
>  {
> -	union vxlan_addr *ip = (rip ? : &vxlan->default_dst.remote_ip);
> -	int ifindex = (rifindex ? : vxlan->default_dst.remote_ifindex);
> +	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
> +	const union vxlan_addr *ip = (rip ? : &cfg->remote_ip);
> +	int ifindex = (rifindex ? : cfg->remote_ifindex);
>  	int ret = -EINVAL;
>  	struct sock *sk;
>  

[ ... ]

> @@ -121,16 +125,17 @@ static bool vxlan_group_used_by_vnifilter(struct vxlan_dev *vxlan,
>  
>  /* See if multicast group is already in use by other ID */
>  bool vxlan_group_used(struct vxlan_net *vn, struct vxlan_dev *dev,
> -		      __be32 vni, union vxlan_addr *rip, int rifindex)
> +		      __be32 vni, const union vxlan_addr *rip, int rifindex)
>  {
> -	union vxlan_addr *ip = (rip ? : &dev->default_dst.remote_ip);
> -	int ifindex = (rifindex ? : dev->default_dst.remote_ifindex);
> +	const struct vxlan_config *dev_cfg = rtnl_dereference(dev->cfg);
> +	const union vxlan_addr *ip = (rip ? : &dev_cfg->remote_ip);
> +	int ifindex = (rifindex ? : dev_cfg->remote_ifindex);
>  	struct vxlan_dev *vxlan;
>  	struct vxlan_sock *sock4;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	struct vxlan_sock *sock6;
>  #endif
> -	unsigned short family = dev->default_dst.remote_ip.sa.sa_family;
> +	unsigned short family = dev_cfg->remote_ip.sa.sa_family;
>  
>  	sock4 = rtnl_dereference(dev->vn4_sock);
>  

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index beb3eedc52e53..543eaf420f4c2 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -621,12 +623,12 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  }
>  
>  int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
> -			       union vxlan_addr *old_remote_ip,
> -			       union vxlan_addr *new_remote_ip,
> +			       const union vxlan_addr *old_remote_ip,
> +			       const union vxlan_addr *new_remote_ip,
>  			       u32 old_ifindex, u32 new_ifindex,
>  			       struct netlink_ext_ack *extack)
>  {
> -	union vxlan_addr *oldrip, *newrip;
> +	const union vxlan_addr *oldrip, *newrip;
>  	struct list_head *headp, *hpos;
>  	struct vxlan_vni_group *vg;
>  	struct vxlan_vni_node *vent;

[Severity: Medium]
This isn't a bug introduced by this patch, but the loop in
vxlan_vnilist_update_group() returns on the first error without undoing the
iterations that already succeeded:

		ret = vxlan_update_default_fdb_entry(vxlan, vent->vni,
						     oldrip, newrip,
						     old_ifindex, new_ifindex,
						     extack);
		if (ret)
			return ret;

Each successful vxlan_update_default_fdb_entry() appends the new
destination and deletes the old one, so if vxlan_fdb_update() returns
-ENOMEM for a later VNI, the caller in vxlan_changelink() aborts the
adjacency preparation, frees new_cfg and returns, keeping the old cfg.

Doesn't the retained cfg then carry the old remote_ifindex/remote_ip while
the device-wide default entry and the already-processed VNI entries carry
the new ones? Later deletions keyed on cfg->remote_ifindex and
cfg->remote_ip in vxlan_vni_delete_group() and __vxlan_fdb_delete() would
no longer match those destinations, so the rdsts stay around and can
duplicate transmitted BUM traffic.

Would either rolling back the completed entries, or doing all the fallible
additions before any deletion, avoid the half-applied state?

> @@ -941,7 +943,8 @@ static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
>  		memset(&group, 0, sizeof(group));
>  	}
>  
> -	if (vxlan_addr_multicast(&group) && !vxlan->default_dst.remote_ifindex) {
> +	cfg = rtnl_dereference(vxlan->cfg);
> +	if (vxlan_addr_multicast(&group) && !cfg->remote_ifindex) {
>  		NL_SET_ERR_MSG(extack,
>  			       "Local interface required for multicast remote group");
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915175501.391567-1-edumazet%40google.com
