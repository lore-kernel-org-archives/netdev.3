Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167A35CBC3
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890637; cv=none; b=sjXxHUsqsG7pii7elWz5xDzIDrz2kAnMbO8fKDs/jMXnEKVC4ne7QPif14H+QGLZErUw2sa7GeQ+d3LIzuRCnj9e1CcAHweKM1iWypDWXP99azGtGZ5NddyvNopsvGFRWPXvj2WR60wWqW+yVSKF3c7IDBum+KyxSWCEDL5ewBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890637; c=relaxed/simple;
	bh=h0NeAcbB04hs0xwd/Sv5Kl/DmIYaqCNijFkj1EM5n6o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jaVNYETcMEDvXn8coEApjgb3R6JQDPgHtH6LK8m8zaJlQIVkmGfE2s3YoVfkiBu8gTqZ1RSlHd2WwHe+Zmi1+eb5gofNIvBSmKJPUMM5v6A6gX2PedTJ2sx5qMPd7Gz2E3uSyhg2GPLuZRYj+IXpRU1Clk1UlCBbNKPFQONH9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPN9iCrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPN9iCrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893771F00A3A;
	Tue,  8 Sep 2026 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890635;
	bh=bsthyj88Znq5sAd8oK22hS6ZLsxhkLT6q5Qi+Y7lk0w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cPN9iCrUj7BSjrWeF+nrmaKT0brzF6AbdfPhmq3jUqhvF523ALvJg9ri81GsY7iQ8
	 p4QQ6oy71xxX5MUoxtrq/9JsweR5NE1orVjhYxek2ueahPnLWTypGzFHgAssTVHRPN
	 pX/7ZBKe4nSUhn5dGgo8YwQ2czvEpuFbxGF5/wbUHIQM6nI1EDSQpERawqBPWfjHXC
	 6TLxaTgJFeULuvwNpXRA8m9ijB9GsN3/P4HuHz1vyH72vErgmYhj5y9D283M2NihCB
	 nI690TJ+o+hUnQLG7+PH+9Fpcn8cwFCwRegxqzLYUnVZFzApSFj9qx5983M1GURRKu
	 XL5uBiJ/lJ/0w==
Subject:
 Re: [PATCH v2 net-next 5/8] vxlan: dynamically allocate struct vxlan_config
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 18:03:54 +0000
Message-ID: <178889063414.219967.17640576039088216642@kernel.org>
In-Reply-To: <20260906180111.1973188-6-edumazet@google.com>
References: <20260906180111.1973188-6-edumazet@google.com>
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

- [High] vxlan_config_apply() publishes the newly kmemdup()'ed
  configuration with a plain store and immediately reclaims the previous…
