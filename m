Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D32F5A2D;
	Fri, 21 Aug 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294738; cv=none; b=u4om0WGkxaMYvE9jypwkllKzvgPReW1ClgeiSpIHxM+1IEmqOO92PhdYUgJL6Xi15CIXt8SZbGmu4wKLyc1j74KBAotY7z6jc8ODRnYpXF0yuVaQR6Psa/mwjZdt29B3osbm+0Brl/AWzVJZ/iravr6BK5CDBFWv7lslHDnF11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294738; c=relaxed/simple;
	bh=LAMUa97cr7LDV+9NOCMF8uTd9ZqeFZrSFrVjPHXmo68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EhCUSNaldJTP+M3iWKCCwUZf8czwNZ7X5gX0JxxQ17gshWFOJ9oOl7h0MIpzQl6XvabdNE6Xz2VLFg0JRYprpRxTkbA1sgmuuT96UhNU2Mzu1L/kmhJ8rKnkXXDjEbVRq/a/0fJi+KDXDYVnwH2EucquN1hWrhYYsbIVyEdhANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lVt6+aP9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lVt6+aP9"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5WEPN3794737;
	Thu, 20 Aug 2026 23:45:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=wXqzbr5Vf9se/oFK7M/AhAM
	BZhbBUtAlGCGxg1Dnt9I=; b=lVt6+aP9gZmpHPvw9PujNqRidwvwVsG7bL4jpjV
	FIjB17hRth4hjWKP18S0w6Uf+G4xiW0AQzd8n35WRVCwAr9Zrbr+ckWwXpGT9Cwx
	UJcpV80eZoGvFnAW3LOC9WHR53H4tMa9FjY9tiq/+uDDqBzXYLKPjJFoGoX5gVh4
	F5xcuSvq2NT85AfmBZu8VPq0qJTPxV1tevkg9+CgMQvfi8SqJ1pb6f3YcpNtC3Yc
	uFvJwN5egI2a++d/a8KKY+6pC7bhdSk/gMttea1ILjsNR3CnrdyWUjROYy8ws/Pp
	zHydNJOl704iWWhCEWoWucuAxC2KA4aTvarHw0WDDDPfu9g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g6ccdrrdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 23:45:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Aug 2026 23:45:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Aug 2026 23:45:27 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 0069F3F7090;
	Thu, 20 Aug 2026 23:45:23 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        "Geetha
 sowjanya" <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH net] octeontx2-af: Fix limiting SRIOV VF count logic
Date: Fri, 21 Aug 2026 12:15:11 +0530
Message-ID: <20260821064512.2754110-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MkVJUDKPCv48Jhz42ZErpraNSoqBdOao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA0NyBTYWx0ZWRfX28AztCED0qTn
 0ONwvIrqM3Cc+nfe8psx/0MRpfJe2+05W43AtOm9v279cjODURwE8YOZggdY5Ss+Bl6reSEQL1D
 j3cG5qfZbnZ1U608ad0R0R8PeQCD1aMqcNwTt4Xd81SkCCZTTUXmf4/p5re8LLvRRU1T912Sf5H
 wiGYRGcZXn0Z0t3Knq1kIqF1YijMWcarKtIxbdugoUuknY0rPcwRI+Dv4WN48HNeeBW69n34m7G
 D8Uf0B7VWB7i3oxvbqjwR4kqGjTSbKjCwoN538kBQ54GLnPeO099viFA+rrC5GIgMdA1ncIk5Cg
 3cyfRjl2Z8w74otTc/0wWt3N5NNk6Bgn4H0XBlVJhL8CE2M0TamP2WfkKT8VHcX8Bi6ByO5Duvt
 qsTVZAE1WkXlVFuWg2+qv9Pj7mRPz7LnbMMC4hTn4+2hl4gCP1yx1DPq1uIebtCme/8F/6Hg8CT
 gpfs9qO5hPNq8JjDdzg==
X-Proofpoint-ORIG-GUID: MkVJUDKPCv48Jhz42ZErpraNSoqBdOao
X-Authority-Analysis: v=2.4 cv=Nu7htcdJ c=1 sm=1 tr=0 ts=6a87f408 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=sSXDUGxpSJfk9Fa9rzUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA0NyBTYWx0ZWRfXwn0n72ZsxDaX
 a+bEf0m/pHcZ1r03GcoBKr0tAIndYLA2NTaJdlwrSapDqO9j8TvzaRyD/7bLr/leTSZ7PkGlGJV
 lVUE9/puWspALCB39R6TkKxwEORKEgs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01

From: Sunil Goutham <sgoutham@marvell.com>

When RVU PF0/AF's VFs are SDP instead of LBK, limiting the VF count
based on the LBK channel count is incorrect.

Apply LBK channel-based VF limits only when the VF device ID matches
the LBK RVU AFVF device.

Fixes: 9bd6caf33567 ("octeontx2-af: Enable sriov on AF to create VFs")
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ffba56ee8a60..67a7766f000b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3463,6 +3463,8 @@ int rvu_get_num_lbk_chans(void)
 	return ret;
 }
 
+#define PCI_DEVID_OCTEONTX2_RVU_AFVF	0xA0F8
+
 static int rvu_enable_sriov(struct rvu *rvu)
 {
 	struct pci_dev *pdev = rvu->pdev;
@@ -3481,24 +3483,25 @@ static int rvu_enable_sriov(struct rvu *rvu)
 		return 0;
 	pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &rvu->vf_devid);
 
-	chans = rvu_get_num_lbk_chans();
-	if (chans < 0)
-		return chans;
-
 	vfs = pci_sriov_get_totalvfs(pdev);
-
-	/* Limit VFs in case we have more VFs than LBK channels available. */
-	if (vfs > chans)
-		vfs = chans;
-
 	if (!vfs)
 		return 0;
 
-	/* LBK channel number 63 is used for switching packets between
-	 * CGX mapped VFs. Hence limit LBK pairs till 62 only.
-	 */
-	if (vfs > 62)
-		vfs = 62;
+	if (rvu->vf_devid == PCI_DEVID_OCTEONTX2_RVU_AFVF) {
+		chans = rvu_get_num_lbk_chans();
+		if (chans < 0)
+			return chans;
+
+		/* Limit VFs in case VFs are more than LBK channels available */
+		if (vfs > chans)
+			vfs = chans;
+
+		/* LBK channel number 63 is used for switching packets between
+		 * CGX mapped VFs. Hence limit LBK pairs.
+		 */
+		if (vfs > (chans - 2))
+			vfs = chans - 2;
+	}
 
 	/* Save VFs number for reference in VF interrupts handlers.
 	 * Since interrupts might start arriving during SRIOV enablement
-- 
2.48.1

