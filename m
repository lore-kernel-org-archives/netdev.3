Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5413019DC;
	Fri, 24 Jul 2026 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878140; cv=none; b=CfTwqtXOokac8m170agudLYVCzzPGdFZE5dIjB05K7LIcjkX4WqDImB+3v8/kJgKmzUeNkzevPDhr1mL7+nAEfIv11Eb9VB3eLwDrolNOFbNJZ+g1JCHplxlTIPPymuJdGJ/dZRH50m8HHjwImf2Nl2b1DV7rDC+KBJXDToV7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878140; c=relaxed/simple;
	bh=02sXgYXmpnhBT7Uwii62dJlpg40mMMRXPOSCNXRuvB8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hourwA7OWHdbucZI4KfF++g8m87GeL7oUqxdelDmubmA8ivdO3VrsoAuFhwMrcEATOYYEjkGmdnjyT1sTrlRSdMZXGrgvsRDJ8JooqNx7YZ33kNSnEiRcneAlPEft8xao2M5v/iMyI+IYnvIZPGv7I48uljs2CF6Npfj0zuA7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SGNTtGIh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SGNTtGIh"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lSlb3162828;
	Fri, 24 Jul 2026 00:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=zu9M/0L0f8ieNMC739C/zjJ
	giOEDhw/24KAl/qCK+ds=; b=SGNTtGIhDESiD1nClgSrKPnuGkZk3w8/j8nmlI5
	tr6af4UFcZa6z9lBGiS23BMohyYdjVTbGJ6XJ8axerQacw9bwxGGoyOiMfO9dT00
	nv+4arkOzDTB1dYU4SlDDUKK20ebX5FFJFlhn3n2k3UZsXhsULhCoA107AXkLS2R
	GBWtpVzUus4ZBaldVvmrrFQUaGGYHVmMlWCPfPkpbT++z4CXj+xVGsaufUgi85mV
	/+kOgAHh6PX2PEtCL4NDFBwhRI7Igk7hHpX6meDkXbN16sdHi8geRRxEv9xvnOBR
	mHYnKMYezn2vw29Ss4owYs+cyxGHRUmQJDVFpuFmTrt2Ndg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fkvmu0wgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 00:28:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Jul 2026 00:28:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Jul 2026 00:28:37 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 419123F7077;
	Fri, 24 Jul 2026 00:28:34 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <lcherian@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <tduszynski@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Suman Ghosh <sumang@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-pf: Set correct sequence for carrier off and tx queue stop
Date: Fri, 24 Jul 2026 12:58:31 +0530
Message-ID: <20260724072831.2415281-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QfQ9NMkOpLFu9B5Z054k9bXFj65b3OUm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NiBTYWx0ZWRfXysgG4EUJJAMu
 tSfq2MX/zb8Rci5mBG3l8Xd9QdwxVboWIdA0v7mbSFqvDnM/N79BiARvWfFXybtOkLnS1rr3x9y
 EeJEu0cTKa0MDY42STIVdMnhQvN4BKs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NiBTYWx0ZWRfX8pheCG1Oufci
 BMmrklvGCzNRflAMgYjjseYQfF2vywXNXJygq6rP2zWB2rWI0BO7kV7deyYq5wxvNlaIq4gVhI2
 6PZciMwJsefPr3qs3l0JxTMiytEodvRRtNdAM2XsZWUKBDGvlVTai0/2gQecUUqYqxq6PegeVsT
 hGWFq4ZnFiImTBUlk7XKLTuKHyj7/Tlw5w7GdSKZvw7vJNOBLUszvZyBjzkRwEg2YpfXZpQ+beL
 LLO7QkJKjtPJII4JhQuhfoXEXFFQOpHCeitCSZGzncODp4TY4CdFcnDwLJRB6ZKifj5gqjWDv6l
 otr5YbOrPFHGwiUf0xyhC4wn4ZadoUj6REHI9hQrAccLK+Zn+wS2eOAzH6s1qaRhWFz8vvlFmrS
 iOQLRW872db7uM/nc5R0EElz8rjltR7GdMTM+2+g6wymbTYtq4g9FX+SBOUFjKMKLQM7+Eh/AxX
 v+CqItAuMcsuZOkfhfQ==
X-Proofpoint-ORIG-GUID: QfQ9NMkOpLFu9B5Z054k9bXFj65b3OUm
X-Authority-Analysis: v=2.4 cv=GLg41ONK c=1 sm=1 tr=0 ts=6a631426 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=_n3OG_2dr_0ZU0fReHMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

During link down event, we were doing netif_tx_stop_all_queues() first
and then netif_carrier_off(). This can cause a potential race since
carrier is still on during down event. This patch reverse the calling
order to fix the issue.

Fixes: 50fe6c02e5ad ("octeontx2-pf: Register and handle link notifications")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 2e33b33ec993..c995f2900859 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -889,8 +889,8 @@ static void otx2_handle_link_event(struct otx2_nic *pf)
 		netif_carrier_on(netdev);
 		netif_tx_start_all_queues(netdev);
 	} else {
-		netif_tx_stop_all_queues(netdev);
 		netif_carrier_off(netdev);
+		netif_tx_stop_all_queues(netdev);
 	}
 }
 
-- 
2.43.0

