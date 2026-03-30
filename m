Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290323D6683;
	Mon, 30 Mar 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877438; cv=none; b=bylXu0RqyJD98sRi+Z+BF11jvVZ+88rp/miZT6qR4vb0XIqiUbTQp+5tLzG+rlhUPNgWFBEgb1unEKZymQgRvqIdsJpUA0T6M91Ws73fhP9FQ6zh892z91VeUAsmxxjvEztB4v+zlb4YpnvExO4ohOptZYlEM7hnva+1MVzEtJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877438; c=relaxed/simple;
	bh=it94019hWDi5+EXmvp75kgDn02LPqyjsNMrM+AQU/Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReBzMwblqI35FzHem0Lk27vLU0c2n0E4yXbd8p1egW2Vaks5YzdKwFvCByQRfM4bDsa6NuYdjzuNxjcpEhM0uNO7//SBOtYqa7CIxy5lj4m5QVBR8fQUhoaVcSSc8+TrXrhD93isiMQ3bVfeyk7u8/7O2PomniA+vIBaCdnrUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=ggzdcOXD; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="ggzdcOXD"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 9F82BE83AA4;
	Mon, 30 Mar 2026 15:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1774877435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8V18lfevbDQW5TG2gGwA3EgNlE6m1hYJ87gxmtAghI=;
	b=ggzdcOXDMB2TY+K511w+aHfLN9jlR//RpXi/7uC04VC+4hJrdcK1Z5ziyR5I8l6NXxZQ05
	Y5iYqWexwz4gTWk/bGtL+JJbBOiqoZBzO49lsTeZbTuhjKsn8kPFsujpTLE/2ZzLVdx5UO
	ldMGdaPOm9IWHCPvO2TYRTLFJr7rI2yU7MkhaHUXVvI8x+kZeSvSFhBl2iWd6YlnAdbKEi
	vt5Lb8SwuZo0zcIhG0HFfyIMRsNhszvMltzlg66dTNq+IaH8973ZeyIl/ORhfnyPJWLEH6
	beNstmgS3fDz2hzEcybuS6dxyDqi3KrPfXKGrVmge1WwL26eNGzJYOIKZk5ISg==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id teRtMx4CBOZK; Mon, 30 Mar 2026 15:30:35 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 30 Mar 2026 15:30:35 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as non-fatal during PHY registration
Date: Mon, 30 Mar 2026 15:29:52 +0200
Message-ID: <20260330132952.2950531-4-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330132952.2950531-1-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
 <20260330132952.2950531-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PSE controller driver is built as a module, it may not be probed
yet when PHYs are registered on the MDIO bus. This causes
fwnode_find_pse_control() -> of_pse_control_get() to return
-EPROBE_DEFER, which currently propagates up and destroys the PHY
device.

Treat -EPROBE_DEFER as non-fatal, allowing the PHY to register
successfully with psec=NULL. The PSE control can be resolved lazily
when first needed.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Acked-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/mdio/fwnode_mdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518265..2a03b3fc41e6 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -161,8 +161,12 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	psec = fwnode_find_pse_control(child, phy);
 	if (IS_ERR(psec)) {
-		rc = PTR_ERR(psec);
-		goto unregister_phy;
+		if (PTR_ERR(psec) == -EPROBE_DEFER) {
+			psec = NULL;
+		} else {
+			rc = PTR_ERR(psec);
+			goto unregister_phy;
+		}
 	}
 
 	phy->psec = psec;
-- 
2.43.0

