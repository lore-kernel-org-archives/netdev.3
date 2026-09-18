Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022644AC143;
	Fri, 18 Sep 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734481; cv=none; b=l0hfaiWclj701Q3Km5+PJn0lyVmJPC/TKCSRP+D8E6MHOhtmiy2p1c9sPgPVrRFl1iA7fGS/FmV5GwG4/CkF0+wwTXJcjVkdcMvt5Kl1H2nq4p3f9EdgRJtj8IBE0U7As/W9L3ZkZDqOc/DTxEiNvUKDfoXdneBdEF+oMqYsStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734481; c=relaxed/simple;
	bh=D4I03yeQGzjKpMCYkTB8uAyyeRUNwjiqewlK+eDXjMQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pKVr85ZcTGOILSyQsQIeEAsK9v3bbXaqdsXsVzo3VqjQTWvoIFjk2xySokLhlNYh+/qGRIE8/+bOHREnCP4cmMISFJEXHvBEII7kLnCnv01nNxxO8HrgsJ/AX2a9W7IUXd68u+bcJl9kiucQpWzporhQ7IV5uE/ab9KZOOXDhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lRLSd3CW; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lRLSd3CW"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75D0CA50C5;
	Fri, 18 Sep 2026 14:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789734474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zx+UnW+U+8Lo3B9mBHhdyZeWG2LwXc0mc8VMD/jW+6g=;
	b=lRLSd3CWhGDLQ+vXzCVIdV1a3BEPf07TTGGUMaNaYPPjsPTanjjtkqhMC4CfKanmZJKoce
	gCJWNkWe16IPsmZwvkd+sFGY4vVF5Y/PqZ1U4d5a7GtBW3crzq3C9m6zxwCEhJrIk1Vg1n
	MgBceIofv69LV9K1YIhI2hK1gntfTL8kMAxMONJ/Y/Raj6ikEXK3dAykYinQJt32zeUc72
	qgJb0V7kspNs2n5rCBTyXnMT6BSc5tvcYhru5WpG4lXKdwsAJHO2sRCpWdG4qACpVJmHL2
	OVkd18fA+Q/BKDyIEaO51tEVX5vsJHBSljm6u8RRuNnqsGNJpWboZ7u7qBx2nA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 14:27:51 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 1/3] net: phy: realtek: add support for
 RTL8261CE_CG
In-Reply-To: <20260916081444.497-2-javen_xu@realsil.com.cn>
References: <20260916081444.497-1-javen_xu@realsil.com.cn>
 <20260916081444.497-2-javen_xu@realsil.com.cn>
Message-ID: <5f533ecb12674818c763153390619702@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 16.9.2026 10:14, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add support for RTL8261CE_CG, its phy id is 0x001cc899. RTL8261CE_CG
> share the same sub_phy_id and firmware with RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c 
> b/drivers/net/phy/realtek/realtek_main.c
> index 97b0b67b9900..d0d09e8e8f5c 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -257,6 +257,7 @@
>  #define RTL_8251B				0x001cc862
>  #define RTL_8261C				0x001cc890
>  #define RTL_8261C_CG				0x001cc898
> +#define RTL_8261CE_CG				0x001cc899
> 
>  #define RTL8261C_CE_MODEL		0x00
>  #define RTL8261D_MODEL			0x81
> @@ -3363,6 +3364,19 @@ static struct phy_driver realtek_drvs[] = {
>  		.soft_reset		= genphy_c45_pma_soft_reset,
>  		.suspend		= genphy_c45_pma_suspend,
>  		.resume			= genphy_c45_pma_resume,
> +	}, {
> +		PHY_ID_MATCH_EXACT(RTL_8261CE_CG),
> +		.name			= "Realtek RTL8261CE 10Gbps PHY",
> +		.probe			= rtl8261x_probe,
> +		.config_init		= rtl8261x_config_init,
> +		.get_features		= rtl8261x_get_features,
> +		.config_aneg		= rtl8261x_config_aneg,
> +		.read_status		= rtl8261x_read_status,
> +		.config_intr		= rtl8261x_config_intr,
> +		.handle_interrupt	= rtl8261x_handle_interrupt,
> +		.soft_reset		= genphy_c45_pma_soft_reset,
> +		.suspend		= genphy_c45_pma_suspend,
> +		.resume			= genphy_c45_pma_resume,
>  	},
>  };

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
