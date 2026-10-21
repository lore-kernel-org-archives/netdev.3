Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792559868;
	b=2SGDfmnwnqzVc+fHuOCMNrdxdPOIM9V0ghdhO1+LBMQnpRJX0mWP2YNHo46ymQbN6aOx
	 UwYQv1g/PkGKIhpe8F5Ziv0qeaNGhkwEjJl5zY4laMBx2ppeb6NmrYFSZrJ7PuWgM2oku
	 Wmsun3OST0ivh3DfxmEw4gSiVcwNeycL8wYVs7VjiEgeSP+B6l5W67MINZ5S4R20G//xV
	 S5pjo4O7dw2Upy4NLvqMJGMhc2cNELeaInnOO90MAmhxYYFcRlJLGeYmFuh97cnjjQbMx
	 U8MhgxZ9W7pZRJNkPf9DgCzaUVAK1ZGUVKmhwn9bPsB7FNDsStdeCTPeym5drmbDkYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559868;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=YlxKBCa2wFXBNqaUVZfW61G5tni5rV4zLZ5eUhzpkhE=;
	b=BLP9oBl0fMovPVNf7JVkoif/d6k5tpwbkHqgOL+wNwMPSb9uMKdqOrs7cbkMIAyL/h82
	 0V4oerKZpzCOLbQ1ZiHOp2Q6BdLKFlsXeHWtm6ZOkhONYYs+p50yNjxnSNyb866MtKCqA
	 GGdkOyxpg0iKgsp+4oTcSclNyWF4yNzYADg/H5sjklL76wa6HTXh/4+shWJdo27VdqcQ6
	 WylZmkN1UgKhJ7E/0fuT/fmVxQsCoQ2m+KrG3fUBORzkTu/zQCGuEDi5NkpZXtV+zJ2ZA
	 cmnJDRIYtXGaIP1SdREMSuDShs7i6T49JSME1R/P7mDshxVQjZzrNC95Pm70Jsr8pVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GmtKw3H9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D62606A319;
	Wed, 21 Oct 2026 05:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D62606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GmtKw3H9
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 92687202013;
	Wed, 21 Oct 2026 07:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792559858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YlxKBCa2wFXBNqaUVZfW61G5tni5rV4zLZ5eUhzpkhE=;
	b=GmtKw3H9cDtaUr4URxH0LXNKxMVLyUXRfEjm5/HtHJUujnOOz3GYQF0OhLbh24FcYJoEts
	I0L8Ec6MeNSWEPihwmNuHcVv+33QxhXUmzVswZMnhJOc7mM9dkfV1PBQrfIG3h3191qsYt
	lA/CbDhOgI/gOqCLOYDe6hDlIkI0NNyRC/rZ0IRWySWbuM3Q7b3DLGeDpEpt++EomlK3xz
	+yDDiRHnS4vZtjK1/ppbr7j0NfXAFZHKVJGmBwOugYNjTKD+8Wypphs0L7k/PD318fHSqA
	GPuSgoqaZSgFD+EKvuV/JFpDK0FMWaoq5XDoSZLLO43P7QaVh/vFid8BGCLU8Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792559858; a=rsa-sha256;
	cv=none;
	b=f+vPYwi4+kMpZBVP68kL/sMVpbocUl+WhY3OeObbLp/685bd1BiYe4y+Mp5zS3o93sEmMI
	5Uf0Yl6Lw/i6/CZxO9U44UIbWAEDXxlpQZw/H77cWlRPHqTw6Pinw1FwHkNZ4RNeiTWJ3L
	OKJJxat5OiqL/UDb9FAlKaYNDndWpMtXjaqsdMevBoepE7DJMJxKUCUB4oujfoqA/pMmyS
	8TA6EWgc6BMm/ZfVU3WiJp6xPmrX4Bl2jCJiMaCJTuTUEmtq9SjWGmlaR1uk0CcQcZ031g
	2APPdAl16k+cDu30IF+QHnFF1BpeiN25XwOEb32QH3hZbjY/DElz9MlHX8p4DQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792559858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YlxKBCa2wFXBNqaUVZfW61G5tni5rV4zLZ5eUhzpkhE=;
	b=aRBukfI8hV3LGVxkN86mNvlleQ6FzRskvHoCRFy4Cca+ImAWDNIt5DTmr+i65aaYl1xRRE
	KyMV2uFBMK+oehPPI5M6WF0rRF8AwoeWvKdx3R/T/d3ocvyscXuGvqT7fPX4o2gqPST0zG
	LE0Ilh14SsLzg/BFF/E8VQ/UHraIByJkZqnjpVTryemhi8lXS+HXzVhIzx7qowx8XgW4nk
	w6iKSTZz0DVcfOkr702u5vTKbPqqpYi70PEwpldk9pjsi343Mujkd0HYkpuYaXn1dr/eVE
	dFywSTC/4ygZZ/vyeMFnsXuyrN+yBl59LNvf86Ru8EiXgh+Ki4GRadJPflvwzA==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJOhm-000Vln-1f;
	Wed, 21 Oct 2026 07:17:38 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJOhm-00000006d0z-1gJH;
	Wed, 21 Oct 2026 07:17:38 +0200
Date: Wed, 21 Oct 2026 07:17:38 +0200
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
Subject: Re: [PATCH net v2 01/14] net: pse-pd: size the notification kfifo
 after defaulting nr_lines
Message-ID: <athK8pD1fOINOAV6@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-2-github@szelinsky.de>
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
In-Reply-To: <20261020171249.853085-2-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:36PM +0200, Carlo Szelinsky wrote:
> pse_controller_register() allocates the notification kfifo before it
> turns nr_lines == 0 into 1, and kfifo_alloc() fails for a size below 2.
> So a controller with nr_lines 0 or 1 cannot register. pse_regulator
> (podl-pse-regulator) never sets nr_lines, so its probe has failed with
> -EINVAL ever since the kfifo was added.
> 
> Apply the default first, and allocate at least two entries.
> 
> Triggered in QEMU (arm64) with a test-only PSE controller with
> nr_lines 0: its probe failed with "failed to allocate kfifo
> notifications". With this patch it registers.
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
