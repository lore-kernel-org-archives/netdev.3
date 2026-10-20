Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464304;
	b=OFVNfIFqEaEQx+xKdqsq1ysaLx8RcDP0qq0djMzT1J5H0dmFaK41ezqyIO//N8pDtDsN
	 azSP8G+QgkbSmaPp8cTFTKBC2GuY6UCHUFKQ9cP+e9J1T1zFmoeCB8K5AgInUzHdwjQio
	 ig/OOEqyPuVHheeTNecCms8mNrbZ7P4RpxHaB7GczOY6mKpWQs9LjQQ9O5AQTnRdkXkoe
	 jpod99IWkvb+3JHa/dtP8yshUfMQ3P1mJ/xFXIoLs3DIfC0PEoT68CgP/aSsdPJ6ZkOA0
	 uuS7cLeEQ41et5mVxVRGEvRRhM9+3C/mx5U3bnKKS7qLlfQnzts344xjMNz2M/KWMEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464304;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=IFv7vbxJLGLObxW15iqz+nNEO4suaelXyxqktavpmL8=;
	b=J+o54sYzsN9D2hL6Ntdw7ZHS2UqXTo82O7o9C22nNc4oalbZkh/kHU0xM6lFArRhKyAA
	 fXiHmW9AlHL7IOU0MKlyX4wCOZhp/HQs4ijufgJiH5KjtE4BhUchnDxBAMmv+QMi7ov7F
	 s+5cxMwajZ9oBXL58dOABuQfmqfP8/TJm+q2EUvV6zD9KIOAuxYdH91QiM/AHKfkYN6cB
	 pVDTgmGISn2eQkdlPDlSDAWitTbpzKbOqxzcUpDvuwOJXUkwRzhfZhwIsUG71eKuV1VBB
	 e4KyGjfTnlVgy159hflSFJwy1hYKhRAENRyMLvqhSwLYx++NO4QmrCDtOULMbbkv9Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=X+2ovOcZ;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54276606A31A;
	Tue, 20 Oct 2026 02:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54276606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=X+2ovOcZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IF
	v7vbxJLGLObxW15iqz+nNEO4suaelXyxqktavpmL8=; b=X+2ovOcZ4OyYsG5oeM
	RM2ilSbBpw8v8XDEDglTOvlXDGi68snA5Q1W9Zw+a2uisdRR5LpQHYGBTWqeEysn
	ZSBycWbrWS5dMoAsDfsHObehaEbrpFoDickwhl+3L0hav2KKm+2NWVOi8oxAUxgI
	V7gLThEpDZNyS2t5RhZ1ILYSw=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3X3yD1dZqXuo8Aw--.20289S2;
	Tue, 20 Oct 2026 10:44:21 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: shshaikh@marvell.com,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] qlcnic: Protect loopback filter hashes
Date: Tue, 20 Oct 2026 10:44:17 +0800
Message-ID: <20261020024417.517941-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3X3yD1dZqXuo8Aw--.20289S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww1kArWrCFy3GrW3XF1xuFg_yoWxZF4DpF
	srWFyUJrn8XFyDtan7Gw48ury3u3y8KrW0gFWDG39a9F1jqr1xurW5KrWag3s8Cws3Xa9x
	Zr4DXwn8Ar4qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC-AXmymrW1YX1cgAA3+

QLCNIC tracks learned MAC filters in two hash tables, but the existing
mac_learn_lock and rx_mac_learn_lock protect only some insertion and
deletion operations.  Filter aging and interface teardown traverse,
unhash, and free nodes while the TX and loopback RX paths traverse or
update the same buckets without holding the corresponding lock.

The race is reachable when filter aging or interface down runs while
packets create or refresh learned filters on another CPU.  A transmit or
loopback lookup can follow a node that the aging task has just freed,
and concurrent modification can corrupt a bucket.  The result can be a
use-after-free detected by KASAN, corrupted filter accounting, or a panic.

Extend the two existing locks over each complete hash-table operation:
aging and teardown hold the lock while traversing, deleting from the
firmware, unhashing, and freeing; the transmit and loopback receive paths
hold it while checking the count, looking up, updating timestamps, and
inserting a new node.  The existing firmware-command path is already called
under these spinlocks, so no new lock class or lock ordering is introduced.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: b5e5492c0d49 ("qlcnic: support mac learning")
Fixes: 53643a75b147 ("qlcnic: fix ping resumption to a VM after a live migration")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 .../net/ethernet/qlogic/qlcnic/qlcnic_hw.c    | 12 +++++------
 .../net/ethernet/qlogic/qlcnic/qlcnic_io.c    | 21 +++++++++++++------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
index e58176badc1f..c7309ecf6023 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -635,6 +635,7 @@ void qlcnic_prune_lb_filters(struct qlcnic_adapter *adapter)
 	unsigned long expires;
 	u8 cmd;
 
+	spin_lock_bh(&adapter->mac_learn_lock);
 	for (i = 0; i < adapter->fhash.fbucket_size; i++) {
 		head = &(adapter->fhash.fhead[i]);
 		hlist_for_each_entry_safe(tmp_fil, n, head, fnode) {
@@ -646,14 +647,14 @@ void qlcnic_prune_lb_filters(struct qlcnic_adapter *adapter)
 							  tmp_fil->faddr,
 							  tmp_fil->vlan_id,
 							  cmd);
-				spin_lock_bh(&adapter->mac_learn_lock);
 				adapter->fhash.fnum--;
 				hlist_del(&tmp_fil->fnode);
-				spin_unlock_bh(&adapter->mac_learn_lock);
 				kfree(tmp_fil);
 			}
 		}
 	}
