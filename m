Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C14A2055;
	Sat, 17 Oct 2026 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277246; cv=none; b=N6vT9xw+9mP2GFirmv72SH8LAnXVVVy97TJXDBpEhvLbHReon8NRNkJhBUPvHwYgp+5jXkwh561ovu5Uuw8NlTm/VS4Et5KZM4KcONbEc/ds8YoazWRXoJyG+lg6POwRIrKjqcpKze94GknnkQFff7pd+frQLvaSHNm/aO4Pmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277246; c=relaxed/simple;
	bh=yHpQplBB9+/T/A382r8r/FXKjdpjvqCElkH1YGfDn5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPbfBGiLjAF4Hek4Swl3e8cUhbHReF4/kLCw3B0EZ9mKJ8TIJA6IGBq8xnFOTBYUdoTFcnpdFp/leD4d0dKNo3ZbYlQach3UzRAxf/s3wJ6zvVhqM0Pb+jX8pRdsws+VyY7ggQhX8WJ2P/jo4HZyc3dM2jhTpoILbvnGWa5Hq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=I91M2PDc; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="I91M2PDc"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 7A679E83411;
	Sun, 18 Oct 2026 00:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792277240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHpQplBB9+/T/A382r8r/FXKjdpjvqCElkH1YGfDn5I=;
	b=I91M2PDcPvFitEM+2UW+x54n1cbz50yBr9uYWzhr7NjE26AeMoMHsNdq8/F9PTs/EdG53X
	JGjHrGwX3mtsknpLFcV3EJsHsXJ182d9+gV72jPIncsYwuKgndy8s8nwSpWvwncp3VKEMR
	3lKneIzMr3LMB/W/3+tTCP9S+YOkw7GmZZVqO6WgHOXCMPvpIgkjK1OhfAJJYxtChJVFwN
	pMJv4oElo6/ZLsjr3JPNIe31iYr0wAg267RBvSMO7Fth+kbACB6esE5ELbKvRghzmrv3EE
	dHi/w8oSbb3whPo5m9wxBqlmr6qK+T4rZueMe+gZDlE1hR8kkgnDYJzIT2BFZQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id fn6lAaj1QyVI; Sun, 18 Oct 2026 00:47:20 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 00:47:19 +0200 (CEST)
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
Subject: Re: [PATCH net-next v8 6/7] of: property: do not let "pses" block a consumer's probe
Date: Sun, 18 Oct 2026 00:47:18 +0200
Message-ID: <20261017224718.1527444-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179122161108.434549.4299749280069396742@kernel.org>
References: <179122161108.434549.4299749280069396742@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 17:33:31 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Is this description accurate at this point in the series?

No, not at this commit: it describes the phy patch that comes later.
v9 folds this change into that phy patch, so the description and the
code now arrive together.

> [Severity: Medium]
> fwnode_mdio still does the PSE lookup at this point. Does that mean every
> deferral of the MDIO bus owner now runs a full PHY driver probe and
> remove, including the hardware setup done in probe?

Yes, with only this patch applied. Because v9 folds it into the phy
patch, which removes the PSE lookup from fwnode_mdio, no commit has this
probe and remove cycle any more.

> [Severity: Medium]
> Can this also make deferred probing loop forever while the PSE controller
> is absent?

Yes, I could reproduce the hang with only this patch applied. The same
fix applies: in v9 this change is part of the phy patch, and with that
patch the PHY no longer waits for the PSE controller at all, so there is
nothing to loop on. A boot test with a PSE controller that never binds
now boots at every commit.

Carlo
