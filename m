Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA985474E;
	Mon,  5 Oct 2026 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180580; cv=none; b=KCZ5VNiRISkHtg2hGk/gIyVANMH55oOg3AUyATpRYEZIr4oOuIszvGJSWSmCIJYvNYXAHSku7RuCUNvG0DeAjZGvCjZmQque7xzf2OAoXDoTmqEJoBzJy4QZuLc9Ck9cIxi185HQyduRIUlEfMjgcckaTESk8kMQuK9nnWcevao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180580; c=relaxed/simple;
	bh=oAxjYL6kQKOvQpBk1whn0DcLWpBRtofzj5CaLTUe/nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvwgrkCI0mhDcDOwfywJd2ABSpdbYSjn0bH7T1GioBysDraeH53zwyE07PkQ58Rr2X7wDwoE3jqlm2CxiBGJhmiHpXYPBy+Nm85yhwEms2T0Yo5Yh3ommhEykQd5gehsyvANETVjVn/MZx9KyVizuyXxdUoXB5EcRmP4bfCh09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jw3UE9p0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jw3UE9p0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515e4i2066010;
	Mon, 5 Oct 2026 06:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n190gGFblrlj4Vd9x
	OJlzVfmnNPLZPFuu2RtjmnW43s=; b=Jw3UE9p0HVdLQkybytFlH6VQuai8G6/s6
	KfFo1Ad0uRDgDxydXKHK9hw6aR4xmiIeowACRY882kYDK4/zS755w09kM7PrWd0f
	h3qOy7NSBVWtbMp5Azar72G1kDC+3Arkqd/RWYUxJbkC4m5s6DqHFaL5k2ThaDwQ
	LTaqhiJ+Ana3BSwr8ZOWmlEHcbzVBqNulft953pEPliWXT/O9oUT7ohRYu6bDa3A
	+Z8gxJM7GNe87D209MTanYfiUN7USvRFmjCfzSWzvfMyPASHjutX0qdmEOBpjYGE
	cFUxe2eXWWWecPb7F95AdEqJXvkCPmSb8fMk6Yjjunxo4V6v9bJkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fr3mg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6951HM5S2163433;
	Mon, 5 Oct 2026 06:09:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvm9tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69569LF531326732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:09:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A9C58059;
	Mon,  5 Oct 2026 06:09:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A82D45805B;
	Mon,  5 Oct 2026 06:09:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:09:18 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, nnac123@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/8] ibmveth: return the error when set_channels cannot add TX queues
Date: Sun,  4 Oct 2026 23:06:07 -0700
Message-Id: <5685e3b9be9c24021f73404d2269899e3a099af1.1791178212.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac33f14 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=RZ4y7BAnkfP1csG6fq0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX4Y0t6FtMuqQJ
 4X6UNf//uPSFiCPoNEXkx8iYRRp0eExclvJF2e5EhsC8mrCTfAGksWUAwXoPPmd1/5U9pdeQLar
 nVQQlrjeC+WnCw+Wdpe1S+nnyiqtRPSxKcKe04nLW652G1p9wOb95SjxCYLVTrevjAGAX3rFfOh
 3cXILSdCzoclDANGiBfCg0B0F18bEnb+S8ICCgHddwy8oz+4r8DH8Tr9wqHjUHeu3M3PZ8ApNWk
 E6PVmIhb2wqMjtbx/UKN4grGHGXR9UnWRQcEqrEQ9bLh7Q+xwIiA6ZeOiO4zJTNzSEWn79oj3Yg
 74T6F6a/1MVPLsaM1CNahm4EhPUU0cjiiJFy8aFjoXGdP00+exP7v1Sgefe7jI1+zGZAqOEUaPS
 /1ABAI654d3GebX1RNMBqzRdPKwYnc/B1e8G/swsD4Eg0F0ysSiJkPNwmJCmSZuXnZajgmhpWJU
 116+hfYJQMT+qE7r9vA==
X-Proofpoint-GUID: jh2600aLDox0hEEfSLqe9Z_x0VuVkenV
X-Proofpoint-ORIG-GUID: 6T9bsJOlhyLqHuk2S6IKoSOCNbnc7vSJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX/NhMIFmlp5av
 3ILMPh771AfM4mW6xX1xqbE34IEdpurEy4/olOlT6HZTZ3nc9h2Ztx2g4DO2y3TtHRg3AKwyOlu
 lXTDruAAJJu0UVovPRA1qtaOXipRizY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

When ibmveth_set_channels() cannot allocate a TX buffer for a new
queue, it falls back to the old queue count, and the successful
netif_set_real_num_tx_queues() call then overwrites rc. ethtool -L
reports success while the queue count is unchanged.

Return the allocation error when the fallback succeeds.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection. Tested on a POWER10 LPAR with the TX
buffer allocation forced to fail by a test-only module parameter (not
part of this patch): ethtool -L tx 8 now fails with -ENOMEM and the
device keeps its four queues and passes traffic. No kernel selftests
cover ibmveth.

Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index a10ebaca9081..e242417ed8da 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1169,7 +1169,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int old = netdev->real_num_tx_queues,
 		     goal = channels->tx_count;
-	int rc, i;
+	int rc, i, alloc_rc = 0;
 
 	/* If the device is not open (including a failed close/open with
 	 * IFF_UP still set) then don't allocate, just set desired
@@ -1195,6 +1195,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		/* if something goes wrong, free everything we just allocated */
 		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
 			   old);
+		alloc_rc = rc;
 		goal = old;
 		old = i;
 		break;
@@ -1205,6 +1206,8 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			   old);
 		goal = old;
 		old = i;
+	} else if (alloc_rc) {
+		rc = alloc_rc;
 	}
 	/* Free any that are no longer needed */
 	for (i = old; i > goal; i--) {
-- 
2.39.3 (Apple Git-146)

