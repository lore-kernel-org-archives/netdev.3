Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B3470E92;
	Thu, 23 Jul 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827378; cv=none; b=mPNHTZXPcRLsTx6KhrUApdbgPbAUq7IKg/2oy1iklp1Bj0XOqRT6dSiskGZpZLesJ0dpyseUECOvd1lDg5tLNU0W1FnE9NbtM+lTBmV9iOcQsX2tL4Z/5kDv3E1Viz+f4CCM2Q6BiUKj5ijd2xFb8x19u9J9L166LU9krXdmLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827378; c=relaxed/simple;
	bh=+GBoG1iFHFbXN1UA+4JYNqN5y5vwhyogQ/aT8iRwUvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK25c1/gOz/ZSo7SxhmHXPMC+r1E6/GinJNQMOReS6MAKi0QVIvCUUT7n1jtqVZmpxA4Bz9rVdyGuHL6IVjIURltFk/q+EHPiw8ifrvljMCHpdfSIvt0hlVEx/iQD9QvxdiKg9WE9UiLxzvrPrpou+2S+rtLMtatMeLoN1TrOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=sD9KUK48; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="sD9KUK48"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C5D5760191;
	Thu, 23 Jul 2026 19:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1784827373;
	bh=5xzz4IwMvyGPIBEam+MyTsNSIxFkfzg9bsnh9V0M1yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sD9KUK48mcWLsF5ObDzp64Ul2NMQIx6GfQmdS/QYRPN97EJIR4M5NFK7hO1lJ1zis
	 Wmg543uDy9dW/jcWa78osGQ5+SPKMsYCDyBkPcW/EAvS7ogY8FnJX52Y17miikTyV0
	 /CE4qwhRy3u49NRICaXCv+6Kau+Ll/sTkWlpV8rY3vFEiM35VH4UCh2M6dHZ8P8dG9
	 1fEJkV1WAWxyuklgUdrkUA1tFpp5zmOch1W3OK47mzcBp7W4mxTRq/LTDpThzYwqdL
	 3frfnVJPGbfLAT/zkphnXXVbIcS/JbgQ1isN3M6NP/ic3UFizZre0F8CUUs7r+k5gk
	 9Sq6EEl+8CgQQ==
Date: Thu, 23 Jul 2026 19:22:51 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ryoga Saito <contact@proelbtn.com>,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH net] seg6: fix NULL deref in
 input_action_end_dx{4,6}_finish() after nf hook
Message-ID: <amJN67Vtl0atkj7H@chamomile>
References: <20260720204430.1886091-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720204430.1886091-1-xmei5@asu.edu>

On Mon, Jul 20, 2026 at 08:44:29PM +0000, Xiang Mei (Microsoft) wrote:
> When nf_hooks_lwtunnel is enabled, the End.DX4/End.DX6 actions dispatch
> the decapsulated inner packet through the NF_INET_PRE_ROUTING hook chain
> with input_action_end_dx{4,6}_finish() as the okfn. Both functions read
> the lwtunnel state via orig_dst = skb_dst(skb) and dereference
> orig_dst->lwtstate.
> 
> A hook in that chain can legitimately drop the dst: nf_nat_ipv{4,6}_in()
> calls skb_dst_drop(skb) when a DNAT rule rewrites the destination
> address, leaving skb_dst(skb) NULL. The okfn then dereferences a NULL
> orig_dst, causing a general protection fault and a panic (the fault
> happens in softirq NAPI receive context).
> 
> Free the skb and bail out when the dst was dropped, instead of
> proceeding with a lost lwtunnel state.
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
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  net/ipv6/seg6_local.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 2b41e4c0dddd..45e66ba306ca 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -909,6 +909,11 @@ static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
>  	struct in6_addr *nhaddr = NULL;
>  	struct seg6_local_lwt *slwt;
>  
> +	if (!orig_dst) {

This should be:

        if (!skb_valid_dst(orig_dst)) {

> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
> +
>  	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
>  
>  	/* The inner packet is not associated to any local interface,
> @@ -962,6 +967,11 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
>  	struct iphdr *iph;
>  	__be32 nhaddr;
>  
> +	if (!orig_dst) {

Same here.

> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
> +
>  	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
>  
>  	iph = ip_hdr(skb);
> -- 
> 2.43.0
> 
