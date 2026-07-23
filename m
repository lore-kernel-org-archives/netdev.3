Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9C31A065
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773497; cv=none; b=YrZz4ISj8A56qmPKLJQMFeRAvM5Oev1fcWieyvstL/TyqIDz/ClsNe0fhodVmjyZHjkJkkoVUckTqlkIr0l8Wcfxc5Km4EqAZmEWWVPECGohHnNMj5V6VskZ8NqAN0jjUAngmSGTqGIuQABWomOYRb7yRvenMJWWUVBK8GsQMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773497; c=relaxed/simple;
	bh=tABmB1/kW0JDasoLUwQOzzuBiYWYw9a7bzBSFdsm7e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaZC/jgfON316550Gn3sCJ4LkgK1CFE/xSyOYk5jtv5tB8SBgrOQZ1eerwAs6EEx8BqDgApPvVo2PEiAjMP2kEXX6LtOQxTpfpliIPSSCQMxAxaPcOzW/Xp3989Ffn9x4qY01YJCZgedgSEbkVO9S9PJDjZuL8mFE1ETQJRCskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNYfsv9F; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNYfsv9F"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caf228a910so1346785ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784773494; x=1785378294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fZCnR4B/MekCn1lTTtDL2oBst2/7Abw1Lem8ZtySJ4Y=;
        b=YNYfsv9F/AlzXxQhRvSwDWelt4LXmnFOfS+MKesbu8SO45UZrxD3BvInCxqda2WUqE
         6oH2tmrYVqBni122kDZ6GVMVQ+7sjggWoAkvWtDpe3jO12hAlqNekRcOBydHCoH4mLQI
         gtlRbVAGENdsFURc/PhZ7lYOXSMtYMQieu62/cVbcED3dIudPVBGWXRvRuyX96qHM2UD
         uiUh1zrjwRr1x6KWLkOllTMjbN8uOUNn0kog/RqXDfJbEo/LIwr5X++/3VC8XoFyl3Md
         eB+SmeshcYq64a3u40vkT6mYPmgJyNCS4YlyYBO9Kl6Bph9NGVLvNPzbx+o76VYsimet
         4pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784773494; x=1785378294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZCnR4B/MekCn1lTTtDL2oBst2/7Abw1Lem8ZtySJ4Y=;
        b=XDNEVV9/ryJS5m5GZkJlsyNnn2ETYmk3vDxMo53jAq7j9xsk1Evfj1nTJL8C89mdyL
         6HZHHFWnZc/bR0Z2xx+md2k6e0D/HBl9Do8upXYRd8rO+YssrM4wRD1VgCcOITPlCSpZ
         IMQhH8Lzx+3AvnDJcOD2u8RLbO8SSdGc3jk2aWoCPt+XZBFWsiEGBLw9OqiEmD8KIi6f
         jA/99qZV9KpBNHRXoDmeuOJpLfBPNf4SsVB0WaOAfSwtm0u41Jh6pOaZuQvo1KaE1Jo1
         mVzEjJXsxEwufhqRvI3RwHn+m/LwrALalPLPgWwJ/QwHPEg+1AWhTD+q9V2ZtM6jsvnw
         bmWw==
X-Forwarded-Encrypted: i=1; AHgh+RqaS465C4UDxiam8/j5XpNS7HVp3r2DBRpvDvTjNzfk7oaI3BUgREb+EF1OwHKft+rt+bhmL3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOj7e4Tw9nl5RrzK+s1brJ+pLel2cJhuowK/4OcB9Qok/E7CzK
	tTcZ5ysWiLyYWRyrX6xCDpIsTZV1Bv6cZsX22K/no9/mJqzGUuSDl18f
X-Gm-Gg: AR+sD127lNYQQe6u/zYt/nTfKRche90G4QNsdoLlfc8ANT0jsor/qzDqGgWP8Auw0Ut
	F+Sxn6lDGL3KKCMfYoqsLiKyrgA94LLuT91SYisgQ5hb5J9HDn2IMC+vAnNjqTeF2LVsOWB6N+D
	67xGmHy5QqGeaGhvVNmsG/wPc/W5wm1aha5Q7wcu7MIrkAapQVIoOPWsD86bK06+zqC6qzXUf44
	X8DVkNQmphdONiVeka7CUqrJj+ZdnvatWpGzEbyDNtaV+tYquA/DhxmH1eKefnZxIC4UtswyrbD
	dq/5fZV1m9rSGzSU+piQUunz2YPu2VW7aukBFAgVq+OUqJ5WpUesQnQoEvUwjbAJNcWMn6NiRDc
	EfOmNPysYWwnr8BJuqNPyEhqLzL/Bab0OLT9YY52DUOOVRiinlnvG9MjYnafLPpzb57ckrHpzPG
	w7rV0vbuq4YZAeRIP0HJUTCKXyuAng0Gw8NVTIM5Gr0ApMub9LwNhSyzwcEPmMAVMxhw==
X-Received: by 2002:a17:902:c942:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2cfa6a5a196mr14944055ad.10.1784773493944;
        Wed, 22 Jul 2026 19:24:53 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa39e9sm23809715ad.10.2026.07.22.19.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:24:53 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Joe Damato <joe@dama.to>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] nfc: nci: Fix conn_info use-after-free
