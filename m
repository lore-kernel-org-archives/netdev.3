Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0137AA9E;
	Fri,  9 Oct 2026 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533347; cv=none; b=MFT0U6nKuQTBnhG9AOkaNHbPy3KdaKroUXWeNUAwequeV+SdKPp7GRRBcCPYz7rJgn9rcT1nu8uQHLXAHxp850RS9rrIZWnCOjkyXK1gJ1mli3dEgoHzKVG5H93kosR2WZECctKlwNAAq1GvhGgykEc1C4mUKjG1Po8ZdSyEjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533347; c=relaxed/simple;
	bh=YqCj2DI45rBAiCTfBWTa8ZEjISoBAV0jHOtCtO+LHRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS0ttkMeq4zm2YmJSLmAa+piaCYzQfSjNspGcELYcd3SaZfE1Qo5Zc5WnLX3BdSTJ7v30IPQR6CwMseEOgNXFZzIYRKhkTPXklwEOLVkcNfACnnW8C7lQpWVQwMw9jWAcCQKF2h4TMSZI7MR9XBdJkaumnu9mT/VwWuFak+H8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UqPzd8aB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UqPzd8aB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791533339; x=1823069339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YqCj2DI45rBAiCTfBWTa8ZEjISoBAV0jHOtCtO+LHRQ=;
  b=UqPzd8aBy8NXZI+M86dO/gZUwhbF9gDnB9DsUx1TMEWM0OBd+yLYgm/r
   n+arK2euNP7kK70kKngZPgkMP+EzxUuHV1xlX7QXdqG6oSLM0PizIOQgE
   HQDRqU6AE5gPqv3FnRRlwCXALW/5SRY/jeRlg5e+RFm5wi7QbPPVpxZSJ
   8m37APXdsvMos/dIVGCZg00FxdPqu1/8122DlF26+3nR0jDbhwEIrwjvG
   6EYThRS1lKaHyK8FTzh9B0qLqyPqI24UxA5DZ2NogwZ6Nd0q/0OyOYCTg
   nAmaHRkNB4rHSj1bUNCsPzWlbEE1Lg89Z5wLnqECtmxWQa0mM05U9nlMQ
   Q==;
X-CSE-ConnectionGUID: dIsZ+WLRTeKwVkIRWHtgXQ==
X-CSE-MsgGUID: vZlShO7RSgiWPTorujsFvg==
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="75117816"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:08:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 9 Oct 2026 01:08:51 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 9 Oct 2026 01:08:49 -0700
Date: Fri, 9 Oct 2026 10:08:48 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Kusuma Vasana <kusuma.vasana@amd.com>
CC: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <git@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V4] net: axienet: Clear stale AXI DMA TX/RX
 status before re-enabling interrupts
Message-ID: <20261009080848.peze77mpvcub5wqv@DEN-DL-M70577.microsemi.net>
References: <20261005090106.1594994-1-kusuma.vasana@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261005090106.1594994-1-kusuma.vasana@amd.com>

Hi Kusuma,

A few comments:

> The AXI DMA interrupt line is level-sensitive: it asserts whenever
> the IOC (XAXIDMA_IRQ_IOC_MASK) or DELAY (XAXIDMA_IRQ_DELAY_MASK) bits
> in the status register (XAXIDMA_TX_SR_OFFSET / XAXIDMA_RX_SR_OFFSET)
> are set and their corresponding enable bits in the control register
> are active.
> 
> During TX/RX, interrupts are disabled in the control register while
> NAPI runs. Completions arriving in this window cause hardware to latch
> IOC/DELAY into the status register regardless of the control register
> mask state. After NAPI completion, re-enabling interrupts immediately
> re-asserts the IRQ line due to these stale status register bits, even
> when no new work is pending.
> 
> This results in a stale interrupt and redundant NAPI poll cycle with
> no new work pending, causing unnecessary CPU processing.
> 
> In the initial driver, the status register was cleared after polling
> all packets, which naturally consumed any status accumulated during
> processing. In later versions of the driver, status register clearing
> was moved to the ISR before polling begins, leaving no mechanism to
> clear status bits that arrive during the NAPI poll window.
> 
> Clear the status register IOC/DELAY bits before re-enabling interrupts
> and recheck the next BD to catch race-window completions. Both are
> skipped on budget exhaustion. On the RX side, both are additionally
> skipped on refill failure.
> 
> Signed-off-by: Kusuma Vasana <kusuma.vasana@amd.com>
> ---
> Changes in v4:
> - Read back SR after W1C so the clear is posted before the BD recheck.
> - Document that poll may return @budget on that recheck.
> - Drop the incorrect "leave IRQ armed" wording for RX refill failure.
> 
> Changes in v3:
> - Updated the commit description.
> - Restricted TX/RX status-register clear and completion recheck to the
>   NAPI completion path, with RX only when refill succeeds.
> - Rechecked descriptor completion after status-register clear to handle
>   race-window completions.
> 
> Changes in v2:
> -Added net-next prefix in the subject
> -Updated the commit description
> 
> ---
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index fcf517069d16..4d8169fc39cd 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -986,7 +986,8 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
>   * @napi:      Pointer to NAPI structure.
>   * @budget:    Max number of TX packets to process.
>   *
> - * Return: Number of TX packets processed.
> + * Return: Number of TX packets processed, or @budget to continue polling
> + * after a post-clear completion recheck.
>   *
>   * This function is invoked from the NAPI processing to notify the completion
>   * of transmit operation. It clears fields in the corresponding Tx BDs and
> @@ -1018,6 +1019,17 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>                         netif_wake_queue(ndev);
>         }
> 
> +       /* Clear stale IOC/DELAY bits, flush the clear, and re-check for
> +        * race-window completions. Skipped on budget exhaustion.
> +        */
> +       if (packets < budget) {
> +               axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET,
> +                                 XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> +               axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
> +               if (lp->tx_bd_v[lp->tx_bd_ci].status & XAXIDMA_BD_STS_COMPLETE_MASK)
> +                       return budget;
> +       }
> +

The patch does not apply on my tree.

This part was reworked in f9d58127380a ("net: axienet: do not report TX
completions as NAPI work") to not return budget-sized work, it now just returns
0.

>         if (packets < budget && napi_complete_done(napi, packets)) {
>                 /* Re-enable TX completion interrupts. This should
>                  * cause an immediate interrupt if any TX packets are
> @@ -1204,7 +1216,8 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>   * @napi:      Pointer to NAPI structure.
>   * @budget:    Max number of RX packets to process.
>   *
> - * Return: Number of RX packets processed.
> + * Return: Number of RX packets processed, or @budget to continue polling
> + * after a post-clear completion recheck.
>   */
>  static int axienet_rx_poll(struct napi_struct *napi, int budget)
>  {
> @@ -1301,6 +1314,18 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
>         if (tail_p)
>                 axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
> 
> +       /* Clear stale IOC/DELAY bits, flush the clear, and re-check for
> +        * race-window completions. Skipped on budget exhaustion and on
> +        * refill failure (cur_p->skb == NULL).
> +        */
> +       if (packets < budget && cur_p->skb) {
> +               axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET,
> +                                 XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> +               axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
> +               if (cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK)
> +                       return budget;
> +       }
> +
>         if (packets < budget && napi_complete_done(napi, packets)) {
>                 if (READ_ONCE(lp->rx_dim_enabled)) {
>

I think the RX side looks good.

>struct dim_sample sample = {
> --
> 2.43.0
> 
> 

/Daniel
