Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07691432BD9
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785578983; cv=none; b=ucRDx116p9Jpp91vVJA8gj5eizeM6citor0gL4ugxjhjjQBF4fMfjiHXxlmYJTTIgQE+AXewC0OwZXzSYN8XtkyVlITic1VIeBDgj1ktcle33vkVN3808Z6xq/TRyOaDBrNCsloPEjTOsbcdoL1pb0AhLjeA56LOkREUeAmc4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785578983; c=relaxed/simple;
	bh=nbhO8ao3ySptXDKq2nua/MJiCu7VlbT87yHkv/IMa1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMTe+sElzcVXgFzB27KY4pwCs/cynTq3Mx3sMPVrnhxb3i57YhasTL8r/cqTWSRSB0nCu5ABJRsFAmIhpvNhKESxlCDlm2ynso7caVX711cglK7tLIl7OnM0XjCyaD1bC1lOVbYXsHCICU/EHgGUJJKCzXIW/4bQDsQGw+FWhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YSkn/VnY; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSkn/VnY"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671A5j4G1889309;
	Sat, 1 Aug 2026 10:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8x2cmk1B1sG88oQqpQBLaHJX0GZG+
	kX9glaNlLhNBQg=; b=YSkn/VnYp1Lyvj/CY0ypLB7KAdxYhm52EnuZe/oGaOv9T
	eRLf4zIpGlUk56HYKuZFcUuGCHIIwPuPCT/OOGZtWEldF6X/vJYQTsdJmQvB9t0q
	Vzwn0+vYBbABfUBbmneuuzDoqZDX0cwDDcxwiJN/2DeQJW5345LSy6B5xuq1xs5M
	c3jpYTZ6gySlnp5iJT2mNf8VnrS+OhAZpkwC4Pw1nyvBEgfEveRfGXWSkHubsEqA
	0aQKdgWOdBuETN2R2watqZi8fPg4Uyq82MsfA4EmYa7ePn36Ia1IU5ojL/VYFoAZ
	/3zXfZbawDI0faYvMo21ragp96APgHLPSN/pen01A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs77ehdmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Aug 2026 10:09:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 671A5W6n001432;
	Sat, 1 Aug 2026 10:09:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78r1sar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Aug 2026 10:09:28 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 671A9SVZ012121;
	Sat, 1 Aug 2026 10:09:28 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fs78r1sa0-1;
	Sat, 01 Aug 2026 10:09:28 +0000 (GMT)
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: rajashekar.hudumula@broadcom.com, bhargava.marreddy@broadcom.com,
        vikas.gupta@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, alok.a.tiwarilinux@gmail.com
Subject: [PATCH net] bnge: use int for bnge_fix_rings_count() return value
Date: Sat,  1 Aug 2026 03:09:20 -0700
Message-ID: <20260801100923.1498570-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=975 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608010076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA3NyBTYWx0ZWRfX3uwR14mc+O4z
 ncKusX4Hvj9xy4du47I3I3kYCOGbCuCH3HLU94yoBlQzF0JuPs2qSJ5RwY5cgFNlz2zv1GQChS0
 WZFQlGlgvbf5xMz2wzTJ2NYlKKmL4E7qPS9Z15FvpovJgwtEwmu5L0kFefhMVfxr7dwVBZGWzt7
 KoU8ke5eoxkTuwOgcWBrbWQHF9x/fVWuVHMvQttg12fQE50t07JBZrLkNKxy8C85SGyOEQ6NNCh
 BlnwdSmfT71//zYnama6GxNWr4lg3Igu0PZdw5jc0PUTOmWNclQ0QGOEb8x9HUmcOIyq2rAQeTZ
 wRfITr8dGbJ1qSaEQDnfSNaoWK+6t7jSpetgdJ29unAoMipQVczFlPc23nAuY2rEhKfM8HX4KY8
 HieqYwUWBpbONqwnTFLIdYyb9lLjHloweNS7hdeMYp4H01A3QrfNQUdzV9B3/Ld4dqKXZTrYwMx
 A60xBJgkiaFyM5xWbSl+JN0rbJLuj0xTxa7LOdTo=
X-Proofpoint-GUID: zVwmiMgnuHDN0Za7By7o5m5DQ0ScS9w1
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a6dc5d9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=oyV_HcrR-YwniT-pQw8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-ORIG-GUID: zVwmiMgnuHDN0Za7By7o5m5DQ0ScS9w1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA3NyBTYWx0ZWRfX+SXo8fugaJKd
 AzwVBChhAKeBdESexcbF4ccAV64Gz8+gZBm3OPRiWsFyzkF2p+Grh5SBc5SKhRQmzMu+DPbeSau
 ZBaR3dgq+aUsmSOD4i+l/us1aZxMrEgXe2tvFMt4QknUG0v5Lv4J

bnge_fix_rings_count() returns 0 on success or a negative errno on failure
However, bnge_adjust_rings() stores its return value in a u16 variable,
causing negative error codes such as -ENOMEM to be converted to a large
positive value.

Use an int for the return code variable so that error values are
preserved and propagated correctly.

Fixes: 627c67f038d2 ("bng_en: Add resource management support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 0e94f092813e..4711dd4945ff 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -163,7 +163,8 @@ static int bnge_adjust_rings(struct bnge_dev *bd, u16 *rx,
 	u16 tx_chunks = bnge_num_tx_to_cp(bd, *tx);
 
 	if (tx_chunks != *tx) {
-		u16 tx_saved = tx_chunks, rc;
+		u16 tx_saved = tx_chunks;
+		int rc;
 
 		rc = bnge_fix_rings_count(rx, &tx_chunks, max_nq, sh);
 		if (rc)
-- 
2.52.0

