Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106237C933
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830734; cv=none; b=Wv9P2WokoG/iCsFLH793xmxvWV+8048+ZIralegCnJZpe1Aqz+2xHrcmwwF8riZwMhvetD+mWVmITjh/d98u+e9/GUI8onPnD83tabjnHT2Z81H1fnIE3KqiLLQBmbuihKShghXtUo7ig3ieB+xdPSApPThEIsUGHVWtd/yAPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830734; c=relaxed/simple;
	bh=p8zMjORm0/hkfoyTD/SypuALuBvuuomngpdQ9cqOvvQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EIAk76nlvcvtMwBc+OWuFQyLIncOjlUzKhbumOit6UIogerueP+KaeW97+diUmFspvefnHhf2Qaqx1oX3xRWXb6Ro118fvpfPgP5u8YbdmcVcFdb7O+UcVSEuPcFvZ0m21mHQrVxdsXS+YDUHuEu4xc+3Y45RxUo8Tu83Y+k/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/8S5SKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/8S5SKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A42D1F0089B;
	Mon, 12 Oct 2026 18:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830732;
	bh=9RExwvHNY45qtGxU7CQyhKlKlCESMsARfjziwrMkBxQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z/8S5SKRTonlUPzXwank9ORvIIW347OzciWfYIkGckZjk1MSBFK6OgIPePyj0sXMf
	 sLXL8l0coIBRglHHe5dogV3LE8fsTN04vMTwy7357lFW5oaHDm+KrIbJ0WyogMuo+W
	 l1Cse9ZFmSEEFgJpktz6bWSRqjZoq/ET25rADn/O4xr9XCipNedh59nWtV7hG7+W8N
	 9hreZryS2lpFV2R+TLm7ccj1pzbtbrISJRtbtX2+Kly7eeP8oxswyLJmkYcKjPre8n
	 zoNU8zn/3pStoBXL0iAwvGZjn8mc/MyqTEWB9Ke1OQYq78Los5gXnYGMg1sGXQjelQ
	 Xp6lpjrbiM6wg==
Subject: Re: [PATCH net-next v4 04/15] net: ethernet: cortina: Normalize free
 queue pointers on rebuild
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:30 +0000
Message-ID: <179183073088.434549.6045538378727552076@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-4-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-4-4b1631b08f5d@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `writel(0, geth->base + GLOBAL_SWFQ_RWPTR_REG)` in
  geth_setup_freeq() comes with the comment "Discard pointer state…
- [Low] The patch fixes a real out-of-bounds access but has no Fixes:
  tag.

--

net: ethernet: cortina: Normalize free queue pointers on rebuild

This commit masks the free queue page index in geth_fill_freeq() to the
active queue order. Before the initial fill, it also writes 0 to
GLOBAL_SWFQ_RWPTR_REG in geth_setup_freeq(). Together these are meant to
stop out-of-bounds access to the replacement page table when the free
queue is rebuilt at a smaller order.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index c03541deed495..c3d1abdbebf61 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -887,6 +887,7 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
>  
>  	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
>  	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
> +	pn &= m_pn;

[Severity: Low]
Should this patch carry a Fixes: tag?

The unmasked pn computation in geth_fill_freeq() comes from commit
4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet").
If rptr is left over from a larger ring, the old code indexed
geth->freeq_pages[pn] past the end of the newly allocated table. It then
called page_ref_count()/page_ref_add() on whatever pointer was there.

A user with CAP_NET_ADMIN can reach this. Running ethtool -G on both ports
while they are down shrinks the free queue through:

gmac_set_ringparam()->geth_resize_freeq()->geth_cleanup_freeq()->
    geth_setup_freeq()->geth_fill_freeq(false)

The other free queue lifecycle fixes in this series all carry
Fixes: 4d5ae32f5e1e:

  "Keep shared free queue parent-owned"
  "Drain free queue IRQ before resize"
  "Correct free queue DMA mappings"
  "Preserve in-flight free queue pages"

The mask does not depend on any other patch in the series, so it should
backport on its own.

>  	epn = (rw.bits.rptr >> fpp_order) - 1;
>  	epn &= m_pn;
>  
> @@ -958,6 +959,9 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  		if (!geth_freeq_alloc_map_page(geth, pn))
>  			goto err_freeq_alloc;
>  
> +	/* Discard pointer state belonging to the previous queue geometry. */
> +	writel(0, geth->base + GLOBAL_SWFQ_RWPTR_REG);

[Severity: Medium]
Does this writel() actually reset the read pointer? gemini.h defines the
register like this:

union dma_rwptr {
	unsigned int bits32;
	struct bit_000c {
		unsigned int rptr	: 16;	/* Read Ptr, RO */
		unsigned int wptr	: 16;	/* Write Ptr, RW */
	} bits;
};

geth_cleanup_freeq() follows that layout and writes only the wptr half:

	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);

If rptr is read-only, the 32-bit write of 0 clears only wptr. The hardware
rptr then keeps its position from the old, larger ring.

In that case the new comment, and this part of the commit message, would
not match what the hardware does:

  Reset the pointer register before initially filling a rebuilt queue

geth_fill_freeq(false) masks the stale rptr only for the CPU-side page
index. It then publishes a masked wptr:

	writew(pn << fpp_order, geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);

For example, take a rebuild from order 10 with rptr at 768 to order 8
(256 entries). Software posts entries 0..253 and sets wptr to 254, but the
hardware rptr is still 768.

Suppose the free queue engine computes descriptor addresses from the raw
rptr (freeq_dma_base + rptr * 16). Could it then read descriptors past the
end of the new dma_alloc_coherent() ring and DMA received frames to
whatever buf_adr values it finds there?

Nothing in the driver shows the hardware reducing rptr modulo the new
queue size. The commit message also hedges with "if hardware retains its
read pointer while the queue is disabled".

Later in the series, geth_setup_freeq() still has the same writel(0) and
comment. geth_fill_freeq() then starts at wptr and stops at
((rptr >> fpp_order) - 1) & m_pn. If rptr is retained, a rebuild after
traffic would fill fewer entries than expected. Wouldn't
geth_setup_freeq() then fail with -ENOMEM?

> +
>  	filled = geth_fill_freeq(geth, false);
>  	if (!filled)
>  		goto err_freeq_alloc;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
