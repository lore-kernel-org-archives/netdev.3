Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26E2E5B21
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784380324; cv=none; b=F5QSGenD/yDFiTpf6UBBh6FjEBnd1n4PCjxHSwS2DINsDKmgWdfkmUrKnQhR/Kc/2YiPhz+Adb/ffEzPeVJe8mkw1pxTBK5Xp2/jhRdIqFavsqk3ITAP7PZBU8MXAsGkxo0Wx9FyXkUSnjjWIy8JB2IXHeBm4Nw+JAHYfIpV2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784380324; c=relaxed/simple;
	bh=W7XQTfuqTrDmbhP5coXZZxglozsyzmYIoIR3YFg+OWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfeXDof6bgNh9Gb/MXJFlhhpo1F6gf++HcRjUtIAHc8XNjyn+3qoUThLY/SQerSXW9BFZ9T4gg0dLtblTQEqOx3pSeCoVGUss21Iu2Wk5K4gR5V0pXkUGYSNwWepmmAratBuGMlHBv+B3FHSKlpOu3y5t9hp7ypi6PEhLRnDkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=scMZnhvw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="scMZnhvw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4A4514E40E3D;
	Sat, 18 Jul 2026 13:11:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0143360363;
	Sat, 18 Jul 2026 13:11:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1B6E11BD0158;
	Sat, 18 Jul 2026 15:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784380313; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cn+vNRSAkypeyWe3eKFZ40rnV6QGEwFkM2avWDWeb2E=;
	b=scMZnhvwSngQMHWZOFIwUPMeWPesFgskntyrktS9mKXj3G1XBdLK+Xe4pUEfqIY5zj2/Ku
	k0DYncVxXhb2SOAj25EGQMDVAjXyP3ua/fzu8JaCHUutfjv7dvaPFOJu9wzcJ4/FB8+rdR
	Uj4WI5maLAQ6B5KNWZLRUQM1WLZ/W41Wjtb+SxOQ3KO4VPS/qYVMp2aZRD5uRD6bnrFvaM
	IunscxDiGY0nrQ+CVNNN7gCKuCzUv0UH07hs0/FlTJ6o1Wn8HB9fdab+YyplnblPj4Kgqh
	EP0l/8UZS4RK7R6LBds4iTd5z+2n+7qL8oa5NRHr11D166tjjgW1Ey1OXGpkJw==
Message-ID: <46e90a47-4507-40fe-b74e-efef932e9b62@bootlin.com>
Date: Sat, 18 Jul 2026 15:11:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
To: tresonic <tresonic@mail.de>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, kuba@kernel.org
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
 <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
 <09ee8651-4f29-4ae0-8e82-a32a1f7ad04a@lunn.ch>
 <97d803a5-ca6e-4d4a-adc2-f97cabfded65@mail.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <97d803a5-ca6e-4d4a-adc2-f97cabfded65@mail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/18/26 09:35, tresonic wrote:
> Thank you for you explanations!
> 
>> The interrupt is being enabled in the init_chan call in
>> stmmac_dma_ops. Ideally, it should be disabled in a mirror function,
>> which currently does not exist. So maybe deinit_chan() needs
>> adding. But where to call it from? init_chan() is called from
>> stmmac_init_dma_engine(), from stmmac_hw_setup(). stmmac_resume() does
>> call this. So we need something in stmmac_suspend(). Maybe in
>> stmmac_stop_all_dma()?
>>
>> stmmac is messy, there are often not mirror functions. If there is a
>> stmmac_init_dma_engine() there should be
>> stmmac_deinit_dma_engine(). If there is stmmac_hw_setup() there should
>> be stmmac_hw_tairdown(). But none of these seem to exist. 
>>

(sorry I missed that thread, I was on my  way back from netdev)

>> Anyway, do you want to try to implement deinit_chan() and call it from
>> stmmac_stop_all_dma()?
> Yes I'd really like to implement a solution here.
> This is my try, but I still have some questions:
> - is it ok to disable all interrupts on deinit_chan()?

It mirrors the init, so it should be fine. Now I'm not sure how that
will interfere with things like WoL though, I've yet to test this.

> - maybe the interrupt could also just be disabled in stop_rx?

I don't think so, if something is missing w.r.t the interrupts being
enabled when they shouldn't, that would need to be addressed in the
xdp part, as this seems to be the only place where stop_rx is called
without the dma_chan interrupts being masked.

> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 829a23bdad01..65c243fb829f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
[...]

I've given this patch a test on imx8mp (that has a dwmac4.10), no regressions found
from running basic tests :) I think this is a good fix, if you submit it can you
address both dwmac410 and dwmac4 ? They both should be impacted by that problem.

Maxime
