Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A738E5FE
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761488; cv=none; b=kvO5otJCawyin02jazm2EcV2SFo7g+ybT+IIA7SPBBCuwW3gXOlarqB51neeLVTlekjnE2m8MHUh5KcHVPjz5OKfKq8AWEIZzerFdkHCikdFb9hVcr5XXzClKW6++sPQBVNkHhxzhL+3iBIWoWgAY282GLFMa/QczqVn8cKZAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761488; c=relaxed/simple;
	bh=GSHQUMfMJvBUlEIHuo3uqsDw7xP3/SlPZMHcLjpesNM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Myfybs5YSgVH18moqWwUao8973WXQxhnKI5NtRLB+4x+sIECen+cg8kWOBAOCiNunIE4A3q3Jr3I+K/iUXXi2Ox+gjW8AfB3BErE+NCG9pZyxtuAPW044BttnH/bU3XbUDufbqDPRe/w999djbasexmThu2GgW6OuCf6JueO9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+4y7ZAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+4y7ZAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B542D1F00A3E;
	Mon,  7 Sep 2026 06:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761486;
	bh=cfGFNpYXmXrL9dTh3l9qCx+WmDGYiPtCLI00fDEcKWM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E+4y7ZADFSBszqw2AKb4jSUK9JO47Z+uP4X60THXFiz1EuxDNCVvZEP8mi6TinptM
	 /+234j1iGm4ea97nDvqu+XxMGZhMkNRRpCGlmxu5tjL4zXmSmedBnTkBi9mz8+g215
	 VT2bnbXWlpbl+6ItKhXhVxYa3Itot5Xu0qKbbCZrALGZvs4AVqNmdu6QlymFv0zlLh
	 sdLkr+vsQ4XyGtMT3MWHAtCrkbfEG12pjB7NPuig2ynkxSeDiS6qPA9kYf9qGq8Sxn
	 NwPL4XKLmB+qfyxSxnkMMm/dgw3fVL3+edsdrjoQucKeKvAqlyhYLDcQm5J9tZZaWN
	 fHdTu2NYNViwQ==
Subject:
 Re: [PATCH net-next 6/9] vxlan: dynamically allocate struct vxlan_config
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 07 Sep 2026 06:11:25 +0000
Message-ID: <178876148532.219967.4493447289054249092@kernel.org>
In-Reply-To: <20260903120840.1024153-7-edumazet@google.com>
References: <20260903120840.1024153-7-edumazet@google.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] vxlan_config_apply() publishes the newly allocated config with a
  plain store and immediately reclaims the old one with a bare kfree()…
- [Medium] The new configuration pointer is published with a plain store
  (vxlan_core.c:4038 `vxlan->cfg = new_cfg;`) right after the payload is…
- [Low] vxlan_encap_bypass() adds a `!dst_cfg` NULL test whose error
  branch (`goto drop`) lands on the `drop:` label, and that label passes…
- [Low] The patch introduces two mutually exclusive assumptions about
  vxlan->cfg for a live/registered netdev, on the same code paths.

--

vxlan: dynamically allocate struct vxlan_config

