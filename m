Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093C4071E2
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521435; cv=none; b=i3iVj+z6hVn655Q2j4tYOZz2LffIobbdriJ3dCCAytt+9BZ7iqFqChz9juwoU6hgEICUkwvAxNuEDrUzysrv2nA40HlOmTD1gvTSFn0od1xLcMXa5txi1Ty7bMEZvVxALBODdj1MtKfoFMAnZI/2VXbe0lRKXRCEOSiOLKMs+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521435; c=relaxed/simple;
	bh=gMSWQH1z54P3kzApnUMfI3l4HFjJarIqIyQotw4+7Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gS0/ypa1yPFgY1LvCo1SsawmDFmCToAO3bk/R880GBFJ5Y2Vhl2gOUR+ymMoHVniEIipQX7yIlSAr6wTnyJLUAb3TzXCyHQPJ6sGBSdiw90OVOMAUl2LcPQzPcIdc4/uayZW6Tk5QJOUO+JQCVayAy4u4Cf4Hr5meDJ9te7brLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ipExXbYr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ipExXbYr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7D1024E41507;
	Fri,  4 Sep 2026 11:30:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 385CA6057F;
	Fri,  4 Sep 2026 11:30:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 456E811C7ACD3;
	Fri,  4 Sep 2026 13:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788521424; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=E3epY1+67KLNv+IiSLbiHclGF4bMJDsX7GFrt9DkOYA=;
	b=ipExXbYr18+T4LuW6LN7F0s3LyWtmOSffrPuVWtBPVLFTgg3T6PTPkHxBVcB9OaJ7xoBso
	m2ueNuhhXe/l7MTLDXPLRgVzsDe9EU+eNrvRtS/7mgwScitmIdX7iOVDun2JLX2+9/yanD
	yfofokEZBnPxjrJoWL7UCqFdqs6EQXy+YpjOGq6LiUa7RErv3g9hHrocXEuDrj2g9eG9+k
	j+jydJrMEg1KgkoxQSjfw1hvctAY6YITLTHSgCj1QkJVE3qu/a2G118TbhZSl/dyTm5Ms6
	DSR61EapucpHNFLA79pvAuXOI/KrpNfxzPT05J12HJ43rzuUZPbpx2GigKEyqg==
Message-ID: <3b4865f9-fa18-4138-a46e-05b14f1d3cef@bootlin.com>
Date: Fri, 4 Sep 2026 13:30:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: initialize ptp_lock at probe time
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/4/26 12:32, Lorenzo Bianconi wrote:
> priv->ptp_lock is only initialized in stmmac_ptp_register(), which runs
> during __stmmac_open(). However, the lock is also used while the
> interface is down and has never been opened: tc_taprio_configure()
> invokes the PTP gettime64() callback to compute the EST base time when
> offloading a TAPRIO schedule, and stmmac_get_time() takes
> priv->ptp_lock. Using an uninitialized rwlock is undefined behaviour.
> Move the rwlock_init() to __stmmac_dvr_probe(), together with the other
> private locks, so that ptp_lock is always valid regardless of the
> interface state.
> 
> Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 24656b35350b..5fe7e95fdd34 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8025,6 +8025,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  	stmmac_napi_add(ndev);
>  
>  	mutex_init(&priv->lock);
> +	rwlock_init(&priv->ptp_lock);
>  
>  	stmmac_fpe_init(priv);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 960249960004..3bfcc9760dce 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -365,7 +365,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
>  	if (priv->plat->crosststamp)
>  		priv->ptp_clock_ops.getcrosststamp = stmmac_getcrosststamp;
>  
> -	rwlock_init(&priv->ptp_lock);
>  	mutex_init(&priv->aux_ts_lock);
>  
>  	priv->ptp_clock = ptp_clock_register(&priv->ptp_clock_ops,
> 
> ---
> base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
> change-id: 20260904-stmmac-fix-ptp-clock-init-b8eba4328243
> 
> Best regards,

