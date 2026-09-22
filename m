Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E285328DD
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092952; cv=none; b=eZ2eHNbg31UbTyc8WcITj22xc2wN8GXYNswBVP58hUNoyH+3fyZqPxnWlzDzvR4Yqqw7mxLVwKME3oHbt2HaTZh50xbA/mSpA/laOQCyfxweV0qn1yb6Xr0oville35eYKwW3lKGIk5VicMt9KMIOI44aF1Dr9YHh4GppxebiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092952; c=relaxed/simple;
	bh=Ncz7CQBqB5oktJ/N60An10A7HDBKgqh+UTY0yaIgqlc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9qCSR39hbc9VYe/1ny+y6utXtRZnJMsvORw2+SiW6LotxhJtSSpyS6p/I5BAikOvCugroraV/jZwp0PAfZuVfxy7e9ZXitbb+RzZRkDo46nMWlJ7irybp7XSawUj3JCsvBjhGr5gqY3NRSIEZpiRDVwlK0ZaEHFpvZlZZDnA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcLOaNIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcLOaNIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F31F00898;
	Tue, 22 Sep 2026 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092950;
	bh=wWceUFZ4RHIGoXegkXkHU7YhQ74ks/AZrPsuIzn0Bl0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LcLOaNIKLKzCtVEZj7guNnElp/vjxtQ4hrNZ3ea4eMolI+QxB/GsJFGmV4AGZ7SRc
	 j6itlRyCaGkngTwLJwVivzmMeFXf5T+zT4XknGG8Y22PVH2o9ZlukKt/OV5h55q0IW
	 PdMWZtxPj0jPHmLT4m4JKf8X5h0u4YcOO4SGwa79M5Pynsrjxz6j7xl6AdhOUh8KLL
	 SW9fXylJ3WyBNgIG8E8jgXxeSiUN3PaTdtM5VJga+pD0NFtJZL1hUkejRdaB4hl94Y
	 RG5qYzH0Fz3qNZiOPS8weJ4TIUENg4QSdIyvOKP+vjN+03De4S3MRYV7dy11FAsx8j
	 mLcHFGhpOLvqg==
Subject: Re: [PATCH v5 net-next 7/8] vxlan: remove default_dst and use
 vxlan_config and lowerdev
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 22 Sep 2026 16:02:30 +0000
Message-ID: <179009295008.2160803.2616095529025993546@kernel.org>
In-Reply-To: <20260921100139.508191-8-edumazet@google.com>
References: <20260921100139.508191-8-edumazet@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch is advertised as a pure redundancy-removal refactor
  ("remove default_dst and use vxlan_config and lowerdev"), but it…

Pre-existing issues:
- [High] On a running VXLAN device with VXLAN_F_VNIFILTER, a changelink
  that swaps the lower device (or changes the remote) makes…
- [Medium] This problem wasn't introduced by this patch, but the patch
  touches the affected function: in vxlan_vni_update_group()…

--

vxlan: remove default_dst and use vxlan_config and lowerdev

This drops vxlan->default_dst and replaces it with a plain
struct net_device *lowerdev in struct vxlan_dev, moving the remaining
readers of remote_ip, remote_vni and remote_ifindex over to vxlan->cfg.
vxlan_config_apply() gains a lowerdev_changed argument, and
vxlan_config_validate() gains a new rejection when IFLA_VXLAN_LINK is
cleared while per-VNI multicast groups exist.

A few questions below about how the behaviour changes are packaged, plus
two older issues in code this patch touches.

