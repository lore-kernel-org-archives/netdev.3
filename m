Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34134183B5
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651206; cv=none; b=VOEGBfYj1fDaLpW14NOpD2vBz0YoO2y+7+AWymgPZ96O12obrj7pC89GOu/z+qPwrzVJv7AdyNra9A0r/8uaDsrgvQ8xhx6SKqmpxaKvLbh9UaZIA6MM5PFN3NGUVZZAlJTBBKENH858n354jkh87VTuqEdyQtBhdZShNw4eDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651206; c=relaxed/simple;
	bh=qjDKjhPpttI+UQx2avyK3+GZI3Dxeu06L24De+4zMsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+CsIkzr+7emvLv5v4OVsB+/MdOa5zAUH54POHSBPUcvyoL5qCNGPH0/QRCGtd//q+hvAapWPU6GbW2NEqdWsoVoQyO1tVJwj1ELNxj2yjknFMqINxtCAKR0Uti5/30sRMbG3ylGmS7dkcDO42kRZfi1i1//RxfjOkQ97z9GRlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VNmveZCM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VNmveZCM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 87C8D1A0910;
	Fri,  5 Jun 2026 09:20:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A77B5FED1;
	Fri,  5 Jun 2026 09:20:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F582106A202B;
	Fri,  5 Jun 2026 11:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780651202; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=I67YpnlUqPTyg2ONDmwiTIl0/OLYwSFgLshuT8Sr4PU=;
	b=VNmveZCMuIq+I3UZGaCG+up+nENGJ3cuI6FVdZMQDJJIGR8kl/r5zOiO86P4/DgRrnnrEM
	D8pBa7CSBHKXk1oPReFa7ZkvzEUM1vmxuIxGqQcdx05WEC7h5ZLAJiLiVD3xOrPD54sXnP
	VBG1yl1npKofoLeapWqp33tfioucmej++yy36gofN19POlmckjImK5EX4AOlaGjPt4NiQu
	VqIlJn64A0FCLkyaQAtNCOaYNEAtkGD+j3p0bApCGqAw6H48/tfnbArsNeDQgA7g/GDcfT
	oxqhMiT/D7UxybhPXNPplrE7MRYMgOz0OTSZHSFY7Q4Q9IHXbIBWPVh+sVOYIQ==
Message-ID: <476ef2e0-b090-4a06-af3c-d2b97641cdc5@bootlin.com>
Date: Fri, 5 Jun 2026 11:19:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] net: phy: clean the sfp upstream if phy
 probing fails
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20260601084029.815461-2-maxime.chevallier@bootlin.com>
 <20260605012403.3513979-1-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260605012403.3513979-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 6/5/26 03:24, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: phy: clean the sfp upstream if phy probing fails
> 
> This commit adds a call to sfp_bus_del_upstream() in the probe failure path
> to ensure the sfp-bus is not left with a dangling upstream field that could
> be used during subsequent SFP events.
> 
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
> 
> [ ... ]
> 
>> @@ -3775,6 +3778,9 @@ static int phy_probe(struct device *dev)
>>  	return 0;
>>  
>>  out:
>> +	sfp_bus_del_upstream(phydev->sfp_bus);
>> +	phydev->sfp_bus = NULL;
>> +
> 
> [Severity: High]
> This is a pre-existing issue, but if a subsequent initialization step fails
> and we jump to the out label, should we be calling the specific PHY driver's
> remove callback?
> 
> If phydev->drv->probe() succeeds early in phy_probe(), but something like
> phy_setup_ports() or of_phy_leds() fails later, the execution jumps to this
> error path. Without calling phydev->drv->remove(phydev), any resources
> allocated by the driver are leaked.
> 
> Also, drivers like dp83640 register the phydev with external subsystems,
> such as adding it to shared lists like clock->phylist during their probe.
> Leaving dangling pointers to this unbound phydev in those subsystems could
> lead to use-after-free crashes later.

Good point too. I've sent a V3 already, so if V3 is accepted I'll send a
standalone patch for that, or include that in V4 should it be needed :)

Maxime

> 
>>  	if (!phydev->is_on_sfp_module)
>>  		phy_led_triggers_unregister(phydev);
>>

