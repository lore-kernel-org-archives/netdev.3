Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463244;
	b=k2t6AOAxwddfx50V2mv8/9t0agkq2Ll8HfdtiOTZLVw8oQjATI4wFLADt3EiFyxB9jre
	 8DsuWHEryfZjRM36d+S0SQRJEE5DWUwqEZpm/PMSXG6w8b5mZlW/LKQ2r+tsXaM62H0xd
	 9MLEzZmn7rwN2ZkKoWuWn9lAWmtn17HnfMjVvJ5xcOZ6jUyMwtgY18lbKyV1lEyaQASno
	 Dt/U5H2E34qMfZN/OT/k6BM2mH9FfSVyyXEh9O6CbdnMdXue/K9Ej7Y/p+Ndo0K6ABPUH
	 CuariDuCYvZK6RN2aGWZGVmru/0nvZ6qhOrnGxDYg6AE9yk/5tUiJS+0IbgqSgFUCFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463244;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4dpF3PjqXhgSVJ1gs4ldu0scOe6sTlAmI5ssZqcED1A=;
	b=wuUgDzhO3oc+W9TUBdaE7HuJGaMbVvsEErGcBZdGdrvFfp4ArMGpuAgY6S5+C/GN1aAl
	 lt3VkxpXhlVZYszjPT6ahoIGhteQbCRO8IdIWXOjumkYXmzdG4uJ3UKs9+ebaII7qPEdV
	 jdOn4mbmFBpQP7SQlHkYe7dT1Z8g+UtbhOU3ZYzKXvQK1QtOarCJvfPBvJAIxUSBuL+D5
	 PEAf25odp/XAVPOCdxbha0wTUKKfQJL0/QIyGhHrwBZFMtP5cdQYJsk1K7fp4JGuwA/W2
	 x16PX3glWm1Tfb4qKnHfzxPGevM6Lfo7X25xt8kCzFWaD98ZF7Ako4EtYju1OWc0cXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DXyZbBq1;
	arc=none smtp.remote-ip=91.218.175.191
Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A13606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9A13606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DXyZbBq1
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ruhOIGzk5JT5yGbHrtNFr71ekWRk/c340FuzwAxWGdY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792463241; v=1; x=1793068041;
 b=DXyZbBq1Up33KytlyQroVDiZDg3DWx1mk4Qtk7XZr38KK1RDbw477/dkNr0luealpXCCtv/T
 EOI1lidKVtg98tmuYE6DDdUbUKNmSNMGfVkM68Pw0F5jKJF2bBGumU8bqdyDBLHCVNjneSmCfNd
 9yuBU5nx3GNDU32i0Mzryfeg=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7172e4ae6d6e83ce;
	Tue, 20 Oct 2026 02:27:21 +0000
X-Mizu-Trace-ID: 7172e4ae6d6e83ce
X-Migadu-Flow: FLOW_OUT
Date: Tue, 20 Oct 2026 10:27:03 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, andrea.mayer@uniroma2.it, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, contact@proelbtn.com, pablo@netfilter.org,
	vega@nebusec.ai, sashiko-bot@kernel.org, petalzu987@gmail.com
Subject: Re: [PATCH net v2 1/1] seg6: validate state in netfilter
 continuations
Message-ID: <atbRd1km4IlW4wwY@fedora>
References: <cover.1792230570.git.petalzu987@gmail.com>
 <ec7399b424e82f050a1ff5dc79537aee1d93723a.1792230570.git.petalzu987@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec7399b424e82f050a1ff5dc79537aee1d93723a.1792230570.git.petalzu987@gmail.com>

On Sun, Oct 18, 2026 at 02:27:29PM +0800, Ren Wei wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> Netfilter hooks can drop or replace skb_dst() while an SRv6 packet is
> queued for continuation. The End.DX4 and End.DX6 finish callbacks and
> the seg6local input continuation currently dereference the destination's
> lwtstate without validating it. The seg6_iptunnel input and output
> continuations make the same assumption after POST_ROUTING hooks.
> 
> Validate skb_valid_dst(), a non-NULL lwtstate, and the expected
> LWTUNNEL_ENCAP_SEG6_LOCAL or LWTUNNEL_ENCAP_SEG6 type before using the
> state. Drop the skb when validation fails. This check is by type, not by
> identity of the original state. It does not walk through an XFRM dst or
> take an additional lwtstate reference. Retain the loop-detection
> explanation for saving the lwtstate address in seg6_input_core().
> 
> The End.DX4 reproducer creates a SEG6_LOCAL End.DX4 SID, enables
> nf_hooks_lwtunnel, installs an IPv4 PREROUTING DNAT rule, and injects an
> outer IPv6/inner IPv4 frame through AF_PACKET from a non-root user in a
> fresh user/network namespace. DNAT drops skb_dst() before
> input_action_end_dx4_finish() resumes.
> 
> A separate root-only reproducer exercises seg6_output_core(): an SRv6
> encap route, POST_ROUTING SNAT, and an ESP transport policy replace the
> route destination before the continuation resumes.
> 
> On a clean KASAN kernel, the End.DX4 reproducer triggered a NULL pointer
> dereference in input_action_end_dx4_finish from packet_sendmsg(). On the
> patched kernel, the End.DX4 reproducer completed with exit status 0. The
> SNAT+ESP/XFRM reproducer ran twice; one run returned exit status 0. No
> target KASAN report, Oops, or kernel panic was found on the patched
> guest. Tests used QEMU TCG because KVM was unavailable to the test user.
> 
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Closes: https://bugtracker.nebusec.ai/f/11977

