Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D44A263B
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307152; cv=none; b=rj4RxnvlwmzjsnvhnBNL9lgwxtt2ufUe2XKikV+ocMsk0kv+VtTTWhaDGB+8Qo9pNPrs8uUG8AbKFpMI0eOJWIGS+bdFh9ae6S43hun/neNlrmicFwNwFsq1BTF3k/BPcDVDWCDvHmoUMcVh5lHT8EQgnn7Zzb0z4ldZAWJFR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307152; c=relaxed/simple;
	bh=77QdhTukApkWCNqlmIRVmhZ2IYxGnK1mAZGI4i9Fm9U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9j++QEZL19rak8w34suF0dkg/PuWHakZl0AC9BUThuYRWt3TAOYEFWmag0p5keVxH1HXmBBv5v4eIUF5h3kLABncpfMLvH5P1hbHUIkZtIdGNxnBWwDzIGwV3OvnEti/Gj2iPLWtl7OFGyWeBTMlFOHVf20AFf+GeRLoeOlRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW9Dydaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW9Dydaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FCA1F0089C;
	Tue,  6 Oct 2026 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307150;
	bh=HuGTdOHbbNNgKa7jgCRZaaVTLxKCxLUVQvCqOos0S9U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HW9Dydaw9yk3AQM0l1ZGRViAre5ItLqELzX0oO33ARaqpWe9peqJskT7Fwb4zAk9r
	 GIrzfZLJ6fzmVJtS+kIIZCT0uEY357cUnvuDHNF20H5Q8kQUNaPUXIU36+kYMx/93a
	 4MgGo76iUrdO2moZVQeyQPv8HdMPBQORXTFI3ZJK1e2F5A9lu7/DD7X98CCJBIGesl
	 spvR0bK+f4weAue4NeN/FP2EoewHlIYzbEpzaKfCflFPpvBr7voiOgIkhaA9c27O20
	 fmjN3jUX2zt8GpfvZi/rsUAIU2QgaC9n2IuiTicPaBa1DFxlgC1j/mEA+HyhYKQefJ
	 7Xhm8/SdZPj4g==
Subject: Re: [PATCH net-next v3 07/12] net: ethernet: cortina: Rebuild free
 queue metadata for RX ring changes
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:09 +0000
Message-ID: <179130714937.434549.3960553240621666752@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-7-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-7-3e1f25890ae8@kernel.org>
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

Critical: 0 · High: 0 · Medium: 3 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag blames the wrong commit, and the main defect
  comes from the patch just before this one in the same series.
