Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21395478E57
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969883; cv=none; b=FTaRv+KY/cFoUMwrmhYdbGnjQR1UpiL+z8nH5vqql4gpf2h1zF7sbzsj6rn+nkD18iKA6KYWpLUt26DB9pDbSUDqyD+/JP5qrxlEu3R5hPA13YP8o4OP4iur9OLT48ka6KvyiQ/OR0oIPAp0NrCwMsFL+OVWPa4pZ7pJPTdK0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969883; c=relaxed/simple;
	bh=5QRYdaHzYLMd1OIi/FeuqvpDMR7ho4y3kN+D+5uMtKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIyzY4laOz//ihK1CfdxmqOAVU+Zfo2kXB/gXjjAhnZNGgZxE2FmJyFgLatmrRFjuS4jA8qF/wZ4svaWt+em4DkHnvfuQt9lv9hnTVzb7o9nibiXpzkm7ptkBc669pLkKBL9qrkF+dBB/UzZkQuFHi5EW27gadiSURs+PGhZF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l/QqwisH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l/QqwisH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HlrjN316157;
	Wed, 5 Aug 2026 22:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ehEmUC7YmgNmZI//a
	LROybic21o28hl65gzZpo7wk+c=; b=l/QqwisH+3rN7PKl4tJ1GeWMCGkwa65E5
	uHUXlKJwR4PlHI/6CJS8eXqubJikPqIGTHUE6bat1VpSTjEmHmD64Ga7Rb29v7Bd
	E6M9g3zZUMqhCvaquq3PwP9V/pp3sJ3Z8IfaLqGIk1fQn7FmXkp1qoBguTzuezpV
	/AT9r5iXVWuoOOxCp9087Ml5u8lgdMo//AuGHQbOUFjpMi5utUU0B6FNEvUFApgh
	gR1JrVqGK0U8ypxJMEcszJUxqLKcD5k4cXQO9pmjhAbI/WhiiG3lr2YekB02myIm
	BRBo3hi3OhcBgephVd57eLL1djvM39tnk+/DB4fK4R+0yyH6PNqGQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a45d26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675MfJSY022281;
	Wed, 5 Aug 2026 22:44:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k8nf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675MiUKN53936464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:44:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E7EA5805C;
	Wed,  5 Aug 2026 22:44:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FCE158054;
	Wed,  5 Aug 2026 22:44:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.135.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 22:44:27 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mmc@linux.ibm.com
Subject: [PATCH net-next v1 5/6] ibmvnic: allocate a new long term buffer before freeing the old one
Date: Wed,  5 Aug 2026 15:44:00 -0700
Message-Id: <20260805224401.58791-6-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260805224401.58791-1-mmc@linux.ibm.com>
References: <20260805224401.58791-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a73bcd1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yp8KHkDamDrUkzBX:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Jd2wlpY-SieSRpusQl4A:9
X-Proofpoint-ORIG-GUID: XGHon8NxhBVABKrYKLvE2ZZDxvM0h8PQ
X-Proofpoint-GUID: 510HcwuozjuAiZZk-pbUNzZna2fqWqgK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfXxvRzJ2qQehVx
 tDNtpgr5ET9gTBSfU4Oz/jJoRB5DlwqkmMOg2kJ64ZyUCWOMqILc8grvtBDi2YoDNgXI9J7Q3NZ
 pDQvdr9YD3qS/dIj/AAGuUzz5NXduHs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfXyrqKj17NIuta
 sVWmSiUUwSYyYZKfouicYBxqTSlXI3/+z7F3Sj+Qg6xBAqlYyLllIkBNV/ZSVpJxht+seZYUc/Q
 HJCPXs2wUvdeGpNgxtw/GnugRL32FAvt2+AJ2z2wOaxZB6bvdcARmvWWsjk5gAxoyFzkdEikDUc
 jlX3CWckSu5DHqCClcbRuy8/PempuLYe7UPO79NfyoHKsXrTc//PsUNHkWhnpx9ngA1llnietDb
 2GVFLw1+U+dnGsxHqXM+Steyi4+cEpzph6fXEDB21x16c7hbLr0gDwZVNTR5Kwfisd/CxIu7VIm
 vBiUblJTp/VgFv+CV2bSf4DlizmhtFx3/pfPfwJ0srC2T3o1rSJ2h9pHdTYnLuqjLHqJl6/Wn/c
 DiP6ObWi715GbbFCr3Stqc44mWW1isXDzewoxnVz5tFogMdU4fY9VztJLofHEkzx51cfvlUaZtI
 xvhuF5+myD/gjvJi5pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050183

