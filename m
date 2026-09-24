Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5F18B0A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208723; cv=none; b=goNEbNwvOvM3+IPvcCZRJ9NhBZjnJLRYfXYXKhjUS5FhecmB5+ZfWRnMF8bdHbkMmjG3stSrgFSUYiCERlQdU2sBvyJOgb9I1hOiBR0Q0PVvtHWGYw1LZQ0lbxfDNxcXaittzI/2n2mipFJczlYulxA3tvmfXoHwBR/nxae0jkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208723; c=relaxed/simple;
	bh=nYKn9WmSubelTboXGDTkpRe77oRhzKr1eTvL06iiOrQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwUYEAaYzFcLDqxISCRug0kzKyy8nIKE5Z84yRvtk00U3sbkpeqU3O1qnN9lfANuLRGj2mgUbFoVcCR+x2EaqiuYEb/k+dEx3Luj6U2agUU4Ts5cVntJkaCdkWCaf3yUl8sBvNPt83gOE9UNmfepczdpFQHto8f7Q5hfpTIPpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLPewFCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLPewFCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701D11F000FF;
	Thu, 24 Sep 2026 00:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208718;
	bh=+qFYRSUo8GlDaBI66Lpwh+MUr7k1CVQ/ajh/E5+msAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oLPewFCB6yOzr/UYGHpMk6+woRxm0p1xhJzJFlYp8rdMkOZiL6zmDwKAuNg6Jqpvd
	 d6PUsBeSx6OQuaSPoEMP250f+mOBNst7uNcPbBfymD14X9HF1Bz/MGDDtRfTM1C5m+
	 gkQf7/+Q/LPyKWWQkJK8SCgw73VIiycbtPRTFRrPSdgUBCxM3aQ9TtPagHDFVmcSLa
	 vLbwWu2slb9Mn1eihgQ/PBLqe307qs7+vf9lVNfNVT/ofxVJBJkE26HZaMqcGZu6OZ
	 lK60QsrHlTGdyAazZrrWTY5nGYot/rjMMZB2T/f1FCCXTkB7X2eUKzr7H8lvK89+xO
	 pDnI09kKWvmag==
Subject: Re: [PATCH v6 net-next 7/8] vxlan: remove default_dst and use
 vxlan_config and lowerdev
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Thu, 24 Sep 2026 00:11:57 +0000
Message-ID: <179020871799.2160803.5568318276736693193@kernel.org>
In-Reply-To: <20260922181102.3989489-8-edumazet@google.com>
References: <20260922181102.3989489-8-edumazet@google.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] vxlan_config_apply() unconditionally stores
  dev->needed_tailroom = 0 (vxlan_core.c:4046) and only afterwards,…
- [Low] The patch subject advertises a pure data-structure cleanup
  ("remove default_dst and use vxlan_config and lowerdev") but it also…
