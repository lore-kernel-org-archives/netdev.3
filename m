Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3C493D34;
	Thu,  8 Oct 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454065; cv=none; b=Sob7FrDD1FqdYKUwHO7QBUENZNuQyEyRj/aIS3AY01EfLLvUu35kniQ0+yuvjvEipPUju/s5cBhSU/OGxycmZfbMeRAV65xjfSJ+yaoZWUdeCHEravLZ0NsNlTIb5vvqRj75E21PJHMO6RP8Bptjt3wby6vQEnzxYntiXRwM8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454065; c=relaxed/simple;
	bh=lVb0xFpEK5cwo9x36G6hNGkZihB9xVejXEIxp97SWWk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=E2A78BWoBryFQsmO/0+vLR7V53n+DweUSjcGp/06ZXxLsHERkWesY/B08G2WQlo0ZcYSJSP5w5kjMjlLOEs52+Nqxyndmp5tUD2hn6cO65K5bYntNSG8S0ndQxMTmXC6n/0kxdNfdLSwPMtzIF99VcuEjwJwiW/SJTAFwSDePjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=gsaZmgoB; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="gsaZmgoB"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B17F3A0E2B;
	Thu,  8 Oct 2026 12:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791454057; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rYSUkZYYwWzW10vZqDKGMwsY7bAPWob7o3MElX2TeDk=;
	b=gsaZmgoBZlTiGWUa1s0EfwbHkmMfQDMASiEd2aIjyNKx2qhedbdrSlKEv5MS/IczQqw7JG
	MShLun0zh9Yoa2Vsop2h9OGVU8YE9mbv3U9TVbJPGOCAJNrYGEFRn480JnFinZw4NKoxWG
	/Vq/7mi48AilZ0p8JwpUdDJroPuMkNOxuz20HcX59UBskhymworp9VE1TstYabcPgumaB9
	0TjUZlPS4krmOrUoI1Xl91H4fsmCmJieM7F0CgX/M4qxI+fMBeYApis0Utwelinescn+kB
	TIlDSbjX0bjc0CSbJ0RYGPCmEJS6TBMfN1bFtWjnkmy+h1+2yt76ithXJzZHSw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 12:07:36 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Subject: Re: [PATCH net-next v3 5/8] net: bcmgenet: derive the receive buffer
 length from the MTU
In-Reply-To: <179145241305.434549.6513642342117691943@kernel.org>
References: <20261007-nb-genet-mtu-nn-v2-v3-5-74a796c019ce@tipi-net.de>
 <179145241305.434549.6513642342117691943@kernel.org>
Message-ID: <adbf20dcce3c19e4731a0ad0bace8fd1@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 8.10.2026 11:40, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [Medium] In bcmgenet_set_mtu_regs()
>   (drivers/net/ethernet/broadcom/genet/bcmgenet.c), UMAC_MAX_FRAME_LEN…
> 
> --
> 
> net: bcmgenet: derive the receive buffer length from the MTU
> 
> This commit computes the RBUF packet ready threshold from the MTU and
> derives the receive buffer length from it, replacing the fixed 2048 
> byte
> RX_BUF_LENGTH. UMAC_MAX_FRAME_LEN and the TDMA flow period are now also
> derived from the MTU, and the TBUF threshold is programmed at its 
> maximum.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index 83ffc4a2a2a72..4a4b0c46f8986 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> 
> [ ... ]
> 
>> @@ -2630,6 +2648,44 @@ static void bcmgenet_link_intr_enable(struct 
>> bcmgenet_priv *priv)
> 
> [ ... ]
> 
>> +/* Program the MTU dependent registers. Call with the MAC disabled. 
>> */
>> +static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, 
>> unsigned int mtu)
>> +{
>> +	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
>> +
>> +	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN(mtu), 
>> UMAC_MAX_FRAME_LEN);
> 
> [Severity: Medium]
> 
> Will this drop standard size frames once the MTU is lowered?
> 
> Before this patch, UMAC_MAX_FRAME_LEN was always 1536. Now it is
> ENET_MAX_FRAME_LEN(mtu), which is mtu + 36, and nothing keeps it from
> going lower.
> 
> The commit message says:
> 
>   The MTU is still fixed at ETH_DATA_LEN
> 
> Only the upper bound is fixed, though. bcmgenet does not override
> min_mtu, so ether_setup() still allows any MTU from 68 up to 1500:
> 
> net/ethernet/eth.c:ether_setup() {
>     ...
> 	dev->min_mtu		= ETH_MIN_MTU;
> 	dev->max_mtu		= ETH_DATA_LEN;
>     ...
> }
> 
> This commit has no ndo_change_mtu, so __netif_set_mtu() only updates
> dev->mtu. The next open or full resume then writes the smaller value:
> 
> init_umac()
>   bcmgenet_set_mtu_regs(priv, priv->dev->mtu)
>     bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN(mtu), 
> UMAC_MAX_FRAME_LEN)
> 
> Take an MTU below about 1482, for example 1400 for a tunnel overlay, or
> 1280. Full size 1514/1518 byte frames from LAN peers would then be over
> the MAC limit. They would get DMA_RX_LG and be dropped in
> bcmgenet_desc_rx():
> 
> 	if (dma_flag & DMA_RX_LG)
> 		u64_stats_inc(&stats->length_errors);
> 	...
> 	page_pool_put_full_page(ring->page_pool, rx_page,
> 				true);
> 
> Before this patch, the MAC accepted these frames whatever the MTU was.
> Full size UDP, broadcast, multicast or forwarded traffic that used to 
> be
> received would now be lost.
> 
> This still happens at the end of the series. The later commit "net:
> bcmgenet: allow the MTU to be changed" adds bcmgenet_change_mtu(), 
> which
> applies the smaller limit straight away on a running interface.
> 
> That later commit does fix two related cases here. One is the stale,
> too-small limit left after raising the MTU on a running interface. The
> other is the WoL fast resume mismatch between TDMA_FLOW_PERIOD and
> UMAC_MAX_FRAME_LEN.
> 
> Would it work to program max(mtu, ETH_DATA_LEN) into 
> UMAC_MAX_FRAME_LEN,
> and to update the commit message to match?

Sure. Will do in v4

---
pw-bot: cr
