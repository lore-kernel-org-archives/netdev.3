Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5723C8AE;
	Thu, 20 Aug 2026 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202235; cv=none; b=ogcyWf8hS4wKkuSkF4att+42SfRWavGZ4oYvukKYd5+yUNDe3SzcUiWyvqDJndt9Ci7oDb5GBevdzXejW+A6Tf5GABk2C312xHjIm80BA5gnz/gXZY8aH623QXaM7BektorYtKO8Gvbl5gKetE0pbQuC5tVV0Clbj6pn4CmUypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202235; c=relaxed/simple;
	bh=Eyo7H8cc+Dmb/2qqu5yYwbDBBg4mcTWj3H0ujvDv8OE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BN2UvD09C3io2cJbmWbgf8lxiMTPkNI551ss9p59aiG1yPscqoVRPbUjEqh3cXPglKncagRHmldnXso9Emxzr6QuGJ48TIsrFGYhxVJan8wXVVcT9S9OdyvHcmqOnaT9JAxXBuHl+dhsnA04lm0F5Z1MMtcHJcFDr2k4ekPf/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kEn03DGx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kEn03DGx"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JM8HcE211492;
	Wed, 19 Aug 2026 22:03:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=rQgyR7dTxAvHkWkEg/1ofuj
	aXk4N5qwDtcT5DYchkWM=; b=kEn03DGxZKTKSfR+8HCBATz65kDlPtC5r/WKaLk
	SEyU87+ORRzonjCAQ0+Kk/RweTqCCTTHFfPYHJ7J1/k+1mAfA3f+KkqhgnBOwZ4N
	OW9hiKK6bhnwUZdls9hNPEyzGlKdy8j5qmKb1XPqAs0Tko7vxARa2aXDdv2C7uPd
	pg0tFf8dRQSP6Q9bavXRbwcBd7h9v8JCWsLsocYAoW7Lb/ex1YVyM5LFB1hZycyr
	oLh51ImAhKLKT8rd1PQK2vsqLVzrUJ22VXeAF0ndkHbjkoqDTuIV6DdMqZ+St9qq
	srnebN2K1z3rYbG2oaqx98EFMELOwqHroKFNtvvXO9mngTw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g5bbauy0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 22:03:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Aug 2026 22:03:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Aug 2026 22:03:43 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C34293F7051;
	Wed, 19 Aug 2026 22:03:39 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <agaur@marvell.com>, <davem@davemloft.net>, <horms@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <wojciech.drewek@intel.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: fix NULL deref in NIX TM tree debugfs read path
Date: Thu, 20 Aug 2026 10:33:33 +0530
Message-ID: <20260820050333.2606095-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAzNCBTYWx0ZWRfX6VqW53ZnyXS9
 95Jum8ZWJiAptjwOINE4Dj0Abu/yAofrcSfPX98GfkdqjFcoXb99W4VoNan8HVePss2t2VIL0Dy
 exqBidAQuSbI2gSm0ND0tyOzvWith900I89XmYsoRAIhn4Mr28CVR3STmQTPYb+YYxJyOzVOTMR
 r5j0GqrtobXtqDpO0ijGjpfZjtNhaiDStzAQbeCl0FLki50jIuux4VvbUXSrLhAsphV9VT4/K9z
 jOqtEmFt7Ge9G7xKJ+YF02LMsDEFUoGk8ViL5GTLT8YHGXFurc/xeb5LKobuM2r2tCxVLCHq3At
 YMt3KM/PVN+rTGefeK2QIoznvpv11kbO+gwTIFMWJwciTKYh32oZ/+9PjKyD9fwQNXSuB6Yqn6e
 A7oZ2LdX5hEN7NWSTzB/vLr4FdgDXaPNRHsWO6olmNoICdn+FuFtzaUAUZ9PcSxijcptgi5jNtu
 qLMiESxpXi7zOEW/hTg==
X-Proofpoint-GUID: XnVKlFNu0C15rwI0daoNmgSwxB35PYH8
X-Proofpoint-ORIG-GUID: XnVKlFNu0C15rwI0daoNmgSwxB35PYH8
X-Authority-Analysis: v=2.4 cv=COYamxrD c=1 sm=1 tr=0 ts=6a868ab0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=pyQZY_hvSu-EqxGpny4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAzNCBTYWx0ZWRfX4dIkE5QeYeOD
 TzwWt62L5kqNsMHnfgVBUXbyTqLE/DDB1ZRxEAoH8jU9vY1ZzPdBtNTT9IoIyZUkmuKVYSuFBnR
 ilXz8uhSLQ6AL74q46CSFwl024tbKfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

From: Anshumali Gaur <agaur@marvell.com>

rvu_dbg_nix_tm_tree_display() dereferences pfvf->sq_ctx without
checking whether the SQ context has been allocated. Reading
/sys/kernel/debug/octeontx2/nix/tm_tree for a NIX LF whose transmit
queues are not set up triggers a kernel oops.

Guard the read path the same way rvu_dbg_nix_tm_tree_write() already
does and return -EINVAL with a seq_file message when sq_ctx is NULL.

Fixes: b907194a5d5b ("octeontx2-af: Add debugfs support to dump NIX TM topology")
Signed-off-by: Anshumali Gaur <agaur@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3456313d3b3c..22ee99676879 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -1697,6 +1697,12 @@ static int rvu_dbg_nix_tm_tree_display(struct seq_file *m, void *unused)
 		return -EINVAL;
 
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+	if (!pfvf->sq_ctx) {
+		seq_printf(m, "SQ context is not initialized for pcifunc 0x%x\n", pcifunc);
+		return -EINVAL;
+	}
+
 	max_id = pfvf->sq_ctx->qsize;
 
 	memset(&aq_req, 0, sizeof(struct nix_aq_enq_req));
-- 
2.43.0

