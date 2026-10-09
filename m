Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642852269A;
	Fri,  9 Oct 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570839; cv=none; b=PhcIHsWpGs6vaIu7YPYWCevh45LSKszyc9o/Q/8bjLJwihBjfOvnGH+inbiWDnSM5RVb0JTfaOOB+V21Us0N4Cobzbwk0R6fBkpj6GHuStbDAoITVwC8gUq1YkMJxsNhaeRv+XYteCtKtncbre1Qjbnf9290Nbl3EiYkYeEqbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570839; c=relaxed/simple;
	bh=PQQneQAw+XuWvHkJMJFP2+3sOUYtMw78HQ4o40wrLUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdF5p/vJDeecml3hG7Xr4H9lcj8bNmHCmhrnk6FHNBtehyKu7vBdeAO+RDfO3ksyOB+ueDHZs8OYlGIn13UlDywFGMUEainNyjby+T4Xh/81B+UyPboVSTkXyMcn950absbwd0ed32gmXomWDxSf9ttXvoXhXTEWRXh9bJXt++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MarKNb70; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MarKNb70"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Ha7xo3714797;
	Fri, 9 Oct 2026 18:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Av6uhvbgZTCmKJS6O
	j87hEIQkel1NelHpjlOR15CVjg=; b=MarKNb70ekyhLWlKLT0r1Ooc2whzldSWn
	vK1PEpJ4gkJNugFqJPHtdTXXABi+2aS8qiKzNfo4t/QajBkJRePPNF9nFWJo6tlk
	o/sAwOItTT9gGHYYIQWxqJpp3uOYFhV95X2hSekJqCuJnzUhmWxlQPUHKBPQ2fc9
	vJddOsn6AMcgvVDmY/diBoGIyVkNfBfnOPneRxlZbX3AgnL/6m65wBH030YQoN49
	5LpofLWHFE73c4WKK34gC3nVQt72CiJl6fOcV+MtK6b5grajjDNBO9UjWiUmyD8J
	5JwG9m7yAvV0Ttnc5vvOKzW3yADctKNrahrvWZv25uVVMlXRd3z+A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74ter90d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699H8EdB1142905;
	Fri, 9 Oct 2026 18:33:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd2bsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 18:33:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699IXUo45309084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 18:33:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 153B35805A;
	Fri,  9 Oct 2026 18:33:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C437E5805E;
	Fri,  9 Oct 2026 18:33:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.110.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 18:33:27 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnac123@linux.ibm.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com
Subject: [PATCH net-next v3 6/8] ibmveth: return the error when set_channels cannot add TX queues
Date: Fri,  9 Oct 2026 11:32:56 -0700
Message-Id: <20261009183258.18624-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261009183258.18624-1-mmc@linux.ibm.com>
References: <20261009183258.18624-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JlBIvYujos4aa8CbMxrJeY1PabPT3qrl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX4DdkYkjaxjVo
 /hXsW7FVs+85a9zD3mgkfMWH30XigcvL+PDese2eEovTHRJSPLKrhIfhJVLHR7BzboR1Ui2opLM
 bNN3o7GhR6AQg/4tBccyeF3/7N/Sh2ZBe6xXBoeln8eTa7lF8rY3pVjpTHXB99Bn7NBkS5m8eYu
 KunT3r5tzh+qgzwNo4gGRXOIbobWqjXuD/Iae+gdw81pJJxP7cbq117rUOmTUKiML0RCZ4jiNJs
 BNGxn7BInp/C7cn7dKYYEt8UQs2Nv1jztbx4DRyJEvxr74kG4VrCWPDWZZSjgBOA/yzE5WywMTo
 czphHIeb6pulXh4mkBTUe/haQjzxRMEuBzDPDQlnhRhO8i1S/vBUZExHSI/5+jtaoaTfc93Yw1O
 Maz5JnFUl809BG/FXS29BhheqQl9T4lVtaLagAwTg641/OIhfZZl3mgZFp/PyFknE58hI/7FyxR
 uPkETCAA2W5kRWUFVKQ==
X-Proofpoint-GUID: 0iwd7fiMtOceJWqAdFxNYFJpJisy3wEj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX3zAO7VGV+8Yd
 w611d4Df5IWTUncAA1sgDj8/AKhYt3emKceEFw9oGIe2D3d40yTF+3evNQzdBP7vp7uhsNKxyYg
 P/QyuoJo995sV7ZvX+QhDBkt7/vk10k=
X-Authority-Analysis: v=2.4 cv=Nf1zRGD4 c=1 sm=1 tr=0 ts=6ac9337d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=RZ4y7BAnkfP1csG6fq0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072

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
index dc5e63b7369e..18eb0f27512e 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1178,7 +1178,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int old = netdev->real_num_tx_queues,
 		     goal = channels->tx_count;
-	int rc, i;
+	int rc, i, alloc_rc = 0;
 
 	/* If the device is not open (including a failed close/open with
 	 * IFF_UP still set) then don't allocate, just set desired
@@ -1204,6 +1204,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		/* if something goes wrong, free everything we just allocated */
 		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
 			   old);
+		alloc_rc = rc;
 		goal = old;
 		old = i;
 		break;
@@ -1214,6 +1215,8 @@ static int ibmveth_set_channels(struct net_device *netdev,
 			   old);
 		goal = old;
 		old = i;
+	} else if (alloc_rc) {
+		rc = alloc_rc;
 	}
 	/* Free any that are no longer needed */
 	for (i = old; i > goal; i--) {
-- 
2.50.1 (Apple Git-155)

