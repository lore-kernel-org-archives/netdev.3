Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FE4A2076;
	Sat, 17 Oct 2026 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277243; cv=none; b=jPvjvsYnqtX2Qp8HCUeYvOt5tvCAfZeeazIBLZEIstjeHU+/EJ90A6IgESydZiU51m1Vsj51KlPor4GtNtnp2irdyCrMcE+zGkpkmKQasHN+fpEa8jueW/Kw9YX8ciGljvbHfbJRF4JTYGhrzdlCIQ3cEbvk8XcG8W8LSHeAUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277243; c=relaxed/simple;
	bh=bEFzKxXaWpKuuiBarHWmhQXj+7UB1mTnrblXUsCUvaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHELspOyDEecOa2ob4+wyenaqP9wLt7i6hPZr9bCqaoPFCAQNI/byE39V0UQfgw9FMSFPT2kQGRjNf6kRMI1mHkApXxrGPKNLtGux6a7rPOm0u7EfYhJDQKgs1oNXKkcxlE+X3ey3YaFafkS75YIhZtd4h/GiZkv7BctNiGPYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=ffEEFpCS; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="ffEEFpCS"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C2F15E83406;
	Sun, 18 Oct 2026 00:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792277237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEFzKxXaWpKuuiBarHWmhQXj+7UB1mTnrblXUsCUvaI=;
	b=ffEEFpCSyrlzdhqf7IHaJo68mwqr0pjuf+QdRGMkPYUwiLvcnGAONf2sDuKF7KtkjIwpuf
	PoQgN7mcpEE3cLQQhHcuUOQPqxWUBtMwcDB/SCLqfj7BtDE7M5FfDwiGeq22z7IzwFfw2q
	qGmhmhJ6R29p+fttvOHB34tAbCNMsPcpDJjZ3jHR5lrAbwPGGWLaD7ZEmyn1Em/kU5hAb4
	S6yIwpKBu4SexBzVtkLArlnRn4R0Ut6Cl1FaKKaHb2GdpIrS0g0Evg0Y2fTYk/pKIXZYxA
	OARlFtFs+Llg6mAC9NRVebHRQgW1A3tRiJVQkIJyUP3jI7vB7TKCiexMcj1e+Q==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 5yJQ-yn1bl6y; Sun, 18 Oct 2026 00:47:17 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 00:47:16 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	devicetree@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 5/7] net: pse-pd: check the PI vpwr supply before registering the controller
Date: Sun, 18 Oct 2026 00:47:15 +0200
Message-ID: <20261017224715.1527426-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179122160924.434549.13478805521146010203@kernel.org>
References: <179122160924.434549.13478805521146010203@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 17:33:29 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> This isn't a bug, but the commit message only describes the future
> phylib notifier case. It leaves out a change that applies today.
...
> Could the commit message mention this?

Agreed. The v9 commit message says so: a PI whose provider appears late
now gets its power domain, which pse_register_pw_ds() used to skip.

> [Severity: Medium]
> Can this check pass while the PI regulator registration still defers its
> supply?

Yes. The check does not copy the regulator core exactly: a provider that
is registered, but whose device is not bound yet, still passes. That PI
then gets no power domain, and the v9 commit message says so. Closing
this fully would need an event from the regulator core when the provider
binds, which does not exist today. The window is small: the provider has
to be registered but not yet bound while the PSE driver probes.

> [Severity: Medium]
> Does this new -EPROBE_DEFER exit leak the pd692x0 power budget claimed on
> the vmain regulator?

Yes. That is an older bug in pd692x0: it already leaks the budget on any
probe failure after setup_pi_matrix(). Its fix goes to net: the budget
is now released through devres.

Carlo
