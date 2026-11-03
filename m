Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714963;
	b=wo2S1q9dw+ahpXJPmpiRt4O42datuRvQEtRBFamBdrH9n/AIp2GKi8mBfh8sHdrED+4h
	 Ne1pIdTJWEnYo/+vkTgg91b8mdXQ3vdDzuegyMDXUPTc518P97CAZCFQ+DJixZ1gRFfEg
	 f9uncu8XuXfVyVm2/xNNCVvG4Jp0sJx9aihM8lDKzlJlX1/MWw+XW8IhiazgJhiYHNhZd
	 lIRnx3/T50MFz2kyoLtPfB+Zi0GZu7FbATaHykh+aK7dYqdNkfKe1f1M+rKHdV0rvhlAv
	 PFex0w0zH8Z2uw+qxuTPKLogOqk1g3U8g7Aia2BJJtaFKMLIdQ/vW/h1gZistnO/2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714963;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pAU6lY1mmWFrbMj2mA1SlbUUOB4e4rqx9wfmZ1QBWLA=;
	b=grdk6C5mKHViRoip5c84sHahJQwI1iP1X7Pp2hkcSuI/wJMe1eh/kj16C7WYmToDks21
	 2g/cCHpUC8DGNW2WX+UqNlaSpBPIU1Ke8uN2KgP9bmrGVYBlGxa1ydVzHDl6AtjaWVLWu
	 H+ZKK4epqYuLdcoRYWaVEY0EfdWBRjK0H1L1DBNt11yYd8mgP7OYOPY9BReJQIKMzMqQW
	 OwizC+XLLS4TrDFYDE6HHI+g1pQIARTPCMwIsFmWo+PtxauwrWFUxOB7mL+qsK86X2Qi4
	 hkSxJPUq/FFfpBIVZ0JWYrBoNRhNWNLuXBMjj7Ov37RWwf/o5reRrEJEHDVoE56ppGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=PQb0tKqk;
	arc=none smtp.remote-ip=92.121.32.54
Received: from inva129.nxp.com (inva129.nxp.com [92.121.32.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E6606A337;
	Tue,  3 Nov 2026 14:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B8E6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=PQb0tKqk
Received: from localhost (localhost [127.0.0.1])
	by inva129.nxp.com (Postfix) with ESMTP id 6AB996000295;
	Tue,  3 Nov 2026 15:09:16 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva129.nxp.com ([127.0.0.1])
 by localhost (inva129.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ic6YV_2UnzoN; Tue,  3 Nov 2026 15:09:15 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva129.nxp.com (Postfix) with ESMTP id D74DE600028F;
	Tue,  3 Nov 2026 15:09:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva129.nxp.com D74DE600028F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1793714955;
	bh=pAU6lY1mmWFrbMj2mA1SlbUUOB4e4rqx9wfmZ1QBWLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQb0tKqkU0tWI7cEKn34hUThcwU1ZZtJpJzeauhGlZ7WYxkQC9sPN/LlBROUISzgx
	 9WPGoOWIXFCP6AFDCz6JBkawzrgooM1b8XltbgFxgLUnkv1SquUXPuhmFvzF9s1uW9
	 XFc5dNOAkuWWQIieUnzqp3KhomEMFrLZLnxBi0C8hiVqx3BMhdNn7WyxZhS8/hCsGh
	 V7MGpazSdX4X1cSMemNXqgKPDOld99DLRAL0dCK6Av8IRVx49axWvamHEjC68kOe2h
	 2d6bxYWksImYAoxC1gSuz2n1SMmrFervn0JHqZNEA2zj9dTalGt0qbIqfGUoF0Tig/
	 w9uiZi56/YcNw==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B32A202AF;
	Tue,  3 Nov 2026 15:09:15 +0100 (CET)
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
Subject: [PATCH net-next v3 2/5] net: enetc: Enable probing of version 4.4 devices
Date: Tue,  3 Nov 2026 16:09:08 +0200
Message-Id: <bf8effe9a06ba569b5e5a36cc1d1982b2e3fff53.1793712309.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1793712309.git.claudiu.manoil@nxp.com>
References: <cover.1793712309.git.claudiu.manoil@nxp.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v3:
 - Added sysclk_freq info for the v4.4 ENETC devices.

v2:
 - Described why there are two ENETC PF IDs in the commit message, as per
   review.

 drivers/net/ethernet/freescale/enetc/enetc.c  | 26 +++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  4 ++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c6571b5cc8425..b989823859ff2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3832,6 +3832,20 @@ static const struct enetc_drvdata enetc4_vf_data = {
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_s32n79_ppm_data = {
+	.sysclk_freq = ENETC_CLK_500M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc4_ppm_ethtool_ops,
+};
+
+static const struct enetc_drvdata enetc4_s32n79_vf_data = {
+	.sysclk_freq = ENETC_CLK_500M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc_vf_ethtool_ops,
+};
+
 static const struct enetc_platform_info enetc_info[] = {
 	{ .revision = ENETC_REV_1_0,
 	  .dev_id = ENETC_DEV_ID_PF,
@@ -3862,6 +3876,18 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_VF_DEV_ID,
 	  .data = &enetc4_vf_data,
 	},
+	{ .revision = ENETC_REV_4_4,
+	  .dev_id = NXP_ENETC_PPM_DEV_ID,
+	  .data = &enetc4_s32n79_ppm_data,
+	},
+	{ .revision = ENETC_REV_4_4,
+	  .dev_id = NXP_ENETC_PF_DEV_ID,
+	  .data = &enetc4_s32n79_ppm_data,
+	},
+	{ .revision = ENETC_REV_4_4,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_s32n79_vf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 2c9d9042eb0bb..8e6a9d366d404 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -414,6 +414,7 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_REV_1_0		0x0100
 #define ENETC_REV_4_1		0X0401
 #define ENETC_REV_4_3		0x0403
+#define ENETC_REV_4_4		0x0404
 
 #define ENETC_G_EIPBRR1		0x0bfc
 #define ENETC_G_EPFBLPR(n)	(0xd00 + 4 * (n))
@@ -1048,8 +1049,9 @@ struct enetc_cbd {
 	u8 status_flags;
 };
 
-#define ENETC_CLK_400M		400000000ULL
 #define ENETC_CLK_333M		333000000ULL
+#define ENETC_CLK_400M		400000000ULL
+#define ENETC_CLK_500M		500000000ULL
 
 static inline u32 enetc_cycles_to_usecs(u32 cycles, u64 clk_freq)
 {
-- 
2.34.1

