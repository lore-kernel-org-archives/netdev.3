Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490771;
	b=usHDaRXagtjco0McmD0zDr5ITeuVV8qZMDklHvEAHEnt0MZgmogQmIfzH350BGdx1PVn
	 9QtbVdveCFVd2h0C7S1hh9dBXlitflVSQ3vZycX7RYIUgYmusmdMMPoTLQ4RdEHuYajlO
	 QMnxwLtQUwyaDoM9rkN2oLynogjZHTJEjJFyeYCv1oeZdCf5F15ceFUV5a9Bf9MfLNCo6
	 ADVognPLfIN7mhmyZa30GWOxOxpFXxQIOzsuxl43HZlR68NEYqAd4R0OFWFlaXnqpSH4L
	 5mqJvl878yblUS8ronUnz9ExHcYEQ4c56qBLwHudoMk0jWLleA6UayQrf/PGQ/QAo2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490771;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Qr085VRnl8gJZ/3Bm96U62EfaKT+yyDYox/VAzqsz1w=;
	b=VMdleNboUDNDAII4UfZNNL5c1KA0wLv58+fMcK0E9wvbChAwZHlFs/++wfQG8xKwg2Rs
	 vyu0h2h9v8olygAiaQDbXUnyofAaX0elSqr6DHyG6ShxDT7oL7YnRWGQfE7mEH2yV2kh7
	 t7WJiNCglt4lQTiRefvVC1Ve1rmbsbShq4CAFv3tjwOQGAe8LVpwIDqINtYSS5ixvKrwU
	 JcRGl32UrKsBvxcWxMMVobSeiZMCIiJYNtvtjbSeNKrqhqFTYM3RWHHS9M5MOazEVdRAc
	 MoRh8HmMeJyC3F1HIZrCWPBUZupLZqPoeLYmY3xWOALnV+fwKOZKoNRNtt61Qomk30Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljIDbazF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59065606A886;
	Thu, 12 Nov 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljIDbazF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794490771;
	b=hf/kKX1ey9hlfCPzd9/MxIoAoRMGhHNY3JCG0LB6V2toXykAP6rixx0K9/5Il1Yt25Wo
	 CuB61CMbkXBcZQo/JiuGIJo4jw1GiDCZ4i2qSoRHGcWjC5pLPnpTAbRA+VZcysusYsyQq
	 wSVmHS3R124rXU2uCZz1dBSaXgPjz6LCjcN2KUpRdov3OETYQmihqIPSFsPba5fbAVVTb
	 +0CF3K8gIq27iANaMs3RKL/rFd9lSEqL5ocCBBWw6nHGyIGlltxMjFzbvBGmqovsQ/32N
	 K3gKhoN9V4Kwylq6E9q2dyIovdouAtOy9utDo1I2aqSMgjZZ6yfRXASv1MkvwsiF7zQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794490771;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Qr085VRnl8gJZ/3Bm96U62EfaKT+yyDYox/VAzqsz1w=;
	b=hmf6C01ArPLD0kfg50WSB9q44GSBqHTYvIH9XN6OkCr2ivSQ2uhMmBqL2q9DSudy6BKp
	 1OjYOI5DiSraTttpValmKjlEONhaAOYSEsu52MnKZKFeV+RJ7JvPVaS5oDrY4eysWtFfr
	 Vm7CD2BOHSzTqxNL82XIB0LRG46UR9w4NkbZfXikGp20JEE2g6ZTDmg9WQRjn+9e+29bv
	 MGRbKjR6EI7Oidn56DUaXtwiJNASwYsKqXASmO06mwZaQLn9Bp6X79SbeqHSFZApo9ZXC
	 R7Jw7Wol0QXUr9QGZfIj2EHEWDsbLk9fwNvcvGbciPdPT/bJkSzB14zsujh1VlKK7lQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1D9401F00A13;
	Thu, 12 Nov 2026 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490771;
	bh=Qr085VRnl8gJZ/3Bm96U62EfaKT+yyDYox/VAzqsz1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ljIDbazF/6iILzPZrJIKMjbmWlIal4Rc2NrqU59LqAzyX7tZMjcmQBgPWSNJg1T7y
	 5333f6xMkeJbg1KITMkRNdvpniX/K5Ny6+Q/Lyx7uwq27/ftHiyd6UJOz5XPMeIW8p
	 tIj8PncmTwxAyjhKbblI362uVkAyKMHO2bIb7aQLCe6TeEwdS52pJ7aOOgeDhlKAwh
	 vreUoUoklVTk/Z4uHz1VTMzg6s9BoxSiUcmibVHstpXeMynB6OfcGCNEF5gFVHX41c
	 FDQUYEBfR6CVgcWHVKYbut/Ssm/k7NQo8Goq6WPUE5Juv5kC8TjvFdd7FxLUcK+eWM
	 U2evMV6+LVedg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 848E4494F8;
	Thu, 12 Nov 2026 13:39:29 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 13:39:29 +0000
Subject: [PATCH net v3 1/2] nfc: st21nfca: add spinlock to serialize SE
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
Message-Id: <20261112-st21nfca-v2-v3-1-c81702269e01@gmail.com>
References: <20261112-st21nfca-v2-v3-0-c81702269e01@gmail.com>
In-Reply-To: <20261112-st21nfca-v2-v3-0-c81702269e01@gmail.com>
To: david@ixit.cz, krzk@kernel.org, joasantonio108@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, horms@kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794490768; l=5138;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=gbB1vcL0IEfdm5e/eHIFkQNefoTQQiMuPGA/mTBLC/0=;
 b=xKMt5ZhDemp4ofzpZnOJr5SLZt1AtqbBBsCw4Ouzu2WeeD0xNF1mTX++iGu4KeKPjFRhUCpQe
 2GFk2MEE+ZICHlyTLeWHuXTD5VchRgRoxcZ3H1gfMmz4iL8T7bJSYXr
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

 - st21nfca_hci_se_io() sets them from the netlink path
 - st21nfca_se_wt_work() reads/clears them from the timeout workqueue
 - st21nfca_apdu_reader_event_received() reads/clears them from the
   HCI rx path

Add a spinlock (se_lock) and take it around the accesses in these
three paths.  The callback pointer and context are copied under the
lock and invoked after releasing it, since both the callback and
nfc_hci_send_event() may sleep.

Also move the bwi_active = true assignment before mod_timer() so that
the flag is always set before the timeout handler could observe it.

st21nfca_se_deinit() is not changed here.  It still accesses
bwi_active without the lock; the teardown ordering has problems of its
own which need a separate fix.

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
index ae6771cc9894..03e41fadb5ed 100644
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
+	spinlock_t se_lock; /* protects bwi_active, cb and cb_context */
 
 	struct timer_list se_active_timer;
 	bool se_active;

-- 
2.43.0


