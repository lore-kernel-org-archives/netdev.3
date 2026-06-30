Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A61A7264;
	Tue, 30 Jun 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836814; cv=none; b=dJ5d9mMCYJ2+2ofXXpT0ZewgIbfV1mDEu6OvRDIjwElG60uwLYjBj1uMRFOL9dKhvRIpEea9aKImJh+aWheD2+IYcKZIQYoOa60Hnk4xRPiyqtMyQvZBmhbZDGfLqlGCm/TH9G0ABw+b0mtj1zJMUbRHk4ukfVa/EKgn9ZdKGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836814; c=relaxed/simple;
	bh=evlSDYy6Ygp+ukrloEMuQ3tjfA3TwvKzk7xCnaU6qpA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XexzDqubvYaPzFLd6Ere4ZjYjcQFInIeSx/9nkC+41+viU+XulvX07eeC4OjALDy7hs0b1XSZ5ZgXT0TUjU0JHmip15CjXU6ELE1BR7LwggoFFEto8+9urnsIT7e42yVEJbrK+HxKNOsakm+r8ZYAjQp1W4SuH+vDLcI6TvUVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i6qnUW8t; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i6qnUW8t"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIgCJ499666;
	Tue, 30 Jun 2026 09:26:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=jkdCbgZYH2S06QeuGHlHz68
	OzUvoZ/bSIa5DVIJfQtE=; b=i6qnUW8tIPr3yCo+55+pk7VbL2GMo7FvRuu1iRQ
	Xy5iKA5ZQr9FqUmugDnLT7ffmxXFNbo8VydTz1UXfuPv49f6zzvF1Kp7mvHLq48+
	nXFzPnQ2DDsdVm/IpSe/iPS6q5zMNmJI9kynD1V9OjOY7oLaEyI6r9yoRD97V8I3
	qLCvtqWyl1K828sI+dPgHJPsPaZmbPJe88dvw/44Bo2XTH5qBzRCroGxCI+Sq2vr
	3NMsYCyV9T+piTQ/d3MtnUmjjMiwGgMquVru3OxNh0MWFgLutHk5P7x6uurTI52H
	PYccP16zMhQ8sgFz1uhum3SUyoBzR2nrqpzSgswyaEU8GEQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f42dfjtwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:26:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 30 Jun 2026 09:26:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 30 Jun 2026 09:26:36 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 2AF453F707A;
	Tue, 30 Jun 2026 09:26:30 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <naveenm@marvell.com>, <tduszynski@marvell.com>,
        <sumang@marvell.com>, <hramamurthy@google.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>
Subject: [PATCH net v3] octeontx2-pf: check DMAC extraction support before filtering
Date: Tue, 30 Jun 2026 21:56:22 +0530
Message-ID: <20260630162622.2667086-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE1NiBTYWx0ZWRfX0XfeNzWOKO3k
 aEdL6ztifWGfbz3Ne8bY2WC5ekpXCqjIESaxmIFd9YxiK+f0ceS2ADQi8N2DSVTv9Ca/SCmCfXS
 yQpTMmZ5apUyuxnXGL7MHxD4riZeUMM=
