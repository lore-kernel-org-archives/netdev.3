Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5D3876C9
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761484; cv=none; b=NXdI3xtl1lZU9MfaFa0tA4QMC3A2qvB5ksvD69nBP6fX7vb+uZLsGmp1zDHWXpwWkQtZ2Cigz+uegx3tk9Id0r9v/34gRNX/7mx5hprReyf9kaGmjDuZ3qAanRDTHhX1k7/fC5CZp/cvNuWaFor5X+g2rZiWufqFo95CQTA6Qxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761484; c=relaxed/simple;
	bh=+UMbsviVjO5pyUXtdonNVl76O0/qws6vlaJQuMs4PnA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjhWMerCB8bwTvMvelGXtZHtpUlgKJNPjKWG4yr3RrrlPaO+aTMMF6kcT5VF1cp3VGHvz3seBTHKMgTMTdlVmpNBLHcSF4y9d4VOxoxC2RsBOWrgXVtoyL6S4evIGDMRKXBIfw+0YyK5a62dMhWudRvLNCGx/PVLvtCenb7Chso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go+g3N4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go+g3N4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379251F00A3D;
	Mon,  7 Sep 2026 06:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761482;
	bh=lO9gpVVzGIESPEMZBPw4cMp7DERchWccYiFB677C7cM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=go+g3N4LAWItfcIUUGW1bgsgAQYsj14wActYDNzuHWvsu1AHlijPKCRdxXiJYNV0w
	 tCaVTTyrh+B4AsElGS5pnqoKRGm5WtsFOBvWKhXKoaro6vkQ1jtdbnTsWy0jUzClNs
	 mcOVaM7XWWGTr2MPKpH4t7gVJ7Jd0tUCLgfSjq+E0gA9pyO1p4nW7h/KOveXU4N48t
	 e6b2LWdo7WLb5zf3/FV/ZV0n3FgrvAHUUgvgkmdWcRSK11SHiPFk7EO1ePLWM6yzYC
	 8vVnyb0u1MH9VfQrh2QzMT23x+vh67aT83rTKTVsFifj6XjOdy3PDk8qCv/k3XdycL
	 0FkrBZ/ET39wQ==
Subject: Re: [PATCH net-next 2/9] vxlan: vnifilter: free vxlan_vni_group via
 RCU in vxlan_vnigroup_uninit()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 07 Sep 2026 06:11:21 +0000
Message-ID: <178876148175.219967.9585071476410633782@kernel.org>
In-Reply-To: <20260903120840.1024153-3-edumazet@google.com>
References: <20260903120840.1024153-3-edumazet@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Changelog premise is not supported by the code: commit "vxlan:
  vnifilter: free vxlan_vni_group via RCU in vxlan_vnigroup_uninit()"…

--

vxlan: vnifilter: free vxlan_vni_group via RCU in vxlan_vnigroup_uninit()

This clears vxlan->vnigrp with rcu_assign_pointer() in
vxlan_vnigroup_uninit() and defers the freeing of struct vxlan_vni_group
to kfree_rcu(), adding an rcu_head to the structure.  It is described as
fixing a use-after-free between device deletion and an RTM_GETTUNNEL dump.

>     vxlan->vnigrp is an RCU-protected pointer accessed locklessly under
>     rcu_read_lock() in vxlan_vnifilter_dump_dev().
>
>     Currently, vxlan_vnigroup_uninit() frees struct vxlan_vni_group
>     synchronously via kfree(vg). If a VXLAN device is deleted concurrently
>     with an RTM_GETTUNNEL dump, vxlan_vnifilter_dump_dev() can suffer a
>     use-after-free when reading vg->num_vnis or walking vg->vni_list.
>
>     Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")

[Severity: Medium]
Is the described race reachable in this tree?  The RTM_GETTUNNEL dump is
registered without RTNL_FLAG_DUMP_UNLOCKED:

drivers/net/vxlan/vxlan_vnifilter.c:
static const struct rtnl_msg_handler vxlan_vnifilter_rtnl_msg_handlers[] = {
	{THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL, vxlan_vnifilter_dump, 0},

With flags == 0, rtnl_dumpit() wraps the whole callback in RTNL:

net/core/rtnetlink.c:rtnl_dumpit() {
	const bool needs_lock = !(cb->flags & RTNL_FLAG_DUMP_UNLOCKED);
	...
	if (needs_lock)
		rtnl_lock();
	err = dumpit(skb, cb);
	if (needs_lock)
		rtnl_unlock();
}

so vxlan_vnifilter_dump() and vxlan_vnifilter_dump_dev() run with RTNL held,
not "locklessly" as the changelog states.

On the freeing side, vxlan_vnigroup_uninit() is reached only from the
vxlan_init() error path and from vxlan_uninit() (ndo_uninit), both of which
run under RTNL via register_netdevice() and
unregister_netdevice_many_notify().  Doesn't that make the dump and the free
mutually exclusive today?

The dump also does not cache a device or vnigrp pointer across paginated
recvmsg iterations: it stores only an ifindex in cb->args[0] and re-resolves
through dev_get_by_index_rcu()/for_each_netdev_rcu(), so a stale vnigrp does
not appear to be observable between iterations either.

The code change itself looks harmless, since the remaining readers already
tolerate a NULL vnigrp:

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vnifilter_dump_dev() {
	/* RCU needed because of the vni locking rules (rcu || rtnl) */
	vg = rcu_dereference(vxlan->vnigrp);
	if (!vg || !vg->num_vnis)
		return 0;

and vxlan_vnifilter_lookup() in drivers/net/vxlan/vxlan_private.h does the
same NULL check.

Would it be more accurate to describe this as preparation for an
RTNL-unlocked RTM_GETTUNNEL dump, and to drop the Fixes: tag (or justify it)
so this is not backported to stable as a use-after-free fix?

The next patch in the series, "vxlan: vnifilter: use
list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()", repeats the same
premise ("runs under rcu_read_lock() without RTNL"), and the RTM_GETTUNNEL
handler is still registered with flags == 0 at the end of the series, so the
same question applies there.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e0886..ddfa24ad16f9 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -902,6 +902,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
>  	struct vxlan_vni_group *vg;
>  
>  	vg = rtnl_dereference(vxlan->vnigrp);
> +	rcu_assign_pointer(vxlan->vnigrp, NULL);
>  	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
>  		rhashtable_remove_fast(&vg->vni_hash, &v->vnode,
>  				       vxlan_vni_rht_params);
> @@ -914,7 +915,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
>  		call_rcu(&v->rcu, vxlan_vni_node_rcu_free);
>  	}
>  	rhashtable_destroy(&vg->vni_hash);
> -	kfree(vg);
> +	kfree_rcu(vg, rcu);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903120840.1024153-1-edumazet%40google.com