Date: Thu, 23 Jul 2026 11:24:07 +0900
Message-ID: <20260723022407.3402916-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_tx_work() looks up conn_info from conn_info_list and keeps using
that pointer while sending queued data. nci_core_conn_close_rsp_packet()
runs on the separate rx_wq and can remove and free the same conn_info,
so the tx worker can dereference freed memory.

The same lifetime rule also has to cover other conn_info_list users and
the direct rf_conn_info and hci_dev->conn_info aliases. Protect
conn_info_list and conn_info pointer aliases with a dedicated lock, use
it while publishing and removing entries, and keep readers under the lock
while they dereference conn_info or copy the fields they need.

In nci_tx_work(), take the lock only around lookup, credit checks, skb
dequeue, and credit accounting so close cannot free conn_info while it is
used, but transport send latency does not block rx_wq response
processing.

Fixes: 736bb9577407 ("NFC: nci: Support logical connections management")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v4:
  - Guard hci_dev before clearing its conn_info alias during teardown.
  - Reflow lines flagged by the netdev 80-column check.
  - Use the current NFC maintainer address from MAINTAINERS.
v3: https://lore.kernel.org/netdev/20260630071717.3618185-2-sanghyun.park.cnu@gmail.com/
  - Add Fixes tag for the logical connection close lifetime bug.
  - Add the missing NFC maintainer and oe-linux-nfc list.
  - Cover all conn_info_list helper users, not only nci_tx_work().
  - Protect direct rf_conn_info and hci_dev->conn_info aliases.
  - Publish and remove conn_info entries under the same lock.
  - Protect RF conn_info discovery publication with the same lock.
  - Keep HCI rx_skb immediate dereferences under conn_info_lock.
  - Narrow nci_send_data() lock coverage around skb queueing.
  - Avoid holding conn_info_lock across nci_send_frame().
  - Use spin_lock_bh() so HCI timer callbacks do not take a sleepable lock.
  - Keep conn_info_lock alive until nci_dev teardown instead of destroying it before nfc_remove_device().
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260610081657.686636-1-sanghyun.park.cnu@gmail.com/
  - Replace flush-only fix with conn_info locking around tx and close.
v1: https://patchwork.kernel.org/project/netdevbpf/patch/CAOrxSK5UmFFfzdRG+P89+E+Rvg_1DmOvTs+M7353Q8=hkPXmSg@mail.gmail.com/

 drivers/nfc/st-nci/se.c    |  16 +++---
 include/net/nfc/nci_core.h |   9 ++-
 net/nfc/nci/core.c         |  98 +++++++++++++++++++++++++--------
 net/nfc/nci/data.c         |  68 ++++++++++++++---------
 net/nfc/nci/hci.c          | 109 +++++++++++++++++++++++++++++--------
 net/nfc/nci/ntf.c          |  23 ++++++--
 net/nfc/nci/rsp.c          |  52 +++++++++++++-----
 7 files changed, 271 insertions(+), 104 deletions(-)

diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index 607ec768eb7b4..1f8e2265e20b0 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -548,6 +548,7 @@ static int st_nci_hci_network_init(struct nci_dev *ndev)
 	struct core_conn_create_dest_spec_params *dest_params;
 	struct dest_spec_params spec_params;
 	struct nci_conn_info    *conn_info;
+	u8 nfcee_id;
 	int r, dev_num;
 
 	dest_params =
