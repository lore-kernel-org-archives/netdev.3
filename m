Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485958;
	b=IzFiRuTsRD73f7MtDC4Ow6nVY+rqz55DwkZNnQB33tAvUaAI32VcxT3392Zf+Z/pXQhu
	 BtPjLSujMwS4wqOKMoxfUoPDyIoXQ7nLveEIk5szU2fC80XdyWnblgDsgyZBCoG1kNAbL
	 AINKOdpyzRvqKqWPAZ7QstfQrdqAclB6SUA/p6qSZGALcY7hqA+n3ZmTzsOVucQgqAIrI
	 Nw4Qs2T1SEjQfNVQ96A8bQgrOT9HnTW1FxxWZofLo+JtRD7zxsBMDRgcyqWbSVwaIc+q8
	 ngtduGuAnM+/get0Sru8huwwFwnY+aeXNkwfLqxJnUQHPpXtB9ng/UvC3w1O6UseqJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485958;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=QZk03uKyCPRUhuK7+e1NdJhunuSpIM7RD1mNR5GIZ04=;
	b=EOC9OOtX/X2aYWBfm8vT2dtcKnIIb8UNhpCmCHegVqarf9O7APxCitRBkFVUlpbyjrSo
	 163ZdCEpYfOB3WCwER8Q3F4Bffs7N/vzYEe6R0/vrjU95YBrFWRCR6hXcwn9slgeMe6ur
	 XvACaGYOyZd0kbEQB7WHMshMjGvPpe2sL0k+exPQx6F2l9LKWx2nJNr30slFph+obroqv
	 CQ528tzYHNxjoIk4jl26otxpzexhY7fewHQGydqoOFe/WXKcI4o8qztcxNLwRrx7NUNkj
	 l/8gew2QGEQ4+Y3OMnuT6YnYMVRzOg6vG1z6qO56/qtnQQiwICgOqcVfs+RiIHSdq6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=a2io9LQh;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD90606A321;
	Thu, 12 Nov 2026 12:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD90606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=a2io9LQh
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC7Pl3v121862;
	Thu, 12 Nov 2026 04:19:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=QZk03uKyCPRUhuK7+e1NdJh
	unuSpIM7RD1mNR5GIZ04=; b=a2io9LQhgoc2/aXhYruzN8c9yZr1+B+9rwhYBEh
	IYVFt+SHlZJmkxZKC0w5UANAswNsC3JsdNCkoBEXxY6LFeXaNKd/X+cVf44dzdpG
	2kv4N/5bCHzUwqX3zpObFNnV1MT9L+80RF1J/EY296qCh61LXhiZFktxlo4jQYmi
	UmvqyBDFO3vAjqD3Tj4B/XuZJoGon3Z2OEDfUezsODbuuHaoWq+hgL8Vh4U3d6LB
	mFSClcGaebNxO6UigxyNYJ58fstapvkQz5aNIJxPQSve682CY7GNzw974P6RJPHL
	EC/qDa9v4DRBWFhz2k7omNXNoW0txzrczBmMk9lyaOaHTAw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hw92913nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 04:19:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Nov 2026 04:19:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 12 Nov 2026 04:19:07 -0800
Received: from sjc4ccscust-vm07.sclab.marvell.com (unknown [10.110.24.160])
	by maili.marvell.com (Postfix) with ESMTP id 52CA53F708E;
	Thu, 12 Nov 2026 04:19:10 -0800 (PST)
From: kmahammadraf <kmahammadraf@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Satha Rao
	<skoteshwar@marvell.com>,
        kmahammadraf <kmahammadraf@marvell.com>
Subject: [PATCH net v2] octeontx2-af: fix TX scheduler queue index width for CN20K
Date: Thu, 12 Nov 2026 12:19:07 +0000
Message-ID: <20261112121907.2576520-1-kmahammadraf@marvell.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GsDXaU1C c=1 sm=1 tr=0 ts=6af5aebf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=TqQ25hKhOvP58c2vajwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX4rL2ORBkAnAh
 5OymMkQDkep/Eto/5kLzM83SbvevICaa/l5JzasHY0NfpoVV2NCjuWPtcUAU9PxXX6zjwE77Z3/
 N8ArGc+JYEyFD7o2z+EzPJg08ACaiGw=
