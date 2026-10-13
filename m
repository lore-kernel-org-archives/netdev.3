Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777D48E0F0;
	Tue, 13 Oct 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916224; cv=none; b=CYNsMBUfRghKu1J5N/fu1hIxOkYT56t4erFLR4YpI/niILiJzReud/PRNYZpmztsasZ2W4mkO/VXTpb5ehR0Bb2yh/fNvgIXYhAySF0P/9Tn7SDVEIQC6s43CDQmTqn9JVxv3eRIsEkHnLLXPRVXJLBcSUMc5VduhhYCIyE2ejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916224; c=relaxed/simple;
	bh=4MCgHtKqEHyQxmruUcRIzzPIj1fu8n87yYLVO2EEmkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijFu1UneYDuoUfPlWugwq3PHx5XVfJiyqiXUFRj9pntimU9JWdm7JAbSRvxohpuvKthyp+1VgYWdQ+yf64EwkFsHD/xqEMQJlS2jbStLk3p22rLpSSkZNIC4wPIhZF5hYY3wBOB64g6mwE/hohE6CTEam2b23D8089eJHbJTiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L3hyyg2P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L3hyyg2P"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDgsRD1932099;
	Tue, 13 Oct 2026 18:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S3SzXUHhDWldWmpPm
	YxF0Oh++q8Ha7tJ+47jh3T09tw=; b=L3hyyg2P5AvB5r1UD9XKeUDCMjEQ9Ohot
	KwrBJvs6iNtsBpOAesToiFVVcwjkg+Ws9QlERMzn4FI2ITdNp5yk9w2gAhrmF4y5
	5xXkk1RoBvY0DusnFLciDFCoXr6G9IqBXaYf8jXZBCImaV8gRZD141V7O+Tuj7nj
	MXcxYgUQ2r5OnEY6/an6lNj6HmiILuBpcfleFvyXTbCwqqiJgin+hdi9d4deJhwt
	rEqgiMfZz5jGi2gx/C8vVwsSo2/MszwWDj3Qzc056zWjaBlmC9SKzN2I54s9ZDci
	ARNkFlRKHPsFta84UGALyWMa2AkjDQQ6rlYCPSlaf5/qQ3c7+W2MA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w7p1b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:29:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DHuTtM3211854;
	Tue, 13 Oct 2026 18:29:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2yh28d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 18:29:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DITqgW41419448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 18:29:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3677B5805D;
	Tue, 13 Oct 2026 18:29:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6755C58054;
	Tue, 13 Oct 2026 18:29:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.58.174])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 18:29:49 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com
Subject: [PATCH net-next v5 3/9] ibmveth: disable the reset work before unregister in remove
Date: Tue, 13 Oct 2026 11:29:20 -0700
Message-Id: <20261013182926.30417-4-mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX1tGGyHhul4SZ
 g+MA6tohYfG1hMzVcRHOxxQFxqzg3NCzs/ZHpA9NbIpivlOtPqSBM4bRfL0XwocWvkPlIryQBII
 EMt7KeMYzjEEit70dOCfqqEPw54Qfkg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MiBTYWx0ZWRfX3ylfeLhO7gFZ
 tuFZw0OsRxPFGoLzDqHzSQN2LccB7QqaTzEZqggbvhF1tfLUTKsZCgEThsY6ZnMjJq2HkdRGjU+
 mgwsMzhJpJGP96jzw7g6WCC0Uw6Oz6zS43dZ7y8e98Aj5TXi6pnEGWpHr5iEfrBmwXgA7L/yd5D
 0FAI62xMGYpDS8iGiQG7ZYDeeyMD88lnD5kJePzJ3uWPzZBo+BATX7FAdoEtKQiqNwgMf2MsrrP
 pSlzJvcBVA2HbuACuj3XoufF9CfzZTAXiJP/PcbYOqeOARia1y9uEhQjvGDJ7BQO0fvZsv4JS0U
 3xAWc2Gi8Qn4iVmfPa3dvuywT5fwKivBQkKvGQlHNyjcEpY9uoL1hRbg5dWY57jIaqiJFVUkqR6
 ySxx9Zcw7K802EscuDarqVNB8i+PAuuPZ89OjQIKTD6xVp7uD1t0rMosWufLHnPi2brRU/l53sz
 u2Qqpot9G/G1KNBKezQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace78a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=IlR5_4QjEJt1gQzRlPQA:9
X-Proofpoint-ORIG-GUID: RmBSwEevjbIeEQC7hAK2o1vZitVOPuG5
X-Proofpoint-GUID: uIAOp32DlpuYQZx0xy6fa7w7MJcSExdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130072

ibmveth_remove() cancels the reset work before unregister_netdev(),
but NAPI keeps running until unregister closes the device and can
queue the reset again, on an interrupt enable failure, a bad
free_map entry or a bad RX slot. The reset can then run on the
adapter after free_netdev(), or reopen the device during unregister.

Use disable_work_sync(), which waits for a running reset and keeps
the work from being queued again. A bad RX slot also makes poll
spin, which can stall unregister; a later patch in this series
fixes that.

Found in review of the ibmveth multi-queue RX series and confirmed by
code inspection; it was not reproduced. Tested on a POWER10 LPAR with
unbind and bind cycles under traffic. No kernel selftests cover ibmveth.

Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4665447997ea..cee0e9783b2a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1956,7 +1956,7 @@ static void ibmveth_remove(struct vio_dev *dev)
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
 	int i;
 
-	cancel_work_sync(&adapter->work);
+	disable_work_sync(&adapter->work);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[i].kobj);
-- 
2.50.1 (Apple Git-155)

