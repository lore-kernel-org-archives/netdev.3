Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245826;
	b=XzRmRwI6yh58SZ8BcWqjvgSxLPyQ2vTYnmrJSOTERCed1cwstyjqedAo9ft5cqujIQlJ
	 BGCN0OQV85UWkNmnMFuinZxH5M/GUT6RefeJqy4TN/+RqF3ZSCyMJxSoPahez/D+K4r7c
	 +eyXRYoC8B+uocTjvbKGa5MFUt5hz90xg2eq0UH3dlSpGSMQTDED8xbiSKVShXi+M9pmL
	 vtuVKKfDYoDOevOX7GwDPvjlncJMkmhpzMjGOsnsP0JSRIqqfAUFGZw63pDII2n5X2FYe
	 aFlv49ILaefzR5aRim6k6gGEbL/JW29hsQ21RUAPmwNLs29R614TuAJ19qdVx48XJNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245826;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i2dzBPk2KyCkXa9Ry/J6aPzwN7dFhy1J+ad3KFJSVCo=;
	b=oGmDb123oQWzk1UE7uM2tAKu1jA4ErFsS3F38a0rpfx6Y+nktdzeSleEwZnX8uP0CDRA
	 uIDSQlKu0SepCddEQ+kCkeD2RJxwl37sNUuNdq3pOcwJT9US12W1DQSnj9RgUKLNiSrti
	 nH56zULlb3TFzWRMUugF0Bjyo6gWK28LsJoS1GIcFbFuZSxnHRCiFkodisf/YMdBILKUS
	 9oGj8m7QlX0Vh+pG04B9cRGWgh2O2AdpCF4dL6ORAJ9hawAlnycZyRBHrB2VwLMrdFfEN
	 3qbzDpguqXHc2cKGnR4UhQzipQz1rAnJ0xYUCKeFUJaO7qwXbORVmzjs+dOHiaKWRqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsLBoyzD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B7606A31C;
	Mon,  9 Nov 2026 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsLBoyzD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5941F0089F;
	Mon,  9 Nov 2026 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794245826;
	bh=i2dzBPk2KyCkXa9Ry/J6aPzwN7dFhy1J+ad3KFJSVCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UsLBoyzDXclZURcLlAVnpfdx1bQX47+aMaIu6rOp9H65LGjgf7eEiLRbjPbVYr+HA
	 kEaFFeNGf1wgD40VvhOA/k+XqiSxBf+fBaVvwpPYnBsjtJ1ZtocMWbfv7JrmME1zRu
	 gQTXzYZbdjKTjXAwz0Au28t+KUBUAnkR/hCf8/I/2uueKXcCI1kd0gkTgoS9KqV/38
	 X2f/VvdIVgU3/5I1f4ape5h/zdV175YODTDs8OeyrzmrGwoLdiuDqweNk2Hs2A6Ppc
	 ugucn3KO1LtURaL9UI0pN8bHPKTIFqgV9Xx+Y84gaiUH9VEmMguMh6kiVJnTXDxLY1
	 EWYrH2OSVJTrA==
Date: Mon, 9 Nov 2026 17:37:01 +0000
From: Simon Horman <horms@kernel.org>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: netdev@vger.kernel.org, s32@nxp.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] net: enetc: Enable probing of version
 4.4 devices
Message-ID: <20261109173701.GW18859@horms.kernel.org>
References: <cover.1793712309.git.claudiu.manoil@nxp.com>
 <bf8effe9a06ba569b5e5a36cc1d1982b2e3fff53.1793712309.git.claudiu.manoil@nxp.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf8effe9a06ba569b5e5a36cc1d1982b2e3fff53.1793712309.git.claudiu.manoil@nxp.com>

On Tue, Nov 03, 2026 at 04:09:08PM +0200, Claudiu Manoil wrote:
> The ENETC v4.4 devices are present on S32N79 SoCs and feature only
> Pseudo-MAC ENETC ports, whose PFs use either the 0xe101 or the 0xe110
> PCI device ID, and the VFs answer to the usual device ID of 0xef00.
> 
> While the ENETC PF instances are usually designated by the 0xe101 ID,
> in newer IP versions the 0xe110 ID was introduced to indicate the
> power-on reset default NETC switch management interface. These IDs
> do not indicate any functional difference between the designated
> ENETC instances, and can be interchanged and re-assigned at boot time
> (i.e. from firmware).
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v3:
>  - Added sysclk_freq info for the v4.4 ENETC devices.
> 
> v2:
>  - Described why there are two ENETC PF IDs in the commit message, as per
>    review.

