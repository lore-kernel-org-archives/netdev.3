Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FD4ACC62
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023809; cv=none; b=VErc5ctcZSn3HVta1RmhoBOLumN2ZBnmsNeZR4C0B3aAEtUberVQc2i6sBdhCgQ49UZgcJ8gD3Nc2HqPM26NvlQ3+WdLyv3pHSWNILuAM11e+hmIhXisUxA8Jy55c43gR/lOepsjiZwS9YWO9aCLjZ2yNnmePOfADnZo3HCVi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023809; c=relaxed/simple;
	bh=sEpMRwtMz2cYwLEIqUUIGuPt+V1jsq30W6J5iVsU6C8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBta6EZuvjibGT0jAiUyz/suRjcmZ1yE1DSGiBg3lTtteTSs7SpU+kTKu2EZLqn+bJovNXLIoyKDRGA9tPmFthIdz6eytgPlopw0/rZXP3wZUP9Ntqf7skkWQBt8R1iRQWbreDciD961aosj1lk6/9q+9rt1rirpXKEZtjrNUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+vqw1DW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+vqw1DW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6B51F000FF;
	Mon, 21 Sep 2026 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023804;
	bh=XFcLji0DWuUN4Fj3cm0CA0/DE324nW10lDE459NMhBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H+vqw1DW00AQGDBAQlrqsFGY1WFwZujN2TIHRzMc4qZgMUZ8dosROgiLFqfwEiDkT
	 Ha7h7ZO3/Er7W6YpMLgVceZ5WmfU5+SOp8hDnbqGN9JUnRTed/3IvO8P0IYsyrB9ya
	 /h70ViK80fUk7WfdLNOWBCZjlmvvYM+qtNbnHQsUAiE9gYoz0ITmGa2O2N8p1+p3OW
	 vTnbqaMhIA/lhpVYOfBmCI8SGxj/jCB1XXrr0w9DPc7FJBHaZZG44VwV7WioBVdcUK
	 ULj1JKyFB603oKiDF8yUfdpsbxvYXpZBAsGmG/vp08ojHzZq2g9khHMzJMf9ZNBNSx
	 qNQNrqbLtZD5g==
Subject:
 Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP segmentation
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 dev@openvswitch.org, andrew+netdev@lunn.ch, jasowangio@gmail.com,
 willemdebruijn.kernel@gmail.com, ncardwell@google.com, kuniyu@google.com,
 alice@isovalent.com
Date: Mon, 21 Sep 2026 20:50:03 +0000
Message-ID: <179002380317.2160803.2629890126162105944@kernel.org>
In-Reply-To: <20260918084651.3022878-3-wang.zhan@smartx.com>
References: <20260918084651.3022878-3-wang.zhan@smartx.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] skb_segment(): a non-zero SKB_GSO_CB(head_skb)->max_segs
  disables the *entire* frag_list eligibility block at…
- [Medium] __skb_gso_segment() now advertises a protocol-agnostic per-
  call bound ("@max_segs: maximum MSS segments per output GSO skb, 0…

--

net: gso: support bounded TCP segmentation

This adds a max_segs bound to __skb_gso_segment(), carried in the
skb_gso_cb scratch area, so callers can ask the GSO engine to group
several MSS segments into each output GSO skb. All existing callers pass
zero, and skb_segment() uses the bound instead of GSO_MAX_SEGS when
computing partial_segs.

> diff --git a/include/net/gso.h b/include/net/gso.h
> index 29975440cad5..fccb37889965 100644
> --- a/include/net/gso.h
> +++ b/include/net/gso.h
> @@ -19,6 +19,7 @@ struct skb_gso_cb {
>  	int	encap_level;
>  	__wsum	csum;
>  	__u16	csum_start;
> +	__u16	max_segs;	/* Max MSS segs per output skb, 0 = no limit */
>  };
>  #define SKB_GSO_CB_OFFSET	32
>  #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))

[ ... ]

> diff --git a/net/core/gso.c b/net/core/gso.c
> index bcd156372f4d..157f2bfdca12 100644
> --- a/net/core/gso.c
> +++ b/net/core/gso.c
> @@ -77,6 +77,7 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
>   *	@skb: buffer to segment
>   *	@features: features for the output path (see dev->features)
>   *	@tx_path: whether it is called in TX path
> + *	@max_segs: maximum MSS segments per output GSO skb, 0 means no limit

[Severity: Medium]
This kernel-doc describes max_segs as a protocol-agnostic bound on an
exported entry point, but only tcp_gso_segment() was taught to look at it.

The other gso_segment implementers reached through the very same
__skb_gso_segment() path still take their unconditional "nothing to do"
fast path. In __udp_gso_segment():

	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
		/* Packet is from an untrusted source, reset gso_segs. */
		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh), mss);
		return NULL;
	}

and in sctp_gso_segment():

	if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
		/* Packet is from an untrusted source, reset gso_segs. */
		...
		segs = NULL;
		goto out;
	}

Neither consults SKB_GSO_CB(skb)->max_segs, which is exactly the check
tcp_gso_segment() gained in this patch.

