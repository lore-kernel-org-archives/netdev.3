Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50C306757
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231795; cv=none; b=JiY/fm6oB62OkIqDHrM2zC/MJe8LmLEiku6FTYzvB+B2QRYvbqWEv4VlKECSgR9EbPUT64qJb3aqZCuD3afkA68Ix949rnNG3Jn2H7Rr/+2+m0rNcUu7PJYxkyYcHj1U4ul/epKL60HlN5NoVF5MfoPFj1BL81mRJppAbNOwi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231795; c=relaxed/simple;
	bh=vpm2sYXVp2f19p7aRTZC+CwjaVK2aPR511GU9AtxiTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WS0cuxqZeX5urSIahQ655zJRU3l232OkXRFDSNHJ870vUAPyZ6nVt8RJs8deOzefI316DN8JY01Y+Fp6gClszevnWHrXEl+rtVVUJMFXGlV85/sYbwA7gr8WCdPtWY31kCtWAqYDdUBg3x9sHdk/PBeMiXlXoBqG8eG5D0oT9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YE5a2DeG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YE5a2DeG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9B2221A08AE;
	Tue, 23 Jun 2026 16:23:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 57704601C2;
	Tue, 23 Jun 2026 16:23:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E7DC106C841A;
	Tue, 23 Jun 2026 18:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782231788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/9CbdAPN/4V+FSMLtSl5yulm65CsF7yRuepdwDsnG3I=;
	b=YE5a2DeGmMl4nhclGldtGgDPhgjcVG06bQ67THBJgVOCnGHBEb/G7C1pXG0iHvf1ZJQcQY
	b4k4eQ5Km9bP3HTv74szkqqfJD7c5Weq6CnltVyxIV4/WAplF/7YowNGJZA1NYiQCIsP7x
	KtstEYRrDJ23nwq5f3E9yHdDNbWBTHIZCVPagjuvrs9VHChsiECSU642Csf8I/ui6JAQlQ
	v0oNJsl9Fq6q2cIi44cqMfNJvX733/ebA2aVAJDDMfgsmGd+wKRaujWcycg2r1IWBy3oSI
	t3UToQRIxF9wTQ0RiiO101u3NUFMhZXDacI1FcvqwERrPNv9PatCuzxqg0JMJg==
Message-ID: <376a850a-dabe-421a-b227-9b612056583f@bootlin.com>
Date: Tue, 23 Jun 2026 18:23:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: phy: sfp: free mii_bus in
 sfp_i2c_mdiobus_destroy
To: Petr Wozniak <petr.wozniak@gmail.com>, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, bjorn@mork.no, olek2@wp.pl, kabel@kernel.org
References: <20260623080538.7646-1-petr.wozniak@gmail.com>
 <20260623080538.7646-2-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260623080538.7646-2-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/23/26 10:05, Petr Wozniak wrote:
> sfp_i2c_mdiobus_create() allocates the I2C MDIO bus with mdio_i2c_alloc(),
> a plain (non-devm) allocation, and registers it. sfp_i2c_mdiobus_destroy()
> only unregisters the bus and clears sfp->i2c_mii without calling
> mdiobus_free(). As the only reference to the bus is then cleared, the
> struct mii_bus is leaked.
> 
> This is hit whenever a copper/RollBall SFP module that instantiated an MDIO
> bus is removed: sfp_sm_main() takes the global teardown path and calls
> sfp_i2c_mdiobus_destroy(). sfp_cleanup(), on driver unbind, frees
> sfp->i2c_mii directly, which is why the leak only triggered on module
> hot-removal and not on unbind.

which is worse, this can happen many times in a row :)

> 
> Free the bus in sfp_i2c_mdiobus_destroy() to match the allocation done in
> sfp_i2c_mdiobus_create().
> 
> Fixes: e85b1347ace6 ("net: sfp: create/destroy I2C mdiobus before PHY probe/after PHY release")
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>

With this patch sent towards the -net tree,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/sfp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 03bfd8640db9..c4d274ab651e 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -963,6 +963,7 @@ static int sfp_i2c_mdiobus_create(struct sfp *sfp)
>  static void sfp_i2c_mdiobus_destroy(struct sfp *sfp)
>  {
>  	mdiobus_unregister(sfp->i2c_mii);
> +	mdiobus_free(sfp->i2c_mii);
>  	sfp->i2c_mii = NULL;
>  }
>  

