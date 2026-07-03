Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2291A6835;
	Fri,  3 Jul 2026 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112835; cv=none; b=fwVnNLPqg/AeFP6K3iACXPNC7cYDp4OvgI8QEtdyxP0rIqKvgItsF950DJacFCX2mcMM8W54qUSfs/foeHTZP/FERjoMCLho54yUeIsxksuzMeI8hCuMO3FV8PsQk8eYEQNZqzZRLlsvDnsnwvpqrr82FQnaJZiigUw1w3Gu/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112835; c=relaxed/simple;
	bh=6Mb/5Sypu6E/ZiOsb1JdxqLJhirbFsKR/gwQDmZOFMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkvUcCjnHXrkbrkj4mwBkZ4JlNT2ybCgHrgU6BSyFQhEWEo+sjzLsYLaamh9qBJZJhVixb6J2YtSAiiOu9UWu3nkpaiiJdLX6OQkkErrAZc/jh0qKUAjbeujczikFUL1bPV+O8uCDZHB/+rsVRV6AfhQV6gvS46jgmjkQPhiLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=TFLXXZaS; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="TFLXXZaS"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id DA615E83A30;
	Fri, 03 Jul 2026 23:07:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1783112825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ir5B0QRGK3HXwOvCc8TrvXpYHnIhWl7QYZS6Kqo90c8=;
	b=TFLXXZaSoZ1UZt7FMiv4aepP049a1+QCJBVHp5AQLzwHFPV5FrDRA5A2ANZAubdDvJ/3Aq
	F0mDh6PBND4TmGFCmNJmT5J1k+8TWMNO2mocz9dPLgOY8kYhO55DSgUq7Fpc94Zn4E1AA7
	E4AdFCDTApmNT1Jt8uslkZfs1idxBjlCs2UogXyRHjYO4l0dlYaLDz+2dblJuVnFYMnFvk
	p2t6qvNjwzOMRbXkFmtZX7jfKs/VbA88aKX3oxtkqXfcxvCvvXmMiWlb8UAdVk8VWjYW84
	2fhZcm+7mW0U57KIw5sTzI8IX1S7Tg/yYKlmkQDQWEhy7lTAHC1FI+3mNMDt/w==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id eb4NlK7Q6ZAX; Fri,  3 Jul 2026 23:07:05 +0200 (CEST)
Received: from p14sgen5.lan (p5784dea5.dip0.t-ipconnect.de [87.132.222.165])
	by szelinsky.de (Postfix) with ESMTPSA;
	Fri, 03 Jul 2026 23:07:04 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net-next v4 3/3] net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook
Date: Fri,  3 Jul 2026 23:06:51 +0200
Message-ID: <20260703210651.63197-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703071025.100797-1-pabeni@redhat.com>
References: <20260703071025.100797-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks, I traced this and I think the review is right.

A phy that has been device_del()'d but is still pinned (an attached
netdev holds a get_device() from phy_attach_direct()) is off the
mdio_bus_type klist, so the PSE_UNREGISTERED walk (bus_for_each_dev)
does not see it and phy_pse_detach_one() never clears its phydev->psec.
When it is finally released, after pse_release_pis() has already freed
pcdev->pi, __pse_control_release() reads pcdev->pi[] and pcdev->owner
-> use-after-free. So the commit message is wrong for the off-klist
case: bus_for_each_dev() only defers the release for phys it can still
reach.

A few questions so I fix it the right way:

1. The trigger I can see is unbinding the MDIO bus while a netdev still
   has the phy attached (mdiobus_unregister -> phy_device_remove ->
   device_del, and the phy stays alive on the netdev's reference), and
   then the PSE controller unbinds. Is that the path you have in mind,
   or is there an easier one I am missing?

2. On keeping pse_control_put() in phy_device_remove(): wouldn't that
   bring back the reason it was moved out? phy_device_remove() and the
   walk's phy_pse_detach_one() would both touch phydev->psec, and
   serializing them means taking rtnl in phy_device_remove() - which
   the sfp caller already holds, so it would deadlock. Did you mean a
   plain put there, or something narrower?

3. Simon raised the same psec-vs-pcdev lifetime on the net regulator
   patch [1] and suggested either draining the references on unregister
   or having pse_control hold a refcount on pcdev. This series does the
   drain, which (as you show) misses off-klist phys. Would having
   pse_control pin pcdev; so pcdev->pi and pcdev->owner cannot be
   freed while any pse_control is still out... be the direction you
   prefer? That makes the deferred put safe no matter what the klist
   walk sees.

I'll send a v5 once the direction is clear.

Thanks,
Carlo

[1] https://lore.kernel.org/netdev/20260624151251.1137250-1-horms@kernel.org/
