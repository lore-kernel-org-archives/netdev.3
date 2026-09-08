Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80DB4C9001
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890637; cv=none; b=bUeSvMVDgTUaHsGwJ+PItI9tQ3/fkRpJPGmj36b8vfIaYI33lQG4rGkh4MfSd/uzztxgRraXtk3yAnhC1dW4zDCminZS3jeuwqr5B8OGxeEvurkScrmWejFuioDzQyxF0OOzY1xFyZ6WtLsNhT/jJ1k6F68okE/UkG+KbgiZdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890637; c=relaxed/simple;
	bh=WsSaBvMkdhgVSSG3xiTANOOIpWhl2ZJIYI9bgwN9l24=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eERt6+TcVKS3HAk7r/9Iso8m0vDrkR/IJq2svR4QnqyGI/cHjONQ/9NPRutMDtfFpLeFxmS/zo/uUdPTE8BSoDiPUzgqlB+KC0jXGMrrFAkOIWs6EeZeUQUU2oWnkGEbHC/PiSHUEfJ4Rq0THuEKAn7wvCCCiKNO9ugFiC2L27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDZOhKfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDZOhKfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783DF1F00A3D;
	Tue,  8 Sep 2026 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890634;
	bh=cMC1+5ahGk4VOuyW0pxUHNhet9MqtTp+G6LdDiDyrDo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GDZOhKfZv6qermKyibTC7LElSyuiFXbYUM67lobjpvP2xXLaiL05iuMKrZ4w6aFnC
	 2CMwrsorRKxjN4EX6jGAFY4PEiNFoHEMIVU9V+Mk3jmFbCgpUbSabmSKQ6GWDkpUXT
	 nvQ7qiwj3kaqxHf+dYY7PDZIKsOU4QYfc/tTrtdE3UoTuOTCIgosHBx30JzaMmJJLQ
	 nUsRFmRmSr32MQm1srgDVU9tc1vUfapt4Jpmjy6BvK/4YR3hRttel2DhCpviQP/Qkc
	 tJ1J+Be9iBi0V88wNR6MSBSc2g04rJfwGcogmWez2C0I2rnmwBG7tbFfiX6FLOiu08
	 wuzWDPwMHuv6A==
Subject: Re: [PATCH v2 net-next 2/8] vxlan: vnifilter: use
 list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 18:03:53 +0000
Message-ID: <178889063307.219967.14381012776534349065@kernel.org>
In-Reply-To: <20260906180111.1973188-3-edumazet@google.com>
References: <20260906180111.1973188-3-edumazet@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (2)

- [Medium] The commit message's first justification is factually wrong
  for this tree: vxlan_vnifilter_dump_dev() does NOT run "without RTNL".
- [Medium] The paginated RTM_GETTUNNEL dump resumes with pure ordinal
  cursors: cb->args[0] is the position of the vxlan device in the netdev…

Pre-existing issues:
- [Low] Claim: vxlan_vnifilter_dump_dev() reads vg->num_vnis
  (drivers/net/vxlan/vxlan_vnifilter.c:355) with a plain, unannotated…
- [Low] Claim: the dump reads v->remote_ip (a multi-word union
  vxlan_addr) via vxlan_addr_equal() in vxlan_vnifilter_dump_dev()…

--

vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()

The patch converts the vg->vni_list walk in vxlan_vnifilter_dump_dev() from
list_for_each_entry_safe() to list_for_each_entry_rcu(), and clears
cb->args[1] on the two early returns so a stale VNI offset is not carried
over to the next device in a paginated RTM_GETTUNNEL dump.

A few questions below.

> vxlan_vnifilter_dump_dev() runs under rcu_read_lock() without RTNL when
> dumping VNI filter entries via RTM_GETTUNNEL.
>
> 1) Currently it traverses vg->vni_list using list_for_each_entry_safe(),
>    which performs raw pointer accesses without RCU dereference barriers.
>    Since concurrent RTNL writers modify vg->vni_list using list_add_rcu()
>    and list_del_rcu(), use list_for_each_entry_rcu() instead.

[Severity: Medium]
Is the "without RTNL" part of this description accurate for this tree?

RTM_GETTUNNEL is registered in vxlan_vnifilter_rtnl_msg_handlers[] with a
flags value of 0, i.e. without RTNL_FLAG_DUMP_UNLOCKED:

