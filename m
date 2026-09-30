Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D612FA0C6
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736641; cv=none; b=XHcS/V6Bb3NoJzFVBc28SCfytcSasy9IvFLxnaGCnYH11K1DMNauApuxvsx0B8zQsvWozxjz2dtnbeO8Z5r8fCQ/1OdmsF1QYLaGISl+Ee0SSN5ipLqnbw9g3hhXwaWM11a1j2tPdB6FoGL3asEb1JD2KTznnjrpoalc/RyPr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736641; c=relaxed/simple;
	bh=/+Lu6nfeF+9oXXBtP5LrSRFvcBC68C2Gvif1zEziRwk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4lWyCzJtLS4c7VYtGXpyQOMG9LzxwuySaZ1dKPaoNFWiMvvy6Vycu0KEfCNOpT+a4U4h0ncBA8iTkb79wrCDKZ/k/3h+E/VwMNgSPX+aCpMwV7t+0qrMUHwFFiAD1tsFWy8HTKYEsJ8/bfw1DDnJDzWTfjK1dE6oFkI2y5846Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpbkpKMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpbkpKMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485DE1F00893;
	Wed, 30 Sep 2026 02:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736639;
	bh=Xul2N+zlL5Anth/SHwJu+TIQ853LCxRtZsArNdmUZlk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZpbkpKMt2tz7o9tQmSHaOSZNrbqOdov+E7I7np2wYgp/4PC/sps49h+PesBSPKmBP
	 4BNW3sRrgGH/ESf5e2T58duE0mCieuigFpyj83omm80CZhd2VNtRxbKkZJvN1NcNDr
	 CieFe26qTDmHN3px58A12hBQM4koDVShCjuArHmnMaQ3wRa53eB5qpmXu50EwNB1P3
	 6V79gUoBRb0eJxQBkKItjrke8PZHykK5kcUhOOWOyN/N8zPBSR8bd2RmiINo7C9VSI
	 /FbmJ8wx5uGwthFX5OLCyIeeQPKNj9LEtWRAVgqNZVtxrYDVoCKHy8PtiP5jad6aUS
	 7YcSPG9brUnsg==
Subject: Re: [PATCH net-next v2 02/11] net: ethernet: cortina: Drain free
 queue IRQ before resize
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:38 +0000
Message-ID: <179073663886.434549.12766814518697663211@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-2-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-2-758a795d7a78@kernel.org>
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

Critical: 0 · High: 0 (1) · Medium: 2 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new sequence in geth_resize_freeq() (lines 1096-1098) is
  mask, synchronize_irq(port1->irq), mask.
- [Medium] At this commit, geth_resize_freeq() calls
  geth_set_freeq_irq(geth, true) (line 1112) without checking the return…
- [Low] The commit fixes a use-after-free race, but it has no Fixes:
  trailer.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  geth_resize_freeq() assumes the peer port object is valid.
- [Medium] This problem wasn't introduced by this patch, but at this
  commit geth_resize_freeq() sets `geth->freeq_order = new_order` (line…
- [Low] This problem wasn't introduced by this patch, but the kernel-doc
  of geth_resize_freeq() is wrong.

--

net: ethernet: cortina: Drain free queue IRQ before resize

This commit changes how geth_resize_freeq() disables the SWFQ empty
interrupt. It used to only mask it. It now masks it, calls synchronize_irq()
on port 1's IRQ, and masks it again, so that a threaded handler which is
already running gets drained. The read-modify-write of
GLOBAL_INTERRUPT_ENABLE_4_REG moves into a new helper, geth_set_freeq_irq().

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Low]
The commit message describes a fix for a race, but there is no Fixes: tag.
In the race, gemini_port_irq_thread() refills the queue while
geth_resize_freeq() tears down freeq_ring and freeq_pages.

The mask-only sequence being replaced in geth_resize_freeq() appears to
date back to the original driver submission. Should this carry a tag so
stable and backport tooling can pick it up?

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 31bcd41c17fad..e5531e41ae9a3 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1030,6 +1030,21 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)

[ ... ]

