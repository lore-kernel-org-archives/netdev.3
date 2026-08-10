Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FA3BB12C;
	Mon, 10 Aug 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365809; cv=none; b=AZKKrjoJiR7GqEqsuTZ6MDizegzZZTfCXd5SGsPIQuZFvPuv21cBqxfTmwRtwBBmzbZvfspKhsp0f8Nasx5EQ4Y/NnzAayo3XL3JyR1F4VTsNXaKRWNTvKvg5+Xf0iHghCwocadl9osEAIq8SRnbxmFr3P0li29wvKHWzF00I/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365809; c=relaxed/simple;
	bh=/qawxrdfFCKHlS9yd7+yK8Hoq3VAST5V+MFUuaA/Vi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fn/fEPgkMHDjc2X+jZZZ37fZk6RJO9xPHpgqTGMABMzUMClg4Ml441WR+X6M7Lk3I2uI/X1uj9ZlvT+If3T1NuBQAeIhxbiscQXgMcyhM2QgnXQ0FuNmSLEvpViyAlDNHf7BBixSzK9Hd4DJVxRON2Vml7AlEjv2aqOjO1gjmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M/8G0r2m; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M/8G0r2m"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 197A31A152A;
	Mon, 10 Aug 2026 12:43:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF4F46033B;
	Mon, 10 Aug 2026 12:43:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CF8C11C4A544;
	Mon, 10 Aug 2026 14:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786365802; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0hrkZD/AiU+UuEL//Iu+w7pPpUaCtAm3M4J/hmMk3UQ=;
	b=M/8G0r2mVbgq+t9nsmBvFELgNZX72Q748g/bI0nUqllNJexcQS8fCfYQwIU9jOY41xhvD1
	Fu4Zcu/B63yTqV2NTsVcgL5h5jX2RVEH5Vzv7oc7jYdls1m9MvxLnRYPMjtPJtx3dn8OvJ
	qkwD3GbKYGIRevwhTOAQD7GH8L6UGNMptyfs3HtYq07Ffih3GEYh7aTnAtfkc6+5S39saJ
	EqfG2qYtDe33d1dpp1ipubqdgdIrvjw1KHO9EFJnWLclgtpWtUebnW09Q5Kb0N9yhQj0ev
	0gV5UOWFXXs9Sc5/eTJekHsGoXjebB/VYqPoyHr5EVkeMaWN6yqNbpjLpL/YLQ==
Date: Mon, 10 Aug 2026 14:43:17 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, Sander Vanheule
 <sander@svanheule.net>
Subject: Re: [PATCH net-next v12 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Message-ID: <20260810144317.520186f6@kmaincent-XPS-13-7390>
In-Reply-To: <20260809112251.5797-2-jelonek.jonas@gmail.com>
References: <20260809112251.5797-1-jelonek.jonas@gmail.com>
	<20260809112251.5797-2-jelonek.jonas@gmail.com>
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

On Sun,  9 Aug 2026 11:22:47 +0000
Jonas Jelonek <jelonek.jonas@gmail.com> wrote:

> Add a binding for the microcontroller (MCU) that fronts the PSE silicon
> on a range of managed Realtek-based switches. The host talks only to the
> MCU, over I2C/SMBus or UART, using a fixed message-based protocol; the
> PSE chips behind it never appear on the bus.
>=20
> The device is the MCU together with its Realtek firmware: the firmware
> and its host protocol are what the binding describes, not the
> general-purpose microcontroller they run on. The PSE silicon behind the
> MCU (Realtek or Broadcom) is reported by the MCU and detected at runtime,
> so it is not described here - hence the 'realtek' vendor prefix.
>=20
> Two protocol generations exist, both Realtek's, selected by the
> compatible: gen1 on older boards (fronting Broadcom PSE silicon) and gen2,
> the altered protocol used with Realtek's own PSE silicon. On an I2C
> attachment the framing the MCU firmware expects is part of the compatible
> as well - '-smbus' or raw '-i2c'; a UART attachment carries no framing
> suffix, as the transport is given by the parent serial node.
>=20
> Each board additionally carries a device-specific compatible that falls
> back to one of the protocol compatibles above. Drivers bind on the
> protocol compatible; the device-specific string identifies the board and
> reserves a place for a future per-board quirk without having to retrofit
> device trees already in the field.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