@@ -569,9 +570,14 @@ static int st_nci_hci_network_init(struct nci_dev *ndev)
 	if (r != NCI_STATUS_OK)
 		goto free_dest_params;
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		goto free_dest_params;
+	}
+	nfcee_id = conn_info->dest_params->id;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	ndev->hci_dev->init_data.gate_count = ARRAY_SIZE(st_nci_gates);
 	memcpy(ndev->hci_dev->init_data.gates, st_nci_gates,
@@ -601,13 +607,9 @@ static int st_nci_hci_network_init(struct nci_dev *ndev)
 	 * HCI will be used here only for proprietary commands.
 	 */
 	if (test_bit(ST_NCI_FACTORY_MODE, &info->flags))
-		r = nci_nfcee_mode_set(ndev,
-				       ndev->hci_dev->conn_info->dest_params->id,
-				       NCI_NFCEE_DISABLE);
+		r = nci_nfcee_mode_set(ndev, nfcee_id, NCI_NFCEE_DISABLE);
 	else
-		r = nci_nfcee_mode_set(ndev,
-				       ndev->hci_dev->conn_info->dest_params->id,
-				       NCI_NFCEE_ENABLE);
+		r = nci_nfcee_mode_set(ndev, nfcee_id, NCI_NFCEE_ENABLE);
 
 free_dest_params:
 	kfree(dest_params);
diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e66e0..1dd961507f9d3 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -19,6 +19,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/skbuff.h>
+#include <linux/spinlock.h>
 #include <linux/tty.h>
 
 #include <net/nfc/nfc.h>
@@ -227,6 +228,8 @@ struct nci_dev {
 	struct sk_buff_head	tx_q;
 
 	struct mutex		req_lock;
+	/* Serializes conn_info_list and conn_info pointer alias updates. */
+	spinlock_t		conn_info_lock;
 	struct completion	req_completion;
 	__u32			req_status;
 	__u32			req_result;
@@ -382,8 +385,10 @@ void nci_clear_target_list(struct nci_dev *ndev);
 #define NCI_REQ_CANCELED	2
 
 void nci_req_complete(struct nci_dev *ndev, int result);
-struct nci_conn_info *nci_get_conn_info_by_conn_id(struct nci_dev *ndev,
-						   int conn_id);
+struct nci_conn_info *nci_get_conn_info_by_conn_id_locked(struct nci_dev *ndev,
+							  int conn_id);
+int nci_get_conn_info_by_dest_locked(struct nci_dev *ndev, u8 dest_type,
+				     const struct dest_spec_params *params);
 int nci_get_conn_info_by_dest_type_params(struct nci_dev *ndev, u8 dest_type,
 					  const struct dest_spec_params *params);
 
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b5720f6..57c144c5f31a4 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -40,8 +40,8 @@ static void nci_cmd_work(struct work_struct *work);
 static void nci_rx_work(struct work_struct *work);
 static void nci_tx_work(struct work_struct *work);
 
-struct nci_conn_info *nci_get_conn_info_by_conn_id(struct nci_dev *ndev,
-						   int conn_id)
+struct nci_conn_info *nci_get_conn_info_by_conn_id_locked(struct nci_dev *ndev,
+							  int conn_id)
 {
 	struct nci_conn_info *conn_info;
 
@@ -53,8 +53,8 @@ struct nci_conn_info *nci_get_conn_info_by_conn_id(struct nci_dev *ndev,
 	return NULL;
 }
 
-int nci_get_conn_info_by_dest_type_params(struct nci_dev *ndev, u8 dest_type,
-					  const struct dest_spec_params *params)
+int nci_get_conn_info_by_dest_locked(struct nci_dev *ndev, u8 dest_type,
+				     const struct dest_spec_params *params)
 {
 	const struct nci_conn_info *conn_info;
 
@@ -71,6 +71,18 @@ int nci_get_conn_info_by_dest_type_params(struct nci_dev *ndev, u8 dest_type,
 
 	return -EINVAL;
 }
+
+int nci_get_conn_info_by_dest_type_params(struct nci_dev *ndev, u8 dest_type,
+					  const struct dest_spec_params *params)
+{
+	int conn_id;
+
+	spin_lock_bh(&ndev->conn_info_lock);
+	conn_id = nci_get_conn_info_by_dest_locked(ndev, dest_type, params);
+	spin_unlock_bh(&ndev->conn_info_lock);
+
+	return conn_id;
+}
 EXPORT_SYMBOL(nci_get_conn_info_by_dest_type_params);
 
 /* ---- NCI requests ---- */
@@ -411,13 +423,17 @@ static void nci_nfcc_loopback_cb(void *context, struct sk_buff *skb, int err)
 	struct nci_dev *ndev = (struct nci_dev *)context;
 	struct nci_conn_info *conn_info;
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
+	spin_lock_bh(&ndev->conn_info_lock);
+	conn_info = nci_get_conn_info_by_conn_id_locked(ndev,
+							ndev->cur_conn_id);
 	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		nci_req_complete(ndev, NCI_STATUS_REJECTED);
 		return;
 	}
 
 	conn_info->rx_skb = skb;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	nci_req_complete(ndev, NCI_STATUS_OK);
 }
@@ -443,13 +459,17 @@ int nci_nfcc_loopback(struct nci_dev *ndev, const void *data, size_t data_len,
 					NULL);
 	}
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
-	if (!conn_info)
+	spin_lock_bh(&ndev->conn_info_lock);
+	conn_info = nci_get_conn_info_by_conn_id_locked(ndev, conn_id);
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return -EPROTO;
+	}
 
 	/* store cb and context to be used on receiving data */
 	conn_info->data_exchange_cb = nci_nfcc_loopback_cb;
 	conn_info->data_exchange_cb_context = ndev;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	skb = nci_skb_alloc(ndev, NCI_DATA_HDR_SIZE + data_len, GFP_KERNEL);
 	if (!skb)
@@ -464,8 +484,15 @@ int nci_nfcc_loopback(struct nci_dev *ndev, const void *data, size_t data_len,
 	ndev->cur_conn_id = conn_id;
 	r = nci_request(ndev, nci_send_data_req, &loopback_data,
 			msecs_to_jiffies(NCI_DATA_TIMEOUT));
-	if (r == NCI_STATUS_OK && resp)
-		*resp = conn_info->rx_skb;
+	if (r == NCI_STATUS_OK && resp) {
+		spin_lock_bh(&ndev->conn_info_lock);
+		conn_info = nci_get_conn_info_by_conn_id_locked(ndev, conn_id);
+		if (conn_info)
+			*resp = conn_info->rx_skb;
+		else
+			r = -EPROTO;
+		spin_unlock_bh(&ndev->conn_info_lock);
+	}
 
 	return r;
 }
