Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D482F0680;
	Mon,  8 Jun 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923803; cv=none; b=TxXQ5YJdZLUZbKaERYigOjHzeKH9AKWlKMIjkA6riXNLtHpgYr49NRQpmDnAy3hvOlYUcVE1tlf+L+m/8V3mjx+1gGwxc2TDt5gjHgIDG7yPr8jp7cgrCGFjTPc5u5ib4ydYtZs7fip7pcVGhHlenK2ixkuBoA8mhwyoS8h7x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923803; c=relaxed/simple;
	bh=ZfGb3yRO3uJdV97UqrPxkNCdZZ0VqT54a/R7KAZrCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFe0RiUzLdWMc9tjF9s0L6eK9V8YCoVIk5+pTLs7HKWyXu4Fk4dqWJBJg2RgecTN13Ofr/btdKwBf5fwM15LLsIyOnMd71mttztrdoJSby/rSYu7JPRoPNgLfTXKw4BCHiMoBstEDOle3DeU18KIv5kq/E4FQM/2myfiIecfTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HbMuVHGg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HbMuVHGg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CC4F7C5147D;
	Mon,  8 Jun 2026 13:03:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1ED55FFB7;
	Mon,  8 Jun 2026 13:03:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1045B106A0F7D;
	Mon,  8 Jun 2026 15:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780923793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r4XgRVe/buFyPPXpJMVJDq0d56yIUHK0TN5rUg1BD90=;
	b=HbMuVHGgzgaU1FebEzJ4oThUJCl004U9R/tazgIPhKGK/iDdnO0HNXKiZAj3RijnlIYMzh
	AXYtVmjia1G56xwW/pvix4LhG24WainLDWAgzSJbaXxHYckS4oH7Yhvt4UNkScvko2zhGW
	cKl8FeYruuV+4PRHqS4kglOH2RrXScQV27lLc3dq9tnvWksKPzDtL4yA7H4ayu3duBjgI7
	03HCQiaoFKuIby1Y8hQbSsJj5EJ9S8Hr+uG9fYxOOauoY9HVY5jFImUobNATszGDZyuDpD
	FMyeCV71DRTJsWuPu8TxSc1oqKj3P+qlvr7TNEzJMgsnuCB1P/YmX3hVZ0MbNg==
Date: Mon, 8 Jun 2026 15:03:06 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.machon@microchip.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 2/2] net: pse-pd: pd692x0: support disabling
 disable ports GPIO
Message-ID: <20260608150306.32a37e54@kmaincent-XPS-13-7390>
In-Reply-To: <20260607165600.1260210-2-robert.marko@sartura.hr>
References: <20260607165600.1260210-1-robert.marko@sartura.hr>
	<20260607165600.1260210-2-robert.marko@sartura.hr>
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

On Sun,  7 Jun 2026 18:55:36 +0200
Robert Marko <robert.marko@sartura.hr> wrote:

> Microchip PSE controllers have a dedicated disable ports input that like =
it
> name says disables PoE on all ports.
>=20
> So lets support parsing that GPIO and using the GPIO flags to set it low
> by default and enable PoE on all ports during probe.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
