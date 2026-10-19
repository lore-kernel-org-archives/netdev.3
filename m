Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67BE45FFAA;
	Mon, 19 Oct 2026 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386504; cv=none; b=UgCbI/Au7yUvXCFGxqzAjAfNLM89ah9mdvMUqqfvT6B5vQ46xM04nILpz26+Dhs39FbMvR5WYmAM+ZrehXp5PisBIzU0rWKzlgFP4rA5WJ/F3Hn5JZVgqRf5tb6pAafV0llW+AXFr05Sm0yY+ckqI/kL7rZlkScVkBlAPMBQ2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386504; c=relaxed/simple;
	bh=yGvc6awARnZE2tQYL3x3TA0b0QsnOI6BXtSqHTOOIUI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4nbD8Ej3bU0RxYrVHAi935TRKACaUoR5t+fidCAv2g1ni5F5GdAgn4j/qDWhdF4LSPAcZoAstUdzbuJU4QxreQCG1M8gsJXLdYZRsA4tD2E7WAWJ0UE/qMKUX6yfQ8ehm/C4p/yEXen6A0KOEkxU08meRrTC8WqotU4IqBH7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyFLae48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyFLae48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6BB1F000C6;
	Mon, 19 Oct 2026 05:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792386497;
	bh=feYvSxk3/cg/Iox3JCkB7KAiANWalFhwxLCSxJSaD1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZyFLae48Ovuf+NBbKQGj0nvRjQ2P9vEHlTd2pVwHksbxWf1xOZs6xyDulCdrWRjm0
	 ymDV/TuvXFVvUNTyhas4Z1IPCnatBwmV3/I79aWYAd2oAyBl6k9FvAhW0HeqKwkJ93
	 x3LioaDRDc3ii47WBkOBadLTWzHetK1b5787STNXwRHUKK7lNpiIWbgPk2jsqWw/m6
	 6TUtJlprJS6zf5AAL0kcuzb/jOPMKsb/EkXSBhvfbrdfuoxMOak/uDoIInEf0rAxgL
	 4+BeZmv4XvFhv6RQGgwJAZ299msGCf1bD5MJO1l4XsMmcuW9yIJMWf2tvFMvMVVlCe
	 hMFy08hom6iIw==
Subject: Re: [PATCH] net: ns83820: drain RX tasklet when stopping the device
From: netdev-bot+sashiko@kernel.org
To: yaojiale02@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 05:08:16 +0000
Message-ID: <179238649630.3135.5526826653643739893@kernel.org>
In-Reply-To: <20261018040708.534335-1-yaojiale02@163.com>
References: <20261018040708.534335-1-yaojiale02@163.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix drains only one of the two deferred RX contexts.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but rx_irq(),
  which the drained rx_tasklet runs, unmaps completed RX buffers with…
- [Medium] This problem wasn't introduced by this patch, but
  ns83820_cleanup_rx() frees every posted RX skb without…

--

net: ns83820: drain RX tasklet when stopping the device

This patch adds a tasklet_kill() of rx_tasklet to ns83820_stop(), after
the device is reset and the IRQ is synchronized. The goal is to make sure
an RX tasklet that is already queued cannot run after the stop path
cleans the RX descriptors, or after device removal frees the rings and
the netdev.

> diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
> index cdbf82affa7be..f31c15cb2f517 100644
> --- a/drivers/net/ethernet/natsemi/ns83820.c
> +++ b/drivers/net/ethernet/natsemi/ns83820.c
> @@ -1536,6 +1536,7 @@ static int ns83820_stop(struct net_device *ndev)
>  	ns83820_do_reset(dev, CR_RST);
>  
>  	synchronize_irq(dev->pci_dev->irq);
> +	tasklet_kill(&dev->rx_tasklet);

[Severity: High]
Does this drain only one of the two deferred RX contexts? The tasklet
being killed here can itself queue dev->tq_refill. The hard IRQ path can
queue it as well:

rx_action()->ns83820_rx_kick()
ns83820_do_isr()->ns83820_rx_kick()

drivers/net/ethernet/natsemi/ns83820.c:ns83820_rx_kick() {
    ...
	if (dev->rx_info.up && nr_rx_empty(dev) > NR_RX_DESC*3/4)
		schedule_work(&dev->tq_refill);
    ...
}

This happens when the GFP_ATOMIC refill fails under memory pressure.
tasklet_kill() waits for the tasklet but not for work the tasklet has
already queued. The driver has no cancel_work_sync() or flush_work() for
tq_refill anywhere.

queue_refill() calls rx_refill() without checking rx_info.up. Only the
kick_rx() call is gated:

