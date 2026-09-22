Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18594D2ED0;
	Tue, 22 Sep 2026 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066256; cv=none; b=bkZMFqPciFOHKNmBYmJAbRttqDzAjcpQvUew/+zrlA9UBRuKNcdMKShJWikoGY90vmh2IkyCCy5FLIBU/3upI+U4PMYCzovCuosrtQQZSFtyeqEQ3naGSC9K4LEZptuqkr/O67PsQp1DtdkpuYZqpCI84bB0naSee6G6jS4Cv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066256; c=relaxed/simple;
	bh=jgoJkGaxQ4n9HD+hXE7OMOf2ziP/UyV/Abu2Ct7LoxM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=F92wzJuQuNB+mddPu0mv782NFTKejOegMTX9bPNrRbafAmCLrDpbnwYcpB8hm5TaIcebnyhqoRIiyws1bwgPKyzb+MUcXo7d/AIl/NxH6fzTTodhh/QOsrTCKVaLMf5kJFhcuOxNCZke906MzbxYAD5DDvGGQTTynUx04jf54B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=gnIX03mv; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="gnIX03mv"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68B3AA4A2E;
	Tue, 22 Sep 2026 10:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790066252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=in/raziPW5G1Xu1xOb4L1v46XCRFE+KHp+ilG22zHH4=;
	b=gnIX03mvyfbFokRLjamq9/I2zkZv7MoZYt8u7/8bDbxK6CvCKFvtgaTyApSQ0TtYwt1M/G
	NJfTaZ65KN+0xuUaDJ2+daOOXdeh/IP6vncO1VkOB/mbQ6Qd7d+B8vr2Bhy3n9zi55oqiQ
	eWFiFL2B4k3MS6gFn4H0Mv7o5fZB55G4h2aAFrfBUcLTun4W/ftTiG6s9i+8xZ2o5GCdF1
	Gw2yZ9BZyb+e/RqX2LhLf26MjGqb35i3Qu9/f6rar1lcfeSEDVh5SvZnCrRD2obQjCGlok
	fGiMf1CWd9tfp2IScQIYqb4oqULLJkFpEeRdBl3R0aBci7mwokd7+qXDIeh7sQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:37:31 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 02/12] net: systemport: Fix invalid dev_id argument in
 bcm_sysport_poll_controller()
In-Reply-To: <20260921231305.394773-3-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-3-florian.fainelli@broadcom.com>
Message-ID: <45a74e48795133e9b7dc8e04f43ed9ff@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 01:12, Florian Fainelli wrote:
> Both bcm_sysport_rx_isr() and bcm_sysport_tx_isr() expect their second
> argument (dev_id) to be a 'struct net_device *dev', as they call
> netdev_priv(dev) to retrieve the private data structure.
> 
> bcm_sysport_poll_controller() was passing 'priv' instead of 'dev',
> causing netdev_priv() inside the ISRs to treat 'priv' as a net_device,
> leading to out-of-bounds pointer calculations and crashes when 
> netconsole
> or netpoll is triggered.
> 
> Fix this by passing 'dev' instead of 'priv' to the ISRs.
> 
> Fixes: 6cec4f5e00a3 ("net: systemport: Add netconsole support")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index db627cd15fb7..8328fe824d15 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -1198,12 +1198,12 @@ static void bcm_sysport_poll_controller(struct 
> net_device *dev)
>  	struct bcm_sysport_priv *priv = netdev_priv(dev);
> 
>  	disable_irq(priv->irq0);
> -	bcm_sysport_rx_isr(priv->irq0, priv);
> +	bcm_sysport_rx_isr(priv->irq0, dev);
>  	enable_irq(priv->irq0);
> 
>  	if (!priv->is_lite) {
>  		disable_irq(priv->irq1);
> -		bcm_sysport_tx_isr(priv->irq1, priv);
> +		bcm_sysport_tx_isr(priv->irq1, dev);
>  		enable_irq(priv->irq1);
>  	}
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