X-Proofpoint-ORIG-GUID: hMz_NLu-fPhy3c_v5M0WYBfKyBzJFpKq
X-Authority-Analysis: v=2.4 cv=Zrvd7d7G c=1 sm=1 tr=0 ts=6a43ee3d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=E9o4sS0pqQQeLg7t-9wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: wCQm1AUN0J7uhnmj5iyvnrFvY1gE_siz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE1NiBTYWx0ZWRfX0Z+kKv77l68b
 ndhFMucpKEyT72AHZTopCHQlMB9hXx34LSeg68YtqdJfLIUxMP0OkybqxVtG7uirmdWH7PCmT4h
 y4RL8coKe0nDSv8Y6fHJGEvgUWm+BkTxfiUiWCrES8tMJMJWuIn241rWr899KgpcCGVFhLhE7H9
 mB647S7L7AsZndzBHfwTbQM9D73WJFtgyspFUhwawMx8TZa9ahWVbRCHQgrZEyoYh5huFedhhMF
 bvB8CNDnGomHbOkm56V7uyx5zlIFeMO5PqZiqhofvYQIH6fGB3hQOTqQHFbysI1MHnP010ZuFP2
 w2AtjZ9A9WyQZ1nbqqoeJIsm7kCR60Chi6xH3mRlTBSQw3SPkTuTH6Uq1eQK3lslqlhpVcF/yvN
 4TdA0rB+fDZqJ6Js7eNFUwY0PGyczeJj+MYZ6/keW2rcYqIRxHhulmHZ8uXFzzipwhQuXIWBL9H
 S8p+B0ryTYsWKrJI6Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Currently, configuring a VF MAC address via the PF (e.g., 'ip link
set <pf> vf 0 mac <mac>') blindly attempts to install a DMAC-based
hardware filter. However, the hardware parser profile might not
support DMAC extraction.

Check if the hardware parsing profile supports DMAC extraction
before adding the filter. Additionally, emit a warning message
to inform the operator if the MAC filter installation fails due
to missing DMAC extraction support.

Fixes: f0c2982aaf98 ("octeontx2-pf: Add support for SR-IOV management functions")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>

---
v3:
 - Update config->mac only after hardware programming succeeds in
   otx2_set_vf_mac().
v2:
 - Move the DMAC extraction check from otx2_set_vf_mac() into
   otx2_do_set_vf_mac() which already holds pf->mbox.lock, so all
   mbox operations are under a single lock/unlock pair. All error
   paths now use the existing goto-out pattern, eliminating the
   scattered mutex_unlock() + return calls from v1.
 - Return -EOPNOTSUPP instead of 0 when DMAC extraction is not
   supported, so the caller gets an explicit error rather than a
   silent success.
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 44 ++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b63df5737ff2..697570765957 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2517,10 +2517,43 @@ EXPORT_SYMBOL(otx2_config_hwtstamp_set);
 
 static int otx2_do_set_vf_mac(struct otx2_nic *pf, int vf, const u8 *mac)
 {
+	struct npc_get_field_status_req *freq;
+	struct npc_get_field_status_rsp *frsp;
 	struct npc_install_flow_req *req;
 	int err;
 
 	mutex_lock(&pf->mbox.lock);
+
+	/* Skip installing the DMAC filter if the hardware parser profile
+	 * does not support DMAC extraction.
+	 */
+	freq = otx2_mbox_alloc_msg_npc_get_field_status(&pf->mbox);
+	if (!freq) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	freq->field = NPC_DMAC;
+	if (otx2_sync_mbox_msg(&pf->mbox)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	frsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
+	       (&pf->mbox.mbox, 0, &freq->hdr);
+	if (IS_ERR(frsp)) {
+		err = PTR_ERR(frsp);
+		goto out;
+	}
+
+	if (!frsp->enable) {
+		netdev_warn(pf->netdev,
+			    "VF %d MAC filter not installed: DMAC extraction not supported by parser profile\n",
+			    vf);
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	req = otx2_mbox_alloc_msg_npc_install_flow(&pf->mbox);
 	if (!req) {
 		err = -ENOMEM;
@@ -2559,13 +2592,12 @@ static int otx2_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 	if (!is_valid_ether_addr(mac))
 		return -EINVAL;
 
-	config = &pf->vf_configs[vf];
-	ether_addr_copy(config->mac, mac);
-
 	ret = otx2_do_set_vf_mac(pf, vf, mac);
-	if (ret == 0)
-		dev_info(&pdev->dev,
-			 "Load/Reload VF driver\n");
+	if (ret == 0) {
+		config = &pf->vf_configs[vf];
+		ether_addr_copy(config->mac, mac);
+		dev_info(&pdev->dev, "Load/Reload VF driver\n");
+	}
 
 	return ret;
 }
-- 
2.48.1

