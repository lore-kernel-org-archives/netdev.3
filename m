Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73C522F05;
	Tue, 13 Oct 2026 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911577; cv=none; b=LWAoV2N5laDyGelWMFyRWrlNR8Njpf3/ECbjFPJXmbey4w6DIB+USeKaR2CASFu+sDzC1EYAWCMz3pRdVSrpIyZ7AW12uYD3tLTVxjrtz8GPzbs5769/t3EL6wmZm/fNiz6vHK6gZQkN/n4imiKTpJfQ08L2OrnBlF4PO+RnEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911577; c=relaxed/simple;
	bh=xSkfTaYrSMPHg2IM9WCzV6VsQG8nhipepnWid2s0Mi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOQagtENMsdRENNZpRpjfZAnLX6NdwRky8pdt1FcfpjI+GogcG1PeJcsRtqBtHKksimJrjer9rOzHZIpsMcPoXrhMsGN01wq3bn8Yl9SyVK53vE4cJPjekknojm/PAIuAlHf1GdovO9hTSZeU974f+ZfAAlaOJTcHoTXIvDsPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B979F20021E;
	Tue, 13 Oct 2026 19:12:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ACDC22000E4;
	Tue, 13 Oct 2026 19:12:53 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A64C7202DA;
	Tue, 13 Oct 2026 19:12:52 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev
Subject: [PATCH net-next v2 2/5] net: enetc: Enable probing of version 4.4 devices
Date: Tue, 13 Oct 2026 20:12:46 +0300
Message-Id: <537a977b10b3d76c30b1f879f423bde4fd6f42f8.1791908694.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791908694.git.claudiu.manoil@nxp.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

The ENETC v4.4 devices are present on S32N79 SoCs and feature only
Pseudo-MAC ENETC ports, whose PFs use either the 0xe101 or the 0xe110
PCI device ID, and the VFs answer to the usual device ID of 0xef00.

While the ENETC PF instances are usually designated by the 0xe101 ID,
in newer IP versions the 0xe110 ID was introduced to indicate the
power-on reset default NETC switch management interface. These IDs
do not indicate any functional difference between the designated
ENETC instances, and can be interchanged and re-assigned at boot time
(i.e. from firmware).

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2:
 - Described why there are two ENETC PF IDs in the commit message, as per
   review.

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

