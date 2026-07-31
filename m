Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479D2C21DD
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458901; cv=none; b=qVMsK7w2A3FBt8pULV5/axHpJv7XHWH64zuncCHS6ymTrqDnt3YR+7v8eZbBRi/1dVmLQPNVEsXkHPiNTM+4oyxaSpy5uxr2eOaZpUJoIDaqGEz7kB6pJ+m+qAsyZHOIwCE6YqXucwPb8yFuwraxjkxhbxOVIBmgAvPt89zbpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458901; c=relaxed/simple;
	bh=RiykdDmWKU/ZyuDX0zGrRC+Sq/lZ/LQAmuzGFWJQat4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9oUmKK24y/Z+LYzUS5KzX1i/7l+YVuWRhrbCJbf2l4J2dItXwGQqiq27sAa30CJVuPEPy/TAOoMICNeTg0P7H1sW+fTVvSj+b2uPPTwMplVnH6NbSnXtlvY09yToc7/o2SrxnFNtDGNnfgWKiOim6dorhFIV8KLdNYiO17qRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sn5zILi0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sn5zILi0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNHa5r184532;
	Fri, 31 Jul 2026 00:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=W0TwsDpzNwRA457xZ
	ULCe/Ax2ANoFbzWec/BO/ZbF+o=; b=sn5zILi0LTE1QcY4vzj6vGRYOsX5+QMRo
	ocIZkTj1f34w5FAJ0NRqHgc9MgQHIK4G4dHnRIKGkWhlNhXtJ/d15satK7woPVSI
	uplf0Se4ODDa5oMDj0GEmn2TwnJvMF+AtfglXF2LAzPADrimfRpJ4RmGvnvoVXbe
	epKMI/diGKJZ3lJNHGWGursVWqIz6+J2iGGgCoWHHRAJ4i8UEhjszX6ywVlZgauR
	yoUlR+nYCU20x+5CWhN/lQ9FzosZsiWhLCkuqk9ccfKSsuKXqxF2AhuvTjB3gTSc
	46ZvKt2J87nTKitvZ6V7Hm1kmzmn5oA4nSJRjYwt8nAccHescUV9g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7tkcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fiEg008044;
	Fri, 31 Jul 2026 00:48:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkdv0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:48:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0m4pA63897916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:48:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA1EE58058;
	Fri, 31 Jul 2026 00:48:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED22A58057;
	Fri, 31 Jul 2026 00:48:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:48:02 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 11/14] ibmveth: Expose per-queue buffer pool details via debugfs
Date: Thu, 30 Jul 2026 17:47:14 -0700
Message-Id: <fa6f1b5f19acd2b54f6b2c19d27bd79f4ff60599.1785457143.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 3xUr2KIUNfuEkXUaQMPDpcWMolG_sCB7
X-Proofpoint-ORIG-GUID: kv1uOIcUgjgjyTZq9FTqZxhMyD_5gZEm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX3Ov9rmlTCU+3
 ASLzzlZSoC39C2zZ04i7CQnytLwZlv4ZDAyLUY6PwN6YABsaWVM8BMJ4p62R+a5UTsVhpaR1asE
 35EqRyPI5RrNbQ4l6abevN3Fh388Ucd2ZJJ0bYQ782pnp74rxRX5WUKxKDbgdY+/E9eO+jHwsiH
 fpVAWdKXYhiimqeh36ztu7SfcrxHg4qOtHs+JFVQgtSVbVL4URkkY6fqnQedOZSVLXM2PqG8d/m
 YGseQtIUI4qG3NtAZML8csC/3XMiqpwTS8wDtIh1WSVgM2qPeFovisjgbYaCo21DNbulAvAtrBc
 GB7TsP0vDoic37fYO7PPeExBb/PdR8M83Q+LEqpnnu8xHxkonERJP1StvUEYRM1fDlgGHlylBS0
 ELHSR0QsXZVeQWBuf4h8Q1ehTOUylVvQJTqw0Y2RifLsGv61OTecQ5qDeBzTQipoMZ5KZm+51hm
 fzi5u4q2MsrrvtsZiSw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bf0c6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=j1YzoZixPWT-uwAQvisA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfXzRaO/+rHMbCJ
 JedYEAfEEpZwi0AHU5EB8yDvUWJcExTjuUTQa841U5eipoapFHuBG4258oOSkk6XnHDjr2NeX7r
 GfIlE95lB3MOoUqOjcpjqy3DohO9qaU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310003

