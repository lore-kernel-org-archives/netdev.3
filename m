Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B21EA84
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672283; cv=none; b=Vm8qJF0Vk6YG8kysTODMg8QuoizAqTCfuaJeakH1LnbFV9Jvd+Ra+BvoVrUTPazIhMtJcVme/24KbNxtLUXM+MylDtbMFHStf0L7O6uh9lof1N/e/yeC/Dz8PzqotB+FealiYHC4iT+ZhvdhWFEb6oJGawTWwwb8W3Xk7VDJvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672283; c=relaxed/simple;
	bh=1g5WFjlGiiibxjESiyPtDH+1591pyc/aUWQxj5T23FA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljBCVgyNnG6VjUwSLD3obg7w3rHOWoJ8O6N8C9n5Bx1R7Y57BB7ITFdiAZJ1w+2xgkkZovp8Mr7sop+SYoqMe7Q2nKjYXLlSu+iEX9FYuCJDpEAxUiKkIDwAtN8Bz198Wv1KodJdYTCddllwJJ+O9AoEK+Q7QbIUlu/W2DWuews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WZ1B2ldm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WZ1B2ldm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 969C2C55049;
	Mon, 16 Mar 2026 14:45:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E60935FC4A;
	Mon, 16 Mar 2026 14:44:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B67A4103721B9;
	Mon, 16 Mar 2026 15:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773672278; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IGC4VRqY81B5t0LIt3uvpRW2LAZUsttTwB9fKzsqiPo=;
	b=WZ1B2ldmHUrwJtX6hcemVq7m7JX8V4W54BcuX8XPzk9wqSZ2WzEVTN03RC2oX433BtNFKe
	6EnPBWpLdUa144oPlN6LI0KlDJT5uJZ8NypT1e00IyuED9gPGec0cq14ln+SW1vwTTWmLc
	BNKfzN2o9X0uVZjmKBRc+Ixa+yR7OI1TFYWQIln/XIVP76k2eab6uddIqA8u44GzlNXSbq
	HEKfGPNvMgxHxJ96fAA4vWdS87Fc1/9AhaN+aDunoFX4AhdVaV6/L2ZuVY4sC5JdR6/jtp
	KHiOfTNXhUNr3pc7fhzBtr832hjNOR9UrMCPjWMTx5yTCeD9mbhu+IqSjp7Zpg==
Date: Mon, 16 Mar 2026 15:44:33 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Carlo Szelinsky <github@szelinsky.de>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pse-pd: add LED trigger support
Message-ID: <20260316154433.032346e5@kmaincent-XPS-13-7390>
In-Reply-To: <abblHRq6Q85j5lXA@pengutronix.de>
References: <20260314235916.2391678-1-github@szelinsky.de>
	<abblHRq6Q85j5lXA@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Carlo,

On Sun, 15 Mar 2026 17:58:05 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Carlo,

Nice to see you trying upstreaming the PSE LED work.
=20
> On Sun, Mar 15, 2026 at 12:59:16AM +0100, Carlo Szelinsky wrote:
> > Add LED trigger registration and polling into the PSE core subsystem.
> > Per-PI "delivering" and "enabled" triggers are registered for each PSE
> > controller, with a configurable poll interval via the DT property
> > "led-poll-interval-ms". =20
>=20
> Nice work. However, this needs an architectural shift.
>=20
> Since the hardware lacks interrupts, we need a core polling mechanism.
> However, the PSE core already has an event notification framework. The
> new polling should integrate with it instead of being LED-specific.
>=20
> Please consider this approach:
>=20
> - Add a generic polling loop in the PSE core. It should simulate the IRQ
>   handler pse_isr() by detecting state changes and pushing standard
>   events into the existing ntf_fifo to be processed by
>   pse_send_ntf_worker()

Careful with pse_isr() there is a tricky case between software and hardware
managed power control. And the irq support was mainly designed to support t=
he
software managed power control case.

Adding a generic polling loop should be indeed similar to what happen in the
interrupt process. This mean we need a polling_handler to report the events
from the driver similarly to the irq one:
https://elixir.bootlin.com/linux/v6.19.6/source/drivers/net/pse-pd/tps23881=
.c#L1348
And either modify the devm_pse_irq_helper() supporting the case when the ir=
q is
null or adding a new devm_pse_poll_helper() helper. So either the core deci=
de
to use polling instead of irq either this choice comes from the driver.

We have two cases, interrupt not supported by the controller or interrupt
supported but not wired and the polling case should comply with both.

Note: You may also need to modify pse_pw_d_is_sw_pw_control() accordingly.

> - Do not poll inside the LED code. The core state tracker should trigger
>   LED events as a reaction to state changes.

+1

> - Please add a define for the default polling interval. Include a
>   comment explaining why this specific value is chosen.

+1

> @K=C3=B6ry, How should we decide when to enable polling?  Should we check=
 if
> no IRQ is registered? Or add a flag if the controller lacks IRQ support?

Replied above.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
