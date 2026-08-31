Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA73C0A0D;
	Mon, 31 Aug 2026 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158803; cv=none; b=PCVdiSjR9qYwc8dAccf3qAKm0BucIIkHIcpZnV+bkCwWzGNq/75+tj9CNswpJ4yvsqoE9GAOL/9SgLNCEQJa56g0yMKTkbXiKh6K6CY+2m1OrtYoYL4cF06ztY09zCUGEPHGJLviSlGTPVopNk25ltw2vUdcOoaEms/3rwW/tvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158803; c=relaxed/simple;
	bh=S65xMpGJL9bkVUyPMtjq9CbtZOcNsfYZY/7VKvy4As8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FwpCkEp+x4wISkhhEwDB1riF8TbMcZc1WEpjfwdnyrHy+RLFDkNVRSKiEMWrObFXsm62GUOwhEPlFWQ2ASWParemFVh92n2IiSQeMf1bK7uT0FkGzkJcesOflZfmeQoxLLkgVCesNITjpA4vtunrmNpsBB8t7u+F0lkRY4X8kxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JNH1su60; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JNH1su60"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52xln002500;
	Sun, 30 Aug 2026 23:46:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=xLOGzF+TNKwCOEMuFRXCUiK
	pdc/bkxrnbBY0jTOKxFM=; b=JNH1su60foSQHchUg6z+LZA8ia1ZpBw/uqt6cVH
	0Kv+vd0ibWF9xHnHRR84RF2Ro3SHzFPreMSqiOHfrK02puF8zmW+3UTelIslq7zA
	kSA8Ebtgt2747PVjjZlFun3/fAe3abASf0+aJn1hNqRUBNJ35M5aUIoVCP1t7pcw
	znxktTwoHHbVTMbqwl9JiSw3UnLaTVE+AVRZ1mBIaWbWtmCaMkQWZGLT122Lk8X8
	4qvok9xRCoAcHiAroHXr2Fxdm/r2nMDw4TPr9Irwm2VhMMkikmmhtlKQsgS/FVyT
	UpeD7G2M19d3JzA9RVtXFlcEXFD/HxzyjFDHRABZZOZTclg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gcg68htrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 23:46:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 30 Aug 2026 23:46:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 30 Aug 2026 23:46:19 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id A572C3F7221;
	Sun, 30 Aug 2026 23:26:06 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Naveen Mamindlapalli <naveenm@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2] octeontx2-pf: Add NIXLF error and poison interrupt handlers
Date: Mon, 31 Aug 2026 11:56:00 +0530
Message-ID: <20260831062600.839203-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SEpjrpEmtzmCrLOu8r5FL6mMru54U1TN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NiBTYWx0ZWRfX4XSP3igv1jRf
 9pWLnPmzla0YuCvastgdoCPYk0XU1Fn1OPz+jJmwZPl2ldlrEWghGJKLo9GPswj7C17sIcvdqE0
 2BAqAQwPNu/+LFs6b9uqimpLkH+c8HTZMlz0SSA5oPa/y7cUVcZke50pDKfk3wi9IaU+vuUt2uo
 OGowfOWSKKEs2+f2+n/69r8VyeZDDl1JPCzY/qLTErdlkz5urk6f88vGdXLATTDpu8OioAdPJWK
 EuMtu4jmmpOm4aPo1W4Y3NsoakRf35ALSl7YeH9RuMHqMFnp9RvPgkMiCb7TQax7mrTCPXs1Lox
 UDGB68n/U1f8rKwgUZQyrBSDE6ILkN5RxF1zlE3FTFsTB6BJlVPg4XcJ+JVmTg8xueySvOPCX7J
 Knsixazm4KswU7i63XRSIiyg/fUxbMmRMDeshKyEfaio2XtKLPVqalhVidxJHGyzCnxLb3qYxMk
 T58UqnLe3BlybTm9fsA==
X-Authority-Analysis: v=2.4 cv=fZedDUQF c=1 sm=1 tr=0 ts=6a95233d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ncu3KJG07k_EHxY4y7MA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: SEpjrpEmtzmCrLOu8r5FL6mMru54U1TN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NiBTYWx0ZWRfX9Ni6OxGvzRhT
 y3syJMhcxme5WJ2TCywcAYf0s5BN3ZPFHe1mov4GuOISOL+b0/2sgME/d+u/toKbCChgdi9+OcU
 gN23HwcP6RdXll7NX3qFGXLVngjeDF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01

From: Naveen Mamindlapalli <naveenm@marvell.com>

