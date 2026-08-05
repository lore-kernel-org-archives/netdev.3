Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBB47043E
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969874; cv=none; b=HeFi918VUHqkiuqqrkIStQON/vlLJ9Ho1bDzZRBzvilqgAYX3Jbf6nXOcSLGRTuB6MOGXyBI+aMix85UYNDMj9g2Q0c/d8oYofysANsICSM07Y8Z6+scNgCLpUoF5/SBwZu8ryakrhqNO6PV2FXbVYwkwdVSaoXnMZluaxDcPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969874; c=relaxed/simple;
	bh=YqEUWo/3H5EbTSD0WkeWyh/zstMheP9p3cWDUvIsc/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUAM7l6NZQtiUXFGy8IrttvXEJLbZT1gd6TzIdumFxMJG3v2XntyIVe8xa6eG2PzqWZ+GluVavsnnLdIH+Z0mpSlC+VoiUZbDuN8dB+6GNsQ0AoPCoVk83nmMT8n2xmmF3Xd00aqlxCeyko+hAQVke2Hb+Mn8ElnrpmrQU/wDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e4aVBlyl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e4aVBlyl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Hlhkf394792;
	Wed, 5 Aug 2026 22:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+wio647H132F5XatW
	I6sMsuTPjtVfx2YGqwmAgmUcwE=; b=e4aVBlylGh68T3MVV4K4UqMXnvxMF6jH9
	J+nlsYwO9VAxjgtSBiibmMUlWSCovZYxsa1B1NyzeGrI1fBUK+yBB3I0w2dr4ALE
	ODEtGBP5GZqJIJYVBYpZNShsFNkiZxQ6bgy8Xp8ZvmNtGDIdy8pgUD5qcBez2EEx
	FZMxyRTOd4jn3omZdKcA+qQtmy0Dg78Djk1S4/e/wueWZE40g6fn4fbgI66p065B
	4Yx9LGZ64WePv1WBPuB0yqUTyvBox+Q19/EvAKWTAT1Xol0T8cv9bDGYa0MtkLc3
	vNxRVf99VS0tgsGQq747/dupOsFQhhs2zwuQlykWyWfzBnOcMiEBA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euvtcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675MfFO2016546;
	Wed, 5 Aug 2026 22:44:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qrs0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675MiGfg22807188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:44:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C6B85805C;
	Wed,  5 Aug 2026 22:44:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59D6F58054;
	Wed,  5 Aug 2026 22:44:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.135.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 22:44:14 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mmc@linux.ibm.com
Subject: [PATCH net-next v1 1/6] ibmvnic: cap rx pool entries against the real buffer size
Date: Wed,  5 Aug 2026 15:43:56 -0700
Message-Id: <20260805224401.58791-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260805224401.58791-1-mmc@linux.ibm.com>
References: <20260805224401.58791-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dkF4Cv3iaM0m3-CZijUQfdX0Q_1nJ9o1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfXwk5cpNs9zc1K
 9ddojyzDcQ0XOfdWBr7JG7LEpzDa6DvC+yJPGyRUvqi0O4t+VjnF1CyvwsB0U8MMK+maIulJWcD
 M2xZgOjL1D4RXFG5fuln8uyickqZa2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX8XcAL1wlZRT7
 73KhFBZadnJihiL29dJQAV95rjEBnPX49Rji0jDcrl35oVEZEaD1xg1X5HsNJB/u0ot/pP0JdRg
 eSNTT7OFycXHP+vEbb8u/tTPohUTGi5HCFEjR+1+bnwMiQUbR2ErBtc8b3918apSki0f3Xqctdl
 KtBQ4kpWnoIwO1Wsz4Bcu8bdavpIaW4DdKjnxN0J5z0Cfi8rcAytxC7GX7lmPSl6wFB/+I8WkSl
 XHAHVEWfKgE5sEtPh43NCmsGDMXDDBQHarmLMVH2uwGUneNH41wRTzS7j8BgVM4EKVOtbq8R0w0
 1FpefaMRPWWcxLmfXyVmX0OuaQfXQJ76jQ0JpL5tt1v6KUCQxE1Lft8PbxeIiJ5pAaPLdHX0RoB
 AUWBlPGz7iUw0Ji+2nhbjpNYRDS2RSTJeCmaqrKlZBb+9dYM3a2hF6QZR3Ngx5tUJcAheIwg3Vi
 U2uVUZo0+K9RyyW8MaA==
X-Proofpoint-GUID: XAumqa-L1D29YRxcACM2fosKIxzpiS6c
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a73bcc3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=RX7lkqzSWFBi5ArnvYEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050183

Changing the mtu from 1500 to a value in the 2000..8000 range can fail
pool allocation and leave the interface down:

  ibmvnic 30000008: Couldn't alloc long term buffer
  __alloc_pages: ... order:N, mode:0x...

(9000 happens to succeed, which is how the middle of the range stood out.)

That is the non-bucket case this series exists to allow: the guest mtu is
not one of the sizes the backing buffers were sized for. Until the next
patch, req_mtu was always forced back to a size the device carries, so
the pool guard happened to measure the right buffer. Once arbitrary
in-range mtus are honoured, that luck goes away.