>  /**
>   * geth_resize_freeq() - resize the software queue depth
>   * @port: the port requesting the change

[Severity: Low]
This isn't a bug introduced by this patch, but the kernel-doc for
geth_resize_freeq() says:

 * This gets called at least once during probe() so the device queue gets
 * "resized" from the hardware defaults.

The only callers appear to be gmac_open() and gmac_set_ringparam(). Neither
gemini_ethernet_port_probe() nor gemini_ethernet_init() calls it.

This patch reworks the IRQ handling in this function. Could the comment be
updated at the same time? It is also unchanged at the end of the series.

> @@ -1047,8 +1062,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	struct net_device *other_netdev;
>  	unsigned int new_size = 0;
>  	unsigned int new_order;
> -	unsigned long flags;
> -	u32 en;
>  	int ret;
>
>  	if (netdev->dev_id == 0)

[Severity: High]
This is a pre-existing issue, but geth_resize_freeq() dereferences the peer
port here without checking it. The patch adds another unchecked dereference
further down with synchronize_irq(geth->port1->irq).

Can geth->port1 or geth->port0 be NULL, or point to freed memory, at this
point?

If the peer ethernet-port node is missing, the pointer stays NULL. The
binding doesn't require either child node.

Several in-tree boards declare port@1 with no phy-mode or phy-handle:
gemini-dlink-dns-313, nas4210b, nas4220b, rut1xx, wbd111 and
dlink-dir-685. The ns2502 and verbatim boards inherit port@1 from
gemini.dtsi in the same state. gemini_ethernet_port_probe() publishes the
pointer before the steps that can fail:

	if (!id)
		geth->port0 = port;
	else
		geth->port1 = port;
	...
	ret = gmac_setup_phy(netdev);
	if (ret) {
		netdev_err(netdev,
			   "PHY init failed\n");
		goto unprepare;
	}

On those boards gmac_setup_phy() returns -ENODEV. Devres then frees the
netdev from devm_alloc_etherdev_mqs() that contains port, and geth->port1 is
never cleared.

Wouldn't a later ip link set eth0 up or ethtool -G eth0 then go through
gmac_open()->geth_resize_freeq() and read freed memory? That would happen
via other_netdev, netif_running(other_netdev), other_port->rxq_order, and
now geth->port1->irq.

gmac_open() also treats a spurious -EBUSY from the netif_running() check as
success. The interface would then come up without a configured free queue.

This still appears to be present at the end of the series.

[ ... ]

> @@ -1079,13 +1092,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	if (geth->freeq_order == new_order)
>  		return 0;

[Severity: Medium]
This isn't a bug introduced by this patch, but geth_resize_freeq() stores
the new order before geth_setup_freeq() succeeds. It doesn't restore the
old order on failure:

	geth->freeq_order = new_order;
	ret = geth_setup_freeq(geth);

geth_setup_freeq() can fail, for example in dma_alloc_coherent() or in
alloc_page(GFP_ATOMIC) inside geth_freeq_alloc_map_page(). After such a
failure freeq_ring is NULL, and GLOBAL_SW_FREEQ_BASE_SIZE_REG is still 0
from geth_cleanup_freeq().

The next gmac_open() or ethtool -G would compute the same order. Could it
then take this early return with 0, so that gmac_open() goes on to
gmac_setup_rxq() and gmac_start_dma() without a valid shared free queue?

Later in this series, "net: ethernet: cortina: Preserve in-flight free
queue pages" changes the check to the following and NULLs freeq_ring on the
setup error paths, which resolves this:

	if (geth->freeq_ring && geth->freeq_order == new_order)

>
> -	spin_lock_irqsave(&geth->irq_lock, flags);
> -
> -	/* Disable the software queue IRQs */
> -	en = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
> -	en &= ~SWFQ_EMPTY_INT_BIT;
> -	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
> -	spin_unlock_irqrestore(&geth->irq_lock, flags);
> +	/* The threaded handler can already be running and re-enable the IRQ. */
> +	geth_set_freeq_irq(geth, false);
> +	synchronize_irq(geth->port1->irq);
> +	geth_set_freeq_irq(geth, false);

[Severity: Medium]
Does this sequence fully close the window described in the commit message?

synchronize_irq() only waits for threads that were already woken. After its
refill, the drained gemini_port_irq_thread() re-enables the interrupt
unconditionally:

	/* ACK queue interrupt */
	writel(irqmask, geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
	/* Enable queue interrupt again */
	irqmask |= readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
	writel(irqmask, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);

Suppose SWFQ_EMPTY is asserted, and the hardirq is handled after that
thread finishes but before the second geth_set_freeq_irq(geth, false). Then
gemini_port_irq() sees:

	if (val & en & SWFQ_EMPTY_INT_BIT) {

It masks the bit and returns IRQ_WAKE_THREAD. The second mask then clears a
bit that is already clear, and nothing waits for the newly woken thread.

Couldn't that thread run geth_fill_freeq() on freeq_pages and freeq_ring
while geth_cleanup_freeq() frees them? It could also race with
geth_setup_freeq() rebuilding them with the new freeq_order, and then
re-enable the interrupt after teardown.

The sequence and the unconditional re-enable in the thread appear to be
unchanged at the end of the series.

Would something other than a second mask be more robust? One option is
disable_irq(geth->port1->irq) and enable_irq() around the resize. Another is
state protected by irq_lock that stops the thread from re-enabling the
interrupt during a resize.

>
>  	/* Drop the old queue */
>  	if (geth->freeq_ring)
> @@ -1099,10 +1109,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	 * after probe(), this is where the interrupts get turned on
>  	 * in the first place.
>  	 */
> -	spin_lock_irqsave(&geth->irq_lock, flags);
> -	en |= SWFQ_EMPTY_INT_BIT;
> -	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
> -	spin_unlock_irqrestore(&geth->irq_lock, flags);
> +	geth_set_freeq_irq(geth, true);

[Severity: Medium]
Should this re-enable be skipped when geth_setup_freeq() returns an error?

By this point geth_cleanup_freeq() has already done the following:

- set wptr = rptr
- written 0 to GLOBAL_SW_FREEQ_BASE_SIZE_REG
- kfree()d freeq_pages and freed the ring, without NULLing either pointer

The geth_setup_freeq() error paths kfree() the new freeq_pages without
NULLing it, and they set freeq_ring to NULL. A dma_alloc_coherent() failure
leaves the stale freeq_pages from cleanup in place.

Setup failure looks easy to hit. For example, ethtool -G ethX rx 16384 asks
for an order 15 queue backed by many alloc_page(GFP_ATOMIC) pages.

The queue has just been emptied, and resize never ACKs
GLOBAL_INTERRUPT_STATUS_4_REG. If SWFQ_EMPTY status is latched, this
re-enable wakes gemini_port_irq_thread()->geth_fill_freeq(geth, true).

Can that walk freeq_pages[pn] in freed memory using the new, larger
freeq_order? Could it call page_ref_count() and page_ref_add() on stale page
pointers, and write through the NULL or freed freeq_ring in
geth_freeq_alloc_map_page()?

Later in this series, "net: ethernet: cortina: Preserve in-flight free
queue pages" resolves this. It returns early on error before the re-enable,
and it NULLs freeq_pages and freeq_ring in the cleanup and error paths.

>
>  	return ret;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
