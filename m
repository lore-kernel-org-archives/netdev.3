Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C183CC327
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944759; cv=none; b=otJs920uyD+ZF2ynq9Fh2hsnU6DnhxeQJsguGAUxNzm6jiYda9SyIpL50R47FGTC0NcJ2wLZXokZrTdQQAoxPak87kq2cwxThoLsHaOunxLIhNm4Hb1tZBTx4HaGsZmivRM+CZMvg3cCrM1dFLmIi3vhcUa/IViMzHy0EJq61Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944759; c=relaxed/simple;
	bh=c0UlIyPzVoS38lOqKuNemaPiDL0OuUcyCHqPIE6Dv2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJz80hMhPFd+p2h0TtGW0kETcZ3hwEzDnuKDYajy2Lwn4BxkP6om+HQcCEPOv5IRvZdPD104M/UL+/PA/xKcCzLPiL8nMpTk07RzSlX2SCL5iM+k7WAfUt/2qzq2lbMKaolVjdCvFOVKJYdEXnSR9x6kzvwU+ev/uJAok6s9rVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G/BR1joK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G/BR1joK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661LoQlk2229186;
	Wed, 1 Jul 2026 22:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cQrIpqT0bGUKwqhkD
	Nycoj7YMDQ9fXIeDCvrzwtwXyI=; b=G/BR1joK6CbABK/jlfT6yXhqt1KdGdqsu
	uDG46AVxNC3UlU1CxDIylVvPPkXdZjfb3LJogs4LwfHkS/q0g11l3LJ61tunnTbT
	d0gnH6jEHZ8jMHWOzSi44yrPEMlOFvMhb10E0sPm9L/1C1eztHD5oZAtoS7r/dmy
	SE30LkUIA5Iy1+gukpYq8dMQWqRalbFKdzSHDPiFC/14aGwdmrsxCk6g0SZOpf2g
	8YvyC4LSePcLQ3Ib7tDGr1to1Dq7rYZrqv+UJNMric+b8fQR7q2gZ2YnvNrUuAfh
	pch3I3uehhkBkVUBVSPKCKAF6ji9ssQ+qWRyk84zR9aTBqHhVD3hw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg6x4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJadP025324;
	Wed, 1 Jul 2026 22:25:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gh8ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPicK60883374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DF9E58067;
	Wed,  1 Jul 2026 22:25:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D92F458055;
	Wed,  1 Jul 2026 22:25:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:42 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 11/15] ibmveth: Expose per-queue buffer pool details via sysfs
Date: Wed,  1 Jul 2026 15:23:23 -0700
Message-Id: <20260701222327.61325-12-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4593eb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Pa5pnD676arj_S7OnbYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX8j1T7YHEV+Rn
 RAUKfQETu2JAi5qc05JKp2kRT8PJOfNgSee9Il2HugVWX1vpkKH6N0yT3Mv5SEzm8BhrpZc01dQ
 VQDF/MWMwBMluHZur1XjZwcBpytEW6E=
X-Proofpoint-GUID: PffDoAkj4RYSDf35OJ8v1LC4veQ_Cvm5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX2WepJEnZc6WR
 Wchsu2JGN6zVSOw24NcIwrYaqdgewLCsqMaUAHfQiReplJQujHHy9hAi0g8YUAtEnmdkPMkUTFw
 Lvo/dtqOeFCj4b6WAlHOL17IaJxy/r2y/yMlGL7uwKWwyg/XmiFontqR2uMh2dkmtfhecUg1QQz
 G9MTWCS0rU4H3pg3m0/dVesvJ19nDtVV35r/8xPfpfRlKxGE0eCrD8+Wr9JhcOlh9P2/K+Af4Ou
 Eaa5JTLht8jxlsEy7JOkqwk/eptbZP1Jgs9+TBYtgj6ctxBaVvVSmjRtoXPiMIVNuvQlHYmxvWW
 8B+yAecpbi35xYViJRxalz5OESx/K1a1pitNgV+IywIPS+6L6B9iwO5T7dWr6BHO+L9E5cXkdIX
 WGyxkiuwpnXtwRI76+R/PzmJ+SjAPOZj4eD1twN0mEXjstP8oXU8rDCFHrYz/KWEwv9e2tiN25F
 UX7DvGEZAyw8H1UnOPw==
X-Proofpoint-ORIG-GUID: F4OzQSCLrICuB1FUj-rKlTyBs2w58o0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239

Add a read-only buffer_pools sysfs attribute under the VIO device that
lists size, buff_size, active, and available for every RX queue and
pool: runtime per-queue buffer pressure during MQ operation. ethtool -S
pool%d_* (previous patch) reports queue-0 static probe geometry only;
sysfs is the right place for dynamic per-queue pool state at scale.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4e3f49b6346f..ecc472ee8f71 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -2896,6 +2896,52 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 #endif
 };
 
+static const struct attribute_group ibmveth_attr_group;
+
+static ssize_t buffer_pools_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct net_device *netdev = dev_get_drvdata(dev);
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+	int len = 0;
+	int i, j;
+
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			 "Queue  Pool  Size  BuffSize  Active  Available\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len,
+			 "-----  ----  ----  --------  ------  ---------\n");
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
+			struct ibmveth_buff_pool *pool =
+				&adapter->rx_buff_pool[i][j];
+
+			len += scnprintf(buf + len, PAGE_SIZE - len,
+					 "%5d  %4d  %4u  %8u  %6d  %9d\n",
+					 i, j, pool->size, pool->buff_size,
+					 pool->active,
+					 atomic_read(&pool->available));
+
+			if (len >= PAGE_SIZE - 100)
+				goto out;
+		}
+	}
+
+out:
+	return len;
+}
+static DEVICE_ATTR_RO(buffer_pools);
+
+static struct attribute *ibmveth_attrs[] = {
+	&dev_attr_buffer_pools.attr,
+	NULL,
+};
+
+static const struct attribute_group ibmveth_attr_group = {
+	.attrs = ibmveth_attrs,
+};
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
 	int rc, i, mac_len;
@@ -3056,6 +3102,14 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	netdev_dbg(netdev, "registered\n");
 
+	rc = sysfs_create_group(&dev->dev.kobj, &ibmveth_attr_group);
+	if (rc) {
+		netdev_err(netdev, "failed to create sysfs attributes rc=%d\n", rc);
+		unregister_netdev(netdev);
+		free_netdev(netdev);
+		return rc;
+	}
+
 	return 0;
 }
 
@@ -3067,6 +3121,8 @@ static void ibmveth_remove(struct vio_dev *dev)
 
 	cancel_work_sync(&adapter->work);
 
+	sysfs_remove_group(&dev->dev.kobj, &ibmveth_attr_group);
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 
-- 
2.39.3 (Apple Git-146)

