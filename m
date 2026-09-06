Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C3364942
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709424; cv=none; b=ICSdBvRoXQsTalklP731FPKHFiqpPwG6ljGGBnMJXCzNqasdQK/eN1ZKNwclpQwHCovNnbrICSMT5o1XyPN9nKQdBRLYmnQ/JURXSW3nu8zJX+kmTrQ6kMVFZJW4xbBttoAKeEIsVhKiGZD6aGLagA/Og6MOxvzXm5TyEdyOQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709424; c=relaxed/simple;
	bh=VIhohHcx0SkBUGBuyu+li/MstEWPK62/31/grkhVZe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+QYeqDedkwqiSV2lexMhrvQ0khi18OaBC0RjDL1cWRU81zGPLvLC45p9yKyaUcg5sgjdPxHys6ME1Yg86Q+yC7cRU/IdyVKHzp2AcKqPXSD1+Bvm3kKxtz/mjOdGCbN7DGvdh/8j2y2E9o56lL+nYbL6KLR6GnhK8OclIUDyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaYhfvml; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaYhfvml"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso3396626a91.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788709422; x=1789314222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQ5Zk4J+hLvsdimx8KJiE0DP9iSw9BVVCAqpnMEf3Qc=;
        b=PaYhfvmlLeHSSClcoPMnp4n2CwH3QSRCr8aNivW8WklY3lzlSOr48pqbI4fUjA0wyK
         v1boSs51UZiwdelXM2MbQLfwVbBVvNWSuUtI5UQf0FfmBq1BvY6WJ/NYgZtfl4ZpDrHQ
         gAil7ti9kaAfnnWUSkcI5ZtkpISohQwm4Egijkb6DgwAG+45cLMMxuOkiyPJszKyXimB
         sERG9cCvM5X8YrRRE27gdD+6I81CiU6lAWTA19Kjycy1l1zyOkKmD16Ku3jjsgRxG5NZ
         vidoAT0ZWEMF63qXK3WpZ5YeGmDfnqv30NYcLBcGc4OOp9I1kFGoKRMf7G+RlXnqppXy
         9zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788709422; x=1789314222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQ5Zk4J+hLvsdimx8KJiE0DP9iSw9BVVCAqpnMEf3Qc=;
        b=TtmEFBDRVZvBkie+qUWGy4uSUd/xuWMfakgctTbxaJ8hMBOun9f6mRtjJunWR1flcD
         qpZ5RUY5XAoi0TosbGObmBQqrIK6IuL3z1C0/9zbWB3qAm6y1onILqcvc3+p+MsQiPcK
         /yQoKsDmZR/jAaJnb0tlm8kFzgro2jiV5F3iVWWiNXhFUOuv0PhFtm4Gg1aACrxhr2iM
         vGtsByK2bMWn8WxCeipjuYTtEfo9GiCNBncNH9VnSZIx5a6/d/HDGvefByyCaWY6u7Nx
         u1jbOB6XVIeNhBETKWVzTu7ErS0eqOAcw5Dt016Jg/YxvTaZi/1CaPEdnnxorxstGJo9
         h7KA==
X-Forwarded-Encrypted: i=1; AKwUvByLPtOwVWREA7cgImN4a18LAOPbMeWERs9yb+xFqWCxDpCCWiESJX2t7IeOMLY/Z/2LanbdfGA=@vger.kernel.org
X-Gm-Message-State: AFuF++kSRxNMg/II3sTly6gOmvPlmtKkqk9/JT6ceAQH7gXTOTbH0sdI
	cv/hUVjqRuJEJuyv159lUwrB+vg2aEvH0fCjAQKAS7pU4R+SzoQ4w0s1
