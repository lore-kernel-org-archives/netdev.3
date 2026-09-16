Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5983CB8F0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602942; cv=none; b=T41DkLnuZjN/Lb9OMVa8gcD44SjpcOYGPd4sAajZW0HEGE7e1VNelxob1BwdVNuu+IHWF1JadYK5cuxJ8Gk4veoxYxNUd1e0LbiHdGuUVXteMB0DWYuIiHwaSOvrhV8u1OMDpi2twbazWmxN0bfrdKCtQ3vqdsB+VuRjJt/+qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602942; c=relaxed/simple;
	bh=jopall65XG5bP/LkVF3LlIENbMwL2Ae1cBI2KtTofDE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZxETZovM8VJUaD4hwJ1Ww6yJxtbermV1BVFkw/Pg73IKkVIKj5vFU/3fCFGhimOmmQibAufe4GEWJo81x4qM7pBFEEXuKNqYuWyLNIPQnaWLgVDhafUaLSwgxf3cX3yMzFsYjHCp90gyM/eDy2n9aITr34RzzqWIUBDLAiVilVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4jyEAd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4jyEAd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B18E1F00893;
	Wed, 16 Sep 2026 23:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602941;
	bh=Wq7Cb8f+QlFo33jDx4OLlb+tvxBxZep+xHU9Y45S580=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J4jyEAd6D2YKbPqPP0jvwnFVGH2JfZBR4QF76RYyhIyfODcZ0hPNDm1R1ZotSW89T
	 aFa0mYAsDbEYYE4I1fhlCh2As7q089pWLF8ouA9bBhMWJrwe/KxkESc7+um2j593D8
	 Mg6XN5iBfi0lEgL3Z0uE2BwroGPPPH8ONO7/khdsUKM8wMBq9D7rLmnKLdjHV7DrNu
	 bNsrTSwEFPL3l0+CCd46x8dKCX437wsFs+2s1v97CiI7T+uD3WE/mGfEE4a2Lzeqkp
	 AH70YL55m8GF3s0YUVi7JsWzXitg5wcAdJqc3Pd0ieHR8r30mo03CzuezEjT1QrFoC
	 dUhFOxM7DiAyA==
Subject: Re: [PATCH v4 net-next 2/8] vxlan: vnifilter: use
 list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 kuniyu@google.com
Date: Wed, 16 Sep 2026 23:55:39 +0000
Message-ID: <178960293995.22033.13473813342519065221@kernel.org>
In-Reply-To: <20260915175501.391567-3-edumazet@google.com>
References: <20260915175501.391567-3-edumazet@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Incomplete dump consistency in the paginated RTM_GETTUNNEL dump:
  both resume cursors remain plain ordinals (cb->args[0] = netdev…

--

vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()

This switches the vg->vni_list walk in vxlan_vnifilter_dump_dev() to
list_for_each_entry_rcu(), since writers modify the list with
list_add_rcu()/list_del_rcu().  It also clears cb->args[1] on the early
return paths and tracks the device ifindex in cb->args[2] so a stale VNI
offset is not carried over to the next device of a paginated dump.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index e433e66f6d4d3..4404b912a7427 100644
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

[Severity: Low]
The new cb->args[2] check only runs after vxlan_vnifilter_dump() has already
selected a device using the unchanged ordinal cursor cb->args[0]:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vnifilter_dump() {
	...
	for_each_netdev_rcu(net, dev) {
		if (!netif_is_vxlan(dev))
			continue;
		if (idx < s_idx)
			goto skip;
		err = vxlan_vnifilter_dump_dev(dev, skb, cb);
	...
}

If a vxlan device is unregistered between two dump skbs, the ordinal of the
partially dumped device drops below cb->args[0] and it is skipped before
vxlan_vnifilter_dump_dev() gets a chance to compare ifindexes.

Can the remaining VNIs of that device then be dropped from the dump result
even with the new ifindex tracking in place?

Also, is the extra clearing of cb->args[1]/cb->args[2] in these two early
return paths needed?  The unconditional check at the top of
vxlan_vnifilter_dump_dev() already resets cb->args[1] for any device whose
ifindex differs from the saved one, and vxlan_vnifilter_dump() breaks out of
for_each_netdev_rcu() on -EMSGSIZE without visiting further devices.

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
Resume inside the device is still a plain position into vg->vni_list, and
RTNL/RCU are dropped between dump skbs.  If a VNI located before s_idx is
removed between two calls, the entries after it shift down by one, so is one
VNI skipped from the dump?  Conversely, a VNI added before s_idx would make
one entry appear twice.

At this commit there is no generation counter, no cb->seq and no
nl_dump_check_consistent(), so userspace gets no NLM_F_DUMP_INTR indication
that the dump was interrupted.

The next patch in the series, "vxlan: vnifilter: signal interrupted
RTM_GETTUNNEL dumps", adds vxlan_vnifilter_base_seq()/cb->seq plus
nl_dump_check_consistent() in vxlan_vnifilter_dump_dev(), which covers this
case.  Would it be worth noting in this commit message that skipped or
duplicated VNIs remain possible until that patch, since this one already
claims to address shifting ordinal indexes?

> @@ -394,6 +406,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	}
>  
>  	cb->args[1] = err ? idx : 0;
> +	cb->args[2] = err ? dev->ifindex : 0;
>  
>  	nlmsg_end(skb, nlh);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915175501.391567-1-edumazet%40google.com
