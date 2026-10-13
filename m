Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960F49B1EC;
	Tue, 13 Oct 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916233; cv=none; b=tYISxEeupiE0JXXbKxh3xbw/uGZlw7SUKqA4/HXGt2Kgxja98V2+NPxXwZ+/LXrs5ueXVlmh4Sj/5Uxd4BmIiLJ/jMGrVkx/FS3tGFUN2nJdWyVr1aHb22XqZz5+anzkje0kCwcZLpI7IfeD6c5IDitEsCprasZWQI/pUcBxH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916233; c=relaxed/simple;
	bh=6MlkYsUt/+sDG9+Ivhcq3K8U22DWKw6e2iDX1UQ/8SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2PqorwmXvMHO5IGK1XK8BoaXO8Gh3fzoqWnu6xo6FB6RJMxj8LpbosGCbVcgsVEs1Hu3c5NfHMklJkcrz1cCH6sILHwirAPvoahEgb00nCenD3PtMdzMguC/W3X4D/00kSc2jlBgSt5cY8UWf/xPMWH/jywBZVttSUKOt5XGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cnvQpSRs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cnvQpSRs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DEM85N148965;
	Tue, 13 Oct 2026 18:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d39BEdHIq+0wd4PRB
	wRfMKcLrSQEEOw9A++hD+0F9gA=; b=cnvQpSRs555u5suT/qBQDApbdtuh4jCvT
	4W3lm3jouwUIbXyinh5XdhmTBK1DVuTlFu0wN8jz2k2LmnayaEzXVWAX+lnYOUEG
	ZWT1g2VZ8/gbr8hLLZbEOfl/WUUhCayq5NlxIYwFxc4vxQIGsGmrOg61UBlzfIj/
	2wKfioqlR9lTHmMYkVLWtAf4kAfE/tacxf/VqIpvCbzM9TvoKYyEPBpzmkMuLoXP
	bwvYTKQUl3CY+TUwMFcbIOIL6i7NsC9Nqfpovtzw93fXrmPQFhP0Ogpylw22I1xF
	YMP6tA2iXPLDJNkA4xS0u43GEVDAQN2qFU8aPhGufGrp1tEsyi/nQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhg5g9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DIBSS83303962;
	Tue, 13 Oct 2026 18:30:11 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6ryvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:30:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DIUARw2228986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 18:30:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAF7858066;
	Tue, 13 Oct 2026 18:30:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 230B75805F;
	Tue, 13 Oct 2026 18:30:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.58.174])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 18:30:06 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com
Subject: [PATCH net-next v5 6/9] ibmveth: return the error when set_channels cannot add TX queues
Date: Tue, 13 Oct 2026 11:29:23 -0700
Message-Id: <20261013182926.30417-7-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX08IgPsQVvC2x
 E+9Yr+gic/f2JCpsWRqHyvMl2y1VuDoLkRW8RKWLpqF58DUHGKOsIKy7NKfAznpxQ3oiucwJR2v
 ++nSqFv1GU5u/NHHGkMICLeNgwS8HNQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX8XkA2JvQmLm6
 vFwK/NaQ86XNgwJTI+VB2+S6u94wsprM9EUMon9UQpiFcFPPcrQf873b/3iyAN+LsKNiylAwWhi
 fH6D6YJYZNAA7F6Pqw6DwInaUg7RGSCiJv7tW3BPMqTpEvEXEdm65ZI6GHkNYYx+UFJmM3H6cFr
 nFhats6CiWHwXSR6UwgdgniDB0N6Zn+ZVQpEq3kO8hH8MEb7s6E/ahh53cbmI3l65/t3FozOgTF
 mkEr0WELCUb4f6De5KD13T9pdCwR2KYhCIG/bsG+nrwEACCnRMw/zB3QSNPT0sUj87ERYzG2yEu
 /B6PKNT3mMGzsYtjLysQJmZuWftygrfCvELxBv/LLaZMQlfd9Pd3H+ApVjtHHNdA32iflnpp5tc
 c3CJ77EsUNGPvfAP8EwlXYhN1BKCEG5lGff1LFLtIr/h83+MPE5b6ENdhVRLvIbcPdhoBGEu7Kx
 w7pVBH4BGPkkECDNTJA==
X-Proofpoint-GUID: bN4YsGPZVgHSSiuur5xNQTx1gTrsXZFw
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace78b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=RZ4y7BAnkfP1csG6fq0A:9
X-Proofpoint-ORIG-GUID: 45dIU7MpdN1bm7sVhh9c-Kdm41a6PL5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130072

When ibmveth_set_channels() cannot allocate a TX buffer for a new
queue, it falls back to the old queue count, and the successful
netif_set_real_num_tx_queues() call then overwrites rc. ethtool -L
reports success while the queue count is unchanged.

Return the allocation error when the fallback succeeds.

Found in review of the ibmveth multi-queue RX series and confirmed by
code inspection. Tested on a POWER10 LPAR with the TX buffer allocation
forced to fail by a test-only module parameter (not part of this patch):
ethtool -L tx 8 now fails with -ENOMEM and the device keeps its four
queues and passes traffic. No kernel selftests cover ibmveth.

Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 42aa9f7bd49d..48bc4406396b 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1177,7 +1177,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	unsigned int old = netdev->real_num_tx_queues,
 		     goal = channels->tx_count;
-	int rc, i;
+	int rc, i, alloc_rc = 0;
 
 	/* If the device is not open (including a failed close/open with
 	 * IFF_UP still set) then don't allocate, just set desired
@@ -1203,6 +1203,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
 		/* if something goes wrong, free everything we just allocated */
 		netdev_err(netdev, "Failed to allocate more tx queues, returning to %d queues\n",
 			   old);
+		alloc_rc = rc;
 		goal = old;
 		old = i;
 		break;
@@ -1213,6 +1214,8 @@ static int ibmveth_set_channels(struct net_device *netdev,
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