Register and handle the NIX LF error (NIX_LF_ERR_INT) and poison/RAS
(NIX_LF_RAS) interrupt vectors, The handlers acknowledge the interrupt
and log the status (ratelimited) to help debug NIX LF faults.

Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
---
Changes in v2:
- Clamp VF qcount to OTX2_MAX_CQ_CNT to fix MSIX vector budget underflow on >64 CPU systems.
- Skip ERR/POISON vector allocation for representors that don't register those handlers.
- Fix stale comment and typo in otx2_realloc_msix_vectors().
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 88 ++++++++++++++++++-
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  2 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  4 +-
 3 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c995f2900859..1f8cb78c1919 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1524,6 +1524,34 @@ irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
 }
 EXPORT_SYMBOL(otx2_cq_intr_handler);
 
+static irqreturn_t otx2_nixlf_err_intr_handler(int irq, void *data)
+{
+	struct otx2_nic *pf = data;
+	u64 regval;
+
+	/* Clear interrupt */
+	regval = otx2_read64(pf, NIX_LF_ERR_INT);
+	otx2_write64(pf, NIX_LF_ERR_INT, regval);
+
+	dev_err_ratelimited(pf->dev, "NIXLF Error Interrupt: 0x%llx\n", regval);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t otx2_nixlf_poison_intr_handler(int irq, void *data)
+{
+	struct otx2_nic *pf = data;
+	u64 regval;
+
+	/* Clear interrupt */
+	regval = otx2_read64(pf, NIX_LF_RAS);
+	otx2_write64(pf, NIX_LF_RAS, regval);
+
+	dev_err_ratelimited(pf->dev, "NIXLF Poison Interrupt: 0x%llx\n", regval);
+
+	return IRQ_HANDLED;
+}
+
 void otx2_disable_napi(struct otx2_nic *pf)
 {
 	struct otx2_qset *qset = &pf->qset;
@@ -2080,6 +2108,34 @@ int otx2_open(struct net_device *netdev)
 
 	otx2_set_cints_affinity(pf);
 
+	/* Register NIXLF error IRQ handler */
+	vec = pf->hw.nix_msixoff + NIX_LF_ERR_VEC;
+	irq_name = &pf->hw.irq_name[vec * NAME_SIZE];
+	snprintf(irq_name, NAME_SIZE, "%s-nixlf-err", pf->netdev->name);
+	err = request_irq(pci_irq_vector(pf->pdev, vec),
+			  otx2_nixlf_err_intr_handler, 0, irq_name, pf);
+	if (err) {
+		dev_err(pf->dev,
+			"RVUPF%d: IRQ registration failed for NIXLF ERR vector\n",
+			rvu_get_pf(pf->pdev, pf->pcifunc));
+		goto err_free_cints;
+	}
+	otx2_write64(pf, NIX_LF_ERR_INT_ENA_W1S, NIX_LF_ERR_INT_MASK);
+
+	/* Register NIXLF POISON interrupt handler */
+	vec = pf->hw.nix_msixoff + NIX_LF_POISON_VEC;
+	irq_name = &pf->hw.irq_name[vec * NAME_SIZE];
+	snprintf(irq_name, NAME_SIZE, "%s-nixlf-poison", pf->netdev->name);
+	err = request_irq(pci_irq_vector(pf->pdev, vec),
+			  otx2_nixlf_poison_intr_handler, 0, irq_name, pf);
+	if (err) {
+		dev_err(pf->dev,
+			"RVUPF%d: IRQ registration failed for NIXLF POISON vector\n",
+			rvu_get_pf(pf->pdev, pf->pcifunc));
+		goto err_free_errint;
+	}
+	otx2_write64(pf, NIX_LF_RAS_ENA_W1S, NIX_LF_RAS_MASK);
+
 	if (pf->flags & OTX2_FLAG_RX_VLAN_SUPPORT)
 		otx2_enable_rxvlan(pf, true);
 
@@ -2132,6 +2188,16 @@ int otx2_open(struct net_device *netdev)
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
 	pf->flags |= OTX2_FLAG_INTF_DOWN;
+	/* free NIXLF POISON irq */
+	vec = pci_irq_vector(pf->pdev,
+			     pf->hw.nix_msixoff + NIX_LF_POISON_VEC);
+	otx2_write64(pf, NIX_LF_RAS_ENA_W1C, NIX_LF_RAS_MASK);
+	free_irq(vec, pf);
+err_free_errint:
+	vec = pci_irq_vector(pf->pdev,
+			     pf->hw.nix_msixoff + NIX_LF_ERR_VEC);
+	otx2_write64(pf, NIX_LF_ERR_INT_ENA_W1C, NIX_LF_ERR_INT_MASK);
+	free_irq(vec, pf);
 err_free_cints:
 	otx2_free_cints(pf, qidx);
 	vec = pci_irq_vector(pf->pdev,
@@ -2171,6 +2237,18 @@ int otx2_stop(struct net_device *netdev)
 	/* Clear RSS enable flag */
 	pf->hw.rss_info.enable = false;
 
+	/* Cleanup NIXLF Poison IRQ */
+	vec = pci_irq_vector(pf->pdev,
+			     pf->hw.nix_msixoff + NIX_LF_POISON_VEC);
+	otx2_write64(pf, NIX_LF_RAS_ENA_W1C, NIX_LF_RAS_MASK);
+	free_irq(vec, pf);
+
+	/* Cleanup NIXLF Error IRQ */
+	vec = pci_irq_vector(pf->pdev,
+			     pf->hw.nix_msixoff + NIX_LF_ERR_VEC);
+	otx2_write64(pf, NIX_LF_ERR_INT_ENA_W1C, NIX_LF_ERR_INT_MASK);
+	free_irq(vec, pf);
+
 	/* Cleanup Queue IRQ */
 	vec = pci_irq_vector(pf->pdev,
 			     pf->hw.nix_msixoff + NIX_LF_QINT_VEC_START);
@@ -3006,11 +3084,15 @@ int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 	struct otx2_hw *hw = &pf->hw;
 	int num_vec, err;
 
-	/* NPA interrupts are inot registered, so alloc only
-	 * upto NIX vector offset.
+	/* Skip NPA vectors. Representors only use CINT vectors, so limit
+	 * the budget to that range. For PF/VF, allocate the full NIX LF
+	 * interrupt range (QINT, CINT, GINT, ERR and POISON vectors).
 	 */
 	num_vec = hw->nix_msixoff;
-	num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
+	if (pf->flags & OTX2_FLAG_REP_MODE_ENABLED)
+		num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
+	else
+		num_vec += NIX_LF_POISON_VEC + 1;
 
 	otx2_disable_mbox_intr(pf);
 	pci_free_irq_vectors(hw->pdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
index 1cd576fd09c5..c144fd2bbe51 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
@@ -121,10 +121,12 @@
 #define	NIX_LF_ERR_INT_W1S		(NIX_LFBASE | 0x228)
 #define	NIX_LF_ERR_INT_ENA_W1C		(NIX_LFBASE | 0x230)
 #define	NIX_LF_ERR_INT_ENA_W1S		(NIX_LFBASE | 0x238)
+#define	NIX_LF_ERR_INT_MASK		GENMASK_ULL(31, 0)
 #define	NIX_LF_RAS			(NIX_LFBASE | 0x240)
 #define	NIX_LF_RAS_W1S			(NIX_LFBASE | 0x248)
 #define	NIX_LF_RAS_ENA_W1C		(NIX_LFBASE | 0x250)
 #define	NIX_LF_RAS_ENA_W1S		(NIX_LFBASE | 0x258)
+#define	NIX_LF_RAS_MASK			GENMASK_ULL(10, 0)
 #define	NIX_LF_SQ_OP_ERR_DBG		(NIX_LFBASE | 0x260)
 #define	NIX_LF_MNQ_ERR_DBG		(NIX_LFBASE | 0x270)
 #define	NIX_LF_SEND_ERR_DBG		(NIX_LFBASE | 0x280)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index b022f52c6845..eda4ed52a8d8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -554,7 +554,7 @@ static int otx2vf_realloc_msix_vectors(struct otx2_nic *vf)
 	int num_vec, err;
 
 	num_vec = hw->nix_msixoff;
-	num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
+	num_vec += NIX_LF_POISON_VEC + 1;
 
 	otx2vf_disable_mbox_intr(vf);
 	pci_free_irq_vectors(hw->pdev);
@@ -597,7 +597,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 
-	qcount = num_online_cpus();
+	qcount = min_t(int, num_online_cpus(), OTX2_MAX_CQ_CNT);
 	qos_txqs = min_t(int, qcount, OTX2_QOS_MAX_LEAF_NODES);
 	netdev = alloc_etherdev_mqs(sizeof(*vf), qcount + qos_txqs, qcount);
 	if (!netdev)
-- 
2.48.1

