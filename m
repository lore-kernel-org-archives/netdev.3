Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D717C203;
	Thu, 24 Sep 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209918; cv=none; b=eHMriGoNxJ+v0CjXwPC4thuDAkI6aRC9bLUOh4HiuK5bsZnqyvk2nX60rXN5Wvb0mGYsGjUsf4++MCEzP24JrZYoIEC8xMT1SlBOQoqKwPNKH2Hf47XgBYuaaFW4WLKLQbXEFEkalr0FG+uifcGo7X+f+/I5Ow18yBCENOt8vdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209918; c=relaxed/simple;
	bh=DCMEs3W/VY9ntGtGNtRm+QaGtpqva0uHRx6sySBE5DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLcFa0lzg2BlALCp/nf0X0GD/Lzfnx5cGS3+JbQE0ctoV+VUow1BLmyzjXHQlMshwYgYxSELopCJyQAys4I74oHTS2ULzqLunCGiHM56w6m//Fds20/j7HDwPnJLtcjtn3GxZx5lOLpKKui7+sjmwYCqWxOF+qEti9Mf+N9PA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=AaFv279O; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="AaFv279O"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0F49105B30;
	Thu, 24 Sep 2026 02:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790209908; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=bIla9WS4q+EH9bLUK0Yr9DxP2K0ikL42KF8TxnynahA=;
	b=AaFv279O1b+ULW+bBqdyq61KQtVnenL1ph3J2jqSt/cCwSHMDFPNlRUVxucWK/3m6WmELU
	wKeKNoeMBKChrJgNqj8VJGVsH5d44g1rwJ+xy7GCNS3z03zAVo0PjNRBFcYwkj11+Jhl5T
	vnW9IU7uLENe4rkH9+o1hxTgDBuDF/JhNynmw9ktP/48th9pQa8ehYsNdFZAaMIrIWw6ju
	4Db34FzzCPnjCp4+FpG9N4HFcZlLx9WoUkwUmAtE77Pk/rYp4plPPxWF1iHrW8/qTNRUxg
	hCs1mJSJY72sqptLSRsuFRLXuHIy9/SsP7Z4rzl0TREBokgqMIKu4zjJpceB3Q==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [net-next,PATCH v1] enetc: Increase eMDIO MDC rate to 1.2 MHz
Date: Thu, 24 Sep 2026 02:30:59 +0200
Message-ID: <20260924003132.580306-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The current eMDIO MDC rate is 558 kHz on i.MX95 B0. This is very low,
but also very compatible. However, for example NXP TJA1120 PHY needs
at minimum 1 MHz MDC clock and 558 kHz does not work with that PHY.

As a minimum change, increase the MDC clock to 1.2 MHz which should be
equally very compatible, since even old PHYs like LAN8210Ai, KSZ8794,
DP83822 support up to 2.5 MHz MDC clock frequency, and it covers the
NXP TJA1120 as well. There is no known rationale for why the 558 kHz
was picked when the eMDIO driver was added.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>
Cc: imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
NOTE: Alternatively, I can either add a DT property to configure the
      clock rate, or model the clock as clock hw divider and then use
      assigned-clock-rates DT property to configure the desired rate?
---
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
index 998aaa394e9c4..30ea91cea00e5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
@@ -24,7 +24,7 @@
 
 #define ENETC_EMDIO_CFG \
 	(MDIO_CFG_HOLD(2) | \
-	 MDIO_CFG_CLKDIV(258) | \
+	 MDIO_CFG_CLKDIV(138) | \
 	 MDIO_CFG_NEG)
 
 #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
-- 
2.53.0

