Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD63D6CC4
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568082; cv=none; b=bOpxoqoDwQv+99sRNZGRdAED9GFH+Jotvsh3Ls14kMBGsZGeX+2VO10cvn0L0MTK4HLCEQylQkPvHNT6Uy6V8C7RcyyBasqyfnr3qwOsHP1xQxdIscvSpadNjd+gSZwJKWZXmPjQ6w9CmTXyhmt2xw7THEtROCOFrn4loi8/FCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568082; c=relaxed/simple;
	bh=jnjjtyoNqk3fLph1H7cvL8QrFATxoSZEE+evx3Rybnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FL+9BZfb+ignCCmsh+dQtGlxlTG63h005yfrtJuwK+9ELC651sN+Jzi5b1swECydn8mdDtXjF5Op1Ts4NziQGmA7CX8XMUvVRZTJpjUx1ASZDTgjgWthpj04vajlHHBTATsNL/vImfznv1iV1w/Y0RWMrA+DnZJm43rctVmk37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YxH7E+yX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YxH7E+yX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 45F704E40589;
	Thu,  4 Jun 2026 10:14:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 192AE5FEF7;
	Thu,  4 Jun 2026 10:14:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8923106A18CF;
	Thu,  4 Jun 2026 12:14:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780568078; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=z5PIo9Jtm3gyRPVQtyYqQOLI/bKP1AnD/5E7TyaKnfo=;
	b=YxH7E+yXWDOdCKP0i4ylBBAk7HD0nO3sBn8k+7mvRVbgxiN7314J9nqERzVPn92AA9gB7f
	rPiGfjf6Ekxvu+G/VGUmHKpa3bbUKCvQ8To2SWJZDIaKLoZ7/dc/Q/g7WTOIlRG33h7TEd
	SUcchFiwNW7BvekFtCowZdPSJzGOXybmt4FyPKvb1Kz2fXF4SQ+udG0DMYhp5BKgAlNgne
	OH+J9TtucwvsPXq+VGqDCRHOm5cAkzQQKyUK59EduxrQPFc3mRWqLyF/cUXuTFZaoFC0cD
	H8uWnqrvQ13HMlcqS4MbACco0S0yJUzjm9dNhcFrY6siDSPg2fqmFSzujO/D7g==
Message-ID: <2e9e7a9d-ef15-4e32-9e2a-b8d2a23b3bec@bootlin.com>
Date: Thu, 4 Jun 2026 12:14:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: phy: as21xxx: handle corner case with link
 and autoneg complete
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601105342.28865-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260601105342.28865-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/1/26 12:53, Christian Marangi wrote:
> Add missing case in custom read_link, when autoneg is started, autoneg
> complete bit is reset but link is still not up.
> 
> Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Looks like the same approach as in genphy_update_link()

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/as21xxx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index d5738117eca6..0db82da8dbdf 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c
> @@ -658,6 +658,13 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
>  		return status;
>  
>  	phydev->link = !!(status & MDIO_STAT1_LSTATUS);
> +	phydev->autoneg_complete = !!(status & MDIO_AN_STAT1_COMPLETE);
> +
> +	/* Consider the case that autoneg was started and "aneg complete"
> +	 * bit has been reset, but "link up" bit not yet.
> +	 */
> +	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
> +		phydev->link = 0;
>  
>  	return 0;
>  }

