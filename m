Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6194BB81D;
	Thu,  3 Sep 2026 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446405; cv=none; b=h4zoFvXaj8k3w7hLiLWYBI+TuK+MHvVOyfpTO6FnCKAYu4KFK9yOvdxaQ4ymdIwbig3HR3jxk+YfGryO2EJYya5GcXgeiTFILr0X1N1nqXoMcf2N/hac6aXq+OX5hYNJuHR7UKY2b8di6qRv9bj44bo7gxn56vAEBsRhjYeVaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446405; c=relaxed/simple;
	bh=xAk7yYw9wHlpOkMNFd+zn1jHV0oYDrRvbsThv1HC2rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yg57AEr2IZABWzuG5NwiyK7+ydcHY9KS6nAPz0gna6zCH7xuLKSqNp1+YUHzrD6GSRpo/Un3erjyVkjGHhdyzanzKlrDoc2nGSmQrvKRTKUI5JaKK15kQzmSGxM1Vms2cTfwOud9II1hS+xByih3ePoOw0dVoKX5AMpVXor62wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BTIc9hTy; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BTIc9hTy"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683D6c0V227832;
	Thu, 3 Sep 2026 07:39:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=sDc4adbets5AxfpSI5I3S5R
	9XJk2wufDTvrEe0jgql8=; b=BTIc9hTyYhHsLrm625jZr+C2qhxpINXTN45uC0s
	diIIhqIMuHBvoqxGF759RqyrZYiXH6XZM7FCAxp66TlvJ1sDXZinFAUT/Gstt7F7
	kXWqIYQJ5OqIngLPPOn20Fx9zjyUIzxxcPaSB0nn3WG2xpowUZLalouhQVcnXdDm
	Av+9UOxeVJ5kZr/mdOtzsiB2qAU9Q5hNuQw6oQ6hR2sy2g56Y8a2gbFf3FDfM/vl
	I0ZnaEtbp+z/iYur1x4iV/a6++cmAosZn+V7Tmcpr3/2BezeOj88NQMBW9slZhxF
	5kJoCvv+8z07rWZZp3Id5iLdwjSvQLvDqqS57DHQbApVwQw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gef5b539q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 07:39:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 07:39:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 07:39:48 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id A8BBB3F7052;
	Thu,  3 Sep 2026 07:39:44 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Geetha sowjanya <gakula@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] octeontx2-pf: fix invalid aura pointer free
Date: Thu, 3 Sep 2026 20:09:41 +0530
Message-ID: <20260903143941.2698880-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNyBTYWx0ZWRfX7tJv76KrnfJR
 FTo8z6Of6X2sA3XbGRZVCEp1xfKz2OrB/gjt/smNCdsCAbtf8j5Xs+jF+O5M3eKMGTd7GPMvzco
 3cXVjrO47lhufn7133n+g8UqseuRqGs3HP0nwuDnvLw6P4ZuXFfsrC+7P3gqNPcGr2FEv9STSN0
 K7BoCAbTpT/in9gsJ3SvfU8Sqt776Y3Bg2pVXbkIUpeDosUP3oQJStFVEBAWdyNK2jfJA9+5D4b
 d8fe8TE9QJlXCS5UEmCP+EX1758iG/h2bnUkF7YsUer9sfg11mTAQfWc0S5zVDwijmUoPUFDIEd
 ZuwT1AIraYisJ9cgki4MuJRY/jH9kwDTiDevPzCsIE/BsqXxz6qkuOy9IJ+InpkcLbanb8xAx5s
 CAV8AXFKDLRYYsumTDqpq50KnNseW8l5TaIXLP/eWRM3W2r3fcnrLV0y9f+WFjuACnUe+/Nfn/0
 S94RhPN8dGIaAujOl+g==
X-Proofpoint-GUID: A2JPyXzbd3xMIV1M3k_ezvsCLpLURsAE
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a9986b5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=4WQ1D3Iku-DGc2y9b3MA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: A2JPyXzbd3xMIV1M3k_ezvsCLpLURsAE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNyBTYWx0ZWRfX3Lb2PRjY573A
 bPe4sdebjReeecHWJ55B8S8xagWMHg0aITAEl9k8lNTOueGUWHV5Vw6yVLYxy+FEJ3lUx9V31dd
 s/5v2BPFgrNUDsJWuEZD9r+nMKovO2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01

From: Geetha sowjanya <gakula@marvell.com>

Do not free empty or uninitialized buffer addresses to the aura.
This avoids freeing bad pointers during receive buffer cleanup.

Fixes: ef6c8da71eaf ("octeontx2-pf: cn10K: Reserve LMTST lines per core")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..231fd8586b42 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -845,7 +845,7 @@ static inline void __cn10k_aura_freeptr(struct otx2_nic *pfvf, u64 aura,
 static inline void cn10k_aura_freeptr(void *dev, int aura, u64 buf)
 {
 	struct otx2_nic *pfvf = dev;
-	u64 ptrs[2];
+	u64 ptrs[2] = {0};
 
 	ptrs[1] = buf;
 	get_cpu();
-- 
2.48.1