drivers/net/vxlan/vxlan_vnifilter.c:
static const struct rtnl_msg_handler vxlan_vnifilter_rtnl_msg_handlers[] = {
	{THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL, vxlan_vnifilter_dump, 0},

rtnetlink_dump_start() then routes the dump through rtnl_dumpit(), which
holds RTNL for the whole callback:

net/core/rtnetlink.c:rtnl_dumpit() {
	const bool needs_lock = !(cb->flags & RTNL_FLAG_DUMP_UNLOCKED);
	...
	if (needs_lock)
		rtnl_lock();
	err = dumpit(skb, cb);
	if (needs_lock)
		rtnl_unlock();
}

The writers of vg->vni_list (__vxlan_vni_add_list() and
__vxlan_vni_del_list(), reached from the RTM_NEWTUNNEL/RTM_DELTUNNEL doit
handlers, which are also registered with flags 0, and from
vxlan_vnigroup_uninit()) run under RTNL as well.

So the previous list_for_each_entry_safe() walk appears to already have
been serialized against those writers, which would make item 1 RCU hygiene
or preparation for a future unlocked dump rather than a fix for a live
race. Item 2 does look like a real fix, since RTNL is dropped between dump
pages. Could the changelog be adjusted so that the Fixes: tag is not read
as covering an RCU list-traversal race that cannot happen today?

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e08865..fdf25d01bc1fb 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c

[ ... ]

> @@ -342,13 +342,17 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	bool dump_stats;
>  	int err = 0;
>  
> -	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
> +	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)) {
> +		cb->args[1] = 0;
>  		return -EINVAL;
> +	}
>  
>  	/* RCU needed because of the vni locking rules (rcu || rtnl) */
>  	vg = rcu_dereference(vxlan->vnigrp);
> -	if (!vg || !vg->num_vnis)
> +	if (!vg || !vg->num_vnis) {
> +		cb->args[1] = 0;
>  		return 0;
> +	}

[Severity: Low]
This isn't a bug introduced by this patch, but a note on the plain read of
vg->num_vnis in vxlan_vnifilter_dump_dev() while this early return is being
touched.

The counter is updated non-atomically after the RCU list publish/unlink:

drivers/net/vxlan/vxlan_vnifilter.c:__vxlan_vni_add_list() {
	list_add_rcu(&v->vlist, hpos);
	vg->num_vnis++;
}

drivers/net/vxlan/vxlan_vnifilter.c:__vxlan_vni_del_list() {
	list_del_rcu(&v->vlist);
	vg->num_vnis--;
}

As shown above, both the dump and these writers currently run under RTNL,
so there is no concurrency and no torn read today. Should this dump ever be
converted to RTNL_FLAG_DUMP_UNLOCKED, would this read need READ_ONCE(), or
could the num_vnis test simply be dropped now that the traversal itself is
RCU-safe?

>  
>  	tmsg = nlmsg_data(cb->nlh);
>  	dump_stats = !!(tmsg->flags & TUNNEL_MSG_FLAG_STATS);

[ ... ]

> @@ -362,7 +366,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	new_tmsg->family = PF_BRIDGE;
>  	new_tmsg->ifindex = dev->ifindex;
>  
> -	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
> +	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
>  		if (idx < s_idx) {
>  			idx++;
>  			continue;

[Severity: Medium]
Can the same "silently skipping its first N VNIs" symptom still be reached
through device and VNI list churn between dump pages, so that clearing
cb->args[1] on the early returns is not sufficient?

Both cursors are pure ordinals. In vxlan_vnifilter_dump() the device is
matched by position:

	for_each_netdev_rcu(net, dev) {
		if (!netif_is_vxlan(dev))
			continue;
		if (idx < s_idx)
			goto skip;
		err = vxlan_vnifilter_dump_dev(dev, skb, cb);

and in vxlan_vnifilter_dump_dev() the VNI is matched by position:

	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
		if (idx < s_idx) {
			idx++;
			continue;
		}
	...
	cb->args[1] = err ? idx : 0;

RTNL is released at the end of each rtnl_dumpit() invocation, so with vxlan
devices [D0, D1, D2] and a page ending mid-D1 (cb->args[0] = 1,
cb->args[1] = 40):

  - D0 is deleted between recvmsg() rounds
  - enumeration becomes [D1, D2]
  - position 1 is now D2, so D1's remaining VNIs are never emitted
  - vxlan_vnifilter_dump_dev(D2) is entered with s_idx = 40 and drops D2's
    first 40 VNI entries

The new cb->args[1] = 0 statements do not help here because dump_dev() is
never called for the device the offset belonged to. bridge vni add/del
between pages shifts the VNI ordinals in the same way.

Additionally, unlike other rtnetlink dumps over the same netdev list, no
generation counter is recorded and NLM_F_DUMP_INTR is never set, so the
skipping or duplication is invisible to user space:

net/core/rtnetlink.c:rtnl_dump_ifinfo() {
	cb->seq = tgt_net->dev_base_seq;
	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
}

Would keying the VNI offset to the device ifindex rather than its list
position, plus a cb->seq generation with nl_dump_check_consistent(), be the
more robust fix?

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but while the
traversal is being made RCU-aware: the loop body reads the multi-word
v->remote_ip union without any annotation, both here

		if (!dump_stats && vnirange(vend, v) == 1 &&
		    vxlan_addr_equal(&v->remote_ip, &vend->remote_ip)) {

and in vxlan_fill_vni_filter_entry(), while the writer replaces it in place:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vni_update_group() {
	if (group)
		memcpy(&vninode->remote_ip, group, sizeof(vninode->remote_ip));
}

Since both paths hold RTNL as shown above, a torn value cannot be observed
by this dump today. If the dump becomes unlocked, would the in-place memcpy
of remote_ip need to be replaced by something RCU-safe so that a mismatched
sa_family and address pair cannot be emitted or used for range coalescing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906180111.1973188-1-edumazet%40google.com