X-Gm-Gg: AYBFou2j3wq0iWkyFtHjWMPbZq1//17uv7xkje1Nufw+Rd9Fdgzqtpw8mujnhGqsCuE
	kiOAzTBdb2fvF2qtxh7x1oGgohOsvJCezq2/8EXp7FoimBVNQE+vweXRB8F2hB4kZe3kZ6GJ9uR
	r9X57BTmTp1erKSWiuhOoBrhUUOhUeV4hbe+cCkvZ9qAAxulQN33TSpwULJi4ZoN7LJVQp1Oi/V
	LkwOLdtnIfKJQ6qgcMuoKQKwzQZMdeI3UVl3+ADZPbQ9JgZ0P0FHQ4jY8a+1iw6H+iSMvfABKi3
	raIDD2hwHORCVKPZRn1FGBqAmWCxf8kRgWWbuwlX5uyObSe63T7Y2bDe1VTUN8Y+Ga39cQ+C1ax
	Py6A+Mvereq7yCTQN4AGKFJjb/TG0rhVPs/X4gd77wn2oZv1Jnmxw7mcsj3QtKaKzNOeojOGXn+
	YMsESIs31HULCNWFayRL7LBsRNWOtq6Zq8Y5YcN9kG0BFKBMgiRyRnR8Qi9x6jRe6AhKT3s0dbX
	XJ1d5zp5O5NqEjgdFh2eLQz/P5mG+8Dvvird8pHfr8G
X-Received: by 2002:a17:90b:17c2:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-39b25f1c5bdmr25690589a91.0.1788709422195;
        Sun, 06 Sep 2026 08:43:42 -0700 (PDT)
Received: from localhost.localdomain ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm18930617eec.6.2026.09.06.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:43:41 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Manish Mandlik <mmandlik@google.com>,
	syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com,
	Aby Sam Ross <abysamross@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v3 bluetooth] Bluetooth: coredump: Quiesce dump work on unregister
Date: Sun,  6 Sep 2026 23:43:32 +0800
Message-ID: <20260906154332.763402-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_devcd_handle_pkt_init() arms dump_timeout and coredump producers
queue dump_rx without holding an hdev reference. Unregister leaves both
works live, so disconnecting during an active dump lets them access hdev
after hci_release_dev() frees it.

Shut down coredump processing during unregister. Close the producer gate
under dump_q.lock before disabling both works, then free the active buffer
and queued packets under hci_dev_lock. Serializing the gate with enqueue
prevents controller-specific workers from adding packets after the final
purge.

Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
Reported-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
Reported-by: Aby Sam Ross <abysamross@gmail.com>
Link: https://lore.kernel.org/r/20260322210849.68743-1-abysamross@gmail.com
Suggested-by: Aby Sam Ross <abysamross@gmail.com>
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Link: https://lore.kernel.org/r/20260814231248.3096377-1-tristmd@gmail.com
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: OpenAI Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v3:
- Serialize coredump enqueue with the terminal shutdown gate.
- Reject and free packets submitted after shutdown begins.
- Disable dump_rx and dump_timeout, then free the buffered dump state.
- Add links and credits for the two earlier attempts.

 include/net/bluetooth/coredump.h |  2 +
 net/bluetooth/coredump.c         | 65 +++++++++++++++++++++-----------
 net/bluetooth/hci_core.c         |  1 +
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index 1f071ab554163..acc1849f66c0f 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -70,6 +70,7 @@ struct hci_devcoredump {
 const char *hci_devcd_state_name(enum devcoredump_state state);
 
 void hci_devcd_reset(struct hci_dev *hdev);
+void hci_devcd_shutdown(struct hci_dev *hdev);
 void hci_devcd_rx(struct work_struct *work);
 void hci_devcd_timeout(struct work_struct *work);
 
@@ -89,6 +90,7 @@ static inline const char *hci_devcd_state_name(enum devcoredump_state state)
 }
 
 static inline void hci_devcd_reset(struct hci_dev *hdev) {}
+static inline void hci_devcd_shutdown(struct hci_dev *hdev) {}
 static inline void hci_devcd_rx(struct work_struct *work) {}
 static inline void hci_devcd_timeout(struct work_struct *work) {}
 
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 5bee863bd6d2c..71fc8dab40047 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -104,6 +104,22 @@ static void hci_devcd_free(struct hci_dev *hdev)
 	hci_devcd_reset(hdev);
 }
 
