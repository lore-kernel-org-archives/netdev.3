Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC8D46E013;
	Tue,  4 Aug 2026 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853012; cv=none; b=i7+RKCjklyUDiLvWCJ0E0KGYTdB8ZDh0Fk8WIdkVgMdx6gwBqtzL0+aHX2R9HQI2c3LTtCj6h4nmZq7/gQh1sb7+Fwi1/MV6tA7kzgBFQe5CV+tShqp3G4zSXa86D8zRqa1lSMT2aWP0tP+kOrFHtB5/cJtxvBzEkcjH6Rd0Smw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853012; c=relaxed/simple;
	bh=0gNl2j7wMWSdbB+S0HQhwVZuG/H5fZCRYk/ezEvPXBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJjjWCBnAgyF3vlzYdH9StZ4iuxfjlO6mYLj+dhLujWwjr1Sgaxm1mBwwDP4O2IHvN5bzIswFZpD5T89k/sVEl3u7xCpcYtC9oKKZFAHzf3Z8gcMNQq+kj9AVOm0AkXey0l8bMISIbOcg1prVo+aHHGE5icK+dZF40+jsdKzxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iP1DpoQ3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iP1DpoQ3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 424B51A13FA;
	Tue,  4 Aug 2026 14:16:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F4AA6029E;
	Tue,  4 Aug 2026 14:16:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A8B911C32DC9;
	Tue,  4 Aug 2026 16:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785852992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aaTOsyqLfltEiDVoe0qUuVANOU3C1a+/jJ0nViOag58=;
	b=iP1DpoQ3bSprJou1YjQfnOdmTMeWqNvH3Ap2/OSN6GaZs5u1ttfNd6lQnLcpO2rBvwDcOX
	nMjoAeeFHsf4BTH6QX/tDncYNstU1vGm1mbDy9w42zHHe5f7/FLZYtlOZz6M/N5U6ayiYI
	K0Icri5wm8rNerXBZExE3oxWAzDr1E6TDEHfBSHBsegflBk1jzpesUXOfbxo1wnFEsPfE5
	lzVp5Pt/yXqk62VpeKuTT3BCAcsEQv6PI1hCWSHDYOI5iRgKPoJnQVUhCqMPOeBzJxepSH
	BeD532/p9eDch7lYyfkDVJxY1N8PJ6iea/0lsEFDOirM3BDDHAjTzcwPN+RLrQ==
Message-ID: <807166df-2de0-4176-aad6-6bf632670528@bootlin.com>
Date: Tue, 4 Aug 2026 16:16:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] net: stmmac: manage error case during
 stmmac_dvr_probe
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, linusw@kernel.org,
 antonio.borneo@foss.st.com, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260804132052.205273-1-christophe.roullier@foss.st.com>
 <20260804132052.205273-5-christophe.roullier@foss.st.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260804132052.205273-5-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On 8/4/26 15:20, Christophe Roullier wrote:
> In case of error during stmmac_mdio_register, pm_runtime is not
> cleaning before exit probe.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Can you send this path to the proper networking tree ? Is it a bug you've
encountered in the wild (like, eprobedefer or something ?) or just
something you've noticed ?

If this is something you encountered, let's send it to -net (and it would
need a Fixes tag), otherwise just target that to net-next

Thanks :)

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 0de4bc949913..852de0f51c09 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8062,6 +8062,8 @@ static int __stmmac_dvr_probe(struct device *device,
>  error_pcs_setup:
>  	stmmac_mdio_unregister(ndev);
>  error_mdio_register:
> +	pm_runtime_put_sync(device);
> +	pm_runtime_disable(device);
>  	stmmac_napi_del(ndev);
>  error_hw_init:
>  	destroy_workqueue(priv->wq);

