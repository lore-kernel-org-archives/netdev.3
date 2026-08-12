Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A75429CC2;
	Wed, 12 Aug 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535602; cv=none; b=Ong8Ee+vRM9na7kMe0dUYQyrQxd0TGix+32fWCuGzkhpwNpPeJILiCE7JNR64kB/QKfM21s+yz7PgKP9OtFQlZ8tKBJAB4sxJJk/qOCf+QdznjwrqGshKkYr4pWXCqwC87vIQe+BvfeeOGritrNGM3XDK66c+MDHuXg12+hXfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535602; c=relaxed/simple;
	bh=1Cgae24WxB/xGMF2RmHx4RzPtI0hGnQvfUccoloDvVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWon6B69y8XhhAURpRfmGgTPjync1pNQdmHWotCF1Qox+Vimd8sy5yZhpXRPMWjTOyeLEtnjKTSemvSrTsBh4RQzx//Izsn0K45tbpGwe83Y8WR37mLjsVN0WeWYO2hwC6igYo08YYBJdb5i2umv7ML1aWqKuPguar4R91avE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZkXHjjZP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZkXHjjZP"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB4VVP1629437;
	Wed, 12 Aug 2026 04:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
	wGNU3eblUZ6SEatapZ3vFhBNl1d4DBdFjFnOodBDLM=; b=ZkXHjjZPvFv1fMuig
	kkHGeQIkAWxdDami7hUHh7m8j8xFOA0Z4ssXdiaKJ76YPuEA2iLL6noG3kEwV7cg
	mPFaQCBw8bebwIg01+Il6NLV7CJVWLCYdI57eeMnAmCABgC/HtjRn/muVR+3SFZq
	EOv/EO1pFBJB2mM01BW7LwNbs22E33Z4tbMof9Vr5YxmViATL9u6PMeLoHSERKOg
	+ympFLqMUaBxNtPtp3pfPWYRLwdTEOXRredE6Sw5XKl6TjGowzW0xpiJrHDjY39G
	+TDQm1EfPLSRyiVAbyBUd93wpM2JoVidngtttCR/98QjrIWfXF6hz/jviHCdXMwO
	7epRw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fyjvyyc0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 04:53:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Aug 2026 04:53:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Aug 2026 04:53:11 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 113FB3F7044;
	Wed, 12 Aug 2026 04:53:07 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v3 2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Wed, 12 Aug 2026 17:22:58 +0530
Message-ID: <20260812115258.773319-3-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812115258.773319-1-subratp@marvell.com>
References: <20260812115258.773319-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QJ1YgALL c=1 sm=1 tr=0 ts=6a7c5ea9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=9qxNCY_qAAAA:8 a=M5GUcnROAAAA:8
 a=zu5CyLosWp3-ngOb9goA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: wKRhzx3GUhluXijZTZyundiV85y-HRLS
X-Proofpoint-ORIG-GUID: wKRhzx3GUhluXijZTZyundiV85y-HRLS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5NiBTYWx0ZWRfX3Q3oPeUW8ZtY
 9HrgmlLsUker0f6GNLME2Y+Tu4TamqnY61/ETR3nDeHg4a6DR5yBHupC8EpqcKUD7D7HdtHpxJx
 ZEI7LfQMs8Ofq9tWKgSyFOxdYGQcfOg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5NiBTYWx0ZWRfX86CVVHhw3u/8
 vks9k2OfyengJfDrknGz0lJk+E/n4VOZgi/gNM97u7MMhvIKikJ7rNoT//JOPKEdZAypQY2w6xe
 y3vKV50dzbfyCoW/t/6h8kjsFfsYCiuMCkyvb0RKvL1AZ+FPW4FziGkmFfg+taPsUXTsKD5Jq/B
 FJLUcUFgf/g2k3/Mho3meTRRyQxyAHQGUzlZVW9QfhXKx9E3fBURbhp01RVI5Sr4hZw6uJESW5y
 P+eDJsDE7cD1zSowxVp/Fqi0F0sCB+irsDNjHPq1XH+6DibG0YIBRsTWZEdFv0hRcbZ9pCmzVXt
 GTDuiGkVwO1fmJOFVdMTzl2s0sXGbg7Opv/Cj8LzqDZiHpVsOsrfM3CMrIJwJcTiu41k4eW+BDv
 jR7VseB2gB43cusPqTXC7/+wypx6KURaWJkycrf9GHRT1FfEMCKiD4/7YfAha4xSXME5pLBbOyR
 sJ6E9mCFRy8aDv8NLkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01

From: Baha Mesleh <baha.mesleh@nokia.com>

The SC resource cleanup loop was incorrectly iterating over secy.max
instead of sc.max. Use sc.max as the loop bound.

Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage MCS block hardware resources")
Signed-off-by: Baha Mesleh <baha.mesleh@nokia.com>
Signed-off-by: Subrat Pandey <subratp@marvell.com>
---
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

