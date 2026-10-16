Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4B4BF376;
	Fri, 16 Oct 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177117; cv=none; b=Yk3AzhVXQk+a3uJD3xZ7nuv19RzOQjNamX+Z4UvgTj8ft5h0+DonSgr1PssiQKEI4ctelFOGQTAkVOvh1eRhnyi20j1226Pv3hgj+FL+XSgzn4Clp7prpylFp9LbO+CyLHjmrptMSOJtnLN6KIRvrYzuYcOpvFEkD+Afy41KDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177117; c=relaxed/simple;
	bh=c07PDig+LSsE24sQR4HQwR8JnWSTzX5sad8ADiutG3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thCfUKV3Bo7A91u6j8siybHZYuV0JCY/kAKkezXqTCVN8ecswlZouw8aN3hidk1coBTbVkI5HrXuniwVLqMRMy0m09NODyfwRaiRRqddvhcemgiluoRW+Uhbz5oWv/jDXojsjhFRUD+JzEFLnKxb1eG/QklMH9gyjBm28sqs7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=iCcXohur; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="iCcXohur"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACFAD1060F1;
	Fri, 16 Oct 2026 20:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792177101; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=3M3kA3GZbcaM6eIdFleDuwMC14PtsMd6qtqktQqPFSE=;
	b=iCcXohurxm6O4ru4PCCQYfFl8lWcLu3E5FNfUVcPdNZMvhsNr0TKrPil/ppnwj+RkLboq1
	GRvstPf8HGuxz+F0bisaB5nI+lGtTqLG4V2C5+9x+9IJdgph+7F2S+g4j4eb3vyeonuPL/
	ABjwt7anNn417szKlzGabfKAmOFY3RCvNgzbqTFScmrv+9SNGINaSyO7LGJkXQemqaEb70
	AvqG4x4teMftB6XJthjPMjj3YsDYBqO1gWKI7QUt7ZGN3zjxFuaOskzeAoPoplRFpXBQpP
	U5MFIwupId91Q+SwA4sH2AaMgglVcPXuTAqRJ0IDq+h6r5kTwSH5xJ8T4Clymg==
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
Subject: [net,PATCH] Revert "enetc: Increase eMDIO MDC rate to 2.5 MHz"
Date: Fri, 16 Oct 2026 20:57:38 +0200
Message-ID: <20261016185817.54096-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This reverts commit 587acb86d6465efdc03f6d8524461e6e725597b7.

While the i.MX95 MDIO MDC clock is improved by the commit
587acb86d646 ("enetc: Increase eMDIO MDC rate to 2.5 MHz"),
other SoCs use different base clock for their MDIO and the
MDC clock on those SoCs is set out of specification by the
aforementioned commit. The fix for the i.MX95 MDIO MDC has
to be done differently, and will be done so in a follow up
change. Until that is done, revert the commit to fix the
other SoCs.

Fixes: 587acb86d646 ("enetc: Increase eMDIO MDC rate to 2.5 MHz")
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
NOTE: This is for v7.4
---
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
index a90a04a47befd..998aaa394e9c4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
@@ -24,7 +24,7 @@
 
 #define ENETC_EMDIO_CFG \
 	(MDIO_CFG_HOLD(2) | \
-	 MDIO_CFG_CLKDIV(66) | \
+	 MDIO_CFG_CLKDIV(258) | \
 	 MDIO_CFG_NEG)
 
 #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
-- 
2.53.0

