Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA5376BE8;
	Thu, 20 Aug 2026 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205313; cv=none; b=B7mhoK8Ngr5N7wkAbGQkR6/KdAo3OBpxNJMks4Mb8lRDj69VsW89atpFcj8amFjL2LzL+9YiJkBjdIttDUXqNwyTgqm4rRgLAV++dtsexqkw8G1DPsO6RBZVVXQeNTWiLNf38APau7ACTji0QsESibFbadh2sQ+yzypTh2ltens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205313; c=relaxed/simple;
	bh=vRN1mWNs862eFWVETx5Ntlk1DhnDdkA4sgTdyf4PyXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rPgHlLcR2+VAEAtPx/zc0iYokD4faUyJrrjYEAF+pO1ip61ey8VRN9dKbZsjyYd/c+Vc46WMQ1/VLc6udryS2q6NGdLVVPmGOSgiW+7RiMejiPy2HGb7kuV3wnkbPcQ++RJkmJdpV2UNABNfp8XC51yfbQvoVOGVoaKqBdBVh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=h6TgCv97; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="h6TgCv97"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JM8JWr527698;
	Wed, 19 Aug 2026 22:55:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=uRERParzvEebLQCQgcdtd0x
	2NB4JCGOBlcjEPLdAlS0=; b=h6TgCv9703iilc+nojd7KrpsIrLGTFJdh14kdW5
	s5FtaWQWzQAPsMCcsh50ioWucGalfggc3bj0zdFJLRAlBIgQXHzHC7MVl+hFhjrP
	xwP16FBUAdEi6fkjdxe+RQk3tcNjpPL8PsC/vWyjnD2kW+vBAuVdg8zJXVJgmEB4
	NZHr3mlzNP2GAVanX/eGrT5xQHfEA0z8XV2kbGqYJG0jWIAbb/CaMRLsWoBnPhSc
	wqIAe/YKehWxaAq6aeYi+cmgAFRpsodX1cfb8qLuI+jybfvRSTrxYQ6UmY2lpuQ3
	OGzBCdsdUGSPtW091mO/2KMl0lJv+mfjooc8DK1p1HLfURg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yevegtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 22:55:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Aug 2026 22:54:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Aug 2026 22:54:59 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0372D3F703F;
	Wed, 19 Aug 2026 22:54:55 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rkannoth@marvell.com>, <sumang@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Anshumali Gaur
	<agaur@marvell.com>
Subject: [PATCH net] octeontx2-af: fix out-of-bounds read setting MSI-X irq affinity
Date: Thu, 20 Aug 2026 11:24:51 +0530
Message-ID: <20260820055451.2642358-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0MCBTYWx0ZWRfX7aq3gBKfuviU
 xwTxfZM7RllVWyBhZZTDSA/fSSjw5zR9aOBCOby0E4U9ev4vdNlKfESYeQpf9XRb2vStY2wHpjU
 VEiKLZikF4aGT0Mq3z1iPVBqHm+wolA=
X-Proofpoint-GUID: Cho2blPSPsqdCIRu1QAumwkh7FrG-a18
X-Proofpoint-ORIG-GUID: Cho2blPSPsqdCIRu1QAumwkh7FrG-a18
X-Authority-Analysis: v=2.4 cv=Wq8b99fv c=1 sm=1 tr=0 ts=6a8696b4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ev-rcN9vpzT4Mh_83k0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0MCBTYWx0ZWRfX++ipGUG2NN+6
 u798KEylPRD8QcVOJixB5D8BasfqAumBVi33NqrCzLgxfKL9mohM6DLIBnafXn7U3FiiUrC5Vh8
 jnsX0oPPIiOQCNUwMBFABD9S0dcooYBo/6TI8BDCMYygoA1ma9/E14R8DtppXxxxssBdwd2tmqB
 O0IemkO60meDS4F2EJ3d4lgPowsAAJaowoyBt4faJigCk/qtFX1Tpy8NTFBRaohF+1knPdtef+l
 XXujkL4XtkUdSV6nf/Q/iBq/ff50+KkuzucGweydk0Xugra91SG3LG3OxfayzoavVdu5xaLlxk/
 SnoJy69mTmrOjLQo2mnqdsDWZe0t3DHvYAz0clNu9kOIMpdckiNmMZXr39CYUPQdwO2XPiZKJjz
 EvQsxVQOhJf8ltScDUAHqHhIugTHXbpB3bCFJKlfFJMAuEMJOf9oueWcb5NB7axDwhlZXTE0WEA
 Y98FRkV/yDF64q/Y12A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

From: Anshumali Gaur <agaur@marvell.com>

rvu_register_interrupts() walks every MSI-X vector and uses strstr()
to match "Mbox" or "FLR" in irq_name before pinning those interrupts
to CPU 0. irq_name is a per-vector NAME_SIZE buffer, but not every
slot is populated before this loop runs. strstr() keeps scanning until
it finds a NUL terminator, so an uninitialized slot can trigger a KASAN
slab-out-of-bounds read at boot when debug options are enabled.

Use strnstr() with NAME_SIZE to bound the search within each vector's
name buffer.

Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
Signed-off-by: Anshumali Gaur <agaur@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ffba56ee8a60..43062390aa4c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3331,8 +3331,8 @@ static int rvu_register_interrupts(struct rvu *rvu)
 		goto fail;
 
 	for (i = 0; i < rvu->num_vec; i++) {
-		if (strstr(&rvu->irq_name[i * NAME_SIZE], "Mbox") ||
-		    strstr(&rvu->irq_name[i * NAME_SIZE], "FLR"))
+		if (strnstr(&rvu->irq_name[i * NAME_SIZE], "Mbox", NAME_SIZE) ||
+		    strnstr(&rvu->irq_name[i * NAME_SIZE], "FLR", NAME_SIZE))
 			irq_set_affinity(pci_irq_vector(rvu->pdev, i),
 					 cpumask_of(0));
 	}
-- 
2.43.0

