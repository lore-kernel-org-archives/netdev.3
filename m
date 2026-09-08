Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1335C1B1;
	Tue,  8 Sep 2026 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788847912; cv=none; b=kdSnbhRsBBLGnKzyloUGH8jck7AOQzdRFKBMDy5kjQHBsyad4FTdlqRBFueHThfDr6K6LGlYXpKkR0SrxaVpjPsZmQPwnIrRRvRNkUgCGynw0f5VxtRNvO0t2kJ03NiNRDdoJX5mdois375076ttiFGcLbRNmGTItuBjNjiOQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788847912; c=relaxed/simple;
	bh=36V7lOv5QZtTZ1R0ymeUOfInUP/3oP0JCDsHGYMyqG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E8nejQVJ6/GyCojjobjcHud99fBQItZ2u6Qwx1TGMk8x4xtXZoIbV0xKkjPExzz8SCvvcRT4ozMSyBJ8sNQ0jcwwIb3I+yAnirD5KsFvIUmZ2ktViNcM4fNw5HJExR8TSp7J1/tK8w1oB5BRnJAMObggzNrKjfH1G7m+sJlBgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MGaJwntx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MGaJwntx"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Np2pJ3008857;
	Mon, 7 Sep 2026 23:11:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=gqrsgzyvWvkaIbFDytwXhf0
	UfL2PpmIHIs1RiHOadBw=; b=MGaJwntx6K3RwucZgcUz3j/5ssv3a535d3WztSm
	7z183TpofB+Z3lWhq9a0N8/9oXWtgenewvmoeSLi+Q92R8ZPQgE5gjb/dxgEPKTX
	kvCZv6sqQ5QhuT4ZB6NtwG0GipMeEXfSlKAAcmz03hkLa9PUfwNNX4j1VnWhHeKL
	snEX1SwmPmzu5Ju4mIa3JJKk51Rty61QLtyLE3U/5HoGX21Iop+8/WG3k6d4/gGA
	O3l4+YPPstl1p8Bdp5uk6h9sRA41FV7G1lL3eYm12MG7D7AXUdadomQmjK6HmL6h
	jCKh8bZzWp7g+kYiRwmD6RgU2dqHrEdRz6vx8OPvb9k4aOg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gh3u8vuhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 23:11:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Sep 2026 23:11:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 7 Sep 2026 23:11:42 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 312793F7077;
	Mon,  7 Sep 2026 23:11:38 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2: collapse consecutive blank lines in source files
Date: Tue, 8 Sep 2026 11:41:13 +0530
Message-ID: <20260908061113.246837-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AQ5-abD6mcEoyEEtNLLJRHjcQ6oa_xLc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2NSBTYWx0ZWRfX3St+kdf1Xcrj
 RAfvT3JBsWkByiqZ9gHTJItTx+tfHhdcz4nK0E0lnBe7zWyg4opsQFw2+yYKhLHHwlZgCBtnjgT
 F1Zo2xgCVef8vTHm6SqNuw1dbu1DoDI=
X-Authority-Analysis: v=2.4 cv=b7+CJNGx c=1 sm=1 tr=0 ts=6a9fa71e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=f-IhN4xM_Ets_Pua6zgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2NSBTYWx0ZWRfX9zxxKNis2GHW
 Kz/wD1rLbLG34DqSaoRbSUpx2N45qXdYS8jhqnLnwoaC4OiM5GrsRfEeIg5H4bgDPdHqrYfSXOB
 0Dn8tSD83+JZDBcUJ8E/pwEWOlyCaU593pgIEoL7tvx3m9k1cduMbaF8W+6ViSJ4z0e5rjjfDgR
 ESwI0Uw1ERRuwAa33zW8W1uO5SPp+HhHgt0GlkK6edi+PSghEA5q2pr+p8mnuYodCdQnZE4to4O
 GH6Vf9C/1rE72Avl7c6HupUDsUi/iKYDqC4YB8ZaZuaK76/CJGzhZeWuShkABNXkaLfedo2qIe0
 NxHbUVPVv8G5cmsRJI9p+xZo61QFDOC3Yt9u/AYP2da6v/eiDJZt7HrynTGRoFCteU+lWIuc3em
 3kOW/iu8VhBJ4sPWTgJb8rshABbWZwUlYzkCYG4t1L2HuR1GCKjhNc+EPSteiWkaZc0/2AmBqHe
 zLuP1FrQP67M8d2Ru1w==
X-Proofpoint-ORIG-GUID: AQ5-abD6mcEoyEEtNLLJRHjcQ6oa_xLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01

Remove extra blank lines across the octeontx2 driver source.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c     | 2 --
 drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h | 2 --
 drivers/net/ethernet/marvell/octeontx2/nic/qos.h    | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 3696bec7a8fc..8ced44a4495e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -2043,8 +2043,6 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	list_add(&cgx->cgx_list, &cgx_list);
-
-
 	cgx_populate_features(cgx);
 
 	mutex_init(&cgx->lock);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
index f4c6de89002c..ec932a592707 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
@@ -19,8 +19,6 @@
 		offset = 0xa28ull;			\
 	offset += (a) * 0x8ull;				\
 	offset; })
-
-
 #define MCSX_MCS_TOP_SLAVE_CHANNEL_CFG(a) ({		\
 	u64 offset;					\
 							\
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
index 221bd0438f60..bd12174bf94e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
@@ -73,6 +73,4 @@ struct otx2_qos_node {
 	u8 level;
 	bool is_static;
 };
-
-
 #endif
-- 
2.43.0

