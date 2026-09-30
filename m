Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB93A3821
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743301; cv=none; b=pmZ1w17VdIvMD3qtS3dADLYLybCeZlVj8Surp96pUOazjXfeA7BMyeo4isIYcX2E06JoPZ9X2XKPinNAgElVYvmquok612xycXx46ukYIHsdbEjOYXe12TDPCedym9Q3bq4GdZlFHsFqG7FPAC8giujqN7m71rsDoQo5n8aYDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743301; c=relaxed/simple;
	bh=Duk7grCHCMIFG1pLv+AY2YIYuMhSA0JA5v8RZ7idL8M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uET0ssR71tPJJTINz7HMgh9Qedd2sBhkH1o4hV9+8OMQR7TOhdUAlWNtjPZkNDP4lSP6gBfedFNyKpyYSd2dRC+iDpQYqy1ZEIGK7Dy3HGIlPS1N38h7iQkCGDyhe+qzTDycKV5YlX7y0mIHbSN1gBV0yA8Kid4r/vnH6JBurEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azr9H2Ic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azr9H2Ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F091F000FF;
	Wed, 30 Sep 2026 04:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743299;
	bh=wx++1GGBVPHGpmHuxDY1kycAGPoEWmBAfjZaJOnRLaA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=azr9H2IcBud5nISo/Ceeze3rYdFqX5Eiu6Vq/AMyS63EkwTrK/l7VhuPJ0UamT+DS
	 tyEVuNUfUUiInPNNPpGwdtsv/2/BWMkQc7Ce0TU8J1dgtL9znL/LoeCayQX4QBKk5+
	 fLZBBpVHzowwVmW5x8XOAzTTtN42Jy5NZTZEuvqJOvotWH/mV2yZ7l+VxRw1eHkq68
	 amHo+B3LvGWn9sLjGfn7BQR39Bl27kBKj6i7l8IZs7HpC1lJKQ7cvoNs3MylKOxok+
	 KdUpvjpiXcvhpk2NTdpum74g7QxLw4LDyhg5bSkexWMAG0TZCvZkuRYoVHEdJa0QkZ
	 Ftn2hYvqxfYdg==
Subject:
 Re: [PATCH net-next v3 3/5] net: gso: support bounded TCP segmentation
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org, daniel@iogearbox.net, ncardwell@google.com,
 kuniyu@google.com, alice@isovalent.com, david.laight.linux@gmail.com
Date: Wed, 30 Sep 2026 04:41:37 +0000
Message-ID: <179074329764.434549.1178255528306927844@kernel.org>
In-Reply-To: <20260928044102.1004310-4-wang.zhan@smartx.com>
References: <20260928044102.1004310-4-wang.zhan@smartx.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The public @max_segs kernel-doc for __skb_gso_segment()
  (net/core/gso.c) says only "must only be set for TCP GSO skbs".
- [Low] Rejected as a false positive.
- [Low] The comment in tcp_gso_segment() (net/ipv4/tcp_offload.c) that
  explains `mss *= skb_shinfo(segs)->gso_segs` still names only two ways…

--

net: gso: support bounded TCP segmentation

This patch adds a max_segs argument to __skb_gso_segment() and stores it
in struct skb_gso_cb, so that skb_segment() can put a bounded number of
MSS segments into each output GSO skb. When max_segs is set, skb_segment()
skips the GSO_PARTIAL/frag_list decision block and caps partial_segs with
the bound. Existing callers pass 0 for no limit.

> diff --git a/net/core/gso.c b/net/core/gso.c
> index bcd156372f4df..42fbce17b508c 100644
> --- a/net/core/gso.c
> +++ b/net/core/gso.c
> @@ -77,6 +77,8 @@ static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
>   *	@skb: buffer to segment
>   *	@features: features for the output path (see dev->features)
>   *	@tx_path: whether it is called in TX path
> + *	@max_segs: maximum MSS segments per output GSO skb, 0 means no limit;
> + *		   must only be set for TCP GSO skbs
>   *
>   *	This function segments the given skb and returns a list of segments.
>   *

[ ... ]

> @@ -117,6 +120,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>  
>  	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
>  	SKB_GSO_CB(skb)->encap_level = 0;
> +	SKB_GSO_CB(skb)->max_segs = min(max_segs, GSO_MAX_SEGS);

[Severity: Low]
Should the kernel-doc for @max_segs also say that a bound must not be
passed for an skb with a frag_list?

Right now that rule is stated only in the new comment inside
skb_segment():

    /*
     * A call with max_segs set groups the MSS segments below,
     * and the frag_list split in this block does not carry the
     * bound, so a bound must not be passed for a skb with a
     * frag_list.
     */
    if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {

Neither the TCP rule nor the frag_list rule is enforced, here or in
skb_segment(). The bound is stored without a skb_has_frag_list() or
gso_type check. A non-zero max_segs also skips the frag_list uniformity
and head_frag checks.

A future caller could follow the kernel-doc and bound a TCP GSO skb that
carries a frag_list, which is common after GRO. Could that caller then hit
the BUG_ON()s in the frag_list walk of skb_segment()?

This can't happen in the series as posted. The only caller that passes a
non-zero bound is skb_gso_output_max_segs(), added in "net: core:
resegment oversized TCP GSO skbs". It returns 0 for skb_has_frag_list(),
non-TCP and encapsulated skbs. Every other caller passes 0.

Would it be worth adding the frag_list rule to the kernel-doc? Another
option is a check like DEBUG_NET_WARN_ON_ONCE(max_segs && list_skb) in
skb_segment() that falls back to the normal path.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 8912a66cd9097..b16a6843f3192 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -4874,7 +4881,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		 * now.
>  		 */
>  		DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS);
> -		partial_segs = min(len / mss, GSO_MAX_SEGS);
> +		if (max_segs)
> +			partial_segs = min(len / mss, max_segs);
> +		else
> +			partial_segs = min(len / mss, GSO_MAX_SEGS);

[Severity: Low]
This isn't a bug, but the comment in tcp_gso_segment() in
net/ipv4/tcp_offload.c still lists only two ways that skb_segment()
returns GSO skbs:

    /* GSO partial and frag_list segmentation only requires splitting
     * the frame into an MSS multiple and possibly a remainder, both
     * cases return a GSO skb. So update the mss now.
     */
    if (skb_is_gso(segs))
        mss *= skb_shinfo(segs)->gso_segs;

The bounded grouping added here is a third case, with neither
NETIF_F_GSO_PARTIAL nor a frag_list. The code still works because it
tests skb_is_gso(segs). However, the comment isn't updated in this patch
or later in the series.

Could the comment be updated to include the max_segs case?

>  		if (partial_segs > 1)
>  			mss *= partial_segs;
>  		else

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928044102.1004310-1-wang.zhan%40smartx.com
