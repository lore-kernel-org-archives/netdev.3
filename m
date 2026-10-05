Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07E5474E;
	Mon,  5 Oct 2026 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180525; cv=none; b=aZZEKbzjywBsEL35eXTCF5FPi3/3n7vyJQkyGxdD+jvUbJCe7d9C8QXjhf8vLXDI4bwob0e62VOwK1IUsd9j16HQ3KgqjfgLVSwnnPrIsToK1SYjfuhCmezSa99RWd81xAp9R/aOuVAGMpVPFL6vOiYkRW+mq9N8o0olkEpSgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180525; c=relaxed/simple;
	bh=IwroYdYlZxwAxTWh/Oc3ZrvlEGtbCxxZtggzaBg2pYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QDeofi6bjSuqGUpy6tOmYpEUx0sZstiC+KJSFwoWbge6hMJisiN0Vl7TUxcvLQNbOGl/WEhOPsGLuHBeMyd1fEpBBR9Sqeq2MroJ7mGHPX5JTHjzrzezLdxx2Y3qSXMINYIvl7bZdO6bD+mosqEYvaTsd9yGU0SxZlDfufvrDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JgFHL1sc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JgFHL1sc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69516KCK2067199;
	Mon, 5 Oct 2026 06:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yY5Zy0AOMIswvDraE
	QovtE1WInwOnlfvewvx1gJAqUQ=; b=JgFHL1sc4G5x1KLDEttJYUIaI+9Eyb2re
	tPztDU/IZyj9cD2p3vccFUZGp4/EBKdo5g5Zp/4tT5gS97Xl3abOUvgN5mrAbQmK
	+zUwyRAh5aXhu9ZUsm8LcQT9QbagO7c2nTZvr4Q0lrw8nP/qMPaB8k+Sj2X68ZnC
	fMeoThvoJJSgRIwiwkyXPG8ohU573YOYYSSszKZv9odoJ/ePJRITr337PlD5ViQZ
	UtqnTJdABDlo53+zIY188VNFIta69a0Ud55yy9UAJn2eINB13vm/gwXZ7VlGy5Bs
	xgTHcSgPGTLQvOEHkYPL/4F6+Z5avh9lZq1H605if6JQe7fPGX+6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fr3h2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:08:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69512ojf2142366;
	Mon, 5 Oct 2026 06:08:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jm6eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:08:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69568Oip32506602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:08:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F345805B;
	Mon,  5 Oct 2026 06:08:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4528458059;
	Mon,  5 Oct 2026 06:08:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:08:20 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/8] ibmveth: disable the reset work before unregister in remove
Date: Sun,  4 Oct 2026 23:06:04 -0700
Message-Id: <219666bf36377a7b67d14281fb0b57332c3dab15.1791178212.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1791178212.git.mmc@linux.ibm.com>
References: <cover.1791178212.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac33edb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=IlR5_4QjEJt1gQzRlPQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX7hUS4Z6xagZ/
 zdz/4PALQDcY3kX0Q/aWEtLZ3Xrgs71gWYdNNfPO116TIOwONhhFh3o+ZrqI4H2VqnyWKsNBQfP
 uic3ms3xjUR1/ncdUMrEyjxWksW6lPFe05iQTE3V798sr/evNcKJ+U/kM4iQWXV+bS5J/wS/0xC
 fVC1qwFczyU3qQYrx98DqoH1y0TQT82AFkuxr6/38uIJZZNNei4HZVqeqQa2R1E4RJvwvQvB0mi
 c1pt6VaRYmoE55hyT94FtszAzWUxdHJhF/MuMBVu5pPN6FQSo4ZIWfzcfB8gflyWXE19EPkpdrr
 lojZerfSlnPqjp9xUuf7EuzggfE2BpjK9JaNnWBYIjMO2fVpdCp0Iba1/piu1Ir/A4B/FL85xYN
 7Mrzhrult5qEVKsMHDT+pUItTBiy1dqvHIA3s+TdeXIz+c2pwZlxl8N2KDNg3A356sOinycFPf9
 HhHgCWgJ3RJgR+WEzFA==
X-Proofpoint-GUID: ngPXV_Y1QdmOYgDdnk_d2xPNku-SI-XI
X-Proofpoint-ORIG-GUID: OTmDrWmKh5eVyuFEPFIzlpf7JbtiPToI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX3q3o5206m92T
 7+bkWKzqguawcTNzf+HV5NOhd6bjjb9F3rLFhevl9Tzs9VF4aVP9Rvr6AGLBKJqPwoWFeNuMegt
 4V4KFrzv/jKpQ96/Mm6Beng/Pfhb9Ys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

ibmveth_remove() cancels the reset work before unregister_netdev(),
but NAPI keeps running until unregister closes the device and can
queue the reset again, on an interrupt enable failure, a bad
free_map entry or a bad RX slot. The reset can then run on the
adapter after free_netdev(), or reopen the device during unregister.

Use disable_work_sync(), which waits for a running reset and keeps
the work from being queued again. A bad RX slot also makes poll
spin, which can stall unregister; a later patch in this series
fixes that.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; it was not reproduced. Tested on a POWER10
LPAR with unbind and bind cycles under traffic. No kernel selftests
cover ibmveth.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index dab571fe8dde..d269599f5a99 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1954,7 +1954,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	cancel_work_sync(&adapter->work);
+	disable_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[i].kobj);
-- 
2.39.3 (Apple Git-146)

