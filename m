Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4B5326A8;
	Tue, 22 Sep 2026 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072541; cv=none; b=tWckDjKrWCpUqmXLhynxsmKp1BkOhmRLIDbl8aItzYh9rbw3IFJsO0HO3rxlMLKXYqQTFbi9LAV0aMqR5iZdW+FYfeaIASjzm8C8+pMSVRGJMxvOCfV6YQiKXuKSI2n4TiE/isc0L+3+FfWmYJoE7pwVqRD76uznx+DgGdjvMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072541; c=relaxed/simple;
	bh=1Fs63LCLNT0J5zDsPlhicYrIWg6A4pf2Fa7RctWoS6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB/nY3B8mJpb2z25aPpU72Sem/axNRA0IIsmQLZK6QfDhnBbMlzKxSlHoCF+4PY4pEdiH9aKr19MAxtT4aicqXcspjXPjNOYbd/XmgDfyqFu00Y+m+zcQUGtdY6tH6b2Uzxyicq9IeGAAun1GPaeSySevMtLNVuQXlEhcQPJMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bJv7VdKZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bJv7VdKZ"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MACmtx062882;
	Tue, 22 Sep 2026 03:22:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	RE77QKuhLPRPhmNLsSGVJqB+zlyIeS/RNUsyKT9E3A=; b=bJv7VdKZSXodWmU7L
	f1Du82LRSzutdfQKtmR57au+XrH4aPcDbEmKtLlq3Dww+3AFCAbd7NldmbCxsEPA
	Othfi+ow4mBgbvsrD8aQLd/32/SoJAYfHio80kN+B2tyYQaztMCgqcAqEgB9rc9D
	mQfSwBmkfFF4Bmsj4O9KPFozuS58QdzguZ1x71VIGewvyzApawXI5PO0BSPpgzHw
	glpuaWR/oPh+j14IYyuFkBWYFaX1gWEX7xTgqDAoIMcF1cnaGbEBxU8FaMsxDwta
	npkxBRQ5KTAdIRDsHue7AEnlu/SdfsZhFD0diRJ0/LIuz4L7n67ES2cY1t1B0FnB
	hB5PA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4guabub4n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 03:22:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 03:22:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 03:22:01 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 868123F70C1;
	Tue, 22 Sep 2026 03:21:58 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v7 2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Tue, 22 Sep 2026 15:51:49 +0530
Message-ID: <20260922102149.2078168-3-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922102149.2078168-1-subratp@marvell.com>
References: <20260922102149.2078168-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -ayEVCHiXLOqbIq09qvXeIMOikAhe93P
X-Proofpoint-GUID: -ayEVCHiXLOqbIq09qvXeIMOikAhe93P
X-Authority-Analysis: v=2.4 cv=PMOaavqC c=1 sm=1 tr=0 ts=6ab256cb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=9qxNCY_qAAAA:8
 a=XdUeuafyeVSBVPQTZIoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE0OCBTYWx0ZWRfXwQTzoP4W+9YO
 y+mrr/0Jtz+WU3xhwn0fkTGW8FcPcwZYKlULtedXyCyvoCgWUzgVMd9PZHWVNQ1zHQKRGGXYDOU
 ax18vQm97ZwONUadTGLT1bPlsd3KuSHc4XBr3W9Y/ulIAvROTC/qVTAtDjHqjZIjljV8bB0D/Qv
 q2s7PXiPkXRabPnfk0qXPfRZIppSefzMH3/zAYyM4JGbW/lHxAAkCcTM+jD0DvdjBrkEvOLS0FL
 pB8svkl0Y5qe34GEF3kVXB72ZO8bPJYC3aGivO4qBW4JA2MqC8DWJ0DkmhT5zGpWyH3ovBMVYmV
 1pry+8LNH1XdGPavnwHR7kA254HCqBeGvrCFJohzhEgsdFSilOgvQLGweJQ48DrEDhfbjDR5/hs
 6422wUA7rWKccatI4OMpJjUq8lVR42tP0RItiMiX2yp6W0AhhjGfh45NSVjJX+bAFFLTqUkAxIs
 iGL8XAEZKS3G1I9SLzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE0OCBTYWx0ZWRfX+WpRi4orVrk7
 WFp4u/Gowrx0uUKfFNboFUWSH8DaiVWwaKqxB11kkX36cOYi9uoXnxX39MkCv7qePf5jfbWscz1
 svsRVrOEiM9BYmn2Q/WW/fjTf+LcQvc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01

From: Baha Mesleh <baha.mesleh@nokia.com>

The SC resource cleanup and statistics loops were incorrectly
iterating over secy.max instead of sc.max, so the highest SC id
could be left allocated across teardown or FLR. Use sc.max as
the loop bound.

Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage the MCS block hardware resources")
Signed-off-by: Baha Mesleh <baha.mesleh@nokia.com>
Signed-off-by: Subrat Pandey <subratp@marvell.com>
---
v7:
 - v6: https://lore.kernel.org/all/20260910062657.3712256-3-subratp@marvell.com/
 - Reword commit message.
v4:
 - Correct the Fixes: tag commit subject to match the actual upstream
   commit title.
v3:
 - Extend the sc.max fix to the SC stats loop in mcs_clear_all_stats()
   (v2 fixed only mcs_free_all_rsrc()).
 - Add Fixes: tag and reword commit message.

 drivers/net/ethernet/marvell/octeontx2/af/mcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index 211c10aa5880..30c672d526a0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -314,7 +314,7 @@ int mcs_clear_all_stats(struct mcs *mcs, u16 pcifunc, int dir)
 	}
 
 	/* Clear SC stats */
-	for (id = 0; id < map->secy.max; id++) {
+	for (id = 0; id < map->sc.max; id++) {
 		if (map->sc2pf_map[id] != pcifunc)
 			continue;
 		mcs_clear_stats(mcs, MCS_SC_STATS, id, dir);
@@ -738,7 +738,7 @@ int mcs_free_all_rsrc(struct mcs *mcs, int dir, u16 pcifunc)
 	}
 
 	/* free sc entries */
-	for (id = 0; id < map->secy.max; id++) {
+	for (id = 0; id < map->sc.max; id++) {
 		if (map->sc2pf_map[id] != pcifunc)
 			continue;
 		mcs_free_rsrc(&map->sc, map->sc2pf_map, id, pcifunc);
-- 
2.43.0