When an mtu change grows the pools, alloc_long_term_buff() releases the
existing buffer as soon as it knows the size has changed, and only then
asks for the replacement:

  if (!reuse_ltb(ltb, size)) {
          prev = ltb->size;
          free_long_term_buff(adapter, ltb);
  }

  if (ltb->buff) {
          ...
  } else {
          ltb->buff = dma_alloc_coherent(dev, size, &ltb->addr,
                                         GFP_KERNEL);
          if (!ltb->buff) {
                  dev_err(dev, "Couldn't alloc long term buffer\n");
                  return -ENOMEM;
          }

This one is megabytes of physically contiguous memory, so it can fail
while there is plenty free. By then the old buffer is gone and the pool
it belongs to has nothing, which takes the interface down.

Allocate into a local buffer and only commit it once the allocation has
succeeded. A failure now returns with the old buffer still in place, so
the mtu change is refused and the interface keeps running at the size
it had.

Both buffers are live across the swap, so an mtu increase now needs the
old and the new at once. That makes the allocation somewhat more likely
to fail in the low memory conditions this is meant to survive, but
failing with the old buffer intact is still the better outcome: the
caller can decline the change instead of losing the interface.

The new map id is taken before the old one is released, so the two
differ across the swap. That is harmless with 255 of them.

Fixes: f8ac0bfa7d7a ("ibmvnic: Reuse LTB when possible")
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Vaishnavi Bhat <vaishnavi@linux.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 24c8acc42a93..88d0c231a74f 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -455,6 +455,7 @@ static bool reuse_ltb(struct ibmvnic_long_term_buff *ltb, int size)
 static int alloc_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb, int size)
 {
+	struct ibmvnic_long_term_buff new_ltb = {};
 	struct device *dev = &adapter->vdev->dev;
 	u64 prev = 0;
 	int rc;
@@ -464,28 +465,29 @@ static int alloc_long_term_buff(struct ibmvnic_adapter *adapter,
 			"LTB size changed from 0x%llx to 0x%x, reallocating\n",
 			 ltb->size, size);
 		prev = ltb->size;
-		free_long_term_buff(adapter, ltb);
-	}
 
-	if (ltb->buff) {
-		dev_dbg(dev, "Reusing LTB [map %d, size 0x%llx]\n",
-			ltb->map_id, ltb->size);
-	} else {
-		ltb->buff = dma_alloc_coherent(dev, size, &ltb->addr,
-					       GFP_KERNEL);
-		if (!ltb->buff) {
+		/* Allocate first so failure leaves the old buffer in place. */
+		new_ltb.buff = dma_alloc_coherent(dev, size, &new_ltb.addr,
+						  GFP_KERNEL);
+		if (!new_ltb.buff) {
 			dev_err(dev, "Couldn't alloc long term buffer\n");
 			return -ENOMEM;
 		}
-		ltb->size = size;
+		new_ltb.size = size;
 
-		ltb->map_id = find_first_zero_bit(adapter->map_ids,
-						  MAX_MAP_ID);
-		bitmap_set(adapter->map_ids, ltb->map_id, 1);
+		new_ltb.map_id = find_first_zero_bit(adapter->map_ids,
+						     MAX_MAP_ID);
+		bitmap_set(adapter->map_ids, new_ltb.map_id, 1);
 
 		dev_dbg(dev,
 			"Allocated new LTB [map %d, size 0x%llx was 0x%llx]\n",
-			 ltb->map_id, ltb->size, prev);
+			 new_ltb.map_id, new_ltb.size, prev);
+
+		free_long_term_buff(adapter, ltb);
+		*ltb = new_ltb;
+	} else {
+		dev_dbg(dev, "Reusing LTB [map %d, size 0x%llx]\n",
+			ltb->map_id, ltb->size);
 	}
 
 	/* Ensure ltb is zeroed - specially when reusing it. */
-- 
2.50.1 (Apple Git-155)

