Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F3A31D72B
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782249; cv=none; b=tT8n5iBnvRzXfNpqLascizciIgc4gAASqjfvmLdFbdGGxiGR/D/OpDzsRlWOVQoCxgGQJxyROtDXkLSFwkNapozLS3EsQfL3WreTwmk9ztSXsLiNHIJnYE9+8SVSX9W1/EKcbZLLZUCNiZx35MI0cyfG6b8QXpMANYDntpyPAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782249; c=relaxed/simple;
	bh=kKysxAZk48FOOwromC64Vuv3HvTQ6QsR8vCARd3WMeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYzhTqc6WuNeNXxQlEkh82ksSuDbXYFTFsHS6PJhtnCHPI+hhzg75hV3Pws1UL3mwrjPVX6BZt8uWMtdT5PtiAsTzj7XMBWRkdpYvE5CkJoQes94rBm5aZHyr1F7xpAIAlgSgkUWyaHmO1QVLVvGo5iaDEOWQEASxEUPBSADPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22949200704;
	Fri, 30 Jan 2026 15:10:40 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 14DFC2006E8;
	Fri, 30 Jan 2026 15:10:40 +0100 (CET)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AC36F20263;
	Fri, 30 Jan 2026 15:10:38 +0100 (CET)
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
Subject: [PATCH net 2/4] net: enetc: Remove CBDR cacheability AXI settings for ENETC v4
Date: Fri, 30 Jan 2026 16:10:33 +0200
Message-Id: <20260130141035.272471-3-claudiu.manoil@nxp.com>
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
command cache attribute registers (EnCAR), from the IERB register
block.

The hardcoded CDBR cacheability settings were inherited from LS1028A,
and should be removed from the ENETC v4 driver as they conflict
with the global IERB settings.

Fixes: e3f4a0a8ddb4 ("net: enetc: add command BD ring support for i.MX95 ENETC")
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_cbdr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
index 3d5f31879d5c..a635bfdc30af 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
@@ -74,10 +74,6 @@ int enetc4_setup_cbdr(struct enetc_si *si)
 	if (!user->ring)
 		return -ENOMEM;
 
-	/* set CBDR cache attributes */
-	enetc_wr(hw, ENETC_SICAR2,
-		 ENETC_SICAR_RD_COHERENT | ENETC_SICAR_WR_COHERENT);
-
 	regs.pir = hw->reg + ENETC_SICBDRPIR;
 	regs.cir = hw->reg + ENETC_SICBDRCIR;
 	regs.mr = hw->reg + ENETC_SICBDRMR;
-- 
2.34.1

