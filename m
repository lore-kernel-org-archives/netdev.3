Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD02673B0;
	Thu, 24 Sep 2026 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273179; cv=none; b=Qo+iX0KBD6U66E8ms8ObjO6fFHmYbfPIR5BQv9iO1W6I8dnkTJbRFFaUOB6FEpqvpKb3cTzIgVN4C+8gI7ianRdensbE5Ah0Wss/MeyAzUuPUGw2MfRjOFN/1qKhsAKyJX3XCDYsJD0KJ5RyjUYvwBC91uYg41a3H5qhEycHNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273179; c=relaxed/simple;
	bh=Y1+7dQfnBLtpJ3fUnh6CVR+XPKnQosCyu5Oy87/d99k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHYISRgsWlhoHDze5mLgVkTgXqIV2ni5jrGKMTe9UbA9CSGy4bOjE2JKFe042uuK4OMFTeg1a9MBy1y//uALlcym+bxvU5vLnNzV1ZipWdo5hBAH975B4o9tIFDHPp+beKMVLKIDBr95PHh5LemUDxNlc7OSgUovHgn0X3IKnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=KFuaBJLH; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="KFuaBJLH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72E9310495D;
	Thu, 24 Sep 2026 20:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790273171; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=yZbG7EDxzq6EGbpOvn4qy5pdZdFyqtMwIGB/4X51pHQ=;
	b=KFuaBJLHZPeIjv3ft2tLNGCSGeUhpOZab326Cp0yiKKhSEWcrZCkVQOrTk8EtbwBAn8Kgp
	cr9GXMjb8i1dc0ma068vKW84KNTUKmjMcNqZOgCB9w+EGo1c0UZsBSsslswK2PbYEkKSZj
	Alz4ykJgn/V0SXGoqrALhu6UP8/Dvu+1Knmnu1fDFDPVeTpzWRS5N83lUjJHBmQL+iZxUq
	eCSrrfOgTyhkVEZ6BToKhNfA/VLHG9/bVzd6oumzx0vFJLk5B+n7kqmnBNJKy99TTw4QAR
	4uD6iFIaCsYAmlCgTiM7URpaPxnPGg0TLIqQdRB2PFZm686Liy1RhykXH4j6nA==
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
Subject: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Date: Thu, 24 Sep 2026 20:05:19 +0200
Message-ID: <20260924180607.60932-1-marex@nabladev.com>
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

As a minimum change, increase the MDC clock to 2.5 MHz which matches
the 802.3 specification. Also, even old PHYs like LAN8210Ai, KSZ8794,
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
V2: Use 2.5 MHz per 802.3 spec, update commit message
---
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
index 998aaa394e9c4..a90a04a47befd 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
@@ -24,7 +24,7 @@
 
 #define ENETC_EMDIO_CFG \
 	(MDIO_CFG_HOLD(2) | \
-	 MDIO_CFG_CLKDIV(258) | \
+	 MDIO_CFG_CLKDIV(66) | \
 	 MDIO_CFG_NEG)
 
 #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
-- 
2.53.0

