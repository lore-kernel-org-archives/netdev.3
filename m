Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240821CFE0;
	Wed,  9 Sep 2026 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926812; cv=none; b=dhxQU6IQb8abWmdC99bInBOlCSNiDuwdLzSBoX6CRPzcYAN3eeGHUDRw1afq+uH+YyXVLvQ72NC9hjt5jr1pX1mUS8jxXd+itBY0rtJWUimcpDdLNmMSDTxEvIQmK2sSst708iMC9bnpn/r9dK2Gm2YOGFLxUvMCgc/UdEEn3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926812; c=relaxed/simple;
	bh=3PgQLRSjU9bmk0YVmDNd7cf6rP2a1MX+VoQ+Zs+3iKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kp/tMHgMUqsYF40aMbcC4mSJDuDPGooz0hUVsrLsLQBPU9jnBm0zBJeYMmnVIs6IhX4zyo11d4ZsokpaxUKl/hWH9/zbLz1LOoMr/eKyX+kEvVmYEF3q9zC2qogcaYp5z0IcD9VrnO+8j02HSikhJ2aWsn1kAhWwt3L1k4/qKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CnL/gic9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CnL/gic9"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6891M4GX2901567;
	Tue, 8 Sep 2026 21:06:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=DC3e4qC8uDH9YJcrIt5EREE
	XtG2Ftvl6LxD0R8d6tL8=; b=CnL/gic9+/VxeNH0TLcx3KiMnccR62kJsOUD//3
	KRkHevxH9OMQlPzsjjNPc/s8SjWtARtFHTX+L4MWn3O9kC6LaFzlty514BdRU2w5
	+gpvqLBbymMVKRzzhu5vM2nlTxSFAgvBT5H652xxvfm34TrodzT0NeE6ch+OVbS7
	TuaIDxULILc9LT3S05QilbkDgLLmSvJD5FV2+d4zaURHSniUxQ1dOXgL1OVvfOux
	zDeXXOzMukeTo8YStS3jhwdQnDrz4g01je4hkacaIpFoGHVXCgxoRO//GzrW++Ac
	wujRR0p1CNbJi0HQQkx3wln5pJzfywqR1w58aMe85XuUWLw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gjwqwgbqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 21:06:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Sep 2026 21:06:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 8 Sep 2026 21:06:40 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CF2E73F7078;
	Tue,  8 Sep 2026 21:06:36 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Hariprasad
 Kelam" <hkelam@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v3 net-next] octeontx2-pf: report port connector type in ethtool link ksettings
Date: Wed, 9 Sep 2026 09:36:20 +0530
Message-ID: <20260909040621.397255-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MiBTYWx0ZWRfX20NpKd9zD1SY
 ZOrGWwQtcA7ijvV9ZGQxqdF0XO7ku7YiJ22R75//d02MwmNCL391DFSq3Qql980/O4tmMOLIHIH
 fLFaS1bTb4E7nbzjVJELhwF5ZjjcuhyVdngM+7Mi3ihuMb9+m5xPOxoeGsZx/4l+ZY3EvwZgAlZ
 84hzaHBCiF4zf9VwjR1KZUzTr6nLz0+9HEAhw3MHfTqNyft4nBIXEkKJfan993or7qN7AwdqH1C
 pXBM3c4DpV3QXwBERqHdAbspUhDXhzNwD/6UlSWFCnAwx1L+cnHVt7/q1GdDaZ/65mfqDZ8igTE
 iH2qv7phoIDAjVJZ5iwV6PEUHgwIpSJ/8/3SUJHQhuHApF+AV7aRD8Jt93WlZxda77x3+7ScihH
 BKjflbrleTjnpc9p2PgIA8daEtpuSL6VHYh3h4X/xxTEQAPDgzji70q5ullwD3+ww1iCIwBAoJJ
 Qola7/w3J7jvo2aDQnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MiBTYWx0ZWRfXwjrtK+UD0+Yj
 ojo3xJabMIRwKJCt33d4A21W6boiATYQeiIneBvyinAg3idZ7AXeP8GgKgKbfi96+Vgw9eupSO3
 qT2XdVE1jQDni+mpvHru3Y7G4Q9qCvI=
X-Authority-Analysis: v=2.4 cv=XKEAjwhE c=1 sm=1 tr=0 ts=6aa0db51 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=GJ08_EToFyOulzXwadsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: iMDsnY1HbCq_Wty0J7Xe1qdmJWGWhTUd
X-Proofpoint-GUID: iMDsnY1HbCq_Wty0J7Xe1qdmJWGWhTUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

otx2_get_link_ksettings() already reports speed, duplex, autoneg, link
modes and FEC from CGX firmware shared data, but never fills
cmd->base.port.  As a result, ethtool does not show the physical
connector type even though firmware provides it in fwdata.port.

Read the connector type from shared firmware data and expose it via
ethtool.  Extract only the low 8 bits of the firmware field and
validate the value against the standard ethtool PORT_* definitions
before publishing it to userspace.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

v2 -> v3:
- Extract only the connector type bits with FIELD_GET(GENMASK(7, 0), ...)
  instead of casting the full 64-bit firmware field to u8.
- Validate firmware values against the ethtool PORT_* whitelist before
  exposing them to userspace, per Jakub's review.
- Map unrecognized firmware values to PORT_OTHER instead of passing
  them through blindly.

v1 -> v2:
- Addressed Sashiko review comments.
  https://lore.kernel.org/netdev/20260904154833.3b32ea6a@kernel.org/
---
 .../marvell/octeontx2/nic/otx2_ethtool.c       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 9bee1b91eeaa..a05dee0085a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1209,6 +1209,7 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 	struct cgx_fw_data *rsp = NULL;
+	u8 port;
 
 	cmd->base.duplex  = pfvf->linfo.full_duplex;
 	cmd->base.speed   = pfvf->linfo.speed;
@@ -1231,6 +1232,23 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 				OTX2_MODE_SUPPORTED, cmd);
 	otx2_get_fec_info(rsp->fwdata.supported_fec,
 			  OTX2_MODE_SUPPORTED, cmd);
+
+	port = FIELD_GET(GENMASK(7, 0), rsp->fwdata.port);
+	switch (port) {
+	case PORT_TP:
+	case PORT_AUI:
+	case PORT_MII:
+	case PORT_FIBRE:
+	case PORT_BNC:
+	case PORT_DA:
+	case PORT_NONE:
+		cmd->base.port = port;
+		break;
+	default:
+		cmd->base.port = PORT_OTHER;
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

