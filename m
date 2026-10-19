Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5B4E7808;
	Mon, 19 Oct 2026 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409543; cv=none; b=lk8gLQRYlP1nd+IvUL+YE4vmzo7BY9/w4gOKU5l9GwBshZ+Ep3N/o+01yfj0y8YwNP0ICk9lEcgm0AdsMki8JUI7xkxdXu4HxBwlAf4TR0gShSnodQVWDo3RrT23VCxVRLsfE2YsxOsVU074ucixDEta13nyCfVJZg8XSH5ywcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409543; c=relaxed/simple;
	bh=lo9zUxJ4IDoU0BPSsG/keYDLx5MfS4Xq7tX6TBV6MNE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=N2/O3o1LL6iDI/OW+JurLkO5LAOgs9+oH3VGsdvMM5IZ0VcoM9HOJYqsZc/6ccw5QLnuREG9S4aAsY0Y0o9bwl36fkR0SOniiMpMen1MIa9su8sybHwO0Vw4Rps6xgklnHzT4oHhTRkjLHhI0gNi5Bdv8LS83leKJUV9ZE+Gf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=vrC07do9; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="vrC07do9"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30063A15A5;
	Mon, 19 Oct 2026 13:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792409539; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sUYlmOugU7MtjRD+n63PLNv4sB8Cfzdv44OFMAwozD0=;
	b=vrC07do9nl4D0F6ehlWaXB3h6VqXoaX5dVTSvr6CA5IFTGKp2usr5OGa4H/RnmI9ENHeyG
	UZmVi3kOeKoP6PCu9br38/IphjCfNBdlkdU6GlZhF5qfTlmSYf97ntmLZ8AB1YKL94pl5G
	9khoWhgET8p6hws40Sl7fQjwRIxNqtP5gI6fljC3BXbrHDXMzWlNNFw1lFgwcNyrgO74vc
	4WveGydqPNkerANk+MlZSe+Tl05r6B0Fo7dR/hjbPhUwUozOAp+DhVDeJs6Y02btxqWCyB
	FzCfbtG+ZTSH6NnKqvD/hd7FpC78nvNECeAx+1uBsf4LiXjiOAG449n4HKuaTw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 13:32:18 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Valerio <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 1/3] net: macb: add QUEUE_DISABLE capability
 to 3 compatibles
In-Reply-To: <20261016-macb-set-channels-v5-1-90ce0c0b8e75@bootlin.com>
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
 <20261016-macb-set-channels-v5-1-90ce0c0b8e75@bootlin.com>
Message-ID: <d4c8dd5afbb3fa6c74a14fc8a877e49e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 16.10.2026 18:58, Théo Lebrun wrote:
> From datasheets, we know those 3 IP versions support Tx and Rx queue
> disabling, ie bit 0 in RBQP and TBQP registers.

nit: Just learned that git am will turn this into >From. Maybe reword 
the first sentence.

> 
> All revisions I've seen either support it on both Tx & Rx or don't
> support it at all.
> 
> Sources:
> 
>    Compatible            | Match data         | Datasheet
>    
> ----------------------|--------------------|-------------------------
>    atmel,sama5d29-gem    | sama5d29_config    | DS60001764 [0]
>    microchip,mpfs-macb   | mpfs_config        | header files [1]
>    microchip,sama7g5-gem | sama7g5_gem_config | DS60001765 [2]
> 
> To contrast, check out the SAM9X60 DS60001579C datasheet [3] that does
> not document bit 0 as anything special on page 1041 and page 1042.
> 
> [0]:
> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA5D29-Data-Sheet-ds60001764.pdf
> 
> [1]:
> https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/blob/614a67ab/src/platform/drivers/mss/mss_ethernet_mac/mss_ethernet_mac_regs.h#L200-L207
> 
> [2]:
> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf
> 
> [3]:
> https://ww1.microchip.com/downloads/en/DeviceDoc/SAM9X60-Data-Sheet-DS60001579C.pdf
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 020a47353d01..625171fd3f9b 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5743,7 +5743,7 @@ static const struct macb_config sama5d2_config = 
> {
> 
>  static const struct macb_config sama5d29_config = {
>  	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP |
> -		MACB_CAPS_USRIO_HAS_MII,
> +		MACB_CAPS_USRIO_HAS_MII | MACB_CAPS_QUEUE_DISABLE,

AFAIU this also switches WoL suspend on these SoCs from the tieoff ring 
to
QUEUE_DISABLE. Was WoL tested on any of them? Worth a line in the commit
message too.

>  	.dma_burst_length = 16,
>  	.usrio = &at91_default_usrio,
>  };
> @@ -5799,7 +5799,8 @@ static const struct macb_config mpfs_config = {
>  	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
>  		MACB_CAPS_JUMBO |
>  		MACB_CAPS_GEM_HAS_PTP |
> -		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE,
> +		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE |
> +		MACB_CAPS_QUEUE_DISABLE,
>  	.dma_burst_length = 16,
>  	.init = init_reset_optional,
>  	.usrio = &mpfs_usrio,
> @@ -5812,7 +5813,7 @@ static const struct macb_config 
> sama7g5_gem_config = {
>  		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
>  		MACB_CAPS_USRIO_HAS_REFCLK_SOURCE |
>  		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP |
> -		MACB_CAPS_USRIO_HAS_MII,
> +		MACB_CAPS_USRIO_HAS_MII | MACB_CAPS_QUEUE_DISABLE,
>  	.dma_burst_length = 16,
>  	.usrio = &sama7g5_gem_usrio,
>  };

Thanks,
Nicolai
