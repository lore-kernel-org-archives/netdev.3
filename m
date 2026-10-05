Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1113328267;
	Mon,  5 Oct 2026 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180587; cv=none; b=e7BjsqiYNf7BkK6KmhIQMc3DZhhRRgUGwuBWR1uJZ6pQHc2lxU/uYfBIQ/FOYaig93ZKOgH1ztQMCf17LbNwS709+b+YY3ANCSaI/K6xrVCexWMgj6OOpfUOatiD7fLA5EliDV/UjsuMDQdVQYONt9BENBNNqXv1W4/3+dqkyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180587; c=relaxed/simple;
	bh=GzGVzebKyymSacJ4H9sY9yfvFwEPPkJFlGOhLBM3NhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QIyLjM+adP1h5WMe/TfVHELQ2+/qGTz4GyS74Z1KhC4RLNr+IjC15JChl3XpPo8CsLo4uAaoNKI1pPIzkL8LFwp/0LDYUYUSzIuLOgfF0/onFV3ratPgx4cBGeW0HDA9pwCp0T5ieqwTDtUNX7XKqGF9b11X72JM1IG4kFMhho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BpCQ0gJ+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BpCQ0gJ+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515vRO2066516;
	Mon, 5 Oct 2026 06:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZYPoh6it/oNB57OFQ
	PCnHjd8sUELLNdL6f5uuCEoML0=; b=BpCQ0gJ+6bChsf52BCBQ+yuLhahOhs+jI
	pWT7Q0uelKKrpfRXuZc4FU7RoDnr6CuBrFGiItxzB2YS454rK2kF1yPEyTDwYm29
	AsdmoJgGfg0gqIwW3JYAmtwOYpy+sfab+yOB27PCmdibkbP2I2lgIdjFbrLW015F
	EzYbArxirznHmgF+H39pJB5Q3TbdQ7Gm4IwUIJIavQU5fjqxT6IdNPdRzst8RIBG
	JI7z5366lE/1DWrfDPRJ6Kk6JElBWXUM39yLt5kqqf1ppFJeq7aAb11uTQzwOsrt
	dy3rvw8QEeiPsN2jAfaKCX5nL8+ljgRzb4Uo3lh0B92mmRv/6paig==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fr3mt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6951HVEM2163522;
	Mon, 5 Oct 2026 06:09:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvm9tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69569RM062259460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:09:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05AD05805B;
	Mon,  5 Oct 2026 06:09:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C150158058;
	Mon,  5 Oct 2026 06:09:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:09:23 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/8] ibmveth: wait for in-flight transmits in ibmveth_close()
Date: Sun,  4 Oct 2026 23:06:08 -0700
Message-Id: <64ed5d98164f9a57b2dc9b6c61982d94ea92be96.1791178212.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac33f1a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4X-BtLuwBG46RJIdyTYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX0a2U5V11TjCT
 8eFXqXDNtuyorgIobcexBirBMN2rzvYwq7zo3I2C1ychM48FBWiCEDLYza7J9QxLDAHNk3y/s+X
 i82WCl2e1i9Z4tWaE8Ab2S9atpeBzFphVzNY03bTY+XVYxiLZCMI6oazvy/nBl28hJe10sjgNeA
 QulTUgPusxYrPON43N5dkUYPLi4BtYSrdsxKsRKnaltKUts2E11zg7h2V9O+NiaY705+8BNr83b
 8HBBNol3MlKyddhxEBQZ4YEXGvebW+mZzuAnupt4k7cVLKG2V9WKM+Rff5h664+cigGakRBGauz
 mWeaHDTMOhB/17ee+L5i24WGPV0m8NgKN2x/pnZVJWg/7EsMa+RSiGDmTWr2dQrz7jaj+zyz/Pi
 nLmKSbUCWIhkk4+qXhBFLXSv2oRpzEwZ/F8OhrbUk26m/jWd6gthf5a20R1Wfgl7G0Jcg2PYpKb
 WT4KfbcToxGiPaKuZ8g==
X-Proofpoint-GUID: GLMf8NRTyrZdLrNajisY205jfMJtY60w
X-Proofpoint-ORIG-GUID: dzOfU4ZE_-YUMjlSufzn7kqNkpFs2i1s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfXwQqP8FN2nHys
 6MPXgJRRTOWkrx/D+sxs+x5oqSuGPHG0Uz625DwoZDSmwpmk1vHeJGuSpv0+sKSnd4KpMJLcHTS
 XyoV/nJ3Mbk6X1qwf3MTkSzMZpVDbG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

ibmveth_close() frees the TX buffers after netif_tx_stop_all_queues(),
which does not wait for an ibmveth_start_xmit() already running on
another CPU. That transmit can copy into a freed buffer and hand PHYP
a stale DMA address.

MTU, csum/TSO and buffer pool changes call ibmveth_close() directly
while traffic flows. ifdown and the reset work go through dev_close(),
which waits for running transmits only when the qdisc has an enqueue
function, so with noqueue they race the same way.

Use netif_tx_disable(), which waits for running transmits.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; the race was not reproduced. Tested on a
POWER10 LPAR with MTU changes during a ping flood, with no warnings. No
kernel selftests cover ibmveth.

Fixes: d6832ca48d8a ("ibmveth: Copy tx skbs into a premapped buffer")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---

Changes in v2:
- commit message: dev_close() waits for running transmits only when
  the qdisc has an enqueue function, so ifdown and the reset work race
  the same way with noqueue

 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index e242417ed8da..db6188cefffe 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -827,7 +827,7 @@ static int ibmveth_close(struct net_device *netdev)
 
 	napi_disable(&adapter->napi);
 
-	netif_tx_stop_all_queues(netdev);
+	netif_tx_disable(netdev);
 
 	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
-- 
2.39.3 (Apple Git-146)

