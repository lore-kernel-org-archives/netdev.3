Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262303016F1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271153; cv=none; b=nFs+u6worwzrLzKS0S0bHDRlbEMS3KX+zotTmcFfgXkKwwQZk2V+6qCTRhMm5rbCcctAvDB7W0kkzi6kqjQnhbHGGuAO/Xc8cC1OGH9aM2M5kh4wCwoxnHDf9d7vMHA3mgsOam5urgJZtaCozR4AXVT8Rdad7F+xmbyFlV/5w0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271153; c=relaxed/simple;
	bh=+dQW5HMUoVkq1CBnPzF+MmC76PM+fL5474Pz/VoXE7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZALThd6zCrKKNgYAT6aoJ9JIeWL2H8NDLDhSTByN7gzfgGYy3FMvSVPQ9ITEXfXdTT2hDobBlBq6CEkJd+hBTcTWcnn2ka07x95JwDhmR3f5F5RUNy5E9I1f1GxLFHAXAAREXtQhZoI+zMIejhxQ9nYQRoqQaOI9QU4k0GjqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbJpyPNJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAr/3elC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbJpyPNJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAr/3elC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788271150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyeT2gPwgRHGbRT1UC00BJ26hUwN31fmD+oDhUutisA=;
	b=JbJpyPNJ/w3zz3f+CGCpCuof50zU0xQDu/aYkuoeMt6jqE8hRH9CpXurhpvY0NMDO5PSei
	qJiP29QELNIhlO5mVVasa3tpnBrHpcGBHYfDhIT70YnkPU0FRyvGI5u211tAjjDS3lZ0qZ
	Wl9FvZFIz7SdV+Yez/VqjP1HdG84rTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-j5DmVvUzMU2ilNrsd_1sPA-1; Tue, 01 Sept 2026 09:59:09 -0400
X-MC-Unique: j5DmVvUzMU2ilNrsd_1sPA-1
X-Mimecast-MFC-AGG-ID: j5DmVvUzMU2ilNrsd_1sPA_1788271148
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955fd77c18so26974105e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788271148; x=1788875948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RyeT2gPwgRHGbRT1UC00BJ26hUwN31fmD+oDhUutisA=;
        b=LAr/3elCnOAvH/kVYc+6e94S+p0vL2LMILz1mr1Gtjg5rAT3F8tKZ+YKHtNkdMZ6l+
         L/IrITJ4YSDII4EmOYCt5AKiNjdiM4JAyToMbdrhT6D0kGaNkgo9hjuvtKAhNI6noBuN
         b8kV4upsTAjIgAL9dImyKYcXV1h11b2TCAfaMJDdGXMnaM1Y8LiiDHw+96oEcYdGiOdC
         pDJZ4ca0PJGcP6glUxio/E2N7kZ/FyEgODC8Sb05yWeoDoulHNK+ErfSY0wXaIwZxMyH
         SlxvqSU0icKeQut4tfdUY5UKayIykBESEgxvjAFumvd4gIHhGR5JRyQOwQh6CK4mqbws
         dawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271148; x=1788875948;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RyeT2gPwgRHGbRT1UC00BJ26hUwN31fmD+oDhUutisA=;
        b=O7zJ8rijzFmDMcXO9gjoAHaYq6lzUE3FN3bLTYbNMpDSLfP0DGUI8tUf4RpYrGFETw
         6SFUrV7FxFEYrPGqSwop99XM+b8js+h+IGjq4dbBAEu+tjAlEglcCwC7m5PBdZJ9u+pu
         aznqEO4KkxvWq3HyhSKGP1JmcgG28MOn2ey5ZHqvCme2bn4EtfvPJzvSd1cAMsj3bn5k
         Lfl9uibuWPIIsnVdDmSudDdj/r5iHCs2TvEYDwEbv3QPbQfCO4HM6i/6jpPLUlI9a2ln
         JLP84UeSWWeWP/NjJ8WKfYQCRdq/kQy7f8r+KH2OYZ4c16GdF3tQ/t5ukQJXskO0CjyG
         51Qw==
X-Forwarded-Encrypted: i=1; AHgh+RobT8R9obfOsHrjVPNbyNwVs0OGfkhbEX47s+Nqf8p1f8qiplLr7O44kBR487VuNRuKBAfil04=@vger.kernel.org
X-Gm-Message-State: AFuF++nZGCOkryjF8X9nAclaxVb0mtO6fKeEvhDdsjE7pmVoy+l0c5Jt
	fXrb+wlEY+f3/lpEcuiAzVUUjVa2/fIGVwBp4x3AfO6N8efoB0JVoNvpV3AH4D0G+w/wb+kpf+9
	pehymGaOTZOu8L6aXVZUWPq6475NWEsUlXW+cyY4/Hc1EdizApXvV5A9p+g==
