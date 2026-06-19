Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FF28C840
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859008; cv=none; b=WP7Ks6u16pmVmKuL9oRJhqq+tID4bvpE3WxCqNEV/j/B0oo49cdCQCdK8RbfzNboOPyATm2kDMIY/1VVv4jzJ2dufk8ORDUlKvu4orgQMAph127MHJqb+NFiJ/3eEL15Cx+BtHLJ1N032HQHgj9tOINBDMo751OewAdpWZ+f2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859008; c=relaxed/simple;
	bh=j0TQ1klvpgpAp7IoqxioiurzX6IYOP7YgUjiWQ6435A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfbgBi0EsviuyO30fpDA5Z3WwB452uL3qCxvrtjq/OXx2454qVIACU/WqDVcw2lzeGm+loJDvHVZkcfneZskIwa4ZDVMyC3osQchf0VZ4veLMSqc4DulaUgkcNy+VZ+KvTWpF+HUnu5ZZfRYRHSByD94eyr+2NzyKOxY12P5fF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FQF6O65q; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FQF6O65q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 59AFCC06CD4;
	Fri, 19 Jun 2026 08:50:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 88758601AD;
	Fri, 19 Jun 2026 08:50:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 439A3106C88A9;
	Fri, 19 Jun 2026 10:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781858999; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1cGPNM8CgkhC9iC98sy5Y925tuG5J0QBkzDj6YCkI5c=;
	b=FQF6O65qXr1VlcP9MSF+J07p3E48H7o6y9CqpbXKX94y2PGB8gD21/z2aVJqSrczW5zUHh
	+6I+rwIZoEnatEV9OnMHUp6GwpQGI6QR11NBsfG6B2u3eN9P4cj6VfTt2Mttj5eCcYqeZO
	O0aT6Wv8s1cXTxHcnPOycM7VJSm9BpOdR6HRPE9dLXp0KsuM2aGEXaIZx4QACKIgi1Fson
	g1F8TkqXdGhvJX0OFO711R96Z5XBER1pRQDlIFga8Nruhw/qY82fEMvStTR7QiCMqHl3pv
	7NH5KWhyK/JBDZZzS4wA7cW38UQu6MCX2+5qNb2FBaKlk47tI2pCT9vdI+4q1g==
Message-ID: <e9e251f9-40b9-4543-b3c1-bac5a9ec5811@bootlin.com>
Date: Fri, 19 Jun 2026 10:49:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
To: Jan Klos <honza.klos@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260619011519.50009-2-honza.klos@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260619011519.50009-2-honza.klos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/19/26 03:15, Jan Klos wrote:
> On RTL8127A connected to a link partner that advertises 10000baseT
> speed cannot be changed to anything other than 10000baseT as 10GbE
> is always advertised regardless of any setting. Fix this by
> clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
> call to phy_modify_mmd_changed().

Makes sense, this is also done as part of the C45 config_aneg sequence.

You're missing a few things process-wise :

 - a Fixes tag to indicate the commit that introduced the bug

 - You must CC all the relevant maintainers, including the top-level networking
   maintainers, use ./scripts/get_maintainers.pl to get the list

 - The patch must have in the subject an indication that this targets the
   'net' tree, for bugfixes, see :

https://docs.kernel.org/process/maintainer-netdev.html

Feel free to re-send a V2 (after waiting 24h), and add my review tag :

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> 
> Signed-off-by: Jan Klos <honza.klos@gmail.com>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 27268811f564..b65d0f5fa1a0 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -1802,7 +1802,8 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>  		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
>  					     RTL_MDIO_AN_10GBT_CTRL,
>  					     MDIO_AN_10GBT_CTRL_ADV2_5G |
> -					     MDIO_AN_10GBT_CTRL_ADV5G, adv);
> +					     MDIO_AN_10GBT_CTRL_ADV5G |
> +					     MDIO_AN_10GBT_CTRL_ADV10G, adv);
>  		if (ret < 0)
>  			return ret;
>  	}
> 
> base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823

