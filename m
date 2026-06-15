Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E6149C6F;
	Mon, 15 Jun 2026 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781492863; cv=none; b=YvzKyGgf5a1G7sgvnF0mhvjKPm2l5l9qgECFf7fJ7NqkpgJ3ZAsj9fdFtoYlmUkZzJeoZV/z7PKCZ6Ppmh+VempNJ3qBDTxu7+me+0IurA26RrzpMONOTOi9qlTA9budpUxTe0/Hn2lhF/CXJNKNATzbdr3u/R0MFLZctU50Ls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781492863; c=relaxed/simple;
	bh=8k55ly92V3t2xUQcy3Fi2ToUhLC16PV/sIavmy2naU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGKepUmGHwzvU8PzQWiW69a8yAHkekiMKYtfxWTO7KmFHQmkkpz6w1DXSWgDMwBVJ86dqgF4jKnMJcZqCw1OYJE/qhOIowIlMXi+bRzjn5uvGqKjEskJ7t2Z9ZYT+VmHjpEvA4Fy6JU6hOF2vDrUJOD1cq0uLu9MsZmAF5nNNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SgagreBk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SgagreBk"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1k8ji3712615;
	Sun, 14 Jun 2026 20:07:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=QupNVda2y4YSr4HKXjoEUzE
	XhWif1KFV8gSpTw3AlIw=; b=SgagreBkB/VekcNiULMnQ7WiZP2WSWDZNHZFTzZ
	yKllpwVnEYWLquPiiUiqov5BXi5wcccq4a9MrXQREdymbZiN9nGNExDJjSOn47cI
	DzdI4Eff17zE/D0v92gDwGRxCBofSt1MAY9wflFm664Lx4vCHVtnCht94LRFp5k4
	S/8UWuVVXReWB+DFGCD1lwK//hsoY4HctbKtbqrVzdmn9PnzsXckpktbSwpA6Jon
	pId/uIGQTD92wp9R8UavXQ1l6sxMYBTO1h/1O9mgXxAVf8RcrlGRsaaqnE7MMwc7
	o8u06FEuKqVMAzcAHofjgVvS4705S2rNqF9PJxniX57p9xg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jjwft2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 20:07:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 14 Jun 2026 20:07:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 14 Jun 2026 20:07:20 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C69553F7063;
	Sun, 14 Jun 2026 20:07:16 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <amakarov@marvell.com>, <davem@davemloft.net>,
        <jesse.brandeburg@intel.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <richardcochran@gmail.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-pf: Fix leak of SQ timestamp buffer on teardown
Date: Mon, 15 Jun 2026 08:37:04 +0530
Message-ID: <20260615030704.504536-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2EjEWW4BFoybW4IK-VBd3kgfKyh1fd1Y
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a2f6c69 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=MiCwuK_h0avDvia1oPkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDAyOSBTYWx0ZWRfX2EAGjTimw1TV
 SFZe6g6Z0TSX7+tJ8vm3bD/vvcRmZn5PK6HSAzZY/KuMV7+xhev1bNw2O2u/BQqziJOA0P/i56v
 PVNc9gfECbztZC1cmP2TQ2KQmeeCpLs=
X-Proofpoint-GUID: 2EjEWW4BFoybW4IK-VBd3kgfKyh1fd1Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDAyOSBTYWx0ZWRfX3s7XZ1ukobez
 hCQYC3sDCpVMy3go+63z1zgC3Bf2r+yhVGH1yESCw309QA2rfQ3EFRGRSmM88wmCH5T+QVm/ZT3
 p0sQgxCa76BKY9KAKou1aCG3V2828zNYWkiw4OGVIEj7iILshg9cwl3it1Rfzwpd7sHjY6pn/1/
 ZR5gEDTCNwiknr2ZHDVDQjdp0G/XXwTDZVivqI3lOG6Yb5VyUzm+81SSc+Pa0eMFcTojdYPPaeT
 /6Xild/97pi4xzAPhPaIxQGJeenV5KSQ3BZPFfU/+aObixR14D4QlL9E7cOsQbw0OjuLMyoRftR
 IDO/IXqqJm0VmmPO5A6EvWgDRao9sCE6GC1+AUxEXv6Ul484AMaBeiFgCbaHXF41LJthDhwPPGM
 mKoPTNh8+sPepXTmZNNOqS3PLxqWD51/zP0UgIoERVFDd4hAFqvXRCwptpKdVhSZ2Sk1sj/E5hz
 5j59gAJJowz9YbHsNbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01

The send-queue timestamp ring is allocated with qmem_alloc() when
timestamping is used, but otx2_free_sq_res() never freed sq->timestamps,
leaking that memory across ifdown and device removal.  Add the missing
qmem_free() alongside the other SQ companion buffers.

Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
Cc: Aleksey Makarov <amakarov@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f9fbf0c17648..0c2da974ac6d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1578,6 +1578,7 @@ static void otx2_free_sq_res(struct otx2_nic *pf)
 		qmem_free(pf->dev, sq->sqe_ring);
 		qmem_free(pf->dev, sq->cpt_resp);
 		qmem_free(pf->dev, sq->tso_hdrs);
+		qmem_free(pf->dev, sq->timestamps);
 		kfree(sq->sg);
 		kfree(sq->sqb_ptrs);
 	}
-- 
2.43.0

