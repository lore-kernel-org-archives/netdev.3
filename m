Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B442CAEB
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969876; cv=none; b=ulbAbYfIa2xBiHBQ6K/H6cd0sRUARC/knJ8g1dIuYsXDeYHbIh1JrmD3eJUALOvRlVR2b0seBAN9PPz9dqPzqsw0fHLYjGuUDWbydw8FLNiFt9G8OQKVpSwETPkQ5ao3tlJhG+2LZWTicXzKgwaS5/Z6nmJkdmiLzk+RQlqI9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969876; c=relaxed/simple;
	bh=MJwDogP9efndM0b2+jq4zaLM2pHkj4SqxRuO5BJHfI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZmLXRrcBIfk1eI0E6Wf9A6zDFd1zz5LHNhn8wbVb+534YHhUHo0Zsp35Q20boe4FJmf281/xoo2QmVLAIF2jrCmhsBBDRXl1+nWgJwf8V9aP2tzsiZ47cg02vpIi2w7x8smzovFH+9cIrU/edt2686nBTkZBHUfu69Z1/uhPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rThYQQk5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rThYQQk5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Hlhkg394792;
	Wed, 5 Aug 2026 22:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e0U++xU8OMRRsKneG
	GCuvRdyWeURGDnucMMJBuYnCiA=; b=rThYQQk5dhMeZLcasuMWzyhIdHs1Wi8BP
	b6elwQa+f2QZNOiua2y28Mz7JRr/jQTlnnqkmYyLFHYgbsLxZ7EdO9J+1e/ft0mj
	k4GFKBzEeta4X3JJUYsoCLVbdmkbpaOA5EoeWjkXmfh85M7DGXF0hhfFpfQcvibQ
	TbYc5F+2YoJ2XYL7A+1aKVo8xrp7REhl/DT1MMeqGCEtBduLsvwmSBdDq+ctFnEq
	/EbAqccDyzO0SBMmnCXKWWXfWwSRzfS4NNisvDBQAKDdkYAMI87c+szC0fFJxMmP
	xDQQsLJlfKSHhDTZ4kKjaVNaSxM+j3etYF9i/PjrDg5QiCv1ByxCg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euvtd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675MfHtj022256;
	Wed, 5 Aug 2026 22:44:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k8neq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675MiKKe65601842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:44:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A54A58066;
	Wed,  5 Aug 2026 22:44:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEC205805A;
	Wed,  5 Aug 2026 22:44:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.135.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 22:44:17 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mmc@linux.ibm.com
Subject: [PATCH net-next v1 2/6] ibmvnic: honour the requested mtu instead of reverting to a fallback
Date: Wed,  5 Aug 2026 15:43:57 -0700
Message-Id: <20260805224401.58791-3-mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: cnsixlzSSpXXbLxSq6Ebt29HLokxM2IM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfXyeQTj7PiLROa
 h72MCmcoJg7fN0QWuQPajK/QPHUOJ8w7aGE9B25iRGgEa8/Kk9o2iCEICH7BvqBe1RborwCGYk+
 9YTyg/ICrQ+tEUHoQkTel5Vd01g9Oa0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX9XqXQ2uc5e0R
 yQrXwpiIhTxRhEilkzaOQxXw6NJm+ILzh6QtJyazVqQT9rimA4r1RNkuAQOxpHQ4+xpHfPMFh0o
 icNyxpsLbDq5IVFbipZcfIc970kSMMCovc8RRNokBRCVvyVwxs0+Q+fLG1f8NGcwGknU/JRpYWg
 DS1rGbNZaBUYodwNg4gTSZgFu9o+PiEBh7lXRPp2iiFDkksJq3QleH/WIgNd0A3sbTVMyNKWhO/
 papR3yWaOHeojiq/4jNfHM6F+JUnHkOg/y+QrsmUM4VdbqPCxqoRaB/yX8QJ6X/xQQ7bYj0bPNh
 FnUf8HYMVHBTCoo7uZ8XyZ0k4/I8RZdtzpBcJU37QBQg6oTvQjlfKaJKABgx/hjt3HCPb4kBokl
 6S0tyIS8Xs6RCrxSodtVnTCEiEV8W45AX8sCW2UBd34KZDHfMC/VL2exLmhaRBKSci6qR0s76ZP
 fkxVg5YR6MfNnymowyg==
X-Proofpoint-GUID: g_1y57XMDFVni2afvfOIEhf9j1_9u92G
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a73bcc7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=jl8DONJFTl3ZpNuRYKwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050183

