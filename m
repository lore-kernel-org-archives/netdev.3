Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574310;
	b=k0Tdwtsxg2Ga/qC1n4++Ll+T4g/3AvxiFoPZio8/MS4UdX3Z5FFaLoVOVnP47nuWvaF3
	 XQKyZtYQxbyRRqrcQHBeDoRJYusQ0Zdpnyoan82KjPjMLrtkyGxpguRDk9GC99k3BlRPU
	 dRCmp+QO9dqZgCweGRQseHLGTQsQc6ibiT4POXFRMPDOcdOA89mtp7ns9Tj+yg+dgDH3o
	 AYOLvphhgTuLQOKKvEaEv/KM/YA2smEXucmWxDMqMfzxDGvXTHnTVp69sZUF2ZAg4mmOj
	 e6v8yaSc045DjHUwfZENLTt46YgLQ1gDL52QlNukmGEDdnbDRi27VMCJSJQETZPNC6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574310;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=mciEYXOTOH/Axh/70OgPngXreZRnJbIrBuvHC6F4sS8=;
	b=1+E7IjKcjIvdC+vY5YWZeYxVe9HuPLigVttBWsl6EAZAwaH6CyqIgvu3b2owG2JeHIs9
	 BQGE65qBxx8q3wUZDdFxxrD5GBfADx7cnlJMPeUVh+8h+0IrgYywcaoKLTGY9stPFBuos
	 rhoB+6TQsFc4YvC4J6wJDuxFYwHPBrpWmvR6L5NuSIicJkLlTuJFAwO7rzwNWzP8UIwpw
	 dAnGVffpc93ag7sxcZ/upKXHPURuSejbJsNsM/TRVq59k4Dyd5WlmbLMOsYEFE8pgeYBT
	 Vwg42q9fWX6gd6m2thIiCFjj0uAfq3jR3H0pq9PTJZQ0VdR9jShWIggQ9p0EImVnMWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=KRHLHVmh;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D2606A31E;
	Wed, 21 Oct 2026 09:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=KRHLHVmh
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j3AK1215381;
	Wed, 21 Oct 2026 02:18:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=mciEYXOTOH/Axh/70OgPngX
	reZRnJbIrBuvHC6F4sS8=; b=KRHLHVmhhJgAEjHoJXKgfMvO5WHkAqzWoUcRLya
	yt6uicAeSgR/MU0GbxKN9QCyFE5syeE5zkkuE9LwvZTAeqkCeGKJafN5bqejIbBM
	ZX8zepSo9ivzd7kdpVOoEJSOBAMEbIXl2A1a7788ZL0MqzaWtYPpku0JeGBIxn6g
	D/DPfWPf2Bul955Vm1IZ6tGm7Hx827uokloWRf7FhUrwZmmmp+Vjn4/YGLumcEW9
	1HVsNJ0vpRPYKuT5pltTaQorTnl5kqINXkG4qEJvNAQ1EaocDL600gvJ7+hEA65L
	ZpEjiR+GWcJvhL9wRnx/nSPbHbX4vy/MjqXC85uHkZX0ZfA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hebjb4p62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 02:18:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 Oct 2026 02:17:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 21 Oct 2026 02:17:54 -0700
Received: from sjc4ccscust-vm07.sclab.marvell.com (unknown [10.110.24.160])
	by maili.marvell.com (Postfix) with ESMTP id 06D363F70AB;
	Wed, 21 Oct 2026 02:17:54 -0700 (PDT)
From: kmahammadraf <kmahammadraf@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Aditya
 Thapliyal <athapliyal@marvell.com>,
        kmahammadraf <kmahammadraf@marvell.com>
Subject: [PATCH net] octeontx2-af: Fix representor flow rule PF_FUNC mask and channel In representor mode, an AF-installed TX rule must still match on PF_FUNC, so do not clear the mask when rep_mode is set. Also, do not overwrite a channel already provided in the request when the rule comes from a representor device; only default to the PF/VF rx_chan_base when none is given.
Date: Wed, 21 Oct 2026 09:17:36 +0000
Message-ID: <20261021091736.2406505-1-kmahammadraf@marvell.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9bOJ46I5lM7kQ0M189Bna0xOyHKeTZ11
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNiBTYWx0ZWRfX8s6CbpJ0sjbt
 3GWfeaDAiKQVXRIKndupsWLZhH1sAS3ESo+PmKzLlO3uqd/EMMYh85fofV4PKbF2/08z4Ypa45T
 osyirtc4LWD5VrW1z8N9lxBg+UtA4rM8DdsnfJh/24dZGPMUuhEtxpL04tNNRx5rT9DrREeTa6y
 R/TLLDlkxioUFtWoHjuw2WQMylZMc97utAnaSES9CGEDOo8rck8iL6maP3OCzy6Y+1b8gZQpXs0
 tUeg6NQxCU8tTXer/rwTX/eLVhEIoaAaouRJXEO1C3S/PWplHoY/h+3nTVekmodDW6oYNINiIut
 r1vxPjJXM7bg07pftIV30kVpA/xNFXwozb5n8q9l7/4jPfurUzypC/g4CdLyVayKV8LPA6e62bU
 uU5a+FvOf/Yi/z4wFhjgDcuHchUuvj2yRBPZjG3j0bVQRnCZOFTezkqT1YoC+uhsOjQv4g5RHGP
 236YiUEk9mksz4dYM0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNiBTYWx0ZWRfX9sj6qAawFnKD
 wn2zsFsivyEMOR8UVQ0GRXS9dpnItFQ0qr8LV2GNNxxsqQcFfHXsW/B/EfUUwOUabSc7KcGqjvG
 F9a+9YodLn5HtWB0eeuFpOATc6KWnf4=
X-Proofpoint-ORIG-GUID: 9bOJ46I5lM7kQ0M189Bna0xOyHKeTZ11
X-Authority-Analysis: v=2.4 cv=BYdNQbt2 c=1 sm=1 tr=0 ts=6ad88350 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=rQimyMRkXGdN88wx:21 a=uleU-PZzgXoA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22
 a=M5GUcnROAAAA:8 a=0xJ0BhhoCPI0sQK9vYcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01

From: Aditya Thapliyal <athapliyal@marvell.com>

Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")
Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
Signed-off-by: Aditya Thapliyal <athapliyal@marvell.com>
---
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index d422bdd5e8f8..a569a63a21d9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1397,7 +1397,7 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	/* If AF is installing then do not care about
 	 * PF_FUNC in Send Descriptor
 	 */
-	if (is_pffunc_af(req->hdr.pcifunc))
+	if (is_pffunc_af(req->hdr.pcifunc) && !rvu->rep_mode)
 		mask = 0;
 
 	npc_update_entry(rvu, NPC_PF_FUNC, mdata, (__force u16)htons(target),
@@ -1846,7 +1846,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 
 	pfvf = rvu_get_pfvf(rvu, target);
 
-	if (from_rep_dev)
+	if (from_rep_dev && !req->channel)
 		req->channel = pfvf->rx_chan_base;
 	/* PF installing for its VF */
 	if (req->hdr.pcifunc && !from_vf && req->vf && !from_rep_dev)
-- 
2.25.1

