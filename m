Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CE4CC610
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884415; cv=none; b=Z+eoX6XtP5f4rp7CLRmoM/6K0qoqiVW9OtFg6oSgmJ1A7dJvaLHDwYpFBta4hM9ZsoTOys+kbmMmMFNq6LZHh+05pwXkNga6bSAgT1tfnupYZW3CvthEiPbrJ0TM4D832Hd9mnvDkNc7EWm/pCkWyG1t6YmVE8FA7iv3L5xVtkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884415; c=relaxed/simple;
	bh=6C1Zf9/82+PRcxljTpDJg1BHI0g9Mjh946pQCg9W8wg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=uCj2B70EopgzWT7AJGBeuFOfVGBY/EGzcGuuSwag1TN6R3JtMeweSDCmjykNSfXn/ihZMowP7ijPYRVlyac+9a9oqY/cL5lzE1v8efSwzWlovXAIYNCI81iR4vgUkNkZNeALaRVZ38IE9jFweUW8vjfDNAs3TS3dnfrVaSJJhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JD1sDVe6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JD1sDVe6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E48ABC653E5;
	Tue, 13 Oct 2026 09:41:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 580FD60362;
	Tue, 13 Oct 2026 09:40:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E68AE11D703F1;
	Tue, 13 Oct 2026 11:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791884406; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9rZE64iTvt+0a2Ro/fm+bE0rCG5rktVSCHZlWnilnIc=;
	b=JD1sDVe6ms4o0HyzW22g3DY54AmDg8nSwzeGDIH2DOKO8G6aeCT7A9YD9Wh15NCIALRxcp
	o8YAAYUge1mGIkadfEfnlEtopHRol7erDv03oQEVdXnOoFsBeuuR9jw5doboyCPUm3vnVZ
	9fZ8RMGu3Q3lfyWgQvIMf0yqpMelg1OPv7qXFVzojUwNnXO1crBnooOj3L073LHJcQ+oi6
	mumYNgLHp6541xGv02za1Mv2fPbsaBIevmAhl0GslutJGe8Tt5hpNJerLY5fM260kLSnGt
	wGyHShpc7TLssijTFQc57PiWFY+E393o3wXhghlDYIx5ZiNw8KKjv9mEdaLdGg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 1/7] net: pse-pd: add notifier chain for
 controller lifecycle events
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
In-Reply-To: <20261004164219.1161294-2-github@szelinsky.de>
References: <20261004164219.1161294-1-github@szelinsky.de>
 <20261004164219.1161294-2-github@szelinsky.de>
Date: Tue, 13 Oct 2026 11:39:59 +0200
Message-Id: <179188439906.332369.7366288574063718816.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 04 Oct 2026 18:42:13 +0200, Carlo Szelinsky <github@szelinsky.de> wrote:
> Introduce a blocking notifier chain that allows other subsystems to be
> informed when a PSE controller is registered or unregistered, and
> provide pse_register_notifier() / pse_unregister_notifier() as the
> subscriber interface.
> 
> A follow-up change uses this to let the phy subsystem own the
> phydev->psec lifecycle directly, decoupling PSE lookup from
> fwnode_mdiobus_register_phy() and removing the probe-time
> -EPROBE_DEFER coupling that currently exists between mdio, phy and
> pse-pd when the PSE controller driver is modular.
> 
> [...]

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

