Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E9400983
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693132; cv=none; b=ZsAFN4O6wxm302g3zc16cPZnrKRvP8Yk6a9moQ09hcezAdpUjGe6N0qsEJp0YhZ9czy43t05or74puPf+e1T150sNWxN8oz5fcMzc12FB7dlLExY9t3l2ovv27ZT8gg/BXzHBbnbz3wYX6M+NQ+IaYBzhn8Ojhr0lqs3nkKia8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693132; c=relaxed/simple;
	bh=SsArAHj5wVgUhNdcgiwTRdwlH12cOYde/sK01jGvhdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hg9qH83mHR2G0jRH0hmMsk60pApqk0kq7ARCvncaFKGHkcJNgBYvnZST6KqiwpMhruXFJU4iVm1xRrWv5AZhd617ao0e8lfauD5jr8ojQ1POAIwEBm3jNUW9SX3cDtjUGBkVpdN/0wx61u/vcLwUw36e4M+haxcFSjELdZK9x5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mjCAuhHc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mjCAuhHc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4WN9w059711;
	Fri, 14 Aug 2026 07:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PbVAUNGx9/XtU8ujm
	ggUMLnWn0arc3l3krHyL1I6sxY=; b=mjCAuhHctJ4ID4+1Xr9TWaUIcSu/onDi2
	sgbcQa2yN6qLxmtxQJppNyjjWzejXhiBLLqlSQE2kz9zuLpST0RkhpOtX0a8Olbo
	mrJ74H6ApltLq69ofIMf99DEwz2vgwu85PzaxbFZhaSSrkIg9W3g6sx9y2mS/IC4
	IODbEoqPD7kLFbF8XrnYhbbytaIEeFmgyjxSFUWMzfW5ogebu7fIU4ZwSdOgS3jj
	NAFSWy0equgc1qaL4BhvBi+1FnzdDsWNoyjlsTdQ7xOQ87liW1e08ZT1omOkBH3K
	wPUKgM7m8MTIoMlHPnqW0MPT3G88Huda8kUpa9rphXOYIxmfu5JFA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3amq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E7QK1J017907;
	Fri, 14 Aug 2026 07:38:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wegca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:38:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E7cKrM18547288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:38:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF5CD58057;
	Fri, 14 Aug 2026 07:38:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C907B58062;
	Fri, 14 Aug 2026 07:38:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.89.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:38:18 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v5 12/15] ibmveth: Report MQ-aware RX counts in ethtool get_channels
Date: Fri, 14 Aug 2026 00:36:39 -0700
Message-Id: <20260814073642.24630-13-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260814073642.24630-1-mmc@linux.ibm.com>
References: <20260814073642.24630-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ec5f1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=PA20WcGQiNPz0IH_SaMA:9
X-Proofpoint-GUID: OFY_pIYdNsnMHERuVagvMTdclJeUo0W5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX4M+9+NbxmhbL
 N2a4zIwmYqkGt+Czu0KwV3u/qkGKaICmcHH0xMDqM37auC807ZigNf3+1J8j9I1duI+6ulM0/kV
 a8uDLTQRmKJ6lSRM1N3a0b4efseQOf/iMvy39ETN6RQ6e0m6NTyxIGu2w1TGm5I76fR8QbaJ62k
 +T7H7MYFpdusxjp73J0WX36gywAYWIxruarj6qjrSPcAKhu2OLi7wCNHAbNgNXXqdNMpmZ/ECdr
 AGuRh0rqd+xxOJny9VK28/s5Vwr68MrkaUBQxxSB7miX62Hvx33i9W02lCSbBr87Y4PHEKZ9nQ4
 xFT2Be91i6/jILff/WV1YeZKawki3WQv3TTN5CIJRzSucWi8IZJl4xuPPUVsTt+HmlDUNuIJm2k
 lpRc5NwNS1dQBe4kqqu2WCjIWN952vlv9yGaVczONL8VC07EROT7MuImC1gbBJLbKJscaztlMER
 8tmzlAcHgoVafGznW8A==
X-Proofpoint-ORIG-GUID: keTKK_sb57NeJGs1ev2ZJFw4dfENrEur
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXxpy/nK/C46SL
 nhbSoeZZDvTRdfbpHerqwqGeOR93yhwB/RJsPrqteaPZ0B4zEfagjHy00u20nwkIAZbrOcn+t0Y
 xTkWJekYyVaekL7c1ODEDe+S6nz3ZEw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140058

Report MQ-aware channel limits and counts from get_channels():

  - max_rx is IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1
  - rx_count tracks the driver's published num_rx_queues

Previously get_channels() mirrored netdev->real_num_rx_queues for both
fields, which under-reports max_rx on MQ firmware and can disagree with
the driver's private RX count before the next open.

Keep this out of the stats patch: channel reporting is ethtool -l ABI,
independent of per-queue counters, so it can be reviewed and blamed on
its own.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v5:
- get_channels rx_count via get_num_rx_queues() (READ_ONCE consistency)
- New peel: get_channels from v4 stats -> tip P12 (14->15)
- get_channels: max_rx = MAX_RX_QUEUES when MQ else 1; rx_count =
  get_num_rx_queues() (was mirroring real_num_rx_queues for both)

 drivers/net/ethernet/ibm/ibmveth.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3202b657c9b8..5d4ca4b3d3d0 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -2522,11 +2522,16 @@ static void ibmveth_get_ethtool_stats(struct net_device *dev,
 static void ibmveth_get_channels(struct net_device *netdev,
 				 struct ethtool_channels *channels)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+
 	channels->max_tx = ibmveth_real_max_tx_queues();
 	channels->tx_count = netdev->real_num_tx_queues;
 
-	channels->max_rx = netdev->real_num_rx_queues;
-	channels->rx_count = netdev->real_num_rx_queues;
+	if (adapter->multi_queue)
+		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
+	else
+		channels->max_rx = 1;
+	channels->rx_count = ibmveth_get_num_rx_queues(adapter);
 }
 
 static int ibmveth_set_channels(struct net_device *netdev,
-- 
2.50.1 (Apple Git-155)

