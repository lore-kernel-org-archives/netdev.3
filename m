Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C1396D12
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824183; cv=none; b=pBe7x1e677DRLOI25QsymkP5YEyQzuxUjWlYNOjBMS90lMlfT59O6euLjQAmaQyKPvpOGIn8z0zwc1r5ypn/u7571kyKllZ4J6LckFDduVEX85c3O+1rJheMnCMY2igSXXq9QCWbALUIF4RBLzNchab75ybUfxBWSJYrsZ5pcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824183; c=relaxed/simple;
	bh=e8K+m4/u1sBNfWNpsxL44kUKSDTey4Otqq1oT9mljo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idkajtTXxTa4dotKnz1Ep9ix3AbldoZaifJQpdxpLuQW5jnrLxnh1DGILE8ZnnFcCX/hH5MUNrxGOgJ9qtp9mOI1d7Kf+6ed18pKU3CP7mlZVONyh9g4g8LOENgw3HqKeHqH7NBHgHS2lMcWvzTAYwjbz/yzwDhQ8X5lEjOngxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=plWuq2Nu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="plWuq2Nu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 103E61A2E9F;
	Wed, 18 Mar 2026 08:56:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D639C6004F;
	Wed, 18 Mar 2026 08:56:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13586104506C1;
	Wed, 18 Mar 2026 09:56:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773824171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FFHfSJWTfi30mPuW/btoOYk0NY/0JJ+dKHbFOscjYes=;
	b=plWuq2Nu/MHxScP2TAnHt0BtCosxkY+PZxHyPLHHU1dE/1eA3UvbHmdBD6y859R4d9EmjL
	CU+uLXN8fJQFw0XUJyzr1tukK32PQat/fnl6kKLKoc2M73sUJFEzksjVSgZW5DWoljFk2M
	H3a9S3uU7/eefoYc0F4EwzwWxNhRxd8/CPaH1JQWTsZucVj9GHZRQiK06u36sHNOSDF4mO
	fJstXzTnAI8TRdNKhGc+pjENK0x/FoGtCPKNfEPhl3B16hdNQzBvafX0lXwhreHLCaqKyl
	QRpku60ugip5sIbBsVpDlLfqlMAVr+MjYIffiDC9QOd2IryblWaHp82JKQr/qw==
Message-ID: <0f3a167a-3887-47ee-abf5-53f6a9a97cfb@bootlin.com>
Date: Wed, 18 Mar 2026 09:56:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: add debug for phy_config_inband()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <E1w2mFk-0000000DXW2-2PR9@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1w2mFk-0000000DXW2-2PR9@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 18/03/2026 09:27, Russell King (Oracle) wrote:
> Add debug for the phy_config_inband() call so we can see which inband
> modes are being configured at the PHY.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Ah, useful indeed !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/phylink.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 59bcc69b6c39..1c178038e6f1 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1341,6 +1341,13 @@ static void phylink_major_config(struct phylink *pl, bool restart,
>  	}
>  
>  	if (pl->phydev && pl->phy_ib_mode) {
> +		phylink_dbg(pl, "configuring PHY for inband%s%s%s\n",
> +			    pl->phy_ib_mode & LINK_INBAND_DISABLE ?
> +				" disable" : "",
> +			    pl->phy_ib_mode & LINK_INBAND_ENABLE ?
> +				" enable" : "",
> +			    pl->phy_ib_mode & LINK_INBAND_BYPASS ?
> +				" bypass" : "");
>  		err = phy_config_inband(pl->phydev, pl->phy_ib_mode);
>  		if (err < 0) {
>  			phylink_err(pl, "phy_config_inband: %pe\n",

