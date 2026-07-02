Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73E30C60F;
	Thu,  2 Jul 2026 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782963319; cv=none; b=mwzwo5HUktrYhaUU7X1uh2nXkDvcnvIJfBrBefBkV9qAtja8/FN7Vw2TmOjH+KFEhHnkr4MW02v97LxA9WfI9zCZDfkaRiui1JenVDEfp9m6nYuRxgmbu02kTdTf/4jQ3FCPYIN1FeH+g5oiivNxlqCmfd/3ORsh5SWxOD65ytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782963319; c=relaxed/simple;
	bh=Z/ySRfcvyA+3Hx7N9fLd4rbCIbkm680cwMfoAzv9nUs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E3WMcaRhaGRtVP4PDxRnYsIzguOG6dLalxVO8x+eJel1g1tmDQmS6TTsQGMFEmQjAepavA4TMN8B12xY611Kxzhj+wuDE9kPtcj+wVLAZrD5GN6FnKYK7HNH0OOpGaHi86qH4VPzJkI/fTD8mNK8h+Acog6dha2QsxCauUswo8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ArPrAVGB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ArPrAVGB"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MrTq570199;
	Wed, 1 Jul 2026 20:35:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=vwY6AEcf0rMG9F9PhDHZy1f
	nCZkboMZ6nrHBEfdLHAo=; b=ArPrAVGB5W+TsZJm8Yl6iUP7+WM0o7fk9y2Rs3Z
	Yg9JkIOFL71W1QZ+QJqZN0e4B0sE4J9iVzq0x3x9IyKzwRWrN1k0zoYjLw/Xst8V
	5uos8hZbq4eAOt66lIBq6phORC+hCG8t1JvneFVDCli2DLwzJuagDnp8i/cjl1PT
	SvxyQuVdfSYwtABINTSNG+GcB/5g2qAOywskjjGa/q1Q5Pq6j3/0nEDFpDLPUfWl
	n1pIvXghgCsDxLvMODhQgAEIoYzaLduWEVXLZM/NP1IDZ3/nWW7lk5OE7LDIPLCB
	pp1NyHF81F11v3csgLJVrBKkGYQfZWQUP6/TkhdkStvgJNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f5b990u7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 20:35:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 20:35:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 20:35:06 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id A679D3F7078;
	Wed,  1 Jul 2026 20:35:01 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <naveenm@marvell.com>, <tduszynski@marvell.com>,
        <sumang@marvell.com>, <hramamurthy@google.com>, <rkannoth@marvell.com>,
        "Nitin Shetty J" <nshettyj@marvell.com>
Subject: [PATCH net v4] octeontx2-pf: check DMAC extraction support before filtering
Date: Thu, 2 Jul 2026 09:04:51 +0530
Message-ID: <20260702033451.2969880-1-nshettyj@marvell.com>
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
X-Proofpoint-GUID: -5_bJl2zAP6Sa9r0S9y9inre_JJAMkpN
X-Authority-Analysis: v=2.4 cv=GPk41ONK c=1 sm=1 tr=0 ts=6a45dc6c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=E9o4sS0pqQQeLg7t-9wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BknZ-a5B3WrvYJ7wOtj2SU5kBwGG0sNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzMSBTYWx0ZWRfX+WdG00ES1c7Z
 Bk0OqOwDVDpj5XKlzR8tq+GOIU0Ts23inj9kCwNdte5dw7j6ECguy/adWXMDd8+GEgmcSY6SN0o
 k0CXzs5KsJ5QPGNck/3IiWUbT3Dd9LBmIQil8Zoo5vbq0cAlWlTarZBd1CnBtqtA48E4Bopc/QT
 JMDc6dz5oGKq32/ldof1nz2Z2L4avNWoFG70Bk02MK5e356aRVkq+eSO7LCf3fX+fgJqnXCAM2k
 o6Z9kWOA1NX3dcSJWbwX3PUTs7IgUxx0LD+tF4L12mSh/4Qy8l91PpfU6J/kotKcaI2RdDTXefV
 k24ZPofoYF6jh0PhQDjgx9mict553kagtqVKkMHbT4UpDAC9ABDRQ7+5WIE5vFUZaPWkb31IdVM
 0fh7t7A9HZ8Z4K3qnXSnimcnOplYdL6seBiScHyTin0gMOrmxqZXVnZ13TkfZbMmCpRON6BuEP1
 B0eyQa4RHItwnzWl4Mg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzMSBTYWx0ZWRfX5dAITJdip8ED
 eidFKnLloHCxiQML7FwZrJfNeOIYxEGBNg2+9Tik2psk6IXXyZObpX4NJGguqRkGHUQSB58TH/k
 UDoX5+N2j0D145XptiOCqJF9Qd1Ny/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Currently, configuring a VF MAC address via the PF (e.g., 'ip link
set <pf> vf 0 mac <mac>') blindly attempts to install a DMAC-based
hardware filter. However, the hardware parser profile might not
support DMAC extraction.

Check if the hardware parsing profile supports DMAC extraction
before adding the filter. Additionally, emit a warning message
to inform the operator if the MAC filter installation fails due
to missing DMAC extraction support. Update config->mac only
after hardware programming succeeds in otx2_set_vf_mac().

Fixes: f0c2982aaf98 ("octeontx2-pf: Add support for SR-IOV management functions")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>

---
v4:
 - Return the real mailbox error from the NPC_DMAC support query instead
   of masking it as -EINVAL.
 - Updated commit message.
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
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 43 ++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b63df5737ff2..888ebd6cef39 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2517,10 +2517,42 @@ EXPORT_SYMBOL(otx2_config_hwtstamp_set);
 
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
+	err = otx2_sync_mbox_msg(&pf->mbox);
+	if (err)
+		goto out;
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
@@ -2559,13 +2591,12 @@ static int otx2_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
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

