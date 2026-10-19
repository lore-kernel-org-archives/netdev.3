Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB91353A77;
	Mon, 19 Oct 2026 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376970; cv=none; b=nXVih7Zu+6UKwkv/i1QsKV2/agTH3A1mf0LvvLcYzJo687viDc5siUHh78LsA/f3/AoFztgw5MomIjPQhrILiaxQ36rMF8qfsEjTkqQiQovlo8ulBQGsGBy6ZCzkFF969i/OpQ6GzgClfmblKD6QtEj+sw/4v7uuhDlEGQIDPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376970; c=relaxed/simple;
	bh=Pe79u2WtD8qlGYL4vHyAC3UJ6mQinnZFoE9BPYg6Q9s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Djgxtr9MXZAR335seRjH9Aq4cP+1qXvlWJstAEYAvV0bL8EdAYVZ0QTzc/gtOihtwRzeCDjx9ww2hZziOisynnM6lYDmMQyyAJyGnuXln0uzwJUFN8+IJCUwzSVZVr7Qx98PivM7UY4MZusyIeWusHBBIu84eb2552bGEkWYMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAYigqb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAYigqb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF21F000C4;
	Mon, 19 Oct 2026 02:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376967;
	bh=VHXJVdhjsMCDbF8t6cCn/943Z7n4SphvPLRTxcyT55k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oAYigqb8KeTwupotPfR6RJHFQyPGiWPMzDsmkytqj8I8fzwaTceT2d+BiklN7zE4w
	 HFIVb2BJVzqf/fLs3qMHGfXZM/2mLS3F2KhiiiG+SFXTr1a9skg9JOqIc3e9xdqM9F
	 WMTcWQ3o+NNzCllSziU9IbHaf9Mhj6fWffb7G4JOM2iMMGPBojf82/fq36D/d6E2+Q
	 7V4phhorSYzS417XUE7IRE2AKC+HV/PFvgDNJsJwk8+BWgCuPtDscFQ9cm/6xbZ/xu
	 rn0ywb3yumq2NbqUWqsjhKV8FpCzYGnff8ZVHHhCHk8eAOncvAkHco2sj2EAVq3wiO
	 Zv9Od6N7qfapA==
Subject: Re: [PATCH net] net: hix5hd2: serialize timeout recovery with
 interface teardown
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: shenjian15@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ae878000@gmail.com
Date: Mon, 19 Oct 2026 02:29:26 +0000
Message-ID: <179237696641.3135.6340119087907839708@kernel.org>
In-Reply-To: <179203116093.2621539.3718842986255459438.G202@gmail.com>
References: <179203116093.2621539.3718842986255459438.G202@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In drivers/net/ethernet/hisilicon/hix5hd2_gmac.c,
  hix5hd2_tx_timeout_task() (lines 895-900) used to call…
- [Low] hix5hd2_tx_timeout_task() discards the return value of
  dev_open(priv->netdev, NULL)…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the sibling
  driver drivers/net/ethernet/hisilicon/hip04_eth.c has the same defect…
