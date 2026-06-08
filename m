Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C093B5319;
	Mon,  8 Jun 2026 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=XoTODOdgVD77E+5fXicrMakSuKx6iw0EyjQfRL7HZ9aNxRn7QN2Jkdt54E39MU6lE+h4vgQiZoxsqxmQuQbw3mCQ4I9kZxkVemgbfazL702oQums/9x02Jsnen1GxLTVsDgwphRYBXnR7c2+3wdG9+FSSpZxQVjuklmAbVptb6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=XMSsM/S4U7LUT7X7um5us0eJD4r/Z5atYP5f6tUQaQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LQT0UdtFCdXE4A0eeqjNzTA6OeOzVEi8Lm1oncEPbtaToF4zbwgbKUdkP51RaYGF7b0cvpkyJK08y6rcIFFLjIovwQ1axR5i8ndVskjtDWYd5WGsUjifTkq6SvfPeKNCz3H5iZT3mWu7bOv7sFv1LdxbsN7+JvXhY4U6PIjNldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OMKEcX5L; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OMKEcX5L"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586QSYW1727037;
	Mon, 8 Jun 2026 02:55:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=y74C8zN53/7GSMXxgDpYR2j
	WNYTJAwxfEwTv473Sx4E=; b=OMKEcX5LThH1cCiP0hOx+Ksy4b/y/lXp2PaD434
	AyBfPxDuga3y77VSF5n67teebG6HwC4km+oq0dYAPqzucf9nrrG6OZ1C12UwyZ/4
	+lUANh27xkz6o8CG69OuW0MDWkRrYSzd++Z6CVbo4yFDvKllkrtAK+0PFhR59I0k
	01dulqPvk9OwTX/WJfUaOUK7vzCpz9aWNrxx2tIobKQyvk5BMsgMuEb0UxATcPwQ
	JZF1bw6Y2/BooBUcwR4ZAs4yDt82Aoa4HIT/5Qgmg6S/mE6itXvJEkCqc/M+7Fwk
	IFyVotrxSBMXArcgivPXmCCGjZJpEiY6hHFgpenaCPp5zQg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4emgwhxk7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 02:55:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 02:55:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 02:55:26 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id CA61F3F7062;
	Mon,  8 Jun 2026 02:55:21 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rkannoth@marvell.com>, <sumang@marvell.com>,
        <kirankumark@marvell.com>, <nshettyj@marvell.com>
Subject: [PATCH net] octeontx2-af: fix IP fragment flag corruption on custom KPU profile load
Date: Mon, 8 Jun 2026 15:24:55 +0530
Message-ID: <20260608095455.1499203-1-nshettyj@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5MiBTYWx0ZWRfX5lO71u6KQiu3
 uEUmGHdA10rVnfw+o+BiGzBhFQVGUUoQGkSOWX6/fSqzLHgoUWK0PbboJY1bxnSCX3LOfqgVZg4
 PfD2ky4c8QEOUvGUfEFd8sN6CHzUAzHUL4OZRAj4WqfHvJwQhR0UnwGgfszfUm5FTcM1zJQp/2r
 xTxV1tgWYWqqBcEXNOpcrdKMi98LRo6iWiWdYMEnwvhdBVuQ3dA27kwMDAXBeFpmFWhp3YKQqPk
 ucSXpvIu2D408o9UCpsEU6U+1TerYKMoXcWvnbwl91g0sC6MSxTm1Vr4ULasTAyqsL6191VzsVG
 5Whns6jkWwbwvq70/xuXBHd2gYT570IOELtUbV/a3xGaG2CBjH5AwN0eOcramBaDlrGDHJlcWf4
 Zoa8i/9QdFCGMjVQZlHhfMa1jFicHpSXlUHI1FSZGrvU7W+/909fYgB2To0GSPG/PmmCkuYdwbp
 W/5yyNTgLLt0vXfDQ5g==
X-Proofpoint-ORIG-GUID: xuz6WiNyVB24_ydGaXUifbiwLggPSJ_C
X-Proofpoint-GUID: WoBkErD-YRW17K9GuceuPqeyMEIAYDr4
X-Authority-Analysis: v=2.4 cv=Pv2jqQM3 c=1 sm=1 tr=0 ts=6a269190 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=9FxvPpF2a-8rQrtHFiAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01

