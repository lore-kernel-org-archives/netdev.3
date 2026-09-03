Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A594B5415;
	Thu,  3 Sep 2026 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446141; cv=none; b=YfP5SWyuLNuCCmNKQ1VnXAaayRbZypXvtxX3QywiyWD9SfHYjp+zp0CXcTkxOrB7b0eajSJ/CkgoRhHmUPyT/ru57N6HEIMXWfEGD5/e3LyIA+1Hzi824EOSrUQIorkw8qCdifBFV4WkVWbhX3kJPW/PqE18AeLptdThNN/9Okk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446141; c=relaxed/simple;
	bh=YjpaqXpvwSNhD5cxbWrTn7f9BvyFu9l97HslMp3oo/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxLStu61sEFJI5iws/K3jzfLzOj3PRjVClBORFoQ3APSFJYUn7L38AxDaHzAQkW5nxq0ZFjS4fYPz0eLJUi4i0Rxh524SFr/CcLEjEFB1dOAlEqIfNR8L89JfIZBHK2AXxyCqGau5Too/2GZYI/tAjSXPB0z2NDwbUS3ae4stZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iPKVQ3jz; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iPKVQ3jz"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683D6cjQ227829;
	Thu, 3 Sep 2026 07:35:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=DI+TtN4uQGUZT5m13PgQA9B
	E97AK+Mre10Xip4LDuDk=; b=iPKVQ3jzELex9MocaCbkzGwIexvsagQhDB62iTS
	7N4v6ohRjYNEEbkTn8DU6J4td1RQvZQDfZsqhJXTf3Nt4OIk0xUkOCpwtjXaFbli
	whnIor4iQjSt0cySsWd4Ygee1dkJViPIfj69fpsrUG2ZGJ7BuMRTQqdXhiMvnA/h
	GaVIqeN5CsBKIvAbvnKKdhDOZ5WPL/wvTY+vj2NucZg5nLsZpn6HMy2xKo440O3U
	QDJdHjjVkGivI7R3GEz+doIaV4lF3poKmrchQ6PsNWkdX/vMa0NHkO2SH2aGHqmU
	vzzl6F5DFiFJcX5Mq0qZ7xGtcOmsN9UubOnV96W6qZaLvRw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gef5b52tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 07:35:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 07:35:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 07:35:22 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id BB5A63F7052;
	Thu,  3 Sep 2026 07:35:18 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Geetha sowjanya <gakula@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] octeontx2-pf: fix null RX segment address free
Date: Thu, 3 Sep 2026 20:05:15 +0530
Message-ID: <20260903143516.2697708-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNyBTYWx0ZWRfX4KtV1qYkcTbP
 UqiAWj4Qkw8G82YSsvz0oHQzb0l9t6s32gkcOCaTUAxySWI8qFO3XUoLVgTMIPvvEk4jYCViz1e
 HujdUKa0Hybp6hav9MDaqYn51nTDGRfJYbEFTgGtivggk2VxICMF5sesZyZu6PgvwUTdFCYPh9u
 2oMrsKRZBKC1x3PZfJpgVM3fZJezlDNMnJnP1fo6rocf/VvhaL+M8vYpHIng5gO6yGofpQ29YRJ
 hYN+EbUX4NCGy+NwSUppuBFPZ/M9g2Bv9aWQQiUjHh3STtoRxrPVhK8aikKh7UcQlrElVb5CAXx
 zJ2FNmkyaMIiYvw3BYPYvoii+jjG+iPNIaWp7uSGKeD6k5SMDOME9MdfoGf2XoldglWsQ2TSN3b
 Zy03Bo9XwQtlt1XRV4yv9JiYkrQpJI2q8mVewMqBXjESQt+/hsQqyCDnRf/M/H/kxMYfuYY0VPC
 GkiWXyxCYNzn/DjXe6g==
X-Proofpoint-GUID: p5RvlBYcphUB7z-dX6GFb9ngqj_VKNzX
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a9985ab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=RKXXwRgqdNSa3DIiABwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: p5RvlBYcphUB7z-dX6GFb9ngqj_VKNzX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNyBTYWx0ZWRfX7WPruttXJPlL
 PuhmbAo4EdbcE94GMsNOIQQl801EiP05dCCtHGh0erOHFkVNIRU4KCdbnKCcAuWjX5Uzsp/6+be
 kawwRWqVHh2IAj1/yA7SJTcAIEN2vHM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01

From: Geetha sowjanya <gakula@marvell.com>

Avoid freeing RX segment addresses when the segment address is null.
This prevents passing an invalid pointer to aura_freeptr().

Fixes: b1bc8457e9d0 ("octeontx2-pf: Cleanup all receive buffers in SG descriptor")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 8d2d607bc92f..a9aefd14ae52 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -256,9 +256,12 @@ static void otx2_free_rcv_seg(struct otx2_nic *pfvf, struct nix_cqe_rx_s *cqe,
 	while (start < end) {
 		sg = (struct nix_rx_sg_s *)start;
 		seg_addr = &sg->seg_addr;
-		for (seg = 0; seg < sg->segs; seg++, seg_addr++)
+		for (seg = 0; seg < sg->segs; seg++, seg_addr++) {
+			if (unlikely(!*seg_addr))
+				return;
 			pfvf->hw_ops->aura_freeptr(pfvf, qidx,
 						   *seg_addr & ~0x07ULL);
+		}
 		start += sizeof(*sg);
 	}
 }
-- 
2.48.1

