Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F33803C7;
	Tue,  1 Sep 2026 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258323; cv=none; b=Os6+5sRNpgXk3EtZgfLbbusZyZjNMoA34sOMnOuEJw8SJQ8veaHiWthdDG0ZMduzydwpklyGsN9sWCQ4ymaCxrSMLAIANPgy6B1KF8X6KmN2JOrNYyeIlXrNDID7sKePZH1ybr9Impt8dyi5CMUVkwyJrg8UWidjczleecnDCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258323; c=relaxed/simple;
	bh=dpgQTcDFAntabKQEPWMXBkyxDsa/0xz/pF71/sI+/ys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azEplsxovHD+kHa9tTD1CYOLX7VQGKtK+x66lBnezEZMOQhwyzd49EQHik0YMyR79WtasMqm/G3oNHDEl6XcWVuhKYCH/hbaVUyKvDTWlCYqkjXBK7K7KUaf2X7IsJ9hX+Ps5WMDW7mUJVq7oABndln1nP7XHnEyCZUnzR9GzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZyrGbhdT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZyrGbhdT"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AKLXT3033126;
	Tue, 1 Sep 2026 03:25:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=shsVEbJ7R+9Q8yEbl+KCswJ
	0c2jlh9zRxu2kKEgXDoE=; b=ZyrGbhdTgykoM1zvKdUmK/31d9S9YE7HrY2ACCc
	dYNEPHm5x0ysXOa9+fa4iIvQdmQNXFhagVaqcCiH0cHtYgsOuChmkltUxyw3SBw4
	FQJsP87f5Rm3RcqxrqUl8cADbc+rnCBBZv3ZwM3V1US6aQzYp+JpbJDMyNmbBdE4
	mYhJoNwPWs+jilLJQwpD+pnnHvjGoVG3+pnYWx8Rdckw+dqO4RycGoq/WQJ6JV0+
	E0Hlpg7FJdVTg6P4CQudKvwgKRYlfhUgZPIAJNFhkdMxYJjM6MAr5BgnqrNvjCsf
	c2fSb/Jqi8uApgOLA9YlndHA7T2bMax/w8D7WdhOuhBuv5g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gdvpwg1g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 03:25:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Sep 2026 03:25:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 1 Sep 2026 03:25:07 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id BCDA55B6928;
	Tue,  1 Sep 2026 03:25:03 -0700 (PDT)
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
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] octeontx2-af: Fix BPID leak in nix_bp_enable()
Date: Tue, 1 Sep 2026 15:55:00 +0530
Message-ID: <20260901102500.1534911-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5MiBTYWx0ZWRfX/7uGCg6c/cTG
 Tjd8I5Z8JxhC4AZ6POcauIPDf55syMCUiYMV9G+4YPSc9joNV3kuDmzR6KEXJ4igrTYxXFuftSf
 ba/Mu0fYXHnEjDFSivwJPBj9jlkiPCY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5MiBTYWx0ZWRfX5Dn9Li16eyhT
 mJse3hSkFmPzT5vAyMFv7CXngWqLjXbS4x4GYzayAeB57UcCTMhHogTIXJrDW9yFcfNukiWtPCX
 Bt8WyLgMwQ4UIMsdmDXQFDCwIrov5NHw5cPcntlX1iqoCdKI2ejs7uROK4h6FHGxJ2IxSWFGx1u
 gOPK2mM0rJ72Xma5AcReKVF1GhSfeZJtkM2U3xR08yJMQO7p5ZIDR9sYypFcUEkKGz7tYcw6wRc
 wNUbuAnFWvS+odvT57Y3nXqN6NiekpiTlX9LaUBA4jdMIk7+uIKwhl9+0Qf8g5znu+I/6iSS94W
 npQMi7qJ8xOiDeuPI3KFTyMekIlB8fa5WOiQC64cZTqOv7x/QpiT6U6CGd0rl1Q4UsPOgJr13BG
 q6mZZNBlVkznSa1uCfxIZ2WPTR6tV/Ad1CqzKxQKNKkUlMNj4MWHFe8+PRw4//PI3EOrUnJ7Y7O
 lA7ofD6g7Sd+UdpM2QA==
X-Authority-Analysis: v=2.4 cv=brF8wkai c=1 sm=1 tr=0 ts=6a96a804 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=1oJNLSowvIMRzDzG_ikA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0mmI7mcS_6bs9PcDt566LJDQYMUzDvOH
X-Proofpoint-GUID: 0mmI7mcS_6bs9PcDt566LJDQYMUzDvOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Avoid calling rvu_nix_get_bpid() after the last channel is programmed.
For LBK interfaces, each call allocates a BPID, so the extra final call
can leak one BPID.

Fixes: 27150bc4286c ("octeontx2-af: Interface backpressure configuration")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index b81c47ea023b..c6164da4caa6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -784,7 +784,8 @@ static int nix_bp_enable(struct rvu *rvu,
 		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
 			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
 		chan_id++;
-		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
+		if (chan_id < req->chan_cnt)
+			bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
 	}
 
 	for (chan = 0; chan < req->chan_cnt; chan++) {
-- 
2.48.1

