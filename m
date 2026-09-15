Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47073CEB98
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437672; cv=none; b=REIsbFJDo3CKMscpOPtDyGV0AjI7UH4Mms0HyS3Vm0B0pyVqbgmJuzmlq++PHtaREJRtd8VrIKP3CDMnbwTzpgbBx9JLXwcV8u2u1pcZKE+wr4Rpn4Gk2SIKHBlOOpK8HWIPSabhjGQjCoGGqDJ/BU7fhSsxcaP5J/nMXtnYW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437672; c=relaxed/simple;
	bh=uAi004DPNuVsapG2niRAiSz7hWBK9ol+EQfGcdq3ko8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=forV83itvCMKehnQT8QvPNJwoLV3/ykm2jtFJUw/7pyz8MUvkZsTcsZCo0OJwICiH0m5LuZV+sknBguBWC+j23V6OoOtwioSREkiVhzgZTfncaF310iaIN2Y6M4/pS+iyjv1HNTPQWwjHvtgfHi6JCN/voK8oDg0uC79r66pFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4rb0EXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4rb0EXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1961F00893;
	Tue, 15 Sep 2026 02:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437670;
	bh=e64dnLpPkMOwdj8zEYlGbX7uGNtEN20UJgQNONpMUto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4rb0EXvz5JCcDEpiTBGbQ9JHPsWt1AR1VONZkK+gE8vJouT/TgWKZ1W8WO/Rk7r/
	 AGdXPc2acgfoUxLMz4oeVDYvGcfRs/hduh3ZvPf9Pag7vjbAwi7Y4DD3d6+JcW3Qe5
	 Lujb3hJC3a4/MSBl8Px/yuy9tuUyj3cZ/qu7gIzRemXRjgyF5KEw6ZES9XqQwPv33n
	 f/t6rVC8IsF0+1X5E+6+WmHUhdQae65nVW+xB3pbdNKjtnRZGMrgMFrj0CEL+Qokr1
	 jNh3UFuNyeJ0VHX5w5Np/nW+VsPpj+4fQBcm9CRI8bhECiGGeHBxm62Zd79trE2b0f
	 IG5v+n49qlUmQ==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	idosch@nvidia.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net-next 1/6] vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
Date: Mon, 14 Sep 2026 19:00:09 -0700
Message-ID: <20260915020009.886579-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911062200.231316-2-edumazet@google.com>
References: <20260911062200.231316-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()

This switches the vg->vni_list walk in vxlan_vnifilter_dump_dev() to
list_for_each_entry_rcu(), clears the saved VNI offset on the early
return paths, and adds cb->args[2] to track the ifindex of the device
currently being dumped so the VNI offset is reset when the device
changes.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e08865..0a18c32902da0 100644
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

[Severity: High]
The commit message says the ifindex tracking handles the case where
"devices are added or removed between dump calls, ordinal device indexes
can shift".  Can this new check actually observe that case?

In vxlan_vnifilter_dump() the device cursor is still a bare ordinal, and
devices below it are skipped before vxlan_vnifilter_dump_dev() is ever
called:

	int idx = 0, err = 0, s_idx = cb->args[0];
	...
		for_each_netdev_rcu(net, dev) {
			if (!netif_is_vxlan(dev))
				continue;
			if (idx < s_idx)
				goto skip;
			err = vxlan_vnifilter_dump_dev(dev, skb, cb);
			if (err == -EMSGSIZE)
				break;
skip:
			idx++;
		}
	}
	cb->args[0] = idx;

On -EMSGSIZE the loop breaks before idx++, so cb->args[0] is the ordinal
of the partially dumped device A while cb->args[1]/cb->args[2] hold A's
VNI offset and ifindex.  RTM_GETTUNNEL is registered with flags 0:

	{THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL, vxlan_vnifilter_dump, 0},

so rtnl_dumpit takes and releases RTNL per dump skb.  If a vxlan device
preceding A is unregistered in that window, A shifts down to ordinal
s_idx - 1 and is skipped by the "if (idx < s_idx) goto skip" test, so
vxlan_vnifilter_dump_dev() never runs for A and the new cb->args[2]
comparison never happens.  A's remaining VNIs then disappear from the
dump and the dump ends looking complete.  Would an ifindex-keyed device
walk (for_each_netdev_dump()) be needed to close that?

There is also the same-device case.  The commit message says the stale
offset "silently skipp[ed] their first N VNIs", but s_idx here is still a
plain count of entries to skip in a freshly re-walked list, and the
writers mutate that list while RTNL is dropped:

	__vxlan_vni_add_list()
		list_add_rcu(&v->vlist, hpos);	/* sorted by vni */
		vg->num_vnis++;

	__vxlan_vni_del_list()
		list_del_rcu(&v->vlist);
		vg->num_vnis--;

Since the insertion is sorted by VNI it can land before the resume point,
shifting ordinals up so an already dumped entry is emitted a second time;
a deletion before the resume point shifts them down so an entry that was
never dumped is skipped.  In both cases cb->args[2] still equals
dev->ifindex, so the new reset does not fire.  Would resuming from the
last dumped VNI value rather than an ordinal offset avoid this?

Finally, nothing signals the tear to user space.  vxlan_vnifilter_dump_dev()
calls nlmsg_end() without assigning cb->seq or calling
nl_dump_check_consistent(), and the VNI list writers bump no generation
counter, so NLM_F_DUMP_INTR is never set.  The MDB dump in the same driver
does do this:

drivers/net/vxlan/vxlan_mdb.c:vxlan_mdb_dump() {
	...
	nlmsg_end(skb, nlh);

	cb->seq = vxlan->mdb_seq;
	nl_dump_check_consistent(cb, nlh);
	...
}

Should the vnifilter dump publish a similar generation counter so a
skipped or repeated VNI is at least visible to user space?

>  
>  	/* RCU needed because of the vni locking rules (rcu || rtnl) */
>  	vg = rcu_dereference(vxlan->vnigrp);

[ ... ]

> @@ -362,7 +374,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	new_tmsg->family = PF_BRIDGE;
>  	new_tmsg->ifindex = dev->ifindex;
>  
> -	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
> +	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
>  		if (idx < s_idx) {
>  			idx++;
>  			continue;
> @@ -394,6 +406,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
>  	}
>  
>  	cb->args[1] = err ? idx : 0;
> +	cb->args[2] = err ? dev->ifindex : 0;
>  
>  	nlmsg_end(skb, nlh);
>  

For reference, the ordinal cursors and the missing cb->seq /
nl_dump_check_consistent() are still present at the end of the series
(1c77987f9ffa), so no later patch appears to change this.
