Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999505;
	b=EhWxjzCY1c7LsqBuhpLprwQkE5J+0i2THGJ9SHwbyQxD/7f69qY49e+KPle4j98FSYms
	 cl0gDEqS6WNP5ITljeC51rlvusDEjvx3kL9JsdrpFUeUk6Sqvs1c8KWOAOokQkXKJZdIe
	 RiPXT6NRTciN3T/pFeLHd06PjIsq5tZtSAEaS2WyBWIjxlm91ziRiB8DhBoh5D8u1jC95
	 7ZyIAaPtsWngvSt2EXExhI0iFH79mnMc5jMLGoSf+EylVukiPif3eFL4N70JOTh1Haobj
	 LX2vdcPSGSYsAl+sUiA11vxOlwlFPX5onuQLlPzj/f5/fFsws3GPbv9Rbb9q8UE9OYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=sx3lWDVnR64JFWojROwlNESi0RwJ9liq+5x38VAAbKg=;
	b=U+3Q087tx8iAYxdAEOUnyhU7aXyt639j8QcKR7pe4iDoMacNWTkytZJFTkZ9wn9MaFSC
	 LVrSQBzOU2GiEK6B7mMKV/zWVCSB4tupmANZMT3DT+mT/FIcXKyONdACMarM2pNF+GxGd
	 8DRxmM2S8WHN4jTkUPQ4uAreppvzsbhIfQ5Y2s9s4H8GlwxmVbH4sk3t1oA0EfS8rfvfc
	 Cnw++1RVDMy+eVM/1amZmvwbaUGDxTdgVahyT3h9vWvQ3zpPxzvIhAKdyWMy4wUy5i9Tt
	 aaw+AQjc+caT1llWL7hnFGRAgh+L7ud+DqlVlKRb9KagXWyYSjQo00x+jzpQ1crRqXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cTwjcRVW;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7CE40606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE40606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cTwjcRVW
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so1361055a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999503; x=1793604303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sx3lWDVnR64JFWojROwlNESi0RwJ9liq+5x38VAAbKg=;
        b=cTwjcRVWW1SGcSZUcjitTM5D3In8fZew+buYGcWI+MDh2kHw/zrpRPPGS2Kp9leIaR
         ob3TbdwSXJLqdBYZps2eGdfBSTgj/DACFfzVO9MFY+dfWg0FYq/uoK8iseg0UhXo7c0X
         kJ3BmeawbPycV+qQXGArXVynjgzatVwdLuSv4Lld0VnwhiuKdd91w8+4rIA8RKe6Bx+E
         XKUsgnm/u5hPhkO7I5pkebrnK4k3JyCqmXUJHcvcSW9xbo43uN+8X4GE3mB08xDhS6c9
         pA5U4FPPe1RHDr4zLX2Lmg2WeNK83fTLQPWytg1czRj8OqN3bh441s1vqOusVS3jcjW6
         uZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999503; x=1793604303;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sx3lWDVnR64JFWojROwlNESi0RwJ9liq+5x38VAAbKg=;
        b=USmZZBUyVHBN/kAA5Lroz1V+/XE4wBzssljZXu0b4KeuHnv6EpOA1hwIjvWxHbsANx
         DMdgJUgqFn0CprpG9Po07itaSmvO1bzYvlQnPGwoy81GTPZOot0Y7OLbvVJjuqJStOvG
         Ygopc6+F8faV6ekIe5enMf7Z3k9nSNK/tR/xNxvgNlIFkMBpJ8Lzq9S+YBfQIW1BZlEr
         5n1v09g3KOWoqQ2iHIvGxtR43VeOeU2ZQjtOrz8nr8VaZgihGkZnv3fkZAnhZY6kACSj
         mq0jn/0wK/mUZE4buRtlIXyP3GJoUecP/Ktky6889Wz88KITRO1EjyaUy8F2rTZ//caY
         /NMA==
X-Gm-Message-State: AFq9FYJjTFacm+algBR60WO1Y5d3ZdU+8Ppopbk0KYLJLuftfhrnjFMo
	UOK6iLSJaoZyyu0GJpvCspXTCaB8ACtB1Tlfdkj4IlbVotjUBSNLcAuZ
