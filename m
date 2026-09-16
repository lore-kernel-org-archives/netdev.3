Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456013776B
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602941; cv=none; b=CkyuZIozD9JjWcPtatV/SPKZ+qF+UQ4qNZmJMDMB9BWvwZogmZljgt1Oc/8c3UC9eFrwbpzYmyjTPNSM7haVpKpIWyeVk44kZ2ibFaW4RQG5Cd5FG34ahKn/88P7Vi84Qb5iIoAVYpH6Sc/nCXEahJfyAFycmkkmgaOQ8HlRXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602941; c=relaxed/simple;
	bh=yYIe8Y7Q692cSwcTjw4XaZiV7FxyfHxmD+/6OdvIyAc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bwWdPMrkp2+hkcQL+yJ6+DAg7W+tgw8g01UvzEVMblvEN3a5FSikY6q9ySv/mCjZdqjWQZP6ydFdv6bjndebDUHu+hVnEh2aUh8goT6wuusX2i3SceTSxZmUuVlWKksLg4FuF5qDqSQC25aiK1LZYr5t/3NV3vCIdPIpquF/6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxS/WsDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxS/WsDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2FC1F000FF;
	Wed, 16 Sep 2026 23:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602939;
	bh=Etk6P57tHRdvsD2tFz+nN+D8u5jW6AFJL96DtmJY15s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lxS/WsDa5S/A5PJWYF+KqDaINC2/LO0XxB1G2VFxkV0Fjjzy9lqKLc9fnuWyHVzdg
	 5FiZMy4cDHgX2zvHHfOU6Z7oCV7HqOfc+AoLCLqOsznFaedGQ6oILZV92uMMvwQppV
	 4uBVqH6RpmCzMIFwNY7ss3k8n9DBGcOFK5QXOdbMPJedsNtIc4qoomFFdHXWVT1NMH
	 QqvXSEh7hwRG8s4BSJOMIu8KiqHlsZ1rxh0KHiPyr4TcTbX9r+rlByZkHCL1Rl6Iwp
	 SfxRnKymV97F4IOtGqgakN9CScvRMJ0wBfgaUpjFHnP5Wv1Ll+8qLcweE84LYsLsHy
	 zfI6iN1lqJVFA==
Subject: Re: [PATCH v4 net-next 1/8] vxlan: update default fdb entries when
 the lower device changes
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 kuniyu@google.com
Date: Wed, 16 Sep 2026 23:55:38 +0000
Message-ID: <178960293871.22033.12679630645989510026@kernel.org>
In-Reply-To: <20260915175501.391567-2-edumazet@google.com>
References: <20260915175501.391567-2-edumazet@google.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

