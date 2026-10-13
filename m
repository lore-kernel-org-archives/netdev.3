Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E54D37A7
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884421; cv=none; b=gJ4XNw5YfJVwq4y5MRUUKz+U6nV3MPyBkjtOrHRlz0QEvc17eUy/Ssh+Eqskmlxdh1bZxxpjVzkms/QeavC5y+qStdmF4Ei9uMN1w+8Du+tT4cqeYbHOha/6Ljoz+aRDmI8cmWR6oMH/O+rNa8w+w8FU0OWdSGi14AKn+OyukZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884421; c=relaxed/simple;
	bh=qWyBNs96OrtDP80HaEpLU7sHHz2umGjO8wzkZlvjkPc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HNv6e1MoxfC5PnPfQSAjQ5FqNvmaYOKij3IhYZPP45SEXZPOm3mzyuaJx4sMDPZgsBGglLrxPw6tDj0oOXhuCMuuGKnw565OhAh8XOnKW6YcKJ5UpBIOgh0s5H+oqnbh80Izrd7iPs7b0x6+UuswN4Js7ufjItH9b9lMOQyP09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zmDhPRdE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zmDhPRdE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BC8194E4114B;
	Tue, 13 Oct 2026 09:40:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E4B560362;
	Tue, 13 Oct 2026 09:40:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCF7E11D70E05;
	Tue, 13 Oct 2026 11:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791884413; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zBAiEU6UUdPzyIU8IE4qXcz1HB4Oo2D8GHd/vf+EgoM=;
	b=zmDhPRdE4GnNBEJQaVUlGidApM9eVDIdIkMF7VHD9OxuA2dF3jIB93NqwwGVTjvUEiUD9v
	MTpS+UHik9XbU5zbvQakxu2veNTuvilJJJ1GD+JqflnMQD6ArXYMYavoPuP7dPIzg6enBd
	QJqmeMOVmVZHIAhz1brGBlGs3elngzajdYn7aSWi20yi3iLNcAH6H3BsCJaD3k/u8/varq
	QBmE/7HvuApqC5owsjhJ9X8dbjIJsq/f4bAgeF3WroARYmMgIOLECh664EpOn+kcfnQC5N
	kkDD/Oq8VdExM6aEHUFmYJeX66AwWSukd2UhehERJU3xpoGwgWcOWi1BTIw++A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 2/7] net: pse-pd: fire lifecycle events on
 controller register/unregister
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
In-Reply-To: <20261004164219.1161294-3-github@szelinsky.de>
References: <20261004164219.1161294-1-github@szelinsky.de>
 <20261004164219.1161294-3-github@szelinsky.de>
Date: Tue, 13 Oct 2026 11:39:59 +0200
Message-Id: <179188439907.332369.18031665104006936491.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

> Hook the pse_controller_notifier chain so that pse_controller_register()
> fires PSE_REGISTERED after the controller has been added to
> pse_controller_list (i.e. is now resolvable by of_pse_control_get()),
> and pse_controller_unregister() fires PSE_UNREGISTERED once it has been

Can you update the patch message and the comments to make them human
readable. We want to have mainly the why explained in the commit message.
And if you use comment please make them concise.
I know you have faced painful sashiko reviews that always ask for the
same change but it was the beggining of the kernel AI reviews, I hope this
should be better now.

On the code part, I would prefer having the cleanup reordering on a
separate patch than the implementation of the two notifier call.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

