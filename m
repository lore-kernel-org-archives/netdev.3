Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14323EA94;
	Tue, 25 Aug 2026 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635067; cv=none; b=UC6Tw5/OkWS5NOV6tZhZxCcKLIKUqIcIo6k3igWOzSW07uLiR9UB3kchbtbZXJwe+yp3Oiqu2IoP1ODaeW76LSJmjNMgQHGq2RiFHJdu/Mni8IpQkUyeh/ZTR7Z4sON9rJfOL2Gz0k+wM0/AdjO/j42UVbs11XFlKdzKBPBsNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635067; c=relaxed/simple;
	bh=jH9fYfWlkDEQqqsWAsPKJkxMavb+V8lZrBplK7PH4Pc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MFJTgjTMYIITLV0x/LVNJ2zbnJI0XC3/bRX/ddADkMS7ejfjJm3GaBVAGt8F9qEQbnixScxgdP+2OsNHSw3/t0TUPnASbLJtth/eGGzF1Ra1paqu4D47IVk3ez0B22+zjA36HCKy6ZvetZA+gs1gSSav002mRLS24kMmPKlVOOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MjSLgBD0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MjSLgBD0"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2PpWW1298915;
	Mon, 24 Aug 2026 22:17:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=C4QKkOWY2/zM1Uc2xPRR8wL
	sp+RCkHLCURmw4zQueFo=; b=MjSLgBD0qNBjbbdbw33690RPXOaQkMBR0AltLic
	uKiNMI9KSLwm2rcdAzuk3Y+ruWa6FqruYWDJB5ZQWS4tgmVFpvCq1rsNvllrnpcV
	cEP9L4XEAZ46HHYlyFEbuK+UkUH6XPHfw32netXvn2tHxpo5H7ns3nIFhoqrA+y8
	qRKzurLOgBa5Kl4doawziZJdjSHD/XLxdsGGcSk5ewXI+btxrPFC2bZAYBd1CAbn
	nheC6uprUBY8HqfX5VCfzY+/mtwd1V8L8+ap8vqJ20oFAcqf137M5xwdAEKfL2vr
	3yutr3/DuOdIPLe0NI33FSvQulFKsnE29TluF+BSlhcnA6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g8pdx341j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 22:17:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 24 Aug 2026 22:17:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 24 Aug 2026 22:17:35 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 430123F7099;
	Mon, 24 Aug 2026 22:17:32 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rkannoth@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Kiran Kumar K
	<kirankumark@marvell.com>
Subject: [PATCH net] octeontx2-af: fix CN20K default MCAM rule removal on port cleanup
Date: Tue, 25 Aug 2026 10:47:25 +0530
Message-ID: <20260825051725.3732440-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BomtB4X5 c=1 sm=1 tr=0 ts=6a8d2570 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=a3bFawCxOckcWzoCgeEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA0MiBTYWx0ZWRfX8wbRvQzH/gEa
 fTZNpSuER7evIU5jgLmAd3lj9k8AuGr06SQqkdKaRomRvOsqC5O9IBUjH8jnMQ3xg2lsj7HQlTT
 eeypWeQ8BnLccZGVcPSoUelYZ6PRN0GXgrcM2lILir8oJlUg0O5XE1zToTlL+0ikutZQC3KjZYP
 9EI8Iq/KmV6sSUWyZIn3An9OQXENmOPof+eIjE3fW9gdncrVyhaNJiJ8r0ZhWamuUcQJE9mlr3k
 9FnywirvPvK+5J3CULJkf4p6Eb2WMDNwzUUJxxXZbfbqPfMLDE4aj16ggOVCXjwdWgXiCawlH4J
 EVvSfsSo3Z2FzdQGGa6uyt9rT9eVf5GIzRfVDoxCuhpiSUdaOoL0RQNxkyyT4VGz7hlvzxWqwC4
 oUtyvwyJyADes1eXOaK8c2EFNWQx6eO6dBcRu4GFdgYVQiN2Olip+w8AGbHJUFAio96kfXNPfNO
 V81pHzDcEbOp+9dGgng==
X-Proofpoint-ORIG-GUID: Ka0y1KNtxwG0jBTQUkhj08vdEK2te5RH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA0MiBTYWx0ZWRfX+V7FCa5nj7x4
 suc7in1L/4cVVEt6A33BZpEY7AIhsbMrlyzLVC6TkuhWsN6LTJK5jQNecuKfYWnxazh66DsNMXU
 11TP5PFLbDbANn71jxVEmGDBfnE5ug8=
X-Proofpoint-GUID: Ka0y1KNtxwG0jBTQUkhj08vdEK2te5RH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01

From: Kiran Kumar K <kirankumark@marvell.com>

npc_mcam_free_all_entries() disables every MCAM entry mapped to a
port before freeing it.  On CN20K, that also disables the default
broadcast, multicast, promiscuous, and unicast rules, which causes
packet drops when all rules are removed per port.

Only disable and free non-default entries.  Leave CN20K default rules
enabled when freeing the remaining port entries.

Fixes: 013717353c03 ("octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free")
Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 60922944675b..c34f8d86cc8a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2957,10 +2957,9 @@ static void npc_mcam_free_all_entries(struct rvu *rvu, struct npc_mcam *mcam,
 			}
 		}
 
-		/* Disable the entry */
-		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, false);
-
 		if (!cn20k_dft_rl) {
+			/* Disable the entry */
+			npc_enable_mcam_entry(rvu, mcam, blkaddr, index, false);
 			mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
 			/* Free the entry in bitmap */
 			npc_mcam_clear_bit(mcam, index);
-- 
2.43.0

