Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634033B6EF;
	Fri, 31 Jul 2026 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465957; cv=none; b=hPb49tsrSP9F9jd6Gol+QFFyZjVIFuZgARKJeR6MY6wHU1fdaPji69YEuyfQ6dvMOYH2+1XYQqLsJPBnPC7pkQ14B20yXJ5gEYah2q4Rwcu9qYzGwbeKc7HowbxIEgRVuMKh8jTOieIE1FLkh2IE0retmqqBfxRZfSD3wGhRK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465957; c=relaxed/simple;
	bh=YXhAnCbpQfIpSH9+aP4NqP6qqAdaEKG3Q/K/0i17brE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vknyo5x+gTmTXxY0mN4BMwmgBLOH91cI+nHdVQ6VJCp6BXvUcw/ZmxhFAKhO0BVCSgGEjlHRgBInzN+KIqpE/HjW7qjE7qLL+xNShVcf8MesEMVsHcTe3q2ESLJQKwdvLbN/fZC19iZIRC7i4THcSUs1pVoG2Mynd+VDYVgq3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=g4BgawMs; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=AoMBWMT6; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="g4BgawMs";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="AoMBWMT6"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66V2j76R027288;
	Fri, 31 Jul 2026 04:45:12 +0200
Received: from lubuntu-18.04 (host-82-61-152-174.retail.telecomitalia.it [82.61.152.174])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 30A741211F3;
	Fri, 31 Jul 2026 04:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1785465903; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veD/K7HALBBirvZNsoEXPnCdS5wkZwxMAlJlWRPdo3s=;
	b=g4BgawMshc35gPjSXzdIjMmh/Pz1OSzBr1Q6fQnjQ4FGKznjfNobXFkktQWGnzgmIrLDZx
	tSnh6BvLBXDpf+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1785465903; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veD/K7HALBBirvZNsoEXPnCdS5wkZwxMAlJlWRPdo3s=;
	b=AoMBWMT6l1XrrF8LieKUU/qw5uy0gy7zEEP0AOA1Lm9QvlCFREFKwX0IWoCjsx3TjZGLDr
	z2Pve/ziiqlRs3L83twVzj/xzoE7s6w8m5futN7+o4DXcTaGV1MuGPiCv8lTRa1A4+diDr
	is618kSX2UIzqJuPixvaHUJWjcHgSrerLYEeKBaeruXfMxWFsXIuOakJa/48STJ6D17FbZ
	3cl6RofXqkfzVpyZrpvhHl/yElRCYpGbudfA65QwY7JHdTrNUIEDJWpeGzeZ0IV8fHvFZQ
	nUrYpdkApNyWUklJT99xZuzxprbDq/0XAvM+vmSMj/olEpuh0ERgVRdjLdubYQ==
Date: Fri, 31 Jul 2026 04:45:02 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: kuba@kernel.org, pablo@netfilter.org,
        "David S . Miller"
 <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryoga Saito <contact@proelbtn.com>,
        AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
        kys@microsoft.com, justin.iurman@gmail.com,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2 1/2] seg6: check lwtunnel state after nf hooks in
 seg6local
Message-Id: <20260731044502.4b208c42bcb89191489644dd@uniroma2.it>
In-Reply-To: <20260728215448.1543553-1-xmei5@asu.edu>
References: <20260728215448.1543553-1-xmei5@asu.edu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 28 Jul 2026 21:54:47 +0000
"Xiang Mei (Microsoft)" <xmei5@asu.edu> wrote:

Thanks for the v2.

The overall code looks fine.

> When nf_hooks_lwtunnel is enabled, three seg6local functions run as the
> okfn of a netfilter hook and recover the behavior's parameters by
> re-reading skb_dst(skb)->lwtstate:
>
>   seg6_local_input_core()          LOCAL_IN
>   input_action_end_dx4_finish()    PRE_ROUTING
>   input_action_end_dx6_finish()    PRE_ROUTING
>
> The okfn signature is (net, sk, skb), so the skb's dst is the only place
> the state can be found, but a hook is free to change it.
> nf_nat_ipv{4,6}_in() calls skb_dst_drop(skb) once a NAT rule has
> rewritten the addresses, and the okfn then dereferences NULL. A hook can

Isn't nf_nat_ipv4_in() called nf_nat_ipv4_pre_routing() nowadays? The IPv6
one still has _in. The rest of the sentence is right.

