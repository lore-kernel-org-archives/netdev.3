Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322814;
	b=tY0NUlqN4hkMDoUWv4q9/dSOFYbj+OQmvOkkpN6aXUxj6jRjVxiMFXdmwtYEBBfBHu1z
	 Uum3Ux4SXRoqef3/0uMtNOEPSSRgEVBjKeHEfbT1sv2pJdE+xv2eSJBgxEgd0haQ5mMP+
	 y0D5rq/ZPvv+2nW08P4ljrj+0cq5b7vWIjGvi2w8ltkbRCzlPrH8OiRK9fCZlpF8siNS2
	 O4l8PyQGMrOgLAIlk0MJbeqCDU324xQp0c/B6uXdQnxqC738ay1/nMezhlqqqfPAxC4iS
	 icVi/MlpkqE2AjRlBtqXvE9oRjyybjg47xCPv5k5fUL27jq8nGI5rVV8CUS1ajiJfww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322814;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NWbDXuMdgBu6j69IKRt2xG5uhI7J0aBn93nLNFInZYE=;
	b=IrcMgSC7l/ZKB2SpOBe1coQsaibSt1l7bfE6ZAyCbhj49UYR8JE70RJTQob+fESWdW/y
	 beONjuLeJa/YMKS9WUjx4ZEzP1YpaqD5DCzYapfr1lf2DhXm4YdmBBZU+D3w0SFbf+fzS
	 LOFzML2pUlfwzAHYMWWY3H4X5y6Prtw5DzNiyJgvCWNO2QECfOrFIwBWnonXLLrT+JHxE
	 V4Ok0gJ2USOLhQO0caapXwxqOtD5eCKx9w2he105l6vRXnJkSSe4G7TxpyJzAWdHqPWfU
	 57iLNmcyV/WkG380iXDNsMhvjdM2aYlpwFIok6NVcbaJ0i+Wd4xYCpo6zrCuPk0kNqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=z8luqVPi;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99360606A33B;
	Tue, 10 Nov 2026 15:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99360606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=z8luqVPi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794322813; x=1825858813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fJamJnudBxHh9vtC+9fJIZ1mUbVOyFbHiqJYrgy7T38=;
  b=z8luqVPic8yy0OlEWfkDzifSatntA7xW7bctLyPCUC7vQpYV5mM+FHBb
   FcfllDY/7l2A7bl44+QQduyM44hTcj9AuuD2T0clPcDFnHA/ZT7Zyn8rf
   Ic/ZEbH56kFeXdXPSmTTe1xU3L6vY4X7pW2/RVcJfXoQlFBHi2gLASY/E
   j50GZSfbnXC2EpGSy0pWc3Vff6S6/R9I0EQ1uViA5PP/kANcRK0wQfzz1
   Jd3om9eTs+91wJHq6AOxxwapKOnX///2AYMzjwE5rO4Fr6LiDACovhGGY
   bhrubq7cXnnaqG6/3ORHENWC+QAhBEyznk3lcEPs0B+7OBH8znvHFoa/4
   A==;
X-CSE-ConnectionGUID: czGyAmpsRqm+vSONHsZMKg==
X-CSE-MsgGUID: 3J81H9xXTrekv7ZQ5eXaFA==
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="65330202"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:00:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 10 Nov 2026 07:59:44 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 10 Nov 2026 07:59:42 -0700
Date: Tue, 10 Nov 2026 09:59:40 -0500
From: Charles Perry <charles.perry@microchip.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
CC: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <git@amd.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<charles.perry@microchip.com>
Subject: Re: [PATCH net-next v2 4/4] net: macb: Add TSN CBS TC offload support
Message-ID: <avMxXCDMQMh5180r@MON-LT-C78453.mchp-main.com>
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
 <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260909142056.1433875-5-vineeth.karumanchi@amd.com>

Hello Vineeth, 

