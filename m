Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87936F8F2;
	Tue, 15 Sep 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439416; cv=none; b=ALwqcap1N5BN6I8FuI90Vro+O1cSSOC4goseWN8x6PrU9SuXuTbykcQTwe01ZzrXXXksdvnApIKpFkGzMqbCeSs/2oxqYS7+AZTbWxl7OgWIGCzqf6ZLiudnwtAHARQooAtS0A5EbDBjPKaQphHdPse0NBeukxQPhE3fgKjwCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439416; c=relaxed/simple;
	bh=bERjCxn5+FsIc6Y7Jy1KJhrcshoR7zpJpPxrxjEyeEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ifse7oWWp98w2B9kBdtVZl+3+cOyckEfY0s+1n2gt5UHAQ3WUmDsiiRXUH7s7gWW1q5H0XD6yueZatLitnMC1cB8kvr1p+TKGvvZIxPjjkGSkR4x1CaMUjDtmnRib8aQOwGOg7W4APRVEHyy+DgukixE6o/aFU9W4kgd29SyNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=B4QOgKNu; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B4QOgKNu"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EN0pvq1786075;
	Mon, 14 Sep 2026 19:30:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/HaKvD52nfL4NraRwnMP/uT
	UjD15wyUF/BzfrmeyxuA=; b=B4QOgKNucMC9JFTF2a0Dv/fRBYySq3DeYMdTaUI
	pO9vT4rPCTCBlPliiaEh0EN0TBRmAkRcb7isNARYKoFsu8nT8F3U1BG1W+q/tr+B
	5MY/BMEnI95Dxye0zttUksPub+39GevEXIj2uooHvmY2hpzcGwl351Fu2mIECEr/
	+rZBnBU5AlKk78OsZNZXVsZZ0GYdQW2ifn77pWFfeCUemAqlRgccCe0SAvsDdyzf
	FESLz1z82ICEKk0j+bvJfMZd08vFVOPagXpcDXlW/gKRFRadf2/6CzeTkre7SoTc
	y/NM9VQZktx8fACFG0laiT5Rf0XG1pYHG7aibp1PuARnYsQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gpm9fjt0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 19:30:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Sep 2026 19:30:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 14 Sep 2026 19:30:05 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 71B563F70BA;
	Mon, 14 Sep 2026 19:30:02 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>, <lcherian@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Sai Krishna <saikrishnag@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: guard is_pf_cgxmapped() when PF to CGX map is absent
Date: Tue, 15 Sep 2026 07:59:52 +0530
Message-ID: <20260915022952.886639-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VtS2kO2n c=1 sm=1 tr=0 ts=6aa8adae cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=CAlQT0vDR2ouoMAuf9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAzMiBTYWx0ZWRfX2P1hiholvBNH
 BrdwkFzsvnmrPyBRyzSWx5JUME5un3sI1E2bsManR8n3VFslUiXda+lLudY3JLirrpftragFqC3
 s5D7JDybd56DWhGPLpYnCQJSSUmL0l5Y1JjFJ4P/sNiDutbPBkzdiy+3fvAzokEuubousDRM/Jf
 e+klbB4aK0mMoO1Bz/74ollCIShlqTPDvwyDYILUQX2hFCJsJCut4JffyXblhPuepg/D5Dd0q/B
 V56mv/xvyVDVb0R4UfSExzRzWtGg31F7Bs4ryKnYtb19buim2zCDiD2r/lj91udiOQ0x/9uVKuZ
 CP0iSn7/ygXQzYP9F3qi+LE5lPPW3OU0cUs9Bgaoz1MuIZUYm2HyT/vpugGkLv34JA1nG/quOoY
 YOgPsXDbBCGlpbuAmrchV01M10Z2A8UXtthS54OwvXRqr417n8h5QwVlzakoubiTkDKH3BVDiPR
 6NDczqAh9g4wQkZhMKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAzMiBTYWx0ZWRfXy7hEJ32wlfPR
 HAb6R98LsmJBv3SnHLwogd+XZdCiBvmQVQIYLGt6VAYgLPAXd7KE6l6O94trLQW9JigaGSQX7Rl
 fBydNZ+ZnGs50mokQpw/HsLnoqB87B8=
X-Proofpoint-ORIG-GUID: 5bOc5-14j54S3Z4z_JYgn350ijVrMVnI
X-Proofpoint-GUID: 5bOc5-14j54S3Z4z_JYgn350ijVrMVnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01

From: Sai Krishna <saikrishnag@marvell.com>

pf2cgxlmac_map is allocated during CGX init to map RVU PFs to CGX
LMACs. When the bootloader does not provide RPM/firmware data, CGX
devices may be absent and the map is never allocated, leaving the
pointer NULL.

Several call paths use is_pf_cgxmapped() before indexing
pf2cgxlmac_map[], but the helper did not verify that the map exists.
Return false when pf2cgxlmac_map is NULL to avoid dereferencing it
in RPM-less configurations.

Fixes: 3a4fa841b039 ("octeontx2-af: Set RVU PFs to CGX LMACs mapping")
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 094227404ef9..1e0a5aeb3f57 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -970,6 +970,9 @@ static inline int rvu_get_pf(struct pci_dev *pdev, u16 pcifunc)
 /* CGX APIs */
 static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
 {
+	if (!rvu->pf2cgxlmac_map)
+		return false;
+
 	return (pf >= PF_CGXMAP_BASE && pf <= rvu->cgx_mapped_pfs) &&
 		!is_sdp_pf(rvu, rvu_make_pcifunc(rvu->pdev, pf, 0));
 }
-- 
2.43.0

