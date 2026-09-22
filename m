Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720265349D8;
	Tue, 22 Sep 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072584; cv=none; b=N9eA9nlISBQh0NH1E8DkB3kdYwIx7a8WNkcmaJtuZYpcywCbfq/3TZ26H819AAfzvG3kYyxr2YeVUcbuybW4omjXKsWYOToZHTw2rnc+iamkqpZu0VPj/zXa55q3zypbo8Asqx13ktUZVFL5TmMh76ZBn+f3Ssb/b9Bebk4CqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072584; c=relaxed/simple;
	bh=MxKLDNsSEbsAZ2FsjkGj1Cd9kOeqGhPW8SlTehjOBsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o90cXuuT715Yu1xBHzb9jxSVmnixqv/C+NGLM6RYhZVfUHUhP4CwresQj9C1rCEnr7tef20NJ42MuTPmBe9U/sz049TLKq/lmS01zvhQI9TP3M8tsW+iQnjz7RIymFyZOfXgHpbiSfO0vuYVIcha5jblkId9l3daZHfrK/kZNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=geja6OAj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="geja6OAj"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MA2Y9x2142606;
	Tue, 22 Sep 2026 03:22:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=blza3JfDKhjzui9dlwsD3ff
	M8UFDDjdz5j2XBWxUlC8=; b=geja6OAjCSXx0+lgv3UQJdKW94doyuYdPG/GTE+
	si8FSg2StE38O9HOgsyjgLh+frJwx+7BRfnUNL9/AJCjNRYA67MacZdltHV7shZi
	TyZKIpu1Tr8UY7FTV/chq6/hi6o7URkxeFuqesd6viLAT7Vv9D5DG0NS7qkzFcXx
	utFohedeMgzUKj9enMMEX5HPODmW5g4mN/7Ebyksi7NyFREmE4XdiMBsIbci7E7v
	yJHuFune/vTngcG9cX9dHQ8U/+VkeqabMwlYREU94/XhZdruCs7/H9WlZnedSHOd
	VQPHdXopls16om6XYZdQeL1uTXz04tmHxlKsJrNtI2ZEMPA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gudhbaf70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 03:22:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 03:21:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 03:21:54 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id C5F8C3F7080;
	Tue, 22 Sep 2026 03:21:50 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v7 0/2] octeontx2: Misc fixes for RVU drivers
Date: Tue, 22 Sep 2026 15:51:47 +0530
Message-ID: <20260922102149.2078168-1-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE0OCBTYWx0ZWRfX+1C8FkjR5A3v
 /89LFFro1TjeSf/UPM2E/O84Z/+eSyj/EUOLzVBFL/nMm7ILc/ipfvucgedgf5mzBGOToGaMieW
 67ZvwwNSC3t7QEeY9dLfUVDABg3M43E=
X-Proofpoint-GUID: bpeJoKG9a3nIYc2-FOOEqepQ5GZIQ21H
X-Proofpoint-ORIG-GUID: bpeJoKG9a3nIYc2-FOOEqepQ5GZIQ21H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE0OCBTYWx0ZWRfX2razPFz+w9Ki
 MLFhUJBGDfW4yvFaGFD7oLdmVPyfLWxFIzbmx9x4xyvBoTj703adxbgOTqR8TCNSlA3Ofv4qAhG
 /VKTti7g4WE0sGpSt277MCm8zL898Q9oErDA9gpjMccfjx9WuuaRTwtTYxwPk1s8kcDnG2Ogrll
 8gDxWUCmlFFGT8PH+8lQCGUmQ9Twfhd3tyscV4EplarbgWBWmCmHwKEU1dByVH4J1lbmXJEpvO4
 qcz2bDSzwleh6OXwPFcxeiG0jJ2v4XzpcxoxMtrY9TVnqkKXJJHUOMrVRsRV8MO7e4fZnIg3kCD
 qxVtqRAyoF8TaAmy9vCUvkmf6ATzeFXoMDUSfkS6K2h2X1Gdoffb4WUgmK39aV2p4hSY1MQ21im
 A8IZ9zX9kvZSl/mnklp6edhnpKfp2LhNxSbz21vEKhPStws5j9nOti3VqJbVNflCIMTcfbsBQaJ
 lAzFw2okbMMlLSrwUCg==
X-Authority-Analysis: v=2.4 cv=EpRHPicA c=1 sm=1 tr=0 ts=6ab256ed cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=4I0ENqp42E1HAAk-qN4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01

A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:

 - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
   queue_to_pfc_map was always allocated (not true for SDP VFs).
 - Fix the SC resource cleanup loop that iterated over secy.max
   instead of sc.max.

Changes in v7:
 - v6: https://lore.kernel.org/all/20260910062657.3712256-1-subratp@marvell.com/
 - patch 1: NULL check for queue_to_pfc_map in otx2_get_bpid_idx().
 - patch 2: Reword commit message.

Changes in v6:
 - None. Rebased onto latest net tree.

Changes in v5:
 - patch 1: Fixing the compilation issue when CONFIG_DCB is
   disabled.

Changes in v4:
 - patch 1: Add 'inline' qualifier to otx2_get_bpid_idx() helper
   defined in the header.
 - patch 2: Correct commit subject in Fixes: tag to match the actual
   upstream commit title.

Changes in v3:
 - patch 1: Unify the BPID index logic into a shared otx2_get_bpid_idx()
   helper, dropping the per-file #ifdef CONFIG_DCB.
 - patch 2: Extend the sc.max fix to the SC stats loop in
   mcs_clear_all_stats(); add Fixes: tag.

Changes in v2:
 - Dropped "octeontx2-af: Fix mcs string buffer size", will
   re-target it to net-next.

Baha Mesleh (1):
  octeontx2-af: mcs: Fix SC resource cleanup loop

Geetha sowjanya (1):
  octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled

 drivers/net/ethernet/marvell/octeontx2/af/mcs.c  |  4 ++--
 .../net/ethernet/marvell/octeontx2/nic/cn20k.c   | 11 +----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.c | 16 ++++++----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.h |  9 +++++++++
 4 files changed, 18 insertions(+), 22 deletions(-)

-- 
2.43.0