From: Kiran Kumar K <kirankumark@marvell.com>

npc_cn20k_apply_custom_kpu() overwrites KPU profile entries with custom
firmware values and then calls npc_cn20k_update_action_entries_n_flags()
over all entries.  Since the same function already ran during default
profile initialisation, entries not overridden by the custom firmware
get their flags translated twice, corrupting the CN20K-specific values.

Fix this by extracting the per-entry translation into a helper
npc_cn20k_translate_action_flags() and calling it as each custom entry
is loaded, removing the redundant batch call at the end.

Fixes: ef992a0f12e8 ("octeontx2-af: npc: cn20k: MKEX profile support")
Cc: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 72 +++++++++----------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 6b3f453fd500..fe8c4ffcd8f7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -1571,53 +1571,49 @@ static u8 npc_map2cn20k_flag(u8 flag)
 	return 0xff;
 }
 
+static void npc_cn20k_translate_action_flags(struct npc_kpu_profile_action *act)
+{
+	u8 ltype, val;
+
+	if (act->lid != NPC_LID_LC)
+		return;
+
+	ltype = act->ltype;
+	if (ltype != NPC_LT_LC_IP &&
+	    ltype != NPC_LT_LC_IP6 &&
+	    ltype != NPC_LT_LC_IP_OPT &&
+	    ltype != NPC_LT_LC_IP6_EXT)
+		return;
+
+	switch (act->flags) {
+	case NPC_F_LC_U_IP_FRAG:
+	case NPC_F_LC_U_IP6_FRAG:
+	case NPC_F_LC_L_6TO4:
+	case NPC_F_LC_L_MPLS_IN_IP:
+	case NPC_F_LC_L_IP6_TUN_IP6:
+	case NPC_F_LC_L_IP6_MPLS_IN_IP:
+		val = npc_map2cn20k_flag(act->flags);
+		if (val != 0xFF)
+			act->flags = val;
+		break;
+	default:
+		break;
+	}
+}
+
 void
 npc_cn20k_update_action_entries_n_flags(struct rvu *rvu,
 					struct npc_kpu_profile_adapter *pfl)
 {
 	struct npc_kpu_profile_action *action;
-	int entries, ltype;
-	u8 flags, val;
+	int entries;
 
 	for (int i = 0; i < pfl->kpus; i++) {
 		action = pfl->kpu[i].action;
 		entries = pfl->kpu[i].action_entries;
 
-		for (int j = 0; j < entries; j++) {
-			if (action[j].lid != NPC_LID_LC)
-				continue;
-
-			ltype = action[j].ltype;
-
-			if (ltype != NPC_LT_LC_IP &&
-			    ltype != NPC_LT_LC_IP6 &&
-			    ltype != NPC_LT_LC_IP_OPT &&
-			    ltype != NPC_LT_LC_IP6_EXT)
-				continue;
-
-			flags = action[j].flags;
-
-			switch (flags) {
-			case NPC_F_LC_U_IP_FRAG:
-			case NPC_F_LC_U_IP6_FRAG:
-			case NPC_F_LC_L_6TO4:
-			case NPC_F_LC_L_MPLS_IN_IP:
-			case NPC_F_LC_L_IP6_TUN_IP6:
-			case NPC_F_LC_L_IP6_MPLS_IN_IP:
-				val = npc_map2cn20k_flag(flags);
-				if (val == 0xFF) {
-					dev_err(rvu->dev,
-						"%s: Error to get flag value\n",
-						__func__);
-					return;
-				}
-
-				action[j].flags = val;
-				break;
-			default:
-				break;
-			}
-		}
+		for (int j = 0; j < entries; j++)
+			npc_cn20k_translate_action_flags(&action[j]);
 	}
 }
 
@@ -1709,9 +1705,9 @@ int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
 		for (entry = 0; entry < entries; entry++) {
 			profile->kpu[kpu].cam[entry] = cam[entry];
 			profile->kpu[kpu].action[entry] = action[entry];
+			npc_cn20k_translate_action_flags(&profile->kpu[kpu].action[entry]);
 		}
 	}
-	npc_cn20k_update_action_entries_n_flags(rvu, profile);
 
 	return 0;
 }
-- 
2.48.1

