Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF039DBCC;
	Mon, 12 Oct 2026 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781555; cv=none; b=m3cLhPq48mRpi4lOEAIuNH5OwXj6SVIDui7XJYMZnhldkkHKNBocqf2RqOP3Se31+0pvS7wGM9c9ztwP9z/kd9RBdI6sr8WVahFHtDJHgijd1kb/0Yw0XjsG8ZXTRwfz6pRqp1/7RHodjx4axqAvLGe56wIY7wMXsZKEmwnwEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781555; c=relaxed/simple;
	bh=8HFZEsLWtFuEu3DF/DjZYSzTklcfJcjKgbSiQeMTbyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdNnlovT11JsJT+14VJntxyRpZ9lCSgzKYAAllLhuR9zwfHdM3+BAg8N/N2kcQhMgXcQhF0RIIYL638942fdS0ut+hUJZOLOqcsBjFkZdRwdahMp9vPWo1I4M0snZtNIcL13uWusl9RB2EZ8UfC2PZxP05lfV6KMDasYAAnUxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rTYRQ3Wj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rTYRQ3Wj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2F3MP3158140;
	Mon, 12 Oct 2026 05:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vU96N6Mg5oDnRAeCp
	5sckE1d7IjMZBUWCSbSYQ92nJ8=; b=rTYRQ3Wj8/ZtupO0YatfFLTN9B1IBF2w0
	DE4v0JJv2KX7YuG+FS27DdFV01lldj2FStRyFkc1oSvdxq/DBBh9MGmtfV2jyiv3
	G+TaXof1lzpfd8PWFPH5K/xKdcO2tU2Rm/1M2zGoTVGYjrrrf7b5xfyN9rYBMCiE
	KSNr7I0QJZ6F3/x4d/YxM2HiIiclGSI8c012p4lk+Co9o6wBBtxkdotSmeOeIGse
	I4n1qDBrdkHdRp62rYsZ/+n5DinZH1c37eZRX0k2lw+gV5dffljrOCJK5aQLPb9S
	hBcUygsFEqlm0F/YlBPz08HdhZoQhNICI4hRnFOUuihem/yM1ADcg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug78tm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C54ww43726489;
	Mon, 12 Oct 2026 05:05:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfuknj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 05:05:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C55c1w33620670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 05:05:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2496D58128;
	Mon, 12 Oct 2026 05:05:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29AA75811C;
	Mon, 12 Oct 2026 05:05:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.163.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 05:05:34 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com
Subject: [PATCH net-next v4 3/9] ibmveth: disable the reset work before unregister in remove
Date: Sun, 11 Oct 2026 22:05:12 -0700
Message-Id: <20261012050518.88858-4-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261012050518.88858-1-mmc@linux.ibm.com>
References: <20261012050518.88858-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acc6aa5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=IlR5_4QjEJt1gQzRlPQA:9
X-Proofpoint-GUID: de94brw2izx10ylKFkgtSvJ7oomv6I2v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX4mjGJOmEq6gT
 IfdNmwoeV//RsVQadSowVedqHdpk4Up6CuprMlzO8t9+ZVoKJTPJ7CMRu87//5gcxar4iLrOagd
 SqZh1xaFRjQslbj/XwIJkxGKdILr2UQTICiJC7hfGG12ONGLjMpbMiZ7XzKFETC/dY67YjE6IHw
 yJ4RT5dn5seKKKzXDxrPG5Kow0Oqz6OmTiAOJbr1FMt1EjHLP1rR+BV9anVgzIEe+XBVMyYWUE8
 VYhl9iYCe0H18ikc2/jSRZitJqXstENGyjicnalnhNlqC1znAoKl4rwvapa5mVmQJYML5uSXkkv
 /vpn5wcsS2NQV/Pj4RkcOq3jwTockN8+KBkzVKOaRru/OW58yjcTx5318qdn09y1Iyu7lRZ2+j7
 XGwsOKRmpbB5XUVig2u7YO1GH2ULlkuoeXOVHFO2I14WAYwVc/1w7dcIxuoeOVoepEhcKNMEQ5E
 q0U4YUkQtiRhpz127sA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX9Gxtq+9VK4ef
 Qxp55YSQHwxh3/Ic6OIIXFACepTZ02TYgi0Xd2vo9l6CuXB8HEfSe4eHeDBSPJnKZgSaKW9177+
 ul0v/X7uBY+Rg8saBPpTgpiXLeJXYWM=
X-Proofpoint-ORIG-GUID: qq0TwPyDPuIr7Eetpnus9QcUybd8vkdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120018

ibmveth_remove() cancels the reset work before unregister_netdev(),
but NAPI keeps running until unregister closes the device and can
queue the reset again, on an interrupt enable failure, a bad
free_map entry or a bad RX slot. The reset can then run on the
adapter after free_netdev(), or reopen the device during unregister.

Use disable_work_sync(), which waits for a running reset and keeps
the work from being queued again. A bad RX slot also makes poll
spin, which can stall unregister; a later patch in this series
fixes that.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; it was not reproduced. Tested on a POWER10
LPAR with unbind and bind cycles under traffic. No kernel selftests
cover ibmveth.

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

