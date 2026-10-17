Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35E40929D;
	Sat, 17 Oct 2026 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277248; cv=none; b=Zlvn4/CH44557Y1oXy4l72pXP896eYIGkLjVNecf8b2yy8mFZbcGxfz7EtrsSTwEZ4cfvp5ZzfhuKWBCSzJ/urWAGvbyoitqjm7oVQ1fEWOg2d4Bz3X9IRM9qCLaiWryW3Kdf0M7wcHdAnSfSLg8q8MmwKwkzUxxW6jgCy6MslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277248; c=relaxed/simple;
	bh=T/pAdgpOSsqxWSHMg+zswhCkjhXPM9mbN5lqnSjze4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEjaxmZ992jCuMulq8lnXYctwYmUH3rj6s9beacXSBkVRLAQwBim/YKKpTYzYXtV0fOrQ14hvHQum+o8UldgL3/lg1td4k2skTCZkBVa/yBotjOX6HzMb2Vv5qENhZMDWHWo2XYb5FGsgJm+//o7a6jfky34Oj4nLrCPiwtGYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=U7X9Lbco; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="U7X9Lbco"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 68B9DE8341B;
	Sun, 18 Oct 2026 00:47:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792277243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/pAdgpOSsqxWSHMg+zswhCkjhXPM9mbN5lqnSjze4o=;
	b=U7X9LbcoaQyQW1bgzh4KCz1r7lfHH54HkyYtPKTAGb94WVPZmwmmiF7yoSw6ht7ufDZB76
	nt74yqCqYhuA/BqljkME2MwSCbUMEzm3YI1q0dzZSLBgj7zlsLXBhyLQ1Gt6ylNhfieDXH
	COgY5IGCzarBgq7tHoF+moIp/93lsnnH1ugglEfAK7NXoSaqYHX/Vx1m5vhPw+ei61NdwF
	x4CYtuUpDI1ZWFQPOwFc/BYJMKQUmm07JdcWYfcP1OFVsPJvRH3XMpPo/nhNRc58RY2wxr
	UL2tz27UpalJaboWkjrKzKO/tt6jMi1BCUbisXo9EMQs4roePQLc2j3NEM/wNw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id hkradLoTkQJ7; Sun, 18 Oct 2026 00:47:23 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 00:47:22 +0200 (CEST)
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
Subject: Re: [PATCH net-next v8 7/7] net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook
Date: Sun, 18 Oct 2026 00:47:20 +0200
Message-ID: <20261017224720.1527461-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179122161274.434549.2931247814591983963@kernel.org>
References: <179122161274.434549.2931247814591983963@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 17:33:32 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Should this have a Fixes: tag?
...
> If this is meant for net-next only, could the commit message say so?

No Fixes: tag: the series goes to net-next. The deferred-probe storm is
not caused by one commit, and fixing it needs the whole series, so it
cannot be backported as a small fix.

> [Severity: Medium]
> Can this retry leak a reference on the PSE controller module? When
> pse_pi_is_hw_enabled() fails, pse_control_get_internal() jumps past
> module_put():

Yes. That is an older bug, and the retries now hit it more often. Its
fix goes to net: both error paths now jump to put_module.

> [Severity: Medium]
> Does a later PSE_REGISTERED event really retry every -EPROBE_DEFER?

No. If the vpwr provider is registered but not bound yet, the PHY gets
no PSE handle until the next PSE_REGISTERED event. The commit message
says so. Retrying when the supply becomes available would need an event
from the regulator core, which does not exist today. It is the same
small window as in the supply check patch.

> [Severity: Medium]
> Can a failed PSE driver probe now power down a port that was already
> live?

Yes, and that is intended; the commit message says so. If the PSE
driver's probe fails, the controller cannot be used, so switching its
ports off is the safe result.

> [Severity: High]
> This isn't a bug introduced by this patch, but the new pse_phy_lock()
> scheme does not cover psec->attached_phydev. Can pse_send_ntf_worker()
> read a freed phy_device here?

Yes. That is an older bug; its fix goes to net: the worker now looks up
the handle and uses attached_phydev while it holds pse_list_mutex, so
the PHY cannot be freed in between.

> [Severity: High]
> This is a pre-existing issue, but pse_release_pis() still frees pcdev->pi
> here while the PI regulators that index it are registered.

Yes. That is an older bug. It is addressed by a separate net series:
https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

pw-bot: cr

Carlo
