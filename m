Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053873ABD83;
	Fri, 28 Aug 2026 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909904; cv=none; b=IT0IKNw6EBvkgE3eBvzyd1OHn0jNpqKyg0LZW43epCX89ng/bTjPFObYf8oH1MCwvEQ8FOBQ0RcNf+53O1REjc97B6g8quY6XHj6MnWHQmyAOvB4Uskqgy8w307fxLRso5zXSqkJhqxXdKMmQGMQl8yyQxWsoVDar4JYk4uZiEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909904; c=relaxed/simple;
	bh=sFPfepcxPZvl74G8ef9OP/hhpD1y/qErmkaLHo7O0ps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sbcfxqKzjlWJsmGJdmZGcjQIsNbRtLi+q8bjCB+U6XKSjs4Zq68cbT0mDYZG1juHhBU67c7PbEevbrIbO5pqvB08QqR8YJQVq+Q8ZpQM3TTjDYHQAS637N3fZlXHQ51rl5MGYkef4Yytg5xYcZlTaQxbgRJAjFeoNiAZLgCmxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HGq3rt2q; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HGq3rt2q"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S68uuW1333975;
	Fri, 28 Aug 2026 02:19:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=rWjUJdM0+PMAjtfnnD7f/6I
	zWPBGOTtq9uq9AybHbak=; b=HGq3rt2qJZy5iZQYkA8HK6O4MNswHjo6prJpdW/
	hgtKilwKNC1KcMRYRfHBN2orGjAfmWNp6pFjG/+6SWL3eJ9gFio2Z8o9gZcVwYCe
	fXrirbAWUni2eljlGAm1o5KI8j+pmo/Jv/UgYwot2anO2Q/pSk9/66Scck3504BW
	mh6GnwdHHOR1MXwPjdBCr+fwozsCW9H70MA0KkHwPdpsBuDUxufvHq2ooAS8qU2n
	5NPaUUUx9+aB6gNpsSbVvcytTJjLGvZo2ZiZz+O46ByzJ1BYehm3D4+4TjLsfjt3
	ccuoLMo4rfj7zYsoOj8L7OWq67dk97pC8pBUmo+fMZDU6Tg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gaww41qjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 02:19:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 28 Aug 2026 02:19:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 28 Aug 2026 02:19:52 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id A8AD53F707A;
	Fri, 28 Aug 2026 02:19:48 -0700 (PDT)
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
Subject: [PATCH net v2] octeontx2-af: Fix limiting SRIOV VF count logic
Date: Fri, 28 Aug 2026 14:49:45 +0530
Message-ID: <20260828091945.683722-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA3OSBTYWx0ZWRfX5UxsOArbd/4I
 GSkEx+1rIUaoZlVTYwtx8XDQb/HGMCLHdKdEvPC9DVQyVV7QuGAPigL3cYEvF0FpZgaH8JcXAIx
 RK82y+Gvy2X2FNv5tNsE5Irf5IDg9Nx9jODA1xnmP01azKRLlqKzQzYfONdjDHH8R0g7tna+feS
 FaidaOAsDW8Iwp2xk4L3MIsnDXjrN8zhG3w/ltsiXovaq4onrG2oHwvxvAfMf1rDIRe14hErGUE
 5YIn4c4pduMuBgrIHplpvO3G+UXFiVJY26o1SPRNa0AdCXsNlUagOWOhxWlW+OMXUpF/NdM42ZN
 Pd1pmm0CYaT0oLv8c0wL/8LfCSQoQpmrM9+iuDMub/FDmzahuzcAJGdlYU8LnLO2XAcWv0Lc5mO
 EROsG2Vk/xcf6PKUJB3ETc/VByIVqVzYWDbiOST0gi8iQMiT7Hus/A6/S2RZvKEiuWhIP1KTfVq
 i2QgL17brfdJFdEeffw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA3OSBTYWx0ZWRfX3IF3qkJ0fM+X
 PSxZlLYRfsySl/CxZ0ARyxM08LQuVtymC8bBJGmgeIBO4VoN3RKMzuJ/JzYftEZlmw7NHPOx8dR
 uq6Oe2b0+fYfGYtJW8JvhIVtS3K/0mE=
X-Authority-Analysis: v=2.4 cv=eOEjSnp1 c=1 sm=1 tr=0 ts=6a9152b9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=6kWvUkGnr9YHOatCuM0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Xftae-IciJOCH6yeqeoiqycIOgg45Rmm
X-Proofpoint-GUID: Xftae-IciJOCH6yeqeoiqycIOgg45Rmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01

From: Sunil Goutham <sgoutham@marvell.com>

When RVU PF0/AF's VFs are SDP instead of LBK, limiting the VF count
based on the LBK channel count is incorrect.

Apply LBK channel-based VF limits only when the VF device ID matches
the LBK RVU AFVF device.

Fixes: 9bd6caf33567 ("octeontx2-af: Enable sriov on AF to create VFs")
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
v2:
 - Use min() to simplify VF count capping
 - guard against negative vfs when chans < 2
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 74c041ab5280..937b085582b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3468,6 +3468,8 @@ int rvu_get_num_lbk_chans(void)
 	return ret;
 }
 
+#define PCI_DEVID_OCTEONTX2_RVU_AFVF	0xA0F8
+
 static int rvu_enable_sriov(struct rvu *rvu)
 {
 	struct pci_dev *pdev = rvu->pdev;
@@ -3486,24 +3488,27 @@ static int rvu_enable_sriov(struct rvu *rvu)
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
+		/* The last LBK channel is reserved for switching packets between
+		 * CGX mapped VFs. Also, since LBK VFs work in pairs, limit VF
+		 * count to available LBK channels minus 2.
+		 */
+		vfs = min(vfs, chans - 2);
+
+		if (vfs <= 0) {
+			dev_warn(&pdev->dev,
+				 "Skipping SRIOV enablement, not enough LBK channels available\n");
+			return 0;
+		}
+	}
 
 	/* Save VFs number for reference in VF interrupts handlers.
 	 * Since interrupts might start arriving during SRIOV enablement
-- 
2.48.1

