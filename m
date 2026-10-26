Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986734;
	b=KiOjkCZy9fFT0bJG0ZMef+o7IFdnC8fc54Amp4HiUL2bWU3U/jKNcwn9WVRnb6aMStYr
	 vu0x2LCIWUMEfBYea0ANI8smgd4qUYvCzR+sMO45CgZvZ9tL8Vdq8iFELz7guBIlkOGsw
	 ADvmySZ/C2IgEiKiib4BgfEJfHGbiMYUh/wYB1mkgpaWn8SWzxkhxkcwXggntWCvH5AYa
	 +1Vv7LzF+rXu9kI2Ompte8iSmY2i3NIxrcavT4HfeQ+78ZqSB+rjsuD5+udD9hjNol86Q
	 jHYJvd/NKbLDBCafP7YwWIUtSAdZMIx/5S+6CM/ZdL+R+Yz4/RcciRhi+anuq98lutA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986734;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=HoeyBWH1te1eTCZ2bZ28xJlfnxSGCqJ9pUcy5XqPRyw=;
	b=p01oVlUgsNOEOLbEVjLMNXZGQRnW3NAeZGS7NJ0eudzoA2+OaiNv7fAOTWKvHvRI3N28
	 8vMNz3UrRR20gBJ4miBo80kA/phfSmKccDckvIzKe7hNUuuPNzrb438enxddBZRoHjq0b
	 DVs8aL/5a5IUs570P7QJLeiXtJRAEmCbESYxVlXZPm0OqhnGIBhHVZERk8Q1TA+HaKcjP
	 nsLUzev1nj+guMmvaQd8R3ezPnxxofOlIoVA+dQ85o3Nqmgmjbf2sDxguG0f4wI5TGd5D
	 5stxa14sZjdyV6QfOHXuE+ssrQp05hI1IHO6Lqw7Qcb9vM8JsM1LOI7Gsjm6d3TbuNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=jN4dJgSC;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50791606A31A;
	Mon, 26 Oct 2026 03:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50791606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=jN4dJgSC
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2NTA31869800;
	Sun, 25 Oct 2026 20:51:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=HoeyBWH1te1eTCZ2bZ28xJl
	fnxSGCqJ9pUcy5XqPRyw=; b=jN4dJgSCbJS7JBXn0jTH1UCesOWXlCDPB2tofxX
	5FMMZHfHcw1PgtJPqQlnXji8varWQoB9qTB7F6vNuWSKYbODmuJJC0mZHXDd6QnJ
	ZfdGqFjT2MPoH/yh43xYFarBFIOGiG2BFtu7w0/uOcZt/YOvmvKh5FAIuIAhMRYb
	o0/kRQr/a3mh/1FfP0yoVLkEFFo+VuKTCkYlsK42F7M6rOvygTBpzimf1oAyZeaN
	cb268hrTHlY8C0TuXL8En8s3kY3GtANtgcY4wVufGCMSSNFiDeit6kg1b9O1/0Mr
	lHXtkOXVhFQOd6KUHOluMKZYYsTlev0LW5hLcXmxmBF3LoQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hhde826jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:51:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 Oct 2026 20:51:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 25 Oct 2026 20:51:52 -0700
Received: from localhost.localdomain (unknown [10.110.24.192])
	by maili.marvell.com (Postfix) with ESMTP id D799E3F70C9;
	Sun, 25 Oct 2026 20:51:51 -0700 (PDT)
From: vmukunda <vmukunda@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S
 . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        vmukunda
	<vmukunda@marvell.com>
Subject: [PATCH 1/1] octeontx2-af: Fix npc_delete_flow counter read for cn20k
Date: Mon, 26 Oct 2026 03:51:40 +0000
Message-ID: <20261026035140.666684-1-vmukunda@marvell.com>
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
X-Proofpoint-GUID: orTrNDOk8T5fd7b1a7rZ-EpaLARH8_fn
X-Proofpoint-ORIG-GUID: orTrNDOk8T5fd7b1a7rZ-EpaLARH8_fn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxNCBTYWx0ZWRfX/DdcPoqiqGhB
 3HkjfvakP1EW4XaGf1jY9Emq6jJXvx2rM8L1efYGcNQnJYmCBGDyGvRVNtcK2njBvauAuGmmXNe
 +BXk/4Hhd/HVr6Er0ObP7tVLA2IDXhI=
X-Authority-Analysis: v=2.4 cv=Vdlir1p9 c=1 sm=1 tr=0 ts=6adece59 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=j3AFsqOYKst2VyhahHcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxNCBTYWx0ZWRfX568lv6P59+ko
 V2IwejkjjCoTo16tkvmGDIJHJOKq5jKKnur7OjfUOPedHerRd+KdsVAEB9wfYTzpgyc0Tnhl12+
 dRRIlV4qCL1jMhoDoUGjimvyHtWESJAodrXyRYgMrUXOov1408YVWWArQtbaV8D0Hpj8TyWVCAP
 8b3BJws0hmyAsAt3p4g4y0dMMNp+g7NPo5GdM1haC+FJ+/H1B2PfwhCeql1NHSz+ajLNO/USw/P
 gldoX9ZquexF9oSDvewJT6BznS39zJrBhFzPojFvj1YzBUxtprD6T7DFJab00OnVD6BA1jYWQUF
 By7FFhsFZWuAFv7V6uKeKhhJZ5CT+HHKc6FaLbijOuYph99Z76QD1D/DXCmEmoHqDztUAcYRyPZ
 LSSw9y+ZXKrtKS0v1e1ol+zjVqowNAogEbLFwNxtrOkijWtivd+ZkE70+SlIxL97gLitwNt49Or
 aWJ+EHiU3ehG8V9S/oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

On cn20k, the MCAM match counter cannot be read from
NPC_AF_MATCH_STATX. Skip reading the counter value in
npc_delete_flow on cn20k. Counter support for cn20k is TBD.

Fixes: 5f83b4729440 ("octeontx2-af: Do not access match stats for cn20k")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: vmukunda <vmukunda@marvell.com>
---
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index ea5d462a66ee..f3b0b082443b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1960,7 +1960,7 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 			/* single rule */
 			} else if (req->entry == iter->entry) {
 				blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
-				if (blkaddr)
+				if (blkaddr && !is_cn20k(rvu->pdev))
 					rsp->cntr_val = rvu_read64(rvu, blkaddr,
 								   NPC_AF_MATCH_STATX(iter->cntr));
 				list_move_tail(&iter->list, &del_list);
-- 
2.25.1

