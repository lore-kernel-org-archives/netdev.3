Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CB3A0E8E
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251357; cv=none; b=Mse9wIHK5zhN4r9QmOq2Z0e29mvuew39E9f0XB5BWKMVBE1262hRDcTYhCpdhE8FmZyT3dCYtsmGkoSy0OYGEDtWXbM8qNHf6pWbEPB9z7qAurBz/aWGxEU+DkPNENSn4pPiE/N7Twe1qiMyC1LSM2rd44oRjNL9JLwkdC/BLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251357; c=relaxed/simple;
	bh=O88JCx2gCpZ2lze6X5+/bWCjk4500KcqGHSPg7wx6mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiZwn6NJ+6EpISuCa35vBL04glaUawGsRJ+Ppo+/3MWsoFNCv6Byw0pVi10rZbPqCoaxuiodgdx4DwNTbmc4NiFlTLVw/UsxTqNrgwK2h5HuD6Ibr5UXKP3C/OuzNRJg/d3+E7+LsImd8c6QbN+qrFN5hxpFz7tV3tFnynjvj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ySGtK2PQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ySGtK2PQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F3F414E41494;
	Tue,  1 Sep 2026 08:29:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0D2B6053C;
	Tue,  1 Sep 2026 08:29:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D87611C79239;
	Tue,  1 Sep 2026 10:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788251340; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9C9PquLTIFgMhA+5If1UmoprkzZ8Splb57Qu2HeuyeU=;
	b=ySGtK2PQxTK0mPDTeBgTfM8uNmdLH2en7dtCWlV2ryudYRHswSvMCQj5+/0XXaqLTNTCAa
	5xuDyVgE9zrCgI9Z5dx9wsC3GJD2sTiOm3vk+OQ8ruz9MQ5f1RBVKvXuR7D1P6aripD0kX
	FlJtupueLVEbVYzJaMRX6BXUdqjpn9c0CyBCqfryLV6bKJL9XcSrKr5MD6Wl0LWVPs+miG
	pOaAuWO/f3kwCqiP29Y4EhoV4ch3R5WTjpBR9mGrUYXpQkwdUkrt1EUrQMWJloY2FdE08i
	mzILhXUv6ERPjDzMPVaUw7amAC12BuqU5P3t3mrm/4MxO0V2lEztth6tD9J+1g==
Message-ID: <c48c9cde-a5db-4aea-9b62-1ce007308a68@bootlin.com>
Date: Tue, 1 Sep 2026 10:28:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux next v2] net: stmmac: remove software VLAN tag
 stripping
