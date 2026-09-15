Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA853DA7D9;
	Tue, 15 Sep 2026 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456865; cv=none; b=WBxKTOFmLv5lKbH0jdVpy6pAPWg7J0lZPuJiWyDjZ4X3R+fCD1FLcrue9/I5BgtO4k3jyCGlirwQ04yKzCrnZ6eAbz30AfUir6A6o3X3ciBPyvu6C/l9ZI8jVa6an9UA/W0i2FYlQLcC7FRNGRCsaWyvj1/7YnOBpXvjUJxURnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456865; c=relaxed/simple;
	bh=6sLIUpY6/HN0ulzCSwvb/ZZxDAhztGO3kWSTaZ/k6vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BIgaDSaD6lNNQomHsgOYTZet8Ap8dPefzRuh9hnT01U6oAVEpBBNo12MWAYs4uKly9EIvFiUwE1agL2AKswJUG2Qa2+SDW62S3jqFQlI2fLjrCY2kWOF2wNvdVvSq+/3daRAnCh4W39evvMf0ewAClEj0Wdvbqx7j9bI5bKU5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PLuiOC94; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PLuiOC94"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZED82654782;
	Tue, 15 Sep 2026 00:20:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=TilU520dq5fudPBSoTAepZn
	+2uehujDhyxMv0dTA3tc=; b=PLuiOC94UW9OkWhVDlF/6fbZDZh9zFhHFhXcMaR
	0n0XOj7SJfxn4kDeB/C+FNtBhmo+tq3KBcQCJ4F7Nnls7jXlWdX1fOTV5asAlTQ5
	qriwC985N/ZSbPDEg6m8nkX4/BeS+HjqGlql03PhDtsh00E5rCd8xpXNW0I/dbf4
	Rpnaw84fO3yIg1naGLXUBwHBV4qnl1O2ohPzqdG0YDF09vo2++WbC8Rt7lno/Js6
	s1BgNmbtYgu3osN50pFrmRbfpTIGxHMumEhrrF/gwJkbU1VQAHnIw3hMDjNQ7ZGQ
	CDnwgGOiqsvAM+CIhyJ65C1LaNUSxxXK7EtPZ/yf3xYUy0Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gpxufgk7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 00:20:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Sep 2026 00:20:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 15 Sep 2026 00:20:40 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DEF893F7063;
	Tue, 15 Sep 2026 00:20:36 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>, <horms@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: nix: Remove redundant BPID setup from block init
Date: Tue, 15 Sep 2026 12:50:29 +0530
Message-ID: <20260915072029.975824-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: q9ihqRT8dMFA2k1ncwfm23ixxz9BclKP
X-Proofpoint-GUID: q9ihqRT8dMFA2k1ncwfm23ixxz9BclKP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEwMyBTYWx0ZWRfX6gseD5M2Z+5R
 pbaC0JQ6NKf/733TiF7gqKI3tB6wY1zjefBp+fQQM75VzSDHNnN93oiKgFXejJP9Z8/O3sPhzjw
 LK1UeI9nZdToGoDzfhi/y2DxCcJjfQABfj+wmqxT3IUjfeEjhRPKWWMvTxqJsh3uUdxDVm0lWYy
 oKbLTTqsHeGHM8CEjL2J2oP5B98B18F08UHQ0Ggl7BHyGzAcRgLeNdsLhX9oyku5Pws4GgSo5/5
 DmtNDVRbzgcWfjS9j6ogIWcgKYeDz+PvtKvjCrixioWGvjYzGdJysjO25yDo0n+XycEiITsSF0a
 8/RhKTTLWkzqc9cx4NFTdb6m/HMQgVinu6GGIPpHgb2RZQCl+liIhWd8x9IMtX7tzf+D5S73eLi
 Y6tLQRtKuISd7dvpSR3k8FDIgH2w0ajDcvXysebf2hSPwf77J+f6a2Df16htd1HPbswhJMWNWhe
 XUWPVa7Yj5dM2YbTFJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEwMyBTYWx0ZWRfX5cgS3tMSs4Tp
 GxDvYaqUhlyFNYY6GH03SIpuJSYEdt6Br0epK4LuyrqKsdWqAnKhcljrjR7oigg7Safqu6m0+D1
 hZB2XPFa1zbH6uc2lMWaJPNleakxTEM=
X-Authority-Analysis: v=2.4 cv=Ir+L47/g c=1 sm=1 tr=0 ts=6aa8f1c9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=kkVuyRLWe3UCUnBsf88A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

BPID pools are allocated on demand through the mailbox interface.
Calling nix_setup_bpids() during NIX block initialization is
redundant and can interfere with the dynamic BPID free pool.

Fixes: d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..340b2c3d9efb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5077,10 +5077,6 @@ static int rvu_nix_block_init(struct rvu *rvu, struct nix_hw *nix_hw)
 		if (err)
 			return err;
 
-		err = nix_setup_bpids(rvu, nix_hw, blkaddr);
-		if (err)
-			return err;
-
 		/* Configure segmentation offload formats */
 		nix_setup_lso(rvu, nix_hw, blkaddr);
 
-- 
2.43.0