- [Medium] This problem wasn't introduced by this patch, but
  hix5hd2_dev_probe() registers the interrupt with devm_request_irq(dev,…
- [Medium] This problem wasn't introduced by this patch, but
  hix5hd2_free_dma_desc_rings() unmaps each outstanding tx_skb[i] using…

--

net: hix5hd2: serialize timeout recovery with interface teardown

This patch makes the hix5hd2 TX timeout worker take RTNL and skip recovery
when the interface is not running. It also replaces the driver's own
close/open calls with dev_close()/dev_open(). In hix5hd2_dev_remove(), it
moves cancel_work_sync() so the worker is drained before the MDIO bus and
descriptor queues are released.

> diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> index 02282dc86faf..12a5657653f8 100644
> --- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> +++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c

[ ... ]

> @@ -890,8 +891,13 @@ static void hix5hd2_tx_timeout_task(struct work_struct *work)
>  	struct hix5hd2_priv *priv;
>  
>  	priv = container_of(work, struct hix5hd2_priv, tx_timeout_task);
> -	hix5hd2_net_close(priv->netdev);
> -	hix5hd2_net_open(priv->netdev);
> +
> +	rtnl_lock();
> +	if (netif_running(priv->netdev)) {
> +		dev_close(priv->netdev);
> +		dev_open(priv->netdev, NULL);

[Severity: High]
Does switching to dev_close()/dev_open() make every TX timeout a full
administrative down/up of the interface?

Before this patch, the worker only re-initialised the MAC, PHY and DMA
through hix5hd2_net_close()/hix5hd2_net_open(). Now the path is:

hix5hd2_tx_timeout_task()
  dev_close()
    netif_close()
      netif_close_many()
        rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_UP | IFF_RUNNING, ...);
        call_netdevice_notifiers(NETDEV_DOWN, dev);

On NETDEV_DOWN, fib_netdev_event() does:

	case NETDEV_DOWN:
		fib_disable_ip(dev, event, false);

That flushes IPv4 routes whose nexthops use this device, including static
and DHCP-installed default routes.

addrconf_notify() also calls addrconf_ifdown(dev, event != NETDEV_DOWN).
Unless keep_addr_on_down is set, this removes every IPv6 address on the
device, including manually configured permanent ones. Neighbour entries
are flushed too, and bond/bridge/VLAN upper devices see the port go
administratively down.

The NETDEV_UP from dev_open() only restores what the kernel derives on its
own: prefix and local routes for addresses that are still present, and
auto-generated link-local addresses. Static routes and manually configured
global IPv6 addresses are not restored.

Could one transient TX stall then leave a statically configured host
without its default route or its global IPv6 addresses?

The commit message gives one reason for the switch, "so a failed reopen
leaves the interface down". It doesn't mention this change in what the
stack and user space see. With the Fixes: tag, the change is likely to go
to stable.

hbg_err_reset() in the hibmcge driver does use dev_close()/dev_open() for
resets. In this driver, though, the previous recovery path left L3 state
alone.

Would it work to keep the RTNL lock and the netif_running() check, keep
calling the driver-internal stop/start helpers, and handle a failed
reopen inside the driver?

[Severity: Low]
The return value of dev_open() is discarded here, and extack is NULL.
Since dev_close() has already cleared IFF_UP, a failed reopen leaves the
interface down.

Some failure paths in hix5hd2_net_open() don't log anything:

	phy = of_phy_connect(dev, priv->phy_node,
			     &hix5hd2_adjust_link, 0, priv->phy_mode);
	if (!phy) {
		clk_disable_unprepare(priv->mac_ifc_clk);
		clk_disable_unprepare(priv->mac_core_clk);
		return -ENODEV;
	}

of_phy_connect() can fail without a message. For example, phy_init_hw()
can fail on MDIO timeouts, which is plausible while the hardware is
stalled. Errors from NETDEV_PRE_UP and other netif_open() failures are
also lost because extack is NULL.

Would a netdev_err() on dev_open() failure help here? Then a TX timeout
that leaves the interface down would at least log why.

[Severity: Medium]
This is a pre-existing issue, but this recovery path runs the close path
while TX entries are still pending. Is hix5hd2_free_dma_desc_rings()
unmapping the right addresses in that case?

	desc = priv->tx_rq.desc + i;
	addr = le32_to_cpu(desc->buff_addr);
	dma_unmap_single(priv->dev, addr, skb->len, DMA_TO_DEVICE);

hix5hd2_net_xmit() records the mapping in the submission ring instead:

	desc = priv->tx_bq.desc + pos;
	...
	desc->buff_addr = cpu_to_le32(addr);

tx_rq is the completion ring. For entries the hardware hasn't completed,
tx_rq.desc[i] holds either zero or a stale address from an earlier packet
that hix5hd2_xmit_reclaim() already unmapped. The real mapping is never
unmapped.

For SG skbs, buff_addr is the coherent sg_desc address:

	addr = priv->tx_ring.phys_addr + pos * sizeof(struct sg_desc);

So on close, neither the linear mapping nor the per-frag mappings created
by hix5hd2_fill_sg_desc() are unmapped. hix5hd2_xmit_reclaim(), by
contrast, handles these through hix5hd2_clean_sg_desc().

With an IOMMU or swiotlb, could each close leak IOVAs or bounce slots,
and release a stale one twice?

> +	}
> +	rtnl_unlock();
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the sibling driver
drivers/net/ethernet/hisilicon/hip04_eth.c seems to have the same problem
this patch fixes:

static void hip04_tx_timeout_task(struct work_struct *work)
{
	struct hip04_priv *priv;

	priv = container_of(work, struct hip04_priv, tx_timeout_task);
	hip04_mac_stop(priv->ndev);
	hip04_mac_open(priv->ndev);
}

The worker takes no RTNL and doesn't check netif_running(), and
hip04_mac_stop() always calls napi_disable(&priv->napi).

Suppose the interface is brought down after hip04_timeout() queues the
work but before the work runs. Can the worker's second napi_disable() then
wait forever? hip04_remove() would then hang in
cancel_work_sync(&priv->tx_timeout_task).

If the interface is brought back up instead, napi_enable() in ndo_open
frees the stuck worker. It then runs hip04_mac_stop()/hip04_mac_open() on a
running interface, at the same time as RTNL-protected operations.

Does hip04_eth.c need a similar fix?

> @@ -1283,6 +1289,7 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
>  	struct hix5hd2_priv *priv = netdev_priv(ndev);
>  
>  	unregister_netdev(ndev);
> +	cancel_work_sync(&priv->tx_timeout_task);
>  	mdiobus_unregister(priv->bus);
>  	mdiobus_free(priv->bus);
>  
> @@ -1290,7 +1297,6 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
>  		hix5hd2_destroy_sg_desc_queue(priv);
>  	hix5hd2_destroy_hw_desc_queue(priv);
>  	of_node_put(priv->phy_node);
> -	cancel_work_sync(&priv->tx_timeout_task);
>  	free_netdev(ndev);
>  }

[Severity: Medium]
This is a pre-existing issue, but free_netdev() here runs before the
managed IRQ is released, doesn't it?

hix5hd2_dev_probe() requests the interrupt with ndev as dev_id:

	ret = devm_request_irq(dev, ndev->irq, hix5hd2_interrupt,
			       0, pdev->name, ndev);

devres frees that IRQ only after hix5hd2_dev_remove() returns, but ndev
is freed explicitly above. hix5hd2_interrupt() dereferences it straight
away:

	struct net_device *dev = (struct net_device *)dev_id;
	struct hix5hd2_priv *priv = netdev_priv(dev);
	int ints = readl_relaxed(priv->base + RAW_PMU_INT);

If an interrupt arrives in that window, would the handler read
priv->base and use priv->napi in freed memory? The probe error unwind has
the same ordering once the IRQ has been requested.

The IRQ isn't shared and ndo_stop masks interrupts, so hitting this needs
a spurious or still in-flight interrupt. Moving cancel_work_sync() in this
patch doesn't affect it. The separate remove-path change noted below the
cut line (https://lkml.iu.edu/2610.0/05627.html) may be relevant here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179203116093.2621539.3718842986255459438.G202%40gmail.com