- [High] vxlan_changelink() now migrates every VNI's default FDB rdst to
  the new lower-device ifindex (including VNIs that carry their own…
- [Medium] vxlan_changelink() re-keys the device-level all-zeros-mac rdst
  and then every VNI's default rdst to new_ifindex *before*…

Pre-existing issues:
- [Medium] The stale-rdst / duplicated-BUM failure mode the changelog
  describes is also reachable through the sibling caller of the helper…

--

vxlan: update default fdb entries when the lower device changes

vxlan_changelink() now refreshes the all zeros mac fdb entries when only the
lower device changes, and passes the old and new ifindex down to
vxlan_update_default_fdb_entry() so the append targets the new lower device
while the delete still matches the entry created for the old one.  The vni
filter walk in vxlan_vnilist_update_group() was also extended to visit every
vni instead of only those inheriting the device group.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 347245cc1de4e..259f0f07a5358 100644
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

> @@ -4509,12 +4513,14 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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

[Severity: High]

This call now moves the rdst of every vni to new_ifindex, including vnis
that carry their own (possibly multicast) group.  The igmp/mld membership
handling further down vxlan_changelink() is still keyed on the device level
remote_ip:

	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
		err = vxlan_multicast_leave(vxlan);
	...
	if (!err && change_igmp &&
	    vxlan_addr_multicast(&dst->remote_ip))
		err = vxlan_multicast_join(vxlan);

vxlan_multicast_leave() and vxlan_multicast_join() are the only callers of
vxlan_multicast_leave_vnigrp() / vxlan_multicast_join_vnigrp().

For the usual vni filter device the device remote_ip is the any address and
the multicast groups live on the per vni entries:

	ip link add vxlan0 type vxlan external vnifilter local <ip> dev eth0 \
		dstport 4789
	bridge vni add dev vxlan0 vni 100 group 239.1.1.1
	ip link set dev vxlan0 type vxlan dev eth1

Here change_igmp is true because dst->remote_ifindex != new_ifindex, but
vxlan_addr_multicast(&dst->remote_ip) is false for the any address, so
neither wrapper runs while vxlan_vnilist_update_group() has already re-keyed
the rdst of vni 100 to eth1.

Does this split the transmit path and the membership, so BUM frames for vni
100 leave on eth1 while 239.1.1.1 stays joined on eth0?

Can the membership taken on eth0 still be released afterwards?  Both
vxlan_vni_delete_group() and vxlan_multicast_leave_vnigrp() pass rifindex 0:

	vxlan_igmp_leave(vxlan, &vninode->remote_ip, 0);

and vxlan_igmp_leave() resolves that to the already committed ifindex:

drivers/net/vxlan/vxlan_multicast.c:vxlan_igmp_leave() {
	union vxlan_addr *ip = (rip ? : &vxlan->default_dst.remote_ip);
	int ifindex = (rifindex ? : vxlan->default_dst.remote_ifindex);
	...
}

>  			if (err) {
>  				netdev_adjacent_change_abort(dst->remote_dev,
>  							     lowerdev, dev);
>  				return err;
>  			}

[Severity: Medium]

Can this error path leave default_dst and the fdb entries diverged?  The
fdb re-keying above happens before vxlan_config_apply() commits
default_dst.remote_ifindex, and netdev_adjacent_change_abort() only restores
the netdev adjacency, there is no fdb rollback.

vxlan_update_default_fdb_entry() can fail: vxlan_fdb_update() ->
vxlan_fdb_update_existing() -> vxlan_fdb_append() allocates the rdst with
GFP_ATOMIC, and vxlan_fdb_notify() with swdev_notify set can be rejected by
a switchdev driver.

If the k-th vni fails, the device entry plus vnis 1..k-1 are already keyed
on new_ifindex, but the function returns before vxlan_config_apply(), so
default_dst.remote_ifindex keeps the old value.  A later bridge vni del then
looks the entry up with the old ifindex:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vni_delete_group() {
	...
		__vxlan_fdb_delete(vxlan, all_zeros_mac,
				   (vxlan_addr_any(&vninode->remote_ip) ?
				   dst->remote_ip : vninode->remote_ip),
				   vxlan->cfg.dst_port,
				   vninode->vni, vninode->vni,
				   dst->remote_ifindex,
				   true);
	...
}

and __vxlan_fdb_delete() silently returns 0 on a lookup miss:

	rd = vxlan_fdb_find_rdst(f, &ip, port, vni, ifindex);
	if (!rd)
		goto out;

so the migrated rdst survives and re-adding the vni appends a second one,
which is the duplicated BUM traffic this patch is removing.

Related, the changelog says:

    The new ifindex is the one vxlan_config_apply() will commit, which is
    the current one when lowerdev is NULL, so that default_dst and the fdb
    entries can not diverge.

Does that hold on the failure path too, or only on the success path?

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e08865..e433e66f6d4d3 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -546,6 +551,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
>  
>  	ret = vxlan_update_default_fdb_entry(vxlan, vninode->vni,
>  					     oldrip, newrip,
> +					     dst->remote_ifindex,
> +					     dst->remote_ifindex,
>  					     extack);
>  	if (ret)
>  		goto out;

[Severity: Medium]

This isn't a bug introduced by this patch, it dates back to f9c4bb0b245c
("vxlan: vni filtering support on collect metadata device"), but it sits in
the function this patch touches and produces the same symptom the changelog
describes, so it may be worth a note.

In vxlan_vni_update_group() oldrip is only assigned when there is no newrip:

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

So for a per vni group change A -> B:

	bridge vni add dev vxlan0 vni 100 group 239.1.1.1
	bridge vni add dev vxlan0 vni 100 group 239.1.1.2

vxlan_vni_add() routes the existing vni to vxlan_vni_update() ->
vxlan_vni_update_group(create=false) with newrip = B and oldrip = NULL, so
vxlan_update_default_fdb_entry() appends an rdst for B and skips the delete
branch:

	if (old_remote_ip && !vxlan_addr_any(old_remote_ip)) {
		__vxlan_fdb_delete(vxlan, all_zeros_mac, *old_remote_ip, ...);
	}

Does the rdst for group A then stay on the all zeros mac entry of that vni
forever, given that vxlan_vni_delete_group() only deletes
vninode->remote_ip, which now holds B?

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
> @@ -595,14 +604,24 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
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
> +			return ret;

[Severity: Medium]

Should this bail out unwind the vnis already visited?  Each successful
vxlan_update_default_fdb_entry() installs the destination with new_ifindex
and destroys the one keyed on old_ifindex, so returning here leaves the list
with a mix of old and new ifindex keyed rdsts, and the caller in
vxlan_changelink() has no way to undo them.

>  	}
>  
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915175501.391567-1-edumazet%40google.com
