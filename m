Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92E136351;
	Wed,  9 Sep 2026 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920331; cv=none; b=HppGT6mO8/nHFyj7DRmGOopAtrVV4Ex3eibQKodIoOLYMmsJfzHhi+QgphbRHiztvHU3Pqx3MtlNJffYnOjRLr+xqxw9hC3QfBQZnkQ9ei/A/AAdTSmG6tA10ZQWhoxWppkUBOjNyARRMy4VdtPCUWUcP1j0G7YAbxzvMZ16zP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920331; c=relaxed/simple;
	bh=ezCnWhNLd0PnrqUDGoC3hQ0XYhvUxnjaEIeofcm9LF8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eoc+sGQTuRbsEMJDHZ3/Mb8kcTKRwO/MlROEjMD26uwiI5cXTjp0u3zW5h7MYvFanHXcIR7FU92iAUU6GeJ++vSNRbyBPVycSmbbaITS+fMpqTG5d194qwF0L0e5NP69t6qHuG5flmk+5URM5YpViIAuFoYqXU7u01vaUADoCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3gd+PV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3gd+PV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36291F00A3A;
	Wed,  9 Sep 2026 02:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788920329;
	bh=PW/Kt5aGXVcfHJcs71ojtkObUm+W7S3nt9R4flqpg3Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q3gd+PV1BEk0EMLCJT+M4HHlEknjVuOgCBrf2vC7GurnqKnwYKqWhxts6OwE5fxyL
	 vRG8GFibUM5/RtsWelQTQoHfLPUVdbgnUuqZyMr21Qtn/JyeflTH+/IR6kahQjlnLc
	 +jZNEwsy5YDxgWxpPZUSl2gNEtFF4+qhYlWGwI+fc1wF6bNO9Qe14+FdPaUIEywyWR
	 DymDDM6lfdIGJbFmx4RjWRAs8XcAoFnmjtBZybJeqHYcUh3rM/ojyLC6Pis3tv01mQ
	 rcDrS50RqZOryDZhPnq12rEGtz+Br3VhUkgKanG32UDoeqHOBvOn4J7ooiYtB4MFtG
	 K3JQswvtBV6WQ==
Subject: Re: [PATCH net] vxlan: vnifilter: roll back VNI insertion when the
 group update fails
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, razor@blackwall.org, roopa@nvidia.com,
 bestswngs@gmail.com, xmei5@asu.edu, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 02:18:48 +0000
Message-ID: <178892032843.219967.12339801688901979534@kernel.org>
In-Reply-To: <20260904021707.2891129-1-alishmery18@gmail.com>
References: <20260904021707.2891129-1-alishmery18@gmail.com>
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

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 1

- [Medium] Incomplete fix: only the insertion branch of vxlan_vni_add()
  gets a rollback.
- [Medium] The new err_vni_del path calls vxlan_vni_delete_group() on a
  node whose FDB installation may never have happened, and can therefore…
- [Low] Commit message test report is inconsistent with both its own
  reproducer and the code: it states 'after the change the table is…

Pre-existing issues:
- [High] NULL pointer dereference in vxlan_igmp_join()/vxlan_igmp_leave()
  reachable from the exact call the new rollback wraps.
- [High] Loop-control type mismatch plus missing VNI range validation in
  the direct caller of the patched function.

--

vxlan: vnifilter: roll back VNI insertion when the group update fails

This adds an error path to vxlan_vni_add() so that the new VNI node is
removed from the hash table, the device list and the socket when
vxlan_vni_update_group() fails, and moves vxlan_vnifilter_notify() so it
only runs on success. The node was already published, so it is freed with
call_rcu().

Link: https://lore.kernel.org/netdev/20260323095544.3311285-4-bestswngs@gmail.com/

A few questions below, plus one about the changelog.

First, on the test report in the commit message:

  Tested in a QEMU guest under KASAN and PROVE_LOCKING. Before the change
  VNI 21 is listed after failing and a notification is emitted for it;
  after the change the table is empty while the add fails with the same
  errno at the same VNI, and ftrace confirms vxlan_vni_update_group() is
  still reached for all 22 adds, so the failure does not move earlier.

[Severity: Low]
Can "the table is empty" be right for the reproducer shown just above it?
The loop adds VNIs 1 to 21 and only VNI 21 fails, and the new rollback in
vxlan_vni_add() removes only the VNI whose own vxlan_vni_update_group()
call failed. vxlan_vni_add_del() aborts the loop on the first error and
leaves the previously added VNIs installed, so shouldn't bridge vni show
still list VNIs 1 to 20, with only VNI 21 absent?

The same sentence says vxlan_vni_update_group() was reached "for all 22
adds" while the loop shown performs 21 adds. Should that be 21?

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e08865..ef60a96bcf904 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -756,9 +758,21 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
>  
>  	err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
>  				     extack);
> +	if (err)
> +		goto err_vni_del;

[Severity: Medium]
Should the other branch of this same function get the same treatment?
vxlan_vni_add() starts with:

	if (vxlan_vnifilter_lookup(vxlan, v))
		return vxlan_vni_update(vxlan, vg, v, group, &changed, extack);

and vxlan_vni_update() does:

	ret = vxlan_vni_update_group(vxlan, vninode, group, false, changed,
				     extack);
	if (ret)
		return ret;

By the time vxlan_vni_update_group() can fail on the IGMP join, it has
already installed the new default FDB entry via
vxlan_update_default_fdb_entry(), committed the address with
memcpy(&vninode->remote_ip, group, sizeof(vninode->remote_ip)), and
dropped the old membership with vxlan_igmp_leave(). If the join then
returns the same -ENOBUFS the changelog uses as its reproducer, the VNI
keeps the new group in bridge vni show with no membership behind it, and
because *changed stays false no notification is sent either.

