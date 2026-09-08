Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4A59C99F
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890640; cv=none; b=Wu/VhxXprJodaGMQY1c6pHOso1bAzlVqp5ys7wrWor2UTEBh09ykDBXBlybxGUPncuVXxBJCh0or+X7UwhvK0hE9o2WKXVsayLoxBJ5E8nZPE3W8gYasf8kca/gsmheptajG7u7FLebrXXEvsMcOZXvjfYP8xr3glPIF+sOpaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890640; c=relaxed/simple;
	bh=r+SJklDh8uLHkfiFLIXK3oqVmdFGRyRT1EYzliY8s5s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDMeOYdoLA+tqlwqibyzKMK6O6Rjbf9S0JuDAYd2jsl0vqGBTDWy3fKRIWHQB2rJZbBqSl3dFAQxaxC/QVkaaCo6pZORvPgcfalaa7GE79Dx6nllYLPthIglxJHB3CzYmxXHhlbFnV8RmlxHLeSXdC2odwuEVKZJBS+JBzLNszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXDEjV4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXDEjV4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17181F00A3F;
	Tue,  8 Sep 2026 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890637;
	bh=HOZQLSC4UX1pToSY1tP+AVL3KhsFQXzVOFIwvW2LTqo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WXDEjV4vGtdBMv/l7Y1VJP3VMNazfn0muLhgbFZ3Q9ZwVNGlddM1cPxdcWzuR4rpt
	 g1BcclEP7/j/OA7rKm3sNowVTagYxvMME0VUPPEIvVXs5v/xPEtbf+A2nTuqqy3+bm
	 osf3nX8Iw1YG9NZ+XuOQflXY5+Kj8U+LkHHELdGBxGV+rATCLULj0D+FXwtONnZ2/J
	 WTlEsXS3JgRzMv0pVkRtMABrIAj61JWmATRVlGnEkO3b1ABXjaae6wuqdSOqpCSPkQ
	 Diyqa69hW33pJubtXZHNwoIv2sedPZXukNm1DzywfQkPKgvNqH0G6yr1y7A6nFNnFu
	 sMvXIY2Xj7egw==
Subject: Re: [PATCH v2 net-next 7/8] vxlan: remove default_dst and use
 vxlan_config and lowerdev
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 18:03:56 +0000
Message-ID: <178889063649.219967.9220253860644497501@kernel.org>
In-Reply-To: <20260906180111.1973188-8-edumazet@google.com>
References: <20260906180111.1973188-8-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 2

- [Medium] Removing `if (dst->remote_dev == lowerdev) lowerdev = NULL;`
  from vxlan_changelink() changes what is passed to…
- [Medium] Deleting `dst->remote_ifindex = new_cfg->remote_ifindex;` from
  vxlan_config_apply() (it was intentionally inside `if (lowerdev)`) and…
- [Low] vxlan_group_used() in drivers/net/vxlan/vxlan_multicast.c has two
  continuation lines re-indented from parenthesis alignment to an extra…
- [Low] `struct vxlan_rdst::remote_dev` in the exported header
  include/net/vxlan.h has no remaining reader or writer anywhere in the…

--

vxlan: remove default_dst and use vxlan_config and lowerdev

This removes struct vxlan_dev::default_dst and reads the default remote
IP, VNI and ifindex from the RCU-protected vxlan->cfg instead. The lower
device is now tracked in a new struct vxlan_dev::lowerdev pointer under
RTNL, and mlx5e_tc_tun_get_remote_ifindex() reads remote_ifindex from
vxlan->cfg under rcu_read_lock().