Nit: The link is not accessible to non-maintainers. I'm not sure if
this fits here.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> 
> ---
> Changes in v2:
> - Add unlikely() to the new checks.
> - Validate the current dst/lwtstate type in both seg6local and
>   seg6_iptunnel continuations; drop invalid state.
> - Do not walk through XFRM dsts or take an extra lwtstate reference.
> - Retain the seg6_input_core() loop-detection comment.
> - Document both reproducer setups and clean/patched KASAN results.
> - v1 Link: https://lore.kernel.org/all/cover.1790748418.git.petalzu987@gmail.com/
> 
>  net/ipv6/seg6_iptunnel.c | 35 ++++++++++++++++++++++++++++++-----
>  net/ipv6/seg6_local.c    | 38 ++++++++++++++++++++++++++++++++------
>  2 files changed, 62 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 7cbe0685f8bb..75ceeb127337 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -18,6 +18,7 @@
>  #include <net/ip6_fib.h>
>  #include <net/route.h>
>  #include <net/seg6.h>
> +#include <net/dst_metadata.h>
>  #include <linux/seg6.h>
>  #include <linux/seg6_iptunnel.h>
>  #include <net/addrconf.h>
> @@ -60,6 +61,21 @@ static inline struct seg6_lwt *seg6_lwt_lwtunnel(struct lwtunnel_state *lwt)
>  	return (struct seg6_lwt *)lwt->data;
>  }
>  
> +static struct lwtunnel_state *seg6_lwt_state_from_skb(struct sk_buff *skb)
> +{
> +	struct dst_entry *dst;
> +
> +	if (unlikely(!skb_valid_dst(skb)))
> +		return NULL;
> +
> +	dst = skb_dst(skb);
> +	if (unlikely(!dst->lwtstate ||
> +		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6))
> +		return NULL;
> +
> +	return dst->lwtstate;
> +}
> +
>  static inline struct seg6_iptunnel_encap *
>  seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
>  {
> @@ -557,7 +573,6 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
>  static int seg6_input_core(struct net *net, struct sock *sk,
>  			   struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	struct dst_entry *dst = NULL;
>  	struct lwtunnel_state *lwtst;
>  	struct seg6_lwt *slwt;
> @@ -568,7 +583,11 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>  	 * need the address of its lwtstate. So, save the address of lwtstate
>  	 * now and use it later as a comparison.
>  	 */
> -	lwtst = orig_dst->lwtstate;
> +	lwtst = seg6_lwt_state_from_skb(skb);
> +	if (unlikely(!lwtst)) {
> +		err = -EINVAL;
> +		goto drop;
> +	}
>  
>  	slwt = seg6_lwt_lwtunnel(lwtst);
>  
> @@ -667,12 +686,18 @@ static struct dst_entry *seg6_output_dst_lookup(struct net *net,
>  static int seg6_output_core(struct net *net, struct sock *sk,
>  			    struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	struct dst_entry *dst = NULL;
> +	struct lwtunnel_state *lwtst;
>  	struct seg6_lwt *slwt;
>  	int err;
>  
> -	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
> +	lwtst = seg6_lwt_state_from_skb(skb);
> +	if (unlikely(!lwtst)) {
> +		err = -EINVAL;
> +		goto drop;
> +	}
> +
> +	slwt = seg6_lwt_lwtunnel(lwtst);
>  
>  	local_bh_disable();
>  	dst = dst_cache_get(&slwt->cache_output);
> @@ -695,7 +720,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
>  		}
>  
>  		/* cache only if we don't create a dst reference loop */
> -		if (orig_dst->lwtstate != dst->lwtstate) {
> +		if (lwtst != dst->lwtstate) {
>  			local_bh_disable();
>  			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
>  			local_bh_enable();
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 53f7b2452575..79c27e467c2b 100644
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
> @@ -213,6 +214,21 @@ static struct seg6_local_lwt *seg6_local_lwtunnel(struct lwtunnel_state *lwt)
>  	return (struct seg6_local_lwt *)lwt->data;
>  }
>  
> +static struct seg6_local_lwt *seg6_local_lwt_from_skb(struct sk_buff *skb)
> +{
> +	struct dst_entry *dst;
> +
> +	if (unlikely(!skb_valid_dst(skb)))
> +		return NULL;
> +
> +	dst = skb_dst(skb);
> +	if (unlikely(!dst->lwtstate ||
> +		     dst->lwtstate->type != LWTUNNEL_ENCAP_SEG6_LOCAL))
> +		return NULL;
> +
> +	return seg6_local_lwtunnel(dst->lwtstate);
> +}
> +
>  static struct ipv6_sr_hdr *get_and_validate_srh(struct sk_buff *skb)
>  {
>  	struct ipv6_sr_hdr *srh;
> @@ -1008,11 +1024,14 @@ static int input_action_end_dx2(struct sk_buff *skb,
>  static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
>  				       struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	struct in6_addr *nhaddr = NULL;
>  	struct seg6_local_lwt *slwt;
>  
> -	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> +	slwt = seg6_local_lwt_from_skb(skb);
> +	if (unlikely(!slwt)) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
>  
>  	/* The inner packet is not associated to any local interface,
>  	 * so we do not call netif_rx().
> @@ -1059,13 +1078,16 @@ static int input_action_end_dx6(struct sk_buff *skb,
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
> +	if (unlikely(!slwt)) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
>  
>  	iph = ip_hdr(skb);
>  
> @@ -1722,13 +1744,17 @@ static void seg6_local_update_counters(struct seg6_local_lwt *slwt,
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
> +	if (unlikely(!slwt)) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
> +
>  	desc = slwt->desc;
>  
>  	rc = desc->input(skb, slwt);
> -- 
> 2.34.1
> 

The patch looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
