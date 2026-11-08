Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146950;
	b=yxt7BTM8y+7yxs+tfF6MdiHmKbxyCPoCSRiK1yTNJB9rRi7FByMaCbxQBHXbFhVzZ3iP
	 ttsKkynvA6Y90UgoG2PgU98OcSJ8KwStz0qe6x3u70jHO8voORzeMslXM1xno1GlwjYAv
	 k2lslkuA9n5THOSVfRGcT2r/MkTAE43nxkUo1xFhBM/Pbip0Z83qHP8KgqEm085gb/tgu
	 NTj/xCrA7XzVr2F/P62PwqflpeYJuqBPjHy7Aijl6Wf2dZRp8EnRaSawd/Csg11w99xqO
	 3H3f0bnk+Cs/qRRMpItOwLFXdt6QXnJF67Ni2aPndM6PmzzMp1QMhTZZ4dyc6S97yQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146950;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=sORGFzRD8E4HzQkwXuFsiWbFglj3g8iaUxPq0zUsHdo=;
	b=t1qv2ZRb+wWRmqSx3DdCuW2Js4jtv/sIGpcH5grYb9mY23YQUNTjlFqinrF/0XLU7xHe
	 GK49ZP3EuQBaetC1BC9aKpaW2ZcbMS16BkECwf1UJY+JoYRejAx/Gb+yLx5IE0As/MD2U
	 8OtUe8MCU60a0n8BJxK5wlW+qsDLV50pDqkNgG00dOnSZK18sUZ+Z/oS5QXcnhPt/YZbZ
	 20AOGaVI60pqMG8I5lem4lpLayAQjK+UIXdvmXbrAAjJNRcQQj1XNlDgGF0bR7twaeElE
	 K+YFRfyb3W2uqMRPBUDortEsWVu9MhX10K9C97EKFpOVZ+YvUOro+Tl6TheHvDFpQQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZL7T7561;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E74606A31C;
	Sun,  8 Nov 2026 14:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E74606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZL7T7561
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 07E5F1A1577;
	Sun,  8 Nov 2026 14:08:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B64B360025;
	Sun,  8 Nov 2026 14:08:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5ABC9103288D3;
	Sun,  8 Nov 2026 15:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794146937; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sORGFzRD8E4HzQkwXuFsiWbFglj3g8iaUxPq0zUsHdo=;
	b=ZL7T7561Lu4FFwwsI7q0I9RZ2BQQlKh+5WelkTXTfY642Co5faUCOke7jxn9QZSQFt+Udr
	u2wQcYlfcdX9sC6fI0Tad2Qqu4QNVzH96Ba2zmocZovrYEfPzhp+KXZIU1jOY7WMmkvD2K
	1Kpu9W3Lk8G3sxablbgrJD3UE8iqyytlGBq2DlLMGC8i5rq99oI3iq41a+/GOqtzVMe2Q0
	Ijfu0iGvXv6lBraFURij0WGZQFy2eZNapHctiGgj1ukc0QNFBeABvS4da5liFp8ocP3WEr
	mE01PN2hwO1cEkzAWpBkqRqbt+woN1nVOQlAdiJmqMR5E1xyC6Z+DJYsoIv43g==
Message-ID: <864f2931-4eb7-45c5-b58f-23339eb3af11@bootlin.com>
Date: Sun, 8 Nov 2026 15:08:49 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: release MDIO node if bus data allocation
 fails
To: Wentao Liang <vulab@iscas.ac.cn>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Simon Horman
 <horms@kernel.org>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261108110231.315004-1-vulab@iscas.ac.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261108110231.315004-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/8/26 12:02, Wentao Liang wrote:
> stmmac_mdio_setup() takes a reference on the MDIO device tree node and
> stores it in plat->mdio_node before allocating plat->mdio_bus_data. If
> that allocation fails, the function returns -ENOMEM and the caller
> jumps to error_put_phy, which only drops plat->phy_node, so the
> reference on the MDIO node is leaked.
> 
> Release the reference before returning, using an error label so that
> the cleanup stays in one place.
> 
> The issue was found by a static analysis tool; the candidate was then
> audited and the fix was prepared with the help of DeepSeek and
> GPT-6.1 Sol. It was identified by code inspection only and was not
> triggered; this patch was compile-tested, not tested on hardware.
> 
> Fixes: 1a981c0586c0 ("net: stmmac: Make MDIO bus reset optional")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> Changes in v2:
> - Sorry for the very late follow-up to the review.
> - Use a goto-based error label, as suggested by Simon Horman,
>   instead of an inline of_node_put().
> - Describe how the issue was found and how it was tested, as
>   requested by netdev-bot.
> - Drop Cc: stable@vger.kernel.org: the leak is only reachable when
>   the bus data allocation fails.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 3ea16d618215..ded352afd103 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -356,12 +356,17 @@ static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
>  						   sizeof(*plat->mdio_bus_data),
>  						   GFP_KERNEL);
>  		if (!plat->mdio_bus_data)
> -			return -ENOMEM;
> +			goto err_put_mdio_node;
>  
>  		plat->mdio_bus_data->needs_reset = true;
>  	}
>  
>  	return 0;
> +
> +err_put_mdio_node:
> +	of_node_put(plat->mdio_node);
> +	plat->mdio_node = NULL;
> +	return -ENOMEM;
>  }
>  
>  /**

