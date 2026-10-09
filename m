Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FE3CE489;
	Fri,  9 Oct 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550187; cv=none; b=EIgl1uSTdWfs04tFH7F6Rj8A/JRSemTiyZR7bXEpeKpJA3zE+XaWqO0zuLXLgfr3HFhWNxT5orQLH2pK2xK5iD94mQbSDCfal6yNJH2fDdTb0v8bY9/II3MwpfAxw6OX2BoSMn1qSJ+hyGt+8TAPPqksEu6wTixqmE9iocqGeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550187; c=relaxed/simple;
	bh=LlBAUT8TkMZ+fQyTT6oKF4QsDUvUacbVxvQB5phgenI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9eLn2zxqyOaysUct7wc3/KTU/fdSB+J3OIzRoxnx88Ey18pIEPOwS0M2siRB7ywFI93/fY4lcVYsQUOnNW5NYvtf4DL7joeUlI3bNCls5hDLmOgwKfsZUBJu1sPu7eRf0YD2LvChhwE2YHdbqTBgpjdn9C524AmohoPQ+2YglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 645591A0305;
	Fri,  9 Oct 2026 14:40:40 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5701B1A0303;
	Fri,  9 Oct 2026 14:40:40 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BE4512037D;
	Fri,  9 Oct 2026 14:40:38 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 2/5] net: enetc: Enable probing of version 4.4 devices
Date: Fri,  9 Oct 2026 15:40:31 +0300
Message-Id: <701f38d08f9ea371877645223e6ac919af7870b5.1791548316.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791548316.git.claudiu.manoil@nxp.com>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

The ENETC v4.4 devices are present on S32N79 SoCs and feature only
Pseudo-MAC ENETC ports, whose PFs expose both the 0xe101 and 0xe110
PCI device IDs, while the VFs answer to the usual device ID of 0xef00.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c    | 12 ++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_hw.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c6571b5cc842..be7795d4e0c6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3862,6 +3862,18 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_VF_DEV_ID,
 	  .data = &enetc4_vf_data,
 	},
+	{ .revision = ENETC_REV_4_4,
+	  .dev_id = NXP_ENETC_PPM_DEV_ID,
+	  .data = &enetc4_ppm_data,
+	},
+	{ .revision = ENETC_REV_4_4,
+	  .dev_id = NXP_ENETC_PF_DEV_ID,
+	  .data = &enetc4_ppm_data,
+	},
+	{ .revision = ENETC_REV_4_4,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_vf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 2c9d9042eb0b..64789bd0f33e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -414,6 +414,7 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_REV_1_0		0x0100
 #define ENETC_REV_4_1		0X0401
 #define ENETC_REV_4_3		0x0403
+#define ENETC_REV_4_4		0x0404
 
 #define ENETC_G_EIPBRR1		0x0bfc
 #define ENETC_G_EPFBLPR(n)	(0xd00 + 4 * (n))
-- 
2.34.1

