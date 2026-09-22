Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860A3AB47A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092951; cv=none; b=Z+RZWHuGO3mHD3spCXbuNycCVSbVoWy2Mz0QjXvxZQ5L6UqTfnraHuyd3b03gpGkln+bV55019Yux0Kac9VtdUlcI23c7bFkcyCqAiyQDGrQN+Wx8swpJBO5BZs5i0ZgXWWVSgRslrmpmaHgPa9agSwUpYP56mOaQ/zWgj/eJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092951; c=relaxed/simple;
	bh=Cr4lihxMzlvayBZEYBIOKsJG8PDPjKFzpoSDTYG4Ueg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ln1fRlWk1kkRmgCUxnslRWZC+CtJJpywnm++OUs51MM+HUKuOXxH04LBMQrR/6Z4g2kBRRVGSRD+wLp3+xBXi21xKopZAhhpTOT8tc4JfZJvDiVMPzju/bai1DDIrwaKkdIUHwQARGVQUoqH6U/56M2nTggsYua3LVgCCk62cBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnzz+3tL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnzz+3tL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762C01F00893;
	Tue, 22 Sep 2026 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092949;
	bh=HhahDbVh8FfZIna/ioMGXV8EXVQEtV0Y/8hhmwkKnZk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lnzz+3tLFid3es9PzVl7f6iaG7ou8cENSu+8LH5z9dAVBdr8ycy1l/0ZqG2pVsSmw
	 aZgolUP3Y8AQlYu0tdJJPLgOo/65fsMoFy/0OUAFlAy8JkoE2HPI33J9dLy9jHxYaG
	 XUILu+hgrUt2TOA9sMh2jozi2MiklSlF1o7c24M0RnldobSPRCD3gNBK6W254KB/OS
	 Qsfej3/dAphIfm4NpeZzzcoguXlA+qN/Iu20OSJrOEWJpjO5c3fuvuLbdXkn0dr1Yc
	 0A/qTXUV9OyAjiu4Ol/iopZahAqUozau3uLoSWGgm575vj/oH2JsgjCmCIp62rj+0Y
	 A1QSUiqY3EBYw==
Subject: Re: [PATCH v5 net-next 2/8] vxlan: vnifilter: use
 list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 22 Sep 2026 16:02:29 +0000
Message-ID: <179009294903.2160803.6162107041681144702@kernel.org>
In-Reply-To: <20260921100139.508191-3-edumazet@google.com>
References: <20260921100139.508191-3-edumazet@google.com>
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

