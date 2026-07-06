Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9733C1AD
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366633; cv=none; b=YSc5NeCJTRrzSTLgUZFEt+bZ2hkTtZYhpnvabft1A4MXbVTE8HqlTM++DATWWPtgvyJOpzp9gM0iotgXTE0a/sX+gDxwtUuAXmjC8m7w8R9nBUxFrFyuaxMk/bW39IqBavMfEY74lMA4g5Eb0i4psow32I1NaRMi4sBu+FL40m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366633; c=relaxed/simple;
	bh=c0UlIyPzVoS38lOqKuNemaPiDL0OuUcyCHqPIE6Dv2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SM6eWllyHQ6F9kJW+3qSgmPwd0P7owQF6hYiHMYsoQbyHK7V7TO3aC9T5JkdEPBerMzYaXlzlCJeFLL0bq6XMhgqNd9pyUCW9L4kFrcoIdY+B2f9QuXVcUX7ayQj+3mZqm3wmvqFfsQwxxqTYp5qs3Kvp1fCeYRfJL4que8e/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mRjbFni6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mRjbFni6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIqA8757010;
	Mon, 6 Jul 2026 19:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cQrIpqT0bGUKwqhkD
	Nycoj7YMDQ9fXIeDCvrzwtwXyI=; b=mRjbFni69dohaCQVIELiO7YFQCgg5W9t7
	BMakFDd5bQ3AFpZz1XI3RkMA4/2wd51SMpKcuhj9qoKuKnxugGP1dZQpyrHO4Zhc
	2effdmiAKmPmn7BhmyGCqipDD+YQvvqjlZl4ZCi/UD0pKGhk4O3bwsuDm8y09LEa
	J+jdptEW5glW3zQ9DJOZHwfMh7wiyi/J7/g55EM9/80T8xb0z1BsPeSEIbXBXeVD
	vipysExQ2LtcPdFFpg5vJJDE5W4NcoDllTKzJ0HWFsFIx5w8sq4GsHKVTgoE35FD
	a58Bfo0GZoAQI+eiThqJzgt2moqU3GaWjxEag6wPUg+OZpaSrVD1g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknb5eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:37:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JYZqQ004294;
	Mon, 6 Jul 2026 19:36:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfxr7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 19:36:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666Jawr3262674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 19:36:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 772BD5805E;
	Mon,  6 Jul 2026 19:36:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88E7858051;
	Mon,  6 Jul 2026 19:36:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.26.177])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 19:36:57 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v3 12/15] ibmveth: Expose per-queue buffer pool details via sysfs
Date: Mon,  6 Jul 2026 12:36:00 -0700
Message-Id: <20260706193603.8039-13-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260706193603.8039-1-mmc@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4c03dc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Pa5pnD676arj_S7OnbYA:9
X-Proofpoint-GUID: gT8IpHQ0OfDXliOCJ22BLYioqDrybOXl
X-Proofpoint-ORIG-GUID: ijix3NB2lT2nnsVneIldJGVkCgI8_z18
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfXwJYv/iu8W9ub
 jXUNJePQSIVi2YrmR5PBsr+y8SSMMZ2XqwSib0A/nqmVC4tWeAqdVzk9QFDV/M6t+HqEwio4yMl
 Euk8XzzfmzyyIl2xiNuvo9I5qpbyPRw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NSBTYWx0ZWRfX1lSI9U6Wi7f0
 O9CoUZ5jVuUm1ufSA9hOQvpy6nFqNOo1aMKAhCY+DZGV9hGKjz/nJ+Qe0r34G2Rbw0689xEaXfh
 +Nq1KFZ/NhcEY5tRARIAr2EzP7NEV5DU7dfyeM/zop0p9wIcQnRqwLr9Z9jUTxnFNC2+PRQljyk
 Lvlw3LIqqc8+MXwzeuB8eiD9JHiGSAOcObQJ9BOCSZeJxfUHo/6KwLi3frOTo2oijAeVKwhRX3A
 URZdShPrVOd+UosvN1vipMUyAQvoiv9anAgWyEeTdt53KoSmqaw+r/SrD7j5Uw+iU+VD1q/p8z9
 DyssoOKtznzv5sEDgGqqiVNPWISThQqnzyAhGpd0X3UAsdHxAFOcsXwMcJ535z+0HCvI5uylJtJ
 NI/ePuY1Dq47vLtYH1VZHibIORVl8vuYqiwIzmNCPCwMzvquaGHvGIT/ML7fzZUbG7OhmahRM4M
 2bduuheXgvXCgkSGKWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060195

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

