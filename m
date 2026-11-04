Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805604;
	b=T3vJlozTqVUSIotldBMqA5bzuHcRn58Y0klAPOr/A4k5axbGzMY+1KYBHi91enAfd4Dj
	 tRpvsms9ZvkGdCfxnG9SkrFXwpdM5wGd8FcDroqykZV1PJe6re7QIGQuNYal4Nh8iSA4/
	 m/N/NGuR+CA3v8ZiiFzdGaILzYEAgmYY3J5mEpbuo+gKpVdd3Z02OOfsDrxMc3U8vbtRK
	 7+Iu3piqLZHsb/VTPAhWKx/XQRwzDxFREJkhGwc4OdX+X3r3s8hQWhE93XXcnU8BuNr01
	 k7hUnJX45+ZocTrJdTUW9wvmMYFE7ofQEMLJve/6socodFRqIrS+fPRzirdVB/WvE7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805604;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=tvVt81974dDm61IpAOs9Ba0sQDHPKYiHvBxV+dZs6KQ=;
	b=QyuUMfJ6B4dZh3P5k+tQrBTPEsCr2YksZMgK4FAZFal2eMz7ZkXrw4MuH+auO+o/RUjM
	 aViDH1Wn0n97pGkd3ZQlr7u3YrpSv+DxjBe2DW9bs/2gpvOZEs/3BzmLrfEm7AHHgidt0
	 PkUbWlrCJ8McT5VAOoFMAt13Ip9IdHOcNGpLqDMq5J7lZ040Z9lILnZy6Mso4F1dM52O3
	 0xVPyi66yyabVJkxYuax74an9H0xwas0k7xbPIwwwbKwer8UOob/dV74JQYDnzPTGoqqk
	 liUFYHiEk1DgWRLsJ1YUBvx5qoTx47HqoZ/mtr2v6Fx1+vBkFGqvNyjadg2DzVkGxLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GRvivkqT;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0B6083624
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC0B6083624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GRvivkqT
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 16FEFC8F472;
	Wed,  4 Nov 2026 15:21:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12CD160770;
	Wed,  4 Nov 2026 15:20:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2ACF0103291D1;
	Wed,  4 Nov 2026 16:19:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793805601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tvVt81974dDm61IpAOs9Ba0sQDHPKYiHvBxV+dZs6KQ=;
	b=GRvivkqTIqK4QgRIMpMVcKj7g9FAYSk5xLU8U+mFqx1RJ3kgHy7OYYG3Cj1nbL/detV/qe
	Ah4b9U5chZFnlCWkqPjHk8TadhZ/6KWin25D8hlewqxx75uxsm/Vm7kJPf/4w8WogulXqB
	yTCBS9wHogh7Olz096i4cCrl5eZq4zCP6SNvI4hnC9eJK5pNfXbU+ijTiqodZVkY0Ecznc
	6V6p0JLgFgGPwQBGo9UcFpbICPfwNNKWRWj1nf3R4mQjh9/6bJ62D5wjbOPtozXMwFU9iN
	cNW/CBp/TgJHiVtD02PZ0+Du8xcuNi5KU0Fm3dFG0VrqMCIzLRslD6WJqsFh5g==
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
Subject: Re: [PATCH net v3 11/14] net: pse-pd: free the notification kfifo
 when registration fails
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
In-Reply-To: <20261103220217.1131971-12-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
 <20261103220217.1131971-12-github@szelinsky.de>
Date: Wed, 04 Nov 2026 16:19:34 +0100
Message-Id: <179380557481.1333589.9794436031902414643.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 03 Nov 2026 23:02:14 +0100, Carlo Szelinsky <github@szelinsky.de> wrote:
> When pse_controller_register() fails after it allocated the
> notification kfifo, it returns without freeing it.
> 
> Free the kfifo on every error path.
> 
> Found by code inspection and AI review.
> 
> [...]

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