To: he.peilin@zte.com.cn, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 vbridgers2013@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn
References: <20260901102838839qOylm1OxcNUptu0TbB_Cd@zte.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260901102838839qOylm1OxcNUptu0TbB_Cd@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/1/26 04:28, he.peilin@zte.com.cn wrote:
> Problem
> =======
> When the stmmac driver has NETIF_F_HW_VLAN_STAG_RX enabled by default,
> but the hardware does not support hardware stripping of ETH_P_8021AD
> (VLAN 802.1ad) tags, the driver falls back to software stripping in
> stmmac_rx_vlan(). If the received VLAN packet is fragmented and the
> VLAN header resides in the non-linear part of the skb, the driver
> attempts to pull the header without first ensuring it is linearized.
> This leads to a kernel BUG in __skb_pull() due to invalid header
> access.
> 
> Crash log
> =========
> [   72.212903] kernel BUG at include/linux/skbuff.h:2700!
> [   72.212908] Kernel BUG [#1]
> ..
> [   72.212958] [<ffffffff846919d2>] eth_type_trans+0xe2/0x168
> [   72.212962] [<ffffffff844672e2>] stmmac_rx+0x602/0xc58
> [   72.212966] [<ffffffff84467984>] stmmac_napi_poll_rx+0x4c/0xb8
> [   72.212970] [<ffffffff84635246>] __napi_poll+0x2e/0x1e0
> [   72.212975] [<ffffffff8463596e>] net_rx_action+0x31e/0x388
> [   72.212979] [<ffffffff83c329b0>] handle_softirqs+0x170/0x358
> [   72.212983] [<ffffffff83c32cc6>] __irq_exit_rcu+0xd6/0x100
> [   72.212986] [<ffffffff83c32ee0>] irq_exit_rcu+0x18/0x28
> [   72.212989] [<ffffffff84895b1e>] handle_riscv_irq+0x66/0x78
> [   72.212994] [<ffffffff84896728>] do_irq+0x60/0xa0
> 
> Root cause
> ==========
> In the software VLAN stripping path, stmmac_rx_vlan() does not call
> pskb_may_pull() to ensure that the Ethernet header plus VLAN header
> are in the linear area. As a result, __skb_pull() operates on an
> skb with insufficient linear data, triggering the BUG check.
> 
> Solution
> ========
> The software VLAN stripping logic in stmmac_rx_vlan() was originally
> introduced in 2014 by commit b93819854d6e ("stmmac: Add vlan rx for
> better GRO performance.") as a workaround to improve GRO performance,
> since at that time GRO could not handle frames with VLAN tags. However,
> this limitation was resolved in 2015 by commit 66e5133f19e9 ("vlan: Add
> GRO support for non hardware accelerated vlan"), which added GRO support
> for non-hardware-accelerated VLAN frames. Keeping a software fallback
> path for VLAN stripping is no longer necessary and only adds complexity.

I'm not convinced this is the proper explanation to use here. How did you
trigger it in the first place ? Just getting rid of unnecessary code
is good enough of an explanation :)

> 
> Rather than fixing the issue by adding pskb_may_pull() checks to
> stmmac_rx_vlan(), remove the function entirely. Additionally, ensure
> that hardware VLAN stripping features are only reported via
> dev->hw_features when the hardware truly supports them.
> 
> Fixes: b93819854d6e ("stmmac: Add vlan rx for better GRO performance.")
> Signed-off-by: Peilin He <he.peilin@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Jiang Kun <jiang.kun2@zte.com.cn>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++-----------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2b7d0242dd3..790b7362048e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5021,24 +5021,6 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }
> 
> -static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> -{
> -	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
> -	__be16 vlan_proto = veth->h_vlan_proto;
> -	u16 vlanid;
> -
> -	if ((vlan_proto == htons(ETH_P_8021Q) &&
> -	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
> -	    (vlan_proto == htons(ETH_P_8021AD) &&
> -	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
> -		/* pop the vlan tag */
> -		vlanid = ntohs(veth->h_vlan_TCI);
> -		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> -		skb_pull(skb, VLAN_HLEN);
> -		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
> -	}
> -}
> -
>  /**
>   * stmmac_rx_refill - refill used skb preallocated buffers
>   * @priv: driver private structure
> @@ -5407,9 +5389,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
>  	if (priv->hw->hw_vlan_en)
>  		/* MAC level stripping. */
>  		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> -	else
> -		/* Driver level stripping. */
> -		stmmac_rx_vlan(priv->dev, skb);
> +
>  	skb->protocol = eth_type_trans(skb, priv->dev);
> 
>  	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
> @@ -5901,9 +5881,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (priv->hw->hw_vlan_en)
>  			/* MAC level stripping. */
>  			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> -		else
> -			/* Driver level stripping. */
> -			stmmac_rx_vlan(priv->dev, skb);
> 
>  		skb->protocol = eth_type_trans(skb, priv->dev);
> 
> @@ -7965,7 +7942,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
>  #ifdef STMMAC_VLAN_TAG_USED
>  	/* Both mac100 and gmac support receive VLAN tag detection */
> -	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
> +	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
>  	if (dwmac_is_xmac(priv->plat->core_type)) {
>  		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		priv->hw->hw_vlan_en = true;

Now that we don't have software fallback, tag stripping is only going to work
on GMAC4 and later, so we mustn't unconditionally set the NETIF_F_HW_VLAN_CTAG_RX
flag anymore. It should be something like :

// No more dev->features |= NETIF_F_HW_VLAN_CTAG_RX;

if (dwmac_is_xgmac(priv->plat->core_type)) {
	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
	priv->hw->hw_vlan_en = true;
}

Maxime