send_request_cap() limits how many entries a pool may hold so the whole
pool fits in one long term buffer set:

  max_entries = IBMVNIC_LTB_SET_SIZE /
                (adapter->req_mtu + IBMVNIC_BUFFER_HLEN);

The rx buffers are not sized from req_mtu. init_rx_pools() sizes them
from cur_rx_buf_sz, which comes from the login response and describes
the backing device. When the VIOS has the device at jumbo (cur_rx_buf_sz
around 9014) but the guest mtu is still smaller, the guard measures a
buffer much smaller than the one really allocated. The entry count
passes through untouched and the pool asks for several times the space
the guard assumed - enough that dma_alloc_coherent() / __alloc_pages()
refuses the request on kernels whose per-pool LTB budget is a single
allocation rather than a large set.

With a backing size of 9014 the buffers are ALIGN(9014, L1_CACHE_BYTES)
= 9088 bytes, while an mtu of 2000 leaves the guard working from 2514.
The overshoot only shrinks as req_mtu approaches the backing size, so
the largest mtus are the safe ones and everything below drifts.

Cap the count against the size the buffers are really allocated at.
reuse_rx_pools() has to compare against the same number or it would
see a difference on every reset and reallocate pools that are already
the right shape. clean_rx_pools() must walk rx_pool->size for the same
reason, or a clamped pool would be cleaned past its end.

Comes ahead of the next patch, which is what lets req_mtu sit below
the backing size. Keep the two together when backporting.

Fixes: c26eba03e407 ("ibmvnic: Update reset infrastructure to support tunable parameters")
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Vaishnavi Bhat <vaishnavi@linux.ibm.com>
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..86e643ee6b3b 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1021,6 +1021,24 @@ static void release_rx_pools(struct ibmvnic_adapter *adapter)
 	adapter->prev_rx_pool_size = 0;
 }
 
+/**
+ * rx_pool_entries() - Number of buffers one rx pool may hold
+ * @adapter: ibmvnic adapter
+ *
+ * send_request_cap() budgets the entry count with req_mtu, but the
+ * buffers are sized from cur_rx_buf_sz. Cap against that size here.
+ */
+static u64 rx_pool_entries(struct ibmvnic_adapter *adapter)
+{
+	u64 buff_size = ALIGN(adapter->cur_rx_buf_sz, L1_CACHE_BYTES);
+
+	if (!buff_size)
+		return adapter->req_rx_add_entries_per_subcrq;
+
+	return min_t(u64, adapter->req_rx_add_entries_per_subcrq,
+		     IBMVNIC_LTB_SET_SIZE / buff_size);
+}
+
 /**
  * reuse_rx_pools() - Check if the existing rx pools can be reused.
  * @adapter: ibmvnic adapter
@@ -1048,7 +1066,7 @@ static bool reuse_rx_pools(struct ibmvnic_adapter *adapter)
 	new_num_pools = adapter->req_rx_queues;
 
 	old_pool_size = adapter->prev_rx_pool_size;
-	new_pool_size = adapter->req_rx_add_entries_per_subcrq;
+	new_pool_size = rx_pool_entries(adapter);
 
 	old_buff_size = adapter->prev_rx_buf_sz;
 	new_buff_size = adapter->cur_rx_buf_sz;
@@ -1082,7 +1100,7 @@ static int init_rx_pools(struct net_device *netdev)
 	u64 buff_size;
 	int i, j, rc;
 
-	pool_size = adapter->req_rx_add_entries_per_subcrq;
+	pool_size = rx_pool_entries(adapter);
 	num_pools = adapter->req_rx_queues;
 	buff_size = adapter->cur_rx_buf_sz;
 
@@ -2000,7 +2018,6 @@ static void clean_rx_pools(struct ibmvnic_adapter *adapter)
 {
 	struct ibmvnic_rx_pool *rx_pool;
 	struct ibmvnic_rx_buff *rx_buff;
-	u64 rx_entries;
 	int rx_scrqs;
 	int i, j;
 
@@ -2008,7 +2025,6 @@ static void clean_rx_pools(struct ibmvnic_adapter *adapter)
 		return;
 
 	rx_scrqs = adapter->num_active_rx_pools;
-	rx_entries = adapter->req_rx_add_entries_per_subcrq;
 
 	/* Free any remaining skbs in the rx buffer pools */
 	for (i = 0; i < rx_scrqs; i++) {
@@ -2017,7 +2033,7 @@ static void clean_rx_pools(struct ibmvnic_adapter *adapter)
 			continue;
 
 		netdev_dbg(adapter->netdev, "Cleaning rx_pool[%d]\n", i);
-		for (j = 0; j < rx_entries; j++) {
+		for (j = 0; j < rx_pool->size; j++) {
 			rx_buff = &rx_pool->rx_buff[j];
 			if (rx_buff && rx_buff->skb) {
 				dev_kfree_skb_any(rx_buff->skb);
-- 
2.50.1 (Apple Git-155)

