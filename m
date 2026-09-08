Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964759C993
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890639; cv=none; b=u6pmfljh6WKiTAGvTel1SaoIX9ZFCfLL9aEidYqspSwMuXeLGssGf8lvWu9Ix6Y7mNzgMg0tDUCqk5Xcw4ow6B4cDsRaHl+FlG3Y4qEaweXQX0q4VWsARXucYV08/lykY5Ul8TzL8hhl7QnMc4wiOFlmG5e6kgFoxYCfZyqBwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890639; c=relaxed/simple;
	bh=OwBuaJXosG6suKo2hAYord1oqqHJXMcVio26WNJc4jc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rzxu4z+mix5asUcaM7Q7iQsqlozBTjGAv7yfbrkXgplbMrGRuGanzAGoDYySaFNmv0h5HNkJ1FEcuP3AJOX1BweRixqBDl0btIasZUvOeGxKiQmSL7kfY/xgZKRkqodd9O2tvqA03IQCRCSki96U+36+dMF3vCE7fMemu9AZTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1cww0F0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1cww0F0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5BA1F00A3E;
	Tue,  8 Sep 2026 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890636;
	bh=t9cHojouCj3ThmUY0XSnfXYH55J3WyfqC1ZaNakPTug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k1cww0F0lo42dJaRUKmIxFA20nWWDI0BB8AhJ54XYEP/e77A5lD/958Mms08xcnzk
	 Hv9yovW+sC7noe5fXaseOX7+y62P62eRVRa3gPpbAS3eGR6t52JjG+5nJ279wh1JAf
	 2YK/uXLA5U/kBNDnulOKOv/V5G33n0gw4O3fTwdV3Me2VSBm8BlOiIa7cGR2Mht5+T
	 aNA0Imek79YQiVdE9956vqP8PFhj/IcHbqGS6uKEo/QdMhtdpnE+XXVAe1B78pavEG
	 +oA/6VA0waZw1UEMAg4Oe/hq7I1GkHljHdBC/yZUtLeGaZJA8MjrL34SKYVHM0OXij
	 PZcORKM9vw+ug==
Subject:
 Re: [PATCH v2 net-next 6/8] vxlan: convert configuration to RCU protection
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 18:03:55 +0000
Message-ID: <178889063521.219967.13537609905770659520@kernel.org>
In-Reply-To: <20260906180111.1973188-7-edumazet@google.com>
References: <20260906180111.1973188-7-edumazet@google.com>
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

- [Medium] The changelog of "vxlan: convert configuration to RCU
  protection" presents the patch as pure groundwork ("In order to allow…

--

vxlan: convert configuration to RCU protection

This converts vxlan->cfg into an __rcu pointer, switches readers to
rcu_dereference()/rtnl_dereference(), publishes new configurations with
rcu_assign_pointer() and frees the old one with kfree_rcu().  Callers in
mlxsw and the vxlan mdb/multicast/vnifilter code are updated accordingly.

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 5bc3475886b09..b79a15985a994 100644
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

> @@ -2787,7 +2787,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>  	u32 nhid = 0;
>  	u32 flags;
>  
> -	cfg = vxlan->cfg;
> +	rcu_read_lock();
> +	cfg = rcu_dereference(vxlan->cfg);
>  	flags = cfg->flags;
>  	default_vni = cfg->vni;
>  	saddr_family = cfg->saddr.sa.sa_family;
> @@ -2806,14 +2807,19 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>  				vxlan_xmit_one(skb, dev, cfg, vni, NULL, false);
>  			else
>  				kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_TXINFO);
> +			rcu_read_unlock();
>  			return NETDEV_TX_OK;
>  		}
>  	}
>  
>  	if (flags & VXLAN_F_PROXY) {
>  		eth = eth_hdr(skb);
> -		if (ntohs(eth->h_proto) == ETH_P_ARP)
> -			return arp_reduce(dev, skb, cfg, vni);
> +		if (ntohs(eth->h_proto) == ETH_P_ARP) {
> +			netdev_tx_t res = arp_reduce(dev, skb, cfg, vni);
> +
> +			rcu_read_unlock();
> +			return res;
> +		}

[ ... ]

> @@ -4040,9 +4051,10 @@ static void vxlan_config_apply(struct net_device *dev,
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
Could the changelog mention that this patch also closes a use-after-free
window opened by the previous patch in the series, "vxlan: dynamically
allocate struct vxlan_config" (ae42529dbdc6)?

At that parent commit, vxlan_config_apply() frees the old configuration
immediately:

	old_cfg = vxlan->cfg;
	vxlan->cfg = new_cfg;
	kfree(old_cfg);

and there is no synchronize_net()/synchronize_rcu() anywhere in
vxlan_core.c at that revision, while softirq readers hold a plain pointer
to the object being freed.  vxlan_xmit() reads it before taking any RCU
read lock:

	cfg = vxlan->cfg;
	flags = cfg->flags;
	default_vni = cfg->vni;
	saddr_family = cfg->saddr.sa.sa_family;

and then passes cfg into arp_reduce()/neigh_reduce()/vxlan_xmit_nhid()/
vxlan_xmit_one().  vxlan_rcv() does the same and dereferences
cfg->reserved_bits.vx_flags.

So with the parent commit alone, running "ip link set <vxlan> type vxlan
..." (vxlan_changelink() -> vxlan_config_apply(), RTNL only) while traffic
flows frees the config under concurrent TX/RX softirq readers.  Only this
patch makes that safe, via kfree_rcu(old_cfg, rcu) plus the reader-side
rcu_dereference()/rcu_read_lock().

Would it make sense to either use kfree_rcu() already in the previous
patch, squash the two, or at least note in the changelog that the two must
not be reordered, split or partially backported, since a bisect landing on
the previous commit hits a real use-after-free in the TX/RX paths?  No
Fixes: tag looks needed, as struct vxlan_config is still embedded in struct
vxlan_dev at the series baseline, so no released kernel is affected.

Separately, could the changelog also mention the vxlan_xmit()
restructuring?  A single rcu_read_lock() now spans the whole function and
five new rcu_read_unlock() calls are added on the metadata, ARP proxy, ND
proxy, nhid and MDB early return paths, which is a hot path change readers
currently have to infer from the diff.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906180111.1973188-1-edumazet%40google.com
