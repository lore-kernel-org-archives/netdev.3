Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490771;
	b=UfjH7fQ9/pev6eBGaG450Sn9W2DCw0Zu6P2FVFv5eDAtYOs9T2s5ExnIjX4FawdsWvol
	 BVuOw8H1tqgWo4huD7KkHoMlcOpu9zm59utDmWbvSXMSLiQdKAyaMAv9RPwvVNOKzFqer
	 cqEhQGy+8JBYBhQTrjQ8o5gYRlZfKgCw6lCdy7NAVmzdU0Z5adwAYJqQ91HA2/e6SmA6I
	 j88RplwpoBa7FV523y2BZMtsVDw0cZ1jI1+uwmPirIofdMNdGHynENdmMbCFWk08d7chc
	 yBbVx9ya3Z348qEIaV4qsguwDCDxnlEGFohWXPXVb7lsRR2fnyLVuFT5BLgiDtUAVZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490771;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NjeXHJ0/wwse89OwYMk3lb2/lokGK5EV8MiE+1eixis=;
	b=fvyJHiHULacaOg+CQ9fhirfqHXewQ9ebVuTD8OJ8rgOsco7iQAtqR+qRz2xI25GBrT+Y
	 8w9+pYjqZa/BnQpZIqTEBnHRvte8cgJ+NmIrkIXqHCJiR7uWhZzccDk0Q5Un6mzg7JKMV
	 57dGZHoNXlX7E4C6H4kN/cqFDeKGh9LZLKCFvuxVdEbJVpXWPpuQ4sXOrMssreH8rNKzK
	 eP8hH+5/29JzZuSrInW3GyRFBEbzWiJmMd8mvhh4ONOtGb6BX1IYQkrK1TzC93QTCmJ9v
	 WsMCm6mG/usii6fTOnP7rKEqLLVh83vhfL/UtDnhrENQNor0691+9gds4npponD9Zog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qcw3W9V2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE6606A327;
	Thu, 12 Nov 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qcw3W9V2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794490770;
	b=iiOgwpkfqZax2XMydxG3uWruSkw2uKl3ez1jyXYHG2OJORVuaUmRg2wBrUm2itsPLtHh
	 pkwJnsHRyuuTHa53udQHLP6guRJLOUO2Jc8jhzPDIWl+y0uAkLv2bRCNUk//mEY424Irw
	 gFUkauLW/GUS1aC1yQftpsdNvDH5P7SyoaNOTrbEKLclI/nigbE37t9pc9bBem58DiAw/
	 dLTdvyI0m7e8p19JA35iLLqYiLaV085IrtFT6zyRWPPbivNb1IYWxwp5E0ZL6Xkk3wcan
	 PnQjbILKGnOhttRflqLVuK37TJho068CJ/pW5nC5p46IzMQl5KuKL1OJpD9O9sBnNYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794490770;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NjeXHJ0/wwse89OwYMk3lb2/lokGK5EV8MiE+1eixis=;
	b=MkJ6VI+LnEEHIta/E517E1xVgQs61Cq2q71hOkGuV5OC9o68qp+XPsXnik3mgoxrUwkg
	 Oy03lHVjQEkrDv2aE2mEL+Ie+ubZ9SjUfnlNoAaa50qgcFmFP8Cyijj40OzpU9/GXB7xZ
	 wB6BSevK7jZVnEmfNokp8Yvw/vHT/yYTBfehU7eYidaZ1dl9wUHHmYidYmyf70DekTxLn
	 EsIE/G092fhlDqv2cpt/7W6KBH4XVwOdnHn/jyd7iek3UaTL4EoqqGRUK4jLqjMiQnVNC
	 GjX3o3bzuPTiLN+09Ot6ATSju4ElrbI3miJYaBWXH/pyoPNYhOII9wVXDu2RX7P3rNw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1D8B61F00A10;
	Thu, 12 Nov 2026 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490770;
	bh=NjeXHJ0/wwse89OwYMk3lb2/lokGK5EV8MiE+1eixis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Qcw3W9V21KKKg3qNLdBbWhlwTevkk7pzutkukAPmnO+kWd+begFIiQ1zKRN72Vsmg
	 zliDLNTfQxaNNQx9jCqWlQMifgRdYq7zxD0jQ7ptiZ85p5p4+xRwOpS4NJgETcaXc2
	 SEFCl2Ml1ezmVcUMIieKYlsQufzzkX7bZUUyLahrNCv1eldkX3StneN/YI48gbSzx5
	 DfRIiX4QJAj4xhhTrGlGIooxX6Hv/rjLUQ0Gv/Fsy0Z7GN10wWOioEsn6VQW0uzM2r
	 hLEAE8orBpjI0+qXbgBi7B7cI4qcNbXmZcUlImQIl2+FqarpR8yCxM0f4VvQ6E4Sv4
	 6LCJUVt7lR/7A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 98AC24951A;
	Thu, 12 Nov 2026 13:39:29 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 13:39:30 +0000
