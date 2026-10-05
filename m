Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C9340280;
	Mon,  5 Oct 2026 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180593; cv=none; b=MTcyGQnmGEwQG1tgOc6FCUi3o/tTv5uvIlOlBLRd00HLnJ8zS9p+LTeH8eu/JmaAzdV1TmThzfBXPBCsCTtm/jtpcnX99vI4pahmbZpckGRE8Ui+uaY7LGQMcoI8Us7QMk/HkkTpOW+FjMys4GRQOZMa0BL5ISrDva1+QmhIfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180593; c=relaxed/simple;
	bh=NpF93SEtHYrnE/HqTdRkrINsHfq7kk+0VT5ZcskuKJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBm/UrdUzbCONp20QKwsmzx3fpyiSQYeQN778gv3jyVrRBgalhYrboYoa3rrF5WAyn5SsX8Bbsiy+458mxaY2QrBKMBTT6EAuzaqmixFcP0RPlgJ6FjTyY1YjHFiIiXorqMhj5Cc0bzNDaHqRwsiloL1GE9CDVsrQKfI/Gsl060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HFXymg23; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HFXymg23"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515N323274313;
	Mon, 5 Oct 2026 06:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NIdIuqwhdRncpq86l
	Zh+ubsinuR89t4/Cf2kW0n4h1g=; b=HFXymg23/zKZIN8mk0Wkm4xTjHdVViV2v
	3RXrPFO7OzJWM4nZCs4+Uua6zGJWqEIcJrT97dNX3gHM4+214Wo2V0U0EcOMjoiK
	Wio57TAaSiI79DZfkGLDc0eWK0ijXNvD72odkua5ZyKP6r5PuK3lwG3QjiRb+rDY
	QGiOIwAsnnTQEiJzipqydiYu3Vl9LB82e0I5UvEDfBgYskgf1EqDpEuouPLyzJEJ
	Jb7cbPxzRAb1LDBcpPOMZqxntArWyRn58SfOgIxnEuGmWcmdiLSXPosMeRxGveYa
	j6LLE5PQeEp2wdcB13XimhuTohbCaUTbFFVbRHNjhtJ+nCItt6xNw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se58kxf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69512XTS899480;
	Mon, 5 Oct 2026 06:09:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g412t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69569WBM3867300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:09:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DC435805B;
	Mon,  5 Oct 2026 06:09:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4677A58059;
	Mon,  5 Oct 2026 06:09:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:09:29 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, stephen@networkplumber.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 8/8] ibmveth: wait for the RX poll to return before freeing the RX queue
Date: Sun,  4 Oct 2026 23:06:09 -0700
Message-Id: <bd97f9417e06d7e72190e690609388685076289a.1791178212.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX87VFBI6LnfX4
 ZEtWpjtiRzHlLQpR2Q6l/F2KyrsqnBtJF3ZrCgO8lsomF617n36DNWvQ+zBgUQmZ3jWSn21TCru
 +7re3ZQ43A1aqqc/kr63SeQzirIpwlw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfXwFBC8JlFZzU/
 UrZBWhV/j3dAhJPEhiRzyvrlQCJLt3csAqu+IVYuNxUKfvIa7YeB4KqSOYg0E2K/C/krusbbNYm
 z9t+6XCquy++WC1swgElkCoe6kVDZU2tggrOSyHGxPJLz5VMjvgwvb66N0Sm1cKIOV+zETJf3Xl
 cvm8xQNtJdcLTIYCsdreTmHBNswf0zpexPfzwX7DTPgbvjyrCA4v19aFB8ghHiNhOfu9/c8It+m
 FHRvOtNDhT5eZNQeGDkijM82hcLe9LJI1i+vLpQeIRRrFbWFWCXKdRaF54bfjHz7HeXZzrfFp+S
 ezNa+SdAfC4K5txWbCIGklS08Wp1UOsBwU9LkW4ZGDj0V8+48EYNnw5eUsxDfyTN9ThpWDirXnt
 rKbc8DEN/4BAby99864U7KwlvNQefvkwZY1iooTggLhX0I1Cvh5c5YP+w9blLA18acprgKNrD6a
 z7dp8GUxxWz2KURlP0g==
X-Proofpoint-GUID: seTfNVEScFwjEsQpJPtk9eocI0FNpxRz
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac33f1f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=1jQH5Hc4uxvP87yPb2kA:9
X-Proofpoint-ORIG-GUID: jKb5jbDHzPXKLsZXl7cbvGArABnEQ5Bm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

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

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; also raised by the Sashiko AI review of
the first version of this series. The race was not reproduced. Tested
on a POWER10 LPAR under an incoming ping flood with 30 rapid link
down/up cycles and 30 rapid MTU cycles (1500 <-> 9000); ran cleanly
with no warnings or faults. No kernel selftests cover ibmveth.

Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---

Changes in v2:
- new patch; raised by the Sashiko review of v1 patch 1 as a
  pre-existing bug

 drivers/net/ethernet/ibm/ibmveth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index db6188cefffe..b165ee5c2643 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -757,6 +757,7 @@ static int ibmveth_open(struct net_device *netdev)
 			 netdev);
 	if (rc != 0) {
 		napi_disable(&adapter->napi);
+		synchronize_net();
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
 		do {
@@ -826,6 +827,11 @@ static int ibmveth_close(struct net_device *netdev)
 	netdev_dbg(netdev, "close starting\n");

 	napi_disable(&adapter->napi);
+	/* napi_disable() returns once ibmveth_poll() has called
+	 * napi_complete_done(), but the poll still re-enables the
+	 * interrupt and reads the RX queue after that.
+	 */
+	synchronize_net();

 	netif_tx_disable(netdev);

--
2.39.3 (Apple Git-146)

