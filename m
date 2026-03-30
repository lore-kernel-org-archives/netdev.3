Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336243C0612;
	Mon, 30 Mar 2026 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868960; cv=none; b=OllzTkZGSyIw3AJfW+21lcy+RCMscUF0JMy0UK4F+GEyiKzvArLGKBV9gl1Rayde/l72S9daj2WX+yWfCMUiVOxUZ4dCQpOWPAf2jG3MrpuxQzyRF0E3qWmH7KJ30xX3KKViWsSct5AWd9feKBFMTA3ddib2IfPeUgdrxk7xw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868960; c=relaxed/simple;
	bh=k54Zap4HElXxr0bDos8RPOZ3GVUZ3bkTtMh0+mp8NjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QueNe/7WPHudyvjjNz6ABz1qdF2Y/TFKFXTM+Hzbwmz+8kEWZzoGtrT1RTKZ4vLCGiHEEmq9cgSf4CJIp6L9Qj8p+8cugZfMwzcSE2BhtFC1QJnSdO0E+EROx1bVixXHvgGV1eWpqO951u4coNQcLXt0xrB61WuzXw4d94WpLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y4WC6ACd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y4WC6ACd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 419F64E42866;
	Mon, 30 Mar 2026 11:09:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D6695FFA8;
	Mon, 30 Mar 2026 11:09:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81032104500A5;
	Mon, 30 Mar 2026 13:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774868950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xwRrRLlPDpnvyRc4Og3x+xkt86+ixqnLEHUm07b8DV4=;
	b=Y4WC6ACdtbCD0glRCzCT/ZRap1g0l6uOG/8lBc72f6DfW46Ays31m4Vcnqqgk2lq/dmmaC
	vvbViaOee6pxUpuEwH6nGz7H2+zFdwUZPRIklLTjApt0pYpx9MYSHPHKlmvHFT1g6462IO
	hs1MrrWFv2hq4qgDTf1/KdzCulKdgpqf79rqx9jApUta7dOoaygQ96tCbev+WP8NlKyg8D
	xL0HMPz0JhG8NCgnBhUEscBJSGa+3mYTcQ3NqkR3YqLAt4/JY43nyJf54W8HFVWPMsjX6a
	KB7z8XyoGR3Sfx4r5d+/bzaJ4+5b3M+YjjC5Ngc0ZoqMKN+TOGX7bFQELPe4YQ==
Date: Mon, 30 Mar 2026 13:09:04 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: pse-pd: support module-based PSE controller
 drivers
Message-ID: <20260330130904.5f0f4b61@kmaincent-XPS-13-7390>
In-Reply-To: <20260329161014.2908509-1-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
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

On Sun, 29 Mar 2026 18:10:11 +0200
Carlo Szelinsky <github@szelinsky.de> wrote:

> When a PSE controller driver is built as a module, it may not be probed
> yet when PHYs are registered on the MDIO bus. This causes
> of_pse_control_get() to return -EPROBE_DEFER, destroying the PHY device.
> Later, regulator_late_cleanup disables the unclaimed PSE regulators,
> permanently killing PoE.

That's a good idea. I still think that one day I will remove registering
a regulator for every PIs as it only brings pain and fixups, but well until
then lets continue dealing with it.

You forgot net-next in the patch subject.
=20
> This series fixes the issue in three steps:
>=20
>   1. Treat -EPROBE_DEFER as non-fatal during PHY registration, allowing
>      the PHY to register with psec=3DNULL.
>=20
>   2. Add an admin_state_synced flag to pse_pi so that pse_pi_is_enabled()
>      reports unclaimed PIs as disabled, preventing regulator_late_cleanup
>      from shutting them down. The existing dual-path behavior (software-
>      tracked vs. hardware-queried state) is preserved for claimed PIs.
>=20
>   3. Add pse_control_try_resolve() for lazy PSE control resolution on
>      first ethtool access, serialized by RTNL.
>=20
> This is tested on my setup, but I am not fully sure if this is the right
> approach to solve this problem. I would love to get feedback from the
> maintainers on whether the overall design direction makes sense, or if
> there is a better way to handle the deferred PSE control acquisition.

You approach seems good to me.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