This moves struct vxlan_config out of struct vxlan_dev into a separately
allocated object referenced by vxlan->cfg, with vxlan_changelink() and
vxlan_dev_configure() allocating a new config and freeing the old one.
It is described as preparation for converting vxlan->cfg to RCU
protection in the following patch.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 0fcc7282e69d..af320173a1e7 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -110,20 +110,23 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
>  		vni = 0;
>  
>  	hlist_for_each_entry_rcu(node, vni_head(vs, vni), hlist) {
> +		const struct vxlan_config *cfg;
> +
>  		if (!node->vxlan)
>  			continue;
> +
> +		cfg = node->vxlan->cfg;
> +
>  		vnode = NULL;
> -		if (node->vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
> +		if (cfg->flags & VXLAN_F_VNIFILTER) {
>  			vnode = vxlan_vnifilter_lookup(node->vxlan, vni);
>  			if (!vnode)
>  				continue;
> -		} else if (node->vxlan->default_dst.remote_vni != vni) {
> +		} else if (cfg->vni != vni) {
>  			continue;
>  		}

[Severity: High]
This per-packet RX lookup now walks other devices' cfg pointers with a
plain load.  Combined with the plain kfree() added in vxlan_config_apply()
below, can this dereference freed memory?

CPU0 (RTNL, ip link set ... type vxlan ...)
  vxlan_changelink()
    vxlan_config_apply()
      old_cfg = vxlan->cfg;
      vxlan->cfg = new_cfg;
      kfree(old_cfg);          <-- no grace period

CPU1 (RX softirq)
  vxlan_rcv()
    vxlan_vs_find_vni()
      cfg = node->vxlan->cfg;  <-- may already be old_cfg
      if (cfg->flags & VXLAN_F_VNIFILTER)   <-- use-after-free

[ ... ]

> @@ -1510,6 +1521,7 @@ static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
>  
>  static void vxlan_sock_release(struct vxlan_dev *vxlan)
>  {
> +	const struct vxlan_config *cfg = vxlan->cfg;
>  	struct vxlan_sock *sock4 = rtnl_dereference(vxlan->vn4_sock);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
> @@ -1519,7 +1531,7 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
>  
>  	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
>  
> -	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
> +	if (cfg && (cfg->flags & VXLAN_F_VNIFILTER))
>  		vxlan_vs_del_vnigrp(vxlan);
>  	else
>  		vxlan_vs_del_dev(vxlan);

[Severity: Low]
Can cfg actually be NULL here?  The caller vxlan_stop() dereferences the
same pointer unconditionally a couple of statements earlier:

vxlan_stop()
  vxlan_multicast_leave(vxlan)
    if (vxlan->cfg->flags & VXLAN_F_VNIFILTER)   <-- no NULL check
  timer_delete_sync(&vxlan->age_timer);
  vxlan_flush(vxlan, &desc);
  vxlan_sock_release(vxlan)
    if (cfg && (cfg->flags & VXLAN_F_VNIFILTER)) <-- NULL check

The same disagreement shows up in several other pairs added by this patch:
vxlan_open() tests "cfg && cfg->age_interval" after vxlan_sock_add() and
__vxlan_sock_add() already read cfg->flags unguarded, vxlan_uninit() tests
"cfg &&" while its ndo_init counterpart vxlan_init() uses cfg->flags
directly, and vxlan_fdb_get() returns -ENODEV for a NULL cfg while
vxlan_fdb_parse() on the same registered device dereferences cfg->dst_port
and cfg->vni without a check.

Since vxlan->cfg is cleared only in vxlan_free_dev(), the priv_destructor,
which runs from free_netdev() after the device is unregistered (and
rtnl_newlink_create() calls free_netdev() directly on ->newlink failure
without invoking ndo_uninit), it looks like none of the netdev ops can
observe NULL, making these guards and the new -ENODEV path dead code.
Would it be clearer to drop the checks and keep the invariant uniform?
These mixed assumptions also remain at the end of the series.

[ ... ]

> @@ -1692,7 +1704,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  		goto drop;
>  	}
>  
> -	cfg = &vxlan->cfg;
> +	cfg = vxlan->cfg;
> +
>  	if (vh->vx_flags & cfg->reserved_bits.vx_flags ||
>  	    vh->vx_vni & cfg->reserved_bits.vx_vni) {
>  		/* If the header uses bits besides those enabled by the

[Severity: Medium]
The pointer is loaded plainly here and used for many dereferences
(cfg->reserved_bits, cfg->flags) while vxlan_config_apply() publishes the
kmemdup()'ed replacement with a plain store.

Without a release barrier on the writer side (rcu_assign_pointer() or
smp_store_release()) and a dependency-ordering load on the reader side
(rcu_dereference()/READ_ONCE()), can a reader on a weakly ordered CPU see
the new pointer before the kmemdup'ed payload stores are visible, and act
on stale flags/reserved_bits/dst_port/saddr values?

The field is also declared without __rcu in include/net/vxlan.h, so sparse
cannot flag the missing accessors.  The following patch, "vxlan: convert
configuration to RCU protection", adds __rcu plus
rcu_assign_pointer()/rcu_dereference() at these sites, so would it be
reasonable to fold the annotation into this patch instead of leaving an
intermediate commit without ordering?

[ ... ]

> @@ -2278,7 +2293,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
>  			       const struct vxlan_config *src_cfg,
>  			       __be32 vni, bool snoop)
>  {
> -	const struct vxlan_config *dst_cfg = &dst_vxlan->cfg;
> +	const struct vxlan_config *dst_cfg;
>  	union vxlan_addr loopback;
>  	unsigned int len = skb->len;
>  	struct net_device *dev = dst_vxlan->dev;
> @@ -2299,7 +2314,8 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
>  	}
>  
>  	rcu_read_lock();
> -	if (unlikely(!(dev->flags & IFF_UP))) {
> +	dst_cfg = dst_vxlan->cfg;
> +	if (unlikely(!dst_cfg || !(dev->flags & IFF_UP))) {
>  		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
>  		goto drop;
>  	}

[Severity: Low]
If the new !dst_cfg branch is ever taken, where does it land?  The goto
jumps to the drop label at the end of the same function, which passes the
same NULL dst_cfg straight into vxlan_vnifilter_count():

drop:
	dev_dstats_rx_dropped(dev);
	vxlan_vnifilter_count(dst_vxlan, dst_cfg, vni, NULL,
			      VXLAN_VNI_STATS_RX_DROPS, 0);

and this patch also removes the "!cfg ||" guard from that helper in
vxlan_vnifilter.c, so it now starts with:

	if (!(cfg->flags & VXLAN_F_VNIFILTER))
		return;

That would be a NULL dereference in softirq context.  The check appears to
be unreachable today, since vxlan->cfg is only cleared in vxlan_free_dev()
after the device is gone from the VNI hash, so is the new test needed at
all?  A later patch in the series, "vxlan: remove default_dst and use
vxlan_config and lowerdev", wraps the drop-path call in "if (dst_cfg)",
which suggests the intent was for the check to be live.

[ ... ]

> @@ -2765,7 +2781,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>  	u32 nhid = 0;
>  	u32 flags;
>  
> -	cfg = &vxlan->cfg;
> +	cfg = vxlan->cfg;
>  	flags = cfg->flags;
>  	default_vni = cfg->vni;
>  	saddr_family = cfg->saddr.sa.sa_family;

[Severity: High]
This pointer is cached at function entry, outside any rcu_read_lock() in
this commit, and then handed to arp_reduce(), neigh_reduce(),
vxlan_xmit_one(), vxlan_xmit_nh(), vxlan_mdb_xmit() and
vxlan_vnifilter_count() for the duration of the transmit.  Can a
concurrent changelink free it underneath?

Before this patch the config was embedded in vxlan_dev and updated in
place, so a racing reader could only see a torn config.  Now the reader can
see freed slab memory, and vxlan_xmit_one() feeds cfg->saddr, cfg->ttl,
cfg->tos, cfg->label and cfg->dst_port into the encapsulation headers.

[ ... ]

> @@ -2884,12 +2900,15 @@ static void vxlan_cleanup(struct timer_list *t)
>  {
>  	struct vxlan_dev *vxlan = timer_container_of(vxlan, t, age_timer);
>  	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
> +	const struct vxlan_config *cfg;
>  	struct vxlan_fdb *f;
>  
>  	if (!netif_running(vxlan->dev))
>  		return;
>  
>  	rcu_read_lock();
> +	cfg = vxlan->cfg;
> +
>  	hlist_for_each_entry_rcu(f, &vxlan->fdb_list, fdb_node) {
>  		unsigned long timeout;
>  
> @@ -2899,7 +2918,7 @@ static void vxlan_cleanup(struct timer_list *t)
>  		if (f->flags & NTF_EXT_LEARNED)
>  			continue;
>  
> -		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
> +		timeout = READ_ONCE(f->updated) + cfg->age_interval * HZ;

[Severity: High]
The rcu_read_lock() here gives no protection against the plain kfree() in
vxlan_config_apply(), so can the timer softirq read cfg->age_interval from
a freed object across the whole FDB walk?

[ ... ]

> @@ -3247,14 +3276,18 @@ static int vxlan_change_mtu(struct net_device *dev, int new_mtu)
[ ... ]
> @@ -3381,6 +3417,14 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
>  	}
>  }
>  
> +static void vxlan_free_dev(struct net_device *dev)
> +{
> +	struct vxlan_dev *vxlan = netdev_priv(dev);
> +
> +	kfree(vxlan->cfg);
> +	vxlan->cfg = NULL;
> +}
> +

[ ... ]

> @@ -3978,7 +4034,9 @@ static void vxlan_config_apply(struct net_device *dev,
>  	needed_headroom += vxlan_headroom(flags);
>  	dev->needed_headroom = needed_headroom;
>  
> -	memcpy(&vxlan->cfg, conf, sizeof(*conf));
> +	old_cfg = vxlan->cfg;
> +	vxlan->cfg = new_cfg;
> +	kfree(old_cfg);
>  }

[Severity: High]
This is the writer side of the use-after-free discussed above.  RTNL is
held here, but none of the readers (vxlan_xmit(), vxlan_rcv(),
vxlan_vs_find_vni(), vxlan_cleanup(), vxlan_fill_metadata_dst(),
mlxsw_sp_switchdev_vxlan_work_prepare()) hold RTNL, and there is no grace
period, refcount or shared lock between them.  Can the old config be freed
while an in-flight packet still dereferences it?

Since the commit message says this prepares for the RCU conversion in the
following patch, would it make sense to use kfree_rcu() (adding the
rcu_head in this patch) so the intermediate commit is not a bisect and
backport hazard?

[Severity: Medium]
Separately from the lifetime problem, this publishes a pointer to freshly
kmemdup()'ed data with a plain store.  Should this be rcu_assign_pointer()
(or at least smp_store_release()) so readers cannot observe the pointer
before the payload writes?

[ ... ]

> @@ -3987,13 +4045,18 @@ static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
>  {
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
>  	struct net_device *lowerdev;
> +	struct vxlan_config *new_cfg;
>  	int ret;
>  
>  	ret = vxlan_config_validate(src_net, conf, &lowerdev, vxlan, extack);
>  	if (ret)
>  		return ret;
>  
> -	vxlan_config_apply(dev, conf, lowerdev, src_net, false);
> +	new_cfg = kmemdup(conf, sizeof(*conf), GFP_KERNEL);
> +	if (!new_cfg)
> +		return -ENOMEM;
> +
> +	vxlan_config_apply(dev, new_cfg, lowerdev, src_net, false);
>  
>  	return 0;
>  }

[ ... ]

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index c46d57164936..8f6c01930ace 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -178,7 +178,7 @@ void vxlan_vnifilter_count(struct vxlan_dev *vxlan,
>  {
>  	struct vxlan_vni_node *vnode;
>  
> -	if (!cfg || !(cfg->flags & VXLAN_F_VNIFILTER))
> +	if (!(cfg->flags & VXLAN_F_VNIFILTER))
>  		return;

[Severity: Low]
Dropping the "!cfg ||" guard here makes every caller responsible for a
non-NULL cfg, which conflicts with the new !dst_cfg branch added in
vxlan_encap_bypass() that reaches its drop label with dst_cfg still NULL
and then calls this helper.  Should the two changes agree one way or the
other?

>  
>  	if (vninode) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903120840.1024153-1-edumazet%40google.com
