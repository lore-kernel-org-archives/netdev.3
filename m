Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22794318B8F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126291; cv=none; b=Ljr0DIyOhmXlQ9wcE05pgysyKGvzBcyzmm+qJLf8erSh+pK7W8vf1gFqk2vjOca+kB2xC6EJJCrxuSrj2XyzCm+mteeiw7AODXMuCByYqHJFoe9oBV7hIce8sW7mvmLCLa6tFW1pDdCVCIBacc5a8jhGlqT3iW5swos1hmEiSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126291; c=relaxed/simple;
	bh=Yw0oaVLkmeZbACuKe5ikhhQ7YiR09NgS6IZLVZD9zpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLUTYvzk+ySFk7uFy+XTMDOD/H7jcJF8VmqOUYLYONbKY+KChzo4VHasLo1/G+e5eRP1yUesMrchxP4MSdkaHFnFMLs1Lqf1sPNmp7S6PYE83iGh0Xc2rfrjz0nXXA5SYgc1rDhD23UzNSVi5l03t2KhsGX9SH5BWpfiKVd+gWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=dJfwElNG; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="dJfwElNG"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90E675E88C5;
	Tue,  3 Feb 2026 14:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1770126285;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gr9BnoVlnkMBjsUw7Vp5Oum5kiag9K/cDsBuGmAhMrA=;
	b=dJfwElNGiNxDEF5tabwjf3pxSmSb24icLUwisyXHHlEgMf0a44bIuSWuO/bu9m48u9EhRr
	H0HdeOyPRpcc8geOhl24yyPnzlmExblD+oadyP/tWnO1UeaF7lBeaxUo8f8wsbLWmXr7xb
	wAvKTirELgSaFdedHlQd/VUEolPV9e+K4nrOgvkGe5BEt1/ShAJErVsoLuKNEzSJ4T9RkX
	PQBX1wKNlOhW57U6O52+5lrpqqTJ5xSiPGs9bQMMfhROyFqdsE3HzqQeh0ZBtRHmdg03ZE
	Js91YaNISgOXuT21iFoI40AQE0brHZi3FnnENl5cCqwfMBjBLvkB5smFoLpInA==
Date: Tue, 3 Feb 2026 14:44:28 +0100
From: Heinrich Toews <ht@twx-software.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add
 microchip,single-led-mode flag
Message-ID: <bg6t5lhnved4tvjz4zxt77hjvwp423tr77xlwbiebty45r3ry6@4eghzotqon6h>
References: <CAJ+vNU32MJA_YqX6Q3XVZViYrZZQD+ro83dUyRP+t57taghrWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+vNU32MJA_YqX6Q3XVZViYrZZQD+ro83dUyRP+t57taghrWA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Tim,

On Fri, Jan 30, 2026 at 11:19:30AM -0800, Tim Harvey wrote:
> > Hi Andrew,
> >
> > > Am 28.01.26 um 16:22 schrieb Andrew Lunn:
> > > Is that really true? Generally, what actually happens is the
> > > configuration is left alone. So if the boot loader, for example, has
> > > set the configuration, that configuration is left unchanged. So it
> > > could actually be in single LED mode, not tri-colour.
> > >
> > Oh, you're right. We cannot assume a hardware reset state here.
> > Since the driver currently does not touch these registers, the configuration is indeed
> > "inherited" from the bootloader or the
> > hardware strapping.
> 
> Hi Heinrich,
> 
> The setting the SW_RESET bit of REG_SW_OPERATION in
> ksz9477_reset_switch() resets all switch registers so even when the
> mode/errata are taken care of in boot firmware that gets clobbered
> when Linux starts. It is not inherited.

You're right. I see that ksz_setup() always triggers a switch-reset and
there is no device tree property which could change this behaviour.

According to the datasheet (DS00002392C, p. 86), setting Bit 1 in 
REG_SW_OPERATION (0x0300) resets all internal registers, including 
PHY registers. So the switch indeed remains its default
"Tri-Color Dual-LED Mode" if microchip,single-led-mode property is not set.

> I have this switch with single-led mode on two of the boards I support
> (imx8mp-venice-gw74xx.dts and imx8mm-venice-gw7901.dts) and am
> interested in seeing your v2 of this series. Please add me to the cc
> if you would not mind.

Sure. I will add you to the CC for the v2 series. Thanks for the feedback!

Regards,
Heinrich.
