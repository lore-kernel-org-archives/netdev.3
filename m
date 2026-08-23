Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86925377A9A;
	Sun, 23 Aug 2026 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787504974; cv=none; b=gSe1NOXAJ2GaVqvRopfUHME5uTSyica8R4YLpFaB5s7DBSdEXvz+eAyY4lYU6IbrdTL8IZBkLjl8jtzRBxnJ+FjFa0bXAa/486IPBSaxzFInGO/z1UBpSU4DWzHrQ7zVnoDy0H4/+q3B0A+j4YIyOM6Vp7N3iKHiQ+SJyPkEXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787504974; c=relaxed/simple;
	bh=Xd2Wd775Y+oylumj0Z1MysUStzA5yahoA+eeGeHVLh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ada2Zz0f4/tDKq8JWg3XbOxRU1h+DCDrbww7M524OH8MjX3yTICADdmCIagDZ4EFx1l9DTDUYeeJGdyRd7CTc+kpEEDrUwefkdBXKiWxjbOMzmCWslbNxfz8w81Mb1/A/gWKf478E+ZeSnvWUpLvK0ZO6YSucUq0oRCnpXQnA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=D/DsjSjS; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="D/DsjSjS"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C2C0CE836CE;
	Sun, 23 Aug 2026 19:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1787504966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd2Wd775Y+oylumj0Z1MysUStzA5yahoA+eeGeHVLh0=;
	b=D/DsjSjSCv3pfx5mKkpU04OS39XSP80nDag3bXTbyh85KqQWVB2FihXvaNNfqU1bRsVllG
	UWCdXl/J4VV3RBJWMW0vtZB9njOBNEJMZg1HKXx9HHurzXTEs+OLbrSIppaNX402WQ0NZu
	brFlM+wj/5FE0dyAR+AkzJ1llm2bjVHNvRKPvJZ3HXwAitgCgqq33vsTiirkmGhNHAU8ro
	Mc7C9DyaaXTD7d5ApSSn4FKXdVbkTbslAJw+PrcH9XaRjalEUxnNqv2AqD7eutAE1OWqo2
	W5aEj7yY2L0TUQnRulWy44M5Kb1KDzf9MjQL1odHu+RDCxR3pTtpYrl0Grpjsg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id SmHyNGFl71Tw; Sun, 23 Aug 2026 19:09:26 +0200 (CEST)
Received: from p14sgen5.lan (p578611d6.dip0.t-ipconnect.de [87.134.17.214])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 23 Aug 2026 19:09:25 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net-next v4 3/3] net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook
Date: Sun, 23 Aug 2026 19:09:21 +0200
Message-ID: <20260823170921.1429827-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl>
References: <bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch causes a deadlock with the etop driver (lantiq arx100 soc
> family).

Thanks Aleksander, and thanks for testing it on real hardware. It's a real
deadlock and you're right about the cause.

The cause is that this patch makes phy_device_register() take rtnl_lock()
around the psec attach. etop registers its MDIO bus from ndo_init
(ltq_etop_mdio_init -> mdiobus_register -> mdiobus_scan ->
phy_device_register), and ndo_init already runs under rtnl inside
register_netdevice(). So the second rtnl_lock() deadlocks. It only shows up
on drivers that register the bus from ndo_init - most do it from probe,
outside rtnl - which is why it didn't turn up here earlier.

I don't think we should revert. As Jonas said, this should be fixed in the
patch. My idea for the next version is to stop using rtnl for the psec
attach/detach and use a small dedicated mutex instead. A private lock can't
recurse against the caller's rtnl, so the etop case would go away.

Kory, others - does that sound like the right direction to you?

One thing I want to flag: rtnl there wasn't only guarding the attach, it was
also keeping the ethtool code that reads phydev->psec from racing the detach
that frees it. So the mutex would need to sit in two places - the phy side and
the ethtool paths in net/ethtool/pse-pd.c - otherwise the deadlock is gone but
the use-after-free comes back. Just so we pick the right approach.

Thanks,
Carlo
