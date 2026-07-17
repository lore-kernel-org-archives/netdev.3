Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB065311583;
	Fri, 17 Jul 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281269; cv=none; b=syduPb2Qf+aUdx+QjzQHsazVwsGn5vsIhULEy/GhSt0csE/l+k79ALl04EVK8f01CVzKRdCEUSHhYKKDXl0F3/uHQq8p0s3aoYLx5BgpL/YiiZvjhKlltULoPU7ArBEboJynhxER4Hm4z79OyrOsBJ4BzUbPyx+yJggZ7FZ8xOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281269; c=relaxed/simple;
	bh=9LETj7nIcj2PedWR9Y4RSe0ujehfLOBaY0rUtk4VpCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bz4kAW8Dwp8t95Zs27wphhjLy//NyF1RBKFY549yS8QYdNYW1Cj4Mt8dJMtyLYsloaR7AUHywFM+KuCKUl+ndFZS5FvwXLoNF9mwekZaBflxyGn394GI3483bRE2K28DgD3IoHVHnyqQYV3FU7l8qOghOWXVWtnv6LNlexx932c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kPsnpNbW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kPsnpNbW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 34E794E40E17;
	Fri, 17 Jul 2026 09:41:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0091B60361;
	Fri, 17 Jul 2026 09:41:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7384F11BD03DD;
	Fri, 17 Jul 2026 11:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784281264; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9LETj7nIcj2PedWR9Y4RSe0ujehfLOBaY0rUtk4VpCs=;
	b=kPsnpNbWyyZbm21vg8w4kogi/LovjsGmSKIgN/aXIehCIYcSYok9tjvhtrPj/YYwaY/g7S
	uHUTUBGU1DyKzSlt1xKxnGvLD++wN35nf1pVSogLyFo3vpLhs+8PqpUlnnqlmLFYDihd86
	xsZRkBngAsk5suMozOEagcocVcNhQASKYetVVttRqsrCySSH4eD6191UyHOlvNWjVUVl4M
	f3F7RAAgWPqSSW/kLG0Kc90ycvjOG6cWonqDoK1B6C0V9+aHLv1shtsdLIENRuAEXCehNW
	aaZ5Xtl07p2W7oTY2+d9vDkQJIUCVrbBvoqGSkA4myRux1A9fItnhOvoABPe6Q==
Date: Fri, 17 Jul 2026 11:41:00 +0200
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
Subject: Re: [PATCH net-next v8 2/4] net: pse-pd: add Realtek PSE MCU core
Message-ID: <20260717114100.356ca7d7@kmaincent-XPS-13-7390>
In-Reply-To: <20260715075530.2491534-3-jelonek.jonas@gmail.com>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
	<20260715075530.2491534-3-jelonek.jonas@gmail.com>
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

On Wed, 15 Jul 2026 07:55:26 +0000
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
> PSE_BUDGET_EVAL_STRAT_DYNAMIC (controller-managed budget) accordingly.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
