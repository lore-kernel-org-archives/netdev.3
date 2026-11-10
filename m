Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794280977;
	b=D89uadO2EvSCPHrdLOoa0mhydQujLGqEQwY2GNTCBNUdtnJyqW1oWYbK6hQQBnjtzoN4
	 1AaPYX1yL49k6qHZLi4Npp6fVyUs1xXIt96nrZ67bqFc5pF0Kq5eZvLnRAGQqHbiD7g/s
	 2HV96JuisISdwB5/nYXk0zPAAB4Py8BcvbUDNSqA0IDx5gwjDHjBGO4P55PHjca2RMfdv
	 dlclQ9Lq5X8PxSKIOEBoITew6vKzKdgbO7oKG/2mD40mpvmKVqNJzr7HZSIomd4BNqI08
	 xlKOMTN+P0DE6LLPHqXaYrTFO/GtTCD/aBWtQ8Kd1Ny+MxJq5mAEsVWHdZG8tnvbg2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280977;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m9PH1i4gxQ9eo4KcB9BxgLT0AM3ayjQ+vb47xjI8eTY=;
	b=rstY3OmmCcJeuNOM4ewTS06cFKOgxAEzZQU9g/GFpgPW1uFNxjTlnmzMdhWU61egD6WS
	 tRS/rrU/mKg/pX+5nx9sHWt75rkPK+6Y5QB0dCQwSGCh5/5gqS8TnIAOPM6lei/PAuKme
	 tx+GVhLdpWITWPm+WJl4p0c9vbiudEviqQit0NgcdijgPL4mgBTHbtQQ5NZRWbjpCFyQV
	 zcAd5wXoXItQiqlPMrdzFGMrkVPxX7CDqcfEqnwUelHlot/j0NF38TfNCyR460Nofnd2T
	 26iFpCJdZZwXkFUuR/yAeVbPXbuLA14n0HWsdy5mfgOs+N0noQMJf6h62CUb3BO9njw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7ieyewB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759060A2615;
	Tue, 10 Nov 2026 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7ieyewB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794280976;
	b=iPWZQyCpRgSeyZ1EWqmDutG+d8SwjTd8CtyuW2Ii7FspueZOgt7uw2O/ikgTr2lvovXX
	 wJJCAHo+T5Z2tL8iru5qJHWanS5bRpKdGAkq9tWLoRmHbptNNJK1gDBH+HgBSLB0qitRE
	 +ijVybrHN5r5mR1jmwy0xYCa/F+bg6pgnFO0tUcQvaA+fs+9ki3zXLQjOx7LETkhu9kfP
	 GTW43Cw6z7pXfuN+SszbMNeqszQxYUVvCXVJm6FYJS+IjWcX9dELhGaHLD+CcI9G0zwHu
	 hF34c0+LqwMH0gbNoAuKpQPMronM7xTchxy9qMRJ4TiDGMUibvchd9hFtQ6PP7vJb3w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794280976;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m9PH1i4gxQ9eo4KcB9BxgLT0AM3ayjQ+vb47xjI8eTY=;
	b=Uz8fUWDzh/0tdjF9hL+MXU+ZfgMl5vX6Ln3q469ZiV+GMwNNZ79rGT0apgo7gAO5KxW+
	 KsrOZSVg6+7J9I9j1w46wUn2RsqvMFRq/w7XxgnLvIAW8NveaiNq+2mJ2L4yM5jpqW5rJ
	 h7bpBD9REdjWo+Nbf0N3bVDk9YD6GZ1eHbw7qaxd/aqSB2gb5COL2zIygz8Qd1Vrl3H2s
	 elhz48RUvqLjo7HdtYMKKvhY/4IXDLyNOOVrrlRzlNtumgPZQTXAIgK4Itd+zMYNV1BAl
	 MMRhlUD2PsZQgFWRpBRh0rrbgU4rpKa+5hOwxhft0acxqzVlm9zSJap+ljhRkupSEDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5AF891F008BE;
	Tue, 10 Nov 2026 03:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280976;
	bh=m9PH1i4gxQ9eo4KcB9BxgLT0AM3ayjQ+vb47xjI8eTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=l7ieyewBiChiSedzf3sYdMWAYGX1umPBjn1k8JtTjeuRDiYit7z4jdBAwp/KVBGrp
	 CP8ivXvInDFGdXAtCJBI770GyGIC1Q5CW4HrTmWdbDZAmOdJmwyZmlKUDOFJEQBGp1
	 qPgxiADhZuUr5GY4susD9nOp5Yo5csggIJWdphXfZbXllhy9hxO4b+j5QZgnRV/kSx
	 ta7nNxGpEfEgyvs+b75cmxWFqSXeQO1Rv7ZOjrk7fcy+yY1fgkk6VlCe7W9DOjODZR
	 gBIN+IJxDQwLCqtnNoAFzAMH5gZYJEY9w7XCriKps3UCR2S2ztmloRlLVWFHQ8lTTW
	 0Gyq0tyUn9wpg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D44E6487A6;
	Tue, 10 Nov 2026 03:22:54 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:22:55 +0000