Subject: [PATCH net v3 2/2] nfc: st21nfca: prevent double completion of SE
 APDU request
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
Message-Id: <20261112-st21nfca-v2-v3-2-c81702269e01@gmail.com>
References: <20261112-st21nfca-v2-v3-0-c81702269e01@gmail.com>
In-Reply-To: <20261112-st21nfca-v2-v3-0-c81702269e01@gmail.com>
To: david@ixit.cz, krzk@kernel.org, joasantonio108@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, horms@kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794490768; l=3240;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=vqHaopVgmvBm60zL9N9NShO0nqLNUceOzRe4TpLFHXE=;
 b=aOASxBBDF+J49IECQQPB6r/37593fsh0gpF67cWJQhtGpM6W4vvqwtg8wq87QCpiYLbNpLlNg
 5cascdw5MWQA70BDjszptYvxSBe6BEZ3ItpftG8pYyChuSp1Um1mz1t
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

Use the spinlock added in the previous commit to prevent completing an
SE APDU request more than once.  Without this, the timeout work handler
(st21nfca_se_wt_work) and the EVT_TRANSMIT_DATA event handler can both
invoke the callback for the same request.  The callback frees its
context, so the second call is a use-after-free followed by a double
free.

Check bwi_active under the lock in both completion paths and only
complete a request that is still pending.  A response that arrives
after the timeout still gets its EVT_SE_END_OF_APDU_TRANSFER, as
before, but no callback.

Also reject a new SE APDU request in st21nfca_hci_se_io() with -EBUSY
while one is in progress, instead of overwriting the callback and
context of the pending request.  The callback is not called in that
case, so free the context like the -ENODEV path does; nfc_se_io() does
not free it once the driver has been called.

Found by LLM-assisted manual code review.

Fixes: 2130fb97fecf ("NFC: st21nfca: Adding support for secure element")
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/nfc/st21nfca/se.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index 03a30f797ff8..63a88a61d310 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -228,6 +228,12 @@ int st21nfca_hci_se_io(struct nfc_hci_dev *hdev, u32 se_idx,
 	switch (se_idx) {
 	case ST21NFCA_ESE_HOST_ID:
 		spin_lock(&info->se_info.se_lock);
+		if (info->se_info.bwi_active) {
+			spin_unlock(&info->se_info.se_lock);
+			/* The callback is not called, see the comment below */
+			kfree(cb_context);
+			return -EBUSY;
+		}
 		info->se_info.cb = cb;
 		info->se_info.cb_context = cb_context;
 		info->se_info.bwi_active = true;
@@ -269,6 +275,10 @@ static void st21nfca_se_wt_work(struct work_struct *work)
 						se_info.timeout_work);
 
 	spin_lock(&info->se_info.se_lock);
+	if (!info->se_info.bwi_active) {
+		spin_unlock(&info->se_info.se_lock);
+		return;
+	}
 	info->se_info.bwi_active = false;
 	cb = info->se_info.cb;
 	cb_context = info->se_info.cb_context;
@@ -383,6 +393,7 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
 					u8 event, struct sk_buff *skb)
 {
 	int r = 0;
+	bool active;
 	se_io_cb_t cb;
 	void *cb_context;
 	struct st21nfca_hci_info *info = nfc_hci_get_clientdata(hdev);
@@ -395,6 +406,7 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
 		cancel_work_sync(&info->se_info.timeout_work);
 
 		spin_lock(&info->se_info.se_lock);
+		active = info->se_info.bwi_active;
 		info->se_info.bwi_active = false;
 		cb = info->se_info.cb;
 		cb_context = info->se_info.cb_context;
@@ -405,7 +417,9 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
 		if (r < 0)
 			goto exit;
 
-		cb(cb_context, skb->data, skb->len, 0);
+		/* The request may have been completed by the timeout already */
+		if (active)
+			cb(cb_context, skb->data, skb->len, 0);
 		break;
 	case ST21NFCA_EVT_WTX_REQUEST:
 		mod_timer(&info->se_info.bwi_timer, jiffies +

-- 
2.43.0


