Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774C351C04
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525799; cv=none; b=UyG62S/Mw6DK0IpujThdnaVL/G4pj5aHQB4jXBBlinwNzRBlEzIuLmqUz5H3RtKtZpxb2q/9uspPoj+PGSWGolT9chl+MEvS+HNZ4qfvcuIxp8BWa9wRsBFhSawypn+zHIfPipQY0M1+ewfC+Nre6SfciLDBrYGu0x2DAZYu96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525799; c=relaxed/simple;
	bh=X61QJmakFvghyjzpYKP6SHPMX/LziTfFqpAQgTxYfxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beOGFiNOP8RzG7CuBQQCiWeoN/lWMv43sbAhCV5dGuWPEq1Q27lYWO2bUsk0FbKR58mtrHRK0mWVjtr9vK7TAFOWGPHSaHMDppOLl6/IRDIwSJ//8l1h7dnZ2/k4ik4Uw/fuEl6qiqBp8v3SVTjqsxSGXvrvOZ4tyLUXRhj7VBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CFQkq0HJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFQkq0HJ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VH8Xvl4139375;
	Fri, 31 Jul 2026 19:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=qzWXRII5lMnyqpCmXP8qKG42zrfZZ
	s/JLxLGf9vusGU=; b=CFQkq0HJ9dZk6Sqy/ffouddLp9nVlZ3hf+k0GsFa7yPNh
	AKYTuClivvW/kQnvglk8M9orwnfiZGG/TeVEFBf/3jfgN26eX9dW7+ZLliFKOrwh
	JYcXP3NphStbvviccS/E4N6lZoz9Kcpzj/cc7FXJ9sgiYxM7OrxLesS1xdo4w7SL
	QrGZGKf3tNBS0jDVQFzn6PK+j/b4IWBY20r2BbQZvCpWxAHshx82D1i7p2YMBjFv
	5+Cg8aYgT3RWdiyl+pmw4euG7DbkEJGDsAmC9X43cnRZTDz4j1I4vU1rihuOAgzZ
	ijAKGYOWSeUhBN+Up8iA5RCya+5mim5Ndb4yhOCTA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr01bp5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 19:23:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VJKBDM034199;
	Fri, 31 Jul 2026 19:23:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4frtugt6tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 19:23:04 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66VJN4rQ004422;
	Fri, 31 Jul 2026 19:23:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4frtugt6sy-1;
	Fri, 31 Jul 2026 19:23:04 +0000 (GMT)
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: leon@kernel.org, siva.kallam@broadcom.com, vikas.gupta@broadcom.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, alok.a.tiwarilinux@gmail.com
Subject: [PATCH net] bnge: Fix NULL pointer dereference in aux device release
Date: Fri, 31 Jul 2026 12:22:59 -0700
Message-ID: <20260731192301.1427645-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310147
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0NiBTYWx0ZWRfXzVQLQrRJDg0h
 CEOyDzEcPKjh38q/fnYgbIPTpexqU0J/XWOXnL0q2pFn9u1SKh0UrH5EpmDvEunXMwABCjUHBKQ
 fjscggMyRWkl7w2iXW3Jsj0Byt8i93SgASIV9wB5LL3sSbVaPHIb
X-Proofpoint-GUID: q8uu1DAAqj1UA6Mpwehzd4CTv62qbBde
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0NiBTYWx0ZWRfXz9JvyBKpbn6z
 oCH7ve/KEqF6omoflFqVXcPkATsaYKPqFkeIXp5wPKxEZdGH/EjsBDBv4CckJYilEKGkRZuh7v7
 y8EVvZCISjFiDda94JUks2gfFsReiQSBPic6l/gI2vduTw3tHQPFqA8ai5TTkQi9rfBVUecBKjq
 7ilPCHIaGY7zXT1I5oHfaED/w5L8outP5MGOwgwxulhPsR3i2ZvdOW4kJ9W/4g/V5SlPbtFr/UP
 FoSN3g2IDY79090PxmdXmJ7xQU8g4BA0vKS7faTapz4dwqR1HrA2qvPfHGEc/ruuN4YzuYudhwb
 iBOqO8xIttTPIA+3WopXCRioVMjSLeBK5ktk/BchIGjgqNfSw1PEVttcGCGV2r89ShRwCgZoFwk
 ervlIiwBln9aI3XxJSRYRhB4Pab2dWQM0afNoEWt7GarQck5U14GvcIa+fhHAnWn5DYQBeF440i
 OnBiAns1mP4MbRJwEDw==
X-Authority-Analysis: v=2.4 cv=KL1qylFo c=1 sm=1 tr=0 ts=6a6cf619 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=iK-9IKd76Cp9_lFYzUwA:9
X-Proofpoint-ORIG-GUID: q8uu1DAAqj1UA6Mpwehzd4CTv62qbBde

If allocation of auxr_dev fails during auxiliary device setup, the error
path calls auxiliary_device_uninit(), which eventually invokes
bnge_aux_dev_release().

The release callback unconditionally dereferences aux_priv->auxr_dev->pdev
to retrieve the parent bnge_dev. Since auxr_dev has not yet been allocated
on this failure path, the dereference results in a NULL pointer exception

Retrieve the parent bnge_dev from the auxiliary device's parent instead of
auxr_dev, and free auxr_dev only when it was successfully allocated. This
allows the release callback to correctly clean up partially initialized
auxiliary devices.

Fixes: 8ac050ec3b1c ("bng_en: Add RoCE aux device support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
index 67e93e17d4d9..0955b488b6fe 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -141,12 +141,15 @@ static void bnge_aux_dev_release(struct device *dev)
 {
 	struct bnge_auxr_priv *aux_priv =
 			container_of(dev, struct bnge_auxr_priv, aux_dev.dev);
-	struct bnge_dev *bd = pci_get_drvdata(aux_priv->auxr_dev->pdev);
+	struct bnge_auxr_dev *auxr_dev = aux_priv->auxr_dev;
+	struct bnge_dev *bd = pci_get_drvdata(to_pci_dev(dev->parent));
 
 	ida_free(&bnge_aux_dev_ids, aux_priv->id);
-	kfree(aux_priv->auxr_dev->auxr_info);
+	if (auxr_dev) {
+		kfree(auxr_dev->auxr_info);
+		kfree(auxr_dev);
+	}
 	bd->auxr_dev = NULL;
-	kfree(aux_priv->auxr_dev);
 	kfree(aux_priv);
 	bd->aux_priv = NULL;
 }
-- 
2.52.0

