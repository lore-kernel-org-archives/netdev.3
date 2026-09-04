Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EA3B1EEE;
	Fri,  4 Sep 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511900; cv=none; b=gX9c0d0Pvogg8KSdIpiGWL7Qtrx5NTVjOLBpNEnMvUq31qZKtH/QKPpMwcS5Eln9BN3P5fx8wUdxcxFGGmR9FhN4U4r1DkYdknIYA1tN23sCrq6dgUmSNKZmxmap4Jmc9F+p6P3wh8T+41B/KJDABmXDfZH0x8KytDX1/rCVJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511900; c=relaxed/simple;
	bh=fJY4CfTMwXF1c8taumGysvxLPV8UfS2LpkGNcDGd0Po=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLpXrhl/7xXM8lMhNd2o3+r6nVsOJoMXErh3KmI6tWWeQM7EzAmXvKetBM4fNDkhOjNuR+oFcISnRvN4vX9yPRFzYInMbgjpo26fToo8x2oekVIwFKehG/kOVt7vXYaLlJlKAErSenB8SWkKfxReCCMoDGSb5I7mdjQRKgUJFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ei7TVeyl; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ei7TVeyl"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464Ema2882310;
	Fri, 4 Sep 2026 01:51:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=d60EtM1ew6dHpeoOlXeIqV5
	wTzZa1NgjqmZ2qjEaHbM=; b=ei7TVeylxVRrt6ytQYfgRB8XnasAOfDYsJUnEA/
	xGtPfvB2Ardqipr/0q9XrWibVha/IdjyqCii7c6Q4fDJy0Ojm3XnUiMOMNkt8Pf6
	5NLgglNhW0tTqeLY4cfmEE2Jau7502XfePn9s12gxRgQbh/OGsRS2s5rGSF/BhfK
	/emfnSqiV8wIwLfqii3BK5b3+H7c/oLoR+YrqMbQbJhS1A1PGap6pXnJmsVWOH2P
	mjr2VUq3ZPhz6J4hslgo3mRH7BU8T6+2usWevgVdh/Xe2XBr9tK8QO5ZyMxly9T8
	lKvUrYZyXR7oehtu4MJQIa3wR6jQ3vzgdrN3z6YTQ17LAbg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gfkq9s39v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 01:51:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Sep 2026 01:51:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 4 Sep 2026 01:51:29 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 58A9C3F7066;
	Fri,  4 Sep 2026 01:51:25 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rsaladi2@marvell.com>,
        <sbhatta@marvell.com>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
Date: Fri, 4 Sep 2026 14:21:13 +0530
Message-ID: <20260904085114.3385530-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Q9riJY2a c=1 sm=1 tr=0 ts=6a9a8692 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=hLtf2njn-erSVrlKzigA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: NgTKYJy-eNUSL4JG8iFvV9khZuZU-Yyp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX5m1S5CxS0UfK
 kBikk1I/jCTdF//u9qCbM6TapOFrbwPqTH6VBaWZJq3NBq3WdFDewCZ35RbwBPOIUkZHQPkhwT6
 Y9+5XHtab4P7C/vgAHlmBI28FFZAUenI9uRwgx0nKmusaiXpW+uIScw/2rn4pWsQdpIbSP1xlX1
 KIKGC11t8pp7KSe1C/eYgN3r9gorZqIwD5x1b/BwRJgVgg4RTX4iIsCAS4ebS/Cq6ZDtASPOx1+
 PrOW87fo5eKT3tq0a+gsA3Cu4lHSo4JI9ldUPgkfEAUt/u5XfSb06/nlbjkvHs+MY3rsD7rCcGG
 pCf5XiqxUAvF0TvmE07j8qZLhi/WGAhGVHhnj9+4TR+ka3fuuc+xbstThutV1Bt4uFF+r526edg
 9F7iGU61c8FGtg0s6lW+qrTfqnFIP/SfBxVy+j4sWZy6F+nJBbXMPa+5WNodc8qM9uCRhFLO2q5
 qWKGMizxcIwz8rFq9lQ==
X-Proofpoint-GUID: NgTKYJy-eNUSL4JG8iFvV9khZuZU-Yyp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX4WucmG46pmQg
 ZkDF/OsYNpWitaYl8hKvAl75KZ4GplOtafXosIoe7PfV/YLeqwUKwdITqFvGrcmDtqUM6kuW287
 SM852CYGJKG4bXEvmqXgbqtoCM+8fqE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01

rvu_dbg_rvu_pf_cgx_map_display() locates each RVU PF PCI device via
pci_get_domain_bus_and_slot() when printing the PF-to-CGX map. It
assumed PF0 always sits on PCI bus 1 and derived other PF bus numbers
as pf + 1, but the AF device can be enumerated on a different bus.

Use rvu->pdev->bus->number as the base bus instead, so each PF lookup
uses pf + start on systems where RVU functions are on contiguous buses
but do not start at bus 1.

Fixes: e2fb373038654 ("octeontx2-af: Display CGX, NIX and PF map in debugfs.")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2: Added fixes tag, and fixed domain number.
	https://lore.kernel.org/netdev/apqE5CT5_M4coO0m@rkannoth-OptiPlex-7090/
---
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 22ee99676879..904374baae6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -829,19 +829,25 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 	int pf, domain, blkid;
 	u8 cgx_id, lmac_id;
 	u16 pcifunc;
+	u8 start;
 
-	domain = 2;
+	domain = pci_domain_nr(rvu->pdev->bus);
 	mac_ops = get_mac_ops(rvu_first_cgx_pdata(rvu));
 	/* There can be no CGX devices at all */
 	if (!mac_ops)
 		return 0;
 	seq_printf(filp, "PCI dev\t\tRVU PF Func\tNIX block\t%s\tLMAC\tCHAN\n",
 		   mac_ops->name);
+
+	/* All the PF devices are on contiguous PCI bus numbers, but the PF0(AF)
+	 * may not start from 1 always. Hence get domain and bus from PCI device.
+	 */
+	start = rvu->pdev->bus->number;
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		if (!is_pf_cgxmapped(rvu, pf))
 			continue;
 
-		pdev =  pci_get_domain_bus_and_slot(domain, pf + 1, 0);
+		pdev =  pci_get_domain_bus_and_slot(domain, pf + start, 0);
 		if (!pdev)
 			continue;
 
-- 
2.43.0

