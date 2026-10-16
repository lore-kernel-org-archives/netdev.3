Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC3487CF0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175896; cv=none; b=TNILw/216MVE9Nh15ZFZRNHYSaNX9MeNonAgVOrHpfZLy9emjzrB9NFEGkDPdadwyQyNo4R6nydbi9Upm3/MtxGI/79gV2uy41elW1+df/e7nlU+qAn9CEVvbH3uQ71s+h3QXMuBTahnUoYzSbAgF9bLL5pgzOmIW4wvnb2X8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175896; c=relaxed/simple;
	bh=GvKsuENTrQHOfPZEd4h9uKsA+6rtzet/D/9I+J2KKtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y++ircokRf2DyMI0qBn0RwB4qp0NM5m8Pyc0dE+XQutgP3uRnfPbk3m9owrkQCtRSDKSXEwnaZE9egBh8fw6Fjj5+MmvE6MuP9PzO6qMcZB9mbB3MHKvnBSV5PeWpV4ZF/lw9QKVVneeDM6wOj2VZ+DvrC+6OfU0pnPVVZbdHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=j8nUAF2Z; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="j8nUAF2Z"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C7BA1060E4;
	Fri, 16 Oct 2026 20:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792175888; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=cQj2Q90MupHjRjGZgKF4oV9E2GEJk/cNp1updTRRcAY=;
	b=j8nUAF2Z7+ykrELW52n5JeGHRarkTmTp4JArFNN94RgPXVwKUsir+ev8af31t5+KhC4UQg
	UBUwxqgBEMapwDWvACMPDQNug9mEamYHpFR9zkz/gYFMJYuMn8upcR1QNwAZaI+cKdKY8h
	sGrAm0Bxe9A2yRbf6ojuTJFzWFR70sXESoO8rOaat+ypWg+MYIT324xyqkxP21M4CRe3t5
	czjZAagpl7fZHJz1AvYC+aBiYLrbnJrsaK6ANd4OtyWuVI0Vv8rUEcalf07UQuEWc2xoED
	LwLR6a3d0PFyHFa8joBUBausuIQ+vHuy2BaaipHdyh1J0JxP9ufKmeBEXDbwEA==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [net-next,PATCH] net/fsl: xgmac_mdio: Add missing newlines to error prints
Date: Fri, 16 Oct 2026 20:37:42 +0200
Message-ID: <20261016183804.39217-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add missing newlines at the end of debug prints.

Fixes: dd8f467eda72 ("net/fsl: xgmac_mdio: Support setting the MDC frequency")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/freescale/xgmac_mdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index 65dc07d0df0fc..c7df633050683 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -336,13 +336,13 @@ static int xgmac_mdio_set_mdc_freq(struct mii_bus *bus)
 
 	priv->enet_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->enet_clk)) {
-		dev_err(dev, "Input clock unknown, not changing MDC frequency");
+		dev_err(dev, "Input clock unknown, not changing MDC frequency\n");
 		return PTR_ERR(priv->enet_clk);
 	}
 
 	div = ((clk_get_rate(priv->enet_clk) / priv->mdc_freq) - 1) / 2;
 	if (div < 5 || div > 0x1ff) {
-		dev_err(dev, "Requested MDC frequency is out of range, ignoring");
+		dev_err(dev, "Requested MDC frequency is out of range, ignoring\n");
 		return -EINVAL;
 	}
 
-- 
2.53.0

