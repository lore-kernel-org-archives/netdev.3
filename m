Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560291;
	b=5gYSbtIqCWqL5rV+16l/TOdt11e8HY7Qfi3kp40/WEUG/5GJgZTUKMM35QRl1dquHn4S
	 FIkiE+7EYQuyFyuqXecOQkPhoAL3ph8CZ0+mLtpLbx506Z1S0OZiJUCeb/Yp11nSG9caU
	 HX7S8JKyILPIPPbsHttMTJ7esDX5iCSCBdG5O1M34Ry9zH9MVTPV2dCMup0hYdP58zne7
	 Nwm73FtafSfHt3pZ02+ra0XE3TXmDeNAM72dZVLiSfryWVcwFPX4kMqZRuMMRhZtMn/kn
	 ZUaGnBL8tGvAnHGiHDu6sdR7UtqlyKWi9mci9P8/NiYIi1GBpf6rdufg5cJJuY2dQcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560291;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=mdCek0oxCcyTlPnZVu1SO/eHUbe8nS9fLK85pXi/sPk=;
	b=xUmxME/dlWiOh9ws+QflxW7nsb99nNR2tEe/Us0vtCYYc7VQBTMeWqeLXjvskMjrVqgC
	 6iQcekjeYsqaFpEwUZCXXEbaLthy/qK8/5Qywsx5l08VuPltOf9Q+v7RzDKFs81U86jP8
	 AVyA8v2GprCNcwly4sLyiDyQ2nXqokLiw/rPBO3zs5Kn6XzJa7jndG9zPuy/vkhFKCB+v
	 HAsvgQtzdlAmxoabUKkENfh8ZFlWqzl1EmH888v5u0tcNM9mko/UOxt8YnH+6EZn0dtdU
	 aHkaPiIJySf5nx/7ccV6nPT3aD+FeqkEbljNEDtNlTNDXVX6DvGEdUBjdZMT+P5KQ2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NCQZ+xRS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A18606A31A;
	Wed, 21 Oct 2026 05:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A18606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NCQZ+xRS
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D74AC200F60;
	Wed, 21 Oct 2026 07:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792560287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdCek0oxCcyTlPnZVu1SO/eHUbe8nS9fLK85pXi/sPk=;
	b=NCQZ+xRSUaXSO+Timj/m5HSSwib0jQ32qyk2sxNRd13vgRILFW74v4HW3XN4taqPzVTrwF
	PvD3JgDGxPCh2OtNH3VKO4Wg/zLBHvH5vFeiZvtahRHAzkLs00A6eccfErxMNmnflbehmm
	/R50UiWU5wLBt7NwB6M2jnvvV9SJLCCxzeN3et7QKMRGczYdx6t/R2cOiR3rCtuiW1OZyT
	99fiNqEcPAkSXxMCQWuJQ5i/2o3AFhURAgDZ+vcEOUJHZhFlZSdtJCAMwWeOgNagrkszEn
	tfuNhQ+efRl6uj+mZwDXPL/i9Y6T3IEE5VMMccKbLz/XyZFuhwqfK25r/zHihg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792560287; a=rsa-sha256;
	cv=none;
	b=HnHWKp9ZAN1BRGReMe1NIjCnzDGqsN1rjSflSnLXHKJz0M4lQiObdMVDi2l1Cz2DVDcYet
	0JbJ6JJzu7vc0UIE76aZ41lsuLLBgvPwx1Fl3EDqqkc5o1JH3eyFfIFQURfimAvfLegnMh
	8Ii82Zg5O4bvOcrBtAN4mnIdpJYUOxrX0itNHJmx0ThY0/LIKyFltaHtc8vqimfnt4bkSv
	jgkqdl3oTsEUhUgJBJysI66Fe1fAUPiRFVJTZB/xYtMCt/GiwTzVlZ6+YhEKdJZgxBLGuz
	9BdiPhhU+D3k3bD7zitjwhlnHQtJ0qmN3/EkH5LuFZt2rxbkbrJ/KpcIMBVAKQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792560287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdCek0oxCcyTlPnZVu1SO/eHUbe8nS9fLK85pXi/sPk=;
	b=WbMB1QyRYzqmi3xaKySROmwOgaLvNiseQaAwBKz136kJEujtCog9MVNOqYrlYoFIfyZMg6
	eLdDYMelPLm7vHkDLUCwoWImwEPApAEcExUjaX5SJfX6aNaRM6hpU5+OcmhC32aOU88Y8Y
	p7zVtCcIXUPGadGNSTkmV+9Cg52wjHk661KbjWg7/uTBcK85g20uJVbjECWe23jrLNPQia
	x3vwnBxJifKgSVrRT9EErZTZVH9uDSedvd/8lXDEpCAVlxi7CtszVBsewU3giUKDGx81T1
	yZMGX5GshrpB5QCk3hsCE+hssEAZZiIaSb5M6G07IAhNWZdHv9p/R/CXppLs/Q==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJOoh-000Vlx-2a;
	Wed, 21 Oct 2026 07:24:47 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJOoh-00000006d2w-2ut7;
	Wed, 21 Oct 2026 07:24:47 +0200
Date: Wed, 21 Oct 2026 07:24:47 +0200
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
Subject: Re: [PATCH net v2 03/14] net: pse-pd: fix module refcount leak in
 pse_control_get_internal()
Message-ID: <athMn_ER3xhaOJT1@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-4-github@szelinsky.de>
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
In-Reply-To: <20261020171249.853085-4-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:38PM +0200, Carlo Szelinsky wrote:
> pse_control_get_internal() takes a module reference, but when
> pse_pi_is_hw_enabled() fails, it skips module_put(). This happens on
> any I2C or UART error. Each time, one more reference leaks, and the
> PSE driver can no longer be unloaded.
> 
> Send this error path to put_module, like the regulator_get_exclusive()
> error path.
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
