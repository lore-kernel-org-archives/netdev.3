Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66985459AD0;
	Thu, 10 Sep 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036899; cv=none; b=a6AkTO/MAtzKQda5G58exyQmAML8gY1Ci4+GuD94AgPszPBJFE+eJvhBhH/BJ0YRylAqUOK7SFGlDvu/1FLzKt3lBCVgIctjQtoUZ9QVyEOEaYWtT8cXnYETJokgL0xHSf3SoJEAgWeULvfyVMJ9MzxIt4zAzwlbogR1dr8jDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036899; c=relaxed/simple;
	bh=/skYv2yzHIxthX3aknMIMFqKrjldJ+Fkb54yK/1E1ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XXJ84FG/y0lfZtOonedBC5hC1wUXVNjmkzp1jtESZXatGuELm5FGTENT85LM/roQIoGdyjqMe1Vd3dEwTaKS9klwNjnLPVQLXXBXSB0ote7eR9XSbjb2TWQQlsyZQgb1tu1ta2xUVr5nkmk86XzPYq6SQZU6V0QMIgrtPJH5ViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2d5ca4bead0411f19a56ed5b684f684d-20260910
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
X-CID-O-INFO: VERSION:1.3.19,REQID:dc81be4c-e366-494c-b627-ee1c97b218b8,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:dc81be4c-e366-494c-b627-ee1c97b218b8,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:89fc20b376641820f1ece78b656561da,BulkI
	D:2609101841301J4GYU9S,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d5ca4bead0411f19a56ed5b684f684d-20260910
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 419294889; Thu, 10 Sep 2026 18:41:27 +0800
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
Subject: [PATCH net-next v2] octeontx2-af: consolidate RVU AFVF device id definitions
Date: Thu, 10 Sep 2026 18:41:02 +0800
Message-Id: <20260910104102.590989-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f695390ea639 ("octeontx2-af: Fix limiting SRIOV VF count logic")
added a local PCI_DEVID_OCTEONTX2_RVU_AFVF define in rvu.c, although
the same value was already defined twice elsewhere: as RVU_LBK_VF_DEVID
in af/rvu.h and as PCI_DEVID_OCTEONTX2_RVU_AFVF in nic/otx2_common.h.

Move the definition into the "PCI device IDs" block in af/rvu.h, rename
RVU_LBK_VF_DEVID to match the PCI_DEVID_* naming convention of its
peers, and drop the redundant copies in rvu.c and nic/otx2_common.h,
the latter already including <rvu.h> through the af include path.

No functional change.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Acked-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
Changes in v2:
- also drop the duplicate PCI_DEVID_OCTEONTX2_RVU_AFVF define in
  nic/otx2_common.h, which already includes <rvu.h>, so that all three
  definitions of this device id are consolidated into af/rvu.h
  (suggested by the Sashiko netdev review).

Link: https://lore.kernel.org/r/20260908094051.666769-1-yijiangshan@kylinos.cn

 drivers/net/ethernet/marvell/octeontx2/af/rvu.c          | 2 --
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h          | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..5850bc1870a1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -42,7 +42,6 @@
 /* PCI device IDs */
 #define PCI_DEVID_OCTEONTX2_RVU_PF              0xA063
 #define PCI_DEVID_OCTEONTX2_RVU_VF		0xA064
-#define PCI_DEVID_OCTEONTX2_RVU_AFVF		0xA0F8
 
 #define PCI_SUBSYS_DEVID_96XX_RVU_PFVF		0xB200
 #define PCI_SUBSYS_DEVID_CN10K_A_RVU_PFVF	0xB900
-- 
2.25.1

