Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DC33689A;
	Mon,  5 Oct 2026 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180588; cv=none; b=RE7d5BFsJhdFJ+J1jS4kVkNRH3e1PsYduWVe/kIXY4MQfz6rHfmeyb46qhwBcumM7GOk1SoBSAdGx2UCnjx2iJZ7PV6o4ir+QJOCZj4GjaGB+ha/EyFn0Df7zP1ozG6G5GiHJLdvIvy9r1iAy13E4kfsLxwevhiSGk3aWzs00+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180588; c=relaxed/simple;
	bh=39zXM7oHMIK28SXfAL7Z0ODr2Bul3ruHfIHVSG1DClU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8ENNqpefGkkTVD3Joq0JIEb45dJ9EL5jRLDEaCId9kw0s6no8WX0XOj+VZVNuCokoBDx5bGh+NKMMlcxtx8C+39hgZsZicAWJT1UZy49GGGOZ21w1bXIbYFIUGSlHfm46CkEN6ATOcIBcOypf04ObU+zbANX0YMPYAVdarj4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kN/E7Pb4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kN/E7Pb4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515R9C3343841;
	Mon, 5 Oct 2026 06:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Aluqrs4QmgMRDQwSP
	/TN8259vQgzm7Wfkmmxx/BWBpA=; b=kN/E7Pb4r5vZyJ1lx1hyN2zRuOYa5m1ea
	i0NOixBDudNMqe19CJbLwiQRBd9K+nM1Vr+Cawi9Jn7tA3z1nzZDHGUvFqO/B+1A
	ZkIYSukvF3zo3RMpvdOBE1V8LtuU4scPScBxuxqcLEhdyT45bZ0fr8oZSVt2nzFY
	akRjisF8fvx+SKs3MOOY1tDfUnaxUN9WMzP5j+KoiLGhlyn5TnuZpR6Kx6rgesPP
	pj/fz/PX7bin685e7/IJ/Oapkrlb29W81Y8vJRDkdA7kVs+U2sPWhvcyIKwOUPxJ
	t/NDNIofFUFT7HLrupsFLNeXECe26feS7+mk9VcT47f3etONOvr7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74gpar-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69512ZbL2203895;
	Mon, 5 Oct 2026 06:09:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgm4aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:09:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69569Go211010686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:09:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 835DA58059;
	Mon,  5 Oct 2026 06:09:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60D495805D;
	Mon,  5 Oct 2026 06:09:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:09:13 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, nnac123@linux.ibm.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, jeff@garzik.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/8] ibmveth: release the pool kobjects when probe fails
Date: Sun,  4 Oct 2026 23:06:06 -0700
Message-Id: <34c7b4a7ff001425f89f4401309481c098d319cf.1791178212.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1791178212.git.mmc@linux.ibm.com>
References: <cover.1791178212.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qbsQGSZfKfdAFDtzkPploCLFP6pA5g3F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX2qJlKbSp5H1z
 1Ye0RzfHj5ZhKuTMUuM5czbQjj/c3IYZJOfcD0nTNzB+ZkTf5vmMa1xAx4oCatSGzHbMRgwcI+3
 vXLrYBXOCKB/dua46sEyjsku6IHfu/E=
X-Proofpoint-GUID: BCBKVmXYgAWRqAX0E1DaxJlgI5suNSxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX6Fu383iTlb1T
 wXcDMJqZL97JTWx6N/tjdjvJcjga/oOmQts1rAYVlmIoGWC5rkgqz/1hjLTViG/fCjEov9CrnNr
 YXr2TGxQN5zVlGncIjWEDILy+5YizaIa/TKIpS3El+BRKbqlyffGpPdmkO6RrLD/z19iT/xOO7z
 iod/NIeWjWCfPA7Xegngap1N47CuQJHKhkYFuie3I4ORx14C0FMh0RJFYwmai8ZXEE1sZHj9UZy
 rG+akyxkwVOL5YEwYIzDSmCY2N8nRG/PNQW/+Vvasph3alEd/v46hPXcx/JfUdexxEmKOGrKNmr
 jhXx+KkS5LlusE8szZjRQiDxl8iA0c9hksvDLKP/mmjQgLMO992WYD7k3h3aGJu2UQzkGRqeYig
 vTnsStkFtxgfaMtO8RHrX6COPZvHl8WoYiG/0Me7zZl15liQ4rr1VpVBmVHpn2kwxTKbPzFyP4z
 m7FH/gTBxILQAbvs6xw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac33f10 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=9zeWAwZ5pCssfL0I92cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

If register_netdev() fails in ibmveth_probe(), for example with -EINTR
when the binding task is killed, probe frees the netdev but leaves the
pool%d kobjects embedded in it registered in sysfs. Reading
/sys/devices/vio/<unit>/pool0/num is then a use-after-free, and the
next probe cannot add pool0.

Put the kobjects before freeing the netdev, as ibmveth_remove() does,
on this path and on the netif_set_real_num_tx_queues() one.

