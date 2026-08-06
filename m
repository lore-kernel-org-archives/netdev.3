Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62221345CBF;
	Thu,  6 Aug 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033043; cv=none; b=YN/q3o9aDObZa2GN1tC+KkBpPDarAfg6Zutv8pxrSI9TH+xFLdgLypgM25SLbyKzbHSwLJLpvNlwNhFuICPKpdb0w0pqI+7BMDISAxInqEXJ41JAkOUOn7ADHGRQLyi94MC4zwFWy2c2DGTuDxoYCHuQvhCC12NZU1I0jdHYa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033043; c=relaxed/simple;
	bh=zsXxJ9S4Ap4w9/Bngch5HCD6O/baAFmb2Db7r1GB08k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fbpysbyY0gyg/9PBXDF5L2fIaJmm6adpZY5WkpId9eHBa8RPbf7vG25xCQBUGjQCsytToDXqa2Rjg9teFIi6Ta6poJDKGGZQC0Z9OSJ8UnCpWtR4lPB+GXfbzOi8o9rAnxv2hXuyzN7Gk6Ra4siVRVRshvw5QYE70sMJDZGan0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jMdjhv9y; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jMdjhv9y"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EoKSJ3066183;
	Thu, 6 Aug 2026 09:17:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=DNMdbz4PMzDW9TLFVn/ThzX
	5y33s0P0gHsbJNlFivug=; b=jMdjhv9y5bXK/VgVIDTHyaQ8Ab5Ey7DaKBoWClZ
	uenM1/PccxaE96pex+nVt/8ILdK5ojKjrsqNQm3uVZEx3j+gcU0xkeNGMMPbmdHR
	zToXQiwipQC/LfqxN5OV7+/RRHP4LzKE82deU159oxxtC4ziYWdVSIBQPSfWD5e+
	mUxXKC7eLW9DZbI0dMLn9V6Gts8Zn70Ak48OuMgpJduSdZ+2q5ISnHNfbLbn5AHc
	EC4lY8MDeO4Otmb4mxn3Th6s1ZPJpvYBJNWkfljCVXrAq6d57J718BTc/sN0cGut
	+Zt9FXCBa+ryzM9GPBBSjVa/vN0s6FB6iqxBIUfG9fS4Sgw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fvthdh1q9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 09:17:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 6 Aug 2026 09:16:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 6 Aug 2026 09:16:58 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 8093E3F7041;
	Thu,  6 Aug 2026 09:16:53 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Harman Kalra <hkalra@marvell.com>, Nitin Shetty J <nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran
	<richardcochran@gmail.com>
Subject: [PATCH net-next] octeontx2-af: return tsc value along with PTP clock
Date: Thu, 6 Aug 2026 21:46:48 +0530
Message-ID: <20260806161649.2592484-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jHXbMW8pA9e-pwGtUen-xyqgHoSuHeLf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX0M/kpDaJdTbW
 QAlwJQ3ghRYY0/x1cV3NXS6qJ+aa166xp1rq+nGzC1f/r577Gpsne3Z8rQqJ7wty8g2vMErq4rr
 N5x1g7sD563sHV0Vrunx1RKOY5Cxr2o=
X-Authority-Analysis: v=2.4 cv=Xaq5Co55 c=1 sm=1 tr=0 ts=6a74b388 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=rhI_ECBHSXAXZzQ6RNAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: jHXbMW8pA9e-pwGtUen-xyqgHoSuHeLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX5BoxZNV/eRRu
 smutxHb8NyNvtWaqRS0VSaty0TmegaNSgtBkp7AQzudN7NS7IMGMnKUZkYtQzTGG/P9PdAgY8OP
 p8qDpyWX8u9ReQRePcSNmA9W3GcQNhlz9D/98fz/w1wyDuGcwkKtonHakG94tmVYou3C3Exjavu
 BCqEvY3tA09LRZPdaqkSyU17FpOmOeIhyxZRQVnLAzQRcYcIZ7LmEoYU3POPWCUFKfrZ0VKRDAv
 HN40yusPFZsTfWCpp1BrYVdHmkhVlTDq6/pfuEKBxg43tHEiEXYZWkEFMKXIIqyv+dmzfPJdmep
 zRo/P6NtBqocFt0pUzU4iC7IAV9Gnyl2GVJ43KTR6xRMuK1p8gy7MNA05OrOAVFdKXW7Tv9xFG+
 1MS8K+YCUg3hr6vuKpo5lieoPpZuyGmQdMiSW2Vqahx+I07IAzJt8dRItq72YvDi825USkAlsmH
 a2OpTWFRNUocyOwTH6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01