(no Link: tags in the commit header)

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 04b2925d7c38a..b505fefcef70a 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -3973,6 +3982,13 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
>  			return -EINVAL;
>  		}
>  
> +		if ((conf->flags & VXLAN_F_VNIFILTER) && old &&
> +		    vxlan_vnifilter_has_multicast(old)) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Local interface required for multicast remote group");
> +			return -EINVAL;
> +		}
> +
>  #if IS_ENABLED(CONFIG_IPV6)
>  		if (conf->flags & VXLAN_F_IPV6_LINKLOCAL) {
>  			NL_SET_ERR_MSG(extack,
> @@ -4007,10 +4023,9 @@ static void vxlan_config_apply(struct net_device *dev,
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
> @@ -4023,18 +4038,13 @@ static void vxlan_config_apply(struct net_device *dev,
>  			vxlan_ether_setup(dev);
>  
>  		if (new_cfg->mtu)
> -			dev->mtu = new_cfg->mtu;
> +			WRITE_ONCE(dev->mtu, new_cfg->mtu);
>  
>  		vxlan->net = src_net;
>  	}
>  
> -	dst->remote_vni = new_cfg->vni;
> -
> -	memcpy(&dst->remote_ip, &new_cfg->remote_ip, sizeof(new_cfg->remote_ip));
> -
> +	dev->needed_tailroom = 0;
>  	if (lowerdev) {
> -		dst->remote_ifindex = new_cfg->remote_ifindex;
> -
>  		netif_inherit_tso_max(dev, lowerdev);
>  
>  		needed_headroom = lowerdev->hard_header_len;
> @@ -4042,16 +4052,17 @@ static void vxlan_config_apply(struct net_device *dev,
>  
>  		dev->needed_tailroom = lowerdev->needed_tailroom;
>  
> -		max_mtu = lowerdev->mtu - vxlan_headroom(flags);
> +		max_mtu = READ_ONCE(lowerdev->mtu) - vxlan_headroom(flags);
>  		if (max_mtu < ETH_MIN_MTU)
>  			max_mtu = ETH_MIN_MTU;
>  
>  		if (!changelink && !new_cfg->mtu)
> -			dev->mtu = max_mtu;
> +			WRITE_ONCE(dev->mtu, max_mtu);
>  	}
>  
> -	if (dev->mtu > max_mtu)
> -		dev->mtu = max_mtu;
> +	/* A changelink leaving the lower device alone must not shrink the mtu */
> +	if (lowerdev_changed && READ_ONCE(dev->mtu) > max_mtu)
> +		WRITE_ONCE(dev->mtu, max_mtu);

[Severity: Low]

The subject presents this as removing a redundant copy of the default
destination, but two of the changes here look like fixes for existing
user triggerable defects, and there is no Fixes: tag for either.  Would
it make sense to split them out?

Before this patch vxlan_changelink() forced lowerdev to NULL when it was
unchanged:

	if (dst->remote_dev == lowerdev)
		lowerdev = NULL;

and vxlan_config_apply() only derives the headroom inside if (lowerdev):

	needed_headroom = lowerdev->hard_header_len;
	needed_headroom += lowerdev->needed_headroom;

So any changelink that kept the same lower device, for example
ip link set vxlan0 type vxlan ttl 64, recomputed dev->needed_headroom as
ETH_HLEN + vxlan_headroom(flags) and dropped the lower device's
contribution.  Passing lowerdev unconditionally repairs that, and the
new lowerdev_changed argument keeps the previous mtu semantics.

The second one: vxlan_config_apply() used to commit
dst->remote_ifindex = new_cfg->remote_ifindex only when lowerdev was
non-NULL, while vxlan->cfg received remote_ifindex == 0 anyway, so
clearing IFLA_VXLAN_LINK left default_dst.remote_ifindex stale.
vxlan_fill_info(), vxlan_change_mtu(), vxlan_get_link_ksettings() and
vxlan_handle_lowerdev_unregister() all read that stale value.  This
patch removes the divergence, again with no Fixes: tag.

Finally, the new vxlan_vnifilter_has_multicast() check in
vxlan_config_validate() makes a changelink with IFLA_VXLAN_LINK=0 return
-EINVAL where it was previously accepted, and IFLA_VXLAN_LINK reporting
after such a request changes as well.

Could the two fixes be carried as separate patches with Fixes: tags so
they can be picked up for stable, and the new -EINVAL be called out as a
user visible change?

[ ... ]

> @@ -4579,26 +4589,23 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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

[ ... ]

> @@ -4651,20 +4661,26 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	}
>  
>  	if (change_igmp &&
> -	    (vxlan_addr_multicast(&dst->remote_ip) ||
> +	    (vxlan_addr_multicast(&cfg->remote_ip) ||
>  	     (cfg->flags & VXLAN_F_VNIFILTER)))
>  		err = vxlan_multicast_leave(vxlan);
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
> -	    (vxlan_addr_multicast(&dst->remote_ip) ||
> +	    (vxlan_addr_multicast(&new_cfg->remote_ip) ||
>  	     (new_cfg->flags & VXLAN_F_VNIFILTER)))
>  		err = vxlan_multicast_join(vxlan);

[Severity: High]

This is a pre-existing issue and not introduced by this patch, but since
the error handling around vxlan_multicast_leave() is being touched here,
can a failing leave leave a running device with no memberships at all?

With VXLAN_F_VNIFILTER, vxlan_multicast_leave() calls
vxlan_multicast_leave_vnigrp(), which walks every VNI without
deduplicating:

	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
		if (vxlan_addr_multicast(&v->remote_ip) &&
		    !vxlan_group_used(vn, vxlan, v->vni, &v->remote_ip, 0)) {
			ret = vxlan_igmp_leave(vxlan, &v->remote_ip, 0);
			if (ret)
				last_err = ret;
		}
	}

The join side collapses duplicates, so only one membership exists:

	bridge vni add dev vx0 vni 100 group 239.1.1.1
	bridge vni add dev vx0 vni 200 group 239.1.1.1

vxlan_multicast_join_vnigrp() maps the second join's -EADDRINUSE to
success, and it also skips any per-VNI group equal to cfg->remote_ip,
which the leave path does not.

vxlan_group_used() cannot see the duplicate inside the same device:

	if (family == AF_INET && sock4 && refcount_read(&sock4->refcnt) == 1)
		return false;
	...
		if (!netif_running(vxlan->dev) || vxlan == dev)
			continue;

so the second vxlan_igmp_leave() reaches ip_mc_leave_group() with no
membership left and returns -EADDRNOTAVAIL, which is propagated as
last_err.

At that point the new adjacency and the new cfg are still committed, and
the

	if (!err && change_igmp && ...)
		err = vxlan_multicast_join(vxlan);

guard skips the rejoin, so the device keeps running with no group
membership and stops receiving flooded traffic.  Retrying the same
request does not help, since cfg->remote_ifindex now matches the
requested value and change_igmp is false, so only an administrative
down/up restores it.  Should the leave path skip groups it never joined,
or should the rejoin not be gated on the leave result?

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 678565c4f8e27..48135ff9b95a1 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -518,8 +534,10 @@ int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
>  
>  	spin_lock_bh(&vxlan->hash_lock);
>  	if (remote_ip && !vxlan_addr_any(remote_ip)) {
> +		union vxlan_addr rip = *remote_ip;
> +
>  		err = vxlan_fdb_update(vxlan, all_zeros_mac,
> -				       remote_ip,
> +				       &rip,
>  				       NUD_REACHABLE | NUD_PERMANENT,
>  				       NLM_F_APPEND | NLM_F_CREATE,
>  				       cfg->dst_port,
> @@ -553,8 +571,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  				  struct netlink_ext_ack *extack)
>  {
>  	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
> -	struct vxlan_rdst *dst = &vxlan->default_dst;
> -	union vxlan_addr *newrip = NULL, *oldrip = NULL;
> +	const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
> +	const union vxlan_addr *newrip = NULL, *oldrip = NULL;
>  	union vxlan_addr old_remote_ip;
>  	int ret = 0;
>  
> @@ -566,8 +584,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  	if (group && !vxlan_addr_any(group)) {
>  		newrip = group;
>  	} else {
> -		if (!vxlan_addr_any(&dst->remote_ip))
> -			newrip = &dst->remote_ip;
> +		if (!vxlan_addr_any(&cfg->remote_ip))
> +			newrip = &cfg->remote_ip;
>  	}
>  
>  	/* if old rip exists, and no newrip,

[Severity: Medium]

This isn't a bug introduced by this patch either, but vxlan_vni_update_group()
is being converted here, so while looking at it: does replacing one non-zero
per-VNI group with another leave the old flood destination behind?

oldrip is only set when there is no newrip:

	if (!newrip && !vxlan_addr_any(&old_remote_ip))
		oldrip = &old_remote_ip;

so on a replacement vxlan_update_default_fdb_entry() is called with
old_remote_ip == NULL and only runs the NLM_F_APPEND | NLM_F_CREATE
update.  For the all-zeros MAC that goes through
vxlan_fdb_update_existing() -> vxlan_fdb_append(), which keeps the
existing rdst:

	if ((flags & NLM_F_APPEND) &&
	    (is_multicast_ether_addr(f->key.eth_addr) ||
	     is_zero_ether_addr(f->key.eth_addr))) {
		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);

vninode->remote_ip is then overwritten with the new group and the request
succeeds, so the zero-MAC entry ends up with two remotes:

	bridge vni add dev vx0 vni 100 group 239.1.1.1
	bridge vni add dev vx0 vni 100 group 239.1.1.2

vxlan_vni_add() routes the second request to vxlan_vni_update() ->
vxlan_vni_update_group() with create == false.  A later VNI delete only
targets vninode->remote_ip in vxlan_vni_delete_group(), so the stale rdst
survives and re-adding the VNI accumulates more.  The same applies when a
per-VNI group is switched back to a non-zero device default.

Should the replacement case pass the previous address as old_remote_ip so
the stale destination is removed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921100139.508191-1-edumazet%40google.com