Reached with two ordinary commands, for example:

  bridge vni add vni 21 dev vx0
  bridge vni add vni 21 group 239.1.1.21 dev vx0

Is leaving this sibling path untouched intentional? If so, could the
changelog say so, since it describes the defect as state remaining visible
after a failed request?

[Severity: High]
This isn't a bug introduced by this patch, but the very call being wrapped
here can oops. vxlan_vni_update_group() does:

		if (vxlan_addr_multicast(&vninode->remote_ip)) {
			ret = vxlan_igmp_join(vxlan, &vninode->remote_ip, 0);

and vxlan_igmp_join() in vxlan_multicast.c picks the socket purely from
the group address family and dereferences it without a NULL check:

	} else {
		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);

		sk = sock6->sk;

A vnifilter device implies COLLECT_METADATA, so vxlan_sock_add() takes the
path that sets both ipv6 and ipv4 and tolerates a failed IPv6 socket:

	if (ipv6) {
		ret = __vxlan_sock_add(vxlan, true);
		if (ret < 0 && ret != -EAFNOSUPPORT)
			ipv4 = false;
	}

With ipv6.disable=1 and CONFIG_IPV6=y the IPv6 socket fails with
-EAFNOSUPPORT, the device still comes UP, and vn6_sock stays NULL.
vxlan_process_vni_filter() accepts VXLAN_VNIFILTER_ENTRY_GROUP6 and only
checks default_dst.remote_ifindex, and vxlan_vni_update_group() adds no
family check, so bridge vni add vni 1 group6 ff0e::1 dev vx0 reaches
sk = sock6->sk with sock6 == NULL, under RTNL. Is a family/socket check
missing on this path? The changelog mentions an unrelated
vxlan_igmp_join() fix that "was not followed up" - is this the same one?

>  
>  	vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
>  
> +	return 0;
> +
> +err_vni_del:
> +	vxlan_vni_delete_group(vxlan, vninode);

[Severity: Medium]
Can this delete FDB state the failed add never created?

The changelog says "if it failed before installing the FDB entry, both
vninode->remote_ip and the default remote_ip are zero and it does
nothing", but the guard in vxlan_vni_delete_group() is an OR:

	if (!vxlan_addr_any(&vninode->remote_ip) ||
	    !vxlan_addr_any(&dst->remote_ip)) {
		spin_lock_bh(&vxlan->hash_lock);
		__vxlan_fdb_delete(vxlan, all_zeros_mac,
				   (vxlan_addr_any(&vninode->remote_ip) ?
				   dst->remote_ip : vninode->remote_ip),
				   ...
				   true);

So on a device with a non-zero default_dst.remote_ip the rollback still
issues __vxlan_fdb_delete() for the default remote_ip even when
vxlan_update_default_fdb_entry() is what failed. That happens to be
harmless only when vxlan_find_mac() misses.

There is also a case where it is not harmless. vxlan_fdb_append() in
vxlan_core.c returns early when the destination already exists:

	rd = vxlan_fdb_find_rdst(f, ip, port, vni, ifindex);
	if (rd)
		return 0;

and vxlan_fdb_parse() accepts any NDA_SRC_VNI without consulting the VNI
filter, so a zero-MAC entry can be installed out of band:

  bridge fdb append 00:00:00:00:00:00 dst 239.1.1.21 src_vni 21 vni 21 dev vx0

Then an add for VNI 21 with that group commits vninode->remote_ip without
creating anything new, and if the IGMP join fails with the changelog's
-ENOBUFS, the rollback calls __vxlan_fdb_delete() and destroys that
pre-existing entry, with swdev_notify=true so userspace and offloading
drivers see an RTM_DELNEIGH for it.

The helper's other caller, vxlan_vni_del(), only ever sees a fully
installed node. Would it be safer to remember whether this add actually
installed the FDB entry, and only undo that?

> +	rhashtable_remove_fast(&vg->vni_hash, &vninode->vnode,
> +			       vxlan_vni_rht_params);
> +	__vxlan_vni_del_list(vg, vninode);
> +	if (vxlan->dev->flags & IFF_UP)
> +		vxlan_vs_add_del_vninode(vxlan, vninode, true);
> +	call_rcu(&vninode->rcu, vxlan_vni_node_rcu_free);
>  	return err;
>  }
>  

[Severity: High]
This is a pre-existing issue in the caller and not introduced here, but
while looking at this error path: vxlan_vni_add_del() iterates the range
with a signed loop variable against u32 endpoints:

	int v, err = 0;
	...
	for (v = start_vni; v <= end_vni; v++) {

and vxlan_process_vni_filter() reads the endpoints as plain NLA_U32 with
no upper bound (vxlan_mdb.c uses .max = VXLAN_N_VID - 1 for the same
kind of value):

	if (vattrs[VXLAN_VNIFILTER_ENTRY_START]) {
		vni_start = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_START]);
		vni_end = vni_start;
	}

For start == end == 0xFFFFFFFF, v is -1 but the comparison promotes it, so
0xFFFFFFFF <= 0xFFFFFFFF passes and a VNI outside the 24-bit range is
added; v++ then wraps to 0 and 0 <= 0xFFFFFFFF still holds. Does a request
for a single VNI then keep allocating vxlan_vni_node plus per-CPU stats
under RTNL until an allocation fails or the rhashtable reaches max_size?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904021707.2891129-1-alishmery18%40gmail.com
