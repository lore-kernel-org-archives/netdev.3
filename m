Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DD30C14A;
	Wed, 12 Aug 2026 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550807; cv=none; b=kw9NQrbe5fcgntjj+By797fkdGuEp6jqBTLg48KDParjJ3GuAlcuzyMskTCebK4V4Jj8O5zPUGrcb4NEXmQcqhdIbJFxmuXTqSTXjHPor5tXwFT2RqoBYf0APShvG66k5/EEOy9E6y8Ui61u1RnGyB0fBow65Sz1qdEBc6fHLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550807; c=relaxed/simple;
	bh=FjRIs0zo/Kg90MRRkK33otsEN7zsR9TSjX9k04tBgPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uqcSj6XQEVzYkKTUQkO6TBQD0N6DyoTA8YZKeF/IAyKjRbrmp4Pm+KC2Z9py5hXco87dRbA6Dj9JpZVQMYcyDlgqBcZ/l/8MVPl1zqrps/dj1RRzpRXedHxKmSDJjTw00LcRo7y2DqHE1mBX5Y8+fuqTgfex4MhvdDYC9G2g154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZHdi/B/W; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZHdi/B/W"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDckgv2655505;
	Wed, 12 Aug 2026 09:06:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=qBJ/MKOLo4AIyDgzJJbzQFd
	4RHXXZJ4sFwZbtOhARG4=; b=ZHdi/B/WVZ5rvcTibQ/ipMcZBn80fLp08v5qSa7
	NYfNDSvxOSM33rLkjLwiXSQWHeJ3rK2VBtbZn26Jv6seQhA3uasAKPFoKCLpi4gJ
	GUXGjF3f56X93KCU7Ox5QYlsdM1rqt5sGuYP8YVtovBTtINxtIpqlzXoWUPJJBxV
	48HP73o/szpbdspFFdyTkvj+yq2TuVYlBKkHQu5Lzr/nKz40YIpzIQddB6ilsw0u
	hFvJqwpSlgCMlEXPI6GptJWYtFDomdvDbtBJTjGDZ32pk9DCFQA3fElZZ0WxVhBZ
	TcNEMJkKxakaxoTihsMTZYSwBt/z16NNuv795clMiuCGjhQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fyk1hrm1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:06:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Aug 2026 09:06:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Aug 2026 09:06:35 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id E39CB3F7041;
	Wed, 12 Aug 2026 09:06:31 -0700 (PDT)
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
Subject: [PATCH net-next] octeontx2-pf: Add NIXLF error and poison interrupt handlers
Date: Wed, 12 Aug 2026 21:36:26 +0530
Message-ID: <20260812160627.3992050-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMSBTYWx0ZWRfX5AfvN4GfNgT7
 90J/630tLdyTEhvaNtn8zmi/34Y53AUzTjSbtaLyZkAveboNgVlnsTVVhDDXmfrac4jhmxs7u7M
 iyw9lmL+oWJoEdmUnglE9S+d6B2ZI2s=
X-Proofpoint-ORIG-GUID: si8EcFieMX9HGPx-flzWcuU-LZnK2K8J
X-Proofpoint-GUID: si8EcFieMX9HGPx-flzWcuU-LZnK2K8J
X-Authority-Analysis: v=2.4 cv=EIQ2FVZC c=1 sm=1 tr=0 ts=6a7c9a0c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=ByCdszm9PJ39elarfXsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMSBTYWx0ZWRfX/XiNSXSGVYKi
 sc6NJzn+TT6YN3/8x29/wl7hCNSGF7lUEPirNWYkt4Fg/a88S4XXHrJ/it8bgEzcIg1rgifykH7
 +2Z0MwWajpOXzMTu8h/elOz6jYPeL9jdZ+runCtaoismA5cWfXFV8sT27cwxF1SgKcEFXb1zd84
 SuPZHMUrTG4lDijhNaVPqB/q7mzH8G+PuDIfsMt9peBtLFwQozIc+9R7pjcDxrbqibwCLB4lJbZ
 /0YIL3hZlRVNLSlFW6v00OrbMBi/lrDTE9yfb71iW7rIByNIc33o614197sfYNNJxLojDKQ81mR
 yNLJrPo7hNKSHbd7B9+Dg0NlKoXzNDrire/LDzu9NWU6pgyQg/r/QuT1vWxd/cCVpIgoz8nJ9b/
 e0yTvA9im0rSGY16RNdtLD+qWTbRpnhgVXWEUK0CTQcHqUrCCAdni9v/gFRH34iewzC9/JJvRyi
 zV7Zn1ywoKMWCcfqRvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01

From: Naveen Mamindlapalli <naveenm@marvell.com>

Register and handle the NIX LF error (NIX_LF_ERR_INT) and poison/RAS
(NIX_LF_RAS) interrupt vectors, The handlers acknowledge the interrupt
and log the status (ratelimited) to help debug NIX LF faults.

Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 80 ++++++++++++++++++-
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  2 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  2 +-
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c995f2900859..61b0334d0b6e 100644
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
@@ -3010,7 +3088,7 @@ int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 	 * upto NIX vector offset.
 	 */
 	num_vec = hw->nix_msixoff;
-	num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
+	num_vec += NIX_LF_POISON_VEC + 1;
 
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
index b022f52c6845..2a5630561b12 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -554,7 +554,7 @@ static int otx2vf_realloc_msix_vectors(struct otx2_nic *vf)
 	int num_vec, err;
 
 	num_vec = hw->nix_msixoff;
-	num_vec += NIX_LF_CINT_VEC_START + hw->max_queues;
+	num_vec += NIX_LF_POISON_VEC + 1;
 
 	otx2vf_disable_mbox_intr(vf);
 	pci_free_irq_vectors(hw->pdev);
-- 
2.48.1