If a caller passes a non-zero max_segs for a UDP or SCTP GSO skb, doesn't
the bound get silently dropped and the original oversized skb returned as
"no segmentation needed"?  The caller cannot tell that apart from the
device being able to take the skb as-is: tap_handle_frame() queues the
original skb on a NULL return, and queue_gso_packets() turns NULL into
-EINVAL.

No current caller passes a non-zero bound, so this is latent today. Should
the kernel-doc say the bound is honoured for TCP only, or should the other
implementers check it too?

>   *
>   *	This function segments the given skb and returns a list of segments.
>   *
> @@ -86,7 +87,8 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
>   *	Segmentation preserves SKB_GSO_CB_OFFSET bytes of previous skb cb.
>   */
>  struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
> -				  netdev_features_t features, bool tx_path)
> +				  netdev_features_t features, bool tx_path,
> +				  unsigned int max_segs)
>  {
>  	struct sk_buff *segs;
>  
> @@ -117,6 +119,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>  
>  	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
>  	SKB_GSO_CB(skb)->encap_level = 0;
> +	SKB_GSO_CB(skb)->max_segs = min_t(unsigned int, max_segs, U16_MAX);

[Severity: Medium]
The changelog says:

	"the bounded path is only used for skbs which do not carry a
	frag_list"

Is that precondition enforced or documented anywhere?  __skb_gso_segment()
is EXPORT_SYMBOL and records the caller-supplied bound for any skb here,
and the new @max_segs kernel-doc above states no restriction.  See the
related question on the skb_segment() hunk below.

>  
>  	skb_reset_mac_header(skb);
>  	skb_reset_mac_len(skb);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index dbbe10277d51..9c0d140236bc 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4793,6 +4793,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	struct sk_buff *segs = NULL;
>  	struct sk_buff *tail = NULL;
>  	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
> +	unsigned int max_segs = SKB_GSO_CB(head_skb)->max_segs;
>  	unsigned int mss = skb_shinfo(head_skb)->gso_size;
>  	bool gso_by_frags = mss == GSO_BY_FRAGS;
>  	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
> @@ -4839,7 +4840,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	csum = !!can_checksum_protocol(features, proto);
>  
>  	if (sg && csum && !gso_by_frags)  {
> -		if (!(features & NETIF_F_GSO_PARTIAL)) {
> +		if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {

[Severity: Medium]
A non-zero max_segs skips the whole block here, not just the uniform-length
test the changelog mentions.  Also skipped are the net_gso_ok() bail-out,
the per-member head_frag guard and the length accounting:

net/core/skbuff.c:skb_segment() {
	...
		if (!list_skb ||
		    !net_gso_ok(features, skb_shinfo(head_skb)->gso_type))
			goto normal;
		...
		frag_len = list_skb->len;
		skb_walk_frags(head_skb, iter) {
			if (frag_len != iter->len && iter->next)
				goto normal;
			if (skb_headlen(iter) && !iter->head_frag)
				goto normal;

			len -= iter->len;
		}

		if (len != frag_len)
			goto normal;
	...
}

Since len is then still the full head_skb->len, mss *= partial_segs can
produce a grouped MSS that is not aligned with the frag_list member
boundaries, so one output skb spans several members.  Can that reach the
BUG_ON() in the frag walk further down?

net/core/skbuff.c:skb_segment() {
	...
			if (!skb_headlen(list_skb)) {
				BUG_ON(!nfrags);
			} else {
				BUG_ON(!list_skb->head_frag);
	...
}

A frag_list member with kmalloc'ed linear data (as TCP GRO produces via
skb_gro_receive()) is not a head_frag, and previously such an skb took
"goto normal" instead.

I checked the rest of the series: the only in-tree bounded caller,
skb_can_gso_resegment() in net/core/dev.c added by "net: core: resegment
oversized TCP GSO skbs", refuses these skbs with

	if (skb_has_frag_list(skb))
		return false;

and net_test.c never combines max_segs with frag_skbs, so nothing panics
today.  Would it be worth keeping the head_frag and uniformity validation
(or ignoring the bound) when skb_shinfo(head_skb)->frag_list is set, and
stating the precondition in the @max_segs kernel-doc?

Dropping the net_gso_ok() check the same way also means a bounded call can
emit still-GSO skbs whose gso_type the output features do not support.  Is
that intentional?

>  			struct sk_buff *iter;
>  			unsigned int frag_len;
>  
> @@ -4874,7 +4875,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		 * now.
>  		 */
>  		DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS);
> -		partial_segs = min(len / mss, GSO_MAX_SEGS);
> +		if (max_segs)
> +			partial_segs = min(len / mss, max_segs);
> +		else
> +			partial_segs = min(len / mss, GSO_MAX_SEGS);
>  		if (partial_segs > 1)
>  			mss *= partial_segs;
>  		else

[ ... ]

> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index e74d99ca9fac..a4076318c535 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -164,7 +164,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>  	if (unlikely(skb->len <= mss))
>  		goto out;
>  
> -	if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
> +	if (!SKB_GSO_CB(skb)->max_segs &&
> +	    skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
>  		/* Packet is from an untrusted source, reset gso_segs. */
>  
>  		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918084651.3022878-1-wang.zhan%40smartx.com
