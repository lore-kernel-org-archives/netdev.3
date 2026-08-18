Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F603DB30B;
	Tue, 18 Aug 2026 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044321; cv=none; b=fhX2m21RtgO2+Ihb+4fT4n7n339c7SS2Tr/+FGlFtFBMV/CM2ZOI3x3l+rWD3gcMsH7ARU2a75qTSJiDjEUbW8BAlTBNrob76JjZ48KPxlLAJOGQNPWoE3yMVMC6lVvkvNOzDCzZdS4tCrjoHpALU6+EvqTTWBPrFz8JZL+uR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044321; c=relaxed/simple;
	bh=Qvg7bPgD3vrjS9i0U/zL03YKpk9GMf5F5fIrX1khiZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQrzgYCpHcFVX6jQRlLq6F1mSkF2c0awARuqRG8QBTNJgLWBbF2up6fg6Q4tzAjGJ/4pOQYB6IXbA1z4cja9MjhqKdZvvnB4hshPmEG3lyJzfEx21L5RNb1dZyGor2j3RahGqNdx/T4PeroP+MOnyK9rI/PFrAmYPeSUSL1wfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VwVL0mZS; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VwVL0mZS"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I85wBm561869;
	Tue, 18 Aug 2026 02:11:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	5ol7cohRvAeM9S0hczRVt1bvW7Ce0kfRf/WofVMvTk=; b=VwVL0mZSy4doXxJMj
	vNr/yUP+IOALFecSPNXkOQFp97PpakmUyGtpaOjdhj2RxGPfATRj56nD4RpG1qpg
	7HbNTuQxVPXV3/b892kVwSVt/qNCM9dqD/e3T/Ak4J//N7VAqXHy+tL2MHrlBY6X
	FqEoUe+WXf+AM7TTAfS6lAEmlr0N7CHO/Hpj0owxYnNka0/MlU9Xoi0wgeJUcE3k
	+hnU8nvA52afIcxnNq1aHWkNPIu2pFQSUYsgsFdkR/PtNDsNC1v6vchSLmyd9esO
	sdIN5QxSQy04qNHKhp6xANzESXIvQpvJ0MHLMqM7R2FDMXHnytPsQorqg5hr+/0N
	Mzvmw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g4kk0g3x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 02:11:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 18 Aug 2026 02:11:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 18 Aug 2026 02:11:36 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 5E3043F707F;
	Tue, 18 Aug 2026 02:11:33 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v4 2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Tue, 18 Aug 2026 14:41:23 +0530
Message-ID: <20260818091124.1832237-3-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818091124.1832237-1-subratp@marvell.com>
References: <20260818091124.1832237-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=T/G8ifKQ c=1 sm=1 tr=0 ts=6a8421c9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9qxNCY_qAAAA:8 a=M5GUcnROAAAA:8
 a=zu5CyLosWp3-ngOb9goA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: u74nVbD3QLsi02nQsIzWs81M_RjuJhGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2NyBTYWx0ZWRfX1T+xji4NDoaW
 NziDpMvbXZ2WrwRx/RaSMGm5hhBKa6j2Bjq/yGRQBq4GQ90XDrSGWG7XoqEdDXdhiWf2GHNaGN1
 twQpl/9OwwZmZUgEf6z4FYekRTwgwaFxPKRBl89xddrpT8ZGIVPUD910X2jyj5WDCJSPVCXTHSo
 SEQqIlWVlSpyWqGMxyX/ACfhgPnhM5e2DhE/5MlLrBq+aE4nRVdm60NcxF4RCXZiQ+QK02Na07y
 1KBBD7dLW5oEakhhTfUg0GigAcD97gDD6XOcktf65gO5YVcwqOwN01+XQMtxuEjhpRQsiq1uHnZ
 sSbqM3stgLCpKJA9K/BX7RYeXMTefkmHDuwa0hKtdRtPljHocdlBqAR1OTNadNNL72SO5Ui+feX
 4PdQu//GODKTD3V78VsHwxN+/+qhSDiXfFe1W72eOkdJNOQDieKuFSOEvC2pQwLBY3rqYfWls6t
 1PEZbpN7NKkQBRbvXSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2NyBTYWx0ZWRfX/cqIWdHJ8oor
 USdColzIsuLlKQnNzsGIz6+Hl4QdhMxLUviYsAc/ihEw5c1BENjmPhusBe29wi9/7kOKYTUeN9v
 6TVfDG/2zCncZSEmSyEbxfuz9usqeZY=
X-Proofpoint-GUID: u74nVbD3QLsi02nQsIzWs81M_RjuJhGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

From: Baha Mesleh <baha.mesleh@nokia.com>

The SC resource cleanup loop was incorrectly iterating over secy.max
instead of sc.max. Use sc.max as the loop bound.

Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage the MCS block hardware resources")
Signed-off-by: Baha Mesleh <baha.mesleh@nokia.com>
Signed-off-by: Subrat Pandey <subratp@marvell.com>
---
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
index a07e0b3d8d00..aa0ed24bb3de 100644
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

