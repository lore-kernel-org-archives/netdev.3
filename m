Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484659;
	b=zwCUR4M82qabdQBjD0+qm/bdmCNToB/c/nQbEvVzsaLpkXus76Je2F5aPoG9izWOBhVD
	 yK19AxoxChkqIRPGuk25hN0IDlgy34zDcYkPn0tBt+hjKU2VshpWxkzgUe9DUhA1GMjwh
	 rguS7oM4Ew4ExPOaDrNLvNczFaL2L+rgy/FnEe4ishgoogRo/oefqoETiKAkF5thYFy2T
	 2OrrDGg67Ts52gTe4rtiVAbo9Cl8GpKfUTcuXgHU7cIOg0D/pRHculvlpXVkLExULt/SC
	 rcsjOHZX4I+tNaLpDqnJqS3iGR/qWFoIBALXW7nybNM8vy9I5gmGQJMcu3ADaaw1gZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484659;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=DlqCpQB/w1xCgluvOYBDtPMi5u63nGRC4F/2Y68cDf8=;
	b=gCTj1ZTO5984DpuTwOvEbw1WEiIyXyMLC+UPahvUqPuj36m9c/z1i5NvdnV/zQR9EiQr
	 xXMs28J2mBuqATcxktUoMR435kycIt1JW23whUW4yL+7WqufEt/XCBZaeXmAEO63U20VH
	 l7W3Oka29lkS4i/FsgLGgU7qG9E9U/vh5eFo2EtsB6W7obASKtZpd+qG70r1hzespc+mT
	 vVREdO6PzBf+97nF6U0MwMzdphVe4ed8S6hYhB9fMx7tHHA8mqZ7++uRWO2yzlDtpVOlG
	 GCIihr39f5ThtU4JIsv27CCfJ1oTj9JzxmAQiQspz4TKIAboMTbk9xNdU9DM9GtshJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=NStMJvN6;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5212C606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5212C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=NStMJvN6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1792484656;
	bh=DlqCpQB/w1xCgluvOYBDtPMi5u63nGRC4F/2Y68cDf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NStMJvN6839dvoSVVeUgHtHDBXN1sZlL+kDUHsSL4meeznx09g31ClyTk48pjfwfw
	 ySJ6Iqe7J1ZR1GpbAEP449F6UrlbrNTkIfEOXNRVPvZqiwAqHoydZ68yO6LtkbEqhY
	 E6bdjqAPCjaqmc1pWsT67fJK1K0e0UxMYJVcVTqoC8wJn0ktQP748D+CBKQPokWvWU
	 rm2zqUy22rW0AgY9eItyhEjxYQ4Y8v9kPjIwUwydhYbM1NXoO4ttJjA1XVsXLfgHSB
	 a6spnXN2K+HjUMYvmC7K4Chl0YgDhe6XF2FgoySXFSbeeGMCAS78Fjd1a7N8E0lzKU
	 BCwsYiUWfO05A==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C879C60056;
	Tue, 20 Oct 2026 10:24:15 +0200 (CEST)
Date: Tue, 20 Oct 2026 10:24:13 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org,
	andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	contact@proelbtn.com, vega@nebusec.ai, sashiko-bot@kernel.org,
	petalzu987@gmail.com
Subject: Re: [PATCH net v2 1/1] seg6: validate state in netfilter
 continuations
Message-ID: <atclLb6SyGvOtm5p@chamomile>
References: <cover.1792230570.git.petalzu987@gmail.com>
 <ec7399b424e82f050a1ff5dc79537aee1d93723a.1792230570.git.petalzu987@gmail.com>
 <atbRd1km4IlW4wwY@fedora>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atbRd1km4IlW4wwY@fedora>