X-Gm-Gg: AR+sD13h2D+MeynB1z76KIvYOH46wQP27Xgn+eOMMEhNRrMHtMfRUp/A6pIghzHHorw
	ElEBv32uTX1+RLraFcTdE+6+SRI2yxFct78JjFYmKwwVLNZh711q9VOLy0W9NZqv2PvHnRxmMJl
	Wge/ca4r9EGzp92kSp9rOsS2zR+PKpKEqWUWNVq+/GcNuC7mLcxrjnEsX2dXyU5sLxHxsWeZKCf
	YGKhqFwJVXM8mlJvC0r4I/SzgflUYVkMMkmPD5TW6JE6rNDSXZJEy8NizDJfRWDI5F8xjGbNeOS
	yyJA83lfhFl2TnLBPbKjluZe16AmOxXiWDICDunTl9V7IOhLjWQ6wstvPR9HBaX0FrvVxuOkQFY
	+sqX2wr0UPQ1UqZ/v51ttetctUCCk7mrGxS5tpvu/eAYUFLFILU4x6Y5X3UOQQrBI1pS387PWaQ
	==
X-Received: by 2002:a05:600c:3542:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-49cdc422c19mr158172605e9.3.1788271148277;
        Tue, 01 Sep 2026 06:59:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3542:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-49cdc422c19mr158171425e9.3.1788271147829;
        Tue, 01 Sep 2026 06:59:07 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10153sm76476035e9.4.2026.09.01.06.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 06:59:07 -0700 (PDT)
Message-ID: <17e50070-46c9-46dd-8109-95007a4f681f@redhat.com>
Date: Tue, 1 Sep 2026 15:59:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: motorcomm: Enable analog frontend
 on YT8531S
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Yao Zi <me@ziyao.cc>,
 Frank <Frank.Sae@motor-comm.com>
Cc: thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
 <20260831073747.361482-4-maxime.chevallier@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260831073747.361482-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 9:37 AM, Maxime Chevallier wrote:
> The YT6801 PCIe NIC includes the dwmac-motorcomm IP for the MAC part, as
> well as a YT8531S PHY, configured in GMII mode.
> 
> It seems this PHY requires the Analog Front-end (AFE) DAC clock to be
> enabled for link to reliably establish, otherwise the link just doesn't
> come up.
> 
> Let's enable it at config_init().
> 
> This logic has been extracted from the vendor driver provided by
> Motorcomm.
> 
> It's really unclear if this is specific to the integrated version of
> that PHY, and how this potentially interacts with the fiber mode this
> PHY supports, so this configuration is only enabled when the interface
> is GMII, i.e. the PHY is integrated.
> 
> With this, the PHY reliably establishes link and the YT6801 PCIe card
> becomes fully functional.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/motorcomm.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 36c229460a77..90a4f86f2758 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -144,6 +144,11 @@
>  #define YT8521_CLOCK_GATING_REG			0xC
>  #define YT8521_CGR_RX_CLK_EN			BIT(12)
>  
> +/* Analog front-end control register 3 */
> +#define YT8531S_EXT_AFE_CTRL3			0x12
> +/* Analog front-end DAC clock enable */
> +#define YT8531S_AFE_CTRL3_CLKDAC_AON		BIT(13)
> +
>  #define YT8521_EXTREG_SLEEP_CONTROL1_REG	0x27
>  #define YT8521_ESC1R_SLEEP_SW			BIT(15)
>  #define YT8521_ESC1R_PLLON_SLP			BIT(14)
> @@ -1740,8 +1745,15 @@ static int yt8531s_config_init(struct phy_device *phydev)
>  	if (ret)
>  		goto err_restore_page;
>  
> -	if (phy_interface_is_rgmii(phydev))
> +	if (phy_interface_is_rgmii(phydev)) {
>  		ret = yt8531_set_ds(phydev);
> +		if (ret)
> +			goto err_restore_page;
> +	}
> +
> +	if (phydev->interface == PHY_INTERFACE_MODE_GMII)
> +		ret = ytphy_modify_ext(phydev, YT8531S_EXT_AFE_CTRL3,
> +				       0, YT8531S_AFE_CTRL3_CLKDAC_AON);

Sashiko suspects this will not survive a suspend/resume:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831073747.361482-1-maxime.chevallier%40bootlin.com

/P

