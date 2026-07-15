Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36130674C;
	Wed, 15 Jul 2026 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092832; cv=none; b=rUN/FUxxoZzsbfHbQhd7IjTiim8g8/kTMhLkAfLipQVjFiroBf63+AdY7YEoyjUueIGCcBhLP8QlN5v4OMAugzUT1x5PLC9hVzPQdpl3qJCBg4O8brX/D4ciPdvH/jgwn2tKSzpslW6Z7IECIW+XfIzgKZiJ3sZnS01LmmHpt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092832; c=relaxed/simple;
	bh=74hbp5RIsZZ1HGju9OLQxht1hMNz77VQTQMSe0fDZS8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h252Iz2BbLfdqNDM/TZzXTDiRzH5xrQSJs9e7eAiFymQu0Lf0+no+qIh+2gYowq6rMIXgJriuZNngxJYM08242lWVA+iVKc4w0lOrVFceq5J/gZbGKhZY219X+Pg3HDArK4Kki5NYmstqDOU/kDax/mN6RJAfVKs3bkAshOcn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TWjhYcGO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TWjhYcGO"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lP6m1893117;
	Tue, 14 Jul 2026 22:20:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=SEC91u/GllDbmAgCSxPxauZ
	wi1lzs12NXORWD7bWBPo=; b=TWjhYcGOYcvce2kHSL7oW+dnBI9IuUQXFwNfVkz
	/BEq9DJAsBI5VJnRBeu1WTFp4JxN8o05NC6/ieDBrrx47KBleO3pgNpLNHVfU5rS
	tkygdTaqKi34XQVGda9pKDpUdDrrNwjPGfWj0L3pWvK4MDdXqVDIS6X5zz8smb05
	duEbS4i+MGHKHtDI/fdcm2cbzk4CF9N2eEcJohd0boA7JP09amMhS46h6Mr3qP1j
	rIOrXNI1uVy3jFCknmcBt91xVzMb91SJc9B34DanYwu7Ptq9Qhh3e4RhFWnJmsXO
	Ca72G905DiyqBYh13Zvpk4TvKHcTFUcPDxb7jhTGx9W8pvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fdkdc3agy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 22:20:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 14 Jul 2026 22:20:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 14 Jul 2026 22:20:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 7C9F4626761;
	Tue, 14 Jul 2026 22:20:18 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sbhatta@marvell.com>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Suman Ghosh <sumang@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-vf: set TC flower flag on MCAM entry allocation
Date: Wed, 15 Jul 2026 10:50:07 +0530
Message-ID: <20260715052007.2099851-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA0NyBTYWx0ZWRfXwS+JBPnZlyDl
 2zjPCFw2upTn09JuP+63t/6C8pJTq08q6nrlWDMF+J2CXACaR6bZG7e1PQisl5T+nHJmaddV/m/
 RQ5cIXvBms543QduljsYCoAkNMviU1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA0NyBTYWx0ZWRfX6RCp3q7tKfcd
 OBuBZDKyUkiyyCKTJoNZA+Z8+1bvzknjhgPI5tslQfN/K5g6/NxUY7WM9ZUkiT32QmGDTuqdhqM
 Vdq0sx1kDtLrwrBZMRfpgE1J28kgFZoeX3qjAqhOnXZG08WgJyKmomwHJ0d7hh0VVnFq7v/LutB
 n4/T5lvINWg6UxbNicV69opSCPE8Qo8vkbvXOSkG+fTfFYJaS2kpepnwzFQL7Y1dMaCE8ho67i1
 bhTWBeRCuGTXT5ZBHBaWg7EUpWhSoDl1ixr2YFnMrkBxEYZZQa8qH3aHEettvfivIbowV0ExpJi
 iW3Ez+p326h3/SJ2rxT/aYJNS3Vzr7hSM31lzQ3NckrX4QFxkgruEqulG6Ns1oQFUBMVOrvqu4m
 yhTOiAbx10SEUAizHjxl/hibUQurYObxhi7tn3ecaw2vdS31pWRnN31St7kls0AgqiGP+peE7Dz
 12zN9FXPRCgVhZbtXpg==
X-Proofpoint-GUID: SBI03zPrdNvgDm7WU3SxHiDsAuUJyptA
X-Authority-Analysis: v=2.4 cv=WsYb99fv c=1 sm=1 tr=0 ts=6a571896 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=-f_R5ig3iYYmKcMtsT0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SBI03zPrdNvgDm7WU3SxHiDsAuUJyptA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

When MCAM entries are allocated for a VF netdev via the devlink
mcam_count parameter, only OTX2_FLAG_NTUPLE_SUPPORT was set. That
enabled ethtool ntuple filters but not tc flower offload. Also set
OTX2_FLAG_TC_FLOWER_SUPPORT when entries are successfully allocated.

Fixes: 2da489432747 ("octeontx2-pf: devlink params support to set mcam entry count")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 5dd0591fed99..99d78fc5a2c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -272,6 +272,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	if (allocated) {
 		pfvf->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
 		pfvf->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
+		pfvf->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
 	}
 
 	if (allocated != count)
-- 
2.43.0