drivers/net/ethernet/natsemi/ns83820.c:queue_refill() {
	struct ns83820 *dev = container_of(work, struct ns83820, tq_refill);
	struct net_device *ndev = dev->ndev;

	rx_refill(ndev, GFP_KERNEL);
	if (dev->rx_info.up)
		kick_rx(ndev);
}

The GFP_KERNEL refill can sleep in reclaim. It then allocates skbs,
DMA-maps them and stores them in rx_info.skbs[] through
ns83820_add_rx_skb(). ns83820_cleanup_rx() frees rx_info.skbs[] without
holding rx_info.lock, and it does not reset next_empty or next_rx.

If the work overlaps with or follows ns83820_cleanup_rx() during ifdown,
could skbs be left in the ring? On the next open, ns83820_setup_rx()
resets next_empty to 0. rx_refill() would then hit this check in
ns83820_add_rx_skb():

	BUG_ON(NULL != dev->rx_info.skbs[next_empty]);

On removal, unregister_netdev()->ns83820_stop() can return while the
work is still pending or running. ns83820_remove_one() then does:

	iounmap(dev->base);
	...
	dma_free_coherent(&dev->pci_dev->dev, 4 * DESC_SIZE * NR_RX_DESC,
			  dev->rx_info.descs, dev->rx_info.phy_descs);
	pci_disable_device(dev->pci_dev);
	free_netdev(ndev);

Wouldn't queue_refill() then use the freed private area, write to the
freed RX descriptor ring, and reach kick_rx() on an unmapped dev->base?

This is the same kind of problem the commit message describes: deferred
RX work queued from the interrupt path, which synchronize_irq() does not
drain. Should ns83820_stop() also call cancel_work_sync(&dev->tq_refill)
after the tasklet is killed and before ns83820_cleanup_rx()?

>  
>  	spin_lock_irq(&dev->misc_lock);
>  	dev->IMR_cache &= ~(ISR_TXURN | ISR_TXIDLE | ISR_TXERR | ISR_TXDESC | ISR_TXOK);

[Severity: Medium]
This is a pre-existing issue, and this patch did not introduce it. The
stop sequence here ends in ns83820_cleanup_rx(). That function frees each
posted RX skb without unmapping it first:

drivers/net/ethernet/natsemi/ns83820.c:ns83820_cleanup_rx() {
    ...
	for (i=0; i<NR_RX_DESC; i++) {
		struct sk_buff *skb = dev->rx_info.skbs[i];
		dev->rx_info.skbs[i] = NULL;
		clear_rx_desc(dev, i);
		kfree_skb(skb);
	}
}

ns83820_add_rx_skb() maps each buffer with
dma_map_single(..., REAL_RX_BUF_SIZE, DMA_FROM_DEVICE). The bus address
is stored only in the descriptor's BUFPTR. clear_rx_desc() overwrites
BUFPTR before anything reads it. The only RX unmap is in rx_irq(), and
it only covers completed descriptors.

Does each ifdown, and the stop during removal, leak up to NR_RX_DESC
streaming DMA mappings? Those are swiotlb slots or IOMMU IOVAs that stay
mapped to freed pages.

[Severity: High]
This is also a pre-existing issue that this patch did not introduce. It
is in rx_irq(), which the drained rx_tasklet runs. Completed RX buffers
are unmapped with a different size than they were mapped with:

drivers/net/ethernet/natsemi/ns83820.c:ns83820_add_rx_skb() {
    ...
	buf = dma_map_single(&dev->pci_dev->dev, skb->data, REAL_RX_BUF_SIZE,
			     DMA_FROM_DEVICE);
    ...
}

drivers/net/ethernet/natsemi/ns83820.c:rx_irq() {
    ...
		dma_unmap_single(&dev->pci_dev->dev, bufptr, RX_BUF_SIZE,
				 DMA_FROM_DEVICE);
    ...
}

with:

#define RX_BUF_SIZE	1500	/* 8192 */
#define REAL_RX_BUF_SIZE (RX_BUF_SIZE + 14)	/* rx/tx mac addr + type */

With swiotlb bouncing, only the unmap size is copied back. On
non-coherent architectures, only 1500 bytes are synced for the CPU.
rx_irq() then calls skb_put() with a len of up to 1514 bytes. It can
also set CHECKSUM_UNNECESSARY when the hardware reports a good checksum.

Can the last 14 bytes of a full-size frame be delivered to the stack
with stale buffer contents, and skip software checksum verification?
DMA_API_DEBUG would also report the size mismatch on every packet.

Should the unmap in rx_irq() use REAL_RX_BUF_SIZE to match the mapping?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018040708.534335-1-yaojiale02%40163.com