@@ -1045,12 +1072,6 @@ static int nci_transceive(struct nfc_dev *nfc_dev, struct nfc_target *target,
 	int rc;
 	struct nci_conn_info *conn_info;
 
-	conn_info = ndev->rf_conn_info;
-	if (!conn_info) {
-		kfree_skb(skb);
-		return -EPROTO;
-	}
-
 	pr_debug("target_idx %d, len %d\n", target->idx, skb->len);
 
 	if (!ndev->target_active_prot) {
@@ -1064,9 +1085,19 @@ static int nci_transceive(struct nfc_dev *nfc_dev, struct nfc_target *target,
 		return -EBUSY;
 	}
 
+	spin_lock_bh(&ndev->conn_info_lock);
+	conn_info = ndev->rf_conn_info;
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
+		kfree_skb(skb);
+		clear_bit(NCI_DATA_EXCHANGE, &ndev->flags);
+		return -EPROTO;
+	}
+
 	/* store cb and context to be used on receiving data */
 	conn_info->data_exchange_cb = cb;
 	conn_info->data_exchange_cb_context = cb_context;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	rc = nci_send_data(ndev, NCI_STATIC_RF_CONN_ID, skb);
 	if (rc)
@@ -1288,6 +1319,7 @@ int nci_register_device(struct nci_dev *ndev)
 	timer_setup(&ndev->data_timer, nci_data_timer, 0);
 
 	mutex_init(&ndev->req_lock);
+	spin_lock_init(&ndev->conn_info_lock);
 	INIT_LIST_HEAD(&ndev->conn_info_list);
 
 	rc = nfc_register_device(ndev->nfc_dev);
@@ -1333,11 +1365,17 @@ void nci_unregister_device(struct nci_dev *ndev)
 	destroy_workqueue(ndev->rx_wq);
 	destroy_workqueue(ndev->tx_wq);
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	list_for_each_entry_safe(conn_info, n, &ndev->conn_info_list, list) {
 		list_del(&conn_info->list);
+		if (conn_info == ndev->rf_conn_info)
+			ndev->rf_conn_info = NULL;
+		if (ndev->hci_dev &&
+		    conn_info == ndev->hci_dev->conn_info)
+			ndev->hci_dev->conn_info = NULL;
 		/* conn_info is allocated with devm_kzalloc */
 	}
-
+	spin_unlock_bh(&ndev->conn_info_lock);
 	nfc_remove_device(ndev->nfc_dev);
 }
 EXPORT_SYMBOL(nci_unregister_device);
@@ -1523,23 +1561,32 @@ static void nci_tx_work(struct work_struct *work)
 	struct nci_conn_info *conn_info;
 	struct sk_buff *skb;
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
-	if (!conn_info)
-		return;
+	/* Send queued tx data */
+	for (;;) {
+		spin_lock_bh(&ndev->conn_info_lock);
+		conn_info =
+			nci_get_conn_info_by_conn_id_locked(ndev,
+							    ndev->cur_conn_id);
+		if (!conn_info)
+			goto unlock;
 
-	pr_debug("credits_cnt %d\n", atomic_read(&conn_info->credits_cnt));
+		pr_debug("credits_cnt %d\n",
+			 atomic_read(&conn_info->credits_cnt));
+
+		if (!atomic_read(&conn_info->credits_cnt))
+			goto unlock;
 
-	/* Send queued tx data */
-	while (atomic_read(&conn_info->credits_cnt)) {
 		skb = skb_dequeue(&ndev->tx_q);
 		if (!skb)
-			return;
-		kcov_remote_start_common(skb_get_kcov_handle(skb));
+			goto unlock;
 
 		/* Check if data flow control is used */
 		if (atomic_read(&conn_info->credits_cnt) !=
 		    NCI_DATA_FLOW_CONTROL_NOT_USED)
 			atomic_dec(&conn_info->credits_cnt);
+		spin_unlock_bh(&ndev->conn_info_lock);
+
+		kcov_remote_start_common(skb_get_kcov_handle(skb));
 
 		pr_debug("NCI TX: MT=data, PBF=%d, conn_id=%d, plen=%d\n",
 			 nci_pbf(skb->data),
@@ -1552,6 +1599,9 @@ static void nci_tx_work(struct work_struct *work)
 			  jiffies + msecs_to_jiffies(NCI_DATA_TIMEOUT));
 		kcov_remote_stop();
 	}
+
+unlock:
+	spin_unlock_bh(&ndev->conn_info_lock);
 }
 
 /* ----- NCI RX worker thread (data & control) ----- */
diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 5f98c73db5afd..334c0e5a94dbc 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -30,8 +30,10 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
 	data_exchange_cb_t cb;
 	void *cb_context;
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
+	spin_lock_bh(&ndev->conn_info_lock);
+	conn_info = nci_get_conn_info_by_conn_id_locked(ndev, conn_id);
 	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		kfree_skb(skb);
 		clear_bit(NCI_DATA_EXCHANGE, &ndev->flags);
 		return;
@@ -39,6 +41,7 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
 
 	cb = conn_info->data_exchange_cb;
 	cb_context = conn_info->data_exchange_cb_context;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	pr_debug("len %d, err %d\n", skb ? skb->len : 0, err);
 
