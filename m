Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870913C81B5;
	Wed,  1 Jul 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894567; cv=none; b=AkesnSDGvSwcK1xePsF9dYNHfNL5h5ek5dPQSfy1HaJg8mlMWUGrYYr0Kyu5IS18zaqX5u5bOCUkm4ava9fPS4wQnRhRPD0ldG+J48iQcpkXslwPWOQz8gWkVT3A8F1vOChjp5A+lG8GIHKoY8CV48ORP8zBJ+4WSr+lw0NVhxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894567; c=relaxed/simple;
	bh=8Uc+cvbtg99BwjYqc61sq7I9dvIw9WKTyl4yy7Bfv1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlwWHJhn+vdxRmgfkovshX81N/qx8c89+7TjqYqRRU7yqGf1KAkx0ZrIPgBUnsGRWowozR7kgGe0r3DwX8kIsZjxQCf0b6scryu95Yjroy30y1K21RgNAKHMHP9phnD8DhSzvt+Mq90lUZeeSLbzdQAdLlSWh8xhk57/w73fBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yxlk3HM7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yxlk3HM7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E94721A0D6D;
	Wed,  1 Jul 2026 08:29:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB15860288;
	Wed,  1 Jul 2026 08:29:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 975A2104C9958;
	Wed,  1 Jul 2026 10:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782894561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oECz7fTiJqcD3oq+UPg7MWfYlrzBT4yOegUO0AQTw2c=;
	b=Yxlk3HM7twInma1O2Uo94vI0fpqJMgMhAa+Ivw7dhTvfyvzB+kdPGeBXhwpuze7j2juHiz
	Wf9ZCnhTyVXVB2auDbxQAO6f7IyDSIUjcUZhKpho4ZTfbjfBARVF7sIalrc8aY7zOnCPzL
	sN5+0kkoELTF/HG5bGU/EojYVEu8utI3k1DKMf41Jhijjcr1ghNORU+3LfeQqmjN8pR/7F
	gIWJQOJsEh47ZBDozHDuIhe4Uj0F/siBQSkOucB6dL3nyQ1YZjnFZj5W4tJYjx/WCiNnZw
	BAds4lNGJvQQCUVo5m44ZYfhq7Qw64oIT+gqcqdpumBLDZ5uNigimksoDGHfBg==
Message-ID: <37005060-acfb-4791-aa2c-caa3710d4450@bootlin.com>
Date: Wed, 1 Jul 2026 10:29:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phylink: reject unsupported speed/duplex in
 ksettings_set() with PHY
To: muhammad.nazim.amirul.nazle.asmade@altera.com, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260701031746.23448-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260701031746.23448-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/1/26 05:17, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Target tree tag is still also missing in the subject :)

> When using ethtool to change speed and duplex on a phylink-managed
> interface with a PHY attached, the requested speed/duplex combination
> is not validated against the MAC's supported capabilities before being
> passed down to the PHY layer.
> 
> commit df0acdc59b09 ("net: phylink: fix ksettings_set() ethtool call")
> and commit 03c44a21d033 ("net: phylink: actually fix ksettings_set()
> ethtool call") introduced masking of the PHY advertising modes against
> pl->supported, but did not add an explicit check that the requested
> speed/duplex itself is within the MAC's capability set.
> 
> The AUTONEG_DISABLE path in the non-PHY case already uses
> phy_caps_lookup() to validate speed/duplex against pl->supported.
> Extend the same validation to the pl->phydev path so that ethtool
> requests for unsupported speed/duplex combinations are rejected with
> -EINVAL before reaching the PHY layer.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  drivers/net/phy/phylink.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 087ac63f9193..22f9bbd381bd 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -2989,6 +2989,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
>  	if (pl->phydev) {
>  		struct ethtool_link_ksettings phy_kset = *kset;
>  
> +		if (!phy_caps_lookup(kset->base.speed, kset->base.duplex,
> +				     pl->supported, true))
> +			return -EINVAL;
> +
>  		linkmode_and(phy_kset.link_modes.advertising,
>  			     phy_kset.link_modes.advertising,
>  			     pl->supported);

I can indeed reproduce that, with a 1000FD-only mac, running

  ethtool -s eth2 speed 1000 duplex half autoneg off

brings the link down, no error reported, and running

  ethtool -s eth2 speed 1000 duplex half autoneg on

also brings the link down, with

Advertised link modes:  Not reported

This is expected, but yeah no error reported.

I think rejecting these settings makes sense, I'm however wondering
wether this is a fix or not, as this will change user-visible behaviour.
I'd err to the side of caution and send that to net-next, but maybe
Andrew will have more insight :)

So at least, you'll have to resubmit targetting the correct tree.

Maxime
