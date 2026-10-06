Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C549892D;
	Tue,  6 Oct 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298850; cv=none; b=TxOmtyWcHTLDgYNVdBrVYLf9vPCXeHeqmcWSOJyHdeO8/22FXBKzuBXdOunotyQ9iCj0264U87k2LmK6eOvcDO5o1M0DNmhPy0NjU3td9YgkzLwQRb4fLwa3M482F9kgmAWSLAnGAiVijK1nb66S/+WCGiQA697M3Cx8Bx4kw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298850; c=relaxed/simple;
	bh=U+xM9BpoDuls1+MO8yAQeDz3OYIR/FOi4h1KebqNNq0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpPCzCKYlqDbN4nMlUbdPu4xyPokyMMgp5LeNBa+19UGhkg/ByFurEik78FedD2aoNFrusOHbLrqhRA72xX3xDnAtRPrPiKPZdFZxgGP1Wg6rvM+H9Hcm+meVWk4y/rOs6XrTbFDaD0cR5NxetpoPBEADsAI0C5xAcW/AJxltKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK9rKD11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK9rKD11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7C91F0089C;
	Tue,  6 Oct 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298848;
	bh=jigz6mvtE+oVZTKJFugbQfRK+cmc9I1w0LMxPaaff8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VK9rKD11nym2AzAWNtov9zOJh8DOuWZV+pElhY1sk4nbWGlhDN6YlK7HtMylhbFyT
	 vMVA/t34XUVISlkwC6Mf287I8QJ/BYKLsasiSErr0kH/T/GPT1PdQ8EJLD5lD7cD4l
	 KdQpTcI5E1REN9D3aB8gGUIbFq2QkB5s/vF5gXbJK7hbYAqIv4Q0PmBUJLKWZPsWMp
	 dZQPm9g1t/Wo55rlfs7UAKk5lvFn8ukXdbTWY1k9s0l/V5EVZU9kiyrgc3jHmCozW8
	 3g7KakWI9rjqPMm4Bzk3/WEI8lvzlNQ7qRUI8GCg1h/CbQxNuAbEETD2fuspEFV685
	 HxwmO0MMJH3Jw==
Subject: Re: [PATCH net-next 2/4] net: rmnet: optimize rx deaggregation memory
 allocation
From: netdev-bot+sashiko@kernel.org
To: koen.vandeputte@citymesh.com
Cc: netdev@vger.kernel.org, quic_subashab@quicinc.com,
 quic_stranche@quicinc.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 15:00:47 +0000
Message-ID: <179129884778.434549.13290303822104852219@kernel.org>
In-Reply-To: <20261002143529.3217189-3-koen.vandeputte@citymesh.com>
References: <20261002143529.3217189-3-koen.vandeputte@citymesh.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes the allocator change incorrectly.
- [Low] The commit message says netdev_alloc_skb()'s built-in NET_SKB_PAD
  is 'ensuring that the newly extracted IP headers are optimally cache-…
- [Low] In rmnet_map_deaggregate()
  (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c:397), `skbn->dev…

--

net: rmnet: optimize rx deaggregation memory allocation

This commit changes rmnet_map_deaggregate() to allocate the per-packet
skbs with netdev_alloc_skb() instead of alloc_skb(GFP_ATOMIC). The
commit message says this uses a lockless per-CPU NAPI cache, avoids slab
allocator contention, and leaves the IP headers cache-aligned through
NET_SKB_PAD.

> Replace alloc_skb() with netdev_alloc_skb() on the deaggregation path.
> netdev_alloc_skb() is specifically designed for the network receive hot
> path, utilizing a fast, lockless per-CPU NAPI cache. Furthermore, it

[Severity: Medium]

Is this an accurate description of netdev_alloc_skb()?

In __netdev_alloc_skb(), small heads and heads larger than a page still
use the same kmalloc path as before:

net/core/skbuff.c:__netdev_alloc_skb() {
    ...
	if (len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) ||
	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
    ...
}

RMNET_MAX_PACKET_SIZE is 16384. On 4KB pages, packets above roughly
3.7KB take that branch, and so do small packets.

Only mid-size packets take the page_frag path. On that path only the
head comes from napi_alloc_cache.page, under local_bh_disable() and
local_lock_nested_bh(). The struct sk_buff still comes from the slab:

net/core/skbuff.c:__build_skb() {
    ...
	skb = kmem_cache_alloc(net_hotdata.skbuff_cache,
			       GFP_ATOMIC | __GFP_NOWARN);
    ...
}

The old alloc_skb(..., GFP_ATOMIC) path could already take the struct
sk_buff from the per-CPU NAPI skb cache when it had entries:

net/core/skbuff.c:__alloc_skb() {
    ...
	} else if (!in_hardirq() && !irqs_disabled()) {
		local_bh_disable();
		skb = napi_skb_cache_get(false);
		local_bh_enable();
	}
    ...
}

The page_frag path through __build_skb() never uses that cache.

Every packet still makes at least one slab allocation. So is it correct
to say this change "prevents slab allocator contention"? The description
seems to fit napi_alloc_skb() better than netdev_alloc_skb().

The commit message also says the change "significantly reduces memory
allocation overhead" and "improves overall throughput". Could some
measurements be added to support that?

> automatically provisions standard network padding (NET_SKB_PAD), ensuring
> that the newly extracted IP headers are optimally cache-aligned for
> efficient processing by the upper networking stack.

[Severity: Low]

Can the IP header actually end up cache-aligned here?

__netdev_alloc_skb() already does skb_reserve(skb, NET_SKB_PAD).
rmnet_map_deaggregate() then reserves its own headroom on top of that:

	skbn->dev = skb->dev;
	skb_reserve(skbn, RMNET_MAP_DEAGGR_HEADROOM);
	skb_put(skbn, packet_len);

Here RMNET_MAP_DEAGGR_HEADROOM is 32. After that,
__rmnet_map_ingress_handler() pulls the 4 byte MAP header:

		skb_pull(skb, sizeof(*map_header));

That puts the IP header at NET_SKB_PAD + 32 + 4 bytes from the head.
For an L1_CACHE_BYTES of 32, 64 or 128 that is 68, 100 or 164 bytes,
and none of these is cache line aligned. The old offset of 36 was not
aligned either.

The netdev_alloc_skb() kerneldoc says users should allocate the headroom
they need without counting the built in space. RMNET_MAP_DEAGGR_SPACING
and RMNET_MAP_DEAGGR_HEADROOM were left as they were, so each
deaggregated skb now carries NET_SKB_PAD extra bytes of headroom that
nothing uses.

Could the commit message be corrected, or the headroom handling changed
so that the alignment claim holds?

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 2eafb1d969c1a..ccdfde3711db8 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -390,7 +390,7 @@ struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
>  	if (!packet_len)
>  		return NULL;
>  
> -	skbn = alloc_skb(packet_len + RMNET_MAP_DEAGGR_SPACING, GFP_ATOMIC);
> +	skbn = netdev_alloc_skb(skb->dev, packet_len + RMNET_MAP_DEAGGR_SPACING);
>  	if (!skbn)
>  		return NULL;
>  

[Severity: Low]

This isn't a bug, but the skbn->dev = skb->dev assignment that follows
in rmnet_map_deaggregate() is now redundant. __netdev_alloc_skb() sets
skb->dev on every success path, including the __alloc_skb() fallback:

skb_success:
	skb_reserve(skb, NET_SKB_PAD);
	skb->dev = dev;

Could that assignment be removed as part of this conversion?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002143529.3217189-1-koen.vandeputte%40citymesh.com