X-Proofpoint-GUID: HqYVf-V2T1O2mvTIoaoTSxP5Pb-xIN4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX2f+z0BpjVEv6
 z5Eo4yoZJqjfsRkhUN3LY7EOh/1Cxn4YDreZIancepa9wIhoJK389a6D4NTlTMx0CPr/6H0HG2U
 mz3CpJ4jc8ooz+0+muaQ2wIlkxwEBXDUFl72l+K3iv8s7I74Lrse41eM2tu1CcZo3aVnvqfvrML
 YJ+FOhHigVUry069YeeBci0h8M4rw3hK+P+TCtIqaScKBjTj18CZpa4cOS2AEOSpbLwBc3o1PZs
 G7iHt8JICohNK/mpuxaVM5frI52kGz3sc123UCoszw4m86AeyzycKnYGIJRqWzXeAmLLzIHafUt
 xqmMDX6Dt/ChLdh6lSEX2GjnGdnvDvXgzjLyhMW6EQQYP75E0RHq4fkV4enpqt2atpc2lrz+oD0
 Gs0CrsyO2uJqatmsgGsixVNzlV0jNiaChlkvg34YB1EkCsQ//CAaV0Jy13BCC3oTAaiN/96G/9m
 LS5u9ZnxKPMZHqxlMGg==
X-Proofpoint-ORIG-GUID: HqYVf-V2T1O2mvTIoaoTSxP5Pb-xIN4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01

From: Satha Rao <skoteshwar@marvell.com>

CN20K supports up to 2K TX scheduler queues per layer, so scheduler queue
index handling must use 11 bits.

Update TX scheduler queue index handling in both register-address decoding
and hierarchy parent validation paths. Also widen TX scheduler register
masking used by mailbox/config register access.

Without this, queue IDs above 1023 can be truncated on CN20K, which can
cause invalid hierarchy validation and incorrect TX scheduler register
access for higher queue indices.

Fixes: b279bbb3314e ("octeontx2-af: NIX Tx scheduler queue config support")
Fixes: d06411632e80 ("octeontx2-af: enable tx shaping feature for 96xx C0")

Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
v2: https://lore.kernel.org/netdev/179264357442.3290.13030103983603784553@kernel.org/
	- Fix parent scheduler index decoding in hierarchy validation for CN20K.
	- Add Fixes tags for the affected TX scheduler index/mask paths.
	- Correct commit subject formatting (remove nested "Subject: [PATCH]" text).
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h    | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cece197d1074..1b62f9d7f00a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1164,7 +1164,7 @@ struct nix_txschq_config {
 	u8 lvl;	/* SMQ/MDQ/TL4/TL3/TL2/TL1 */
 	u8 read;
 #define TXSCHQ_IDX_SHIFT	16
-#define TXSCHQ_IDX_MASK		(BIT_ULL(10) - 1)
+#define TXSCHQ_IDX_MASK		(BIT_ULL(11) - 1)
 #define TXSCHQ_IDX(reg, shift)	(((reg) >> (shift)) & TXSCHQ_IDX_MASK)
 	u8 num_regs;
 #define MAX_REGS_PER_MBOX_MSG	20
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 29559db68929..72d13d34829d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2755,7 +2755,7 @@ static bool is_txschq_hierarchy_valid(struct rvu *rvu, u16 pcifunc, int blkaddr,
 	if (!is_valid_txschq(rvu, blkaddr, lvl, pcifunc, schq))
 		return false;
 
-	parent = (regval >> 16) & 0x1FF;
+	parent = (regval >> 16) & (is_cn20k(rvu->pdev) ? 0x7FF : 0x1FF);
 	/* Validate MDQ's TL4 parent */
 	if (regbase == NIX_AF_MDQX_PARENT(0) &&
 	    !is_valid_txschq(rvu, blkaddr, NIX_TXSCH_LVL_TL4, pcifunc, parent))
@@ -2849,9 +2849,9 @@ static void nix_tl1_default_cfg(struct rvu *rvu, struct nix_hw *nix_hw,
 }
 
 /* Register offset - [15:0]
- * Scheduler Queue number - [25:16]
+ * Scheduler Queue number - [26:16]
  */
-#define NIX_TX_SCHQ_MASK	GENMASK_ULL(25, 0)
+#define NIX_TX_SCHQ_MASK	GENMASK_ULL(26, 0)
 
 static int nix_txschq_cfg_read(struct rvu *rvu, struct nix_hw *nix_hw,
 			       int blkaddr, struct nix_txschq_config *req,
-- 
2.25.1

