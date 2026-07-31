Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375635DA6D;
	Fri, 31 Jul 2026 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477215; cv=none; b=qjGi4Iu+gFkPrxkm68+ZtYSxugor76SCSE1IhbetQBmPyrdCz2PbZHkhKWwC3Jv8kANMiZpqtXpGZvn1Ez7SvalK3z/lE7Z9lGjlpxesAWzf/r9SkExqxeZJVL6Ik/Po7DvMDAuTVc7msC+lot/zCYcnTXTl/hpOYWz1k/QrbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477215; c=relaxed/simple;
	bh=GrLpewsVD0ngU0v61GtlQ5aXw0Zfb/+Rg18exnX0PPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3TQm/jjELuFEX4iF1oSOaJO3nHqUL60f+wmuBgQ4GborVOTEiiSwx3pzavCrQm8elJxbm1JwgNkE7KAp6MAx7qHQNqKLpB3riGbOjk6YPZSKtG+vi/kl71VplQDjxMUXInjkMp18w0YF2gcaWqIOOJCTCRgjin9y12yRmhWUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hLDOsla0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hLDOsla0"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V4xobT398454;
	Thu, 30 Jul 2026 22:53:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
	dn7mEm1Bg0Q2BJpeM1VoLMJPeg5M8TBw3uZ2ZQaWUo=; b=hLDOsla0A6oZsNoqY
	wGAU8KFGlZMWNCrQYfVNbGemjDriORG/6nps+ws6aOHcvIvVn5f1paiRPR+ZBRV8
	SO0xFqXxfcrh8rnU3dME1t7JsR127j9GMo3BlS7nlM+wKR8rO4Alv4UW2AoV0VvO
	s0GYay9gHqNhu55Qg6xzrNl04D5g/rHn+naWI1lRVGLos/LG6OCfIkOsBqXJlxHD
	L+C20sMc0U8xQpVEDGkHMFxApN2Yz+aBep86/Y2B0chshGp3U/LEugpKnw9cUqzS
	yii7/OA2HR5H1Od0xfUnzdcTGB+RXxtMhaqozeQAHQSHyDu08jrjEMfTGQTGIz4j
	LzXXQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fqu7c5drq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 22:53:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 30 Jul 2026 22:53:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 30 Jul 2026 22:53:24 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id CB11B3F7072;
	Thu, 30 Jul 2026 22:53:20 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v2 2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Fri, 31 Jul 2026 11:23:10 +0530
Message-ID: <20260731055310.1229213-3-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731055310.1229213-1-subratp@marvell.com>
References: <20260731055310.1229213-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX6N1k9LhXLECp
 hIIVCpw5WVcrE3M6xHFb50Cz341RqsjB8VVDoOPt+0fKjNDU79SABoPLzxCPsk6KYXyaoCSiE/P
 jgwquF8BQGutaBsh6XBRxcBtRKSZOXo=
X-Proofpoint-GUID: KVyXunXV0q-PUt7r-b2XGyLLksla1VYp
X-Proofpoint-ORIG-GUID: KVyXunXV0q-PUt7r-b2XGyLLksla1VYp
X-Authority-Analysis: v=2.4 cv=HtRG3UTS c=1 sm=1 tr=0 ts=6a6c3855 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=9qxNCY_qAAAA:8 a=M5GUcnROAAAA:8
 a=XZlTPdtiicSm3vu_L_sA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfXx38pItrJfEVg
 +xbS4rOlkzMFYImY/BZ+U87Vdzv420SHgJ0+8T71y+xmFNBJQSnSLycHkFGyg5r7UPZhoL8WHWC
 /VyHSRDekhfDYgCIRmUZ5pSxshIBZqZoXXnH0raI5GKONCiBZsiPdo3Ro9XvPSfGT0oeO1mZB/y
 f18f20ZMI+K6LzBvUJoR6ojywRMfOTZD4Meo4E70WvCHZMYoLatiUE9+3g4CHXVXADtl4tK2nLn
 ARvdjnoPbCgsLczmb2KTILhT845Zc5AsoA07DerUu2nR7ae9mZsXut50NY8TSdNtHttiaf3LDHz
 c1iSQIIpfgJg/smgn/5V7mNhvkiKwD4pxZljBZYGCY8wC9tWMukQlO2/UGHYgmO+crIuhKrMxGe
 So2ONHhEZuTC0gDZcCPYD5Yw201b0k5zorOSN5ytgQIXgR1ry1p/BHJbjRPaYiqgVrgwJNtZkWx
 QqbXhBSWNSjkVfip3cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01

From: Baha Mesleh <baha.mesleh@nokia.com>

The SC resource cleanup loop was incorrectly iterating over secy.max
instead of sc.max. This patch fixes to use correct value.

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

