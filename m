Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8C390212;
	Tue, 15 Sep 2026 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457479; cv=none; b=tUnVmaeSlMTBZWpzqduPluYSQU8ZSCWsoVIz4z8/baTetIgQ/kObGIHEdY3WqKEOVpWpi+8PljJ47SEU3JaVWP1WbzWkpNWN8TBuNhhHEkpNNBt4/pPt6G2t+vzvv6CdiV5TX2y6VweH9tcnAvcMazJn+cX102uAQznIewfC2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457479; c=relaxed/simple;
	bh=6K/w16UBrqCcu3p1jgGqeQlDh/Z28EnKCgMs3mDtaFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nkNd2OZ+FW2Usasy6F/aFa7MDnA36vh2WivhC16bztyluMhuG7h0PtlaVRZ9y3XUTFtzo1WMv7pKVlv5o9AInA8uES2OQvK5MMpO9XIDf7oLkqQyevi1lTjKsc9cN0BP6ZTWqi7W+9wHJaPUc3OyKlxyuunucuQg4cvPVq2nnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=k3+DfJv8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="k3+DfJv8"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6Z4pk1047656;
	Tue, 15 Sep 2026 00:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=guM89mY3EQyfrFLdaLOEtqe
	e7dC2nqL/3xc61klpagY=; b=k3+DfJv89PzWlQFvvFaOvq6rsanOvPeQrfW6KMa
	AYX4kxS8hiS4V01uyEl7TNPRxOx4lhSkNGoW3ZvV1cnp5x+1egQTTXTv7VPd10BO
	+0+fJcXhLaOVswLCdhhMEoT0FWhx9L1IHUA7AWASnLNGPORyBmgXUPKGHDaGmvKd
	qatptApbyDTf3QbcSuP2aSfRzYaEz4QlP6uVH3zZPlk8yw1mBOSvP8slSDTVeEUm
	lRMjias01gDcGJHsWcPzy8XWccNRPfV/WwIwqXkr7N/GrY9vj8F9+ndAMAmernZH
	4QGVwWy/W1KrE50OCxUTLoB/Ud49dFEBGtEdI10mNLAfvBw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gnqg6yn34-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 00:31:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Sep 2026 00:31:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 15 Sep 2026 00:31:08 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 57F233F7063;
	Tue, 15 Sep 2026 00:31:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>,
        <vattunuru@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: nix: Fix TX vtag upper bits programming
Date: Tue, 15 Sep 2026 13:00:58 +0530
Message-ID: <20260915073058.992915-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=A9/5rKWG c=1 sm=1 tr=0 ts=6aa8f43d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=aHCFOCUg1xN91pC27xIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 55i1oOeJTRIN6Yh1eFj5a8RTDRtkvcx3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEwNiBTYWx0ZWRfX7+opjlQSjT3t
 /8kb9+OvWEedN7CD679sheundxe+8eMkx9MIOHjriRc3v4+olFFXVqwkJnHYR+bdAGuejha3ov1
 HXyiZblEN2aNGU3V1OV0oFB4wnPuCPw=
X-Proofpoint-GUID: 55i1oOeJTRIN6Yh1eFj5a8RTDRtkvcx3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEwNiBTYWx0ZWRfX9tsRVrYJowjQ
 4InZCXNpu4+tAOk9bv8yVLIAx/J4Mg3xmvaxGQ6F94SAZ3MFRdR0nnSb8rr89qIOS29oNXpf9RI
 noDcKouDbDCAPN9YI7Xss4PYxHNRUcegyl2aIbBntxpuUFCtqhmfuqxTQYpLp1Qbb8J+hqol/aY
 Fn4QLvwI7DGOQ769p3wQEGdBsO1K4YGroq5224cN1H2XspEMpqBF55c0Ac8Dcppf3P6F0GMHF9A
 jrg205u7EsizWOdXCnJ3RZXbCf5tDOAxLr9ZqvNni/C24nWlXRPwsJ51PB4JwNOA7mVZXx8KS6H
 yzEU9i6nWLyoX1zl1805VPIvOYURmI8Vn+RvBf+04FABh5r5+Yv4EUP4adsGoVmlrxNk2qrICvn
 2KrEvNgfGrWVThEK1rpw3SwapB9NGe8Eup3XiitjJ4vkhaCpsK83mKrnUiKKic2UFkn+lsP0FNp
 yW8YFFYgT+u0QP1RRYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

The upper bits of the vtag value above bit 47 were not written to
NIX_AF_TX_VTAG_DEFX_DATA, causing incorrect TX VLAN tag insertion
when extended vtag fields are used.

Fixes: 9a946def264d ("octeontx2-af: Modify nix_vtag_cfg mailbox to support TX VTAG entries")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..091ef8dac7c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3107,6 +3107,7 @@ static int nix_tx_vtag_alloc(struct rvu *rvu, int blkaddr,
 	mutex_unlock(&vlan->rsrc_lock);
 
 	regval = size ? vtag : vtag << 32;
+	regval |= (vtag & ~GENMASK_ULL(47, 0)) << 48;
 
 	rvu_write64(rvu, blkaddr,
 		    NIX_AF_TX_VTAG_DEFX_DATA(index), regval);
-- 
2.43.0

