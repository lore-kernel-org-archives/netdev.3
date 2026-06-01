Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBB33B6C9;
	Mon,  1 Jun 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303243; cv=none; b=ZnhTFk7JBf8qqb7kjE8M/AdCmXQFD3x9+A7WRmzmsIAHe0485SDOOlZDYCcNxNaj88pqnq4B7e06JKj+gre+Fim+K8+FbDehxWBC0IGUSdvutWY5n48etZ8p9e/+JXYMkpnbX5ErMFmYTipbgJfs4u/mN6F5MgzDONmrqSPP6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303243; c=relaxed/simple;
	bh=l85lD5VAUj656fnz9FNLxjJKX9/nAn5Zyt14JkcqemU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMpMmH0qHf82G5QUp+deqjOF9ACHkBHGBu/GYEKnUDcbnc2sgl2n3TTjR6kyEjBXqvDXaph6xxUbtxmwOVhTQKywNwFCmG6ZkeKsV1MH+wejL47gAW2XxLvQxTy7YT+RRVoNJupdkMb/JAAXOIgU4mlT6KV0pJBbL1hxh/Y10ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tMWw4u6g; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tMWw4u6g"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0942F1A3796;
	Mon,  1 Jun 2026 08:40:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC67E602AB;
	Mon,  1 Jun 2026 08:40:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D03310888076;
	Mon,  1 Jun 2026 10:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780303238; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=859Mw0cJmmb6gjd0ybDixiH+mwHlqm5Uah1fsB5XgEY=;
	b=tMWw4u6gbRlLKWDwk5CqBJnlToUfXS1qWiuUII2Bog3/VA+OGlHszGSGhNRTRFDkiK7i09
	p6q9TvitJGu8Z/8YUYvA/CzSHCvWNNzD0d6t6oS5dtdla2m3+RuDXlGoMZH39BeaxYEN5d
	hu8vlzNUpKensIdZllvscsaw17v/7g9sHdn/39nvK/onBezEb4W9MTSaNcWkFwEufzAAc5
	33J73fr1KU5p4OPrrckLLKrNNcGwCnZjhsBqm3cHSbbONQHjaGm1cPgkqZr631daqkxRwy
	38aMtCXCHbkK/THQQi1l1BR7xCIyleqqaAsSHV2LsMOXpbwhPk9abPi7HppP+w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net v2 3/3] net: phy: don't try to setup PHY-driven SFP cages when using genphy
Date: Mon,  1 Jun 2026 10:40:28 +0200
Message-ID: <20260601084029.815461-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

We don't have support for PHY-driver SFP cages with the genphy code.

On top of that, it was found by sashiko that running
sfp_bus_add_upstream() for genphy deadlocks, as for genphy the PHY
probing runs under RTNL, which isn't the case for non-genphy drivers.

This problem was reproduced, and does lead to a deadlock on RTNL.

Before the blamed commit, the phy_sfp_probe() call was made by
individual PHY drivers, so there was no way to get to the SFP probing
path when using genphy.

Let's therefore only run phy_sfp_probe when not using genphy.

Fixes: bad869b5e41a ("net: phy: Only rely on phy_port for PHY-driven SFP")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a171cbe2a74a..8eace58e9f12 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3512,9 +3512,14 @@ static int phy_setup_ports(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = phy_sfp_probe(phydev);
-	if (ret)
-		goto out;
+	/* We don't support SFP with genphy drivers. Also, genphy driver binding
+	 * occurs with RTNL help, wich will deadlock the sfp_bus_add_upstream().
+	 */
+	if (!phydev->is_genphy_driven) {
+		ret = phy_sfp_probe(phydev);
+		if (ret)
+			goto out;
+	}
 
 	if (phydev->n_ports < phydev->max_n_ports) {
 		ret = phy_default_setup_single_port(phydev);
-- 
2.54.0

