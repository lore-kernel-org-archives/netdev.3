Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552038E8C3
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761489; cv=none; b=Hqu1BGFa7HhcampK8efdtBBoIy8jZwu50J2WjTzTRvY+MJBXq1f6gXrpksUfRi8mwAnEdJye6P6kkuFUSLisPcVTuU/9WmDEAo9FV45hJOQgMI+nmsLUD7aqjfaglhF4/sz6Q1Bfuxhh7GAS7t99v7NhgIfI+KKAGoOZ/Hc86OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761489; c=relaxed/simple;
	bh=h2PO2nr953dK1mV0ApmclkJ9m9axf3GOnPYnUr/3zZA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iommKPBRNzgbxBdFMc26A991JAVH7ywAbP3uVZ087mu5PNmyH9ENPFxbx1qVy/UUg8USmHyj5/lOgeSBaA9rhdPMXtkyrYYdavIA9AolMxAGOniWQ+FDve5iVXjOdrzd62Iyn2aEylSr7pwfSTY7tbMXNwUZQjWcSDHT19UwrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km8BwP3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km8BwP3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8F61F00A3F;
	Mon,  7 Sep 2026 06:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761487;
	bh=mgv7FnkYPnLdmc1xlHYhujnzQDQlZu/DNfprZcCCdvo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=km8BwP3On+mvrghiBBWl1eQuPTJIizZOmCuEM8kejZ7sh0UU1pEfMvbU4mg7Idtov
	 I4GbfSvVt+5boyzqn6mbWjpLjT2aauw2uBSsHEInTK9/yFgzpfn30W1MES+qWygTaV
	 5WIu2k1pTHhirA5dlXT0/GHH4Qkpgf1XPMnn/WQ/92gSTVmLmO2WTddfim9Mi2Eq8j
	 lnBSad6/AfhzeYwfAOm2UUDtIkP6Azm3KAi41chaYl+HMAn+HPLXFzn9yaSln4ksXE
	 4y3HlSjWMv9IbM/l9qbGRLfRGV9zq+ZG0f9lVCPZYNa/yQKXoLxB1SQG52obF8a7Af
	 7TDyMmZyprJEg==
Subject:
 Re: [PATCH net-next 7/9] vxlan: convert configuration to RCU protection
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 07 Sep 2026 06:11:26 +0000
Message-ID: <178876148639.219967.11080038703047476901@kernel.org>
In-Reply-To: <20260903120840.1024153-8-edumazet@google.com>
References: <20260903120840.1024153-8-edumazet@google.com>
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

- [Medium] Commit message mischaracterizes a memory-safety fix as
  preparatory refactoring, leaving a transient use-after-free in the…

--

vxlan: convert configuration to RCU protection

This converts vxlan->cfg into an __rcu pointer, switches the readers to
rcu_dereference()/rtnl_dereference() and publishes new configurations with
rcu_assign_pointer() while freeing the old one via kfree_rcu().  The TX path
in vxlan_xmit() also grows an rcu_read_lock() section covering all of its
exit paths.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index af320173a1e7..c49d55de020f 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -1704,7 +1704,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  		goto drop;
>  	}
>  
> -	cfg = vxlan->cfg;
> +	cfg = rcu_dereference(vxlan->cfg);
>  
>  	if (vh->vx_flags & cfg->reserved_bits.vx_flags ||
>  	    vh->vx_vni & cfg->reserved_bits.vx_vni) {

[ ... ]

> @@ -2781,7 +2781,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>  	u32 nhid = 0;
>  	u32 flags;
>  
> -	cfg = vxlan->cfg;
> +	rcu_read_lock();
> +	cfg = rcu_dereference(vxlan->cfg);
>  	flags = cfg->flags;
>  	default_vni = cfg->vni;
>  	saddr_family = cfg->saddr.sa.sa_family;

[ ... ]

> @@ -4034,9 +4045,10 @@ static void vxlan_config_apply(struct net_device *dev,
>  	needed_headroom += vxlan_headroom(flags);
>  	dev->needed_headroom = needed_headroom;
>  
> -	old_cfg = vxlan->cfg;
> -	vxlan->cfg = new_cfg;
> -	kfree(old_cfg);
> +	old_cfg = rtnl_dereference(vxlan->cfg);
> +	rcu_assign_pointer(vxlan->cfg, new_cfg);
> +	if (old_cfg)
> +		kfree_rcu(old_cfg, rcu);
>  }

[Severity: Medium]
Is this change really just preparation, or is it the patch that closes a
use-after-free opened by the preceding patch in the series?

The changelog says:

    In order to allow lockless readers in future patches, convert 'vxlan->cfg'
    to an RCU protected pointer.

but the lockless readers seem to exist already.  At the parent commit
5a2b432e8977 ("vxlan: dynamically allocate struct vxlan_config"),
vxlan_config_apply() does:

	old_cfg = vxlan->cfg;
	vxlan->cfg = new_cfg;
	kfree(old_cfg);

with no grace period, while vxlan_xmit() (softirq) does a plain
cfg = vxlan->cfg; and hands that pointer down to vxlan_xmit_one(),
arp_reduce(), neigh_reduce() and vxlan_xmit_nhid(), and vxlan_rcv() (UDP
encap softirq) does the same before dereferencing cfg->reserved_bits.
vxlan_vs_find_vni(), the vxlan_cleanup() age timer and
vxlan_fill_metadata_dst() read it the same way.

So at that intermediate commit:

CPU0 (RTNL, RTM_NEWLINK changelink)
  vxlan_changelink()
    vxlan_config_apply()
      kfree(old_cfg);

CPU1 (softirq)
  vxlan_xmit()
    cfg = vxlan->cfg;        /* may already be the freed old_cfg */
    flags = cfg->flags;

Can an "ip link set ... type vxlan ..." concurrent with traffic free the
config under a live TX or RX reader at that commit?

If so, would it make sense to squash the two patches, or at least say in
this changelog that the previous patch opens that window and this one closes
it, so a partial backport or a bisect does not land on the unsafe commit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903120840.1024153-1-edumazet%40google.com
