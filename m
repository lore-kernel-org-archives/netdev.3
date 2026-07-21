Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB52C11E4;
	Tue, 21 Jul 2026 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617405; cv=none; b=YN9FYGQAt4su0D/799mGz2b8yIGo4m8/cJb7brMlMVCqaZylVVJW41150eDUUTdiEMJQTx13cDiETbaxYII9pr/XKonvp6MyNc1EcOlNCtoEvmwht8nNMpdSV3vwwHsv2llF6Qfg0/0504ZVLi5bdZ4LYuxg2xRmivTfMdcCHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617405; c=relaxed/simple;
	bh=iGtIeuhRqJN0C/aKAY1q/FTJvOe6ddL87C9Bi7Z1hcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rR4zLIHKaW02r8Tz59JauIOwwDrbZ/ROCaNJz0hxv295U4xfZFqIDo6oPOG3nY2uBeFg9dspWl2Ed+33gqwkMprccCHgb17D7pkUG5n4N1WPsbb3XEDLQCVup5lBOpnI1YJnG2f6odle4+5pFCF+fDEM59iC3G/3EZzcC1RPtl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RysZU7J0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RysZU7J0"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNcUbi653583;
	Tue, 21 Jul 2026 00:03:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=2+TK9uJTY+A7N9OlDm7zRLM
	LPMEYjLVboF2cxId9FaU=; b=RysZU7J04L/yqbqvy+voS6jWB7C4sNuE2rXUakD
	ow8/d2xvbwSnHg5F6yNBVYJWKx0IsrYoaxNGpJ3sIM4kZC/OMHzY6t9Wew4AxxKU
	E6tpWfX3jZu82XhROoVeRZaEX+vRX99t1iZYkvtO2Gd+kk8hZOvjvIM/Q7RGsBtT
	OjOMhfRz+a2fYJPXo5PqzsMGA4cNdO9BXcP7qpjqNBDFw//bOgAjK38yu5OLCDA+
	ZGNTLk6slFhrf8PBIcMeGwaj1lhoSDJz4jnf5LC5S1yMTf32xBS2WQ6MtCM8nx7q
	3nEqD3+tphivaWzKdSv9mWxVVrUDDWc6EhfheXNG2qsqq4Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fgdbcypg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 00:03:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 00:03:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 00:03:08 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E137E3F7044;
	Tue, 21 Jul 2026 00:03:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Hariprasad
 Kelam" <hkelam@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap
Date: Tue, 21 Jul 2026 12:33:03 +0530
Message-ID: <20260721070303.986740-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YVWEicRxTFc_ofoK0Ef-r2qizeYJFqw7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfX6afWSTWzatZ2
 aMfbMLYhl4L1hI3//+y7n4hwgYqZSkU6tZ5JvKKxMlsbcdvJSIA4tGNLYtoDyKJR8ywx2zjDxis
 X7AER5mNLDNumVL0r2ifwyYW+7YocDI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfX+T2Ilk1/8lw+
 CRayQm6rXpX2OzADBxRLB3FWTf0ErxXs0r+nvSNJY83jox+CYGTY1x10aHL/qjtzZimaH5IIlJ7
 Tw5F1nh+H8s99RaKfzBMNWfsIkrZbD/2On2roUCSGR0lIVivLb9DTgf0lqFo5mzmdUT7vRK4Eez
 Ir3XntQf5wsd5YcAMeX4hA0NIPyGtstmEbuG+Uq+Xj9PIWnzo9RWT6D7QEyl9+3zBgFjL7+qBcG
 MieleWYV3nAsaUP9nzhbeAITpqOn+iAaIEOkgnry0pj9cpE6JmoVX8TTjR7JKXoOnDmSgwzqhIl
 wcG8sTnFixK6XdLmYnjIKJH4qkYdkoeSOxN4+uMW9UnqX3KvO26s+3OS+Mlz55+TOOz735CtVPq
 Bdm3qXqHzO45BajJpMTYHPEh5/PbsSBAnytm1e7U0xfjCpRXBEO02xKwdtcYEhyFZvMAJqn5K22
 oOKYdqU9pxwIgBC0IXQ==
X-Proofpoint-GUID: YVWEicRxTFc_ofoK0Ef-r2qizeYJFqw7
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a5f19ae cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=6BDruIGW9xnf_RptPNEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

When scanning the MKEX profile to determine supported NPC features, warn
if the SPI extraction field overlaps with other key fields. AH and ESP
may legitimately use the same key offset for SPI, so continue to
advertise NPC_IPSEC_SPI via npc_is_field_present() instead of treating
the overlap as a hard failure.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2: Addressed Simon comments
	https://lore.kernel.org/netdev/20260720171857.278396-2-horms@kernel.org/
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 91b5947dae06..d422bdd5e8f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -729,7 +729,12 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		if (!npc_check_field(rvu, blkaddr, NPC_LB, intf))
 			*features &= ~BIT_ULL(NPC_OUTER_VID);
 
-	/* Allow extracting SPI field from AH and ESP headers at same offset */
+	/* Warn on unrelated MKEX fields colliding with SPI key bits.  AH/ESP
+	 * sharing the same SPI key offset is valid; use npc_is_field_present(),
+	 * not npc_check_field(), to advertise the feature.
+	 */
+	if (npc_check_overlap(rvu, blkaddr, NPC_IPSEC_SPI, 0, intf))
+		dev_warn(rvu->dev, "Overlap detected the field NPC_IPSEC_SPI\n");
 	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
 	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
 		*features |= BIT_ULL(NPC_IPSEC_SPI);
-- 
2.43.0

