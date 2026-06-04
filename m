Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBB3F44CB;
	Thu,  4 Jun 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565313; cv=none; b=t5Zyo4G+T9/HFORaadhVCFzATYeSxNONzND7On7/NlMpFQIR/jtVi0+zKHk9dHx1Bi3m7QdgPQjrWl1jVn6Lm6kxLgsg91emKdrJz/gya2kmWwZ/jQXdJdc/Rg8e1LisyvG7YqHr4SK+lk4KGZa+O7gymhRA9gqsXfUrMh5uklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565313; c=relaxed/simple;
	bh=WW6JgxeMBErUtGgr/0vA+ffViSgDw6LQlXiiXxfyoDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnHgtG0VjLWQq6VmuoM4+5uFN1wU8qfRjRGdIkYAmrJNYEkE2GH1h2dWLRg87Fb5J/EWjv6BcG3NiPPcoB0astOvBIRSPD/rdTAGvoik344bJq+3kDvYoUllayLatsfVqjbbKPFwZhOnSMbVPbZBIfjOhY6L8zwRoLPsLNgCwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=07lJXG45; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="07lJXG45"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AADE84E405EF;
	Thu,  4 Jun 2026 09:28:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F4585FEF7;
	Thu,  4 Jun 2026 09:28:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C669106A1867;
	Thu,  4 Jun 2026 11:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780565309; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mw+r8i3yM/UEbAoWm4ZLrQzfHj7n/cBFxgGHZ6EACQE=;
	b=07lJXG45jRow/WvmQqwGSKNvhExW6fcIGvK9pydACJZwyJ8Roy2ngE51vHckBzxiwPtuIj
	BjdLvvRjGhw6tQnQ8R/XVUIoiswY3PoSbPbMV5Epdsfefl7WdisHr23E4Izp/wzFPYRfaf
	STm2m20MIWrFRdnqh3ajl3aSXxfX5l+nkz/+zymLTbQSiWEkg1bykH6f7uyETj+rKLil1x
	r4bPk9lh/EwMDZR9LvvNqWXXQJqLNOc8pOok5i4lOV4mswJTiLeR0IsqEepe8buoesYLPA
	g1tj9kylPUEwIwVWQharOS8+ipIQI6ptCJDmSifmYIOdb9/Vy+xjXW+ZzIxIfw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net v3 3/4] net: phy: Clean the phy_ports after unregistering the downstream SFP bus
Date: Thu,  4 Jun 2026 11:28:17 +0200
Message-ID: <20260604092819.723505-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604092819.723505-1-maxime.chevallier@bootlin.com>
References: <20260604092819.723505-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

As reported by sashiko when looking a other patches, we need to ensure
that the downstream SFP bus gets unregistered prior to destroying the
phy_ports attached to a phy_device, as the SFP code may reference these
ports. Let's make sure we follow that ordering in phy_remove().

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 4ba880446896..b48722589f40 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3806,11 +3806,11 @@ static int phy_remove(struct device *dev)
 
 	phydev->state = PHY_DOWN;
 
-	phy_cleanup_ports(phydev);
-
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
 
+	phy_cleanup_ports(phydev);
+
 	if (phydev->drv && phydev->drv->remove)
 		phydev->drv->remove(phydev);
 
-- 
2.54.0

