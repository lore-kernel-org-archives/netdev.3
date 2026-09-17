Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565AA4B0482;
	Thu, 17 Sep 2026 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637582; cv=none; b=e/PHDrRHmKxF9cGdRZebC/1e98UI3plOcOfxF0YPVsUthmr83KgnQ4aiJIxUTNaygDO2LvtS/1BX9rwheb1ghKkEHiZv1ygcbdBoBtOdxaRHgDOGNF3h0EeAU9WzTPQFywVedABpZ2s7KIS3+HpXPzIlt95o0PfVqQnzWMeeJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637582; c=relaxed/simple;
	bh=pBuZZ0HQh+WEJNfbYm+ILmuef4dwzhvlfrzvBo6lJEQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=mOo6jGGMZbLkvCSLBW+MaQL46FPKTegcftk0VVxipeawDuAAiauA6w4Z5iBi/2Z4vzhB9r++DiV0H5p5sm5kX6EmH26XG8U92BHl3B2NnXybOexnrVuHYx5EN5OkZ2ZEQ6T2wlY9UuFxbRl+zwMs8Cn2diS5H4cJvbjTtzHKbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gdFAUY5l; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gdFAUY5l"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C84AF1A0923;
	Thu, 17 Sep 2026 09:32:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92DE55FAA3;
	Thu, 17 Sep 2026 09:32:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 929F011C7B02B;
	Thu, 17 Sep 2026 11:32:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789637573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F+AuMvlP2aZ6ARS7QsZ5Sy4iA/uLE9FjF/8Q1FhDY5M=;
	b=gdFAUY5lMJw0XyutlfXh8U8s/eVRDv5RWsh08tKa003+w2TEXy0qg9g1BVBGgHQuPJ7rSw
	mL+Dsjc7MxS0mfNtvXjhI+B00QZpXrMt5D1Y7vBBDppzLjjgwd8qtIEprpxsKbcgGnAXmn
	UidriZnbuAPoKI8n+9nMyO/9kpiiuZtAdsp45lL0+UTrkLO/xAM5lBFbcGmNASU178h+29
	Sno8YU4VKUerjDq6xM41koVUpOUBn09O6Y53qxMK5oA4IIH4kSzW/Vh98KJf92RronBmYI
	GN7l729X6TYycAkclw48YiBXb7b0fCKHf/fcqxrjbHAnGL10/3GRDalkvpS+BQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 11:32:50 +0200
Message-Id: <DLHHKM7ZOTWD.1W25GJL8Z0G7Q@bootlin.com>
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 4/4] net: macb: Add TSN CBS TC offload
 support
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
 <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
In-Reply-To: <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Wed Sep 9, 2026 at 4:20 PM CEST, Vineeth Karumanchi wrote:
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
[...]
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 67150ff03066..00c1c619dea8 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> +static int macb_cbs_add(struct net_device *netdev,
> +			struct tc_cbs_qopt_offload *qopt)
> +{
[...]
> +	scoped_guard(spinlock_irqsave, &bp->lock) {
> +		/* Disable CBS for the queue before updating idleslope */
> +		ctrl =3D gem_readl(bp, CBS_CONTROL) & ~enable_bit;
> +		gem_writel(bp, CBS_CONTROL, ctrl);
> +		/* Update idleslope for the queue */
> +		bp->macb_reg_writel(bp, idleslope_reg, idleslope);
> +		/* Re-enable CBS for the queue with new idleslope */
> +		gem_writel(bp, CBS_CONTROL, ctrl | enable_bit);
> +	}
> +
> +	netdev_dbg(netdev, "CBS: Configured queue %d with idleslope 0x%x\n",
> +		   qopt->queue, idleslope);
> +
> +	return 0;
> +}
> +
> +static void macb_cbs_destroy(struct net_device *netdev, u8 queue_num)
> +{
> +	struct macb *bp =3D netdev_priv(netdev);
> +	u32 enable_bit, idleslope_reg;
> +
> +	if (macb_cbs_get_queue_params(bp, queue_num, &enable_bit, &idleslope_re=
g))
> +		return;
> +
> +	scoped_guard(spinlock_irqsave, &bp->lock) {
> +		gem_writel(bp, CBS_CONTROL, gem_readl(bp, CBS_CONTROL) & ~enable_bit);
> +		bp->macb_reg_writel(bp, idleslope_reg, 0);
> +	}
> +
> +	netdev_dbg(netdev, "CBS: Disabled queue %d\n", queue_num);
> +}

So we write cbs_control/0x04BC only on ndo_setup_tc(TC_SETUP_QDISC_CBS)
callback. As Sashiko pointed how I think that causes an issue with HW
resets & suspend:
 - what if configured then link down then link up?
 - what if configured before link up?

Also when not using CBS we hope tx_sched_ctrl/0x0580 is at its reset
value (0b00, fixed priority) for all queues. I would expect an
unconditional writel tx_sched_ctrl/0x0580 in macb_init_hw(). This
solves the down/up issue, the speed change and also ensures we don't
inherit CBS or DWRR from the boot stages (super unlikely though).

Also, it might be simpler to always use tx_sched_ctrl/0x0580 rather than
sometimes tx_sched_ctrl/0x0580 and sometimes cbs_control/0x04BC, which
are aliases.

What do you think?

[...]

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

