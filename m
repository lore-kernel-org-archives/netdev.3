Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB0411FB0;
	Thu, 24 Sep 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238111; cv=none; b=CNX2lInRLb6RXUmwy+INDvcNq2vs/JxVe0TEYlZ3PFvYHKuMsNN7SkcDGSvlknuY6tPM/jLeQC9pPlhjsaGS4xXzYcs2gso2UmIHcTP0q8fDNpCFLUr93SIoH1537qqoy5f1HFfKSVj4EjRmpms6wkiEVgV+5jMfX0d6I93vbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238111; c=relaxed/simple;
	bh=xGGn5F7O8CViwRoXOfN0Ai1sVBly8TVv9MIYxQ2a/h8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1RqdcHQ5oMM6AMC/0Jj2SJO6Kr85mlANXm+ox6kkLNGm6nr2riy1BWauNkVhQ+7g2Qw70pcGVR/GMb0qZsx1W1TJ3N01s72+Xjxetyi89HssvqXp5I/3iti06zYw3wuc7HkWPGcgW+RA/oXIWBHm9VRKua8OW4dqwtj+IvJMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZGwerb3v; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZGwerb3v"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eEst3974386;
	Thu, 24 Sep 2026 01:21:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Qy1hHJrKVfVdVbJyKoTwRa+
	M6OdPX+7JBQ+sgIiyphs=; b=ZGwerb3vWcrA5kAZ6Pii1DsJEpwD179hyICAcWn
	WucmWRumdwKCdcdr8yrKk5ev+k6Odni+PLVRqoRDg5QnpsSr7vlenRzR1deOdC6v
	pIBXV74/QDx3HU5p6ONN2vGDLq+9rdM2ku9sy98ro/hqsQC7Kh3FKRqSRT97h0Wj
	yCOesXHRZ9yOAKtNkXEvrBjHSjjYc206XnAIUtMcfSsNJfmcD2HDqbgQ3cjn4pe9
	gX8YJctQh8fqpFaRtQro8T3fNJTkri18a57n87dBtH9ichu2L3BAuQzKXsY/UclX
	5TlCyv1yCxnJWUlLFMOvoOW3KzKFv0KNFi0XcdsePvzHMzg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gvksntx0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 01:21:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 24 Sep 2026 01:21:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 24 Sep 2026 01:21:39 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 10A883F7051;
	Thu, 24 Sep 2026 01:21:35 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: fix partial NIX Tx scheduler queue allocation
Date: Thu, 24 Sep 2026 13:51:28 +0530
Message-ID: <20260924082128.1944674-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNCBTYWx0ZWRfX/wK1NXpom/Uw
 G7tqAid9Xg3/UIitDfCYZEZfTOePMpu+CU75+zEPgVfie6VEyHLdzd9+qRXdqgJ2obosDeoVIYD
 wkieXHQNcQSsYIOqY4O/kmEEmotEMwI=
X-Authority-Analysis: v=2.4 cv=fcI4WEQF c=1 sm=1 tr=0 ts=6ab4dd94 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=rHSzDqYvqVz94caIL9AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNCBTYWx0ZWRfX+z/HY24uV5po
 izIf48BTCWcx5ciMqWSDLzTmvYmdQQd1+q5iXVDyYfF4p5zlm9a5wiKnjHBlHfvBWd1xyqQA8dD
 8aZR282VQbJ5JsgNBTzjKAFPY9Yzia5OhCe2v4uK8K54H+ZDHn8/gFv51Osppu/3ej/h26Y9yPm
 hylHjsXjU3RJRSOoKJLbdW6Cce9JvRiil/XdElxr8k/uKlkz+HP+wfgoo1ESKUGWs1YxJPW3kbk
 Pqo2F9jhLDWHW1M/i6IZi1sdhQJxihZTPav3c0qmOKzdLWyiUx2TzyBk5fUi4HmMYinRdiVNp0Z
 fUKIsgbSdw86MMk/M1+GJ3qXhdzIR+0LT1YLr6ahv9+lekzoKG6sId7XHCjisqSBGaTyQO9ICEF
 SLvigt/oAXpl4CdTmUtSSOzJBb5f9uuD2NLAmcqi05Bc47NT0HTaXGWn+2BiwB5Qk27ibEoAtQ4
 YccQLDZcbVlL+H/MxDg==
X-Proofpoint-GUID: 5NvPiPMXVyDUl27eX1fYUT7fuYrMpx-l
X-Proofpoint-ORIG-GUID: 5NvPiPMXVyDUl27eX1fYUT7fuYrMpx-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01

nix_txsch_alloc() could return success after allocating fewer Tx
scheduler queues than requested, or after failing to allocate a
queue under the fixed topology mapping. Propagate allocation
failures to the mailbox handler and roll back any partially
allocated queue indices on error.

Fixes: 5d9b976d4480 ("octeontx2-af: Support fixed transmit scheduler topology")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..28e70bae51ca 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2195,12 +2195,14 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 	return 0;
 }
 
-static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
-			    struct nix_txsch_alloc_rsp *rsp,
-			    int lvl, int start, int end)
+static int nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
+			   struct nix_txsch_alloc_rsp *rsp,
+			   int lvl, int start, int end)
 {
+	int want_contig = rsp->schq_contig[lvl];
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = rsp->hdr.pcifunc;
+	int want = rsp->schq[lvl];
 	int idx, schq;
 
 	/* For traffic aggregating levels, queue alloc is based
@@ -2221,7 +2223,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 			rsp->schq[lvl] = 1;
 			rsp->schq_list[lvl][0] = start;
 		}
-		return;
+		return 0;
 	}
 
 	/* Adjust the queue request count if HW supports
@@ -2233,7 +2235,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 		if (idx >= (end - start) || test_bit(schq, txsch->schq.bmap)) {
 			rsp->schq_contig[lvl] = 0;
 			rsp->schq[lvl] = 0;
-			return;
+			return -ENOMEM;
 		}
 
 		if (rsp->schq_contig[lvl]) {
@@ -2246,7 +2248,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 			set_bit(schq, txsch->schq.bmap);
 			rsp->schq_list[lvl][0] = schq;
 		}
-		return;
+		return 0;
 	}
 
 	/* Allocate contiguous queue indices requesty first */
@@ -2277,6 +2279,22 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 		/* Update how many were allocated */
 		rsp->schq[lvl] = idx;
 	}
+
+	if ((want_contig && !rsp->schq_contig[lvl]) || (want && !rsp->schq[lvl]))
+		goto err;
+
+	return 0;
+
+err:
+	for (idx = 0; idx < rsp->schq_contig[lvl]; idx++)
+		clear_bit(rsp->schq_contig_list[lvl][idx], txsch->schq.bmap);
+
+	for (idx = 0; idx < rsp->schq[lvl]; idx++)
+		clear_bit(rsp->schq_list[lvl][idx], txsch->schq.bmap);
+
+	rsp->schq_contig[lvl] = 0;
+	rsp->schq[lvl] = 0;
+	return -ENOMEM;
 }
 
 int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
@@ -2335,7 +2353,8 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 			end = txsch->schq.max;
 		}
 
-		nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end);
+		if (nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end))
+			goto err;
 
 		/* Reset queue config */
 		for (idx = 0; idx < req->schq_contig[lvl]; idx++) {
-- 
2.43.0

