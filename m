Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805599;
	b=wP3FAhmhKx3q+3CdjyT22Wnve9wS0IYag0f+J8hVSfM3fCHS77A4ROzPlZXxa2Ndc58t
	 Hr918XIErlgSd8mURY/9FdiYIyshifxoQR5c31aHN6MhqDle6H281IQw9pRd6TkSxANAy
	 //RNFxBqMif28aXD9XZ8R2fnGqsph0bSgAXUfS6gZeNRul5VgcHnYkvkOgSO70bXuYdj6
	 bgHh0hVmia9F3DaR8ryLHAAMGZuow/850rp59Y8T+25VNMK2dBd7wkdSYYl4OCkOS9lBR
	 2Z2qMTWwW4ECckK0kqpFsHYnYX5eK4Ch+UVqnx45c1/VA8l6qcKkaGQfO/oSDaPr/Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805599;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=1vYsnOf0pcSBEhv+qYUPA7uTPXegSNz6pmF1iuHj2Ig=;
	b=qBvK39Zv0KaBJjH+ZV51Ic8CfmqOYgIPoEZw5k6vU03NniiG+IQxQZjMOJjI2y31aebG
	 ICy50ifPnSS9jnlQoufHZfX5fhGy05J6zLfLd4GT/KzghkmembXrXgJKpmInTI2veH9E4
	 5snHslUbrZz65k0kT3GwV43vGAkI3gQKNgWKIDkwUETAix8QxSG898dLobPWYIp7rs2pl
	 s0lKUrEkrhUzL+86m5sr9/D9VM0r78erReW5tQX0F9pNby88cbsWjIonrsiUJmaNaiEc8
	 sBGR4nnXzpKdGCTD1Ez/kEWnBXIkbtF9YfeZHt9+MPzz7gIP4wmJcX1o1O4fAek04pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RI8n1doZ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA5607477A
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8CA5607477A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RI8n1doZ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 714EA1A145D;
	Wed,  4 Nov 2026 15:19:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FD3460770;
	Wed,  4 Nov 2026 15:19:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA8DE103291D1;
	Wed,  4 Nov 2026 16:19:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793805596; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1vYsnOf0pcSBEhv+qYUPA7uTPXegSNz6pmF1iuHj2Ig=;
	b=RI8n1doZ24e5lp563mCYI2FwK6ME6AAO2Q+tWCrxV0h5W4iqc6uhNqICWo+niO5NERQVGV
	gSszIk4D/XVVCErrLdr7ZCBGQhJv8yHlvAWfEcaxl5Vx2WVZqjAnSAgRmuZbbvlEFv/EZ/
	KEySkQjkpDWCcDOA5eHWBDkHWMin5r3P5FF06Snl8Z7UIjlqkWF6auMwabhkeM9eBAXHvt
	rtT6e+P3Ievm8MbsBVC9eCLtaysvr53zOh0IqKVqzz9p1q/PfNsJF5AoYd8yABD6BgTnfu
	LQg7AoD1KXXVgQCC5jF1iyyyGZ7z4vMdYauOzbCWbEdzLIDHQeHvywZm6RebyQ==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 08/14] net: pse-pd: stop async event sources
 before freeing PI data in unregister
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>, 
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103220217.1131971-9-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
 <20261103220217.1131971-9-github@szelinsky.de>
Date: Wed, 04 Nov 2026 16:19:34 +0100
Message-Id: <179380557479.1333589.2203505623273885498.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 03 Nov 2026 23:02:11 +0100, Carlo Szelinsky <github@szelinsky.de> wrote:
> pse_controller_unregister() flushes the power domains and frees the PI
> array before it disables the IRQ, while pse_isr() uses both. No in-tree
> driver hits this: tps23881, the only user of devm_pse_irq_helper(),
> requests its IRQ after it registers the controller, so devres frees
> the IRQ before unregister runs. A driver that keeps its IRQ across
> unregister would read freed memory.
> 
> [...]

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