+	spin_unlock_bh(&adapter->mac_learn_lock);
+	spin_lock_bh(&adapter->rx_mac_learn_lock);
 	for (i = 0; i < adapter->rx_fhash.fbucket_size; i++) {
 		head = &(adapter->rx_fhash.fhead[i]);
 
@@ -661,14 +662,13 @@ void qlcnic_prune_lb_filters(struct qlcnic_adapter *adapter)
 		{
 			expires = tmp_fil->ftime + QLCNIC_FILTER_AGE * HZ;
 			if (time_before(expires, jiffies)) {
-				spin_lock_bh(&adapter->rx_mac_learn_lock);
 				adapter->rx_fhash.fnum--;
 				hlist_del(&tmp_fil->fnode);
-				spin_unlock_bh(&adapter->rx_mac_learn_lock);
 				kfree(tmp_fil);
 			}
 		}
 	}
+	spin_unlock_bh(&adapter->rx_mac_learn_lock);
 }
 
 void qlcnic_delete_lb_filters(struct qlcnic_adapter *adapter)
@@ -679,6 +679,7 @@ void qlcnic_delete_lb_filters(struct qlcnic_adapter *adapter)
 	int i;
 	u8 cmd;
 
+	spin_lock_bh(&adapter->mac_learn_lock);
 	for (i = 0; i < adapter->fhash.fbucket_size; i++) {
 		head = &(adapter->fhash.fhead[i]);
 		hlist_for_each_entry_safe(tmp_fil, n, head, fnode) {
@@ -688,13 +689,12 @@ void qlcnic_delete_lb_filters(struct qlcnic_adapter *adapter)
 						  tmp_fil->faddr,
 						  tmp_fil->vlan_id,
 						  cmd);
-			spin_lock_bh(&adapter->mac_learn_lock);
 			adapter->fhash.fnum--;
 			hlist_del(&tmp_fil->fnode);
-			spin_unlock_bh(&adapter->mac_learn_lock);
 			kfree(tmp_fil);
 		}
 	}
+	spin_unlock_bh(&adapter->mac_learn_lock);
 }
 
 static int qlcnic_set_fw_loopback(struct qlcnic_adapter *adapter, u8 flag)
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 761ef3bc8193..2aefb6e9a2eb 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -207,27 +207,33 @@ static void qlcnic_add_lb_filter(struct qlcnic_adapter *adapter,
 		 (adapter->fhash.fbucket_size - 1);
 
 	if (loopback_pkt) {
-		if (adapter->rx_fhash.fnum >= adapter->rx_fhash.fmax)
-			return;
 
 		head = &(adapter->rx_fhash.fhead[hindex]);
 
+		spin_lock(&adapter->rx_mac_learn_lock);
+		if (adapter->rx_fhash.fnum >= adapter->rx_fhash.fmax) {
+			spin_unlock(&adapter->rx_mac_learn_lock);
+			return;
+		}
+
 		tmp_fil = qlcnic_find_mac_filter(head, &src_addr, vlan_id);
 		if (tmp_fil) {
 			time = tmp_fil->ftime;
 			if (time_after(jiffies, QLCNIC_READD_AGE * HZ + time))
 				tmp_fil->ftime = jiffies;
+			spin_unlock(&adapter->rx_mac_learn_lock);
 			return;
 		}
 
 		fil = kzalloc_obj(struct qlcnic_filter, GFP_ATOMIC);
-		if (!fil)
+		if (!fil) {
+			spin_unlock(&adapter->rx_mac_learn_lock);
 			return;
+		}
 
 		fil->ftime = jiffies;
 		memcpy(fil->faddr, &src_addr, ETH_ALEN);
 		fil->vlan_id = vlan_id;
-		spin_lock(&adapter->rx_mac_learn_lock);
 		hlist_add_head(&(fil->fnode), head);
 		adapter->rx_fhash.fnum++;
 		spin_unlock(&adapter->rx_mac_learn_lock);
@@ -330,6 +336,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 	hindex = hval & (adapter->fhash.fbucket_size - 1);
 	head = &(adapter->fhash.fhead[hindex]);
 
+	spin_lock(&adapter->mac_learn_lock);
 	hlist_for_each_entry_safe(tmp_fil, n, head, fnode) {
 		if (ether_addr_equal(tmp_fil->faddr, (u8 *)&src_addr) &&
 		    tmp_fil->vlan_id == vlan_id) {
@@ -337,6 +344,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 				qlcnic_change_filter(adapter, &src_addr,
 						     vlan_id, tx_ring);
 			tmp_fil->ftime = jiffies;
+			spin_unlock(&adapter->mac_learn_lock);
 			return;
 		}
 	}
@@ -347,14 +355,15 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 	}
 
 	fil = kzalloc_obj(struct qlcnic_filter, GFP_ATOMIC);
-	if (!fil)
+	if (!fil) {
+		spin_unlock(&adapter->mac_learn_lock);
 		return;
+	}
 
 	qlcnic_change_filter(adapter, &src_addr, vlan_id, tx_ring);
 	fil->ftime = jiffies;
 	fil->vlan_id = vlan_id;
 	memcpy(fil->faddr, &src_addr, ETH_ALEN);
-	spin_lock(&adapter->mac_learn_lock);
 	hlist_add_head(&(fil->fnode), head);
 	adapter->fhash.fnum++;
 	spin_unlock(&adapter->mac_learn_lock);
-- 
2.43.0