A few questions below about the changelink and config_apply paths.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index b79a15985a994..2b7da90ae2da3 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -4003,7 +4013,6 @@ static void vxlan_config_apply(struct net_device *dev,
>  			       bool changelink)
>  {
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
> -	struct vxlan_rdst *dst = &vxlan->default_dst;
>  	unsigned short needed_headroom = ETH_HLEN;
>  	struct vxlan_config *old_cfg;
>  	int max_mtu = ETH_MAX_MTU;
> @@ -4021,13 +4030,7 @@ static void vxlan_config_apply(struct net_device *dev,
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

[Severity: Medium]
The assignment removed here was deliberately inside the if (lowerdev)
block, so default_dst.remote_ifindex kept the ifindex that the default FDB
entry had been created with even after IFLA_VXLAN_LINK was cleared. Now
that both the add and delete sites read the current cfg->remote_ifindex,
can the add/delete key stop matching?

vxlan_fdb_find_rdst() compares the ifindex exactly:

drivers/net/vxlan/vxlan_core.c:vxlan_fdb_find_rdst() {
	...
		if (vxlan_addr_equal(&rd->remote_ip, ip) &&
		    rd->remote_port == port &&
		    rd->remote_vni == vni &&
		    rd->remote_ifindex == ifindex)
			return rd;
	...
}

Sequence: create vxlan0 with "remote 192.0.2.20 dev eth0" (ifindex 5), so
vxlan_dev_create() stores rdst->remote_ifindex = 5. Then a changelink that
carries IFLA_VXLAN_LINK = 0 with the remote unchanged: vxlan_nl2conf()
takes the attribute (it is present, value 0), vxlan_config_validate()
accepts it for a unicast remote and returns *lower = NULL, rem_ip_changed
is false so no FDB work happens, and the published cfg now has
remote_ifindex = 0. A later changelink that does change the remote then
calls __vxlan_fdb_delete() with cfg->remote_ifindex == 0 (see the hunk
further down), vxlan_fdb_find_rdst() returns NULL and __vxlan_fdb_delete()
falls through to out: and returns 0 without deleting anything.

Since the new remote was added with NLM_F_APPEND just before, would BUM
and unknown unicast traffic then be flooded to both the stale and the new
remote?  vxlan_update_default_fdb_entry() in vxlan_vnifilter.c now takes
the same key from cfg->remote_ifindex, so per-VNI default entries created
before the link was cleared look equally undeletable.

> @@ -4087,10 +4090,8 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
>  	struct net_device *remote_dev = NULL;
>  	const struct vxlan_config *cfg;
> -	struct vxlan_rdst *dst;
>  	int err;
>  
> -	dst = &vxlan->default_dst;
>  	err = vxlan_dev_configure(net, dev, conf, extack);
>  	if (err)
>  		return err;
> @@ -4105,8 +4106,8 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
>  		return err;
>  	}
>  
> -	if (dst->remote_ifindex) {
> -		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
> +	if (cfg->remote_ifindex) {
> +		remote_dev = __dev_get_by_index(net, cfg->remote_ifindex);
>  		if (!remote_dev) {
>  			err = -ENODEV;
>  			goto unregister;
> @@ -4116,7 +4117,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
>  		if (err)
>  			goto unregister;
>  
> -		dst->remote_dev = remote_dev;
> +		vxlan->lowerdev = remote_dev;
>  	}

[Severity: Low]
This was the last writer of struct vxlan_rdst::remote_dev. After this
patch there is no reader or writer of that member left anywhere in the
tree (the only other remote_dev occurrences are the local variable in
vxlan_dev_create()), yet it stays declared in include/net/vxlan.h so every
FDB remote destination still carries the pointer. Should it be dropped
along with default_dst, like the other now-unused vxlan_rdst fields
mentioned in the changelog?

[ ... ]

> @@ -4571,20 +4572,19 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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

[Severity: Medium]
The old code replaced lowerdev with NULL when it was unchanged, and that
NULL was also what got passed to vxlan_config_apply() at the end of the
function. Now the resolved lower device is always passed. Does that make
vxlan_config_apply()'s lowerdev block run on every changelink of a device
that has a lower device, rather than only when the lower device changes?

drivers/net/vxlan/vxlan_core.c:vxlan_config_apply() {
	...
	if (lowerdev) {
		netif_inherit_tso_max(dev, lowerdev);

		needed_headroom = lowerdev->hard_header_len;
		needed_headroom += lowerdev->needed_headroom;

		dev->needed_tailroom = lowerdev->needed_tailroom;

		max_mtu = lowerdev->mtu - vxlan_headroom(flags);
		...
	}

	if (dev->mtu > max_mtu)
		dev->mtu = max_mtu;
	...
}

Note that vxlan_nl2conf() seeds conf from the old cfg, so a changelink
that does not mention IFLA_VXLAN_LINK still resolves the same lower device
and reaches this path.

Can dev->mtu then be silently lowered by a request that has nothing to do
with the MTU?  vxlan_netdevice_event() only handles NETDEV_UNREGISTER,
NETDEV_UDP_TUNNEL_PUSH_INFO and NETDEV_UDP_TUNNEL_DROP_INFO, so dev->mtu
can legitimately sit above lowerdev->mtu - vxlan_headroom():

  ip link add vxlan0 type vxlan id 10 remote 192.0.2.20 dev eth0 mtu 8000
      (eth0 mtu 9000)
  ip link set eth0 mtu 1500
  ip link set dev vxlan0 type vxlan ttl 5

Would the last command now rewrite dev->mtu to 1450?  The write is a plain
assignment rather than dev_set_mtu(), so no NETDEV_PRECHANGEMTU or
NETDEV_CHANGEMTU is emitted to stacked devices and offloading drivers.

> -	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
> +	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &cfg->remote_ip);
>  	change_igmp = vxlan->dev->flags & IFF_UP &&
>  		      (rem_ip_changed ||
> -		       dst->remote_ifindex != conf.remote_ifindex);
> +		       cfg->remote_ifindex != conf.remote_ifindex);
>  
>  	/* handle default dst entry */
>  	if (rem_ip_changed) {
> @@ -4600,19 +4600,20 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  					       NTF_SELF, 0, true, extack);
>  			if (err) {
>  				spin_unlock_bh(&vxlan->hash_lock);
> -				netdev_adjacent_change_abort(dst->remote_dev,
> -							     lowerdev, dev);
> +				if (vxlan->lowerdev != lowerdev)
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

[ ... ]

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
This part of the hunk is a second, independent behaviour change: clearing
IFLA_VXLAN_LINK previously left both the netdev adjacency and the tracked
lower device stale, and now the adjacency is unlinked and the pointer
cleared. The changelog covers it only as "properly unlink and clear
vxlan->lowerdev if the lower device is removed", and there is no Fixes:
tag, so it will not be picked up for stable on its own.

Would it be better as a separate patch with a Fixes: tag, so that the
stale-adjacency fix can be backported independently of the default_dst
refactor?

> diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
> index e2cf10da274f1..ae0320921c8ca 100644
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
This isn't a bug, but the two continuation lines in vxlan_group_used() lost
their open-parenthesis alignment and neither line mentions default_dst, so
the re-indentation looks unintended. checkpatch reports "Alignment should
match open parenthesis" here.

> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 7ced743ec8816..f90d43a9284c1 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -295,7 +295,7 @@ struct vxlan_dev {
>  #endif
>  	struct net_device *dev;
>  	struct net	  *net;		/* netns for packet i/o */
> -	struct vxlan_rdst default_dst;	/* default destination */
> +	struct net_device *lowerdev;
>  
>  	struct timer_list age_timer;
>  	spinlock_t	  hash_lock;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906180111.1973188-1-edumazet%40google.com
