Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180903D967A;
	Wed, 29 Jul 2026 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314317; cv=none; b=VBo1dFs9VzSvYfqCK+nvyRzkjo4ujn1bIANBwLlYN3e55zo4rRvHZaB/wka1gDejq2TtUuzoZ9luElf0/J9D0pURccGaevye4gy9j3Nc2Siaqolnq4kGwmtjzFfQP0vtZmkza7d914huwDYWUwsX5iEaXTqUUpdTvBJ1mRnh0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314317; c=relaxed/simple;
	bh=9XS40PlDrkflNm4TjZrXgb8SjyNmxrjwvdGDc8ENMY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iygapm4I+nQuML4v50l8VuNoWput+3oQQngVmFpBV4P9HCYyHDvDfZUEiGJJ5Bu4fG00g4IeDz7C3JmBMEXaHovPDkKtksV/c3Y+h6W1+P3QyWzOJdhICELBZTP2PvkCERUoQb4xFNGe5LXcM0N9EHTGk51sPBc4nMkpwNRQc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ORRcB0QW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ORRcB0QW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7DE8D4E40FD9;
	Wed, 29 Jul 2026 08:38:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FC6C6039A;
	Wed, 29 Jul 2026 08:38:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09F0711C11F0C;
	Wed, 29 Jul 2026 10:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785314309; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FUu5NqumLRBBsM8cmbA2FL/BiDOsZawATxjJH9KLPTM=;
	b=ORRcB0QWP8F2KSLRl08Cg7G1WcZtx27DTab3iQJvjXstMfo80lsvlXU/f+2gDug23Tru0b
	v8sgzw+eu1SQCHyv8MWMvGJYN4XRDBuHQ8czgk6eIYUg3Ck1OmjhJH/JoDGoqU9Gay9n/S
	EcC//06r/PE3zw3sDYRHGXK/2KLO94ISekCx0v7/Et4/l3E2oQtF7YZp6fC/BCXM8MPjMd
	ChgtQoSpiCcxADq3sqs2ikNpAZWWQZ9Dr1wHLU+nphsnxeE3hFIEat/sDXcgM+3AgeSraw
	/VrUr6fnkGxtVopcH5nZ+P1MXyrEwa9x0kRJ5AsmYiORwM991E/lhvyQT/WdhA==
Message-ID: <ef8823cb-29e4-4892-a9c1-854541312e00@bootlin.com>
Date: Wed, 29 Jul 2026 10:38:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: Skip PHY attach if custom
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
References: <20260729074237.2624940-1-zxyan0222@gmail.com>
 <20260729074237.2624940-2-zxyan0222@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260729074237.2624940-2-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 7/29/26 09:42, Zxyan Zhu wrote:
> When a platform provides a custom PCS via the pcs_init callback,
> the MAC's phylink_pcs is already configured. In this case, no
> traditional PHY device is needed.
> 
> Without this, stmmac_init_phy() falls through to the no-phy-node
> path and errors out with "no phy found" when the DT has no
> phy-handle for such interfaces.
> 
> Skip the PHY attach when priv->hw->phylink_pcs is set and
> phy_addr is invalid.
> 
> Fixes: f0ef433fc264 ("net: stmmac: introduce pcs_init/pcs_exit stmmac operations")
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 562d20830b94..575132b9cdbf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1347,6 +1347,10 @@ static int stmmac_init_phy(struct net_device *dev)
>  		struct phy_device *phydev;
>  
>  		if (addr < 0) {
> +			/* If a custom PCS is in use, no PHY is needed */
> +			if (priv->hw->phylink_pcs)
> +				return 0;
> +
>  			netdev_err(priv->dev, "no phy found\n");
>  			return -ENODEV;
>  		}