> also leave a metadata dst, a route whose lwtstate is NULL, or a route of
> a foreign encap type, the last of which makes seg6_local_lwtunnel()
> reinterpret another structure so that seg6_local_input_core() calls
> through slwt->desc->input.
>
> An unprivileged user can reach the End.DX6 case from a user and network
> namespace: enable nf_hooks_lwtunnel, install a seg6local End.DX6 route
> and an nftables ip6 nat PRE_ROUTING DNAT rule, then send one matching
> SRv6 packet. It panics in softirq NAPI receive context:
>
>   Oops: general protection fault, probably for non-canonical address...
>   KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
>   RIP: 0010:input_action_end_dx6_finish (net/ipv6/seg6_local.c:912)
>   Call Trace:
>    input_action_end_dx6 (net/ipv6/seg6_local.c:946)
>    seg6_local_input_core (net/ipv6/seg6_local.c:1621)
>    seg6_local_input (net/ipv6/seg6_local.c:1643)
>    lwtunnel_input (net/core/lwtunnel.c:465)
>    ipv6_rcv (net/ipv6/ip6_input.c:351)
>    __netif_receive_skb_core.constprop.0 (net/core/dev.c:6165)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Add a helper that returns the state only when skb_dst() still is a real
> (non-metadata) route whose lwtstate is of the expected type, and drop the
> packet otherwise.
>
> The six other callers of seg6_local_lwtunnel() take the lwtunnel_state as
> an argument from the lwtunnel core, which dispatched them through
> seg6_local_ops, so the pointer and its type are known good.
>

That is true except for seg6_local_build_state(), which allocates the
lwtunnel_state with lwtunnel_state_alloc() and passes it back through the
output parameter. The pointer is still known good there, just for a
different reason.

> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
> v2:
>  - Check that the dst is valid and its lwtstate is of the expected type,
>    not just that the dst is non-NULL (Jakub Kicinski, Pablo Neira Ayuso,
>    Sashiko).
>  - Also fix seg6_local_input_core(), same okfn-after-NF_HOOK shape.
>  - seg6_iptunnel.c is handled in patch 2/2 (Andrea Mayer).
>
> v1: https://lore.kernel.org/all/20260720204430.1886091-1-xmei5%40asu.edu/
>
>  net/ipv6/seg6_local.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 2b41e4c0dddd..b75a4dc3a36d 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -24,6 +24,7 @@
>  #include <net/addrconf.h>
>  #include <net/ip6_route.h>
>  #include <net/dst_cache.h>
> +#include <net/dst_metadata.h>
>  #include <net/ip_tunnels.h>
>  #ifdef CONFIG_IPV6_SEG6_HMAC
>  #include <net/seg6_hmac.h>
> @@ -213,6 +214,17 @@ static struct seg6_local_lwt *seg6_local_lwtunnel(struct lwtunnel_state *lwt)
>  	return (struct seg6_local_lwt *)lwt->data;
>  }
>
> +static struct seg6_local_lwt *seg6_local_lwt_from_skb(struct sk_buff *skb)
> +{
> +	struct dst_entry *dst = skb_dst(skb);
> +
> +	if (!skb_valid_dst(skb) || !dst->lwtstate ||
> +	    dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6_LOCAL)
> +		return NULL;

The check is type-level, so it stops the crash without guaranteeing the
same instance, as we discussed on v1. That is reasonable for net.

> +
> +	return seg6_local_lwtunnel(dst->lwtstate);
> +}
> +
>  static struct ipv6_sr_hdr *get_and_validate_srh(struct sk_buff *skb)
>  {
>  	struct ipv6_sr_hdr *srh;
> @@ -905,11 +917,14 @@ static int input_action_end_dx2(struct sk_buff *skb,
>  static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
>  				       struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	struct in6_addr *nhaddr = NULL;
>  	struct seg6_local_lwt *slwt;
>
> -	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> +	slwt = seg6_local_lwt_from_skb(skb);
> +	if (!slwt) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}

One nit: the same check has unlikely() in patch 2/2 but not here. It is
just as rare here, so I would add it, and to the others below as well.

>
>  	/* The inner packet is not associated to any local interface,
>  	 * so we do not call netif_rx().
> @@ -956,13 +971,16 @@ static int input_action_end_dx6(struct sk_buff *skb,
>  static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
>  				       struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	enum skb_drop_reason reason;
>  	struct seg6_local_lwt *slwt;
>  	struct iphdr *iph;
>  	__be32 nhaddr;
>
> -	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> +	slwt = seg6_local_lwt_from_skb(skb);
> +	if (!slwt) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
>
>  	iph = ip_hdr(skb);
>
> @@ -1609,13 +1627,17 @@ static void seg6_local_update_counters(struct seg6_local_lwt *slwt,
>  static int seg6_local_input_core(struct net *net, struct sock *sk,
>  				 struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	struct seg6_action_desc *desc;
>  	struct seg6_local_lwt *slwt;
>  	unsigned int len = skb->len;
>  	int rc;
>
> -	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> +	slwt = seg6_local_lwt_from_skb(skb);
> +	if (!slwt) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
> +
>  	desc = slwt->desc;
>
>  	rc = desc->input(skb, slwt);
> --
> 2.43.0
>

I will follow up on patch 2/2.

Ciao,
Andrea
