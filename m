Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB42DFA5A
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782247; cv=none; b=ly/zNg9AP/mTG+3ZjVCUXCFIwl9XRybGWbOIZ1N7B6CfZUapbUer5wW4z+s3/Li+HAcbzqQeQyHigfg+er2Nq3ogJoPYg0cSVZz/q1/0UaERJJRJUl5JGoUoAWp8bPzSJbRQe/nutj/uqACiJvDo9iWxXcgT/eXgPrNnrlsXFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782247; c=relaxed/simple;
	bh=OF/Ccgm4fDLGt5AzDImX+bKVosWbb/r92z4HMyUHmWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EXa1FsZDHJHTeUDS4USYo2HuQ2BLAa07zh/LZYxpQTME4397zGIooy4aUbzTj31NuKxnwKDdD/9EQxfmQF8d5LaKOXrdMrpwkwhQQs+4zL5h6insgGpwMoAZqVEYVIH53nVaBTK8esj6+/E+H8dRIWtWAlXlA4V05SZcYpIxS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B6B81A072B;
	Fri, 30 Jan 2026 15:10:39 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4ECD41A071E;
	Fri, 30 Jan 2026 15:10:39 +0100 (CET)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EF9B120263;
	Fri, 30 Jan 2026 15:10:37 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net 1/4] net: enetc: Remove SI/BDR cacheability AXI settings for ENETC v4
Date: Fri, 30 Jan 2026 16:10:32 +0200
Message-Id: <20260130141035.272471-2-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130141035.272471-1-claudiu.manoil@nxp.com>
References: <20260130141035.272471-1-claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

For ENETC v4 these settings are controlled by the global ENETC
message and buffer cache attribute registers (EnBCAR and EnMCAR),
from the IERB register block.

The hardcoded cacheability settings were inherited from LS1028A,
and should be removed from the ENETC v4 driver as they conflict
with the global IERB settings.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 53b26cece16a..e380a4f39855 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2512,10 +2512,13 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	struct enetc_hw *hw = &si->hw;
 	int err;
 
-	/* set SI cache attributes */
-	enetc_wr(hw, ENETC_SICAR0,
-		 ENETC_SICAR_RD_COHERENT | ENETC_SICAR_WR_COHERENT);
-	enetc_wr(hw, ENETC_SICAR1, ENETC_SICAR_MSI);
+	if (is_enetc_rev1(si)) {
+		/* set SI cache attributes */
+		enetc_wr(hw, ENETC_SICAR0,
+			 ENETC_SICAR_RD_COHERENT | ENETC_SICAR_WR_COHERENT);
+		enetc_wr(hw, ENETC_SICAR1, ENETC_SICAR_MSI);
+	}
+
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
-- 
2.34.1

