Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E83390200;
	Thu, 10 Sep 2026 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010194; cv=none; b=aqL6HIiouvFfOpLvHhMk8z2quqsXd60q5OVo39vDhEUKY6Z709dB3GwywukqQ9YYcrLQ1BS9qP3fbVI+mZvNxAly6rlgGja1JeI7lE3Qq8BIXd8NG8DEfquTE/Q+g1+QLjPFYg9TLDD0wEaex13db12/cCTJWycQZ45XJNGk60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010194; c=relaxed/simple;
	bh=qfxhNHG0Z1RhgkZUy5OlUfu6fj3lZtQEmv2yXYyJ4Vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YUJNPtMv7gV+H9lnHb+4/6rTvF696b1niXhu45drgYy3eL1W5c08rM+p5u/PHrj9EqYEXQjdIMUZPetJGLNT58u1hT5n1rM3tGhALTEQHgkMcEt58U0eFQ/tZx5KMTT/eFdFKFphUrJhXIrPNxJ30WoOF0flxFSGqDh7Oxr2H0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Lw4PVTj+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lw4PVTj+"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A1kkXZ4173415;
	Wed, 9 Sep 2026 20:16:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=JWMWzi6f44G/es0DiDhckjo
	ib2Sk76tCNKSE/IrNFXI=; b=Lw4PVTj+CFInq8CwNJkPECkSj3N/7nqfOinrOoM
	z1uI2Ej8x8syEkNmdiQYspCSfah6ZrRYZOqZ5UDy+arI+4st/3D2bkddjaDqhcI9
	gcEp56zprxb6nW9260OR2w3T2gBwkI2lJ6bvUUE5jKnrHycfbbIQa86c8mJOo0gN
	EuK80DblHo/nCemA0IzlGbcHdboe4wpq813+ZtfxfWWATDNW01ewR2Z/Tv2mzn0X
	+3253LBapZmwsYHAR3FfX8NVIjrDTI2iW6xXWGReEMdNlKYDA8t0Z+ueAxEQr6g9
	YT2njUbqmRTPWEsovzNdu90s8HNj6Ij0nqnxkX/9wkFmAYw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxnsx1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 20:16:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Sep 2026 20:16:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 9 Sep 2026 20:16:12 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 8A0153F7057;
	Wed,  9 Sep 2026 20:16:08 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Rakesh Kudurumalla <rkudurumalla@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH net v2] octeontx2-af: Fix BPID leak in nix_bp_enable()
Date: Thu, 10 Sep 2026 08:46:04 +0530
Message-ID: <20260910031604.1045397-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDAzMyBTYWx0ZWRfX5YrGlZ8fvgc9
 h437DadRbTCvd2iQoI8UU9jguFQ72WI5U0yfUMjhWaSakRii60TwlYGLADeQNNImTTLhDRnPaKr
 hBVDRdJ/nv/I6EsEeqNOYXfDU2K1EkCovGg/w8NABjw7GZggz/rXXgeLiPAgU8ldudqY0RpQoH9
 ONsHDcD/tlN1z+5ez7z4vRH2fGeuyJYlFV8e0cLP5Xtm3YStOFJwmVtwKcbI582RrR/N9+y/p7k
 SVK0hywdJtmHNXCEAr5Ofr/aXJl68rDRyH8Do7AFDMRHljts28LhsSaRYyQCXEfY/2tekKWzufq
 Ce5PN1Z7BOVdX/3nMP8S+Np14u0q6AZE0KH3Rt8RaT5GDvlznBKaPejJCPOe4elIvX83AuMJ9Ko
 +cN806QxPvmsgRel10BgFmIholsF4vUwlbirJaUcoOdW7qzq1Zt6FmQUOWO1xeHFaiVbPEPUTjq
 kbPFbI+TaNVbI56Ay9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDAzMyBTYWx0ZWRfXxrWUpw8qebVO
 qKhMbq7si2QsBRkogYjB3WD7TfnxcgU8MDf5HnU5+PqdulTedMLv+bwynAYvK3NeK/YQnfOCP42
 /KzweFKrafldWX4G0YoeF+fn9lg52wo=
X-Authority-Analysis: v=2.4 cv=UJxIjyfy c=1 sm=1 tr=0 ts=6aa220fd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=_GkZ78KWd3HuAaUqZusA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: UkOaB3RKQ7XK8-mBESIfWFbF33tjgTuc
X-Proofpoint-GUID: UkOaB3RKQ7XK8-mBESIfWFbF33tjgTuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_01,2026-09-09_02,2025-10-01_01

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

For LBK interfaces, rvu_nix_get_bpid() allocates a BPID from the free
pool on every call. nix_bp_enable() called it unconditionally before
the loop, and again after the last channel was programmed, leaking a
BPID whenever that extra call's result went unused. With
req->chan_cnt == 0, the pre-loop call leaked a BPID on every call.

Move the allocation into the loop body so it runs exactly once per
channel actually programmed, and reject req->chan_cnt == 0 upfront.

Fixes: d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
changes in v2:
- Move the rvu_nix_get_bpid() call for LBK BPID allocation from before
  the loop into the loop body.
- Validate req->chan_cnt before allocating BPIDs.
- updated commit message and fix tag
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..3a43432d29c1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -764,19 +764,25 @@ static int nix_bp_enable(struct rvu *rvu,
 	if (cpt_link && !rvu->hw->cpt_links)
 		return 0;
 
+	if (!req->chan_cnt)
+		return NIX_AF_ERR_INVALID_BPID_REQ;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 
-	bpid_base = rvu_nix_get_bpid(rvu, req, type, chan_id);
 	chan_base = pfvf->rx_chan_base + req->chan_base;
-	bpid = bpid_base;
+	bpid_base = -1;
 
 	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
+		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
 		if (bpid < 0) {
 			dev_warn(rvu->dev, "Fail to enable backpressure\n");
 			return -EINVAL;
 		}
 
+		if (bpid_base < 0)
+			bpid_base = bpid;
+
 		chan_v = nix_get_channel(chan, cpt_link);
 
 		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
@@ -784,7 +790,6 @@ static int nix_bp_enable(struct rvu *rvu,
 		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
 			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
 		chan_id++;
-		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
 	}
 
 	for (chan = 0; chan < req->chan_cnt; chan++) {
-- 
2.48.1

