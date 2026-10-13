Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5A3ED13E;
	Tue, 13 Oct 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916285; cv=none; b=j22/KfE0Pu4gOZnxzs0/Qaeufc2kojdOGvmsw9EdY9QzUlPZK5yF82gAjoi1Tju5lTmHzKmk44e/ruvqsqEXhkvAhG7UHmUN5/QfEfWGbv+H71c+g9sJqdFgyQcCQjE9knRykpLilWkjo4Hv/NzmI9hJ0f9V351IuK+hPMw3xbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916285; c=relaxed/simple;
	bh=b09fdX8pNhouPOjX3yrwZj2/ft6riGwnBgvh7MOxIug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2NiHv8egJIzcM/r/4KW589eG43Oq3TFBH0EoT9yGMYzXS3tutkf4J0cKeCsZ8S2NLjEKOdNKro17HXi1I9QaGhBvdiaLSx7pXZWUovAR/4Vk6n4Jyn7xiq5ZYoe267xVX9ZRX1qXHS2O3xSxSA5ag0H2IQ0tcqt3AA4sq6bCPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lmz3jkOT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lmz3jkOT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDCdAV149292;
	Tue, 13 Oct 2026 18:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iYaEsnrQffQHD1Y75
	rM+5HTESQGOMAG75C9T1hmyTkU=; b=lmz3jkOTdEs3SopODM/u2d6+pajpOszki
	9/WbIDAxGvchTahN/mfjg13Juk15f3OJiHt3LRYcCLkppsC0WnbEJ7rpqvbNeHqS
	vYTVOQsd448kf1jZ/q0C8NBDpH6TM5CwrjVaJC09j6GyKrCA18VUEcIVdTutrL4R
	6ZTktNkKrx+/iTL84mc2qZeigSP3k5dH//Jf6boAaJmuRB83OoD1Oygp6RyrLuAx
	EUA7Zulfk0HKeu0PYNnqhOW0byMft/Nw6o9DPVuFY8CsJ3fdMbFQj6izkABeYQw0
	y4RsGBm/TAR0710szRdG77RduWDDrSDPyT0ybUzivlKEL3Eq0f2Uw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhg5hk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DIKllh2667224;
	Tue, 13 Oct 2026 18:30:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vuqu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DIUKVV65667564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 18:30:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E2ED5805F;
	Tue, 13 Oct 2026 18:30:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5D215805D;
	Tue, 13 Oct 2026 18:30:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.58.174])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 18:30:17 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, stephen@networkplumber.org
Subject: [PATCH net-next v5 8/9] ibmveth: wait for the RX poll to return before freeing the RX queue
Date: Tue, 13 Oct 2026 11:29:25 -0700
Message-Id: <20261013182926.30417-9-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261013182926.30417-1-mmc@linux.ibm.com>
References: <20261013182926.30417-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX1YUaWdYV/t2S
 afgAxrsm93RLl5BGgu1qtQGkhfm7I/hi3ZS15UsuhTz4E1SEZbYHkhHDQMiG8zQ6AaTPkCW9uiH
 82t/SOx2H5eY+TBCbbDlTQgKKp2uVGE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX3tvuoo7Ead4g
 UVfrp8P+HbEG06DfP2PhChz0dkhS8+nPwnOz50Tsyw/IgstdEPT0g43i+R22mKyEVDhslmJ7YI+
 2JVR7B2Xo20DqGH2974kFYIozCGaCknavxBYGjKSSjB4iKhQO5fHK9nVJULaaqzv2ymXv5nJoxl
 1Oe+UyJH55kwiu8tOfr38PGM/+4MvAvlnR1KMQnT5yVEqr3DjGKhmpfV0senIluk5zdb1+T80tH
 Jkux4ilTruq66+JzTV9dBKnznz08YBwjARUeU1MPkUN5PJYqpg8JvoFxhIYSLOYne8+HudCykU7
 G8LtUYixM0pXlHVM+yr2XnTQ4re3ql7AKKPPAzitppIjeFPYSRMyqCV0NhP1l3MCCQdHgfQXj7p
 YffayL+qSGinjYU87WcdKpoeeZVogfg0RuRnZEvxsvRzEqs+rHfjc+FsBf1+ntLTPIRR156EMcg
 9bAURZXxUYOo9X3pBeg==
X-Proofpoint-GUID: 0_-J6Vbzkpk1mJ0YCIusBrwqa994kJR6
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace78c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1jQH5Hc4uxvP87yPb2kA:9
X-Proofpoint-ORIG-GUID: w1OCBQgujhshcflORlzpY_9MMPZbOWub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130072

napi_disable() returns once ibmveth_poll() has called
napi_complete_done(), but the poll is not finished: it then re-enables
the interrupt and calls ibmveth_rxq_pending_buffer(), which reads the
RX queue. ibmveth_close() can free that queue in the meantime, and the
late enable can leave the interrupt unmasked after close() masked it.
The request_irq() failure path in ibmveth_open() frees the same memory
after napi_disable() too.

Call synchronize_net() after napi_disable() on both paths. Every
caller of ibmveth_poll() runs it with bottom halves or interrupts
disabled, so this waits for the poll to return.

Found in review of the ibmveth multi-queue RX series and confirmed by
code inspection; also raised by the Sashiko review of the first version
of this series. The race was not reproduced. Tested on a POWER10 LPAR
under an incoming ping flood with 30 rapid link down/up cycles and 30
rapid MTU cycles (1500 <-> 9000); ran cleanly with no warnings or
faults. No kernel selftests cover ibmveth.

Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
Changes in v2:
- new patch; raised by the Sashiko review of v1 patch 1 as a
  pre-existing bug

 drivers/net/ethernet/ibm/ibmveth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index f2570d637301..85e176d0ed32 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -768,6 +768,7 @@ static int ibmveth_open(struct net_device *netdev)
 			 netdev);
 	if (rc != 0) {
 		napi_disable(&adapter->napi);
+		synchronize_net();
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
 		goto out_free_buffer_pools;
@@ -834,6 +835,11 @@ static int ibmveth_close(struct net_device *netdev)
 	netdev_dbg(netdev, "close starting\n");
 
 	napi_disable(&adapter->napi);
+	/* napi_disable() returns once ibmveth_poll() has called
+	 * napi_complete_done(), but the poll still re-enables the
+	 * interrupt and reads the RX queue after that.
+	 */
+	synchronize_net();
 
 	netif_tx_disable(netdev);
 
-- 
2.50.1 (Apple Git-155)

