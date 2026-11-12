Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476598;
	b=HPo6lq45yWuxrG8bCAB4tedZV3EVHuC6F+A+2jWxiMRWpE+ggIyJBbcaIZvtDCusoq6E
	 VscsS56uZ+K41Z6VrnRBS+fU9IKvTGF8jGdlJlfnu3LiFLqJVlUc+eUo0hKBS5WwIL4nD
	 Efwq9lSOHdH4mk0ztIGtcfpTvf6GgqaU4cjpVy/l2sgUlu/9S46K5QDSAJqcI5+iefhAN
	 69xGqfVw6PqW2o++TqHfRSOT6rn6A3jR8aolXjj+x+R/XwHq5reZyRuPANMxWHZyzcKAE
	 IhlAA/xiN6i+/iQ9DJZq+AEXNkYUVy2x8aYDl7PfX8p0qVWoOKTBugWD0KruLg4m0xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476598;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=HoRCw77ZwoLoLapCSKXoJHWwYpZwKjiCThC98/UXUv0=;
	b=zkqMP4ZNrW/1dKbUv4EveVuwVfn8X7VWMBXjjf9U/bU1kNZEA2pEg/72cyAxvvOwMfMt
	 eiv6bnZlOSexnnlyK9q+bJXMcIxcSiihQ1EbKvPGCecQW0x8hCybVnHXVcJPCrbDvwtBJ
	 qjjar/3FEQsj84K28wB4xjoxeV0sPhs+4vCGEoypDtJLL+L0lB+oEbJaUCfLAnZzYM7cV
	 dTU227e8h0WD7RZOBHaS/KlugFmaHPDif33B7aLzgBDWDB42JSxzUDErYDRWFTC2xBT59
	 Y3wrC5Bep5cZDg5i1Zi0Q8QbJdjptvORKslUfsOJ9JxVh3ruOjEISN/j4Lc6uFFhj8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=YD5jokag;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2432606A336;
	Thu, 12 Nov 2026 09:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2432606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=YD5jokag
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A19D9A1632;
	Thu, 12 Nov 2026 10:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794476594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HoRCw77ZwoLoLapCSKXoJHWwYpZwKjiCThC98/UXUv0=;
	b=YD5jokagYA6izzSHyGkcS07RAUIFMpS/3kZfLRecMVHQrBIxESaCOw5UZZviDzldV+gken
	awTT+Mo0KFXVOfSmLRia78oTafNSahzA5fenahWpog3hjufNnBTBNLZnHA/k9UNIBvFz80
	mPJIVm9z3nb/KvRjqWAUlzyEtndbl0+kKxSVCHVJGxxnQIe/EkRZJl0SQxFMNOnN4/bsFw
	q1O827qAbGguuQakCraEZ39UvyGjHCwR6PtFRFCmdxmNDMHv1PBeTVAjxdaOSEcbDaGlh3
	Ud5mkdUMFonKD3235XuaiyPDgwfdSzR6KuA9Kl/iYvolI3hILEN3V5ft4P0jrA==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 10:43:10 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: aiyengar1990@gmail.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: dwmac-sun8i: Fix the RX_TH
 threshold encoding
In-Reply-To: <20261112-sun8i-emac-jumbo-v2-1-aca0cf23cf17@gmail.com>
References: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com>
 <20261112-sun8i-emac-jumbo-v2-1-aca0cf23cf17@gmail.com>
Message-ID: <58be9817f150b4b67de284c68b3265dc@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 12.11.2026 09:41, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> The EMAC RX_CTL1 RX_TH field (bits 5:4) encodes 00 = 64 bytes and
> 01 = 32 bytes (H616 user manual v1.0, 6.5.10; 10 = 96 and 11 = 128 
> bytes
> as in the driver). The driver has the first two swapped.
> 
> The values are only used in RX threshold mode, which stmmac selects 
> only
> when the snps,force_thresh_dma_mode property is set. No Allwinner 
> device
> tree sets it, so no in-tree board is affected.
> 
> Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c 
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 47954537b29e..0c82662fbe6e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -198,8 +198,9 @@ static const struct emac_variant 
> emac_variant_h616_emac1 = {
>  /* Used in RX_CTL1*/
>  #define EMAC_RX_MD              BIT(1)
>  #define EMAC_RX_TH_MASK		GENMASK(5, 4)
> -#define EMAC_RX_TH_32		0
> -#define EMAC_RX_TH_64		(0x1 << 4)
> +/* RX_CTL1 RX_TH encoding (H616 UM 6.5.10): 00 = 64, 01 = 32 bytes */
> +#define EMAC_RX_TH_32		(0x1 << 4)
> +#define EMAC_RX_TH_64		0
>  #define EMAC_RX_TH_96		(0x2 << 4)
>  #define EMAC_RX_TH_128		(0x3 << 4)
>  #define EMAC_RX_DMA_EN  BIT(30)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