From: Harman Kalra <hkalra@marvell.com>

This patch updates the existing PTP_OP_GET_CLOCK mbox message to
return the timestamp counter value, tsc (cntvct_el0 or pmccntr_el0)
along with the PTP HI clock value.

In some debugging scenarios, a user might need to read the PTP HI
clock value in the fastpath to know how many ticks have been spent
since the reception of the packet (as the packet reception tick value
is already appended to the packet by CGX). If the PTP_OP_GET_CLOCK
mbox message is sent every time the user wants to record the PTP HI
clock value, it will bring down performance to a great extent as mbox
communication is a very expensive process.

To handle this, the PTP HI clock can be derived from the timestamp
counter (tsc, which could be running at 100MHz or system freq) using
two parameters: freq multiplier (ratio of frequencies of PTP HI clock
and tsc) and clock delta (by how much tsc is lagging from PTP HI
clock).

By returning both the PTP_HI value and the tsc value simultaneously
via PTP_OP_GET_CLOCK, the consumer can calculate these parameters
without being affected by mbox propagation delay:
     freq_mult = (freq of PTP HI clock) / (freq of tsc counter)
     clk_delta = (PTP_HI clock value / freq_mult) - (tsc val)

Now, whenever the user wants to know the PTP HI clock in the fastpath,
it can be derived from the local tsc counter:
     PTP_HI val = (tsc value + clk_delta) * freq_mult

Signed-off-by: Harman Kalra <hkalra@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/ptp.c   | 26 ++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 73f743e4a83d..21c3d3d5018e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -2010,6 +2010,7 @@ struct ptp_req {
 	struct mbox_msghdr hdr;
 	u8 op;
 	s64 scaled_ppm;
+	u8 is_pmu;
 	u64 thresh;
 	u64 period;
 	int pps_on;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index 58e62e955554..0b66a86246b6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -356,10 +356,27 @@ static int ptp_adjfine(struct ptp *ptp, long scaled_ppm)
 	return 0;
 }
 
-static int ptp_get_clock(struct ptp *ptp, u64 *clk)
+static inline u64 get_tsc(bool is_pmu)
 {
-	/* Return the current PTP clock */
-	*clk = ptp->read_ptp_tstmp(ptp);
+#if defined(CONFIG_ARM64)
+	return is_pmu ? read_sysreg(pmccntr_el0) : read_sysreg(cntvct_el0);
+#else
+	return 0;
+#endif
+}
+
+static int ptp_get_clock(struct ptp *ptp, bool is_pmu, u64 *clk, u64 *tsc)
+{
+	u64 end, start;
+	u8 retries = 0;
+
+	do {
+		start = get_tsc(0);
+		*tsc = get_tsc(is_pmu);
+		*clk = ptp->read_ptp_tstmp(ptp);
+		end = get_tsc(0);
+		retries++;
+	} while (((end - start) > 50) && retries < 5);
 
 	return 0;
 }
@@ -636,7 +653,8 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct ptp_req *req,
 		err = ptp_adjfine(rvu->ptp, req->scaled_ppm);
 		break;
 	case PTP_OP_GET_CLOCK:
-		err = ptp_get_clock(rvu->ptp, &rsp->clk);
+		err = ptp_get_clock(rvu->ptp, req->is_pmu, &rsp->clk,
+				    &rsp->tsc);
 		break;
 	case PTP_OP_GET_TSTMP:
 		err = ptp_get_tstmp(rvu->ptp, &rsp->clk);
-- 
2.48.1

