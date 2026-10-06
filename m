Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0C49E14D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307157; cv=none; b=ndlVoYIEv9i+w8jMYwzRjMgr5E7saMHUhMoJ89ASw3rXlvp0KopSE/zW6Wr8IsWVGUMEG8Vp+HiCwc+e9UTBKFdnySaH+xnhHJpngr+Y9oKLZPBBxs+RCVkSpOQYlpjXjUIyU9z6RODqSJLYfuTyOOUV3G4glu85sfKjZibA4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307157; c=relaxed/simple;
	bh=ce9RRCKtFccW5QEwYDskod9D4cYO0IwwnQYcshWHp68=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bESCUu8qOgn3R4ECgGC6yy+rvL/aJmE2xK+jMOV+pY7tgQAhd7aXMyEnzkLjHOr91hRpCnerdLoFTZVEJfz11mjIHNx40Ipsj/3RoV3ZoIzv7n5sZIwSBYqXHzZgyqx35XDeaCJMhLvRvRV60/ynt5MYd9tykNqeiwlmrNEvWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1thEkq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1thEkq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA1C1F0089C;
	Tue,  6 Oct 2026 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307153;
	bh=ak2e46SqXbf3llfN2+9lEywpP+BOCZrPuH1ohO5lzuA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L1thEkq2+610aWWRWYSc3wW5IQ1DPpzNIbRx7/6/ohjNstB7K2zciTsoQ27tH0CI8
	 SOtJ+Kj1g1VWAlx1SxTldoos1JnYMisghq0WaVuKQK9ukOeM3duccsAD5vg4AOhmgq
	 ChcGH9VI3AFH1dyUHp/M9rz2KoioyS0hVi5nmPnGR2WxbKhDefmDRvVm/a7P0W8iLk
	 FPp1xI+3VU/RFwdre+y2aQINAaSdTUXfl6x9+x2rz+AN3QVtY/QSUeXQbGJgAiSogD
	 D9Lq0M0tQppPCtP1dRdugvGoYvN1TO5MDEBNZhl61E7wYT+oHo8Jfz2VH2VK5jxqa/
	 wCsshxJEVlMXw==
Subject: Re: [PATCH net-next v3 10/12] net: ethernet: cortina: Validate RX
 fragment lengths
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:12 +0000
Message-ID: <179130715277.434549.7024559629176712429@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-10-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-10-3e1f25890ae8@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Inconsistent descriptor lengths can still produce an skb shorter
  than an Ethernet header, and handing it to GRO causes a NULL…
- [High] net: gemini: valid perfectly aligned packets are dropped on
  0-length EOF