On Tue, Oct 20, 2026 at 10:27:03AM +0800, Hangbin Liu wrote:
> On Sun, Oct 18, 2026 at 02:27:29PM +0800, Ren Wei wrote:
> > From: Zixuan Chai <petalzu987@gmail.com>
> > 
> > Netfilter hooks can drop or replace skb_dst() while an SRv6 packet is
> > queued for continuation. The End.DX4 and End.DX6 finish callbacks and
> > the seg6local input continuation currently dereference the destination's
> > lwtstate without validating it. The seg6_iptunnel input and output
> > continuations make the same assumption after POST_ROUTING hooks.
> > 
> > Validate skb_valid_dst(), a non-NULL lwtstate, and the expected
> > LWTUNNEL_ENCAP_SEG6_LOCAL or LWTUNNEL_ENCAP_SEG6 type before using the
> > state. Drop the skb when validation fails. This check is by type, not by
> > identity of the original state. It does not walk through an XFRM dst or
> > take an additional lwtstate reference. Retain the loop-detection
> > explanation for saving the lwtstate address in seg6_input_core().
> > 
> > The End.DX4 reproducer creates a SEG6_LOCAL End.DX4 SID, enables
> > nf_hooks_lwtunnel, installs an IPv4 PREROUTING DNAT rule, and injects an
> > outer IPv6/inner IPv4 frame through AF_PACKET from a non-root user in a
> > fresh user/network namespace. DNAT drops skb_dst() before
> > input_action_end_dx4_finish() resumes.
> > 
> > A separate root-only reproducer exercises seg6_output_core(): an SRv6
> > encap route, POST_ROUTING SNAT, and an ESP transport policy replace the
> > route destination before the continuation resumes.
> > 
> > On a clean KASAN kernel, the End.DX4 reproducer triggered a NULL pointer
> > dereference in input_action_end_dx4_finish from packet_sendmsg(). On the
> > patched kernel, the End.DX4 reproducer completed with exit status 0. The
> > SNAT+ESP/XFRM reproducer ran twice; one run returned exit status 0. No
> > target KASAN report, Oops, or kernel panic was found on the patched
> > guest. Tests used QEMU TCG because KVM was unavailable to the test user.
> > 
> > Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Closes: https://bugtracker.nebusec.ai/f/11977
> 
> Nit: The link is not accessible to non-maintainers. I'm not sure if
> this fits here.
> 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
> > Assisted-by: LLM
> > Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> > Signed-off-by: Ren Wei <weir@nebusec.ai>
> > 
> > ---
> > Changes in v2:
> > - Add unlikely() to the new checks.
> > - Validate the current dst/lwtstate type in both seg6local and
> >   seg6_iptunnel continuations; drop invalid state.
> > - Do not walk through XFRM dsts or take an extra lwtstate reference.
> > - Retain the seg6_input_core() loop-detection comment.
> > - Document both reproducer setups and clean/patched KASAN results.
> > - v1 Link: https://lore.kernel.org/all/cover.1790748418.git.petalzu987@gmail.com/
> > 
> >  net/ipv6/seg6_iptunnel.c | 35 ++++++++++++++++++++++++++++++-----
> >  net/ipv6/seg6_local.c    | 38 ++++++++++++++++++++++++++++++++------
> >  2 files changed, 62 insertions(+), 11 deletions(-)
> > 
> > diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> > index 7cbe0685f8bb..75ceeb127337 100644
> > --- a/net/ipv6/seg6_iptunnel.c
> > +++ b/net/ipv6/seg6_iptunnel.c
> > @@ -18,6 +18,7 @@
> >  #include <net/ip6_fib.h>
> >  #include <net/route.h>
> >  #include <net/seg6.h>
> > +#include <net/dst_metadata.h>
> >  #include <linux/seg6.h>
> >  #include <linux/seg6_iptunnel.h>
> >  #include <net/addrconf.h>
> > @@ -60,6 +61,21 @@ static inline struct seg6_lwt *seg6_lwt_lwtunnel(struct lwtunnel_state *lwt)
> >  	return (struct seg6_lwt *)lwt->data;
> >  }
> >  
> > +static struct lwtunnel_state *seg6_lwt_state_from_skb(struct sk_buff *skb)
> > +{
> > +	struct dst_entry *dst;
> > +
> > +	if (unlikely(!skb_valid_dst(skb)))
> > +		return NULL;
> > +
> > +	dst = skb_dst(skb);
> > +	if (unlikely(!dst->lwtstate ||
> > +		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6))
> > +		return NULL;
> > +
> > +	return dst->lwtstate;
> > +}
> > +
> >  static inline struct seg6_iptunnel_encap *
> >  seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
> >  {
> > @@ -557,7 +573,6 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
> >  static int seg6_input_core(struct net *net, struct sock *sk,
> >  			   struct sk_buff *skb)
> >  {
> > -	struct dst_entry *orig_dst = skb_dst(skb);
> >  	struct dst_entry *dst = NULL;
> >  	struct lwtunnel_state *lwtst;
> >  	struct seg6_lwt *slwt;
> > @@ -568,7 +583,11 @@ static int seg6_input_core(struct net *net, struct sock *sk,
> >  	 * need the address of its lwtstate. So, save the address of lwtstate
> >  	 * now and use it later as a comparison.
> >  	 */
> > -	lwtst = orig_dst->lwtstate;
> > +	lwtst = seg6_lwt_state_from_skb(skb);
> > +	if (unlikely(!lwtst)) {
> > +		err = -EINVAL;
> > +		goto drop;
> > +	}
> >  
> >  	slwt = seg6_lwt_lwtunnel(lwtst);
> >  
> > @@ -667,12 +686,18 @@ static struct dst_entry *seg6_output_dst_lookup(struct net *net,
> >  static int seg6_output_core(struct net *net, struct sock *sk,
> >  			    struct sk_buff *skb)
> >  {
> > -	struct dst_entry *orig_dst = skb_dst(skb);
> >  	struct dst_entry *dst = NULL;
> > +	struct lwtunnel_state *lwtst;
> >  	struct seg6_lwt *slwt;
> >  	int err;
> >  
> > -	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
> > +	lwtst = seg6_lwt_state_from_skb(skb);
> > +	if (unlikely(!lwtst)) {
> > +		err = -EINVAL;
> > +		goto drop;
> > +	}
> > +
> > +	slwt = seg6_lwt_lwtunnel(lwtst);
> >  
> >  	local_bh_disable();
> >  	dst = dst_cache_get(&slwt->cache_output);
> > @@ -695,7 +720,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
> >  		}
> >  
> >  		/* cache only if we don't create a dst reference loop */
> > -		if (orig_dst->lwtstate != dst->lwtstate) {
> > +		if (lwtst != dst->lwtstate) {
> >  			local_bh_disable();
> >  			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
> >  			local_bh_enable();
> > diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> > index 53f7b2452575..79c27e467c2b 100644
> > --- a/net/ipv6/seg6_local.c
> > +++ b/net/ipv6/seg6_local.c
> > @@ -24,6 +24,7 @@
> >  #include <net/addrconf.h>
> >  #include <net/ip6_route.h>
> >  #include <net/dst_cache.h>
> > +#include <net/dst_metadata.h>
> >  #include <net/ip_tunnels.h>
> >  #ifdef CONFIG_IPV6_SEG6_HMAC
> >  #include <net/seg6_hmac.h>
> > @@ -213,6 +214,21 @@ static struct seg6_local_lwt *seg6_local_lwtunnel(struct lwtunnel_state *lwt)
> >  	return (struct seg6_local_lwt *)lwt->data;
> >  }
> >  
> > +static struct seg6_local_lwt *seg6_local_lwt_from_skb(struct sk_buff *skb)
> > +{
> > +	struct dst_entry *dst;
> > +
> > +	if (unlikely(!skb_valid_dst(skb)))
> > +		return NULL;
> > +
> > +	dst = skb_dst(skb);
> > +	if (unlikely(!dst->lwtstate ||
> > +		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6_LOCAL))
> > +		return NULL;
> > +
> > +	return seg6_local_lwtunnel(dst->lwtstate);
> > +}
> > +
> >  static struct ipv6_sr_hdr *get_and_validate_srh(struct sk_buff *skb)
> >  {
> >  	struct ipv6_sr_hdr *srh;
> > @@ -1008,11 +1024,14 @@ static int input_action_end_dx2(struct sk_buff *skb,
> >  static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
> >  				       struct sk_buff *skb)
> >  {
> > -	struct dst_entry *orig_dst = skb_dst(skb);
> >  	struct in6_addr *nhaddr = NULL;
> >  	struct seg6_local_lwt *slwt;
> >  
> > -	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> > +	slwt = seg6_local_lwt_from_skb(skb);
> > +	if (unlikely(!slwt)) {
> > +		kfree_skb(skb);
> > +		return -EINVAL;
> > +	}
> >  
> >  	/* The inner packet is not associated to any local interface,
> >  	 * so we do not call netif_rx().
> > @@ -1059,13 +1078,16 @@ static int input_action_end_dx6(struct sk_buff *skb,
> >  static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
> >  				       struct sk_buff *skb)
> >  {
> > -	struct dst_entry *orig_dst = skb_dst(skb);
> >  	enum skb_drop_reason reason;
> >  	struct seg6_local_lwt *slwt;
> >  	struct iphdr *iph;
> >  	__be32 nhaddr;
> >  
> > -	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> > +	slwt = seg6_local_lwt_from_skb(skb);
> > +	if (unlikely(!slwt)) {
> > +		kfree_skb(skb);
> > +		return -EINVAL;
> > +	}
> >  
> >  	iph = ip_hdr(skb);
> >  
> > @@ -1722,13 +1744,17 @@ static void seg6_local_update_counters(struct seg6_local_lwt *slwt,
> >  static int seg6_local_input_core(struct net *net, struct sock *sk,
> >  				 struct sk_buff *skb)
> >  {
> > -	struct dst_entry *orig_dst = skb_dst(skb);
> >  	struct seg6_action_desc *desc;
> >  	struct seg6_local_lwt *slwt;
> >  	unsigned int len = skb->len;
> >  	int rc;
> >  
> > -	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> > +	slwt = seg6_local_lwt_from_skb(skb);
> > +	if (unlikely(!slwt)) {
> > +		kfree_skb(skb);
> > +		return -EINVAL;
> > +	}
> > +
> >  	desc = slwt->desc;
> >  
> >  	rc = desc->input(skb, slwt);
> > -- 
> > 2.34.1
> > 
> 
> The patch looks good to me.
> 
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

This approach looks sensible to me.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Otherwise, let me know if you want to handle this through net.git or nf.git.

Thanks.