- [Low] vxlan_config_apply() now explicitly resets dev->needed_tailroom =
  0 before the `if (lowerdev)` block (and re-derives needed_headroom…
- [Low] Two newly added declarations violate the netdev reverse-xmas-tree
  local variable ordering rule: in vxlan_fdb_add()…

--

vxlan: remove default_dst and use vxlan_config and lowerdev

This drops vxlan->default_dst, replacing it with a plain
struct net_device *lowerdev pointer in struct vxlan_dev and moving all
remaining readers of remote_ip / remote_vni / remote_ifindex over to
vxlan->cfg.  vxlan_config_apply() gains a lowerdev_changed argument, and
vxlan_changelink() now only touches the upper/lower adjacency when the
lower device actually changes.

A few questions below.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index dc4e8558c5a9f..8116ede68ac74 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -1249,6 +1251,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
>  			 const unsigned char *addr, u16 vid, u16 flags,
>  			 bool *notified, struct netlink_ext_ack *extack)
>  {
> +	const struct vxlan_config *cfg;
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
>  	/* struct net *net = dev_net(vxlan->dev); */
>  	union vxlan_addr ip;

[Severity: Low]
This isn't a bug, but does this break the reverse xmas tree ordering netdev
asks for?  The new declaration

	const struct vxlan_config *cfg;

is shorter than the following

	struct vxlan_dev *vxlan = netdev_priv(dev);

The same inversion appears in vxlan_mdb_get_parse() in
drivers/net/vxlan/vxlan_mdb.c, where const struct vxlan_config *cfg; is
inserted ahead of struct vxlan_dev *vxlan = netdev_priv(dev);.  The other
hunks in this patch (vxlan_changelink(), vxlan_change_mtu(),
vxlan_get_link_ksettings()) do keep the ordering.

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

[Severity: Low]
Should these behaviour changes be split out of the cleanup, with Fixes:
tags?  The subject describes a data structure cleanup, but three separate
user-visible changes ride along:

First, the new -EINVAL above rejects a request that previously succeeded as
a no-op: clearing IFLA_VXLAN_LINK on a VNIFILTER device that has per-VNI
multicast groups.  That is a netlink policy change.

Second, the commit message says:

    In vxlan_changelink(), pass lowerdev to vxlan_config_apply() to preserve
    needed_headroom and needed_tailroom.

This looks like a fix for a real bug.  Before the patch vxlan_changelink()
did:

	if (dst->remote_dev == lowerdev)
		lowerdev = NULL;
	...
	vxlan_config_apply(dev, new_cfg, lowerdev, vxlan->net, true);

and vxlan_config_apply() only adds the lower device contributions inside
if (lowerdev), so any changelink that did not touch IFLA_VXLAN_LINK (for
example ageing or learning) recomputed dev->needed_headroom as bare
ETH_HLEN + vxlan_headroom(flags), losing the lower device's
hard_header_len and needed_headroom.

Third, the commit message says:

    Setting IFLA_VXLAN_LINK to 0 now also tears down the upper/lower
    adjacency, which netdev_adjacent_change_commit() used to skip for a NULL
    new device

which is a second fix, since netdev_adjacent_change_commit() early-returns:

net/core/dev.c:netdev_adjacent_change_commit() {
	if (!new_dev || !old_dev)
		return;
	...
}

Would it be reasonable to split the two repairs into their own patches with
Fixes: tags so they can be picked up for stable independently of the RCU
cfg conversion this patch depends on?

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

[Severity: Medium]
Does this open a window where lockless readers observe
dev->needed_tailroom == 0?

The field is zeroed unconditionally here and only restored a few lines
later inside if (lowerdev):

	dev->needed_tailroom = 0;
	if (lowerdev) {
		...
		dev->needed_tailroom = lowerdev->needed_tailroom;

Since vxlan_changelink() now always passes the (possibly unchanged)
lowerdev, this zero/restore sequence runs on every changelink of a live
device, including ones that only change ageing, learning or proxy.  Before
the patch the field was left alone in that case because lowerdev had been
nulled.

The readers of dev->needed_tailroom hold no lock at all, for example:

net/core/skbuff.c:skb_ensure_writable_head_tail() {
	int needed_tailroom = dev->needed_tailroom;
	...
}

and arp_create(), igmp_send_report(), ndisc_alloc_skb(), af_packet
sendmsg/tpacket and xsk do the same.  With a lower device that has non-zero
needed_tailroom (DSA tag_trailer/tag_ksz/tag_sja1105, xfrm interface,
mac802154) a reader sampling 0 ends up allocating without the required
tailroom and pays a pskb_expand_head() later.

Both stores are also plain, while the neighbouring dev->mtu stores in the
same function are deliberately converted to WRITE_ONCE() by this patch.
Would computing the value into a local and doing a single
WRITE_ONCE(dev->needed_tailroom, val) match the treatment given to
dev->mtu here?

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
Should netif_inherit_tso_max() be undone as well when the lower device goes
away?

dev->needed_tailroom is now explicitly reset to 0 and needed_headroom is
re-derived from the local ETH_HLEN initializer, so clearing
IFLA_VXLAN_LINK drops those two lower device contributions.  The third
attribute inherited in the same if (lowerdev) block,

		netif_inherit_tso_max(dev, lowerdev);

has no counterpart reset.

After a changelink that removes the lower device (a state this patch makes
reachable, since vxlan_changelink() now unlinks and passes
lowerdev == NULL), does the vxlan device keep advertising the removed lower
device's tso_max_size/tso_max_segs, along with any gso_max_size /
gso_ipv4_max_size reduction netif_set_tso_max_size() applied?  A later
changelink without a link takes the same NULL branch, so nothing appears to
recompute those values.

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

Thanks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922181102.3989489-1-edumazet%40google.com