+void hci_devcd_shutdown(struct hci_dev *hdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hdev->dump.dump_q.lock, flags);
+	hdev->dump.supported = false;
+	spin_unlock_irqrestore(&hdev->dump.dump_q.lock, flags);
+
+	disable_work_sync(&hdev->dump.dump_rx);
+	disable_delayed_work_sync(&hdev->dump.dump_timeout);
+
+	hci_dev_lock(hdev);
+	hci_devcd_free(hdev);
+	hci_dev_unlock(hdev);
+}
+
 /* Call with hci_dev_lock only. */
 static int hci_devcd_alloc(struct hci_dev *hdev, u32 size)
 {
@@ -442,7 +458,29 @@ EXPORT_SYMBOL(hci_devcd_register);
 
 static inline bool hci_devcd_enabled(struct hci_dev *hdev)
 {
-	return hdev->dump.supported;
+	return READ_ONCE(hdev->dump.supported);
+}
+
+static int hci_devcd_queue(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&hdev->dump.dump_q.lock, flags);
+	if (!hdev->dump.supported)
+		err = -EOPNOTSUPP;
+	else
+		__skb_queue_tail(&hdev->dump.dump_q, skb);
+	spin_unlock_irqrestore(&hdev->dump.dump_q.lock, flags);
+
+	if (err) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	queue_work(hdev->workqueue, &hdev->dump.dump_rx);
+
+	return 0;
 }
 
 int hci_devcd_init(struct hci_dev *hdev, u32 dump_size)
@@ -459,10 +497,7 @@ int hci_devcd_init(struct hci_dev *hdev, u32 dump_size)
 	hci_dmp_cb(skb)->pkt_type = HCI_DEVCOREDUMP_PKT_INIT;
 	put_unaligned_le32(dump_size, skb_put(skb, 4));
 
-	skb_queue_tail(&hdev->dump.dump_q, skb);
-	queue_work(hdev->workqueue, &hdev->dump.dump_rx);
-
-	return 0;
+	return hci_devcd_queue(hdev, skb);
 }
 EXPORT_SYMBOL(hci_devcd_init);
 
@@ -478,10 +513,7 @@ int hci_devcd_append(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dmp_cb(skb)->pkt_type = HCI_DEVCOREDUMP_PKT_SKB;
 
-	skb_queue_tail(&hdev->dump.dump_q, skb);
-	queue_work(hdev->workqueue, &hdev->dump.dump_rx);
-
-	return 0;
+	return hci_devcd_queue(hdev, skb);
 }
 EXPORT_SYMBOL(hci_devcd_append);
 
@@ -503,10 +535,7 @@ int hci_devcd_append_pattern(struct hci_dev *hdev, u8 pattern, u32 len)
 	hci_dmp_cb(skb)->pkt_type = HCI_DEVCOREDUMP_PKT_PATTERN;
 	skb_put_data(skb, &p, sizeof(p));
 
-	skb_queue_tail(&hdev->dump.dump_q, skb);
-	queue_work(hdev->workqueue, &hdev->dump.dump_rx);
-
-	return 0;
+	return hci_devcd_queue(hdev, skb);
 }
 EXPORT_SYMBOL(hci_devcd_append_pattern);
 
@@ -523,10 +552,7 @@ int hci_devcd_complete(struct hci_dev *hdev)
 
 	hci_dmp_cb(skb)->pkt_type = HCI_DEVCOREDUMP_PKT_COMPLETE;
 
-	skb_queue_tail(&hdev->dump.dump_q, skb);
-	queue_work(hdev->workqueue, &hdev->dump.dump_rx);
-
-	return 0;
+	return hci_devcd_queue(hdev, skb);
 }
 EXPORT_SYMBOL(hci_devcd_complete);
 
@@ -543,10 +569,7 @@ int hci_devcd_abort(struct hci_dev *hdev)
 
 	hci_dmp_cb(skb)->pkt_type = HCI_DEVCOREDUMP_PKT_ABORT;
 
-	skb_queue_tail(&hdev->dump.dump_q, skb);
-	queue_work(hdev->workqueue, &hdev->dump.dump_rx);
-
-	return 0;
+	return hci_devcd_queue(hdev, skb);
 }
 EXPORT_SYMBOL(hci_devcd_abort);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d7355c73f93e8..a3338bc8a4ed7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2673,6 +2673,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->error_reset);
 	disable_delayed_work_sync(&hdev->cmd_timer);
 	disable_delayed_work_sync(&hdev->ncmd_timer);
+	hci_devcd_shutdown(hdev);
 
 	hci_cmd_sync_clear(hdev);
 

base-commit: 2deb76c21b81e42b3282224f7dd2046fe73fd1e0
-- 
2.55.0
