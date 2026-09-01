Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEC3AE195;
	Tue,  1 Sep 2026 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263307; cv=none; b=sznfQd/ZsZYCFO5kYLb8TZmHjZj7RBtdJHd7S+l0l1Z3w75U8q3qayfWpvxgKPjwH2gm03FMdlLAizc9xqlq/uZj7Dp03og+zlUzpVkBwCa6OsmrnBRXoWyyvjLZ2+QZH4nRtL52LYndkr7UpbGb+wuKzHfFMDfGhOddJfAVMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263307; c=relaxed/simple;
	bh=S/SRet3qeBwN+oQWR3doE93E6/qESJhQ4jEYrrLt4D4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fYKYSkqd9TXZLNbtsQokPU7kyH/6heZBP5yg0S1Rbw4Y4qHJs5gYkQdiSbY1TG/lHIKERvnWrXnBxo0LqTxpXu1oQnWDxcGoXJbPUmrJrpNIW9wKp1lvnxkOS0Gfb8esBsVlGYamE1M3Exac1nnGXqRTUMSBCvg28+7Ya9vuFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Pqgi8KVu; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Pqgi8KVu"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AL0fq3167664;
	Tue, 1 Sep 2026 04:48:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=9Uibh/DA52PFA/piBtPl0uK
	X8OgmgMslK1Dh1GZW2I0=; b=Pqgi8KVup1jawP4X0VVxbpsr9Acb1eTSzEZN8fB
	7bBAFHQ1FvC54K9c1dLuRL7i0sw4fg+ZcGKDGSOaCanAsQWNpkw68OHjJmITeDjH
	0iJSpLM5VILRC+oor1eB6adJz76jJv44uQm0O2hsc1FMTZfAX9JWwjerj+UEZjSq
	csQcDqYwQRMU359UqcYsZCG4AWi4Ytm1/9rR/8ri1GS6y+NTB5tBKJ47Jw9z7qFN
	JHiJMHSWJdZJaTTr+D/Wq6RfnSGQ8STiBzoWswUDkqHm+wSdJQud0PLkyIL1ohGn
	yKyfJtIS8Oj/0+zXL7j+tEk26Lb0qY3A0mKVV/jzHOgBMbw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gdmvqsjfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 04:48:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Sep 2026 04:48:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 1 Sep 2026 04:48:15 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 144265B6928;
	Tue,  1 Sep 2026 04:48:10 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Roy Franz <rfranz@marvell.com>, Nitin Shetty J <nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Simon Horman
	<horms@kernel.org>
Subject: [PATCH net v2] octeontx2-pf: Fix ethtool timestamping capabilities for SDP representors
Date: Tue, 1 Sep 2026 17:18:07 +0530
Message-ID: <20260901114808.1701352-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEwNCBTYWx0ZWRfX48WomyWztRvF
 jAosileGDxcjivMwcJ78BzsnmAsf7V/pQYi3JWdJcY5kIcKSgnQDT2FVZmZHkwXMNEWQLM7qqHq
 xs/hO5E1bzUPiVX49R9iQGHANX5nyB3pyxipZUH+DzwdbeSZ11G8t1LjN8hMtNc9QmZ6zW7XCAB
 n616Kl28xmMAheEqtcrbbjYU/sC1FAyWrPts3MvloSgiPKb3OABOyMq7IU3Misbrot9SEQ7XZ80
 QRnv8U13ABwOE2uq7yl8hARzk78/d87ASCQgofhiwA1hbF2lzBAiPtRD3thG3ngvpzxF0FEYoKo
 V8ZCqrZr9MnPs5JzRMq1m3rUAAldCnQISpWsRkC12919VzPbeJlOtrZWBhwZqYPW282MviIBhrA
 xNrhtzewbMlMtVZnnm6Pi38//0JOiUKIFbUXw3phJ3XrfbeQ1j5JzZRSKB10NMhGdF566CT7JHc
 U6YGeEC5kEQ3J6o2YYw==
X-Authority-Analysis: v=2.4 cv=HYQkiCE8 c=1 sm=1 tr=0 ts=6a96bb81 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ylu_Mql_jpgZ7cmvgmoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: o0jraw87Xo5DHm2Uc_7ZB2T330rrqY9D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEwNCBTYWx0ZWRfXzdvu2PtCBWz3
 XtZjBpk7sloiF+6yVmZKsC0CHJFUoKU0n8IjSx27IZRKcFVHP3G+iyIkr+lvVOSvBNz/pV+NRKB
 bWeWyrw3rQsTJz4c806WwKd1ODrCQqw=
X-Proofpoint-GUID: o0jraw87Xo5DHm2Uc_7ZB2T330rrqY9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01

From: Roy Franz <rfranz@marvell.com>

SDP representors do not support hardware timestamping. The current
implementation of otx2_get_ts_info incorrectly advertises hardware
timestamping capabilities and a PHC index to userspace for these
interfaces.

Fix this by checking if the device is an SDP representor and returning
the default software timestamping capabilities instead.

Fixes: 2f7f33a09516 ("octeontx2-pf: Add representors for sdp MAC")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Roy Franz <rfranz@marvell.com>
---
v2:
- Disable PTP initialization for SDP representors to cover both
  ethtool capabilities and hwtstamp ioctl handling.
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
index 95b0a1e7c936..7b0a51f453ce 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
@@ -386,7 +386,7 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
 	struct ptp_req *req;
 	int err;
 
-	if (is_otx2_lbkvf(pfvf->pdev)) {
+	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev)) {
 		pfvf->ptp = NULL;
 		return 0;
 	}
-- 
2.48.1

