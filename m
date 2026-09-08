Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4594CA77E;
	Tue,  8 Sep 2026 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860487; cv=none; b=IiYLePDMVzpSWJGOvJSOE1zmHAh5jQVZMZ4/hzoUfvJ0vct+6zvWjPklAQw0GRYpwQqnmgImaSGJ2upbw2TZz2y13WBqfPAxhd6gU+iBBX11eIsRGSWTuq5SpCJZyaqm1wPqKDwbRM6D67bhLPKrwuIRb9BRriIUAOhVQfEJ1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860487; c=relaxed/simple;
	bh=927i0POuteXLSBNVLgMU73J3Nczar0uXhikC4tx4xKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPjKJslGHUVGDpXmoov2ftLGJyK9PrSo9g/6osDQX1UqUab2MVn+ertNLcpuDK+zN6fdLz+NhQqq12eNSzH0Rhmyp7O+7FAAiXxguyCUOyLZMQ9V1U/pO/TqbCSFcRqiDUCEomn19vT6+3Qb1bZEmdAna43tSi6mAGPUdrJpBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 714da566ab6911f19a56ed5b684f684d-20260908
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b223f7a6-611b-4a2b-9651-2e2074a52760,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:b223f7a6-611b-4a2b-9651-2e2074a52760,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:4f6c2ac63aeba85c8c7c42e1d1963a5c,BulkI
	D:260908174120EI0IXWZC,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 714da566ab6911f19a56ed5b684f684d-20260908
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 894235165; Tue, 08 Sep 2026 17:41:18 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH net-next] octeontx2-af: consolidate RVU AFVF device id definitions
Date: Tue,  8 Sep 2026 17:40:51 +0800
Message-Id: <20260908094051.666769-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f695390ea639 ("octeontx2-af: Fix limiting SRIOV VF count logic")
added a local PCI_DEVID_OCTEONTX2_RVU_AFVF define in rvu.c, duplicating
RVU_LBK_VF_DEVID in rvu.h.  Move the definition into the "PCI device
IDs" block in rvu.h, rename RVU_LBK_VF_DEVID to match the PCI_DEVID_*
naming convention of its peers, and drop the local define.

No functional change.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 --
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 937b085582b5..65e08ad9d82e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3468,8 +3468,6 @@ int rvu_get_num_lbk_chans(void)
 	return ret;
 }
 
-#define PCI_DEVID_OCTEONTX2_RVU_AFVF	0xA0F8
-
 static int rvu_enable_sriov(struct rvu *rvu)
 {
 	struct pci_dev *pdev = rvu->pdev;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 094227404ef9..16846eeb793d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -22,6 +22,7 @@
 
 /* PCI device IDs */
 #define	PCI_DEVID_OCTEONTX2_RVU_AF		0xA065
+#define	PCI_DEVID_OCTEONTX2_RVU_AFVF		0xA0F8
 #define	PCI_DEVID_OCTEONTX2_LBK			0xA061
 
 /* Subsystem Device ID */
@@ -882,11 +883,10 @@ static inline bool is_rvu_supports_nix1(struct rvu *rvu)
 /* Function Prototypes
  * RVU
  */
-#define	RVU_LBK_VF_DEVID	0xA0F8
 static inline bool is_lbk_vf(struct rvu *rvu, u16 pcifunc)
 {
 	return (!(pcifunc & ~RVU_PFVF_FUNC_MASK) &&
-		(rvu->vf_devid == RVU_LBK_VF_DEVID));
+		(rvu->vf_devid == PCI_DEVID_OCTEONTX2_RVU_AFVF));
 }
 
 static inline bool is_vf(u16 pcifunc)
-- 
2.25.1