I realise this was forwarded somewhere by an automation, but it seems not
to the full CC list, so I'm reproducing it here:

  commit 6de2e15f2fb313f3ab9a84d0bfd5a867de11c72c
  Author: Claudiu Manoil <claudiu.manoil@nxp.com>
  
  net: enetc: Enable probing of version 4.4 devices
  
  This commit adds driver data and platform info entries for ENETC v4.4 PF and
  VF devices on S32N79 SoCs with a 500 MHz system clock frequency.
  
  > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
  > index c6571b5cc8425..b989823859ff2 100644
  > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
  > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
  > @@ -3832,6 +3832,20 @@ static const struct enetc_drvdata enetc4_vf_data = {
  >  	.eth_ops = &enetc_vf_ethtool_ops,
  >  };
  >
  > +static const struct enetc_drvdata enetc4_s32n79_ppm_data = {
  > +	.sysclk_freq = ENETC_CLK_500M,
  > +	.tx_csum = true,
  > +	.max_frags = ENETC4_MAX_SKB_FRAGS,
  > +	.eth_ops = &enetc4_ppm_ethtool_ops,
  > +};
  > +
  > +static const struct enetc_drvdata enetc4_s32n79_vf_data = {
  > +	.sysclk_freq = ENETC_CLK_500M,
  > +	.tx_csum = true,
  > +	.max_frags = ENETC4_MAX_SKB_FRAGS,
  > +	.eth_ops = &enetc_vf_ethtool_ops,
  > +};
  > +
  >  static const struct enetc_platform_info enetc_info[] = {
  >  	{ .revision = ENETC_REV_1_0,
  >  	  .dev_id = ENETC_DEV_ID_PF,
  > @@ -3862,6 +3876,18 @@ static const struct enetc_platform_info enetc_info[] = {
  >  	  .dev_id = NXP_ENETC_VF_DEV_ID,
  >  	  .data = &enetc4_vf_data,
  >  	},
  > +	{ .revision = ENETC_REV_4_4,
  > +	  .dev_id = NXP_ENETC_PPM_DEV_ID,
  > +	  .data = &enetc4_s32n79_ppm_data,
  > +	},
  > +	{ .revision = ENETC_REV_4_4,
  > +	  .dev_id = NXP_ENETC_PF_DEV_ID,
  > +	  .data = &enetc4_s32n79_ppm_data,
  > +	},
  > +	{ .revision = ENETC_REV_4_4,
  > +	  .dev_id = NXP_ENETC_VF_DEV_ID,
  > +	  .data = &enetc4_s32n79_vf_data,
  > +	},
  
  Can probing ENETC v4.4 on an 8-core S32N79 SoC overflow priv->int_vector[] in
  enetc_int_vector_init()?
  
  In drivers/net/ethernet/freescale/enetc/enetc.h, ENETC_MAX_BDR_INT is still
  defined as 6:
  
  #define ENETC_MAX_BDR_INT	6 /* fixed to max # of available cpus */
  ...
  struct enetc_ndev_priv {
  	...
  	int bdr_int_num; /* number of Rx/Tx ring interrupts */
  	struct enetc_int_vector *int_vector[ENETC_MAX_BDR_INT];
  	u16 num_rx_rings, num_tx_rings;
  	u16 rx_bd_count, tx_bd_count;
  
  Previously supported SoCs had at most 6 CPUs, whereas S32N79 has 8 CPUs and
  enetc4_default_rings_allocation() allocates up to ENETC_SI_MAX_RING_NUM (8)
  RX rings to the PF.
  
  When enetc_init_si_rings_params() runs on an 8-CPU system with 7 or 8 RX
  rings:
  
  	int cpus = num_online_cpus();
  	...
  	priv->num_rx_rings = min_t(int, cpus, si->num_rx_rings);
  	priv->num_tx_rings = si->num_tx_rings;
  	priv->bdr_int_num = priv->num_rx_rings;
  
  priv->bdr_int_num becomes 7 or 8 without being clamped to ENETC_MAX_BDR_INT.
  Then enetc_alloc_msix() -> enetc_int_vector_init() writes past the end of
  priv->int_vector[]:
  
  	for (i = 0; i < priv->bdr_int_num; i++) {
  		...
  		err = enetc_int_vector_init(priv, i, num_tx_rings);
  
  where enetc_int_vector_init() does:
  
  	priv->int_vector[i] = v;
  
  overwriting num_rx_rings, num_tx_rings, rx_bd_count, tx_bd_count, and
  subsequent fields in struct enetc_ndev_priv.
  
  Should ENETC_MAX_BDR_INT be increased (and/or priv->bdr_int_num bounded by
  ENETC_MAX_BDR_INT)?

Link: https://sashiko.dev/#/patchset/cover.1793712309.git.claudiu.manoil%40nxp.com?part=2

This does seem to be a legitimate concern to me, and I think it warrants a v4.

There is also a review of patch 1/5, here, which I think warrants
investigation too.

Link: https://sashiko.dev/#/patchset/cover.1793712309.git.claudiu.manoil%40nxp.com?part=1

-- 
pw-bot: changes-requested
