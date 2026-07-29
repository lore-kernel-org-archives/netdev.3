Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79639768D;
	Wed, 29 Jul 2026 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306148; cv=none; b=O94TgxyZQy0yGNqCTEAU5yfaKDvBQF9pkJ9LewL4GYg4foEV2AgcfYqoO1OFicJxmRcgXiF4ZWjhTjKNqGcjzwQ4Ja7ItzuXuTcEWbmZS9qvEtGb+yxwXaBrMBs62LPk3P2xx5AvvMrhw2FLiutDD98+v9VfAfhK5BOeDgGLYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306148; c=relaxed/simple;
	bh=15pZePfxoqfH95rdoCZhhvmuo8Nm+GarZpcrCgRlY+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/WnLkJQMtW5Le1Cx+qhSSAJX7H8ItwpHuhcFx/B5AbN9k8YM/R4j+x3m9a1TqfryQe1s2DywgpFPmEtsutOZMHkWfEv6umZhKRTS/OfY6YLrtBnbtLt5CA0ca/g18HzuRTrOy1e3lSUM3pQpiaVHSN2hHzoK1VlaBqQ+YPBJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aSQ8in+9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aSQ8in+9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2C01C1A12EA;
	Wed, 29 Jul 2026 06:22:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0D1A6039A;
	Wed, 29 Jul 2026 06:22:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB9C111C14983;
	Wed, 29 Jul 2026 08:22:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785306137; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IRgRyy4I/iGOdIRbZQjz7pAYVoSvVDRHQXiU6P9/HMs=;
	b=aSQ8in+9EDU9HVfsYSYQC1fmPobZUJb6cqpsiKBZ8E/wdwbnywx+joCjZiPsoPr7lCgNfM
	lydLiKClnNB4459mda2XWXFrHvy8DXx+xon3sqXNHErGU+M5aMzKmZwSGygvblieneZXkN
	URrtHq6wbuDEBj6g7e9ujbNshdnkqRrNfDOrFWurHXncsqnYT+/SBQFTxZbqmtPNJ2whe0
	WnOp63er7p7aJgQxw774qppUjZgxmlSFL1Z+ZNvjOL2xFvrOLyrHbqYqvJkJ9uWJqOgS0A
	8AWRe5rFmJ6muG0A0uZjk3SMRYvg9XzO/lp4GhZco6Q7e9LtxVnBXT19M8Gybw==
Message-ID: <fb9a8280-4166-43ed-a9e5-b54d7079b222@bootlin.com>
Date: Wed, 29 Jul 2026 08:22:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Skip PHY attach if custom
 PCS is in use
To: Zxyan Zhu <zxyan0222@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260726132618.3580612-1-zxyan0222@gmail.com>
 <20260726132618.3580612-3-zxyan0222@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260726132618.3580612-3-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

I think sashiko's are correct that we can err on the safe side and move
the check inside the "if (addr < 0)" check (even though I don't think we
have platforms with a PCS but no fwnode-described PHYs, but just to be
safe).

Also, sashiko reports an issue on patch 1 that this exact patch is solving, so
you may want to re-send but with patches in the reverse order.

Maxime

On 7/26/26 15:26, Zxyan Zhu wrote:
> When a platform provides a custom PCS via the pcs_init callback,
> the MAC's phylink_pcs is already configured. In this case, phylink
> validates against the PCS's supported interfaces and manages link
> state through the PCS, so no traditional PHY device is needed.
> 
> Without this, stmmac_init_phy() falls through to the no-phy-node
> path and errors out with "no phy found" when the DT has no
> phy-handle for such interfaces.
> 
> Skip the PHY attach when priv->hw->phylink_pcs is already set and no
> phy-handle is specified in the device tree.
> 
> Fixes: f0ef433fc264 ("net: stmmac: introduce pcs_init/pcs_exit stmmac operations")
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 562d20830b94..044ed3b89247 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1346,6 +1346,10 @@ static int stmmac_init_phy(struct net_device *dev)
>  		int addr = priv->plat->phy_addr;
>  		struct phy_device *phydev;
>  
> +		/* If a custom PCS is in use, no PHY is needed */
> +		if (priv->hw->phylink_pcs)
> +			return 0;
> +
>  		if (addr < 0) {
>  			netdev_err(priv->dev, "no phy found\n");
>  			return -ENODEV;