- [Low] The commit message does not say how the issue was discovered or
  validated, or on what hardware the fix was tested.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but gmac_rx()
  adds only the payload length to skb->truesize (`skb->truesize +=…

--

net: ethernet: cortina: Validate RX fragment lengths

This commit adds length checks to gmac_rx() so that RX descriptor
lengths cannot place a fragment outside the posted free queue fragment
or the backing page. Short initial fragments, frame length underflow and
zero-length fragments are now dropped instead of being added to the skb.

> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Low]
Could the commit message say how this issue was found and how the fix was
tested? Documentation/process/maintainer-netdev.rst asks for this in the
bug fixes section:

  All bug fixes must state how the issue was discovered and validated,
  and how the fix was tested.

For hardware drivers, the same section asks for the hardware the fix was
tested on.

The new checks depend on how the hardware fills buffer_size and
byte_count. Was this tested on Gemini/SL3516 hardware?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index a0186cc4b9436..6b333eb81f9c4 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1771,6 +1772,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			if (!skb)
>  				goto err_drop;
>  
> +			if (frag_len < NET_IP_ALIGN)
> +				goto err_drop;
> +
>  			page_offs += NET_IP_ALIGN;
>  			frag_len -= NET_IP_ALIGN;
>  			frag_nr = 0;
> @@ -1779,15 +1783,26 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		if (word3.bits32 & EOF_BIT)
> +		if (word3.bits32 & EOF_BIT) {
> +			if (frame_len < skb->len)
> +				goto err_drop;
>  			frag_len = frame_len - skb->len;
> +		}

[Severity: High]
Can inconsistent descriptors still produce an skb shorter than an
Ethernet header here?

The ETH_ZLEN minimum in gmac_skb_if_good_frame() only applies to the SOF
descriptor's byte_count. On the EOF descriptor, frame_len comes from that
descriptor's own word1.bits.byte_count. The only new check on it is
frame_len < skb->len.

For example:

  SOF descriptor (no EOF bit): buffer_size = 3, byte_count = 60
    passes gmac_skb_if_good_frame() and frag_len >= NET_IP_ALIGN,
    appends 1 byte
  EOF descriptor: byte_count between 2 and 13
    passes frame_len >= skb->len, the range check and the zero-length
    check, appends the rest

napi_gro_frags() then receives an skb of 2 to 13 bytes.

napi_frags_skb() cannot pull the 14 byte ethhdr, so it reuses the skb and
returns NULL:

net/core/gro.c:napi_frags_skb() {
    ...
	if (unlikely(!skb_gro_may_pull(skb, hlen))) {
		eth = skb_gro_header_slow(skb, hlen, 0);
		if (unlikely(!eth)) {
			...
			napi_reuse_skb(napi, skb);
			return NULL;
		}
    ...
}

napi_gro_frags() then passes that NULL straight on:

net/core/gro.c:napi_gro_frags() {
	...
	struct sk_buff *skb = napi_frags_skb(napi);
	...
	ret = napi_frags_finish(napi, skb, dev_gro_receive(&napi->gro, skb));
	...
}

dev_gro_receive() calls skb_get_hash_raw(skb) on entry. Wouldn't that
be a NULL dereference in NAPI softirq context?

This crash path existed before this patch. However, the commit message
says these descriptor inconsistencies are now dropped. Should gmac_rx()
check that skb->len is at least ETH_HLEN (or ETH_ZLEN) before calling
napi_gro_frags()? Alternatively, it could check that the EOF frame_len
matches the SOF frame_len.

>  
>  		/* append page frag to skb */
>  		if (frag_nr == MAX_SKB_FRAGS)
>  			goto err_drop;
> +		if (frag_len > freeq_frag_len -
> +			       (page_offs & (freeq_frag_len - 1)) ||
> +		    frag_len > PAGE_SIZE - page_offs)
> +			goto err_drop;
>  
> -		if (frag_len == 0 && net_ratelimit())
> -			netdev_err(netdev, "Received fragment with len = 0\n");
> +		if (!frag_len) {
> +			if (net_ratelimit())
> +				netdev_err(netdev,
> +					   "Received fragment with len = 0\n");
> +			goto err_drop;
> +		}
>  
>  		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
>  		skb->len += frag_len;

[Severity: High]
Does this drop complete frames when the EOF descriptor carries no
payload?

On an EOF descriptor frag_len is recomputed as frame_len - skb->len.
The earlier descriptors of the chain may already have delivered all
frame_len bytes. One case is a frame that ends exactly on a free queue
fragment boundary while the hardware still closes the chain with a
separate EOF descriptor. Then frag_len is 0 here even though the skb
already holds the whole frame.

The new goto err_drop then calls napi_free_frags() on that skb and
counts it in rx_dropped, instead of handing it to napi_gro_frags().

Before this patch, this case only printed the ratelimited "Received
fragment with len = 0" message, and the frame was still delivered.
That message suggests the condition has been seen on real hardware.
If the hardware can emit such descriptors, frames of particular
lengths would now be lost every time, which can be triggered by remote
traffic.

Would it be better to treat a zero-length EOF fragment as having
nothing to append? gmac_rx() could release the page with put_page(),
skip skb_fill_page_desc(), and still complete the skb with
napi_gro_frags(). The zero-length check would then need to come before
the frag_nr == MAX_SKB_FRAGS check. Otherwise a complete frame that
uses all MAX_SKB_FRAGS slots and is followed by an empty EOF
descriptor is still dropped.

Was the zero-length case checked against the behaviour of the
Gemini/SL3516 hardware before turning it into a drop?

[Severity: Medium]
This isn't a bug introduced by this patch, but the line just after this
in gmac_rx() adds only the payload length to truesize:

		skb->truesize += frag_len;

Each fragment pins a whole DMA buffer of 1 << freeq_frag_order bytes,
with its own page reference taken in geth_freeq_post_page():

	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */

Doesn't this understate the pinned memory by up to about 2 KiB per
fragment for socket rmem and GRO accounting? Would adding freeq_frag_len
here be more accurate?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