- [Low] vxlan_vnifilter_dump_dev() resumes a paginated RTM_GETTUNNEL dump
  inside one device by a positional ordinal (cb->args[1], applied via…

Pre-existing issues:
- [Low] vxlan_vnifilter_dump() still resumes the device walk by ordinal
  position (cb->args[0], 'if (idx < s_idx) goto skip;'), while the new…

--

vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()

This switches the vg->vni_list walk in vxlan_vnifilter_dump_dev() from
list_for_each_entry_safe() to list_for_each_entry_rcu(), and clears
cb->args[1] on the early return paths.  It also records the current
device ifindex in cb->args[2] so the per-device VNI offset is reset when
the device being dumped changes.

A couple of questions about the resume bookkeeping below.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 12fa11a318184..fad7c76418e92 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -333,22 +333,34 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  				    struct sk_buff *skb,
>  				    struct netlink_callback *cb)
>  {
> -	struct vxlan_vni_node *tmp, *v, *vbegin = NULL, *vend = NULL;
> +	struct vxlan_vni_node *v, *vbegin = NULL, *vend = NULL;
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
>  	struct tunnel_msg *new_tmsg, *tmsg;
> -	int idx = 0, s_idx = cb->args[1];
>  	struct vxlan_vni_group *vg;
>  	struct nlmsghdr *nlh;
> +	int idx = 0, s_idx;
>  	bool dump_stats;
>  	int err = 0;
>  
> -	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
> +	if (cb->args[2] != dev->ifindex) {
> +		cb->args[1] = 0;
> +		cb->args[2] = dev->ifindex;
> +	}
> +	s_idx = cb->args[1];

[Severity: Low]
This isn't a bug introduced by this patch, but the two halves of the
resume state now use different encodings.  vxlan_vnifilter_dump_dev()
keys per-device progress on dev->ifindex in cb->args[2], while the
caller vxlan_vnifilter_dump() still resumes the device walk by ordinal:

	for_each_netdev_rcu(net, dev) {
		if (!netif_is_vxlan(dev))
			continue;
		if (idx < s_idx)
			goto skip;
		err = vxlan_vnifilter_dump_dev(dev, skb, cb);

If a vxlan device positioned before the partially dumped device is
unregistered between dump callbacks, the ordinals shift and the
in-progress device is now at idx < s_idx, so it is skipped before
vxlan_vnifilter_dump_dev() is ever reached and the new cb->args[2]
check cannot re-locate it.  The remainder of that device's VNIs is
then never emitted (and if it was the last device, the callback emits
an empty skb and the dump ends with NLMSG_DONE).

Would it make sense to key the device walk on ifindex as well, so the
resume point survives device removal?

For the record, the following patch in this series, "vxlan: vnifilter:
signal interrupted RTM_GETTUNNEL dumps", bumps a per-netns generation
counter on NETDEV_REGISTER/NETDEV_UNREGISTER of vxlan devices and
publishes it through cb->seq plus nl_dump_check_consistent(), and
netlink_dump_done() applies the same check to NLMSG_DONE, so after that
patch the truncation is at least reported to user space via
NLM_F_DUMP_INTR.

> +
> +	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)) {
> +		cb->args[1] = 0;
> +		cb->args[2] = 0;
>  		return -EINVAL;
> +	}
>  
>  	/* RCU needed because of the vni locking rules (rcu || rtnl) */
>  	vg = rcu_dereference(vxlan->vnigrp);
> -	if (!vg || !vg->num_vnis)
> +	if (!vg || !vg->num_vnis) {
> +		cb->args[1] = 0;
> +		cb->args[2] = 0;
>  		return 0;
> +	}
>  
>  	tmsg = nlmsg_data(cb->nlh);
>  	dump_stats = !!(tmsg->flags & TUNNEL_MSG_FLAG_STATS);
> @@ -362,7 +374,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	new_tmsg->family = PF_BRIDGE;
>  	new_tmsg->ifindex = dev->ifindex;
>  
> -	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
> +	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
>  		if (idx < s_idx) {
>  			idx++;
>  			continue;

[Severity: Low]
The new cb->args[2] check validates which device the saved offset
belongs to, but the offset itself is still a position in vg->vni_list,
and writers insert or remove entries anywhere in that sorted list:

drivers/net/vxlan/vxlan_vnifilter.c:__vxlan_vni_add_list() {
	...
	list_add_rcu(&v->vlist, hpos);
	vg->num_vnis++;
	...
}

drivers/net/vxlan/vxlan_vnifilter.c:__vxlan_vni_del_list() {
	...
	list_del_rcu(&v->vlist);
	vg->num_vnis--;
	...
}

Since RTNL is dropped between dump skbs, can a "bridge vni add/del" on
the device being dumped shift that cursor, so the next callback skips or
repeats VNI entries?

> @@ -394,6 +406,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	}
>  
>  	cb->args[1] = err ? idx : 0;
> +	cb->args[2] = err ? dev->ifindex : 0;

[Severity: Low]
At this commit no generation counter is recorded in cb->seq and
nl_dump_check_consistent() is not called here, so a skipped or duplicated
VNI is invisible to user space, i.e. NLM_F_DUMP_INTR is never set on the
affected messages.  The sibling dump in the same driver does maintain
such a counter:

drivers/net/vxlan/vxlan_mdb.c:vxlan_mdb_dump_dev() {
	...
	cb->seq = vxlan->mdb_seq;
	nl_dump_check_consistent(cb, nlh);
	...
}

Should this dump do the same?  Note the immediately following patch in
this series, "vxlan: vnifilter: signal interrupted RTM_GETTUNNEL dumps",
adds a per-netns atomic counter (vxlan_net.vnifilter_seq) incremented in
__vxlan_vni_add_list(), __vxlan_vni_del_list() and
vxlan_vni_update_group(), sets cb->seq in vxlan_vnifilter_dump() and
calls nl_dump_check_consistent(cb, nlh) here, which addresses this.  Is
there a reason to keep the two changes in separate patches, given the
positional resume is being reworked in this one?

>  
>  	nlmsg_end(skb, nlh);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921100139.508191-1-edumazet%40google.com