On Wed, Sep 09, 2026 at 07:50:56PM +0530, Vineeth Karumanchi wrote:
> Add Credit-Based Shaper (CBS/IEEE 802.1Qav) TC offload support for
> time-sensitive networking on GEM hardware. CBS is restricted to the
> two highest-priority queues: Queue A (num_queues - 1) and Queue B
> (num_queues - 2), matching hardware capability.
> 
> Validate that idleslope is positive and does not exceed the link
> speed, preventing negative values from bypassing the bounds check
> due to signed-to-unsigned promotion.
> 
> The idle slope register value is computed differently based on hardware
> variant:
> 
>   High-speed GEM: scale idleslope linearly to the full 32-bit register
>   range relative to link speed.
> 
>   Standard MACB: convert the kbps idleslope into the register's native
>   unit, which depends on the interface width:
>     - 1G (8-bit GMII):    bytes/sec,   scale kbps by 1000/8 (125)
>     - 10/100M (4-bit MII): nibbles/sec, scale kbps by 1000/4 (250)
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
> Changes in v2:
> - macb_cbs_get_queue_params() now returns the idleslope register offset
>   (u32 *idleslope_reg) instead of a bool flag, and the idleslope is
>   programmed via bp->macb_reg_writel(), dropping the per-queue if/else
>   that open-coded gem_writel(CBS_IDLESLOPE_Q_A/Q_B).
> - Expanded the idleslope kbps-to-hardware-unit conversion comment.
> - Zero-initialize kset in macb_cbs_add() so an unpopulated link speed
>   reads as 0 and is rejected; reorder locals to keep the declarations
>   in reverse-christmas-tree order.
> - Rebased on net-next, which renamed the struct net_device pointer to
>   "netdev" (was "dev"/"ndev").
> 
>  drivers/net/ethernet/cadence/macb.h      |   9 ++
>  drivers/net/ethernet/cadence/macb_main.c | 116 +++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index f5359549f3d4..20faeba77d6d 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -184,6 +184,9 @@
>  #define GEM_DCFG8		0x029C /* Design Config 8 */
>  #define GEM_DCFG10		0x02A4 /* Design Config 10 */
>  #define GEM_DCFG12		0x02AC /* Design Config 12 */
> +#define GEM_CBS_CONTROL		0x04BC /* CBS Control Register */
> +#define GEM_CBS_IDLESLOPE_Q_A	0x04C0 /* CBS IdleSlope Queue A */
> +#define GEM_CBS_IDLESLOPE_Q_B	0x04C4 /* CBS IdleSlope Queue B */
>  #define GEM_ENST_CONTROL	0x0880 /* ENST control register */
>  #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
>  #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */
> @@ -224,6 +227,12 @@
>  #define GEM_ENST_ON_TIME(hw_q)		(0x0820 + ((hw_q) << 2))
>  #define GEM_ENST_OFF_TIME(hw_q)		(0x0840 + ((hw_q) << 2))
>  
> +/* Bitfields in CBS_CONTROL */
> +#define GEM_CBS_ENABLE_QUEUE_A_OFFSET	0
> +#define GEM_CBS_ENABLE_QUEUE_A_SIZE	1
> +#define GEM_CBS_ENABLE_QUEUE_B_OFFSET	1
> +#define GEM_CBS_ENABLE_QUEUE_B_SIZE	1
> +
>  /* Bitfields in ENST_CONTROL */
>  #define GEM_ENST_DISABLE_QUEUE_OFFSET	16
>  
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 67150ff03066..00c1c619dea8 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -99,6 +99,10 @@ struct sifive_fu540_macb_mgmt {
>  
>  #define MACB_MDIO_TIMEOUT	1000000 /* in usecs */
>  
> +/* CBS port transmit rate factors: 1000/interface_width */
> +#define MACB_CBS_PORT_RATE_1G		125	/* 1000/8 for GMII (8-bit) */
> +#define MACB_CBS_PORT_RATE_10_100M	250	/* 1000/4 for MII (4-bit) */
> +
>  /* DMA buffer descriptor might be different size
>   * depends on hardware configuration:
>   *
> @@ -4492,6 +4496,116 @@ static int macb_setup_taprio(struct net_device *netdev,
>  	return err;
>  }
>  
> +static int macb_cbs_get_queue_params(struct macb *bp, u8 queue_num,
> +				     u32 *enable_bit, u32 *idleslope_reg)
> +{
> +	/* Queue A is highest priority (num_queues - 1) */
> +	if (queue_num == bp->num_queues - 1) {
> +		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_A);
> +		*idleslope_reg = GEM_CBS_IDLESLOPE_Q_A;
> +		return 0;
> +	}
> +
> +	/* Queue B is second highest priority (num_queues - 2) */
> +	if (queue_num == bp->num_queues - 2) {
> +		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_B);
> +		*idleslope_reg = GEM_CBS_IDLESLOPE_Q_B;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int macb_cbs_add(struct net_device *netdev,
> +			struct tc_cbs_qopt_offload *qopt)
> +{
> +	u32 enable_bit, idleslope, speed_kbps, ctrl, idleslope_reg;
> +	struct ethtool_link_ksettings kset = {};
> +	struct macb *bp = netdev_priv(netdev);
> +	int err;
> +
> +	err = macb_cbs_get_queue_params(bp, qopt->queue, &enable_bit, &idleslope_reg);
> +	if (err) {
> +		netdev_err(netdev, "CBS: Queue %d not eligible (only top 2 queues support CBS)\n",
> +			   qopt->queue);
> +		return -EINVAL;
> +	}
> +
> +	/* idleslope is calibrated for the current link speed; CBS is not
> +	 * reprogrammed on link-speed changes, so it must be reconfigured
> +	 * if the link speed changes.
> +	 */
> +	phylink_ethtool_ksettings_get(bp->phylink, &kset);
> +
> +	if (!kset.base.speed || kset.base.speed == SPEED_UNKNOWN) {
> +		netdev_err(netdev, "CBS: Invalid link speed\n");
> +		return -EINVAL;
> +	}
> +
> +	speed_kbps = kset.base.speed * 1000;
> +
> +	if (qopt->idleslope <= 0 || (u32)qopt->idleslope > speed_kbps) {
> +		netdev_err(netdev, "CBS: invalid idleslope %d (must be 1..%u kbps)\n",
> +			   qopt->idleslope, speed_kbps);
> +		return -EINVAL;
> +	}
> +
> +	/* qopt->idleslope is in kbps; convert to the units the hardware
> +	 * register expects:
> +	 * - High-speed GEM: fraction of port bandwidth, scaled to the full
> +	 *   32-bit register range
> +	 * - Standard MACB: the register counts bytes/sec in 1G (8-bit GMII)
> +	 *   mode and nibbles/sec in 10/100 (4-bit MII) mode, so scale kbps
> +	 *   by 1000/8 (125) or 1000/4 (250) respectively
> +	 */
> +	if (bp->caps & MACB_CAPS_HIGH_SPEED)
> +		idleslope = DIV_ROUND_UP_ULL((u64)qopt->idleslope * U32_MAX, speed_kbps);
> +	else
> +		idleslope = (u32)qopt->idleslope * (kset.base.speed >= 1000 ?
> +					       MACB_CBS_PORT_RATE_1G : MACB_CBS_PORT_RATE_10_100M);
> +

PIC64-HPSC, which has MACB_CAPS_HIGH_SPEED, doesn't have the first idle
slope calculation method which scales to the full 32 bits register range.
It uses nibble/sec for 10/100M, byte/sec for 1G, 2.5bytes/sec for 2.5G,
5bytes/sec for 5G and 10bytes/sec for 10G.

Is it possible that you have another design config bit for the "full 32
bits register range" method used here?

-- 
Thanks,
Charles