- [Medium] In geth_resize_freeq(), the fast path changed from
  `freeq_order == new_order` to `freeq_order >= new_order &&…
- [Medium] geth_freeq_page_slots() and geth_resize_freeq() count a port's
  RX ring whenever `geth->portN && geth->portN->netdev` is set.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  geth_resize_freeq() and the new geth_freeq_page_slots() read and…
- [Low] This problem wasn't introduced by this patch, but the kernel-doc
  of geth_resize_freeq() says it "gets called at least once during…

--

net: ethernet: cortina: Rebuild free queue metadata for RX ring changes

This patch moves the free queue metadata slot calculation into a new
helper, geth_freeq_page_slots(), and uses it in the geth_resize_freeq()
fast path. The check for the other port running now comes after that
fast path. gmac_open() no longer accepts -EBUSY, and
gmac_set_ringparam() puts the old rxq_order back if the resize fails.

> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

[Severity: Medium]
Is this the right Fixes: target? The commit message describes a metadata
pool "sized for the old RX rings", but no such pool exists in 4d5ae32f5e1e.

The previous patch in this series, "net: ethernet: cortina: Preserve
in-flight free queue pages", added page_slots sizing of freeq_pages and
freeq_page_bitmap based on port0/port1 rxq_order. Before that patch,
num_freeq_pages was simply pages and depended only on freeq_order.

That patch did not change this fast path in geth_resize_freeq():

    if (geth->freeq_ring && geth->freeq_order == new_order)
        return 0;

So the regression covers the commits from that patch up to this one.

For example, port0 rxq_order 9 and port1 rxq_order 8 give freeq_order 11
and 1792 slots. Raising port1 to order 9 keeps order 11 but needs 2048
slots. geth_freeq_alloc_slot() then returns -ENOSPC and refill stalls.

Could the metadata capacity part be squashed into "Preserve in-flight free
queue pages", or could the Fixes: tag point at that commit? The rxq_order
rollback in gmac_set_ringparam() and the -EBUSY change in gmac_open() do go
back to the original driver.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 660e51634017b..2345d582cb597 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1066,21 +1066,31 @@ static void geth_freeq_release_pages(struct gemini_ethernet *geth)
>  	xa_destroy(&geth->freeq_mappings);
>  }
>  
> +static unsigned int
> +geth_freeq_page_slots(struct gemini_ethernet *geth, unsigned int order)
> +{
> +	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> +	unsigned int slots = 1 << (order - fpp_order);
> +
> +	if (geth->port0 && geth->port0->netdev)
> +		slots += 1 << geth->port0->rxq_order;
> +	if (geth->port1 && geth->port1->netdev)
> +		slots += 1 << geth->port1->rxq_order;

[Severity: Medium]
Can port->rxq_order still be 0 here even though port->netdev is set?

rxq_order is only set in gmac_init():

	port->rxq_order = DEFAULT_GMAC_RXQ_ORDER;

gmac_init() runs as .ndo_init from register_netdev() at the end of
gemini_ethernet_port_probe(). Before that point, probe has already set
port->netdev and published the port:

	geth->port1 = port;

It then requests the IRQ and sets up the PHY, which may hit
-EPROBE_DEFER, and only after that calls register_netdev().

If eth0 (rxq_order 9) is opened in that window while port1's rxq_order is
still 0, geth_setup_freeq() records num_freeq_pages = 1024 + 512 + 1 =
1537.

Once port1 registers with rxq_order 9, opening eth1 computes new_order 11
and page_slots = 1024 + 512 + 512 = 2048. The fast path check fails, and
because eth0 is running, geth_resize_freeq() returns -EBUSY. gmac_open()
now treats that as fatal:

	err = geth_resize_freeq(port);
	if (err) {
		netdev_err(netdev, "could not resize freeq\n");
		goto err_stop_phy;
	}

So eth1 fails to open every time until eth0 is brought down. Before this
patch, the order-only fast path returned 0 in this case.

Would checking that the netdev is registered, or setting rxq_order before
the port is published, avoid this?

> +
> +	return slots;
> +}
> +

[ ... ]

> @@ -1206,9 +1217,6 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  		other_port = geth->port0;
>  	other_netdev = other_port ? other_port->netdev : NULL;
>  
> -	if (other_netdev && netif_running(other_netdev))
> -		return -EBUSY;
> -
>  	new_size = 1 << (port->rxq_order + 1);

[ ... ]

> @@ -1225,8 +1233,15 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	new_order = min(15, ilog2(new_size - 1) + 1);
>  	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
>  		new_size, new_order);
> -	if (geth->freeq_ring && geth->freeq_order == new_order)
> -		return 0;
> +	if (geth->freeq_ring) {
> +		page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
> +		if (geth->freeq_order >= new_order &&
> +		    geth->num_freeq_pages >= page_slots)
> +			return 0;
> +	}
> +
> +	if (other_netdev && netif_running(other_netdev))
> +		return -EBUSY;

[Severity: Medium]
Does this mean the shared free queue can now only grow?

The >= shortcut runs before the other-port-running check, so it is taken
even when both ports are down.

Suppose rx_pending is lowered with ethtool -G while both interfaces are
down. gmac_set_ringparam() calls geth_resize_freeq(), and new_order ends
up <= freeq_order. page_slots, computed with the smaller rxq_order, is <=
num_freeq_pages. The function returns 0 and keeps the larger ring and all
the pages posted to it.

Before this patch, the order mismatch forced a rebuild at the smaller
order when the other port was idle.

gmac_stop() does not free the freeq, and geth_cleanup_freeq() is otherwise
only reached from gemini_ethernet_remove(). The memory stays pinned until
unbind, which at order 14 is about 32 MiB of 2 KiB fragments.

The commit message also says:

  "Return success while another port is running only when the existing
  queue is large enough."

The code takes the >= path whether or not the other port is running.
Should the >= case apply only when other_netdev is running, with the exact
order match kept otherwise?

[Severity: Low]
This isn't a bug introduced by this patch, but since the fast path is
being rewritten here: the kernel-doc of geth_resize_freeq() says:

 * This gets called at least once during probe() so the device queue gets
 * "resized" from the hardware defaults.

gemini_ethernet_init() has a matching comment:

	/* This makes the queue resize on probe() so that we
	 * set up and enable the queue IRQ. FIXME: fragile.
	 */
	geth->freeq_order = 1;

geth_resize_freeq() is only called from gmac_open() and
gmac_set_ringparam(); nothing in probe calls it. The fast path is also
gated on geth->freeq_ring, so the freeq_order = 1 sentinel is never
read. Could these comments be updated?

>  
>  	disable_irq(geth->port1->irq);

[Severity: Medium]
This is a pre-existing issue, but the new helper adds more unsynchronized
reads of geth->port0 and geth->port1. geth_resize_freeq() checks
geth->port1 once:

	if (!geth->port1)
		return -ENODEV;

It then dereferences geth->port1 again in several places:
disable_irq(geth->port1->irq), geth_freeq_page_slots(), and
enable_irq(geth->port1->irq) after geth_setup_freeq().

On the removal side, gemini_port_remove() calls unregister_netdev(), which
releases RTNL. gemini_port_clear() then does geth->port1 = NULL without
any lock shared with the open or ethtool paths, and devres frees the
netdev that contains the port.

The child driver doesn't set suppress_bind_attrs. Can a sysfs unbind of
port1 racing with "ip link set eth0 up" cause a NULL dereference at
enable_irq(geth->port1->irq)? Could it also read other_port->rxq_order or
other_port->netdev after they have been freed?

>  	geth_set_freeq_irq(geth, false);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
