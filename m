Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCF3DA5D1;
	Fri, 17 Jul 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281165; cv=none; b=VeUshFjpiZr/zHn5VBpRC3VhtERxF/W8ojCZlUyTMh0ukvefqE/dbo9f30z9Jr0v2G2DGeu6P4ERZtLohOBfqsn0Gjl9GfiBU3t05KZNhXbMv2eD+pYWAbxFv5UtefvEBUIUVC2cnwCoDip2SKvK9NeeIhJ7bsx9192WJJSH/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281165; c=relaxed/simple;
	bh=Ccx/e2P3KOYCXl8JyeAppnAcaLNOm2pwVLQ0+QRDdgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=md4X+pIQFq3KaXPUOHCkoP39UHl88eRfu1zWwD1ET/+vbhGwvH88LTTezaV9WdK/XOOCG5ed/ZfxC8yFqGh7b1lyPiscnXI0nEHe5ECtsKj6sYEyS1BKw6TW/ERRmEdyJ2AmUOhx4xhYSF0qrMpUvaYm/TXv3guD+aP7C+/vjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tb4Lph59; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tb4Lph59"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6294F4E40E17;
	Fri, 17 Jul 2026 09:39:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D99760361;
	Fri, 17 Jul 2026 09:39:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB0C411BD03DD;
	Fri, 17 Jul 2026 11:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784281160; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ccx/e2P3KOYCXl8JyeAppnAcaLNOm2pwVLQ0+QRDdgI=;
	b=tb4Lph59BgwN+6y9bjs1ZKeUe2jW0c+z/rfx4rS2rGbLRocZl9sbtwugWwKHApLvPCf0PC
	bpXtjJ5B7LW9F+L0BHwZ6H7wyQTBPKXRw+5sVDhtLaMIT3u2bhUv1+mov1RmJ2qf46Af2L
	+xim+i7mjKylclu4G1By51WFfW1G94XGYTiy2R87QXI3yt8egVP9xKmOoEiGPKIMyN/Vnm
	TehB4maK/YdZHcLzRqzo1jxgct/MClwlpBAVrM6qoNPhgQJvFlcPDlTu/bbZuVeMbu0D78
	CrC2cJX1mcL8KRjYOSoiIKBbz+WiSVLYbmVe/ocq+9uyjAL9Z7DJ4kSA/LzcRg==
Date: Fri, 17 Jul 2026 11:39:11 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v8 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Message-ID: <20260717113911.4feea29c@kmaincent-XPS-13-7390>
In-Reply-To: <20260715075530.2491534-2-jelonek.jonas@gmail.com>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
	<20260715075530.2491534-2-jelonek.jonas@gmail.com>
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

On Wed, 15 Jul 2026 07:55:25 +0000
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
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