- [Medium] The freshly kmemdup()'ed vxlan_config is published with a
  plain assignment (`vxlan->cfg = new_cfg;`,…
- [Low] vxlan_encap_bypass() (drivers/net/vxlan/vxlan_core.c) newly
  treats `dst_vxlan->cfg == NULL` as a possible state (`if…
- [Low] vxlan_fdb_get() (drivers/net/vxlan/vxlan_core.c:1403-1421) adds
  NULL handling for vxlan->cfg only on the branch where NDA_VNI is…

--

vxlan: dynamically allocate struct vxlan_config

This moves struct vxlan_config out of struct vxlan_dev into a
dynamically allocated pointer vxlan->cfg.  vxlan_changelink() and
vxlan_dev_configure() now allocate a new config and free the old one.
A few questions below about the intermediate state this commit leaves
behind.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 9856ec710fa1d..5bc3475886b09 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -1396,18 +1402,23 @@ static int vxlan_fdb_get(struct sk_buff *skb,
>  			 struct netlink_ext_ack *extack)
>  {
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
> +	const struct vxlan_config *cfg;
>  	struct vxlan_fdb *f;
>  	__be32 vni;
>  	int err;
>  
> +	cfg = vxlan->cfg;
> +
>  	if (tb[NDA_VNI])
>  		vni = cpu_to_be32(nla_get_u32(tb[NDA_VNI]));
> +	else if (cfg)
> +		vni = cfg->vni;
>  	else
> -		vni = vxlan->default_dst.remote_vni;
> +		return -ENODEV;
>  
>  	rcu_read_lock();
>  
> -	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, addr, vni);
> +	f = vxlan_find_mac_rcu(vxlan, cfg, addr, vni);

[Severity: Low]
Are the two branches here meant to disagree about whether cfg can be
NULL?

When user space passes NDA_VNI the new -ENODEV check is skipped, and the
same possibly-NULL pointer is handed to vxlan_find_mac_rcu(), which
dereferences it right away:

	if (!(cfg->flags & VXLAN_F_COLLECT_METADATA))
		key.vni = cfg->vni;

Tracing it through, vxlan->cfg is set by vxlan_config_apply() from
vxlan_dev_configure() before register_netdevice(), and only cleared by
vxlan_free_dev() (the register_netdevice() failure path, or the
priv_destructor after unregistration), so a device reachable via
__dev_get_by_index() under RTNL always has a non-NULL cfg and the
-ENODEV branch looks like dead code.

Would it be clearer to drop the NULL test rather than have half of the
function defend against a state the other half assumes cannot happen?
The same asymmetry appears in vxlan_open() and vxlan_sock_release(),
where cfg is tested for NULL after vxlan_sock_add()/__vxlan_sock_add()
have already dereferenced it unconditionally.  It is still present at
the end of the series.

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

[Severity: High]
Can this read freed memory?

vxlan_rcv() runs in softirq for every received frame and now caches a
plain pointer to a kmalloc()'ed object, while the only writer,
vxlan_config_apply(), releases the old object synchronously under RTNL:

	old_cfg = vxlan->cfg;
	vxlan->cfg = new_cfg;
	kfree(old_cfg);

So:

CPU0 (softirq)                     CPU1 (RTNL, ip link set ... type vxlan)
vxlan_rcv()
  cfg = vxlan->cfg;
                                   vxlan_changelink()
                                     vxlan_config_apply()
                                       vxlan->cfg = new_cfg;
                                       kfree(old_cfg);
  cfg->reserved_bits.vx_flags        <- freed

The same pattern applies to vxlan_vs_find_vni(), which dereferences
another device's cfg on every RX VNI lookup, and to vxlan_xmit(), which
propagates the cached pointer into arp_reduce(), neigh_reduce(),
vxlan_find_mac_tx(), vxlan_xmit_one() and vxlan_vnifilter_count().

The following patch in the series, "vxlan: convert configuration to RCU
protection", adds a struct rcu_head to struct vxlan_config, switches
publication to rcu_assign_pointer() plus kfree_rcu() and converts the
readers to rcu_dereference() inside RCU read sections, so the end state
of the series is fine.  Would it be better to fold that change in here,
or to at least use kfree_rcu() in this commit, so that this intermediate
commit is not a bisect or backport hazard on its own?

[ ... ]

> @@ -2284,7 +2299,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
>  			       const struct vxlan_config *src_cfg,
>  			       __be32 vni, bool snoop)
>  {
> -	const struct vxlan_config *dst_cfg = &dst_vxlan->cfg;
> +	const struct vxlan_config *dst_cfg;
>  	union vxlan_addr loopback;
>  	unsigned int len = skb->len;
>  	struct net_device *dev = dst_vxlan->dev;
> @@ -2305,7 +2320,8 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
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
If the !dst_cfg case is really possible, does the drop label then
dereference NULL?

The goto lands on the shared drop label, which forwards the same pointer
on:

drop:
		dev_dstats_rx_dropped(dev);
		vxlan_vnifilter_count(dst_vxlan, dst_cfg, vni, NULL,
				      VXLAN_VNI_STATS_RX_DROPS, 0);

and this same commit removes the NULL tolerance from that helper (see
the vxlan_vnifilter_count() hunk below), so it starts with
cfg->flags.

As far as I can tell dst_vxlan->cfg cannot be NULL for a device that is
reachable through the VNI hash: devices are only inserted from
vxlan_vs_add_dev()/vxlan_vs_add_vnigrp() during ndo_open, and cfg is
populated before register_netdevice() and cleared only by
vxlan_free_dev().  So the new test appears unreachable, but caller and
callee end up with opposite contracts.

A later patch in the series, "vxlan: remove default_dst and use
vxlan_config and lowerdev", changes the drop label to guard the call
with if (dst_cfg).  Could that guard come with this hunk instead, or
could the !dst_cfg test be dropped here?

[ ... ]

> @@ -2771,7 +2787,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>  	u32 nhid = 0;
>  	u32 flags;
>  
> -	cfg = &vxlan->cfg;
> +	cfg = vxlan->cfg;
>  	flags = cfg->flags;
>  	default_vni = cfg->vni;
>  	saddr_family = cfg->saddr.sa.sa_family;

[ ... ]

> @@ -2890,12 +2906,15 @@ static void vxlan_cleanup(struct timer_list *t)
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
> @@ -2905,7 +2924,7 @@ static void vxlan_cleanup(struct timer_list *t)
>  		if (f->flags & NTF_EXT_LEARNED)
>  			continue;
>  
> -		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
> +		timeout = READ_ONCE(f->updated) + cfg->age_interval * HZ;

[Severity: High]
Does the rcu_read_lock() here buy anything while the writer uses plain
kfree()?

cfg is loaded once and read across the whole FDB walk in the ageing
timer softirq, but vxlan_config_apply() frees the old config
immediately, without waiting for a grace period, so this looks like the
same use-after-free window as in vxlan_rcv()/vxlan_xmit().

[ ... ]

> @@ -3984,7 +4040,9 @@ static void vxlan_config_apply(struct net_device *dev,
>  	needed_headroom += vxlan_headroom(flags);
>  	dev->needed_headroom = needed_headroom;
>  
> -	memcpy(&vxlan->cfg, conf, sizeof(*conf));
> +	old_cfg = vxlan->cfg;
> +	vxlan->cfg = new_cfg;
> +	kfree(old_cfg);
>  }

[Severity: Medium]
Should the publication of new_cfg use release semantics?

The object comes straight out of kmemdup() and is published with a plain
store, while vxlan_rcv(), vxlan_xmit(), vxlan_vs_find_vni(),
vxlan_cleanup() and vxlan_fill_metadata_dst() consume it with plain
loads.  There is no rcu_assign_pointer()/smp_store_release() on the
write side and no rcu_dereference()/READ_ONCE() on the read side.

On weakly ordered architectures, can a softirq reader observe the new
pointer before the kmemdup() payload stores are visible, and then act on
stale cfg->flags, cfg->dst_port or cfg->reserved_bits?

The field is also declared as a plain pointer rather than __rcu (see the
include/net/vxlan.h hunk), so sparse cannot flag the missing
primitives.  The follow-up patch "vxlan: convert configuration to RCU
protection" adds the __rcu annotation and rcu_assign_pointer(), so this
gap exists only at this commit.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index f7b60855a05f4..4fba3579774a7 100644
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
Is removing the !cfg test here intentional in the same patch that adds a
NULL-tolerant caller?

vxlan_encap_bypass() now treats dst_vxlan->cfg == NULL as a reachable
state and still reaches this helper through its drop label, so the two
sides of the call disagree about the contract.

> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index d323f91af2364..10f56b5f5206c 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -302,7 +302,7 @@ struct vxlan_dev {
>  	struct gro_cells  gro_cells;
>  	unsigned long	  flags;
>  
> -	struct vxlan_config	cfg;
> +	struct vxlan_config	*cfg;

[Severity: Medium]
Since this pointer is already read locklessly from softirq contexts in
this commit, would annotating it __rcu here (as the following patch
does) make the missing rcu_dereference() sites visible to sparse right
away?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906180111.1973188-1-edumazet%40google.com
