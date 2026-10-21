Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560416;
	b=aiEmifMYBUES0zU54uETgwHXU7XOOzod0Aps4zpqdcd+8Ix1dUX0wS5909eio4QDIi2d
	 pwqOrOc8H1JtyWD9U3vF686rLAgN2gP1eNm3CCxiy5xqOlQkMs5Ru6ZszPc+hS+gzj9cw
	 0GvCbCDYZMMyyVy72IB/16qKjlDHbArsMiRAwOKOqGWcGBdvf+s7OgDSMS7+Tj7eBsr+C
	 wM0IvTpqJh0C0ukJXerq0uNMXGOXZewmA5171ODsNgnoxtUu2vmRdgCaA7ZNxrW6M7k+W
	 sF+ecoTO2hkabOqV/MkhrVpv5s/hNy7MPftolX6d5+1LQZT/lw5TPoUKtKudl9Dgyfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560416;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=GRSAAC2ZU6qFuCrQhqLoz6Zwg2GT2myiN4euQFPmveg=;
	b=3tUqHiaiZw4c81a3vT54nLgvl0HfM6KzB/TFxspmsv824gUOgQLy8/oWUApbh0qtkJTX
	 veh7l1itIR1HSWYn5dJ28LWclFC39crydlzlLTo8n5Mtt8bZoJfs0/VeiIBTPXJr3bhyN
	 B2QmIBA5qoL3pz28QwXrgNEokrgXPuXuddJSZ7E6UYwSRjCSvVW92yBKQElo8Cbggq3OE
	 oba2ZFZKJ6ZWa3BRyqvzH+h/CyimHqWA9kFKcag7Cg1s16aXlUzOO2YPeQOpqZ2oJwRyB
	 xTIxNxo28O/4gkGERtz4/n1GPgbYe5nsVBEmKubkA2hZcbh00QjxIoo50S5oFiMsTQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EQjIIDgv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13322606A319;
	Wed, 21 Oct 2026 05:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13322606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EQjIIDgv
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 68A33202013;
	Wed, 21 Oct 2026 07:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792560413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GRSAAC2ZU6qFuCrQhqLoz6Zwg2GT2myiN4euQFPmveg=;
	b=EQjIIDgvlveRs0I3/znFWnwho3gslO3lHirBjbfiMvv589SM1nVsX3BTGJ6q0BcpDcemK5
	Ea3ASbM+rpJafnJrvmrT4ZV9VLAYy/gU1yfJLalrygBsmnYGT/Kiz8tgLiF5qViZVfSvzz
	5DnDGoGE5JSmUfJ+UuKWotWTZONY4i+OOMp9uNC9b9L/1I9zfVqZ+/kYmOusYZORdgM1YP
	02n1X2EuFZ86DWL/Y4HHzKzuiWbpKCqozNUR8YOVzvc+ynkv7MpryWe6wczrI4Tn+VmicH
	8TsUs+daDkS7PNLUeG7ImqKltjE2W5xnhKLiLcsQYwZgJ+LZES1tHbv9vo4sWA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792560413; a=rsa-sha256;
	cv=none;
	b=Y+EyTxawTpDinjBRb6/62Zz4R7eLN13oy2jroZuiItGHQ+Dz71Yeixhm4qP+PZMWR9mnvb
	ecAl86kS+J+CTl53erW4qimB4OAtX5KYcAEvwhXJMhADHZJYhNmvRrvbRjyNkLd/GHK2ex
	EsVJdYmTCqCKGIALR7/Di1jKimONhxbpXOEjVkx55X31usLK1vzEm/64baWG9Re0++3wo/
	gKFJeHJA1D9vovbFvpN3fF+ci8gG46YKMbMg4EeN72EEx2g9oVCLT9XkJTT4+823rq1FyI
	GZ5TQaTX7GgKCg1GzzQXytihnOukV0T4kEFOSj1ua4CkaaFcRaOTfxNLybLjaQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792560413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GRSAAC2ZU6qFuCrQhqLoz6Zwg2GT2myiN4euQFPmveg=;
	b=H45o8EEH1NB7HhXyRTe5EFRd2q1PQ9peNZkkZClFn4FSq7PIDdTLra7qRztZIqr2uGSgdU
	CZSQDI9b20VVRx/ZNoIGHG4jaclVWerKdDTkrlbaKaKSnw8MyzI4pTNGKABbN6QimMK3B8
	bMUv9+nymX/6sLH+YV4FBuWNHuZqRstWf7vlwbPtFDvCCePAOuZhyVxOZM/LEopK0fHbsp
	aA+A2lWkOHDVmcpSBj2Ope6WFCNrp009Fa6rA6B9YGDTM219Kpxi8t8+4VmjUt3lIT7e60
	PcIuNMN6TgIIf6IAjLsDYlsCxKHZ/9ue2N+oC6yN9LE8a0tgzIVVw7YSrZkSeg==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJOqj-000Vm9-17;
	Wed, 21 Oct 2026 07:26:53 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJOqj-00000006d3E-0ym2;
	Wed, 21 Oct 2026 07:26:53 +0200
Date: Wed, 21 Oct 2026 07:26:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 04/14] net: pse-pd: do not keep a failed IRQ in
 pcdev->irq
Message-ID: <athNHQxpeLajrFN3@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-5-github@szelinsky.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020171249.853085-5-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:39PM +0200, Carlo Szelinsky wrote:
> devm_pse_irq_helper() keeps the IRQ number in pcdev->irq even when the
> IRQ request failed. The failed probe then runs
> pse_controller_unregister(), which calls disable_irq() on that line. If
> another device owns it, that device stops getting interrupts.
> 
> Clear pcdev->irq when the request fails. It is now set before the
> request, because pse_isr() can run as soon as the IRQ is enabled and
> pse_pw_d_is_sw_pw_control() reads it.
> 
> Found by code inspection. Not reproduced.
> 
> Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
