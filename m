Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ABA2FD665;
	Thu, 17 Sep 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608124; cv=none; b=TxC/QCpDpxsG0cc0TQrpcshaTG+md/srhCbLMJxJgOQjf66o95hUkNRolQ2wcXybG7/R0gGA2jTV3l/egSQaj/wQtLKSvAF4kivnIBu+0pOx5EBRFWoevtiMq7aotWwUaKWWp4ggyiOQk8TIT5NlQJcaFpN7LcMv6hi+e7yDUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608124; c=relaxed/simple;
	bh=rrv0ZsKZkUrsFxngXKcbhlEXSxHcCSrCkjHauOs6nxs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HfX0/AktoDDt1Rcqsan1bsLmjnXJ3sHm3MaMKMH09LEf3mopVpQe1iN239Z38ZIsmjeCMkw6OdzNQilB+69prxhlriFrrHUXs4FuV/nt+mZz+GdRjODqQgNZ3QckbTO0hq7ALUCgBOPe6cwsddiRXYuBiCjzyz9oRoUEn0vOSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R19IqMMb; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R19IqMMb"
X-UUID: 2c4436a0b23611f18dc8c9802ae25ab1-20260917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3jQnTexqLKlsnZgBOq3eCESiN5enzxrupb9BUw6kI2k=;
	b=R19IqMMb7cMU8veLH4GljeUXzmgnWVjL4t09TUNP6Rkd2gUnTILg5yHc+B7+RddypjNkC84F7Gftm1sg9k0kM2ZaYwnev/w8EIgOdMHW6J9l90Un7RlJAlgT/61XA2ydRApPv6jyNlRFzk5UW+2Sq1j+v+8Qo/ZNxapnbE/nVEI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4f96e879-d44e-423e-b3ea-272219574f4a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:202f6928-9ebf-4787-bb42-3cd26eee85aa,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2c4436a0b23611f18dc8c9802ae25ab1-20260917
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ar702101@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 297475316; Thu, 17 Sep 2026 09:21:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 17 Sep 2026 09:21:55 +0800
Received: from mediatek.com (172.18.153.125) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Thu, 17 Sep 2026 09:21:55 +0800
Received: by arhtenbupstream01.localdomain (Postfix, from userid 1007)
	id 503B9140DB0; Thu, 17 Sep 2026 09:21:55 +0800 (CST)
From: Weiting Lee <weiting.lee@airoha.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, <bjorn@mork.no>,
	<ericwouds@gmail.com>, <frank-w@public-files.de>, <joseph.lin@airoha.com>,
	<wenshin.chung@airoha.com>, <lucien.jheng@airoha.com>,
	<albert-al.lee@airoha.com>, Weiting Lee <weiting.lee@airoha.com>
Subject: [PATCH] net: phy: air_en8811h: add dedicated suspend callback for AN8811HB
Date: Thu, 17 Sep 2026 09:21:02 +0800
Message-ID: <20260917012102.3103131-1-weiting.lee@airoha.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AN8811HB hardware requires a re-negotiation sequence before
entering power-down to correctly restore the link upon resume.
Add an8811hb_suspend() to handle this.

Signed-off-by: Weiting Lee <weiting.lee@airoha.com>
---
 drivers/net/phy/air_en8811h.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index a03d63dd4ac9..5b1edb127c68 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1573,6 +1573,19 @@ static void an8811hb_remove(struct phy_device *phydev)
 	}
 }
 
+static int an8811hb_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	clk_save_context();
+
+	ret = phy_modify(phydev, MII_BMCR, 0, BMCR_ANRESTART);
+	if (ret < 0)
+		return ret;
+
+	return genphy_suspend(phydev);
+}
+
 static struct phy_driver en8811h_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(EN8811H_PHY_ID),
@@ -1606,7 +1619,7 @@ static struct phy_driver en8811h_driver[] = {
 	.config_aneg		= en8811h_config_aneg,
 	.read_status		= en8811h_read_status,
 	.resume			= en8811h_resume,
-	.suspend		= en8811h_suspend,
+	.suspend		= an8811hb_suspend,
 	.config_intr		= en8811h_clear_intr,
 	.handle_interrupt	= en8811h_handle_interrupt,
 	.led_hw_is_supported	= en8811h_led_hw_is_supported,
-- 
2.43.0

