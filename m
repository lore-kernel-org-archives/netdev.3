Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAA2DC79B;
	Mon,  8 Jun 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923856; cv=none; b=atq4L9ojfsTwMRjhlgN/pZ3cabUAm1p2rUmFkViAKdThoTidXcI4OQzw36bU2VGIkl7815oRXGcn9j06eGmLRjndGBvaSO6e4Jovboo6w3d7RzAH5rVZQB2K2UvNwPJa6HTBvGxhjd2mu4Dva9Xh8SazBkW2IqpGmukA51jaJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923856; c=relaxed/simple;
	bh=qXUg+nteWtBPUnVYVPWZBMAvhYW+7GCoSCkc3vpztYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFVd0pJVuwIddAXPtEfF1OXvX9oyXaWxQY2OQ5MCmbEd9bngHtig/pEYZiyltEtIeqqqaW5W7j1U9VyKvcc6ftCleZ1xWu7WHnxE1irVqQgug9DW1iU3WFz2aFI0utE2MBIOhsPbvrh/+iqOxPrrxOkqD6af9CLpsR8GplJoFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IIweEAdI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IIweEAdI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 680444E414F7;
	Mon,  8 Jun 2026 13:04:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 34E965FFB7;
	Mon,  8 Jun 2026 13:04:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 167E7106A2897;
	Mon,  8 Jun 2026 15:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780923847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l8wOaZQWYEt9bY1fDzjXvlREIzzrPGWG25SfEY5AtJs=;
	b=IIweEAdIqYEWu3IRmRy+Sn4cKgSnOn6lIS8EiTlvuKm+Jl3Q8CJBFuMeZhGBAIRYVdio1h
	3fVkai8XOPK0x98GlR8VlCiH5LW0p+ZRqgACGxqmzEvRuU3O3+66v00SvyO/dWsP4/8FDN
	iTDA7Oy2JMttiW214KEq3OwbyoAYV8a0dGD5GlwrU9BfiTsemYDQGjafKy0aLENRfnDheL
	eTHAFEGQRcP5l04MmP6pIB8+hZatTERQIek/weLSwqkZDc3gWHXPGmwazZF6gO+MF1iSkV
	ZBIWB0RfEr+9CCFIVYX/UkSpEAECGjUkJgK+JowYQ7dUVg5guvZn0FDmSJN73w==
Date: Mon, 8 Jun 2026 15:04:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.machon@microchip.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd:
 microchip,pd692x0: add port disable GPIO
Message-ID: <20260608150402.5dec0207@kmaincent-XPS-13-7390>
In-Reply-To: <20260607165600.1260210-1-robert.marko@sartura.hr>
References: <20260607165600.1260210-1-robert.marko@sartura.hr>
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

On Sun,  7 Jun 2026 18:55:35 +0200
Robert Marko <robert.marko@sartura.hr> wrote:

> Microchip PSE controllers have a dedicated port disable input that like it
> name suggest, will disable PoE on all ports.
>=20
> So, lets document that GPIO.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
