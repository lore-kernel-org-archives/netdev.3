Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4743D9DBD;
	Mon, 10 Aug 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365990; cv=none; b=Wl7RT3e9vkoqmZyXIwxqMRshVQe+gjZ6fwMQgIh44ZZiSD3f5NwyYuHacdMe4L7sf20NHmpC+nq8zdzs0fEjGAnhjWxGBHOECp1sdbZpO0L5+fORKVxbqX8wl+/Lnb16kzKX9WzeukrnVUOJ0L1/E+dtFgCf8CmyLWhp/7/f6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365990; c=relaxed/simple;
	bh=hKXYGb7dCfWITqy4vCn2RRePI+KZ1rbbveIGIpJ4K9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQ7x+3ESsw6Xrtzk2/4NdukgIa+vmat23la6dCgfjKNa7Agps23oSS2UYxn20/f/u8VTWJxVF++qI2dFnZnwNOKwEdHbGyvY1+78e9Va/JGP7iHusPqP6TJcP/JalSEwNW9I2A6syYqv5Kl2nXOn3d6KuYEavfs5M1MXJY+CDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EbpetKcW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EbpetKcW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F162E4E41198;
	Mon, 10 Aug 2026 12:46:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C68616033B;
	Mon, 10 Aug 2026 12:46:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AA2011C4A55B;
	Mon, 10 Aug 2026 14:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786365984; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GXXe5YdkhDgbxuhV28Geck2k2s7V8UKykgkin4EBB6E=;
	b=EbpetKcW2MXX8NMz9aj2C2k/3mtHC5/lCQ2v4KUjJtQk79BzYdIwTgwLrJJcvu2RYYfSB0
	jw+Oht7404jFgj6s1bvwvvKYslAVcR7HjT73YGwMCuo4wtEAdrlrFuj/K6o+CPpO/doi6E
	GhfF4gTHlI7ONPCXeRde+wcKfsVc21hlRHZZJVdEy3MK1xqbOAWlocOo7ewAN5+c+bGhNa
	XE4B7ANs7Fu59Se752vv4IzsYWdWAO3KODwhcb9yjC2fENEfNFKe8rT1SGTTX2IrfW4Z75
	+Ao9NWz/P6Wagm59HGpHJbLMpjZYG4qXgA1X/jpUzFpzMIunNTFS3slCWO0Scg==
Date: Mon, 10 Aug 2026 14:46:21 +0200
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
Subject: Re: [PATCH net-next v12 2/4] net: pse-pd: add Realtek PSE MCU core
Message-ID: <20260810144621.23c14dce@kmaincent-XPS-13-7390>
In-Reply-To: <20260809112251.5797-3-jelonek.jonas@gmail.com>
References: <20260809112251.5797-1-jelonek.jonas@gmail.com>
	<20260809112251.5797-3-jelonek.jonas@gmail.com>
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

On Sun,  9 Aug 2026 11:22:48 +0000
Jonas Jelonek <jelonek.jonas@gmail.com> wrote:

> A range of managed Realtek-based PoE switches use a small microcontroller
> on the PCB to front the actual PSE silicon. The host CPU talks to that
> MCU over I2C/SMBus or UART using a fixed 12-byte request/response
> protocol with a trailing checksum; the PSE chips are managed by the MCU
> and are not accessed directly. Two generations of the protocol exist -
> both Realtek's - diverging in opcode numbering and a few response
> layouts; the driver handles this with a per-dialect opcode table and
> parser hooks for the responses that differ, selected by the compatible.
> The specific PSE chip behind the MCU is detected at runtime and only
> influences per-chip constants (power scaling and the per-port cap).
>=20
> This core module implements the protocol, message framing, the dialect
> machinery and the pse_controller_ops glue, and exports a registration
> helper for transport modules. The I2C and UART transports that drive it
> follow in the next patches; the core (PSE_REALTEK_MCU) is selected
> automatically by those transports and is not user-selectable on its own.
>=20
> The realtek-pse-mcu-* files and PSE_REALTEK_MCU* symbols match the
> realtek,pse-mcu-* compatibles (see the binding for the naming rationale).
> The two protocol generations - gen1 on older Broadcom-PSE boards, gen2 on
> Realtek's own PSE silicon - are both Realtek's, handled by the same shared
> core, each selecting its dialect via the compatible.
>=20
> Power budgeting is left to the MCU firmware; the driver advertises
> PSE_BUDGET_EVAL_STRAT_DYNAMIC accordingly.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
