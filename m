Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8123DB62A;
	Sun, 20 Sep 2026 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886095; cv=none; b=WjFdRERisvdZx7MXNFvEMzy5AydY8aiy2w4gXn7cR1SRpW75H1XC1I6xeLCxTq7LZmIYAMj37LLviaQQ39f9/9iLyaqLN4M5dXcKy7YF5+J9+/5+CgzSnTyDMx1+HGou4zv/we7Au1oMJoq7KlX/j2R0GyCCT8xrDSkf/miJWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886095; c=relaxed/simple;
	bh=dqD1tyipP1C0RZ4sdem9tb00vtHUsyKnVCSkPeTGfbw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f1wAnmn4oVMDeiNqesB1do7MRhZSO92v3rAyYEoAcerWZrcwJSncHCb7v1ZTE5Mm3AqdCao7dmwwgSngL5fuyOQ/FArnMYLGlBA3kwrLOoareRAzQT83F3hnNwnhTCOz0dk1ltQ9WXUdYMsc4Cz6Ux/C1VZ8uIz7Y6I94NLr0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyBThb6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyBThb6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05AF1F000FF;
	Sun, 20 Sep 2026 06:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789886093;
	bh=RWLxBIIM4fit7uDmBvuBpWxzsr3AUSu+ht/G3pR/VKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RyBThb6CzWUPtiTdKDyEJZPon8pUBtzP2s83l3QCvi3QGSZm+DeeHZ7Q1J9oLnlvR
	 Eu2qF3jY50loI2sa+z+DoraT7KzgtlQbnsmw4wMS0Q3BB7h6qvNL1WGr4CcP8Pu3Gn
	 zj6E74l5m0IhFRNje4dTJlgwKMB1/Zy+W0aHBGoK1ParMBBuKgr6+xxOmVgvXMfgC6
	 YtlohCk3rR9W1+Zphw5NMztIuLRCYNKHhv2lRz+QQWS8A8WrQ+TXHCG1V4K334smuo
	 0t8hq7gm2lUiJK1j7djstUForDccz1bnFfEPPmaUBG+J1WMvYVjGFBLtBkgArE001q
	 jfSDrArW+wIiA==
Subject:
 Re: [PATCH net v4] net: erspan: set lltx to avoid sch_direct_xmit deadlock
From: netdev-bot+sashiko@kernel.org
To: yun.zhou@windriver.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 06:34:52 +0000
Message-ID: <178988609227.2160803.11846126417836059113@kernel.org>
In-Reply-To: <20260916061314.936440-1-yun.zhou@windriver.com>
References: <20260916061314.936440-1-yun.zhou@windriver.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch enables `dev->lltx = true` for both IPv4 ERSPAN
  (`erspan_tunnel_init()`, net/ipv4/ip_gre.c:1371) and IPv6 ERSPAN…

--

net: erspan: set lltx to avoid sch_direct_xmit deadlock

This sets dev->lltx = true for the IPv4 and IPv6 ERSPAN tunnel devices so
that HARD_TX_LOCK() skips the txq _xmit_lock, avoiding the nested
_xmit_lock acquisition when erspan_xmit() re-enters the stack through the
underlay device.  The change is tagged for stable with Fixes tags pointing
at 84e54fe0a5ea and 5a963eb61b7c.

Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 82309efd417e0..0058cb20e36a1 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1367,6 +1367,8 @@ static int erspan_tunnel_init(struct net_device *dev)
>  	dev->features		|= GRE_FEATURES;
>  	dev->hw_features	|= GRE_FEATURES;
>  	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
> +	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
> +	dev->lltx = true;
>  	netif_keep_dst(dev);
>  
>  	return ip_tunnel_init(dev);

[Severity: Medium]
The commit message justifies the change with:

  "This is safe as erspan_xmit() has no shared mutable state: o_seqno is
   atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
   o_flags is no longer modified in the xmit path since commit 9958e69b9893"

That statement holds in this tree, but the patch also carries Cc:
stable@vger.kernel.org with Fixes tags on 84e54fe0a5ea and 5a963eb61b7c.
Commit 9958e69b9893 ("gre: fix ERSPAN o_flags race/corruption in xmit and
fill_info") has neither a Fixes tag nor Cc: stable, so it is not queued for
any stable tree.

Both hunks here only touch the *_init() functions, so they apply cleanly to
any tree that has the dev->lltx bitfield (6.12 and later) even when
9958e69b9893 is absent.  In such a tree erspan_xmit() still does the
read-modify-write on the shared per-tunnel word:

net/ipv4/ip_gre.c:erspan_xmit() (pre-9958e69b9893) {
	...
	__clear_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags);
	...
	__clear_bit(IP_TUNNEL_KEY_BIT, tunnel->parms.o_flags);
	__gre_xmit(skb, dev, &tunnel->parms.iph, proto);
	...
}

Once lltx is set, is anything left serializing two concurrent
erspan_xmit() calls on the same single-queue device, given that the txq
_xmit_lock was the only thing keeping those __clear_bit() sequences from
overlapping?  The same question applies to the race against
erspan_fill_info(), which in those trees sets IP_TUNNEL_KEY_BIT back into
tunnel->parms.o_flags under RTNL only.

If a lost update resurrects IP_TUNNEL_KEY_BIT or IP_TUNNEL_SEQ_BIT, can
gre_build_header() then emit optional GRE fields that tunnel->tun_hlen
never accounted for, i.e. exactly the header corruption described in
9958e69b9893?

Would it make sense to name 9958e69b9893 as an explicit stable
prerequisite in a note below the --- line, or to fold the equivalent
o_flags localization into this series, so stable maintainers do not apply
the lltx change on its own?

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 8ebda0b6a78b2..578fb3475f8c2 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1871,6 +1871,8 @@ static int ip6erspan_tap_init(struct net_device *dev)
>  		dev->mtu -= 8;
>  
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
> +	dev->lltx = true;
>  	ip6erspan_tnl_link_config(tunnel, 1);

The same concern applies on the IPv6 side: in trees without 9958e69b9893,
ip6erspan_tunnel_xmit() still runs

	__clear_bit(IP_TUNNEL_KEY_BIT, t->parms.o_flags);

on the shared parms word, and ip6gre_fill_info() reads it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916061314.936440-1-yun.zhou%40windriver.com
