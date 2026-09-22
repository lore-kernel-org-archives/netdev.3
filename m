Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3352BE37;
	Tue, 22 Sep 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066397; cv=none; b=AZ5p6Uwiem9x8CBWfNgVA4xslVpXFnaeBgd9XG5t72kFZDieI8V/MFwnslcDA+/FztXvrwA2Bwa+gUGUOiTu9cs8E3E+G8Nxql5uO1ktyEbP8ACxIDPdM58Ig31rS2kM7lnViCoWIUsfkdpxrMeA/ByaXJ43cW7oCT/35vuIAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066397; c=relaxed/simple;
	bh=ulX/NX+Okoff0WdSlPHwWYfa4aoOucevyh8BttYqLBQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HtX7Ei0fM6ta+Obdh2X3V+k+AmTCw+JjuugNaQj1YtKUvdLqEr18gbZeOJ+dxp1nnOXn/rqDITVBlE+i5wl804k67shUZbO9mJKItnQvlxk4ypsduKP57eJSKKy6bep7aO6inaP8XTkudtaiombg1qw7FEDytD9dcDC/6ZkD+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lDoUJ9TS; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lDoUJ9TS"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C623A4A2E;
	Tue, 22 Sep 2026 10:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790066393; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lNl9StCDLT+Os7JaF6KH7/O3qAKjKS/QI+0ppoppeFo=;
	b=lDoUJ9TSR872a4PMoug+rYzDGA4caZjQI6M6uAUtT8g4YcGwO2/h3dRngdErQsjienolhU
	6OJ4LeOYA8rOlbBruxzAnHMFk9XhNwVVGaRu0z7+IZp93fEgRKnpvfGCZWou7Kziomwewg
	PVU1DuZrgUfU5L+mkqO9tKwn34lBZsRN1TcL6EGw6T2GPpGCInpKTjGQfBb+etxpn7GHn8
	G8mUWRz/hYx1Y9Kzv9+3IMGO8wAWOggsxdZkokBUtDylzVBKX6idD6VukbPRiTG6cDeS0k
	vnrdPqP8VJIjS9mEw1eYzu0W5mQDVZnxXin7cfJCqDLXhgG7lw9jmQ0fQNN5gQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:39:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 05/12] net: systemport: Fix Wake-on-LAN RXCHK filter
 enable loop
In-Reply-To: <20260921231305.394773-6-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-6-florian.fainelli@broadcom.com>
Message-ID: <51016c48b2a4a5eda764dcc01b98e451@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 01:12, Florian Fainelli wrote:
> In bcm_sysport_suspend_to_wol(), the loop enabling programmed RXCHK
> filters in RXCHK_CONTROL used an auxiliary counter 'i' instead of the
> actual set filter index 'index'.
> 
> When non-contiguous filters were configured (for example, if filter 0
> was deleted and filter 1 remained), the code would enable bit
> (RXCHK_BRCM_TAG_MATCH_SHIFT + 0) corresponding to filter 0 rather than
> filter 1, causing Wake-on-LAN filter matching to fail.
> 
> Fix this by using the filter 'index' to set the appropriate match bit
> in RXCHK_CONTROL.
> 
> Fixes: bb9051a2b230 ("net: systemport: Add support for WAKE_FILTER")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 78b96b192185..7f2e5e4efb8d 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2652,7 +2652,7 @@ static int bcm_sysport_suspend_to_wol(struct 
> bcm_sysport_priv *priv)
>  {
>  	struct net_device *ndev = priv->netdev;
>  	unsigned int timeout = 1000;
> -	unsigned int index, i = 0;
> +	unsigned int index;
>  	u32 reg;
> 
>  	reg = umac_readl(priv, UMAC_MPD_CTRL);
> @@ -2682,10 +2682,8 @@ static int bcm_sysport_suspend_to_wol(struct 
> bcm_sysport_priv *priv)
>  		reg = rxchk_readl(priv, RXCHK_CONTROL);
>  		reg &= ~(RXCHK_BRCM_TAG_MATCH_MASK <<
>  			 RXCHK_BRCM_TAG_MATCH_SHIFT);
> -		for_each_set_bit(index, priv->filters, RXCHK_BRCM_TAG_MAX) {
> -			reg |= BIT(RXCHK_BRCM_TAG_MATCH_SHIFT + i);
> -			i++;
> -		}
> +		for_each_set_bit(index, priv->filters, RXCHK_BRCM_TAG_MAX)
> +			reg |= BIT(RXCHK_BRCM_TAG_MATCH_SHIFT + index);
>  		reg |= RXCHK_EN | RXCHK_BRCM_TAG_EN;
>  		rxchk_writel(priv, reg, RXCHK_CONTROL);
>  	}

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
