Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85C316190
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366617; cv=none; b=Lg0/I0UOyDBB1JFtH2EmuNuBZOMoqKpqHDBuZAwH6TPX0+Xg6hSTksrbhXG7QTpxvyDsonRHW6Nxs0QL0Pk0qdxz5GvLdDEk6+8c2mDUqFpxnSmWFJBlGe9uLosIFO7NtL83rlCcsdB6d6uoPJCZG1MWT0F0li3nzx50aKffzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366617; c=relaxed/simple;
	bh=Z4oC5egp7iX1Goe85YfwxPPZzYj45ac8IvJAqpXMX+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJhLBdp0bn+bkB84RveK4AxM7Q+Vzm+APWaE3PWx8MM1E8FoV2Qz9bnUqq+fw9HsYRCMYihjR5tD/Oii+c5vzOcb6fDXYC5lQJkTrNyT/SWGxDSiy3w7DfBbuuleme3gFPprm9jcPvrx0f4zYzkzzzqpRSGJDrCFEWCzKd10AmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r+1dhCaO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r+1dhCaO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIP1x4069547;
	Mon, 6 Jul 2026 19:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vFSLvm
	k1zUspJRDUJrGMLAht1yNaZ1/rGIU2XnN27k4=; b=r+1dhCaOvKsQeAAwqkZNea
	Uzl5dvAWjGkgtgJmKiUa5aVn8hj+wdjbTvl9/THNvdpu70TCJbkWRa7yDZXwzECa
	pckjlPhB1JGE8zg81niCw6o+6THGnRkZ4Zy3QR2l/O91GCUSOAct66dqFSiqFUf0
	/Xa8Wb00jhbsVYHVi0NExSyGnrv2050ZEDfU2kfnYAGftgA8nwyCIMjRgM0aNDzv
	xWSovjX2Wr/xo+dAhA9RHZAQhGA8LM8LZ5EAmPCt7X2kQCYJnMiVhHfn4Yp4EWKl
	9p8dQwxelVMsc6iDkbU88IoerXU4+/IerNwHacJTVBCfwxT06VuNS6kZrpG8Haog
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdkq40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZfv018719;
	Mon, 6 Jul 2026 19:36:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h6v1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666JagJs5243474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0662F5805A;
	Mon,  6 Jul 2026 19:36:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F1F358051;
	Mon,  6 Jul 2026 19:36:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:40 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 06/15] ibmveth: Refactor TX resource allocation in open/close paths
Date: Mon,  6 Jul 2026 12:35:54 -0700
Message-Id: <20260706193603.8039-7-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4c03cc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=mtsAU2ZvJdVy61tLPkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXyw6FXmZydTHW
 ZZz+lFLd5h3WjiPIiDFIMoTqH2MtwNJcwFkGKDNnXLJ/jtM97Qg1uxSKeaUP9XH31zoI4HCSmhv
 RgBLWvfifIn6jFJd053slBn4opMkCI+GXN47BiWpiKBeT1huQ/90jIuWRjGaN8IqynXXBIN5lgQ
 mtxJCwBrQlIhrpPhB/0g8t9WhXj+hrI0BhDGbhQ/iruZzVul0BAlWCzjg/lbWVI11/clw/RSS57
 ViQYOvvlzMVjfVhTRCQDMIN6DXBlWmoPg3KMpwpD2St1/rd1jpVD586ys2f7YH7WUNyxIYx5C3x
 VdFZ0EU0u8T5ie8DnZjqsty8vm1WN/hhQVofhpX1ooL1xj2Q06l1f/EqVB9e7wdD1Kh+DEQuPfz
 /y2WbhE1rERg89aDdLmd0+8YvxEGsz7Zj4E2Zis3ILupNeeL4MQZi4MWmDfFeEYMvwKyQUSSvVZ
 3v8hRPG3iqNw8lT+A1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX14oJahDFrEST
 n992p9X8Rp1xUicRfboAr+468Fy4RhMavZoYh6/Xs7znDLwvJYqPkeG1k3kbtFk2TPBAPTNhaEf
 R1ubFUKtUxNOlIBHr52ZijY21hrOw7s=
X-Proofpoint-GUID: Q1VAz4Cau-gPe6BxyL1vYmzME6H1inx2
X-Proofpoint-ORIG-GUID: pY1KCm1Tw-JR-SeAfE-IbZ_mVpunhfGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195

Same story as the RX refactor: pull TX LTB alloc out of open/close.

ibmveth_alloc_tx_resources() / ibmveth_free_tx_resources() walk
real_num_tx_queues so ethtool TX channel changes keep working. Hooked
into open/close in the next patch.

No MQ RX behaviour change — TX was already multi-queue capable via
ethtool -L. This patch only tidies the open/close path ahead of the
RX helper wiring in the next patch.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index b5ae979c1f82..63b0184c622a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1038,6 +1038,49 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 	return 0;
 }
 
+/**
+ * ibmveth_alloc_tx_resources - Allocate TX resources for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Allocates TX Long Term Buffers (LTBs) for all TX queues.
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+static int __maybe_unused
+ibmveth_alloc_tx_resources(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++) {
+		if (ibmveth_allocate_tx_ltb(adapter, i))
+			goto err_free_ltbs;
+	}
+
+	return 0;
+
+err_free_ltbs:
+	while (--i >= 0)
+		ibmveth_free_tx_ltb(adapter, i);
+	return -ENOMEM;
+}
+
+/**
+ * ibmveth_free_tx_resources - Free TX resources for all queues
+ * @adapter: ibmveth adapter structure
+ *
+ * Frees TX Long Term Buffers (LTBs) for all TX queues.
+ */
+static void __maybe_unused
+ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	for (i = 0; i < netdev->real_num_tx_queues; i++)
+		ibmveth_free_tx_ltb(adapter, i);
+}
+
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
 				   union ibmveth_buf_desc rxq_desc,
 				   u64 mac_address)
-- 
2.39.3 (Apple Git-146)

