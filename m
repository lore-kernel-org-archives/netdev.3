Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901448551E
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939804; cv=none; b=nJpjy+BJQq45FhD79sN2bBdLCCAdsKgzyrX/eKgtgVWT6NdkkmD2CTAIl6zOHFmJkVTPsk+dxHxrAzAomgIxfbrzyST/kdSPzUAPyj3R3fhIfNri0kSbHqkLmFIYdjYb7ewdLlhnewXbRmhVo3+lUpOcOLywmq6Bs5Q0bVoSeKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939804; c=relaxed/simple;
	bh=fKBXgJ84Wfgr1Vc/MjywO6FH3BjD2YUyj+imU22BUUc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppV3WA1LFK7oB7t/WutcpTzcpJYwg26nuTvNptcurQXJJi87nDt5aAt8xRsGpmU3Y22G4Pbc+tPrOyd9GsZsP3PeGg3tKwrzswEq8dHmui6xFW8X+EmT9v773OCLu/zB00MieSyvyDgE9wSZgxcSYq9VPJ50g1FjUschAAHDSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRvFjstl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRvFjstl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C2C1F000FF;
	Fri,  2 Oct 2026 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939802;
	bh=7t66XtqJjNzl4/UqzlSDgJmFr02nZ458oYRE94WIK3U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nRvFjstljW8Fwlwt5htf+o98IPTH0OlcMs47GeV9hsgQXHZp8slL2WkXNEsU187Rx
	 mzfDGhUU3u6WJRVtNAQY7J3q5sYynSm2nbkHe0rGDehxzKDNBRyrbzVMv7DGSG3TYE
	 1nwiyvWkxs+oajEusb/WMIP1gwzsXyZxLJ6CGfIDzfBF4h55TJHQW5hjlzFEjOoZ/T
	 +nA4kuGcSyTKGhQmFU/Rvl+Du2wzxwx21y9b42tP6IO7jMiCXSDMTAf+cvr1aj7VBe
	 cI9jr33MbG91MwExLNi9DWjMbhMQI3/6Odo7kyeQ5m1Di7Ne4ArvAc/KSQFgbcPKxj
	 gZfDX14oRiRGQ==
Subject:
 Re: [PATCH net-next v4 3/5] net: gso: support re-segmentation of TCP GSO skbs
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org, daniel@iogearbox.net, ncardwell@google.com,
 kuniyu@google.com, alice@isovalent.com, david.laight.linux@gmail.com
Date: Fri, 02 Oct 2026 11:16:41 +0000
Message-ID: <179093980103.434549.13718251538882727671@kernel.org>
In-Reply-To: <20260930111526.2183107-4-wang.zhan@smartx.com>
References: <20260930111526.2183107-4-wang.zhan@smartx.com>
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

- [Low] Possible truncation of the 16-bit IP length for grouped outputs
  larger than 64 KiB (fixed by the next patch in the series).

--

net: gso: support re-segmentation of TCP GSO skbs

This commit adds a max_segs argument to __skb_gso_segment() and stores it
in the skb_gso_cb scratch area. When max_segs is non-zero, skb_segment()
skips the partial/frag_list decision block and groups up to max_segs MSS
segments into each output GSO skb. Existing callers pass zero to keep
their current behaviour.

> diff --git a/net/core/gso.c b/net/core/gso.c
> index bcd156372f4df..21a259ca392f4 100644
> --- a/net/core/gso.c
> +++ b/net/core/gso.c

[ ... ]

> @@ -117,6 +120,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>
>  	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
>  	SKB_GSO_CB(skb)->encap_level = 0;
> +	SKB_GSO_CB(skb)->max_segs = min(max_segs, GSO_MAX_SEGS);
>
>  	skb_reset_mac_header(skb);
>  	skb_reset_mac_len(skb);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 8912a66cd9097..fd10a7cdc1883 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

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

[Severity: Low]
When max_segs is non-zero, the grouped outputs are not SKB_GSO_PARTIAL
skbs. Their size is bounded only by max_segs * gso_size. The only clamp in
__skb_gso_segment() is on the segment count (GSO_MAX_SEGS), and nothing
limits the number of bytes.

For non-partial GSO outputs, the L3 length is taken from the whole output
skb and stored in a 16-bit field:

net/ipv4/af_inet.c:inet_gso_segment() {
    ...
			else
				tot_len = skb->len - nhoff;
    ...
		iph->tot_len = htons(tot_len);
		ip_send_check(iph);
    ...
}

net/ipv6/ip6_offload.c:ipv6_gso_segment() {
    ...
		else
			payload_len = skb->len - nhoff - sizeof(*ipv6h);
		ipv6h->payload_len = htons(payload_len);
    ...
}

If a caller passed a max_segs where max_segs * gso_size plus headers is
more than 65535, would tot_len and payload_len be truncated, and would the
IPv4 header checksum then be computed over the wrong length?

No caller in this patch passes a non-zero value. The only non-zero caller
in the series is skb_gso_output_max_segs(), added by the next patch ("net:
core: re-segment oversized TCP GSO skbs"). It caps gso_max_size at
GSO_LEGACY_MAX_SIZE before it computes max_segs, so this cannot be hit
anywhere in the series. What is left is the API contract of
__skb_gso_segment().

Should the kernel-doc for max_segs say that the caller must keep
max_segs * gso_size plus headers within 64KB? Alternatively, could
__skb_gso_segment() or skb_segment() enforce a byte limit, so a future
caller cannot produce outputs with a truncated IP length?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930111526.2183107-1-wang.zhan%40smartx.com