@@ -85,19 +88,26 @@ static inline void nci_push_data_hdr(struct nci_dev *ndev,
 int nci_conn_max_data_pkt_payload_size(struct nci_dev *ndev, __u8 conn_id)
 {
 	const struct nci_conn_info *conn_info;
+	int max_pkt_payload_len;
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
-	if (!conn_info)
+	spin_lock_bh(&ndev->conn_info_lock);
+	conn_info = nci_get_conn_info_by_conn_id_locked(ndev, conn_id);
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return -EPROTO;
+	}
+	max_pkt_payload_len = conn_info->max_pkt_payload_len;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
-	return conn_info->max_pkt_payload_len;
+	return max_pkt_payload_len;
 }
 EXPORT_SYMBOL(nci_conn_max_data_pkt_payload_size);
 
 static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 				   __u8 conn_id,
-				   struct sk_buff *skb) {
-	const struct nci_conn_info *conn_info;
+				   struct sk_buff *skb,
+				   __u8 max_pkt_payload_len)
+{
 	int total_len = skb->len;
 	const unsigned char *data = skb->data;
 	unsigned long flags;
@@ -108,17 +118,10 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 
 	pr_debug("conn_id 0x%x, total_len %d\n", conn_id, total_len);
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
-	if (!conn_info) {
-		rc = -EPROTO;
-		goto exit;
-	}
-
 	__skb_queue_head_init(&frags_q);
 
 	while (total_len) {
-		frag_len =
-			min_t(int, total_len, conn_info->max_pkt_payload_len);
+		frag_len = min_t(int, total_len, max_pkt_payload_len);
 
 		skb_frag = nci_skb_alloc(ndev,
 					 (NCI_DATA_HDR_SIZE + frag_len),
@@ -171,40 +174,47 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 int nci_send_data(struct nci_dev *ndev, __u8 conn_id, struct sk_buff *skb)
 {
 	const struct nci_conn_info *conn_info;
+	__u8 max_pkt_payload_len;
 	int rc = 0;
 
 	pr_debug("conn_id 0x%x, plen %d\n", conn_id, skb->len);
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
+	spin_lock_bh(&ndev->conn_info_lock);
+	conn_info = nci_get_conn_info_by_conn_id_locked(ndev, conn_id);
 	if (!conn_info) {
 		rc = -EPROTO;
-		goto free_exit;
+		goto unlock;
 	}
+	max_pkt_payload_len = conn_info->max_pkt_payload_len;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	/* check if the packet need to be fragmented */
-	if (skb->len <= conn_info->max_pkt_payload_len) {
+	if (skb->len <= max_pkt_payload_len) {
 		/* no need to fragment packet */
 		nci_push_data_hdr(ndev, conn_id, skb, NCI_PBF_LAST);
 
 		skb_queue_tail(&ndev->tx_q, skb);
 	} else {
 		/* fragment packet and queue the fragments */
-		rc = nci_queue_tx_data_frags(ndev, conn_id, skb);
+		rc = nci_queue_tx_data_frags(ndev, conn_id, skb,
+					     max_pkt_payload_len);
 		if (rc) {
 			pr_err("failed to fragment tx data packet\n");
-			goto free_exit;
+			kfree_skb(skb);
+			return rc;
 		}
 	}
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	ndev->cur_conn_id = conn_id;
-	queue_work(ndev->tx_wq, &ndev->tx_work);
-
-	goto exit;
-
-free_exit:
-	kfree_skb(skb);
+	spin_unlock_bh(&ndev->conn_info_lock);
 
-exit:
+	queue_work(ndev->tx_wq, &ndev->tx_work);
+	return rc;
+unlock:
+	spin_unlock_bh(&ndev->conn_info_lock);
+	if (rc)
+		kfree_skb(skb);
 	return rc;
 }
 EXPORT_SYMBOL(nci_send_data);
@@ -282,11 +292,15 @@ void nci_rx_data_packet(struct nci_dev *ndev, struct sk_buff *skb)
 		 nci_conn_id(skb->data),
 		 nci_plen(skb->data));
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, nci_conn_id(skb->data));
+	spin_lock_bh(&ndev->conn_info_lock);
+	conn_info = nci_get_conn_info_by_conn_id_locked(ndev,
+							nci_conn_id(skb->data));
 	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		kfree_skb(skb);
 		return;
 	}
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	/* strip the nci data header */
 	skb_pull(skb, NCI_DATA_HDR_SIZE);
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index c03e8a0bd3bd6..e2f7ab15973ce 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -147,14 +147,22 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 	struct sk_buff *skb;
 	int len, i, r;
 	u8 cb = pipe;
+	u8 conn_id;
+	u8 max_pkt_payload_len;
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return -EPROTO;
+	}
+	conn_id = conn_info->conn_id;
+	max_pkt_payload_len = conn_info->max_pkt_payload_len;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	i = 0;
-	skb = nci_skb_alloc(ndev, conn_info->max_pkt_payload_len +
-			    NCI_DATA_HDR_SIZE, GFP_ATOMIC);
+	skb = nci_skb_alloc(ndev, max_pkt_payload_len + NCI_DATA_HDR_SIZE,
+			    GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
 
@@ -163,12 +171,11 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 
 	do {
 		/* If last packet add NCI_HFP_NO_CHAINING */
-		if (i + conn_info->max_pkt_payload_len -
-		    (skb->len + 1) >= data_len) {
+		if (i + max_pkt_payload_len - (skb->len + 1) >= data_len) {
 			cb |= NCI_HFP_NO_CHAINING;
 			len = data_len - i;
 		} else {
-			len = conn_info->max_pkt_payload_len - skb->len - 1;
+			len = max_pkt_payload_len - skb->len - 1;
 		}
 
 		*(u8 *)skb_push(skb, 1) = cb;
@@ -176,15 +183,14 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 		if (len > 0)
 			skb_put_data(skb, data + i, len);
 
-		r = nci_send_data(ndev, conn_info->conn_id, skb);
+		r = nci_send_data(ndev, conn_id, skb);
 		if (r < 0)
 			return r;
 
 		i += len;
 
 		if (i < data_len) {
-			skb = nci_skb_alloc(ndev,
-					    conn_info->max_pkt_payload_len +
+			skb = nci_skb_alloc(ndev, max_pkt_payload_len +
 					    NCI_DATA_HDR_SIZE, GFP_ATOMIC);
 			if (!skb)
 				return -ENOMEM;
@@ -225,17 +231,22 @@ int nci_hci_send_cmd(struct nci_dev *ndev, u8 gate, u8 cmd,
 	const struct nci_hcp_message *message;
 	const struct nci_conn_info *conn_info;
 	struct nci_data data;
+	struct sk_buff *rx_skb;
 	int r;
 	u8 pipe = ndev->hci_dev->gate2pipe[gate];
 
 	if (pipe == NCI_HCI_INVALID_PIPE)
 		return -EADDRNOTAVAIL;
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return -EPROTO;
+	}
 
 	data.conn_id = conn_info->conn_id;
+	spin_unlock_bh(&ndev->conn_info_lock);
 	data.pipe = pipe;
 	data.cmd = NCI_HCP_HEADER(NCI_HCI_HCP_COMMAND, cmd);
 	data.data = param;
@@ -244,13 +255,22 @@ int nci_hci_send_cmd(struct nci_dev *ndev, u8 gate, u8 cmd,
 	r = nci_request(ndev, nci_hci_send_data_req, &data,
 			msecs_to_jiffies(NCI_DATA_TIMEOUT));
 	if (r == NCI_STATUS_OK) {
-		message = (struct nci_hcp_message *)conn_info->rx_skb->data;
+		spin_lock_bh(&ndev->conn_info_lock);
+		conn_info = ndev->hci_dev->conn_info;
+		rx_skb = conn_info ? conn_info->rx_skb : NULL;
+		if (!rx_skb) {
+			spin_unlock_bh(&ndev->conn_info_lock);
+			return -EPROTO;
+		}
+
+		message = (struct nci_hcp_message *)rx_skb->data;
 		r = nci_hci_result_to_errno(
 			NCI_HCP_MSG_GET_CMD(message->header));
-		skb_pull(conn_info->rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
+		skb_pull(rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
+		spin_unlock_bh(&ndev->conn_info_lock);
 
 		if (!r && skb)
-			*skb = conn_info->rx_skb;
+			*skb = rx_skb;
 	}
 
 	return r;
@@ -366,11 +386,15 @@ static void nci_hci_resp_received(struct nci_dev *ndev, u8 pipe,
 {
 	struct nci_conn_info *conn_info;
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		goto exit;
+	}
 
 	conn_info->rx_skb = skb;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 exit:
 	nci_req_complete(ndev, NCI_STATUS_OK);
@@ -510,11 +534,15 @@ int nci_hci_open_pipe(struct nci_dev *ndev, u8 pipe)
 	struct nci_data data;
 	const struct nci_conn_info *conn_info;
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return -EPROTO;
+	}
 
 	data.conn_id = conn_info->conn_id;
+	spin_unlock_bh(&ndev->conn_info_lock);
 	data.pipe = pipe;
 	data.cmd = NCI_HCP_HEADER(NCI_HCI_HCP_COMMAND,
 				       NCI_HCI_ANY_OPEN_PIPE);
@@ -569,6 +597,7 @@ int nci_hci_set_param(struct nci_dev *ndev, u8 gate, u8 idx,
 	const struct nci_hcp_message *message;
 	const struct nci_conn_info *conn_info;
 	struct nci_data data;
+	struct sk_buff *rx_skb;
 	int r;
 	u8 *tmp;
 	u8 pipe = ndev->hci_dev->gate2pipe[gate];
@@ -578,9 +607,14 @@ int nci_hci_set_param(struct nci_dev *ndev, u8 gate, u8 idx,
 	if (pipe == NCI_HCI_INVALID_PIPE)
 		return -EADDRNOTAVAIL;
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return -EPROTO;
+	}
+	data.conn_id = conn_info->conn_id;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	tmp = kmalloc(1 + param_len, GFP_KERNEL);
 	if (!tmp)
@@ -589,7 +623,6 @@ int nci_hci_set_param(struct nci_dev *ndev, u8 gate, u8 idx,
 	*tmp = idx;
 	memcpy(tmp + 1, param, param_len);
 
-	data.conn_id = conn_info->conn_id;
 	data.pipe = pipe;
 	data.cmd = NCI_HCP_HEADER(NCI_HCI_HCP_COMMAND,
 				       NCI_HCI_ANY_SET_PARAMETER);
@@ -599,10 +632,20 @@ int nci_hci_set_param(struct nci_dev *ndev, u8 gate, u8 idx,
 	r = nci_request(ndev, nci_hci_send_data_req, &data,
 			msecs_to_jiffies(NCI_DATA_TIMEOUT));
 	if (r == NCI_STATUS_OK) {
-		message = (struct nci_hcp_message *)conn_info->rx_skb->data;
+		spin_lock_bh(&ndev->conn_info_lock);
+		conn_info = ndev->hci_dev->conn_info;
+		rx_skb = conn_info ? conn_info->rx_skb : NULL;
+		if (!rx_skb) {
+			spin_unlock_bh(&ndev->conn_info_lock);
+			kfree(tmp);
+			return -EPROTO;
+		}
+
+		message = (struct nci_hcp_message *)rx_skb->data;
 		r = nci_hci_result_to_errno(
 			NCI_HCP_MSG_GET_CMD(message->header));
-		skb_pull(conn_info->rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
+		skb_pull(rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
+		spin_unlock_bh(&ndev->conn_info_lock);
 	}
 
 	kfree(tmp);
@@ -616,6 +659,7 @@ int nci_hci_get_param(struct nci_dev *ndev, u8 gate, u8 idx,
 	const struct nci_hcp_message *message;
 	const struct nci_conn_info *conn_info;
 	struct nci_data data;
+	struct sk_buff *rx_skb;
 	int r;
 	u8 pipe = ndev->hci_dev->gate2pipe[gate];
 
@@ -624,11 +668,15 @@ int nci_hci_get_param(struct nci_dev *ndev, u8 gate, u8 idx,
 	if (pipe == NCI_HCI_INVALID_PIPE)
 		return -EADDRNOTAVAIL;
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return -EPROTO;
+	}
 
 	data.conn_id = conn_info->conn_id;
+	spin_unlock_bh(&ndev->conn_info_lock);
 	data.pipe = pipe;
 	data.cmd = NCI_HCP_HEADER(NCI_HCI_HCP_COMMAND,
 				  NCI_HCI_ANY_GET_PARAMETER);
@@ -639,13 +687,22 @@ int nci_hci_get_param(struct nci_dev *ndev, u8 gate, u8 idx,
 			msecs_to_jiffies(NCI_DATA_TIMEOUT));
 
 	if (r == NCI_STATUS_OK) {
-		message = (struct nci_hcp_message *)conn_info->rx_skb->data;
+		spin_lock_bh(&ndev->conn_info_lock);
+		conn_info = ndev->hci_dev->conn_info;
+		rx_skb = conn_info ? conn_info->rx_skb : NULL;
+		if (!rx_skb) {
+			spin_unlock_bh(&ndev->conn_info_lock);
+			return -EPROTO;
+		}
+
+		message = (struct nci_hcp_message *)rx_skb->data;
 		r = nci_hci_result_to_errno(
 			NCI_HCP_MSG_GET_CMD(message->header));
-		skb_pull(conn_info->rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
+		skb_pull(rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
+		spin_unlock_bh(&ndev->conn_info_lock);
 
 		if (!r && skb)
-			*skb = conn_info->rx_skb;
+			*skb = rx_skb;
 	}
 
 	return r;
@@ -729,12 +786,16 @@ int nci_hci_dev_session_init(struct nci_dev *ndev)
 	ndev->hci_dev->count_pipes = 0;
 	ndev->hci_dev->expected_pipes = 0;
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->hci_dev->conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return -EPROTO;
+	}
 
 	conn_info->data_exchange_cb = nci_hci_data_received_cb;
 	conn_info->data_exchange_cb_context = ndev;
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	nci_hci_reset_pipes(ndev->hci_dev);
 
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb86531..15a95ee3658c0 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -56,6 +56,7 @@ static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 {
 	struct nci_core_conn_credit_ntf *ntf;
 	struct nci_conn_info *conn_info;
+	int conn_id;
 	int i;
 
 	if (skb->len < offsetofend(struct nci_core_conn_credit_ntf, num_entries))
@@ -81,13 +82,17 @@ static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 			 i, ntf->conn_entries[i].conn_id,
 			 ntf->conn_entries[i].credits);
 
-		conn_info = nci_get_conn_info_by_conn_id(ndev,
-							 ntf->conn_entries[i].conn_id);
-		if (!conn_info)
+		spin_lock_bh(&ndev->conn_info_lock);
+		conn_id = ntf->conn_entries[i].conn_id;
+		conn_info = nci_get_conn_info_by_conn_id_locked(ndev, conn_id);
+		if (!conn_info) {
+			spin_unlock_bh(&ndev->conn_info_lock);
 			return 0;
+		}
 
 		atomic_add(ntf->conn_entries[i].credits,
 			   &conn_info->credits_cnt);
+		spin_unlock_bh(&ndev->conn_info_lock);
 	}
 
 	/* trigger the next tx */
@@ -828,9 +833,12 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 
 exit:
 	if (err == NCI_STATUS_OK) {
+		spin_lock_bh(&ndev->conn_info_lock);
 		conn_info = ndev->rf_conn_info;
-		if (!conn_info)
+		if (!conn_info) {
+			spin_unlock_bh(&ndev->conn_info_lock);
 			return 0;
+		}
 
 		conn_info->max_pkt_payload_len = ntf.max_data_pkt_payload_size;
 		conn_info->initial_num_credits = ntf.initial_num_credits;
@@ -838,6 +846,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		/* set the available credits to initial value */
 		atomic_set(&conn_info->credits_cnt,
 			   conn_info->initial_num_credits);
+		spin_unlock_bh(&ndev->conn_info_lock);
 
 		/* store general bytes to be reported later in dep_link_up */
 		if (ntf.rf_interface == NCI_RF_INTERFACE_NFC_DEP) {
@@ -901,9 +910,13 @@ static int nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
 
 	pr_debug("entry, type 0x%x, reason 0x%x\n", ntf->type, ntf->reason);
 
+	spin_lock_bh(&ndev->conn_info_lock);
 	conn_info = ndev->rf_conn_info;
-	if (!conn_info)
+	if (!conn_info) {
+		spin_unlock_bh(&ndev->conn_info_lock);
 		return 0;
+	}
+	spin_unlock_bh(&ndev->conn_info_lock);
 
 	/* drop tx data queue */
 	skb_queue_purge(&ndev->tx_q);
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5f..f54bd2283af2e 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -186,6 +186,7 @@ static void nci_rf_disc_rsp_packet(struct nci_dev *ndev,
 				   const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
+	struct nci_conn_info *new_conn_info;
 	__u8 status = skb->data[0];
 
 	pr_debug("status 0x%x\n", status);
@@ -193,19 +194,33 @@ static void nci_rf_disc_rsp_packet(struct nci_dev *ndev,
 	if (status == NCI_STATUS_OK) {
 		atomic_set(&ndev->state, NCI_DISCOVERY);
 
+		spin_lock_bh(&ndev->conn_info_lock);
 		conn_info = ndev->rf_conn_info;
+		spin_unlock_bh(&ndev->conn_info_lock);
+
 		if (!conn_info) {
-			conn_info = devm_kzalloc(&ndev->nfc_dev->dev,
-						 sizeof(struct nci_conn_info),
-						 GFP_KERNEL);
-			if (!conn_info) {
+			new_conn_info = devm_kzalloc(&ndev->nfc_dev->dev,
+						     sizeof(*new_conn_info),
+						     GFP_KERNEL);
+			if (!new_conn_info) {
 				status = NCI_STATUS_REJECTED;
 				goto exit;
 			}
-			conn_info->conn_id = NCI_STATIC_RF_CONN_ID;
-			INIT_LIST_HEAD(&conn_info->list);
-			list_add(&conn_info->list, &ndev->conn_info_list);
-			ndev->rf_conn_info = conn_info;
+
+			new_conn_info->conn_id = NCI_STATIC_RF_CONN_ID;
+			INIT_LIST_HEAD(&new_conn_info->list);
+
+			spin_lock_bh(&ndev->conn_info_lock);
+			if (!ndev->rf_conn_info) {
+				list_add(&new_conn_info->list,
+					 &ndev->conn_info_list);
+				ndev->rf_conn_info = new_conn_info;
+				new_conn_info = NULL;
+			}
+			spin_unlock_bh(&ndev->conn_info_lock);
+
+			if (new_conn_info)
+				devm_kfree(&ndev->nfc_dev->dev, new_conn_info);
 		}
 	}
 
@@ -298,20 +313,20 @@ static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 		conn_info->dest_params->id = ndev->cur_params.id;
 		conn_info->dest_params->protocol = ndev->cur_params.protocol;
 		conn_info->conn_id = rsp->conn_id;
+		conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
+		atomic_set(&conn_info->credits_cnt, rsp->credits_cnt);
 
 		/* Note: data_exchange_cb and data_exchange_cb_context need to
 		 * be specify out of nci_core_conn_create_rsp_packet
 		 */
 
 		INIT_LIST_HEAD(&conn_info->list);
+		spin_lock_bh(&ndev->conn_info_lock);
 		list_add(&conn_info->list, &ndev->conn_info_list);
 
 		if (ndev->cur_params.id == ndev->hci_dev->nfcee_id)
 			ndev->hci_dev->conn_info = conn_info;
-
-		conn_info->conn_id = rsp->conn_id;
-		conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
-		atomic_set(&conn_info->credits_cnt, rsp->credits_cnt);
+		spin_unlock_bh(&ndev->conn_info_lock);
 	}
 
 free_conn_info:
@@ -330,14 +345,21 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 
 	pr_debug("status 0x%x\n", status);
 	if (status == NCI_STATUS_OK) {
-		conn_info = nci_get_conn_info_by_conn_id(ndev,
-							 ndev->cur_conn_id);
+		spin_lock_bh(&ndev->conn_info_lock);
+		conn_info =
+			nci_get_conn_info_by_conn_id_locked(ndev,
+							    ndev->cur_conn_id);
 		if (conn_info) {
 			list_del(&conn_info->list);
 			if (conn_info == ndev->rf_conn_info)
 				ndev->rf_conn_info = NULL;
-			devm_kfree(&ndev->nfc_dev->dev, conn_info);
+			if (ndev->hci_dev &&
+			    conn_info == ndev->hci_dev->conn_info)
+				ndev->hci_dev->conn_info = NULL;
 		}
+		spin_unlock_bh(&ndev->conn_info_lock);
+		if (conn_info)
+			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 	}
 	nci_req_complete(ndev, status);
 }
