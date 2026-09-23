Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FE2DB788;
	Wed, 23 Sep 2026 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134523; cv=none; b=glpWzQJqEZZp+oFx7XTyUbXo2kXHzS6A7N2ePQN6meUsR+MiFxu0AqYgzAgGBivm77IJcFz6yKdKrQ53zyNXgRr3dWFsbIwCfAIz0Bd3t8atZuOa0nDhOvgPduaiZYO8DU+yGtFRLO8vVK6nG1o4XBlC5OL7yTieI2tVWOD8cwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134523; c=relaxed/simple;
	bh=d6/vMFQpS+Y1EELfagTyToKW6n9JoPBSXMCCTRdZF7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sH4a+Ob8ERsqKX2G6GNIiImFEohYpnhfhcyTneidCvkx2NtS88lL1QCE4JCJ3hKXMLzMPsyTl+aRVIa9XGTvRFmdspogh6JyfpjU6vXux3CjpM4hZRorYcX9rXCouJm+XMQpw/Mc+0bQDsRgKjTmJq7YS1R0Lg3LBlxN69ergUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f8QQ7ewi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f8QQ7ewi"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3TNQT3548254;
	Tue, 22 Sep 2026 20:35:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=q3vzoZwpsmqZEwbt3RgUTQb
	Onjh1UuLbk7fOO1kOJNc=; b=f8QQ7ewidu0iXMWE2AYnfhu5q4KgPGJ1TqvSnjJ
	QzqC62rBfOnqcVqAKDun235aAkM3mLKtl26rcbpTQS8wXNWF2jkeU2JNDriVUqnI
	vLOvcKtM+QgJvsGVLAxLNyVjTG2RFfUYWmdGAu+UK6XrvPA2n2wKqBHbYHhEgCRW
	qXeqVYuDmhH5nQHs36o1pfuVJOObNzqGUk31hVnx3nAMVPPul5LWaoLeHkf2XWLs
	AAZC+xhovOOAAP6/aa9doSr0YNTmQQIUSfVGx3F809byXMnRZeLHAyjUNLXXFZ/z
	TFeT0VAoUqfJ8Qvxwc8DGKG9ZL4hVA71Xp+gBFOVv3FFLwQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gv2ddsa96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 20:35:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 20:35:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 20:35:11 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 99CFB3F7043;
	Tue, 22 Sep 2026 20:35:07 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net-next] octeontx2-af: nix: Log TX scheduler queue validation failures
Date: Wed, 23 Sep 2026 09:05:00 +0530
Message-ID: <20260923033500.1752732-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Op3aWC/t c=1 sm=1 tr=0 ts=6ab348f0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=IgfSDKnIuoUFKMqXljMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxMyBTYWx0ZWRfX8gQfWLknhGNH
 SXAB23m6DJp9zqtbXHZ35qQKru7l2aWZYpZRq5qsYzfrZ705thCjD+zOEIe+ATeOe7sSj8sQEGB
 0ymafbksJhKNcv/EWxuNaJylwjsMsIQ=
X-Proofpoint-GUID: TZOjmUN5lDjyQcXPVoN6ptXa9nDUtMts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxMyBTYWx0ZWRfXx3S6HR6s3r6F
 F74NxOH4rNF5JZtIaSKNY2L++h0M9ZhTEQQ68yfj7exL5A8lPZVWlkjySj1HSIlQiU9Icf3rLPo
 pI/1k395tqYw6ldBnRnQx0xeZSH++EkLvaZY+hZ3nEn7lY6QvW5fd9ONQsmxbvZ6WDLl5xuCqVM
 t/Qg6Mn1MghzWVoSwC9jOhUQzz7DoMNQuOcZuLQo2gXEI1u20Gw/OltAQrIdFnwliwO1FOntGwp
 41BZSlsXR13HO+iBoDKv4Ehg0BDgw3dGdup//FlRNbfxnr98BE5f3qCOM2DUhoI/rhXBUpNDOlG
 lci7wPsqIZ6/KrRxpQlCfqLDFn2ezRKKlKxgTVj17JPabWt6Pwz4LxDrRgu5N5qJuz91dwR7uOF
 52Axq6YcgzcL+Cxm0rf6ULCxQpiyLWECSFfVw/6UvVq3kATOFPJpUka4PtCtYr0VNOPXejfFdwI
 LeVyIPHJsLoS8QLr+1w==
X-Proofpoint-ORIG-GUID: TZOjmUN5lDjyQcXPVoN6ptXa9nDUtMts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_01,2026-09-21_02,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

Emit logs  when is_valid_txschq() rejects a scheduler queue
mapping so misconfigured TX scheduler allocations are easier to
diagnose.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2:

     - Switch dev_err() to dev_err_ratelimited() on PF/VF-driven paths
     - Add schq and lvl to both rejection messages
     - Clarify PF/link mismatch wording instead of "Invalid tx link"
     - Stop logging another function's map_func pcifunc
---
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..b0551559dacb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -324,15 +324,23 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
 		if ((nix_get_tx_link(rvu, map_func) !=
 		     nix_get_tx_link(rvu, pcifunc)) &&
-		     (rvu_get_pf(rvu->pdev, map_func) !=
-				rvu_get_pf(rvu->pdev, pcifunc)))
+		    (rvu_get_pf(rvu->pdev, map_func) !=
+		     rvu_get_pf(rvu->pdev, pcifunc))) {
+			dev_err_ratelimited(rvu->dev,
+					    "NIX TX schq %u lvl %d: pcifunc %x PF/link mismatch\n",
+					    schq, lvl, pcifunc);
 			return false;
-		else
+		} else {
 			return true;
+		}
 	}
 
-	if (map_func != pcifunc)
+	if (map_func != pcifunc) {
+		dev_err_ratelimited(rvu->dev,
+				    "NIX TX schq %u lvl %d: not owned by pcifunc %x\n",
+				    schq, lvl, pcifunc);
 		return false;
+	}
 
 	return true;
 }
-- 
2.43.0

