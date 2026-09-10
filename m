Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D882576E;
	Thu, 10 Sep 2026 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021642; cv=none; b=fp4JeNNk0oWIQXGpR+FdJXJRh5Ol5556h9Q4yALpCY9blAk1ibGDI6Zs0DPLgllx9/LAvIqunLD4XUgRXNOcGguXh64YE56FPnl3AtMa5y9fCBZPqHsPSsEgY7LRT9us2gZDQwVk7ZfxKpA1IdKgoV+6BhfBojIl24xXLiLIb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021642; c=relaxed/simple;
	bh=J7Vc+3Z5fmcgvG4eYL+zpbzLm5bO37OGWBDkNlSaeMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+NUvkbx8iY3S4w2ryBWvNVz+QwjuhJBFOx4FffNcXSpvYy9lumJGQyaHoYG41U8ksXaIqhNop+LUJFR9h2UHiXC0C2IFUbVimxtYPj8w0dbUfKhY5nE2ow4NClZe77ULBEiIP7b06NrIj67rS3ETevkh3mADDJRFL3K5oq2Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=efHfteLl; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="efHfteLl"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GF7D1791018;
	Wed, 9 Sep 2026 23:27:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	AXop2dNCOUhI9Punpi1UK+FSrOP99/vdBl45fZRMaU=; b=efHfteLlVx+06F2QY
	oSrSEhKEDzLti4WkzN7eVbrtRfB39kRNb/kcPqiPTlRvO6atIfShpwEMV0rIxMy9
	CB5JySObprYRq3qGBi1yibRJl8tmmYfG0ktDiRBPjvFr7+34wYUHhs0E4xgvgXLY
	MHjs5JyWzI8Ct2LCQr5LzF5C8zRqft6vpyG0atsFiSbxStJTL/zKCXwIwKKPX0Cv
	tVgyZblg3FMz/rft+LKARm2ABNSOMlnMzRadgF1/Gq9eXRzFX5Xp8B44RIC1fjlf
	L6WtcajgunUHLjP9thQxXEBuCM3m2QH9ebxeJ22PvbIUaaO9BIKNXrsjGGh49tTN
	8d+IQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxsjcxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 23:27:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Sep 2026 23:27:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 9 Sep 2026 23:27:10 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 60EEF3F7063;
	Wed,  9 Sep 2026 23:27:06 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v6 2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Thu, 10 Sep 2026 11:56:57 +0530
Message-ID: <20260910062657.3712256-3-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910062657.3712256-1-subratp@marvell.com>
References: <20260910062657.3712256-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NrlE4MdJ c=1 sm=1 tr=0 ts=6aa24dbf cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=9qxNCY_qAAAA:8 a=M5GUcnROAAAA:8
 a=zu5CyLosWp3-ngOb9goA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA2NiBTYWx0ZWRfX2aHgHa1Nd02g
 LPh2IqLcabiv+SRZMD8MvYP4avas/sCwgaEoG65fz2b8ULRZroDcfQNTo8NDRIWL5MyBwientCp
 Mbek5mAtu8v2liU7V9vM+6wtvJxFVDw=
X-Proofpoint-ORIG-GUID: Uk8212lSLR3AkL7JGtyBRxbbiwz_w3sh
X-Proofpoint-GUID: Uk8212lSLR3AkL7JGtyBRxbbiwz_w3sh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA2NiBTYWx0ZWRfXxSjxNzs5Yqt/
 2Eb7pNVw39BzdeQbwPFQ1rXLQ/JxGwcp1Uf8nrVt9q54ju9VBlIh48rCKTDi5g+qAP5+ZbNT5ly
 Uf+6z7oxgrEBjvnZyGM7MTv/ADDmu9D3XucNuGAkWIMCzgnqj5TpVRQeGwO4jLKzI4mJDv5yW8u
 6RgDpW96gxPz+TF0SacWZFJsu+433GUa0C/3o3XCP6VR39AiHeEDy5TM46gKAhe0o4NDu05ov74
 Ydif0GynWetxkElw0uAMP6YMR9oNhRYUKJO+squctUAWzZf1diZ0lkcsxqLgAAREgsOHTbrbQZh
 yUyYPj0ivphoD3+75ZSWTZ8yiG/ww9+ih5ernBJYhEEcFMtAFnPEC5d0Buq4BCYjCewP+qZUa+e
 QLmSXq4HSuAuMoXXD8hRvrGKg8cLGJ3ZjY3pLQuz0rbg9ueshIc3vMD+Bx3YrKUFk37/qfVjGc7
 szSo+UwfUihzk6OCUSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01

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