The kobjects also have no release(). With CONFIG_DEBUG_KOBJECT_RELEASE,
kobject_put() defers their cleanup, including removing the sysfs files,
to a work item, so free_netdev() can free them first, here and in
remove(). Add a release() that signals a per-pool completion, and wait
for it in both places before free_netdev(). Without that config,
release() runs from kobject_put() and the wait returns at once.

Found by AI-assisted review of the ibmveth multi-queue RX series and
confirmed by code inspection; the release() part was raised by the
Sashiko AI review of the first version. Tested on a POWER10 LPAR with
register_netdev() forced to fail with -EINTR by a test-only module
parameter (not part of this patch): no pool%d directories remain and the
device binds again. No kernel selftests cover ibmveth.

Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---

Changes in v2:
- give the pool kobjects a release() that signals a per-pool
  completion, and wait for it before free_netdev() in probe and
  remove(); with CONFIG_DEBUG_KOBJECT_RELEASE the deferred cleanup
  could run after the free (Sashiko review of v1)
- put the kobjects through one helper, ibmveth_put_pool_kobjs(),
  and an err_put_pools label for both probe failure paths

 drivers/net/ethernet/ibm/ibmveth.c | 52 +++++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmveth.h |  3 ++
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3bac6cabbbb4..a10ebaca9081 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1850,6 +1850,40 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_features_check	= ibmveth_features_check,
 };
 
+/**
+ * ibmveth_pool_kobj_release - Mark a pool kobject finished
+ * @kobj: kobject embedded in the pool
+ *
+ * The pool kobjects live in netdev_priv(), so the last put must wait
+ * for this before free_netdev().
+ */
+static void ibmveth_pool_kobj_release(struct kobject *kobj)
+{
+	struct ibmveth_buff_pool *pool = container_of(kobj,
+						      struct ibmveth_buff_pool,
+						      kobj);
+
+	complete(&pool->released);
+}
+
+/**
+ * ibmveth_put_pool_kobjs - Drop the pool kobjects and wait for release
+ * @adapter: ibmveth adapter
+ *
+ * With CONFIG_DEBUG_KOBJECT_RELEASE the cleanup, including removing the
+ * sysfs files, runs later from a work item in the kobject; wait for it
+ * so free_netdev() cannot free the pools first.
+ */
+static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		kobject_put(&adapter->rx_buff_pool[i].kobj);
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
+		wait_for_completion(&adapter->rx_buff_pool[i].released);
+}
+
 static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
 	int rc, i, mac_len;
@@ -1960,6 +1994,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
 					 pool_count[i], pool_size[i],
 					 pool_active[i]);
+		init_completion(&adapter->rx_buff_pool[i].released);
 		error = kobject_init_and_add(kobj, &ktype_veth_pool,
 					     &dev->dev.kobj, "pool%d", i);
 		if (!error)
@@ -1971,8 +2006,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	if (rc) {
 		netdev_dbg(netdev, "failed to set number of tx queues rc=%d\n",
 			   rc);
-		free_netdev(netdev);
-		return rc;
+		goto err_put_pools;
 	}
 	adapter->tx_ltb_size = PAGE_ALIGN(IBMVETH_MAX_TX_BUF_SIZE);
 	for (i = 0; i < IBMVETH_MAX_QUEUES; i++)
@@ -1987,25 +2021,27 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	if (rc) {
 		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
-		free_netdev(netdev);
-		return rc;
+		goto err_put_pools;
 	}
 
 	netdev_dbg(netdev, "registered\n");
 
 	return 0;
+
+err_put_pools:
+	ibmveth_put_pool_kobjs(adapter);
+	free_netdev(netdev);
+	return rc;
 }
 
 static void ibmveth_remove(struct vio_dev *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(&dev->dev);
 	struct ibmveth_adapter *adapter = netdev_priv(netdev);
-	int i;
 
 	disable_work_sync(&adapter->work);
 
-	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
-		kobject_put(&adapter->rx_buff_pool[i].kobj);
+	ibmveth_put_pool_kobjs(adapter);
 
 	unregister_netdev(netdev);
 
@@ -2181,7 +2217,7 @@ static const struct sysfs_ops veth_pool_ops = {
 };
 
 static struct kobj_type ktype_veth_pool = {
-	.release        = NULL,
+	.release        = ibmveth_pool_kobj_release,
 	.sysfs_ops      = &veth_pool_ops,
 	.default_groups = veth_pool_groups,
 };
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 3f2240823f6a..be0939caa328 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -14,6 +14,8 @@
 #ifndef _IBMVETH_H
 #define _IBMVETH_H
 
+#include <linux/completion.h>
+
 /* constants for H_MULTICAST_CTRL */
 #define IbmVethMcastReceptionModifyBit     0x80000UL
 #define IbmVethMcastReceptionEnableBit     0x20000UL
@@ -143,6 +145,7 @@ struct ibmveth_buff_pool {
     struct sk_buff **skbuff;
     int active;
     struct kobject kobj;
+	struct completion released;
 };
 
 struct ibmveth_rx_q {
-- 
2.39.3 (Apple Git-146)

