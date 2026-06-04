Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAFF373C0E
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568572; cv=none; b=ECrD7iedLzivHofSErgeL5KWAE5m1k6sP7fi830T0xVYXIQcCZDHtPwd73OcolTmdMo7n0Q5OJuj8WqSRm+9hEhdnKaGEcObIYeIKcNG3HtXRDfDL0/lpCdOWDhlOMX8BnfB0ssXDWhbaXsgmJREceHJgR6awxTCA2PjrYg7ul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568572; c=relaxed/simple;
	bh=cACz35Uc2+a6MPuu6gpXvq4GoXJj99xU4zRRb8Ib+CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ls2Ca1U5yGBkNLg6H7mprMY32NMuWVM1clPLjnTY5/N8ImlRxRTCEVVvGnmYeah8UEzG4qVb5nrrSAnOnNqrThQQW8rW2W+SLBaaVhjC4Jg+CJ7x+9S+etlAYjEFuT0Um+xS3JuE/wGrCWhNb3WE2clLHdLpXwXKMFmQg9ue39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q5mpUZ8e; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q5mpUZ8e"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5D3B14E405AC;
	Thu,  4 Jun 2026 10:22:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AE445FEF7;
	Thu,  4 Jun 2026 10:22:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1C13106A18E4;
	Thu,  4 Jun 2026 12:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780568567; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kcL0ulMNPC0gnHlGvkBUUzYgmWFlYbvTgn3AllNsYeI=;
	b=q5mpUZ8evVG0PqKkVaAUYt+QerlJ4hm4cJk+tj9GzqGXqkuBakctwV+wt1DlQI51n3Ocqv
	CO6d0W92xJVGWpxLOhFOfQzdr0fsXQSppCtzmIK7cLdnFLCbXw+a+8ePl1ptwPEd67UTOq
	T0tCBaHUievmhAB5AZ0NOI8fgj+L7jd5SeiXzkdG3df5xz16X5/KLBZvTkslhngYHkZG0N
	T1Jxy2hpzLK1Vc/qOh3pHoHCJhQwlBMHEd20F7D6lLSj5aR24FjHxkdfN8UfIsfztt71qz
	pm43YJdEFMzX2GdVUrYEC6DpxpHnqEKxd6sq1zCm/6kZ/XPfbaCHhN505S+eUA==
Message-ID: <993cc534-63a6-4cc9-a54b-efc78acdb38b@bootlin.com>
Date: Thu, 4 Jun 2026 12:22:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: phy: as21xxx: force C45 OPs for AUTONEG
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601105342.28865-1-ansuelsmth@gmail.com>
 <20260601105342.28865-3-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260601105342.28865-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/1/26 12:53, Christian Marangi wrote:
> With further testing with 2.5G NIC, it was discovered that the PHY
> require the C45 OPs to configure and restart ANEG or speed higher than
> 1G doesn't function correctly.
> 
> To force C45 OPs with generic PHY function, clear the C22 bit from
> devices_in_package bitmask.
> 
> Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/as21xxx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index 97ca37c6929f..a6686b4908c6 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c
> @@ -616,6 +616,13 @@ static int as21xxx_probe(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> +	/* Even if PHY declare support for Clause 22 register,
> +	 * Clause 45 register should be used for ANEG configuration
> +	 * and restart. Clear the C22 bit for devices_in_package to
> +	 * force C45 generic OPs in generic PHY ANGE OPs.
> +	 */
> +	phydev->c45_ids.devices_in_package &= ~BIT(0);
> +
>  	ret = aeon_ipc_sync_parity(phydev, priv);
>  	if (ret)
>  		return ret;

