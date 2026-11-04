Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805602;
	b=2TurZ5GHqaeeb5niUD7sftBvSBMNXvD+l6J3UI81HZivl3DgSc7R/vsP10gPNgKSl8Zt
	 bIbdqB72afysYC3auvs7UoUtqP/wFLsD9rlnuRT4enm1lBpW5fxKMIPMl7Qodrw/9x66Q
	 ACrX6wuNLDmsONui+t7cGEojDFb+2s30ama2dHH5PgE7YLWM00bYUeTnq8uD82hbVYPZO
	 BL+hfefI5zP+gVgNwKbJBDzkSjXkm5AlDN4IK5lFEpQ42EooR6XYT1FEyF0p4IqkrUh4B
	 8lJHjCMbIhfLEWI9GmlHpuIWzn+THYjtcVZhzVMiqIOcFtWz9/+SdW/74b7LPfrE/Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805602;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=Z8PzF1d3Tuj+ontXGJda8/L0k9fX6Ie2H/VO+bwMLTE=;
	b=IJ5h2BtJZvEysUEcBzs2hkNvqKtxdejcPc8fF4R5/3RDcu4sd8WtP0ocNRtjGnDsLpoo
	 E4xvO4AqyQcs70sMyAo24lRqSNP2SnNktyz+lwjV/EF4ACAB0+JlJIx8MyxLtaRjfiA0w
	 PJNPCTQWgdRN/fOGG6/jynr1MR32ZrQobIxiEkMh6Y/mH0bpbso4CVLUcnKgg5X+GGG+h
	 GMmykzCs/M6vvQOCYVmY3hQ5pl3tb/vZsn5mfUlL5wIKRi/NfwIsQfB2U2bKc/19Tyrmc
	 7YD6fvuAht/0p/K6APjirJKCC7OIqdsEpQo+zwpbKROMEN1jg+9uZwVhjIWRDvkZfug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2EWB8QC2;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5B606A7E9
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76A5B606A7E9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2EWB8QC2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 302D01A145C;
	Wed,  4 Nov 2026 15:20:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0495D60770;
	Wed,  4 Nov 2026 15:20:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB279103291D2;
	Wed,  4 Nov 2026 16:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793805598; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z8PzF1d3Tuj+ontXGJda8/L0k9fX6Ie2H/VO+bwMLTE=;
	b=2EWB8QC2IMplIFJovzMVda5gOIoXlyd3kF2rrn/D4Gc5hgIS/re1j4eJRhD4K0Kqrx0dVe
	EQFjCe97NNOOjAgzXPmU7C+TrE8zOadMQ4oVnkxtpmKDra2z58QS+AQOF4khlEGkg26zu5
	rYbJXhnZktpPNAW5SJbTNxfJbHgzvu/iolGIVNi03Z47ho3XfBUzPdCWtMvd60jhcPoakW
	dkYfbIaylzO3rrVx+oJD7H7UoSM4hJSIZxkZal+vDg6rKe8sAYC7+5oMqqjoF6bO3fhKmZ
	+BTsmdqNlUbfBQ0OXvHkNlKxwNXhO3T24/umxqGOdpzX4z+gkGE+gD7QMfUK7Q==
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
Subject: Re: [PATCH net v3 10/14] net: pse-pd: keep the PI data until the
 PI regulators are gone
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
In-Reply-To: <20261103220217.1131971-11-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
 <20261103220217.1131971-11-github@szelinsky.de>
Date: Wed, 04 Nov 2026 16:19:34 +0100
Message-Id: <179380557480.1333589.2244096397403709658.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 03 Nov 2026 23:02:13 +0100, Carlo Szelinsky <github@szelinsky.de> wrote:
> pse_controller_unregister() frees the PI array, but the PI regulators
> are only unregistered after it, by devres. Until then their ops still
> run, for example on a read of the regulator's sysfs "state" or when a
> consumer enables or disables the PI, and they read the freed array.
> 
> Free the PI array from a devm action that is added before the PI
> regulators, so devres frees it after them. This also frees it when
> registration fails, where it was leaked before.
> 
> [...]

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

