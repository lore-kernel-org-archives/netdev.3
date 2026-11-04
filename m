Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805607;
	b=LVBBaZwFcWTFcgqzWW8TTjuyk85J534dsqT2YfaM0NUx9rTsYcMvA2Nodiq1P3v/PuP4
	 SMuV3FHFoyoOJZsLc50+EQ6mztdxb+0Z/2Zlf/TvmLbvDND3+7pDnWpbGNb+AQVKj9Ob0
	 6vHrWH0FKh2UoPEeE4dkTloYwbpSkHwtaVmTVFvU7kn8an4YwHzHVKZ6pMui/mInBoWeE
	 QLiPnEC0B6VUbkocQjB7GclGnkwxM6FHXSvIYeEjhyADnlS7Z6vTowf0n/XitdgM0Ki46
	 YsBnune485LBu5zvAXYrfGb9D6V/8ink4b87CJSAPWNypBZvaElrcM56tLoKcUbwzhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805607;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=GgM4EgkVv+1x6Punl4v9ucm9MZswVB97/k8FiaLVyi4=;
	b=S43AP9LYLYkDVeXWfwUqOe9o71mu/3j1HU6fxfe+v6HoUwph9Q0PzV/yZvNyCfWR48CQ
	 bdlZyf31pRhwDqmPIAGICV/iZnyF+WWvynn1XQxOToy6jNj3No1ljvIHtzBXIiCAI6gUP
	 SlJ5eyNZ0DNxUefg0BgW3Hp+vECO0U0R9PvQGhlomZu6CHIVFZUBdIYuZ6Tgth69eFYq1
	 jP1QOz7kXFcqA5WWu0zch7dmRL0tnkijwXKGie3wGurgwlADRMwRzQ8yVlZUwtD5Ef+KE
	 pOwnuM3ko6gme0PUWBkcGiFphfYHRz+s9xjOZ7/df8LdBZi7O7f85eud1DDP6QFiCjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="V/Jvi2dQ";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA24608363A
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA24608363A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=V/Jvi2dQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5807F4E41406;
	Wed,  4 Nov 2026 15:20:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F74E60770;
	Wed,  4 Nov 2026 15:20:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E610710329206;
	Wed,  4 Nov 2026 16:20:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793805603; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GgM4EgkVv+1x6Punl4v9ucm9MZswVB97/k8FiaLVyi4=;
	b=V/Jvi2dQJyKD1n0dM64eS1cfjwExl9L1PeLjlrHs0EOYxZ1UqsCnVb39Luu62/vU9yPzMc
	/aDERCvsreWczQjLBFwhx0mgWEaWdxNLWza5Qs9V5B7xdKtSxFh+jcdHrX1vPfOtTkG096
	Jgc5I2bkqE3NALQa9MvYbs+ZjRUr9SI7jGGcWlGvfHwiJWDw9GOxCVsbqZgxx2sjeNAtZQ
	a4MTAncrH1WBvFs3NuFVxHobudc2xphVVzg6iem35uKn7OhMrQRlgd2NkONOP7MQDdOnpT
	lvTDuO+4bmTkD7qd38BPzC24x6BJnp9lj9ay1B6phz0qsfwi26ZpaORTZfX4kA==
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
Subject: Re: [PATCH net v3 12/14] net: pse-pd: use each PI's own supply
 handle for the power budget
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
In-Reply-To: <20261103220217.1131971-13-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
 <20261103220217.1131971-13-github@szelinsky.de>
Date: Wed, 04 Nov 2026 16:19:34 +0100
Message-Id: <179380557482.1333589.5626232974220759600.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 03 Nov 2026 23:02:15 +0100, Carlo Szelinsky <github@szelinsky.de> wrote:
> A power domain shared by several controllers holds one supply handle.
> Its consumer device is a PI regulator of the controller that created
> the domain. When that controller unbinds, devres frees the regulator,
> but the other controllers still use the domain and its handle, which
> now points at a freed device. Reading the regulator summary in debugfs
> then reads freed memory.
> 
> [...]

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