X-Gm-Gg: AYBFou128guVnINQD54VlOyRVIanF6RdgP2WEAsMBkNL6xc8e7txO+TgINzyh0eaZd+
	Gj6azhl/ETVo2V+n0WJI9NxwKiHrZvs+qTj6NplKV+hZITjN9dz6JzEUTioQw3EFJl3QjEc/5Ac
	TwwkyuYZyjyHnCUjJE1k/ITeLak2pm0RLklANcQXULM9a686RtKa43XvIyeQeg5dcReUiaLbVXC
	oaWPOcHKZdXYTin53AV2x2OEiairy1LNrlANjXwF1496LboIsvDqkxvHyt4Vg+bsHsqXVxVTvKf
	yKMbChf47W4glHdiCopzFfi9C3bh2wKjWelFBIj4V84RqBTSVuShswM4GpuGyMb815UVfTyTaqc
	xPoY22hjp3txxBuSZ/wHCE/txNQo5CTHnV0q1QcRdlTRlxx/Om9ySmfI8TF/EztVztvPg7bwpn6
	2R3lv3pJvbtEmcncCObi3GdKJvtFQ3m9MQF4v9b3HYQIrHgT8u0VsXtgtBqc1hbss9bWiMZXKKM
	gbQuEZrRnSkIJo/uI4Hm8OcVdPv64jxjxMFZLUKndGZ6nQn8C4iAYEhH2BiP0yFIeAz4QdFD54N
	oXnin1IxqOw+E8wvmdEQpz3dojrOER0RuInuGyvyfPED6ZHBUjP4WOumAs6l
X-Received: by 2002:a17:90b:4ac5:b0:3ac:9717:afd1 with SMTP id 98e67ed59e1d1-3adeafaeb88mr4810570a91.63.1792999503501;
        Mon, 26 Oct 2026 00:25:03 -0700 (PDT)
Received: from 822-patch.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b11f48dsm12911345ad.17.2026.10.26.00.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:25:03 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com, Mark Greer <mgreer@animalcreek.com>, "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Ian Ray <ian.ray@gehealthcare.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Escande <thierry.escande@linux.intel.com>, Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH net 1/1] nfc: digital: fix use-after-free in unregister
Date: Mon, 26 Oct 2026 15:24:07 +0800
Message-ID: <1792999448.107874-2-xuyuqiabc@gmail.com>
In-Reply-To: <cover.1791172164.git.xuyuqiabc@gmail.com>
References: <cover.1791172164.git.xuyuqiabc@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.56.0

nfc_digital_unregister_device() cancels its own workqueue items and
then frees every queued digital_cmd. A command already submitted to
the driver remains the argument of the async completion.
digital_send_cmd_complete() can still assign cmd->resp after that
object has been freed, which is a use-after-free.

Abort the in-flight driver command before reclaiming the queue, and
drain the completion work the driver may schedule from abort. Once
the nfc device is shutting down, do not queue or submit another
command: finishing the aborted one would otherwise hand the next
queued command to the driver while it is being freed.

Port100 and nfcsim invoke the digital completion from a private work
item, so flush that work before abort returns. trf7970a completes from
a delayed timeout work and from its IRQ thread; handle its MD listening
state in abort and shutdown, and stop the timer before the device is
released. st95hf's IRQ thread can observe that remove already ran and
must not call back into the freed command.

Fixes: 59ee2361c924 ("NFC Digital: Implement driver commands mechanism")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 drivers/nfc/nfcsim.c      |  8 +++++++-
 drivers/nfc/port100.c     |  7 +++++++
 drivers/nfc/st95hf/core.c | 13 ++++++++++---
 drivers/nfc/trf7970a.c    |  5 +++++
 net/nfc/digital_core.c    | 22 +++++++++++++++++++++-
 5 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index f8e5c4da3b13..52d1fbf8e532 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -239,9 +239,15 @@ static int nfcsim_send(struct nfc_digital_dev *ddev, struct sk_buff *skb,
 
 static void nfcsim_abort_cmd(struct nfc_digital_dev *ddev)
 {
-	const struct nfcsim *dev = nfc_digital_get_drvdata(ddev);
+	struct nfcsim *dev = nfc_digital_get_drvdata(ddev);
 
 	nfcsim_link_recv_cancel(dev->link_in);
+	/*
+	 * recv_work blocks in the link wait and then calls the digital
+	 * completion. Wake it and wait so the callback cannot run after
+	 * abort_cmd() returns.
+	 */
+	flush_work(&dev->recv_work);
 }
 
 static int nfcsim_switch_rf(struct nfc_digital_dev *ddev, bool on)
diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index e769a30b8b5c..738acb87f19b 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -968,6 +968,13 @@ static void port100_abort_cmd(struct nfc_digital_dev *ddev)
 
 	/* cancel the urb request */
 	usb_kill_urb(dev->in_urb);
+
+	/*
+	 * The URB completion handler only queues cmd_complete_work, which
+	 * is what calls back into the digital stack. Run it before
+	 * returning so that callback cannot outlive abort_cmd().
+	 */
+	flush_work(&dev->cmd_complete_work);
 }
 
 static struct sk_buff *port100_alloc_skb(const struct port100 *dev, unsigned int size)
diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 4d772a308bff..b39a5215dad7 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -856,9 +856,16 @@ static irqreturn_t st95hf_irq_thread_handler(int irq, void  *st95hfcontext)
 	kfree_skb(skb_resp);
 	wtx = false;
 	cb_arg->rats = false;
-	skb_resp = ERR_PTR(result);
-	/* call of callback with error */
-	cb_arg->complete_cb(stcontext->ddev, cb_arg->cb_usrarg, skb_resp);
+	/*
+	 * remove() frees the digital command before dropping rm_lock.
+	 * The completion argument is then gone; do not write it.
+	 */
+	if (!stcontext->nfcdev_free) {
+		skb_resp = ERR_PTR(result);
+		/* call of callback with error */
+		cb_arg->complete_cb(stcontext->ddev, cb_arg->cb_usrarg,
+				    skb_resp);
+	}
 	/* up the semaphore before returning */
 	up(&stcontext->exchange_lock);
 	mutex_unlock(&stcontext->rm_lock);
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index ddfc58c29964..962a5e08bcd0 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1903,6 +1903,7 @@ static void trf7970a_abort_cmd(struct nfc_digital_dev *ddev)
 		trf->aborting = true;
 		break;
 	case TRF7970A_ST_LISTENING:
+	case TRF7970A_ST_LISTENING_MD:
 		trf->ignore_timeout = !cancel_delayed_work(&trf->timeout_work);
 		trf7970a_send_err_upstream(trf, -ECANCELED);
 		dev_dbg(trf->dev, "Abort process complete\n");
@@ -2017,6 +2018,8 @@ static void trf7970a_shutdown(struct trf7970a *trf)
 	case TRF7970A_ST_WAIT_FOR_RX_DATA_CONT:
 	case TRF7970A_ST_WAIT_TO_ISSUE_EOF:
 	case TRF7970A_ST_LISTENING:
+	case TRF7970A_ST_LISTENING_MD:
+		trf->ignore_timeout = !cancel_delayed_work(&trf->timeout_work);
 		trf7970a_send_err_upstream(trf, -ECANCELED);
 		fallthrough;
 	case TRF7970A_ST_IDLE:
@@ -2223,6 +2226,8 @@ static void trf7970a_remove(struct spi_device *spi)
 {
 	struct trf7970a *trf = spi_get_drvdata(spi);
 
+	cancel_delayed_work_sync(&trf->timeout_work);
+
 	mutex_lock(&trf->lock);
 
 	trf7970a_shutdown(trf);
diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index 18236221d898..51d826c7325f 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -162,7 +162,11 @@ static void digital_wq_cmd(struct work_struct *work)
 
 	cmd = list_first_entry_or_null(&ddev->cmd_queue, struct digital_cmd,
 				       queue);
-	if (!cmd || cmd->pending) {
+	/*
+	 * Unregister has already handed an in-flight command to the driver
+	 * and will free whatever is still queued. Do not submit another one.
+	 */
+	if (ddev->nfc_dev->shutting_down || !cmd || cmd->pending) {
 		mutex_unlock(&ddev->cmd_lock);
 		return;
 	}
@@ -244,6 +248,11 @@ int digital_send_cmd(struct nfc_digital_dev *ddev, u8 cmd_type,
 	INIT_LIST_HEAD(&cmd->queue);
 
 	mutex_lock(&ddev->cmd_lock);
+	if (ddev->nfc_dev->shutting_down) {
+		mutex_unlock(&ddev->cmd_lock);
+		kfree(cmd);
+		return -ENODEV;
+	}
 	list_add_tail(&cmd->queue, &ddev->cmd_queue);
 	mutex_unlock(&ddev->cmd_lock);
 
@@ -846,6 +855,17 @@ void nfc_digital_unregister_device(struct nfc_digital_dev *ddev)
 	cancel_work_sync(&ddev->cmd_work);
 	cancel_work_sync(&ddev->cmd_complete_work);
 
+	/*
+	 * A command with pending set has been given to the driver as the
+	 * completion argument. Freeing it here lets a late
+	 * digital_send_cmd_complete() write cmd->resp into freed memory.
+	 * abort_cmd() drops that exchange; the driver may schedule
+	 * cmd_complete_work before it returns, so drain both works again.
+	 */
+	digital_abort_cmd(ddev);
+	cancel_work_sync(&ddev->cmd_complete_work);
+	cancel_work_sync(&ddev->cmd_work);
+
 	list_for_each_entry_safe(cmd, n, &ddev->cmd_queue, queue) {
 		list_del(&cmd->queue);
 
-- 
2.56.0

