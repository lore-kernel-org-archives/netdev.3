Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BC384223
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830739; cv=none; b=hZnELI4DXcAMxOm+wFQADj+g9pOVFRf05eBi0eQ3wlzDzaBkCwNOkehHL8PJ5DC6CY0FPpSWftHaTOMoFmxHv34R26hO4GOTs8q5ow9Z+ThexqlbOuNjX7HHUB1n2hB/JVjslZr5D2gfz39wtVLn/S7u4TuhKAiA1+xCLkrfFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830739; c=relaxed/simple;
	bh=0xUAR/oT7tiSr88DFF6QIpwP1+Vn7NtKjs/ZUrI4J98=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GtQTBqI40GWfXNFcGULeKXzjdUs/EsUiqPMJQeSeADrYJxgG/vuGf4o+MZGs7koYKvVDa8kc/2PmKC2HU5U+V6bLo+jEANL5rhT/5mOM1cxN4mU2Ph7G+rmOw959MNQGE/a9Dkw8dat3A2X61sxIEKOTNTzUnWYLf0G03S1w8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6OLC0wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6OLC0wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFFF1F008A5;
	Mon, 12 Oct 2026 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830735;
	bh=DGrdhb5y9zUZo2Hw84jzgdRN0BVMsPmcQSDyWjpeuTw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V6OLC0wvRZ/SGOC4KJyoAwd9o+xUEYzUTUn0R5mfU/PdH+t9XV/k6JULwnHLdCU0e
	 LLrifsuuOW0z058QpGQ8GVN0FS7UcNllhzSYOyJSoH8P12suPvbSovuKpZSOT28YHg
	 vqVB4bFsgRySDH5SxtFEWp7JXN/jYosVU6rQE8c20Zkjh8jJ/1M51TggITeFfcRlwt
	 bMv5kjvYfeFJhtSA/qKZlFW4snSjYHVXiDuFdfrvFIYmKtvPK0A/dU3Chr+ssAQ2DP
	 sLspKwmXugW440ALepvOZHTcSapFSE6hn7KvUA/UsvZ1Iq5i3ilCgglFChupSpHo3p
	 g8i5iQyHeMYQg==
Subject: Re: [PATCH net-next v4 08/15] net: ethernet: cortina: Rebuild free
 queue metadata for RX ring changes
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:34 +0000
Message-ID: <179183073445.434549.4156334302029834248@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-8-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-8-4b1631b08f5d@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes a regression from an earlier patch in the same
  series, but it has no Fixes: tag and does not say where that…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  gmac_set_ringparam() rounds rx_pending/tx_pending up to a power of two…

--

net: ethernet: cortina: Rebuild free queue metadata for RX ring changes

This commit adds geth_freeq_page_slots(), which computes how much free
queue metadata is needed. The geth_resize_freeq() fast path now uses it,
so an RX ring change that keeps the same free queue order no longer keeps
an undersized metadata pool. gmac_open() now fails when geth_resize_freeq()
returns any error, and gmac_set_ringparam() restores the old rxq_order if
the resize fails.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 284823bdfd50c..cd5ded7384a51 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1234,8 +1244,16 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	if (new_order <= PAGE_SHIFT - geth->freeq_frag_order)
>  		return -EINVAL;
>  
> -	if (geth->freeq_ring && geth->freeq_order == new_order)
> -		return 0;
> +	if (geth->freeq_ring) {
> +		page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
> +		if (geth->num_freeq_pages >= page_slots &&
> +		    (geth->freeq_order == new_order ||
> +		     (other_running && geth->freeq_order > new_order)))
> +			return 0;
> +	}
> +
> +	if (other_running)
> +		return -EBUSY;

[Severity: Medium]
The code change looks right to me. Should this patch carry Fixes: tags,
though, or should the fast path part go into the earlier patch?

The undersized pool comes from the previous patch in this series, "net:
ethernet: cortina: Preserve in-flight free queue pages". That patch sizes
freeq_pages and the bitmaps as the free queue pages plus
(1 << port0->rxq_order) plus (1 << port1->rxq_order). But it keeps the
fast path that only checks the order:

	if (geth->freeq_ring && geth->freeq_order == new_order)
		return 0;

With only that patch applied, raising an RX ring without changing the
computed freeq order keeps the old, smaller pool. For example, take a port
whose rxq_order goes from 8 to 9 while the other port stays at 10. new_size
goes from 2560 to 3072, but new_order is 12 both times. The same thing
happens once new_order hits the cap of 15.

geth_freeq_alloc_slot() then returns -ENOSPC and geth_fill_freeq() stops
refilling early.

"Preserve in-flight free queue pages" carries a Fixes: 4d5ae32f5e1e tag,
which makes it a stable candidate. Could a stable kernel take it without
this untagged follow-up and end up with the undersized pool after
ethtool -G rx N? It also leaves a bisect window between the two patches.

The other two changes here fix behavior that goes back to the original
driver (4d5ae32f5e1e): gmac_set_ringparam() leaving the new rxq_order
installed after a failed resize, and gmac_open() accepting -EBUSY.

Could the fast path change be folded into "Preserve in-flight free queue
pages"? If not, could this patch get Fixes: tags so backporters keep the
two together?

[ ... ]

> @@ -2376,14 +2391,20 @@ static int gmac_set_ringparam(struct net_device *netdev,
>  			      struct netlink_ext_ack *extack)
>  {
>  	struct gemini_ethernet_port *port = netdev_priv(netdev);
> +	unsigned int old_rxq_order;
>  	int err = 0;
>  
>  	if (netif_running(netdev))
>  		return -EBUSY;
>  
>  	if (rp->rx_pending) {
> +		old_rxq_order = port->rxq_order;
>  		port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);

[Severity: Low]
This isn't a bug introduced by this patch, but gmac_set_ringparam() rounds
rx_pending up to a power of two and never writes the applied size back
into rp. include/linux/ethtool.h says:

 * @set_ringparam: Set ring sizes. The &struct ethtool_ringparam argument is
 *	also an output; drivers which normalize requested sizes must update it
 *	with the applied sizes.

After the callback returns, ethnl_set_rings() in net/ethtool/rings.c picks
up the driver's adjustments:

	ethtool_ringparam_set_cfg(dev->cfg_pending, &ringparam);

So a request for rx 300 stores 300 in cfg_pending, while the driver
actually uses 512 (rxq_order 9).

Should rp->rx_pending be set to 1 << port->rxq_order once the resize
succeeds? tx_pending is rounded the same way further down, so it could be
updated too.

>  		err = geth_resize_freeq(port);
> +		if (err) {
> +			port->rxq_order = old_rxq_order;
> +			return err;
> +		}
>  	}
>  	if (rp->tx_pending) {
>  		port->txq_order = min(15, ilog2(rp->tx_pending - 1) + 1);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