No mtu other than 1500 or 9000 can be set on an ibmvnic interface. Any
other value is accepted by ip(8) but silently reverts:

  # ip link set mtu 1414 env8
  ibmvnic 30000008: req=1428, rsp=1514 in mtu queue, retrying.
  mtu of 1428 is not supported. Reverting.
  ibmvnic 30000008: req=1514, rsp=1514 in mtu queue, retrying.
  mtu of 1514 is not supported. Reverting.
  # ip link show env8 | grep -o 'mtu [0-9]*'
  mtu 1500

The backing device runs at one of a small set of fixed sizes, so the
vnicserver answers every REQ_MTU between the advertised minimum and
maximum with PARTIALSUCCESS and the size it settled on: 1514 for
anything up to 1514, 9014 for anything above that. It is reporting what
the backing device carries. Requests outside the advertised range never
get here, since dev_set_mtu() rejects them against netdev->min_mtu and
netdev->max_mtu.

The driver read that as a rejection. It reverted req_mtu to
fallback.mtu and re-ran the exchange, which is why the log above shows
the revert twice: the fallback is in range as well, so it partially
succeeds too and the mtu settles on whatever the fallback was.

Treat a PARTIALSUCCESS that covers the request as the confirmation it
is, and keep the requested value.

The response can also come back below the request. The advertised
maximum is the protocol ceiling rather than a promise about the current
backing configuration, so a device that is not set up for the larger
size answers with the smaller one it does carry. That does not cover
the request and must not be published, so it keeps the existing retry,
which now also stores the response value rather than reverting to a
fallback. It therefore converges on a size the device can carry instead
of re-requesting the same number. Other capabilities are unchanged.

Later patches in this series make the resets that follow a real mtu
change safe (and, on net-next, skip them when the buffers already fit).

Fixes: e79138034068 ("ibmvnic: Revert to previous mtu when unsupported value requested")
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Vaishnavi Bhat <vaishnavi@linux.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 34 ++++++++++++++++++------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 86e643ee6b3b..f5f9c0d5b4e6 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5502,12 +5502,17 @@ static void handle_request_cap_rsp(union ibmvnic_crq *crq,
 {
 	struct device *dev = &adapter->vdev->dev;
 	u64 *req_value;
+	u64 rsp_value;
 	char *name;
+	u16 cap;
 
 	atomic_dec(&adapter->running_cap_crqs);
 	netdev_dbg(adapter->netdev, "Outstanding request-caps: %d\n",
 		   atomic_read(&adapter->running_cap_crqs));
-	switch (be16_to_cpu(crq->request_capability_rsp.capability)) {
+
+	cap = be16_to_cpu(crq->request_capability_rsp.capability);
+
+	switch (cap) {
 	case REQ_TX_QUEUES:
 		req_value = &adapter->req_tx_queues;
 		name = "tx";
@@ -5546,21 +5551,22 @@ static void handle_request_cap_rsp(union ibmvnic_crq *crq,
 	case SUCCESS:
 		break;
 	case PARTIALSUCCESS:
-		dev_info(dev, "req=%lld, rsp=%ld in %s queue, retrying.\n",
-			 *req_value,
-			 (long)be64_to_cpu(crq->request_capability_rsp.number),
-			 name);
-
-		if (be16_to_cpu(crq->request_capability_rsp.capability) ==
-		    REQ_MTU) {
-			pr_err("mtu of %llu is not supported. Reverting.\n",
-			       *req_value);
-			*req_value = adapter->fallback.mtu;
-		} else {
-			*req_value =
-				be64_to_cpu(crq->request_capability_rsp.number);
+		rsp_value = be64_to_cpu(crq->request_capability_rsp.number);
+
+		/* Covering PARTIALSUCCESS: keep the request. Otherwise
+		 * retry with rsp_value.
+		 */
+		if (cap == REQ_MTU && rsp_value >= *req_value) {
+			netdev_dbg(adapter->netdev,
+				   "backing mtu %llu covers requested %llu\n",
+				   rsp_value, *req_value);
+			break;
 		}
 
+		dev_info(dev, "req=%lld, rsp=%lld in %s queue, retrying.\n",
+			 *req_value, rsp_value, name);
+		*req_value = rsp_value;
+
 		send_request_cap(adapter, 1);
 		return;
 	default:
-- 
2.50.1 (Apple Git-155)

