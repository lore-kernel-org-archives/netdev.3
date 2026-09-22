Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737F40928D;
	Tue, 22 Sep 2026 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066281; cv=none; b=gcYJZxDHm2snJWWqiOsX3fy/2KKcrSBFbd7LhZXHNgZ1zXSdT7cPatKC2hNskCMG/25X242lv4789bddqYjzs2SuvH//GiJ9qcU0L67uB+IeAZkDxt6CJqSSJ5a0t2JLio4mlLx56fDBmKdBUz1Z56jMpd8MZpXosQbMGQ6YSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066281; c=relaxed/simple;
	bh=KYe1+Grph1p0Z1bjExAgq4W/tuXK/0qSgQLERHvEBOo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dTqjWgCdqRRje8AcATQEML6BTZSuHpPftbH1VSem0Y31fc03HRRWTIB1eHacRBMoBGiMjaI3Wt4HmBPzvJk9MPYSuDZSB40uf1httd9gxiF11RPCNUniwvtipF1tVDWVtyVTE/a5M9PemC4tWBxkVvUNs755wUTnmDCzV2TKjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=iepPiYbU; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="iepPiYbU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51DF1A3808;
	Tue, 22 Sep 2026 10:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790066278; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PYf7cw75FbfjBsnFH9g8uivtElGUN60205IE1EUJJkQ=;
	b=iepPiYbUb6xvOQI+qep915Mk9cpODqyIiw7U1XeI2MStio1ysSPdAqakDcPA81RT3aTihK
	bXWI/RJMXqS0FXTYoiPZ0AhRubOwvlgPb767UKDNepZJ24NPNLlyoy+fJLVrZXw9offB3+
	7ddqmvRhiIWUeqZ7tGKgAyh4Dp54TNBqXV4OpTlBAMBnehJh6rlvYs0gKhQXpDDu+Bq8gr
	VqbfaKwmQX8v6HYdIJ0NqHS6yJ7tAeEUH9iQsPEph7n0eQKB7o8yu//IZiuGpsHtOkK339
	ATC2YLzpMIZC+KmjrsHzIVB68CVomTybgNOG2/HYoSBH7lRpbRx9UaivHVXGzQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:37:58 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 03/12] net: systemport: Fix NULL pointer dereference
 in bcm_sysport_fini_rx_ring()
In-Reply-To: <20260921231305.394773-4-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
 <20260921231305.394773-4-florian.fainelli@broadcom.com>
Message-ID: <db054c94545471b2c4f6c9eb52b8977e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.9.2026 01:12, Florian Fainelli wrote:
> If allocation of priv->rx_cbs fails during bcm_sysport_init_rx_ring(),
> error unwinding in bcm_sysport_open() calls bcm_sysport_fini_rx_ring().
> Without checking if priv->rx_cbs is non-NULL, 
> bcm_sysport_fini_rx_ring()
> dereferences priv->rx_cbs, resulting in a NULL pointer dereference.
> 
> Add a check for !priv->rx_cbs at the beginning of
> bcm_sysport_fini_rx_ring(), matching bcm_sysport_fini_tx_ring().
> 
> Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet 
> MAC driver")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bcmsysport.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 8328fe824d15..b91a57540f55 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -1717,6 +1717,9 @@ static void bcm_sysport_fini_rx_ring(struct 
> bcm_sysport_priv *priv)
>  	if (!(reg & RDMA_DISABLED))
>  		netdev_warn(priv->netdev, "RDMA not stopped!\n");
> 
> +	if (!priv->rx_cbs)
> +		return;
> +
>  	for (i = 0; i < priv->num_rx_bds; i++) {
>  		cb = &priv->rx_cbs[i];
>  		if (dma_unmap_addr(cb, dma_addr))

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