Subject: [PATCH RESEND v2 1/2] nfc: st21nfca: add spinlock to serialize SE
 APDU request state
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-st21nfca-v2-v2-1-cf9102b314cb@gmail.com>
References: <20261110-st21nfca-v2-v2-0-cf9102b314cb@gmail.com>
In-Reply-To: <20261110-st21nfca-v2-v2-0-cf9102b314cb@gmail.com>
To: joasantonio108@gmail.com, david@ixit.cz, krzk@kernel.org
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, horms@kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794280974; l=4914;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=ySTOHlr1/hkeoLYuHUkCy4vhtVB1vXmf0ml4VRRLgTY=;
 b=m6yqmwUnZBBpH8i7JLb5RG0iGIhprXBmZLgGN8Vz8eonunfH1GdpvEE1YWpvg4mf0peWiVDCu
 DjbuqqsUQYSCOBAWiAhhkMcRqDfUQhz7VbBJHTFxw5uLf/p3jvCFAOK
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

The bwi_active flag, callback pointer (cb), and callback context
(cb_context) in st21nfca_se_info are accessed concurrently from
multiple contexts without synchronization:

 - st21nfca_hci_se_io() sets them from the netlink/ioctl path
 - st21nfca_se_wt_work() reads/clears them from the timeout workqueue
 - st21nfca_apdu_reader_event_received() reads/clears them from the
   HCI rx path

Add a spinlock (se_lock) to serialize access to these fields.  The
callback pointer and context are copied under the lock and invoked
after releasing it, since both the callback and nfc_hci_send_event()
may sleep.

Also move the bwi_active = true assignment before mod_timer() so that
the flag is always set before the timeout handler could observe it.

Found by LLM-assisted manual code review.

