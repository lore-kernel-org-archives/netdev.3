Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7A37DAAD;
	Mon, 10 Aug 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366960; cv=none; b=JyICZg2txSlMnz6nPu2jSpY9QQLssMYbfMVH0H1UEafmyboTxavgu0utknX8bKKjGHsnY7tjhugVkqjhwp85k5TheXd9FIIb2Y0NjW5zBiItsyV6CkUeZ0rUIwJK5y9emv+IHIzjPRfyl8nQZRB9uz0f+5I372PSjVtcLQZ26lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366960; c=relaxed/simple;
	bh=uokSZrydFohbnmS+P0Fsev61dd7ELdkdxao0rxTGty8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liDuofaTHMhD5sa1XTyV6+zu9KcjHdonT6yw7QG+oo8KklLTz20SzokIocuYnxI2GyNpeg8guvj/pxlkd/BFUUhwf+mekG5P5F5en8VMzxrGOC9apr6jP/pi0rnOQFhtBRBUUt6OFolTWgZxHKKX+KBgWG/nGyAvnanif8OpmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TJgvyaC9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TJgvyaC9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B93931A152A;
	Mon, 10 Aug 2026 13:02:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 866F06033B;
	Mon, 10 Aug 2026 13:02:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6ACE11C4A5E4;
	Mon, 10 Aug 2026 15:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786366950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hqFO3D9DbwDQyyIT3yXgSf3uoDLEoHFJDn2WAUyQCtY=;
	b=TJgvyaC94XDDCIrFljSLRtJeyEXUAOx6xVeJNa3BU9b8pP4LnYzkEeKYqUhreWaSgruxZZ
	s/ULuUyXKPbVLItbj5hmZYHjyL8Ss1GkVg6rXy4B8PRRCOt465ckYfBYvJYzf9a+yeTvk5
	C4NjwWgJ/f3s/3Jjy8kK5tcGCqvmsOzhha5QECkQlCHLIX+9uPREyo82ScUbTnRe2Fv7QT
	i3R7rCxjukUDEsAerokMZ3Q5KCgGY7b+iXSQdntfyKLEZ4rEVSolA+ICZTWoXpzHD/gaHx
	PUhA5vPXrPcf0uMZ01JZM+RkwE6qusV+HGXSjKnuPAdSbg3XI832uR5e5pVXWA==
Date: Mon, 10 Aug 2026 15:02:26 +0200
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
Subject: Re: [PATCH net-next v12 3/4] net: pse-pd: realtek-pse-mcu: add I2C
 transport
Message-ID: <20260810150226.3cf36dc9@kmaincent-XPS-13-7390>
In-Reply-To: <20260809112251.5797-4-jelonek.jonas@gmail.com>
References: <20260809112251.5797-1-jelonek.jonas@gmail.com>
	<20260809112251.5797-4-jelonek.jonas@gmail.com>
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

On Sun,  9 Aug 2026 11:22:49 +0000
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

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
