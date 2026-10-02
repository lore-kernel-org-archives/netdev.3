Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018248BD20
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939805; cv=none; b=noKl7LcQIdW1G1jXRQtU8xE6r+Jo0W5gyJMCnwNDvwaeqW+IcnQSt2CWVKLvH/ZGlmncSnrCrjdS3P2SLGvqGiY3FWMF0EBM2warhHAOy2uzm8gWA/umI85Vjm5odWdgjmS9Uv51BmpZmnp2IGkzBtY9DKEOFBTtSOgkxRDa6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939805; c=relaxed/simple;
	bh=KnaAyBamd0Zs7/deB6yIjdYnRZxo5CNs0xLL+3w+J4Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2rI2+tk0u2aBigH3T76T+fY2MVQOIq3pcSKHAiAWCaEuoTC6Hk3GqZZxa9LrH+X30ul/1UHYwhi5KIs9PSezVqwmQJNslk5bOVXTXozygX0vgtOACskkAQ5/wXONt8/aahLGxh4UL2pH4wpvH/GrB4iB0Rjuy0IWe+QtSEA1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuxM/ex3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuxM/ex3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FD51F00893;
	Fri,  2 Oct 2026 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939804;
	bh=HefvilNrde2EG7gMkjM8LQNcoOdvArKxXlxHC6XrN2s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QuxM/ex37emze24Cx3atmgSjHeGKsGM8UjgPRnrLcQWE4JRSXHMFiqSoW15DGW94h
	 ASlut3yo7ggDAzMq8NT4rSwIErhjX/YzWAii3St3K79QD46l7krkiuCbzPREzMca2S
	 IdlXu10Iig83/g2dIcG2oviaLHSOHFV4H8p4quXs3ofowc4M49qw5gEbMuwZOAKKlx
	 eNseMOgFreLoJAgnjBMtjScsegOzzZ9xb72dxc0fsdd12V2I5I4Dmlvl9Svov+tdmu
	 vgDa9s3DFp//NBkPPsOkJCDXGbfaxjdL6axcI4n5n/99VWXOqp+v0afwqJLwSJesUY
	 xKA8FaKtYeqjw==
Subject:
 Re: [PATCH net-next v4 4/5] net: core: re-segment oversized TCP GSO skbs
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org, daniel@iogearbox.net, ncardwell@google.com,
 kuniyu@google.com, alice@isovalent.com, david.laight.linux@gmail.com
Date: Fri, 02 Oct 2026 11:16:42 +0000
Message-ID: <179093980262.434549.10825519147531654784@kernel.org>
In-Reply-To: <20260930111526.2183107-5-wang.zhan@smartx.com>
References: <20260930111526.2183107-5-wang.zhan@smartx.com>
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

- [Medium] The re-segmentation path in validate_xmit_skb() /
  skb_gso_output_max_segs() lets untrusted SKB_GSO_DODGY TCP skbs reach…

--

net: core: re-segment oversized TCP GSO skbs

With this patch, validate_xmit_skb() no longer segments an unencapsulated
TCP GSO skb into individual packets when it exceeds the egress device's
gso_max_size or gso_max_segs. It re-segments the skb into smaller GSO skbs
instead. A new helper, skb_gso_output_max_segs(), works out how many MSS
segments each output skb may carry and passes that to __skb_gso_segment()
as max_segs.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index a6213c9ed5e72..ff9bce2506f67 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3977,6 +3977,53 @@ __netif_skb_features(struct sk_buff *skb, bool check_gso_limits)
>  }
>  EXPORT_SYMBOL(__netif_skb_features);
>  
> +static unsigned int
> +skb_gso_output_max_segs(struct sk_buff *skb, struct net_device *dev)
> +{
> +	unsigned int mss = skb_shinfo(skb)->gso_size;
> +	unsigned int gso_max_size, hdr_len, max_segs;
> +	netdev_features_t features;
> +	struct tcphdr _tcph, *th;
> +
> +	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
> +	    skb->encapsulation || skb_has_frag_list(skb))
> +		return 0;

[ ... ]

> +	gso_max_size = netif_get_gso_max_size(dev, skb);
> +	gso_max_size = min(gso_max_size, GSO_LEGACY_MAX_SIZE);
> +
> +	/*
> +	 * gso_within_dev_limits() accepts gso_segs == gso_max_segs but
> +	 * rejects skb->len >= gso_max_size, so only the size limit needs the
> +	 * - 1; the inner min() keeps that subtraction from wrapping.
> +	 */
> +	max_segs = (gso_max_size - min(gso_max_size, hdr_len + 1)) / mss;
> +	max_segs = min(max_segs, READ_ONCE(dev->gso_max_segs));
> +
> +	return max_segs;
> +}

[Severity: Medium]
Can untrusted SKB_GSO_DODGY skbs now reach the DEBUG_NET_WARN_ON_ONCE() in
skb_segment()?

When max_segs is non-zero, skb_segment() skips the frag_list block. It then
runs the assertion against the full payload length:

net/core/skbuff.c:skb_segment() {
    ...
	if (sg && csum && !gso_by_frags)  {
		if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {
			...
			if (!list_skb ||
			    !net_gso_ok(features, skb_shinfo(head_skb)->gso_type))
				goto normal;
			...
		}
		...
		DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS);
    ...
}

Two things keep that assertion true today. First,
__virtio_net_hdr_to_skb() clamps TCP gso_size to at least TCP_MIN_GSO_SIZE,
guarded by:

	BUILD_BUG_ON(TCP_MIN_GSO_SIZE * GSO_MAX_SEGS < GSO_MAX_SIZE);

Second, the grouping path was only used for skbs that passed
gso_within_dev_limits(), so len was below GSO_MAX_SIZE. The new path runs
only for skbs that fail those limits, so their length is no longer bounded
by GSO_MAX_SIZE.

With PACKET_VNET_HDR, packet_snd() does not check the length against the
MTU when a gso_type is set. packet_alloc_skb() accepts up to
MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER) bytes of frags, plus
a larger linear part.

So a CAP_NET_RAW user, including user namespace root, can build a
TCPv4/v6 GSO skb with NEEDS_CSUM, gso_size 8 and a payload of 524288 bytes
or more. tun/tap goes through the same virtio_net_hdr_to_skb() helper.

For such an skb the path looks like this:

dev_queue_xmit()
  validate_xmit_skb()
    gso_within_dev_limits() fails
    skb_gso_output_max_segs() returns about (65536 - hdr_len - 1) / 8
    __skb_gso_segment(skb, features, true, max_segs)
      tcp_gso_segment()
        skb_segment()
          DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS)

Every check in the helper passes here. csum_start equals the transport
header set by skb_partial_csum_set(), and net_gso_ok() succeeds on a TSO
device.

Before this patch the same skb had max_segs == 0 and no GSO_PARTIAL. It
took the goto normal path and never reached the assertion.

The output segments should still be correct, since
partial_segs = min(len / mss, max_segs). But with CONFIG_DEBUG_NET and
panic_on_warn, the new warning would panic the kernel.

Could skb_gso_output_max_segs() return 0 when (skb->len - hdr_len) / mss
exceeds GSO_MAX_SEGS?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930111526.2183107-1-wang.zhan%40smartx.com
