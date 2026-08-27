Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008F43C05E;
	Thu, 27 Aug 2026 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824044; cv=none; b=k8Yfl74ZDIs8WRogjmPp2NmHQRUloj9c7r2FpzyXR1CNx/NFWevR/W+W5RTayhtVJhSaoglvmtKZUO4THQTsM0ZEibVPJnTqU+lYof/+aThMALXsKyZ/tN2ppqckw+2jIUiZxTz/oDKxJvTYyBQUR2xy48YWnVVQO0HYqPsJDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824044; c=relaxed/simple;
	bh=Qvg7bPgD3vrjS9i0U/zL03YKpk9GMf5F5fIrX1khiZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QW2IPPJzMLnXcqI4UYis4d+zQRjmjgrRzF97IbymzrLdf/ML01alLOxiHjB1VZwWhv6U3nm4V39wwFshr1Y5G5ff25d9aBPmGzoFduKPrAt0N+YREMEimn4+qZKhS++siU2vjtApY+LWl9MCmZc2i9zo7JD1rOoShqvZIJhRLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BsbwnLJg; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BsbwnLJg"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9I5SU3193198;
	Thu, 27 Aug 2026 02:47:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	5ol7cohRvAeM9S0hczRVt1bvW7Ce0kfRf/WofVMvTk=; b=BsbwnLJghlAqvdF2D
	U14NcC6qBY7+FVwQPvLyDkCeKEZ7Td4w4oFtMVFzh2oJ8qiX1EeUdZMESkSEF2DC
	YMGnKkg+oKnGeSo/IrQrS1bvJAFRNihp2f3+DgiOPdBt9k2xOeZG3QmDF6HgPsO/
	n18bH2sEKNjEyoe1OFVUjK5CZ9JGFpSoNlLXu+GfefNDOYrRgb2TOUIcX+bs6hI5
	3TwBozzXe6b09CSxVf3EXZK95v5qTrr2X62P0QqXPXqBVUnYQY5e81j++iWClTx/
	Q7ShOBAtuu9SKsAsWL0s8xHd3fcrpOttfdW1jZGemoJ1nGebaBtT2LY4m2fo4yG9
	LYNCA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ga970sh3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 02:47:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 27 Aug 2026 02:47:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 27 Aug 2026 02:47:07 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 027923F70C4;
	Thu, 27 Aug 2026 02:47:03 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v5 2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Thu, 27 Aug 2026 15:16:54 +0530
Message-ID: <20260827094654.1391105-3-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827094654.1391105-1-subratp@marvell.com>
References: <20260827094654.1391105-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: q57ma1FNYCMn6FgJEYqIqj0oTna9WpVM
X-Proofpoint-GUID: q57ma1FNYCMn6FgJEYqIqj0oTna9WpVM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4MCBTYWx0ZWRfX6H3v2EJ2R95q
 +tgRSkCXtpmEHQiGD4i4/Sg177auE0csq1/YYO9YeHV/rAZOWv9NG7zyXCcnsxZjIcHp9qf0cUv
 bOGLo6oLO07eEbMGDOurTakLGYjE38A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4MCBTYWx0ZWRfXyRIWlsp533A9
 M6/iH7xFpVn+aQx9EhPMiyiMPjs3BUzgQMB8YGMcte4OiIgQxFhK/uBDo63ukkDG+yYgOZeML/m
 1FKB1lr+6XJQCrUyouiQEm+6M8iYWByXsyeyOP/DPpJuhmV9GPjXJbMc+2TqOjGz/lMhukdj/fN
 ZaYXUfsILyBFShDW+xnlmSfqvqA8EUKTdMNhUf5rtjAQ+8de7jAuH/OFBXvhBB5iQpvYUL+PJtz
 Ak1jn58aOAzEw+KUlWbDKHSud/HsEtjbCmv0/aPtKHNp3i9U7/OZSKKoGsFXUwc4QvmwVyLXoTc
 JngCLq6hkj8TW+4+TX4H0tEihHGA4gh1lCy4o8d49Cc6vOY95w4y8Lgo9y+XZ850seshFenOcba
 6bqovBkpLzLagC2BLPCu+sJ0dJezMitTjlaIrsqwby2XBRni7EYEXYR/vwtxdQ/qsp1/LPMDs7g
 NFLC7/mpBYAh9BlOYeA==
X-Authority-Analysis: v=2.4 cv=NvbhtcdJ c=1 sm=1 tr=0 ts=6a90079c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=9qxNCY_qAAAA:8 a=M5GUcnROAAAA:8
 a=zu5CyLosWp3-ngOb9goA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01

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

