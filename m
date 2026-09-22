Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24493516144
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092950; cv=none; b=kjWcZEULCWjnETPNvMmoSvuFKbZsl45M4LD6cacP4TGXaN+4ceAdZ1uok2u5u83rSOGg5RNxmoslO8gM7uIchnFZw902jBTWbP/+2Yhplp0jmSt4I6o1g+Sg/bnWqWYG2aiU/jLScWX4KJBjtKzAE4D3Y2bzVIgxepqZZd8zbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092950; c=relaxed/simple;
	bh=DMJXaHTUtvyDpY2B056sHR57Z/SBxeOdawRNalkN5Zs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M90nGNgtjvTmg10nS7uSsHOH5qmpQ2rpHuMJI8XZVGKGcxxYEg1F7WSAYv/0/cyyYqF7XBTmQC8HrLVuTXxbVIqnSJuEJi3/GI2RWjYBMP3arfRhNgMjGtwnMW3kk8Bfk2AGDm0QxbXikym93hjCNaOvH12MHsLDampWw3DuCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTsw/G/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTsw/G/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF931F000FF;
	Tue, 22 Sep 2026 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092948;
	bh=yHkv64Rb9PD32TmnOnObxFMDksoGqO0i2tcZhAOkSPQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XTsw/G/zkWWjeONHnQms4pGI8auS6wJ5q51Douokv6qwVlSbisg7qMQxLbCNFFOe0
	 MbRXCeBNlugjBDZyfnv3p/VG8yR/WiS9aztiwdqwoQeM1oEZ8Zcg7F8dao8F3v5yA7
	 8hOsYPlsUId99dsIS0h4wv4C0eCdi6X5k5K2Memc82a8GZxHncPJ57Hh2rUb0Zx1vC
	 0OnomAciMcRkDGJqnaLnjmg3LjL0h3qj4POyvaV4mk8ZpVe4de/oPDBB5NabhRLhmM
	 AYobiZ9JeeYI7x5xGOC8z/ygZA8D3lmRUGQkMOkHhNcdZ4Y7qYnkxD3YCSJ+/bN0ic
	 C1gs+e+8Y3CpQ==
Subject: Re: [PATCH v5 net-next 1/8] vxlan: update default fdb entries when
 the lower device changes
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 22 Sep 2026 16:02:27 +0000
Message-ID: <179009294790.2160803.1798518165297205299@kernel.org>
In-Reply-To: <20260921100139.508191-2-edumazet@google.com>
References: <20260921100139.508191-2-edumazet@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] vxlan_changelink() (drivers/net/vxlan/vxlan_core.c:4538-4554)
  now routes every VXLAN_F_VNIFILTER device through…
- [Medium] Both rollback paths added by this patch ignore the int return
  value of vxlan_update_default_fdb_entry(): the err_unwind loop in…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it directly
  undermines the bug class the patch targets.

--

vxlan: update default fdb entries when the lower device changes

