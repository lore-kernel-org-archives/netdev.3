Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97953AA4EA
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281545; cv=none; b=RqHsXJHMefaemwZZbvxTufMQFCw+QscMCDcva4Opw1ve6vQvzUcg5Jm73LNbB0+jJIaJVccmgCUlxnzrh18VpbIDG+5Txcl4qUpYbxszino2onBCXHPJAJtOubtGJ8DNQzw50TrMUY1Kp/CmLLb0WCNgzwRwEVHVKuYBnf3iH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281545; c=relaxed/simple;
	bh=q4DNE14uleoaxP4X+LKSwVON3yaSQA2obiC+UEhZSLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhN3VtKvpkm+vcDamcQuFPAOWlxGb2XVHg3NSpynsJS3pdLS5pPOH4DsY+UZobI8f6mDe3CuoxHOBc7Ieqq+XWURTc3/K/gvzVxCZsXdjmkRQti7FAbDio3WQ0k00DTdLfNTN4/s8aK1gloDZFKO/DKngjHwNmGKHZgaXwCLidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kTIX+wmE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kTIX+wmE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 92920C2B9F7;
	Fri, 17 Jul 2026 09:45:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D34CB60361;
	Fri, 17 Jul 2026 09:45:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EDC311BD1330;
	Fri, 17 Jul 2026 11:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784281540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q4DNE14uleoaxP4X+LKSwVON3yaSQA2obiC+UEhZSLc=;
	b=kTIX+wmE6ai2cI5OjVMUmrDUaexRF9SpP/mS9fVVbSDoPkwkjUD2xAb1jMEF/Zs8sdPAhZ
	/cOJzbeGADlaRSa4tRqnrJDpV+hUkor9vjLmklmQt4P3HOn8MNkcjYGPH+ESgV2L8kExFt
	UPjN4jNq98g8OeZ/xw5u/XSYijx6MPDJ+tE7buRBdYWv5kcsDn745++JJ3/CjeaiR2MKoh
	Ngt0IT68e/nCzhdwmSRautdYcPpgB80SWBjypLnAs2WZNETN4gK+daqEm00e5YO93tdSfQ
	6iBEcJaZVXB9sngoJomd6TA6rJhpqtSueBGXs6TPaxFhOPBbvQ/R6JWuFGpFqg==
Date: Fri, 17 Jul 2026 11:45:37 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v8 3/4] net: pse-pd: realtek-pse-mcu: add I2C
 transport
Message-ID: <20260717114537.48f49485@kmaincent-XPS-13-7390>
In-Reply-To: <20260715075530.2491534-4-jelonek.jonas@gmail.com>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
	<20260715075530.2491534-4-jelonek.jonas@gmail.com>
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

On Wed, 15 Jul 2026 07:55:27 +0000
Jonas Jelonek <jelonek.jonas@gmail.com> wrote:

> Add the I2C/SMBus transport for the Realtek PSE MCU core. It registers
> the MCU on an I2C bus and provides the send/recv callbacks the core
> uses to exchange the 12-byte frames.
>=20
> The MCU firmware expects one of two framings on the I2C bus, and which one
> is part of the compatible: '-smbus' (reads carry a leading command byte
> and a repeated start) or raw '-i2c' (bare block writes and reads). The
> match data flags the raw-I2C case; SMBus is the default because that's
> what the majority of devices uses.
>=20
> Because i2c_master_send()/i2c_master_recv() may DMA, the raw-I2C path
> bounces each frame through a heap buffer rather than the core's stack
> buffers; the SMBus path is unaffected.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
