Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35654CE691
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884428; cv=none; b=QTEkLtuvUX6bDq5yKzMgPN7NGyCsRJEXp7+iJIuQ77xkO/EwapXN3C9JyYMswqlHuixNE31IEbjkXT9C0pLNuK20S6+gja5uyGT6FR3L65bJTpa9zZXT7wvBdC+ZZiaqO9yDwwTajcUwkkY0IcSCaLyh/u1trwIY82vYa9i65L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884428; c=relaxed/simple;
	bh=ET/KqFdTK3KLWL5wNzL4YkrBtHjPe8oowqaSzdhpFhc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Ipq7B+G7O1ioXwU9P/AIndLh9DWwojZ7DRv8uKh8U8BTx6G9ycBMBpx/WX9lQfvoyf57c0bdYO9ak9UmRNI/lBdand/ZB7rzzaog6IAR1jrZc8GA5povI16DCE0Swir/CLQVpyNPST/9SnVQM0negIvIXX6h2J+enTg06okwfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WRmM0AJJ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WRmM0AJJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A29F6C653E5;
	Tue, 13 Oct 2026 09:41:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15E0560362;
	Tue, 13 Oct 2026 09:40:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 606FA11D70DF9;
	Tue, 13 Oct 2026 11:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791884419; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w7gZ4kyVMRwAvesRLhXl8psWguaBShEeyl5Aqo0Co9U=;
	b=WRmM0AJJZojoxr/qs1WV0NS1FRhL6CVaCOmfh6DMTy7b2355e4m1aShTEzYlEi2HQFGN/A
	SqOSiSeHJ4ITy59wOMPjpW/HaVEFcuBS98S5VjLEo30k4nLwdlNBeP7V/AFTKpRNDvI1XO
	ustD9iITxLSs+5G26NMJgadWpLV3IXET/yGF0mKG3MXInKAst/HdWNMvLZOlJ5X5D47Jyd
	1v3ZnPALIhF809rTMgTHPnC/dg2K6rzh8FNbbgO7BsK/CtwfQlJmdyNw6WMPJAtq/99Rcn
	SE94y0b7dF+y0+1Y3AlvJCYSTF27Zoz9DDYa1V9VIQdMwc12DBisBXVAOMWDUA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 3/7] net: pse-pd: unwind allocations when
 controller registration fails
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, Corey Leavitt <corey@leavitt.info>, 
 Jonas Jelonek <jelonek.jonas@gmail.com>, Simon Horman <horms@kernel.org>, 
 Aleksander Jan Bajkowski <olek2@wp.pl>, Mark Brown <broonie@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, netdev-bot+sashiko@kernel.org, 
 devicetree@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261004164219.1161294-4-github@szelinsky.de>
References: <20261004164219.1161294-1-github@szelinsky.de>
 <20261004164219.1161294-4-github@szelinsky.de>
Date: Tue, 13 Oct 2026 11:39:59 +0200
Message-Id: <179188439907.332369.4783081024382387629.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

> pse_controller_register() allocates the notification kfifo and, through
> of_load_pse_pis(), the PI array plus OF references on each described PI
> node and its pairset nodes. Every failure after that point simply
> returns and none of it is freed. of_load_pse_pis() cleans up after
> itself, but past that point kfifo_free() and pse_release_pis() only run
> from pse_controller_unregister(), which a failed registration never
> reaches, and devm_pse_controller_register() drops only its own devres
> cookie. pcdev->pi is a plain allocation, so nothing else will ever free
> it.
> 
> A partial pse_register_pw_ds() is worse than a leak. The power domains
> it already created are devm-allocated but live in the global
> pse_pw_d_map, so the failed probe frees them while that xarray still
> points at them, and the next controller to register walks into freed
> memory in pse_register_pw_ds(), reading pw_d->supply for
> regulator_is_equal().
> 
> Unwind at two depths, because the PI array cannot always be freed here.
> pse_pi_ops.is_enabled(), .enable() and .disable() all index pcdev->pi[],
> and the PI regulators are devm-registered on pcdev->dev, so from the
> first successful devm_pse_pi_regulator_register() until devres unwinds
> the failed probe there are live regulators whose ops would follow a
> freed pointer; regulator_late_cleanup() and the "state" class attribute
> both reach them. So:
> 
>  - failures before of_load_pse_pis() succeeds free only the kfifo;
>  - failures after it and before the PI regulator loop (today
>    setup_pi_matrix()) also release the PI array and its OF references;
>  - failures from the loop onwards free the kfifo, and the
>    pse_register_pw_ds() one also flushes the power domains, but leave
>    the PI array and its OF references leaked exactly as today rather
>    than hand live regulators a dangling pointer.
> 
> A driver's setup_pi_matrix() may have registered devm regulators of its
> own by the time it fails - pd692x0 registers its managers there - but
> those do not index pcdev->pi[]. Freeing the array safely past the loop
> would need the regulator ops to tolerate a NULL pcdev->pi, which they do
> not today.
> 
> pcdev->pi is cleared at the release_pis label and deliberately not
> inside pse_release_pis(): pse_controller_unregister() calls that helper
> with every PI regulator still registered, and pse_pi_is_enabled()
> indexes pcdev->pi[] unguarded behind the "state" attribute, so clearing
> it there would turn that pre-existing read of freed memory into a NULL
> dereference.
> 
> pse_flush_pw_ds() now also clears pi[].pw_d. The domain is devm memory
> of whichever controller created it, so it can go as soon as that probe
> unwinds, and pse_pi_is_enabled() still reaches pi[].pw_d from the
> "state" attribute until the PI regulators are unregistered.
> 
> This does not fix a shared power domain. The reference counting is
> sound - pse_register_pw_ds() takes its kref_get() under pse_pw_d_mutex
> and kref_put_mutex() takes that mutex for the final put - but if
> another controller on the same supply holds a reference, the flush only
> goes 2->1 and devres frees the creator's pw_d underneath it anyway.
> Unregistering a controller whose domain is shared has the same problem
> today. Fixing it means moving the domain out of devm memory so that
> only the last put frees it.

Same, please write concise commit message and comments.
I have just saw that you have replied in the cover letter about a v9.
I will wait for the v9 to review the series.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