This refreshes the all zeros mac fdb entries when a changelink only swaps
the lower device, by passing the old and new ifindex down to
vxlan_update_default_fdb_entry() and visiting every vni rather than only
the ones inheriting the device group.  It also runs the multicast
leave/join pair for VXLAN_F_VNIFILTER devices and unwinds already updated
fdb entries when the vni list update fails partway through.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 347245cc1de4e..c4e3e8e8eef57 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -4475,13 +4476,16 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (err)
>  		return err;
>  
> +	/* vxlan_config_apply() only commits remote_ifindex if lowerdev is set */
> +	new_ifindex = lowerdev ? conf.remote_ifindex : dst->remote_ifindex;
> +
>  	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
>  	change_igmp = vxlan->dev->flags & IFF_UP &&
>  		      (rem_ip_changed ||
> -		       dst->remote_ifindex != conf.remote_ifindex);
> +		       dst->remote_ifindex != new_ifindex);
>  
>  	/* handle default dst entry */
> -	if (rem_ip_changed) {
> +	if (rem_ip_changed || dst->remote_ifindex != new_ifindex) {

[ ... ]

> @@ -4509,13 +4513,21 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  					   true);
>  		spin_unlock_bh(&vxlan->hash_lock);
>  
> -		/* If vni filtering device, also update fdb entries of
> -		 * all vnis that were using default remote ip
> +		/* If vni filtering device, also update default fdb entries of
> +		 * all vnis
>  		 */
>  		if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
>  			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
> -							 &conf.remote_ip, extack);
> +							 &conf.remote_ip,
> +							 dst->remote_ifindex,
> +							 new_ifindex, extack);
>  			if (err) {
> +				vxlan_update_default_fdb_entry(vxlan, conf.vni,
> +							       &conf.remote_ip,
> +							       &dst->remote_ip,
> +							       new_ifindex,
> +							       dst->remote_ifindex,
> +							       NULL);
>  				netdev_adjacent_change_abort(dst->remote_dev,
>  							     lowerdev, dev);
>  				return err;
> @@ -4523,7 +4535,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  		}
>  	}
>  
> -	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
> +	if (change_igmp &&
> +	    (vxlan_addr_multicast(&dst->remote_ip) ||
> +	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
>  		err = vxlan_multicast_leave(vxlan);

[Severity: High]
Can this leave/join pair end up leaving a running vnifilter device with no
multicast memberships at all?

For VXLAN_F_VNIFILTER the leave reaches
vxlan_multicast_leave() -> vxlan_multicast_leave_vnigrp(), which issues one
vxlan_igmp_leave() per vni entry:

	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
		if (vxlan_addr_multicast(&v->remote_ip) &&
		    !vxlan_group_used(vn, vxlan, v->vni, &v->remote_ip,
				      0)) {
			ret = vxlan_igmp_leave(vxlan, &v->remote_ip, 0);
			if (ret)
				last_err = ret;
		}
	}

A single "bridge vni add dev vxlan0 vni 100-200 group 239.1.1.1" gives every
vni in the range the same group, so all of those entries share one socket
membership.  The first vxlan_igmp_leave() drops it, and the remaining ones
return -EADDRNOTAVAIL (ip_mc_leave_group() starts with
int ret = -EADDRNOTAVAIL, and ipv6_sock_mc_drop() behaves the same), which
leave_vnigrp() records in last_err and returns.

vxlan_group_used() cannot absorb the duplicate here either: it skips
vxlan == dev and returns false early when refcount_read(&sock4->refcnt) == 1.

Note the asymmetry with the join side.  vxlan_multicast_join_vnigrp() both
skips entries whose address equals the device default remote_ip and maps
-EADDRINUSE to 0, while vxlan_multicast_leave_vnigrp() does neither.

With err set to -EADDRNOTAVAIL, netdev_adjacent_change_commit() and
vxlan_config_apply() still commit the new lower device, and then:

	if (!err && change_igmp &&
	    (vxlan_addr_multicast(&dst->remote_ip) ||
	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
		err = vxlan_multicast_join(vxlan);

skips the re-join entirely.  Repeating the same changelink does not repair
it, because lowerdev == dst->remote_dev makes lowerdev NULL, so
new_ifindex == dst->remote_ifindex and change_igmp becomes false.

Reproducer shape:

	ip link add vxlan0 type vxlan external vnifilter dstport 4789 \
		local 10.0.0.1 dev eth0
	bridge vni add dev vxlan0 vni 100-200 group 239.1.1.1
	ip link set vxlan0 up
	ip link set dev vxlan0 type vxlan ... dev eth1

Would it be better to rejoin unconditionally here, and/or make the per-vni
teardown act once per unique (group, ifindex) membership and tolerate
-EADDRNOTAVAIL the way the join side tolerates -EADDRINUSE?

>  
>  	if (netif_running(dev) && conf.age_interval != vxlan->cfg.age_interval)
> @@ -4535,7 +4549,8 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
>  
>  	if (!err && change_igmp &&
> -	    vxlan_addr_multicast(&dst->remote_ip))
> +	    (vxlan_addr_multicast(&dst->remote_ip) ||
> +	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
>  		err = vxlan_multicast_join(vxlan);
>  
>  	return err;

[ ... ]

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e08865..12fa11a318184 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -470,14 +470,19 @@ static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
>  	[VXLAN_VNIFILTER_ENTRY] = { .type = NLA_NESTED },
>  };
>  
> -static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
> -					  union vxlan_addr *old_remote_ip,
> -					  union vxlan_addr *remote_ip,
> -					  struct netlink_ext_ack *extack)
> +int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
> +				   union vxlan_addr *old_remote_ip,
> +				   union vxlan_addr *remote_ip,
> +				   u32 old_ifindex, u32 new_ifindex,
> +				   struct netlink_ext_ack *extack)
>  {
> -	struct vxlan_rdst *dst = &vxlan->default_dst;
>  	int err = 0;
>  
> +	if (old_remote_ip && remote_ip &&
> +	    vxlan_addr_equal(old_remote_ip, remote_ip) &&
> +	    old_ifindex == new_ifindex)
> +		return 0;
> +
>  	spin_lock_bh(&vxlan->hash_lock);
>  	if (remote_ip && !vxlan_addr_any(remote_ip)) {
>  		err = vxlan_fdb_update(vxlan, all_zeros_mac,
> @@ -487,7 +492,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
>  				       vxlan->cfg.dst_port,
>  				       vni,
>  				       vni,
> -				       dst->remote_ifindex,
> +				       new_ifindex,
>  				       NTF_SELF, 0, true, extack);
>  		if (err) {
>  			spin_unlock_bh(&vxlan->hash_lock);
> @@ -500,7 +505,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
>  				   *old_remote_ip,
>  				   vxlan->cfg.dst_port,
>  				   vni, vni,
> -				   dst->remote_ifindex,
> +				   old_ifindex,
>  				   true);
>  	}
>  	spin_unlock_bh(&vxlan->hash_lock);
> @@ -546,6 +551,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  
>  	ret = vxlan_update_default_fdb_entry(vxlan, vninode->vni,
>  					     oldrip, newrip,
> +					     dst->remote_ifindex,
> +					     dst->remote_ifindex,
>  					     extack);
>  	if (ret)
>  		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but the oldrip/newrip selection
just above this call makes the new equality guard dead for this caller, and
it also feeds the bug class the changelog describes.

In vxlan_vni_update_group() the two pointers are mutually exclusive:

	if (group && !vxlan_addr_any(group)) {
		newrip = group;
	} else {
		if (!vxlan_addr_any(&dst->remote_ip))
			newrip = &dst->remote_ip;
	}

	/* if old rip exists, and no newrip,
	 * explicitly delete old rip
	 */
	if (!newrip && !vxlan_addr_any(&old_remote_ip))
		oldrip = &old_remote_ip;

So when a vni's group is changed:

	bridge vni add dev vxlan0 vni 100 group 239.1.1.1
	bridge vni add dev vxlan0 vni 100 group 239.1.1.2

vxlan_vni_add() -> vxlan_vni_update() -> vxlan_vni_update_group(create=false)
passes newrip = 239.1.1.2 with oldrip still NULL, and in
vxlan_update_default_fdb_entry() the delete side is skipped:

	if (old_remote_ip && !vxlan_addr_any(old_remote_ip)) {
		__vxlan_fdb_delete(vxlan, all_zeros_mac,
				   *old_remote_ip,

The 239.1.1.1 rdst of the (all_zeros_mac, vni) entry therefore survives, and
vxlan_vni_delete_group() only deletes vninode->remote_ip, so it can never be
removed and each further group update appends one more rdst.

The new migration loop below only re-keys vent->remote_ip:

		} else {
			oldrip = &vent->remote_ip;
			newrip = &vent->remote_ip;
		}

so after a lower device change that stale rdst additionally keeps pointing
at the old ifindex.

Both the pre-existing "!create && oldrip && newrip &&
vxlan_addr_equal(oldrip, newrip)" test and the newly added
"old_remote_ip && remote_ip && vxlan_addr_equal(...) && old_ifindex ==
new_ifindex" test are unreachable for this caller, which suggests oldrip was
meant to be set on a group change.  Should vxlan_vni_update_group() set
oldrip = &old_remote_ip whenever it differs from newrip?

Verified via git blame as unchanged since f9c4bb0b245ce ("vxlan: vni
filtering support on collect metadata device") and still present at the end
of this series.

> @@ -583,8 +590,10 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
>  			       union vxlan_addr *old_remote_ip,
>  			       union vxlan_addr *new_remote_ip,
> +			       u32 old_ifindex, u32 new_ifindex,
>  			       struct netlink_ext_ack *extack)
>  {
> +	union vxlan_addr *oldrip, *newrip;
>  	struct list_head *headp, *hpos;
>  	struct vxlan_vni_group *vg;
>  	struct vxlan_vni_node *vent;
> @@ -595,17 +604,46 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
>  	headp = &vg->vni_list;
>  	list_for_each_prev(hpos, headp) {
>  		vent = list_entry(hpos, struct vxlan_vni_node, vlist);
> +
>  		if (vxlan_addr_any(&vent->remote_ip)) {
> -			ret = vxlan_update_default_fdb_entry(vxlan, vent->vni,
> -							     old_remote_ip,
> -							     new_remote_ip,
> -							     extack);
> -			if (ret)
> -				return ret;
> +			oldrip = old_remote_ip;
> +			newrip = new_remote_ip;
> +		} else {
> +			/* A vni with its own group keeps it, but its fdb entry
> +			 * is still keyed on the device remote_ifindex.
> +			 */
> +			oldrip = &vent->remote_ip;
> +			newrip = &vent->remote_ip;
>  		}
> +
> +		ret = vxlan_update_default_fdb_entry(vxlan, vent->vni,
> +						     oldrip, newrip,
> +						     old_ifindex, new_ifindex,
> +						     extack);
> +		if (ret)
> +			goto err_unwind;
>  	}
>  
>  	return 0;
> +
> +err_unwind:
> +	list_for_each_continue(hpos, headp) {
> +		vent = list_entry(hpos, struct vxlan_vni_node, vlist);
> +
> +		if (vxlan_addr_any(&vent->remote_ip)) {
> +			oldrip = old_remote_ip;
> +			newrip = new_remote_ip;
> +		} else {
> +			oldrip = &vent->remote_ip;
> +			newrip = &vent->remote_ip;
> +		}
> +
> +		vxlan_update_default_fdb_entry(vxlan, vent->vni,
> +					       newrip, oldrip,
> +					       new_ifindex, old_ifindex,
> +					       NULL);
> +	}
> +	return ret;
>  }

[Severity: Medium]
Does discarding the return value here still guarantee the changelog's claim
that "default_dst and the fdb entries do not diverge"?

vxlan_update_default_fdb_entry() is ordered add-then-delete, and it returns
early if the add fails:

		if (err) {
			spin_unlock_bh(&vxlan->hash_lock);
			return err;
		}

The re-add performed by the unwind is fallible.  It goes
vxlan_fdb_update() -> vxlan_fdb_update_existing() -> vxlan_fdb_append(),
which does:

	rd = kmalloc_obj(*rd, GFP_ATOMIC);
	if (rd == NULL)
		return -ENOMEM;

and vxlan_fdb_notify() can also fail through
vxlan_fdb_switchdev_call_notifiers() on an offloading device.

When that happens the new-ifindex rdst stays installed, __vxlan_fdb_delete()
is never reached, and vxlan_changelink() returns the error without calling
vxlan_config_apply(), so default_dst.remote_ifindex keeps the old value.
Since vxlan_vni_delete_group() looks the entry up with the current (old)
dst->remote_ifindex and vxlan_fdb_find_rdst() requires an exact ifindex
match, that surviving rdst can no longer be deleted, and the next
"bridge vni add" of the same vni appends another one, which is the duplicated
BUM traffic this patch sets out to fix.

The same discarded return exists for the device default entry in
vxlan_changelink(), where the revert call is:

				vxlan_update_default_fdb_entry(vxlan, conf.vni,
							       &conf.remote_ip,
							       &dst->remote_ip,
							       new_ifindex,
							       dst->remote_ifindex,
							       NULL);

Would it make sense to attempt the delete even when the re-add fails, or to
restructure so the rollback needs no allocation, for example by keeping the
original destinations installed until every new destination has been added
successfully?

>  
>  static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921100139.508191-1-edumazet%40google.com
