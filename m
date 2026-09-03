Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31E3FDC06;
	Thu,  3 Sep 2026 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424089; cv=none; b=amyi7hPS360U4VrrTQs6hcAW9y/5paguU+26uWr4M1k9uUe2fhlfNz8yKi8yrUwVgmyWJryz7Kz33SbCUkcXXl9rp/1p6STSliAkh6UYdnsd6eEJ9hAFp45bajcrGcIAPRdGd1brfJE0j59XfU7mfBSTOLUYnD+wc8cFcF8PMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424089; c=relaxed/simple;
	bh=RQZWhTVGJ9YXHDC8JUQBz8CMZ/+OUrYmeAbhAPRxO7Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JSZCTGONA6Ebu3XKypOj2lciQpCCJyRP1Gw8r09u6En7aFgh4LDAHhfcB5OANMoJKIKmiPe2mEeLhLO/m0XEVajJI/d4LLyzfWdkTMfpMImpAkQrOnzNhIcsNx9ZXuYnLG5wS4+GeekVpsdiYMsDoXdgMafpTkRcLuDqizDrP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vc4yNTTH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vc4yNTTH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5FFF14E414E3;
	Thu,  3 Sep 2026 08:28:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 34091602B8;
	Thu,  3 Sep 2026 08:28:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2DB411C791C9;
	Thu,  3 Sep 2026 10:28:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788424085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R4ZYqxHPzJYDfgApawn5lg6VkCx9FigI+mUz9arHMOQ=;
	b=Vc4yNTTH00akJ1tS/t4rZjVbmSSuNvrxA7hBfbQABdj3xpH2bPoL+8wUqo7NYR2iiXrDs/
	IDUZrZqtoD8rXFgRPzbH+wvcukzO4qFm+cYCT133t+smpfggvy+8zByeAHSKtMXrC3VZPj
	Su1K49TjMVP3Cf0b9yWvgu+Zm+KbCTyFXTgA+5rK/J8LAT2d0cobGTexDmHyalKwuW//Fw
	gVfQjQYxB3qmQmCur+h1n/hAoGmsIEB56AFwfHiqT9JkoQinGIyq46kyCdWHaKb5Tu4BMk
	CI7P16l0gWODAqSHsUFPnMeALuCiYOVmrCNSBfXxGplIVXJJgx05PolcL8X25g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 10:28:03 +0200
Message-Id: <DL5JFDSQECL6.1CH7S2Z56QSVA@bootlin.com>
Subject: Re: [PATCH net] net: macb: fix NULL pointer dereference on unbind
 with fixed-link
Cc: <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <git@amd.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, "Vineeth Karumanchi"
 <vineeth.karumanchi@amd.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
 <febc4b0932422a2e67f64599dd520e0d@tipi-net.de>
In-Reply-To: <febc4b0932422a2e67f64599dd520e0d@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Nicolai,

On Thu Sep 3, 2026 at 9:23 AM CEST, Nicolai Buchwitz wrote:
> On 2.9.2026 12:28, Vineeth Karumanchi wrote:
>> @@ -5971,8 +5971,10 @@ static int macb_probe(struct platform_device=20
>> *pdev)
>>  	macb_free_tieoff(bp);
>>=20
>>  err_out_unregister_mdio:
>> -	mdiobus_unregister(bp->mii_bus);
>> -	mdiobus_free(bp->mii_bus);
>> +	if (bp->mii_bus) {
>> +		mdiobus_unregister(bp->mii_bus);
>> +		mdiobus_free(bp->mii_bus);
>> +	}
>>=20
>>  err_out_phy_exit:
>>  	phy_exit(bp->phy);
>> @@ -6001,8 +6003,10 @@ static void macb_remove(struct platform_device=20
>> *pdev)
>>  		unregister_netdev(netdev);
>>  		macb_free_tieoff(bp);
>>  		phy_exit(bp->phy);
>> -		mdiobus_unregister(bp->mii_bus);
>> -		mdiobus_free(bp->mii_bus);
>> +		if (bp->mii_bus) {
>> +			mdiobus_unregister(bp->mii_bus);
>> +			mdiobus_free(bp->mii_bus);
>> +		}
>
> nit: replica of the code from above, but also not really worth a helper?

Agreed that the helper is overblown!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

