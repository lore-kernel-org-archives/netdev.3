Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4F3CF68E;
	Wed, 29 Jul 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309859; cv=none; b=Db2CyEoZtoF06tu76GHGfBVnLreiD3i/MZbMzlkyXgGX3fH6f68NWbCLyDRydYPAtxioW5TtNwkX8y/Icl52GbBiZKNyCsJ5lonIK7os6nkeAZGaByUihvkYOYfsqoIS7h6kgJ7N83cSPDQQgwWR28DZhnvG6EgCO6Sxz9x5Wjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309859; c=relaxed/simple;
	bh=q7J6MA4VLuyW1WCzzwCL8p2/jItxBstH/fxHmk3f6qE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bn28//syoo85TSsJhXjdeio03P1HMgleuGM+FujXa8F0i5ClkbVbUbAgrpllbklIHNON8+5jbtWfRgnqcz6pZCv0FfG9pUw0w9L6uO02SeXXUPeD+NAFZodekau6BMKx5+pGjoZHeU6GFFxSnsUTUhN4LXt742dZtTKHebbwfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ERPu1GLC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ERPu1GLC"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4dtra3416436;
	Wed, 29 Jul 2026 00:23:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
	TUPwXCwxHrkQPpXWWq6DLkXxyL8Pq3mXKNHhUc8GRY=; b=ERPu1GLCNnVKVFYls
	mwtTQZPJPY+WDBTJh0l3Jp2AGA4JrCheGjNDzRaBMH/MZqre8JalWkTuZNjPgGdw
	a8BOPwfufKbMBk8VpgSYWVvJNmI5jzuKn0gJRS6EQcmaFtGsa4TlsiSHl4I1O532
	JCFC+pV19dMdzasS3jBV3MqSW9CcYq0oDdh3so/aliTHg1MkKxrWHO66C3I95n2L
	GUxN8zcigsjmdBRqsBiPoAMjScG+dMMs0HzqsCXlngdjRVfKq3nfzLXg57jaGIrR
	V1MU3fxNmXv2lsKX693Mitz1FIL2wsnBoaGESeM3Z6buA5FOyR5is4ZKTTqynZPw
	mBqXg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fq64gh43d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 00:23:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Jul 2026 00:23:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Jul 2026 00:23:55 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 7267C3F704A;
	Wed, 29 Jul 2026 00:23:51 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>
Subject: [PATCH net 3/3] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Wed, 29 Jul 2026 12:53:37 +0530
Message-ID: <20260729072337.664479-4-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729072337.664479-1-subratp@marvell.com>
References: <20260729072337.664479-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1OCBTYWx0ZWRfX8zvQA2UbS0oh
 io+anfzutcM7gPGEavp84UEWqkyBLZvxDWWBFyJPtHy00ivO1ImDC+F9edtueycvskcj6JwNeeq
 i6PBAcD+90tUrDRQo0OZqIj9OouNad+S6UsdnjCIrMdA89yhxRhXahXQ4QgH2LEXWsHX34dHEgh
 i/zA3fJV5aADXLXalctj5vRs8zn59V5eKyou8CBX8RN5tiayOReVPk/NAInTXP2MSyud7cwNOoc
 IKNZlz1cp0gYe5bS0MvxlVj5kgTfCgWBPNAxQTtdUr69YGUpnZ2tS9AOvX4IMOrsojy2pgXgrTg
 jsSazKmRCVFlUlQVLOiwDM8iXqvJxHJqztzzIZkDCfKE9D9DiNgQCptBQl66akNLTKKpM0+KIvg
 DJQ2mhT1TBFAMC0Fq0svtmqeqg1ZscDMUSewVqr/1oqo0TxNMvxB8rYUzTgQ0IQeYcYOmOL7jNI
 pLfnjHgi6nU14nxU95A==
X-Proofpoint-ORIG-GUID: scg6gkL2wTZ_OSzg_yhh4UMy9zStgF4a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1OCBTYWx0ZWRfX8SNYM4SyNxjT
 T5SXOJsN//u5Zo9E5xjP6Cizfor2bUzmNiSKMIVnymqTcsZ/Q2cWSn7p0qhdRoQDbD+qrXq+kup
 Yf285f+f+tFG602i8lYCmK728CV96b4=
X-Authority-Analysis: v=2.4 cv=GM841ONK c=1 sm=1 tr=0 ts=6a69aa8c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=9qxNCY_qAAAA:8 a=M5GUcnROAAAA:8
 a=zmQaR4rliT1_OLB3rVkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: scg6gkL2wTZ_OSzg_yhh4UMy9zStgF4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01

From: Baha Mesleh <baha.mesleh@nokia.com>

The SC resource cleanup loop was incorrectly iterating over secy.max
instead of sc.max. This patch fixes to use correct value.

Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage the MCS block hardware resources").
Signed-off-by: Baha Mesleh <baha.mesleh@nokia.com>
Signed-off-by: Subrat Pandey <subratp@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index a07e0b3d8d00..88658c07c391 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
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

