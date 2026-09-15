Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3E2AE76;
	Tue, 15 Sep 2026 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457070; cv=none; b=cDz4DzkbfzEnJHvWuDDSWgeTB6kz10KTOWj9EkItSG8tHwMEBLQ7CU8vO/r4C7XM+DYG1il0FFnFPOSkKtOVfsxGfM7rokT1IHwZo1eZCMHMudJ9gr5iVWmvV+DqBD9R521s8YzEKNGr2fhPaISCiiJY5w49SMbgahMoSrm/hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457070; c=relaxed/simple;
	bh=HCg/jEVlCo7Ue6o157N4zHJlzVQJsaptGKsAbPUhy7Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xf2VQGGGSy9OfCpkuqO2vTQhXJuxd0WhzUTOHP7vDoT52U0rtdgxZL0hTtG6entc0z15kDPenV5sMdh8/eDPethqAFEZF5NnhN8vvjfGt1jHBTMtM7i2x4+r1d3eO6UL1faJOyA22zEGZot/0HjurTDgO6Rb933wA+OK1mV1kS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ac5CNcsH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ac5CNcsH"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZZwc2902158;
	Tue, 15 Sep 2026 00:24:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=xwQJSthqhpQRUcpdYVjpifI
	Ui//qbqgaljTKOeSdF0c=; b=Ac5CNcsHm8f1s1t78ryprPp8UDu5oytcna/mdCc
	TZ1M29jhyXhcG53Qg6dv2S3VeOXV4+lTM28RU2VbGd+PpTKHW80Ku20OblSDFRpA
	gNXa63ZtEcnordHRuAqCLl8wED7/JY0SFQPpKq708roSxxNXOTdbeYEfuieexhs3
	/++jeAtVZ6UO/i+dsyV415SU8h5ttLAiIjbBp4oDNZ9TMLdZAGVj5EDpEf3CpIve
	NqTfflw9LqBhhKci/MXK9LXAjrinuCuNkL9X+QUDsyxtLhFyQ/zd2K/ymca6q4Ml
	//MeL5gbnjZs6P/di2L6q2pl4C6+tQ4oY3d6uSBK0WSAnvg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gpsc7t0cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 00:24:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Sep 2026 00:24:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 15 Sep 2026 00:24:08 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E73C63F7098;
	Tue, 15 Sep 2026 00:24:04 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: nix: Export CN10K admin queue enqueue mbox handler
Date: Tue, 15 Sep 2026 12:53:57 +0530
Message-ID: <20260915072357.980485-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=aIhlOr9m c=1 sm=1 tr=0 ts=6aa8f299 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=0bvFSw5o0_g-J61_eCYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: gsq_pA4EfySjc_RzOIsx1Vfm6wVAtxnB
X-Proofpoint-GUID: gsq_pA4EfySjc_RzOIsx1Vfm6wVAtxnB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEwNSBTYWx0ZWRfX29RnSCVTmXZZ
 z2wr/K2EO+FvUdAdbaRPtLwJS22RhP6kJLeM3IX/Jln82SEhGnbjEQSiphsIELljBo2D5x7/21v
 zRcMGnbkZeQTe232iL12Sl3BibNt+0E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEwNSBTYWx0ZWRfX8djpcmEePruV
 tT9K7IlOYiR0ztVlHZfendC3xYqr0SlsiSEM7Y5HabYVj2MhqdNRxF4FrkybiRem/POTMcyekW8
 +ZPyamkbnhAXtatynhRHtV2jf7OXqP2F8QR6JkOb/KlkOr5SPFv/tS3Ono8zE08zfFd57PPpcvO
 wNnswz/Y4FRlSadiNxsZ4mpUFMOAZdkVlgLk1yvDMGv5vXlcpUzVlzZLBC9dae20Guj+nzE4wFy
 qOPil9KaBhjEAmU7Ckeb2uQsq5CJ/awCjGVIBJXw9HmWFPeXum0XWXlYF5tP8rT5XLLKZ5MFR+z
 ilS1Ah6ccGesOj76iXnvuPP7A76kXn2TiXZ6DnpxKJn3WIy7MlGmOUmLqXewues0XoRZ32Tw17H
 GG+V9Ord7mqmW69DcWZkRF11y0RZhKPAUs7c1XTW0v1EzjKtz43iJURXh7tD8aSxlw7P9kJB1pC
 TWDOU2oqbb/tosmEeRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

rvu_mbox_handler_nix_cn10k_aq_enq() is used by out-of-tree CN10K
modules but was not exported, causing unresolved symbol failures at
module load time.

Fixes: 30077d210c83 ("octeontx2-af: cn10k: Update NIX/NPA context structure")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..95776ab924e5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1501,6 +1501,7 @@ int rvu_mbox_handler_nix_cn10k_aq_enq(struct rvu *rvu,
 	return rvu_nix_aq_enq_inst(rvu, (struct nix_aq_enq_req *)req,
 				  (struct nix_aq_enq_rsp *)rsp);
 }
+EXPORT_SYMBOL(rvu_mbox_handler_nix_cn10k_aq_enq);
 
 int rvu_mbox_handler_nix_hwctx_disable(struct rvu *rvu,
 				       struct hwctx_disable_req *req,
-- 
2.43.0

