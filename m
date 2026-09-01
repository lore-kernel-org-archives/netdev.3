Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88596377A84;
	Tue,  1 Sep 2026 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238206; cv=none; b=YD7wKK/OAkZk72wgpWOUSTYi+icMqoPcappuE6cS3MzYekbXoLM9inPVkFVvXTSUfjvSajFOPyY3HQ72Wf3WucLjJ58BVXx0R9E5zWqTGxBdXUh1tZcC7MkbxCHdKVjBWsOc+0cwgvr3zKzg0lYMcpGQDZN6JWgDdGUI+p7JIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238206; c=relaxed/simple;
	bh=WVxocmgX9k+AeEIYfKvaUmFxJv+OP8R6EyLzP1Af+Nc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4aMwC8LWpX+KrjH/bBAIHqtmvCVNkoSDRiP0h+SNmyWxLew3U5nde0cJ0YQnK2QjNbDTX3BVnJnjzDtGz/3q3iYlfa614oh2VXPzM4P89wuwfCcWCe69TR48wZbnnoVXCoiSKMwbbYVaDb+j+TJaGwC8hmHsPt7AgGwiOJpWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NdZ64jCX; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NdZ64jCX"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6810peVf2701693;
	Mon, 31 Aug 2026 21:49:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=nLp/EazTo4QMgElhv8T2Khx
	FV83tBq3trTUvhs840wA=; b=NdZ64jCXE2qUBZWTkrlF6LW8V0llexYLglX82F/
	6P+juM+IDdz/IFkTJOrNgznGCwwbQ972li0Emjdr21H2RakelIqn5c2VF0kpy+2o
	8itZj5P/kJLu1T6lF8md4LCSC6S8kImT8ILqg4zAgccmXbGvBIB0ZsTcrv82GfPx
	f4gdltMGVctBto2uTShVzmlasRRyY16b1B4v/AqMhZ8Y/yLutJGPcfUoRp7oEIIE
	FbWfSafdACizD/wEvvoBkUKTJUxrXNggDHsR2cGjv1F6K1u/P/4Y7buZZ5SSjkQW
	dRFQpkE1iHEWsScfYe0gvOBFaX6R6O/E73+0zvd4ekmkoaA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbxxj6rpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 21:49:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 21:49:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 21:49:50 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 189F35B6926;
	Mon, 31 Aug 2026 21:49:46 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
Date: Tue, 1 Sep 2026 10:19:39 +0530
Message-ID: <20260901044939.2772845-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA0MCBTYWx0ZWRfX8Tcc1nwimslX
 HXAEbOxh4JcJI9hgpA28det/W6m+kMFveHbcSxGj64nyX5CQ+OxD8hU/z31zdy7NdPGXpS99UHw
 ie41EEkUGw6AUhbW9vCcgYH+A1m9A+o=
X-Proofpoint-GUID: Z_ZD28dT9mCF4UkEEIriVu1rXfWmCKrX
X-Proofpoint-ORIG-GUID: Z_ZD28dT9mCF4UkEEIriVu1rXfWmCKrX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA0MCBTYWx0ZWRfX6pWbXU7nbJrs
 N+8uAgDuLE/BVNaIZLE5whKSa5EdUsdAZRY/TlxJR9Pqv5rFP+j1qW9oTHsymbOVlf7InsRZrck
 E6WMG6DX4N31fShkIEozga+71/iYBd78gWCgS/I08cCoc+R6WvbZWtYI8+EtD1Av1JNT7OVBCzw
 JZAtnHD7i0NvXNu7CvXLGfRmtBxFiQRJ2iPa62VjVdljaoT7TePc5YK7W90eBWFsjZ2Jz3F0UUu
 Ta7AWb/bhM2EG4NFe5Zr1QqDpe4dBMHJVHJdoaH+w08d0NpU8YFmugycRc5yWCp9XACHI2yryMx
 YuZy+v+cxvpnyu19BtVjHoVaYWxQRVEtqGJwzYif/zp8BbhQqvG1+md7kmOCu1yCMoW08RNXxBo
 TIAX78S10OaLsNgoIQMNpV5bSZm2cQaiFPMeXDnmXtao4abpT61PAIScdpfzq2IvioAaNulNUwJ
 yCbHtZYlsLr0RUIh7MA==
X-Authority-Analysis: v=2.4 cv=QuJuG1yd c=1 sm=1 tr=0 ts=6a96596f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=q3xMn_4gGrLeH3RnqAIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

rvu_dbg_rvu_pf_cgx_map_display() locates each RVU PF PCI device via
pci_get_domain_bus_and_slot() when printing the PF-to-CGX map. It
assumed PF0 always sits on PCI bus 1 and derived other PF bus numbers
as pf + 1, but the AF device can be enumerated on a different bus.

Use rvu->pdev->bus->number as the base bus instead, so each PF lookup
uses pf + start on systems where RVU functions are on contiguous buses
but do not start at bus 1.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 22ee99676879..bf0302c0c1fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -829,6 +829,7 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 	int pf, domain, blkid;
 	u8 cgx_id, lmac_id;
 	u16 pcifunc;
+	u8 start;
 
 	domain = 2;
 	mac_ops = get_mac_ops(rvu_first_cgx_pdata(rvu));
@@ -837,11 +838,16 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 		return 0;
 	seq_printf(filp, "PCI dev\t\tRVU PF Func\tNIX block\t%s\tLMAC\tCHAN\n",
 		   mac_ops->name);
+
+	/* All the PF devices are on contiguous PCI bus numbers, but the PF0(AF)
+	 * may not start from 1 always. Hence get bus number from PCI device.
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

