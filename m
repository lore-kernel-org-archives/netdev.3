Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A7400E01
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565314; cv=none; b=poWRx3D6OkqaLFWYgfmWbbR6KAmYSKHyjWhI/b97LpRl/KQaA5HdIeLQRxba4Hfkh7sTyOBhTIKlMUpz0qmVoW8tYCG5KQ5Jh6VtaRg5SIOXGnwfx2AJYZw5Av3sQKKnX2KZY1s3T6lvj/bwXmBL7QP/eCXGwZZvjajN/gZ9G9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565314; c=relaxed/simple;
	bh=jskCFflmxToUINjJmLffODvvm6DVOanoQ5eEaEd+aVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZToobUf7jcn1K3W7ReCYOLBPPei2FXtfD8yWldgSvGQBMr/GcDJcCUEHWxnIFvny7uGuBDnK8Uz3r+woZXHIOc1B5BEi//dlPWYPu8tcm4XBy9X9k5KgAVrCXWW/x+7qujwPSEF3nRVd11O/iCUNN9Mg0mWVFyfRjqazJz6k1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jFOlI3bO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jFOlI3bO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B96CB4E406AC;
	Thu,  4 Jun 2026 09:28:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8CFEA5FEF7;
	Thu,  4 Jun 2026 09:28:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDC09106A17C0;
	Thu,  4 Jun 2026 11:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780565310; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=YsRgl1lRAk6jP9fJqYly+oGLmo/o8RaokN6f/Q0aPJY=;
	b=jFOlI3bOuPoe+KcopbAWXAHlKCLBJmjGsmlFd1z/oFxMWlwk/ulCgkDc9k5b6QAUSesoOR
	Cl5zLQnY8kip0261+ZGGzyW2VZHX0Zx5vpAdslTPk2yhVvYkS+/PMgDyozG30i48uJiU3t
	FtmcoExh+YdIOuO8XwWTXW+8/Dp9afLQJptpNybULvSTX4SxtCc2/hlWtzrfrwNABYnBnt
	5h86l7ww7MR2kCTCvSYDdzKvyZFJnISTImhq1P69uMLASQFLKBs223cxb+8CJDltF2odlg
	tp4RgfZn7/1Yfy8+wFB17pEIF1Xre10shK0TpXtjclEM9vyN7QnUsUI0hyYmCQ==
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
Subject: [PATCH net v3 4/4] net: phy: don't try to setup PHY-driven SFP cages when using genphy
Date: Thu,  4 Jun 2026 11:28:18 +0200
Message-ID: <20260604092819.723505-5-maxime.chevallier@bootlin.com>
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

We don't have support for PHY-driver SFP cages with the genphy code.

On top of that, it was found by sashiko that running
sfp_bus_add_upstream() for genphy deadlocks, as for genphy the PHY
probing runs under RTNL, which isn't the case for non-genphy drivers.

This problem was reproduced, and does lead to a deadlock on RTNL.

Before the blamed commit, the phy_sfp_probe() call was made by
individual PHY drivers, so there was no way to get to the SFP probing
path when using genphy.

Let's therefore only run phy_sfp_probe when not using genphy.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Fixes: bad869b5e41a ("net: phy: Only rely on phy_port for PHY-driven SFP")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b48722589f40..1511385b9b36 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3512,9 +3512,15 @@ static int phy_setup_ports(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = phy_sfp_probe(phydev);
-	if (ret)
-		goto out;
+	/* We don't support SFP with genphy drivers. Also, genphy driver
+	 * binding occurs with RTNL help, which will deadlock the call to
+	 * sfp_bus_add_upstream().
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

