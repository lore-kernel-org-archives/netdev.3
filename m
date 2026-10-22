Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792644382;
	b=j6ZSweV1baMyK1J14WsvZZx5nAxj7ZvhKv/h3WpZzkpUcKKSaMkgJEgVgmygvYRF0fxl
	 o1obed8tbmWS+Nzj3aDXLS8jh5fM++FE9OnX8OLsh0APJ0JwBEhlwcnGLIK9A9T3FvSFy
	 VUrLZU12O/6gCJR7wbJ5PdKfDf36nuPEYwAYNbxqb3ksD57vTlsOmuJdFIjYDZpPvj8Ul
	 qrbDHoY7nqoVtDjUt3lY0mfAhBg+YZra3Fl96+qIIYlxVMNfeO9Z135qHUTT4R1Kikf04
	 rVCCCX4mnaXfsSkfpsAf/aV9xiXw9UqvgSSQfgLk9NKPdI+FjQWOsV7wMfDltMFKwwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792644382;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=wdFwRrD+BVfZHQwBM5w0aHj2+wi05TOz4Yc/Uggdreo=;
	b=g+tIyzOVjQB8pi9bQka3HXI/oGv+D4DKfbT7N3DR5gD0aKIN8iUpWq4/Ogt67wzxcn79
	 F1RB/eHEy6l/MpLndGD7e2juHAmg4eBziphE8ZAJIMjVh9gvtsfg7j5jEBQlqudbr/R0d
	 0eOSMsDbwxBfLAK9bkz2iJr/NNwuPSn8sUDh847DzE0fpX4tHl7T38dRehv5Rd/maVtNg
	 UyXyPqN6a62OPZnudga6z4jI0ej1DLCmnr8vdyc8GKQ332f6WnfMnYBY8yv+9AIY8Ch7l
	 URuxIH7jWVHuQoziu3cfGhnrCcUjea5LgxOpkvztm02qxUQBGiH4zeRMv4dM5wMVO6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ft8Y7DbV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E6606A319;
	Thu, 22 Oct 2026 04:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 461E6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ft8Y7DbV
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 605D4200BBC;
	Thu, 22 Oct 2026 06:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792644378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdFwRrD+BVfZHQwBM5w0aHj2+wi05TOz4Yc/Uggdreo=;
	b=Ft8Y7DbVLg1SOtmQLD7h+4S3iEhbc1/WiTPk4G96QPmH1lrEI7zMG0TD1orIxv8uBSgMQy
	5XFZRLLsutRcURTmkl2L1FOnCqL10vjPaeFTcJ8OqaClr1oj/qNZD9TzTqitH3Qi1HEvPi
	KM48hlrVL24/+VJ2lH/OBlT9I+xtl6QMMHB0oo+v8fLcmXbJxH/JCVdWwxZ1XItNz6NoDP
	oA9ARuXeK4jD4unbXDh//xXVgiR+bhC/k9CMEBS3nbiGlWyrO+rBmFSxv3kfIRNXHfBVaU
	p9rGpJdRZVJLlRje9k31vksqxj8Raf8bSj7leL+MoOa1yAlRvT67Gt+3+9dubQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792644378; a=rsa-sha256;
	cv=none;
	b=TwUwG6Au+OgaP0h5lKiTqy8hjH/PwRnVzfor0Nonw2U/m99dD8lj85VYhj/4IpFaApxxB4
	Lzpg04XxrM5SUcz0sEAtmgJJcAd88eSzF6EgGCrxHBkE35TEjcueZxt3hsu3OtpTddiwsC
	eA5+yyY0cejEoKidieujf7Ruylt5fsAgYyG3bMwhTrtlAY5xQ537T0sFQa51TOtt8tQIZ/
	e3bBVTV0ZdKpOO8AgC1Es5VCTb+gE4jvYHkdI6sDxPBMV3BGTXLX28wmKHGOxEYUP3ICQd
	A2Lj/No5mkWe/3n+hWHqp+FgeltK/gRTxVCf0PYtJRWylp9ShtKDUmETJ9oTxQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792644378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdFwRrD+BVfZHQwBM5w0aHj2+wi05TOz4Yc/Uggdreo=;
	b=RS0vpSRZaXmSpVvLQ4I7PRhPXdd7Eb/K7D+Sb6zFtdsoCb8CoWlWcCsfKvmoRz3pMX8gZM
	6Yqvn+EoK7edbmi5Y/FWVj2gSbUzDcPA7n1cIa+Bc+SwtAp9WnbsWweK4DkhcUm+gOdukY
	WiZf4T1geR/fo40Ij6QIGmfIJHYzGsISI9n9Cmcu6gBErCaX4gLOzKv0xjxCMKhpqEdZcZ
	gFVccULjTgG/fuj5hDMsX+Ljt4874PUTEeLF2Bz3etWNN0M69Qn4n9Omj0b8XDFg/B5HQ7
	jPMp4yDmWk/sDeL0Iuw3xWYi1cb5px2L/qn9s2wSUc9ooLaFBd2kPVTx6l61mw==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJkh0-000efM-0z;
	Thu, 22 Oct 2026 06:46:18 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJkh0-00000009PVz-0ojq;
	Thu, 22 Oct 2026 06:46:18 +0200
Date: Thu, 22 Oct 2026 06:46:18 +0200
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
Subject: Re: [PATCH net v2 06/14] net: pse-pd: check the PI state under the
 lock when setting a power limit
Message-ID: <atmVGoQry_V_Ktu_@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-7-github@szelinsky.de>
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
In-Reply-To: <20261020171249.853085-7-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:41PM +0200, Carlo Szelinsky wrote:
> pse_ethtool_set_pw_limit() checks whether the PI is powered without
> pcdev->lock. pse_isr() changes that state under the lock, so if the PD
> disconnects in between, budget is reserved for a port that is no longer
> powered.
> 
> Do the check in pse_pi_update_pw_budget() under the lock, and report
> whether the budget was changed, so the rollback after a failed
> regulator_set_current_limit() runs only then. This also rolls back a
> budget that started from zero, which the old code skipped.
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