Add a read-only buffer_pools debugfs file that lists size, buff_size,
active, and available for every RX queue and buffer pool. That is the
MQ diagnostic view (multi-line table), which does not belong in sysfs.

Keep the historical queue-0 poolN sysfs ABI unchanged:

  .../poolN/{active,num,size}

Those are one-value-per-file *configuration* knobs for buffer-pool
classes on queue 0, not one directory per RX queue. With MQ, queue 0
pool geometry remains the shared template: open copies it to queues
1..N. Per-queue runtime pressure is what debugfs shows; this series
does not add per-queue pool sysfs dirs.

Unlike ibmvnic (one RX pool per RX queue, sized from firmware, almost
no pool sysfs), ibmveth historically has multiple size-class pools and
already exported poolN via sysfs. Moving only the new all-queue dump
to debugfs matches sysfs "one value per file" review feedback without
breaking that config ABI.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Move the all-queue buffer_pools diagnostic from sysfs to debugfs;
  subject updated to match.
- Keep historical queue-0 poolN/{active,num,size} sysfs as one-value
  config (template for MQ); do not add per-queue pool sysfs dirs.

 drivers/net/ethernet/ibm/ibmveth.c | 43 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/ibm/ibmveth.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index dbb47a42b4cb..db1374746602 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -31,6 +31,7 @@
 #include <linux/ipv6.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/debugfs.h>
 #include <asm/hvcall.h>
 #include <linux/atomic.h>
 #include <asm/vio.h>
@@ -2985,6 +2986,44 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 #endif
 };
 
+static int ibmveth_buffer_pools_show(struct seq_file *m, void *v)
+{
+	struct ibmveth_adapter *adapter = m->private;
+	int i, j;
+
+	seq_puts(m, "Queue  Pool  Size  BuffSize  Active  Available\n");
+	seq_puts(m, "-----  ----  ----  --------  ------  ---------\n");
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
+			struct ibmveth_buff_pool *pool =
+				&adapter->rx_buff_pool[i][j];
+
+			seq_printf(m, "%5d  %4d  %4u  %8u  %6d  %9d\n",
+				   i, j, pool->size, pool->buff_size,
+				   pool->active,
+				   atomic_read(&pool->available));
+		}
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ibmveth_buffer_pools);
+
+static void ibmveth_debugfs_init(struct ibmveth_adapter *adapter)
+{
+	adapter->debugfs_dir = debugfs_create_dir(adapter->netdev->name,
+						  NULL);
+	debugfs_create_file("buffer_pools", 0400, adapter->debugfs_dir,
+			    adapter, &ibmveth_buffer_pools_fops);
+}
+
+static void ibmveth_debugfs_exit(struct ibmveth_adapter *adapter)
+{
+	debugfs_remove_recursive(adapter->debugfs_dir);
+	adapter->debugfs_dir = NULL;
+}
+
 static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
 				  int pools_ready)
 {
@@ -3182,6 +3221,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	netdev_dbg(netdev, "registered\n");
 
+	ibmveth_debugfs_init(adapter);
+
 	return 0;
 }
 
@@ -3193,6 +3234,8 @@ static void ibmveth_remove(struct vio_dev *dev)
 
 	cancel_work_sync(&adapter->work);
 
+	ibmveth_debugfs_exit(adapter);
+
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
 
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 8e20ccd4a1d5..17faaa4c2d33 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -387,6 +387,8 @@ struct ibmveth_adapter {
 	struct ibmveth_rx_queue_stats *rx_qstats;
 	struct ibmveth_tx_queue_stats *tx_qstats;
 
+	struct dentry *debugfs_dir;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
-- 
2.50.1 (Apple Git-155)

