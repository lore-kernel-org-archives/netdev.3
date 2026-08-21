Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C197390C94;
	Fri, 21 Aug 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297314; cv=none; b=de/hGOjXsg6Lb7xnKJSeBDRRfO/IlObae27kePPURgReI6vcyK+3RoSKroDDsIBM7hC5z3c1bkW+RFFDBtpmIN3+R1rRvrF/rKwf8lHsD+MaVr81I7+2lfW2x3qhaGp6OPWvFAZirVO5EO96cyb3Sg0JbYdMkWlvwEzlpFMYtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297314; c=relaxed/simple;
	bh=RLhyUho1jVVLtnA2f/M8WRnGNMPg2xQpq0OqAWXEhl4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rg/PkXvk1vCyrkhrB7odInl2h2Q7fWNXycVpIeZfvfL/3yMTpcHwiXp8vKVpnI3RPtgRNtzI3WZQgLIK9RO+QVG3ms+8TMw7dut9C3Z2xIyNq7LwzctcUVhd2sESWkkZbOvuV1w92TsYatM0ApzjXv96rjb770iimG3Eas2lTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=US/+0GQI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="US/+0GQI"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5YAHb3877752;
	Fri, 21 Aug 2026 00:28:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=mBMwtfm5KqlcG7ZRAXAP8Xo
	TNEzxaAXlkEgIllfC+5g=; b=US/+0GQInVWUhh4EEN9iyd6I0XM0Q4pxLh5JFfb
	C+RHNGwkLn8E648U3cxjJildQDqmBSFSjWBCqbzAz2GmK5y0yUq0J78lJ/1OkaF6
	aDLwokeZu2J1R1VvwP0kXSzqume9bQaeryItj6Xhpi+C+kg+38QOHcCSyBHPReHZ
	Tm8Ka2mBTW28iPtDybUIBSuqBK0x8xPzW22F7cyBFjQrNRzDU7HAdmdHIernY4nw
	Q3iZGhMaQ3Xppk+DxU3T2ad9yl2QD5dCzn8wiv0b2Qn101tzvYR5na8gPalCB823
	rmCD4hukqmVMF+09P8hr1W+TgdGxC+5aUrZb15yB8cpHeKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g602evk19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 00:28:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 21 Aug 2026 00:28:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 21 Aug 2026 00:28:23 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B46F23F7074;
	Fri, 21 Aug 2026 00:28:19 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <hkelam@marvell.com>,
        <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-pf: reset TL4 topology on HTB offload teardown
Date: Fri, 21 Aug 2026 12:58:12 +0530
Message-ID: <20260821072812.2890922-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: w4BFmijpthlgXfsvo5zZPDr2sXrWW8t9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA1MiBTYWx0ZWRfX97WOMG5grw/J
 4F/ZbD2qspYEO6KPaZUCf5UJTyP9t971/lVyHC7JVnpfoVmHEw4TFIS2vMwJ7VjL8lOlwP2j8A7
 AP+EGVUo+WLlb6IoZ+4MdJtWSxWdwKxb6s8fkr+zKyx6oWVsXixTmDPkDWHQ7dlZdu63RahIiKZ
 tBcsoR9rv+iCuGf9WXUlNtvuT6WmvLWByPIhNDJ6lxQng/2JQiahxj2dOzSc0vbys0EB10y1Vrz
 SQLVXa50LJJio4btsmo3JC6g4rGU1ZyuLE55b7aknKG4GPZK7j+zNyI51mimoCPSJsQlvsIjqeQ
 hECFU4YF/9RsahqYDxA+ypqYEhT/N/jRL5jpXN9ROu+DkuFhC0ubdXTAYC7nPUuSbdgfGss33zh
 XcXfSI62gRm6uhFzX1/+1PCOx545/MCLH5kVpzfW7ggBGxT8BAUSJfISMJnyrFSoL5ZrQHAzPIu
 Jaldnv+DjzgUfGspvjg==
X-Authority-Analysis: v=2.4 cv=NNvlPU6g c=1 sm=1 tr=0 ts=6a87fe18 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=z6uEUuw96xUZyWbPEcsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA1MiBTYWx0ZWRfXxvIRicwd+ySx
 +i+ij1V2cS668kVrKCM8HAisMVDQX/OH9DwJTfDpkSchvGR0gnZ+UPZHuZ8YQhMlyRMc6JoHVMk
 wozbeRW0FLNzFlKl/T6V+uaSlVXXb+Y=
X-Proofpoint-GUID: w4BFmijpthlgXfsvo5zZPDr2sXrWW8t9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01

HTB offload programs NIX_AF_TL4X_TOPOLOGY with RR priority and anchor
settings that the AF retains after scheduler nodes are freed. When mqprio
bandwidth offload later parents MDQs under TL4[0], stale HTB topology can
starve transmit queues. Restore the default TL4 topology for every active
TL4 node when TC_HTB_DESTROY tears down the HTB hierarchy.

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..21943fc059db 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -235,6 +235,49 @@ static int otx2_qos_txschq_set_parent_topology(struct otx2_nic *pfvf,
 	return rc;
 }
 
+static int otx2_qos_reset_tl4_topology(struct otx2_nic *pfvf)
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct nix_txschq_config *cfg;
+	int i, err;
+
+	if (!pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_TL4])
+		return 0;
+
+	mutex_lock(&mbox->lock);
+
+	for (i = 0; i < pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_TL4]; ) {
+		cfg = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
+		if (!cfg) {
+			mutex_unlock(&mbox->lock);
+			return -ENOMEM;
+		}
+
+		cfg->lvl = NIX_TXSCH_LVL_TL4;
+		cfg->num_regs = 0;
+
+		while (i < pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_TL4] &&
+		       cfg->num_regs < MAX_REGS_PER_MBOX_MSG) {
+			int schq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_TL4][i];
+
+			cfg->reg[cfg->num_regs] = NIX_AF_TL4X_TOPOLOGY(schq);
+			cfg->regval[cfg->num_regs] = 0;
+			cfg->num_regs++;
+			i++;
+		}
+
+		err = otx2_sync_mbox_msg(mbox);
+		if (err) {
+			mutex_unlock(&mbox->lock);
+			return err;
+		}
+	}
+
+	mutex_unlock(&mbox->lock);
+
+	return 0;
+}
+
 static void otx2_qos_free_hw_node_schq(struct otx2_nic *pfvf,
 				       struct otx2_qos_node *parent)
 {
@@ -1098,6 +1141,7 @@ static int otx2_qos_root_add(struct otx2_nic *pfvf, u16 htb_maj_id, u16 htb_defc
 static int otx2_qos_root_destroy(struct otx2_nic *pfvf)
 {
 	struct otx2_qos_node *root;
+	int err;
 
 	netdev_dbg(pfvf->netdev, "TC_HTB_DESTROY\n");
 
@@ -1109,6 +1153,14 @@ static int otx2_qos_root_destroy(struct otx2_nic *pfvf)
 	/* free the hw mappings */
 	otx2_qos_destroy_node(pfvf, root);
 
+	if (netif_running(pfvf->netdev)) {
+		err = otx2_qos_reset_tl4_topology(pfvf);
+		if (err)
+			netdev_warn(pfvf->netdev,
+				    "HTB destroy: failed to reset TL4 topology: %d\n",
+				    err);
+	}
+
 	return 0;
 }
 
-- 
2.43.0

