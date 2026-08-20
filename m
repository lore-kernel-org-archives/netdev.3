Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816593DDDD1;
	Thu, 20 Aug 2026 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216043; cv=none; b=llyqYfO6hfGhyOpYSNSufvbaIoi1LLOzteQTZRzEN9B7bObVZYMG6/lNxVoMew/p8SzyaknPznBu9x43L/rbmL2C9GcUYM6zxAzsaGPMSclqKHtaX2JO9J1Glz/4fbebWQXypuVn+BdU0L2226myR99Vxmvufme/WEhsUSPQZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216043; c=relaxed/simple;
	bh=h3YoTFyXd+9hU1zflP5Ox9sTHrEwDinNQS137NLFMkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5dGqDRSWjvjh1Cv5Gm49AoXpO/CDqMBwC+JyTdH71QFU2ihNltnwA3uHlZPrvnahGZSouluu9CDB4vyQVJlIlF6YBWoy0X+LX9ieq0sz2tlWuMNeeXIKMOVO2CvyS3PMKluwMWOol4F6I7gDimspqQvYgRo4OgNgXw2dteL/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EC8akFow; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EC8akFow"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K7dncU241559;
	Thu, 20 Aug 2026 01:53:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=btklWzCya6+0/EdZsoIHGDu
	tr8YM0v29hyCHNsYW7/s=; b=EC8akFowXW3vuwGWT0kKNdx9weELkTHjNtZdLoX
	we9ENKZ1gP2T3ibIJ3tKyvxT2X0X+vL26E9OIqi7fUz0jv1adWxw4x7rLYem7eTu
	FO/x6jV9qBDBFsQI6MtX/yv+MDnqgpWFfbOmDIFwGHhCl7QhsdzsNnO64ylX7OSN
	YUSSZ7tWCZNEFs61rmDp1hcWsoLwwzqIV4okzaOZ9f8B0ok5bzzFJmJbQmq5UmeA
	ArPv+LFd/m9PbeXapQDAMTytVSJKVatjFhrYrjlkqYCvsrXU6s6W8fSb+bPY5UZT
	w+G6mUZyqPx2EUswXYQLU6AtXA/xTtVf9kL0NPIjeAaIxAA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yewf1pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 01:53:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Aug 2026 01:53:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Aug 2026 01:53:52 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 70DB63F703F;
	Thu, 20 Aug 2026 01:53:49 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2: use GFP_ATOMIC for QMEM dma_alloc_attrs
Date: Thu, 20 Aug 2026 14:23:47 +0530
Message-ID: <20260820085347.2672889-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wHDTHsQBmI9Arce0_9wlPfr3rCfFpITO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2MyBTYWx0ZWRfXxLCi95toEaYJ
 Djf1Kk2Kpg+KzeqxAk6KfvKjKDwHoE8SGwhJv7silx24FJumrORCOvBU0eQmwLND3M0RT5TrWYW
 AKMVUMB00f00oxMhnoC1hXta1Gn2P+c=
X-Authority-Analysis: v=2.4 cv=Je6Ma0KV c=1 sm=1 tr=0 ts=6a86c0a1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=WuudxapCgsahSltlGeoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2MyBTYWx0ZWRfXz1nu4VRJpKBz
 0kp87q/XxSwhkHlnnNm2SUeo6/Nz2t7HQ9m0vBqrKuiGQ3PyDp/dSE9G0XJSESFedjY63Xt9ipl
 E3WzrmPe5umdcC4AOyk0xCyNobky9ckkdW0tDKffjKYoWHh1VEsP5IHV632jAG0ZqhJk6vVUqCj
 MLg625qBrzHXB/m96G2tjzGQloYlbwiGzIA7BcZNen8xrHgflDnqcMHi9aXohvgK3LBlO8E6yH0
 TMY+5Njiuhb5HRNXkjM6rNXYzKi8uRBpQid59eV9SAwrUAW1oIj7zzgp37v/JNb57jYosd7pJLM
 5sLnx2N3/cMscyZOBuskUX64UaDbVwnftwX/LWxlRh0YkjTaXTPL88VdNy7sd7EJ8dS/j5O7qMR
 x782+QtsLnzjWISy/ZtukrfKg/WUA6h5WxZVqiN8NfqpZ8+80IJM1Y5Er4bAGW/tSvrteQ2Nbge
 dfEdKlhcGB1XjW3VOrA==
X-Proofpoint-GUID: wHDTHsQBmI9Arce0_9wlPfr3rCfFpITO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

From: Sunil Goutham <sgoutham@marvell.com>

Queue context memory for NIX/NPA and other qmem_alloc() users in the
AF and NIC drivers is allocated via dma_alloc_attrs() with
GFP_KERNEL. On platforms with CMA enabled, each attached interface can
consume a large contiguous allocation from the CMA pool, making CMA
sizing grow with the number of enabled interfaces.

Use GFP_ATOMIC for the DMA backing allocation in qmem_alloc() to reduce
pressure on the CMA pool when many interfaces are enabled.

Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 779413a383b7..ff5d66dd10f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -61,7 +61,7 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
 	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
-				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
+				     GFP_ATOMIC, DMA_ATTR_FORCE_CONTIGUOUS);
 	if (!qmem->base)
 		return -ENOMEM;
 
-- 
2.43.0

