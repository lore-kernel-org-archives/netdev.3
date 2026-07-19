Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F581347C5;
	Sun, 19 Jul 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458416; cv=none; b=dXi/qWo+s53Pf+ggMWfX6xgAKuWe9PmdrJmPk7FJmAA1SHqdhS2edEWk//VyIrEb45XvrdOoJ5dsC4//fSH+XkX0jVv39skJRUzlI9y5t/2B/6q2m07+fLD4Ie3+sMbe+47i8TE+LlRGDmDqk+1vxc9MHgULbDXrA9TsYzzcITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458416; c=relaxed/simple;
	bh=YGEazFIrGT/VpeToepKfs778xpaRjiZ9+Sva2iioD+Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=reRm4KO/AT5s+qW3VuiL9itkcnsXS2j7mDUb3VDVnbluJ3zaniV/bD8ilDXRkBXRRDplAcQYerqLsGHmXeludm4tOlsM0wYURa87M9+jX31Mt/bc3d/IGpEzkCDCTG1Ex4TLXty+2FTFcF6N7fEdxxc/pfCedPyMXOgwh346WWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=AEvqezzC; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="AEvqezzC"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E72DA0292;
	Sun, 19 Jul 2026 12:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784458412; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YF9fV7bCEO9HdEc94h+7cPm3p4Ue0YkXnFcoaE08TDk=;
	b=AEvqezzCPLo2bM7S2YOo01pOCKlaIR7Y7TuIV/PrYA2vPO4KTXnc6Pf0QfKUNCB5eneA+n
	xdkMBa1+s2V1T1G+tWRx3iFlPMlKzRBEocWxLi/XKs6OTqH7ndDZHuW9JNZ+HnfInafKHS
	w1zhCBftWPA6HY576YrkRVriY8JmzXKqrSAXa49QUEmpqCC5mDVf6NpmA5aceOT7bOMk2x
	Rbu4GJdmCWXMu2kWC7JAjqSFy0g9VDAof2AUSsZhRHTs5DlFRbwuOq951s+xytstY9HnUJ
	QKsNNfkXDjSFgiHO1DipEsqyfhmGy6vFJTcSbGOtrqaOHlR9yOQayK2y+EqyoQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:53:31 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 14/15] net: macb: use context swapping in
 .set_ringparam()
In-Reply-To: <20260717-macb-context-v4-14-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-14-0acbe7f10cdb@bootlin.com>
Message-ID: <ca25adb833a2dc5031434ebe33c3b8eb@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 17.7.2026 21:48, Théo Lebrun wrote:
> ethtool_ops.set_ringparam() is implemented using the primitive close /
> update ring size / reopen sequence. Under memory pressure this does not
> fly: we free our buffers at close and cannot reallocate new ones at
> open. Also, it triggers a slow PHY reinit.
> 
> Instead, exploit the new context mechanism and improve our sequence to:
>  - allocate a new context (including buffers) first
>  - if it fails, early return without any impact to the interface
>  - stop interface
>  - update global state (bp, netdev, etc)
>  - pass buffer pointers to the hardware
>  - start interface
>  - free old context.
> 
> The HW disable sequence is inspired by macb_reset_hw() but avoids
> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
> 
> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
> over register writes which would be redundant (because values have not
> changed).
> 
> The generic context swapping parts are isolated into helper functions
> macb_context_swap_start|end(), reusable by other operations 
> (change_mtu,
> set_channels, etc).
> 
> Introduce a new locking primitive (mac_cfg_lock mutex) to serialise 
> swap
> with phylink MAC callbacks. Avoid stopping phylink to avoid a slow PHY
> retrain. Those callbacks grab phydev->lock if it exists so we could
> imagine grabbing that from the swap op, but phydev->lock doesn't exist
> in the SFP case.
> 
> AT91 EMAC is handled differently as their buffer management is separate
> and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
> context swapping for them.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   5 +
>  drivers/net/ethernet/cadence/macb_main.c | 162 
> +++++++++++++++++++++++++++++--
>  2 files changed, 158 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index ac2f2d8065d7..93e513cf1fbb 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1361,6 +1361,8 @@ struct macb {
>  	struct macb_queue	queues[MACB_MAX_QUEUES];
> 
>  	spinlock_t		lock;
> +	/* Serializes context swap against phylink MAC callbacks. */
> +	struct mutex		mac_cfg_lock;
>  	struct clk		*pclk;
>  	struct clk		*hclk;
>  	struct clk		*tx_clk;
> @@ -1421,6 +1423,9 @@ struct macb {
>  	struct delayed_work	tx_lpi_work;
>  	u32			tx_lpi_timer;
> 
> +	/* ISR must not drive NAPI & BH mechanisms. Protected by bp->lock. */
> +	bool			ctx_swap;
> +
>  	u32	rx_intr_mask;
> 
>  	struct macb_pm_data pm_data;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index c832b6c1b98c..5792647eb0a6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

> [...]

> +
> +	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> +		/* Must be done before NAPI is disabled. */
> +		cancel_work_sync(&queue->tx_error_task);
> +
> +		napi_disable(&queue->napi_rx);
> +		napi_disable(&queue->napi_tx);
> +		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
> +	}
> +
> +	/* Must be done after napi_tx is disabled. */
> +	cancel_delayed_work_sync(&bp->tx_lpi_work);
> +
> +	/* Can finally disable software Tx; need to wait until napi_tx and
> +	 * tx_error_task cannot be scheduled as either might wakeup Tx.
> +	 */
> +	netif_tx_disable(bp->netdev);

Shouldn't netdev_tx_reset_queue() come after netif_tx_disable()? Tx is
still running here, so an xmit right after the reset adds bytes to the
DQL that never get completed (macb_free() frees the old skbs without
netdev_tx_completed_queue()). Not sure, but that could leave the queue
stopped by BQL forever?

> [...]

Thanks
Nicolai