Fixes: 2130fb97fecf ("NFC: st21nfca: Adding support for secure element")
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/nfc/st21nfca/se.c       | 24 ++++++++++++++++++++----
 drivers/nfc/st21nfca/st21nfca.h |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index 7154bc1d644a..03a30f797ff8 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -227,11 +227,13 @@ int st21nfca_hci_se_io(struct nfc_hci_dev *hdev, u32 se_idx,
 
 	switch (se_idx) {
 	case ST21NFCA_ESE_HOST_ID:
+		spin_lock(&info->se_info.se_lock);
 		info->se_info.cb = cb;
 		info->se_info.cb_context = cb_context;
+		info->se_info.bwi_active = true;
+		spin_unlock(&info->se_info.se_lock);
 		mod_timer(&info->se_info.bwi_timer, jiffies +
 			  msecs_to_jiffies(info->se_info.wt_timeout));
-		info->se_info.bwi_active = true;
 		return nfc_hci_send_event(hdev, ST21NFCA_APDU_READER_GATE,
 					ST21NFCA_EVT_TRANSMIT_DATA,
 					apdu, apdu_length);
@@ -260,11 +262,17 @@ static void st21nfca_se_wt_work(struct work_struct *work)
 	 */
 	/* hardware reset managed through VCC_UICC_OUT power supply */
 	u8 param = 0x01;
+	se_io_cb_t cb;
+	void *cb_context;
 	struct st21nfca_hci_info *info = container_of(work,
 						struct st21nfca_hci_info,
 						se_info.timeout_work);
 
+	spin_lock(&info->se_info.se_lock);
 	info->se_info.bwi_active = false;
+	cb = info->se_info.cb;
+	cb_context = info->se_info.cb_context;
+	spin_unlock(&info->se_info.se_lock);
 
 	if (!info->se_info.xch_error) {
 		info->se_info.xch_error = true;
@@ -275,7 +283,7 @@ static void st21nfca_se_wt_work(struct work_struct *work)
 		nfc_hci_send_event(info->hdev, ST21NFCA_DEVICE_MGNT_GATE,
 				ST21NFCA_EVT_SE_HARD_RESET, &param, 1);
 	}
-	info->se_info.cb(info->se_info.cb_context, NULL, 0, -ETIME);
+	cb(cb_context, NULL, 0, -ETIME);
 }
 
 static void st21nfca_se_wt_timeout(struct timer_list *t)
@@ -375,6 +383,8 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
 					u8 event, struct sk_buff *skb)
 {
 	int r = 0;
+	se_io_cb_t cb;
+	void *cb_context;
 	struct st21nfca_hci_info *info = nfc_hci_get_clientdata(hdev);
 
 	pr_debug("apdu reader gate event: %x\n", event);
@@ -383,14 +393,19 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
 	case ST21NFCA_EVT_TRANSMIT_DATA:
 		timer_delete_sync(&info->se_info.bwi_timer);
 		cancel_work_sync(&info->se_info.timeout_work);
+
+		spin_lock(&info->se_info.se_lock);
 		info->se_info.bwi_active = false;
+		cb = info->se_info.cb;
+		cb_context = info->se_info.cb_context;
+		spin_unlock(&info->se_info.se_lock);
+
 		r = nfc_hci_send_event(hdev, ST21NFCA_DEVICE_MGNT_GATE,
 				ST21NFCA_EVT_SE_END_OF_APDU_TRANSFER, NULL, 0);
 		if (r < 0)
 			goto exit;
 
-		info->se_info.cb(info->se_info.cb_context,
-			skb->data, skb->len, 0);
+		cb(cb_context, skb->data, skb->len, 0);
 		break;
 	case ST21NFCA_EVT_WTX_REQUEST:
 		mod_timer(&info->se_info.bwi_timer, jiffies +
@@ -416,6 +431,7 @@ void st21nfca_se_init(struct nfc_hci_dev *hdev)
 	/* initialize timers */
 	timer_setup(&info->se_info.bwi_timer, st21nfca_se_wt_timeout, 0);
 	info->se_info.bwi_active = false;
+	spin_lock_init(&info->se_info.se_lock);
 
 	timer_setup(&info->se_info.se_active_timer,
 		    st21nfca_se_activation_timeout, 0);
diff --git a/drivers/nfc/st21nfca/st21nfca.h b/drivers/nfc/st21nfca/st21nfca.h
index ae6771cc9894..abcef1ee48f2 100644
--- a/drivers/nfc/st21nfca/st21nfca.h
+++ b/drivers/nfc/st21nfca/st21nfca.h
@@ -6,6 +6,7 @@
 #ifndef __LOCAL_ST21NFCA_H_
 #define __LOCAL_ST21NFCA_H_
 
+#include <linux/spinlock.h>
 #include <net/nfc/hci.h>
 #include <linux/skbuff.h>
 #include <linux/workqueue.h>
@@ -131,6 +132,7 @@ struct st21nfca_se_info {
 	struct timer_list bwi_timer;
 	int wt_timeout; /* in msecs */
 	bool bwi_active;
+	spinlock_t se_lock;
 
 	struct timer_list se_active_timer;
 	bool se_active;

-- 
2.43.0


