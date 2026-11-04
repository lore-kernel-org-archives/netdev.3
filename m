Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773242;
	b=KYlQTOsDNbsudIbsbwj6rhDzcQl+Vncww6WAC1vZiOlZo0ZsICGD+99FAKGfFOZkyDA/
	 Yx/lUHTmddqyPPd5cU1VezLtGQkwcrNU4T9jboxn37DwAvt9SwaCDa8mnR0OYGFy9AvjD
	 /u3A+xP/UxfEbk595QcZtwQYTOF0jc91yTZGRDb/ZpUJnMkxud5qGKy02zq7OVpvkqC/N
	 cVJLhWCb+UzMCT7soOL+GRRbN5U2Vt0+yKv+kH+NFDvHypTzmyyDpPJobSjcOLFY4KC3h
	 v7qRuVM38X5xh5cvYa13l+m0TvQSckForD3CjRTI7jAoU03o+3Q7lkE0DhyotymAyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1tJVRCb/zaDNHQdLOze/vPuDWnmA0GE0275Fh9oDpzU=;
	b=qAdlrR2yDyYt67MRNYa475sgxckxkusPvZKxkJJqMsvBlDXEluQMMSk/MB3l0oTcFeTM
	 3SQ0q1p7QmObNLUTwi3m0lQYsyTzYYLddQRUVIhJNbUFm9K5XY9BcurQbulIEP1SDTLSs
	 e94K2R5cGiRt/o1sPBNU4hFYjrnayslbbfeS4Jio2nFxC08zSc3/TZQpiy5EYcYbJEfIh
	 tvNR6tCm0rdGldRLj/Z5Wu+IjZyTngX7mFJ1P/At4BtDCk9c3JR9R3f2FWijEN1bg6dzQ
	 cBDILcbbMQrXmDqSD5hNoEYQJOqN93S2lJtydIf6AcLQs75xtLW94D/voBOYnBHd/+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=R24WMQQA;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A87606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A87606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=R24WMQQA
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-353804b591eso631667eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1793773241; x=1794378041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1tJVRCb/zaDNHQdLOze/vPuDWnmA0GE0275Fh9oDpzU=;
        b=R24WMQQAjlT+JC14jgGN84PV72AMgdxQv2816eIEx8GLSkjepCp+ZmZv8Bv487EmDG
         cIZbb7yoP2VlG8AlzzDYkp3N+DuyEK7nZM5YgTacK78ie5zsL93hMGrw81MZ9W01y6uw
         0yTRHZU2SY+eA5ROBeSCB6KAtoqaqkAxh5DmCNbyEbSHebY1kQK57EmWPiD+bsqDmfLb
         p1HY3+a7NmBdMzc2SEW1u5hLITrqyfeX6OTJQRnRY8WpRCv9Pc647Sp8Q4A/Eayz6MNr
         0JtsCriXFDR+Sfe4Fc8XF72b6fqyqInTqtEZp4eZh51Du4XETtjba+5BhRW4wxpU9mob
         M95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773241; x=1794378041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1tJVRCb/zaDNHQdLOze/vPuDWnmA0GE0275Fh9oDpzU=;
        b=UuHGGiDx3e3JWLKgr6PDvKg16HcFJRb+FoSLuCHadTMSQ9Km1TyrKTreVlyJikg9YA
         WL4Zfy/xBRWOTbdmnSAShm3cvuj/7g1IFbs0CqLtUtj8GGVEOVwhOfWUnvDD3c9c8OCX
         AA9z7Ef8nnYEHfR9twm2ufA4Xdt/y/5KInwr5nf4nKU0uj0HwxwiQoPzMN4w8F7Oa1li
         qzLK3B6WOu/ZpoLqfeIT7fiVlfHMzPEOcPQjbSSMkS+GFSjYUWnkmRwEmwgdDl6Ggt8T
         REq2I6dBHpTZ0esxea0bEzL/6vkdKxmGtmNt0N9Ftw1bTyh69sr8U44NSBtNpfOQh2DE
         NK3g==
X-Gm-Message-State: APuU4Z/ySqInIhiprx02QFlj9+or4iUqQZ4L7Ou1h0sKYsu90oguryNX
	QreK4w9AnsKSqgRtRAkQPuKOigP7UjUBgJ3U+fs3aIg16LxbyQl8z2osvMj3QA0TJqwC0+IWg6a
	hZXhY
X-Gm-Gg: AYBFou1hDiUv/SlZELtwexvFFHa0rYoUehb/WmXbu4xlE+TQAJlc4mxoALZsvkmASpf
	+mcU+APddbLSKqoALCPZKhfSUo2CvEGJlrd7mJahLXFn89vVlMtbSXstX9LPkfIXBarRgHcLmTG
	wSHiYn3GQgFcSqE+XKd8zIAZguHDU55evWlCxqC4xHnLZFLo37Y4B7nguVkoDjiP+0FBh3kRYES
	VGg7bUwT50T/rIocQxIsCBdVQQBnZJEsyiWaO0w5SVkLqtiycofiFrd7epuWo2PFcsYquLDdE1P
	rzpKCxFWvS73Vxn8bctZ7jm9bpLYc28PVCcXjKAgyMsbcJnNS2IIPQVvB7KAuBHphk6/BVZ2Bl/
	RELyz3DI3qEb3zN/EOScO3uLGGOhMgC9YgRsQ1UuoQ9iM80HxbaVR2pSOeR9rXjnYO2vK5fbXnJ
	ObCKlFfeTQ2DGdKKT2jY6XcCa12q7g1I9xHnGWCCvRO7h3dCf1KGW2Kgq8hK3GZbjOqTUmoN9cQ
	Jp/ttdLb7pFtghne3DjUY0Lc+sz2dvhCeKryUIIYMfGg2WQof/UZ0h8AgLC+bPPRCKxzrcTHxCJ
	Bj9CmYEunD3qhW/Tu++LGr3Pvex0d3Actln3gRaui4IWyXUCmv7h17XXAVCiifw/n1DS0GYpFTw
	6uStwfTY1U4RKVdbjEDOYQu/YeZxhwg8rziKHEpJlffFwNEIdkv4Nqt1o/PG13hrBWMHbEdE=
X-Received: by 2002:a05:701b:4283:10b0:191:a5b2:ef4a with SMTP id a92af1059eb24-1ac5cb186d7mr23086695c88.28.1793773240379;
        Tue, 03 Nov 2026 22:20:40 -0800 (PST)
Received: from localhost.localdomain ([103.196.55.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c69c3fsm4486279c88.20.2026.11.03.22.20.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 22:20:39 -0800 (PST)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	david@ixit.cz,
	horms@kernel.org,
	gio@octane.security
Subject: [PATCH net v7 3/3] nfc: nfcmrvl: stop firmware work before unregistering
Date: Wed,  4 Nov 2026 11:50:26 +0530
Message-ID: <20261104062026.80599-4-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104062026.80599-1-shubham@octane.security>
References: <20261104062026.80599-1-shubham@octane.security>
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

nfcmrvl_nci_unregister_dev() destroys the NCI workqueues before draining
the firmware receive worker.  That worker can still submit NCI commands,
while the later abort can release firmware state that it is processing.
The firmware timeout can also complete the same download in parallel with
the receive worker.

Add active and stopping states protected by the firmware receive lock.
Once completion or teardown starts, reject new firmware receives and wait
for active receive entry points.  Shut down the firmware timer, cancel the
receive and timeout workers, and purge their queue before releasing
firmware state.  Perform this shutdown before unregistering the NCI device
so its command workqueue remains available until firmware work has ended.

Drain the NCI command timer, command worker, and command queue as one
dependency chain.  Delete the timer before and after cancelling command
work so a detached timer callback cannot queue work which rearms the timer.
This also removes command skbs which cannot run after command admission is
closed.

Queue timeout completion on the firmware workqueue and claim completion
under the receive lock so firmware state is released once.  Hold received
frames until the initial reset pulse has finished, preventing an error path
from asserting reset while the start path later deasserts it.  Report
firmware completion with the positive errno value expected by the NFC API.
Reject a new download while the current one is active or still completing,
so its firmware pointers and state cannot be replaced during asynchronous
processing or cleanup.

Initialize the firmware timer while setting up the receive workqueue.
This makes teardown valid even when a download was never started.
Serialize the stopping transition with firmware start through the NFC
device lock.  Use non-synchronous timeout-work cancellation during
completion because
completion can run from the timeout work itself.

Discovered during an AI-assisted source audit using OpenAI Codex,
gpt-5.6-sol.  Patch development and test planning used the same assistant.
Confirmed with an unmodified kernel and a pty-backed user-space controller
exercising firmware start, timeout, completion, and device teardown; no
error injection was used.

With the fix applied, the reproducer passed 500 firmware teardown cycles
and all five timer-boundary modes under KASAN, UBSAN, and lockdep, plus 200
cycles under strict-mode KCSAN.  No physical Marvell controller was
available, and no in-tree selftest covers this firmware path.

Fixes: 3194c6870158 ("NFC: nfcmrvl: add firmware download support")
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/fw_dnld.c | 243 +++++++++++++++++++++++++---------
 drivers/nfc/nfcmrvl/fw_dnld.h |  11 ++
 drivers/nfc/nfcmrvl/main.c    |   5 +-
 3 files changed, 192 insertions(+), 67 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index 8b9d52573..6e8608655 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -90,22 +90,50 @@ static struct sk_buff *alloc_lc_skb(struct nfcmrvl_private *priv, uint8_t plen)
 	return skb;
 }
 
-static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
+static void fw_dnld_stop_cmds(struct nci_dev *ndev)
 {
-	if (priv->fw_dnld.fw) {
-		release_firmware(priv->fw_dnld.fw);
-		priv->fw_dnld.fw = NULL;
-		priv->fw_dnld.header = NULL;
-		priv->fw_dnld.binary_config = NULL;
-	}
-
-	atomic_set(&priv->ndev->cmd_cnt, 0);
-
-	if (timer_pending(&priv->ndev->cmd_timer))
-		timer_delete_sync(&priv->ndev->cmd_timer);
+	/*
+	 * The timer callback can queue cmd_work after a workqueue flush, while
+	 * cmd_work can rearm the timer.  Drain both directions before purging
+	 * commands which belong to the firmware state machine.
+	 */
+	timer_delete_sync(&ndev->cmd_timer);
+	atomic_set(&ndev->cmd_cnt, 0);
+	cancel_work_sync(&ndev->cmd_work);
+	timer_delete_sync(&ndev->cmd_timer);
+	skb_queue_purge(&ndev->cmd_q);
+}
 
-	if (timer_pending(&priv->fw_dnld.timer))
-		timer_delete_sync(&priv->fw_dnld.timer);
+static void fw_dnld_over(struct nfcmrvl_private *priv, int error)
+{
+	struct nfcmrvl_fw_dnld *fw_dnld = &priv->fw_dnld;
+	char name[NFC_FIRMWARE_NAME_MAXSIZE + 1];
+	u32 result = error < 0 ? -error : error;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	if (!fw_dnld->active) {
+		spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+		return;
+	}
+	fw_dnld->active = false;
+	fw_dnld->completing = true;
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+
+	strscpy(name, fw_dnld->name);
+	wait_event(fw_dnld->rx_wait, !READ_ONCE(fw_dnld->rx_active));
+	timer_delete_sync(&fw_dnld->timer);
+	/* Timeout and receive work share a single-thread workqueue. */
+	cancel_work(&fw_dnld->timeout_work);
+	fw_dnld_stop_cmds(priv->ndev);
+	skb_queue_purge(&fw_dnld->rx_q);
+
+	if (fw_dnld->fw) {
+		release_firmware(fw_dnld->fw);
+		fw_dnld->fw = NULL;
+		fw_dnld->header = NULL;
+		fw_dnld->binary_config = NULL;
+	}
 
 	nfc_info(priv->dev, "FW loading over (%d)]\n", error);
 
@@ -114,7 +142,11 @@ static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
 		nfcmrvl_chip_halt(priv);
 	}
 
-	nfc_fw_download_done(priv->ndev->nfc_dev, priv->fw_dnld.name, error);
+	nfc_fw_download_done(priv->ndev->nfc_dev, name, result);
+
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	fw_dnld->completing = false;
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
 }
 
 static void fw_dnld_timeout(struct timer_list *t)
@@ -122,6 +154,18 @@ static void fw_dnld_timeout(struct timer_list *t)
 	struct nfcmrvl_private *priv = timer_container_of(priv, t,
 							  fw_dnld.timer);
 
+	queue_work(priv->fw_dnld.rx_wq, &priv->fw_dnld.timeout_work);
+}
+
+static void fw_dnld_timeout_work(struct work_struct *work)
+{
+	struct nfcmrvl_fw_dnld *fw_dnld = container_of(work,
+						       struct nfcmrvl_fw_dnld,
+						       timeout_work);
+	struct nfcmrvl_private *priv = container_of(fw_dnld,
+						    struct nfcmrvl_private,
+						    fw_dnld);
+
 	nfc_err(priv->dev, "FW loading timeout");
 	priv->fw_dnld.state = STATE_RESET;
 	fw_dnld_over(priv, -ETIMEDOUT);
@@ -395,62 +439,74 @@ static int process_state_boot(struct nfcmrvl_private *priv,
 
 static void fw_dnld_rx_work(struct work_struct *work)
 {
-	int ret;
-	struct sk_buff *skb;
 	struct nfcmrvl_fw_dnld *fw_dnld = container_of(work,
 						       struct nfcmrvl_fw_dnld,
 						       rx_work);
 	struct nfcmrvl_private *priv = container_of(fw_dnld,
 						    struct nfcmrvl_private,
 						    fw_dnld);
+	struct sk_buff *skb;
+	unsigned long flags;
+	int ret;
 
-	while ((skb = skb_dequeue(&fw_dnld->rx_q))) {
-		nfc_send_to_raw_sock(priv->ndev->nfc_dev, skb,
-				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
-		switch (fw_dnld->state) {
-		case STATE_RESET:
-			ret = process_state_reset(priv, skb);
-			break;
-		case STATE_INIT:
-			ret = process_state_init(priv, skb);
-			break;
-		case STATE_SET_REF_CLOCK:
-			ret = process_state_set_ref_clock(priv, skb);
-			break;
-		case STATE_SET_HI_CONFIG:
-			ret = process_state_set_hi_config(priv, skb);
-			break;
-		case STATE_OPEN_LC:
-			ret = process_state_open_lc(priv, skb);
-			break;
-		case STATE_FW_DNLD:
-			ret = process_state_fw_dnld(priv, skb);
-			break;
-		case STATE_CLOSE_LC:
-			ret = process_state_close_lc(priv, skb);
-			break;
-		case STATE_BOOT:
-			ret = process_state_boot(priv, skb);
-			break;
-		default:
-			ret = -EFAULT;
-		}
+	skb = skb_dequeue(&fw_dnld->rx_q);
+	if (!skb)
+		return;
 
-		kfree_skb(skb);
+	nfc_send_to_raw_sock(priv->ndev->nfc_dev, skb,
+			     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
+	switch (fw_dnld->state) {
+	case STATE_RESET:
+		ret = process_state_reset(priv, skb);
+		break;
+	case STATE_INIT:
+		ret = process_state_init(priv, skb);
+		break;
+	case STATE_SET_REF_CLOCK:
+		ret = process_state_set_ref_clock(priv, skb);
+		break;
+	case STATE_SET_HI_CONFIG:
+		ret = process_state_set_hi_config(priv, skb);
+		break;
+	case STATE_OPEN_LC:
+		ret = process_state_open_lc(priv, skb);
+		break;
+	case STATE_FW_DNLD:
+		ret = process_state_fw_dnld(priv, skb);
+		break;
+	case STATE_CLOSE_LC:
+		ret = process_state_close_lc(priv, skb);
+		break;
+	case STATE_BOOT:
+		ret = process_state_boot(priv, skb);
+		break;
+	default:
+		ret = -EFAULT;
+	}
 
-		if (ret != 0) {
-			nfc_err(priv->dev, "FW loading error");
-			fw_dnld_over(priv, ret);
-			break;
-		}
+	kfree_skb(skb);
+
+	if (ret) {
+		nfc_err(priv->dev, "FW loading error");
+		fw_dnld_over(priv, ret);
 	}
+
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	if (!fw_dnld->stopping && !fw_dnld->starting && fw_dnld->active &&
+	    !skb_queue_empty(&fw_dnld->rx_q))
+		queue_work(fw_dnld->rx_wq, &fw_dnld->rx_work);
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
 }
 
 int nfcmrvl_fw_dnld_init(struct nfcmrvl_private *priv)
 {
 	char name[32];
 
+	spin_lock_init(&priv->fw_dnld.rx_lock);
+	init_waitqueue_head(&priv->fw_dnld.rx_wait);
 	INIT_WORK(&priv->fw_dnld.rx_work, fw_dnld_rx_work);
+	INIT_WORK(&priv->fw_dnld.timeout_work, fw_dnld_timeout_work);
+	timer_setup(&priv->fw_dnld.timer, fw_dnld_timeout, 0);
 	snprintf(name, sizeof(name), "%s_nfcmrvl_fw_dnld_rx_wq",
 		 dev_name(&priv->ndev->nfc_dev->dev));
 	priv->fw_dnld.rx_wq = create_singlethread_workqueue(name);
@@ -462,26 +518,64 @@ int nfcmrvl_fw_dnld_init(struct nfcmrvl_private *priv)
 
 void nfcmrvl_fw_dnld_deinit(struct nfcmrvl_private *priv)
 {
+	nfcmrvl_fw_dnld_abort(priv);
 	destroy_workqueue(priv->fw_dnld.rx_wq);
 }
 
 void nfcmrvl_fw_dnld_recv_frame(struct nfcmrvl_private *priv,
 				struct sk_buff *skb)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->fw_dnld.rx_lock, flags);
+	if (priv->fw_dnld.stopping || !priv->fw_dnld.active) {
+		spin_unlock_irqrestore(&priv->fw_dnld.rx_lock, flags);
+		kfree_skb(skb);
+		return;
+	}
+	priv->fw_dnld.rx_active++;
+	spin_unlock_irqrestore(&priv->fw_dnld.rx_lock, flags);
+
 	/* Discard command timer */
-	if (timer_pending(&priv->ndev->cmd_timer))
-		timer_delete_sync(&priv->ndev->cmd_timer);
+	timer_delete_sync(&priv->ndev->cmd_timer);
 
 	/* Allow next command */
 	atomic_set(&priv->ndev->cmd_cnt, 1);
 
-	/* Queue and trigger rx work */
-	skb_queue_tail(&priv->fw_dnld.rx_q, skb);
-	queue_work(priv->fw_dnld.rx_wq, &priv->fw_dnld.rx_work);
+	spin_lock_irqsave(&priv->fw_dnld.rx_lock, flags);
+	if (!priv->fw_dnld.stopping && priv->fw_dnld.active) {
+		/* Queue the frame, but do not process it during the reset pulse. */
+		skb_queue_tail(&priv->fw_dnld.rx_q, skb);
+		if (!priv->fw_dnld.starting)
+			queue_work(priv->fw_dnld.rx_wq,
+				   &priv->fw_dnld.rx_work);
+		skb = NULL;
+	}
+	priv->fw_dnld.rx_active--;
+	if (!priv->fw_dnld.rx_active &&
+	    (priv->fw_dnld.stopping || !priv->fw_dnld.active))
+		wake_up_all(&priv->fw_dnld.rx_wait);
+	spin_unlock_irqrestore(&priv->fw_dnld.rx_lock, flags);
+	kfree_skb(skb);
 }
 
 void nfcmrvl_fw_dnld_abort(struct nfcmrvl_private *priv)
 {
+	struct nfcmrvl_fw_dnld *fw_dnld = &priv->fw_dnld;
+	unsigned long flags;
+
+	device_lock(&priv->ndev->nfc_dev->dev);
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	fw_dnld->stopping = true;
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+	device_unlock(&priv->ndev->nfc_dev->dev);
+
+	wait_event(fw_dnld->rx_wait, !READ_ONCE(fw_dnld->rx_active));
+	timer_shutdown_sync(&fw_dnld->timer);
+	cancel_work_sync(&fw_dnld->rx_work);
+	cancel_work_sync(&fw_dnld->timeout_work);
+	skb_queue_purge(&fw_dnld->rx_q);
+
 	fw_dnld_over(priv, -EHOSTDOWN);
 }
 
@@ -489,6 +583,7 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 {
 	struct nfcmrvl_private *priv = nci_get_drvdata(ndev);
 	struct nfcmrvl_fw_dnld *fw_dnld = &priv->fw_dnld;
+	unsigned long flags;
 	int res;
 
 	if (!priv->support_fw_dnld)
@@ -497,6 +592,14 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 	if (!firmware_name || !firmware_name[0])
 		return -EINVAL;
 
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	if (fw_dnld->stopping || fw_dnld->active || fw_dnld->completing) {
+		res = fw_dnld->stopping ? -ENODEV : -EBUSY;
+		spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+		return res;
+	}
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+
 	strscpy(fw_dnld->name, firmware_name);
 
 	/*
@@ -520,6 +623,7 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 			firmware_name, fw_dnld->header->magic,
 			fw_dnld->header->phy);
 		release_firmware(fw_dnld->fw);
+		fw_dnld->fw = NULL;
 		fw_dnld->header = NULL;
 		return -EINVAL;
 	}
@@ -532,11 +636,6 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 		fw_dnld->binary_config = &fw_dnld->header->firmware;
 	}
 
-	/* Configure a timer for timeout */
-	timer_setup(&priv->fw_dnld.timer, fw_dnld_timeout, 0);
-	mod_timer(&priv->fw_dnld.timer,
-		  jiffies + msecs_to_jiffies(FW_DNLD_TIMEOUT));
-
 	/* Ronfigure HI to be sure that it is the bootrom values */
 	priv->if_ops->nci_update_config(priv,
 					&fw_dnld->header->bootrom.config);
@@ -546,8 +645,24 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
 
 	/* First, reset the chip */
 	priv->fw_dnld.state = STATE_RESET;
+
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	fw_dnld->active = true;
+	fw_dnld->starting = true;
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+
 	nfcmrvl_chip_reset(priv);
 
+	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
+	fw_dnld->starting = false;
+	if (fw_dnld->active) {
+		mod_timer(&fw_dnld->timer,
+			  jiffies + msecs_to_jiffies(FW_DNLD_TIMEOUT));
+		if (!skb_queue_empty(&fw_dnld->rx_q))
+			queue_work(fw_dnld->rx_wq, &fw_dnld->rx_work);
+	}
+	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
+
 	/* Now wait for CORE_RESET_NTF or timeout */
 
 	return 0;
diff --git a/drivers/nfc/nfcmrvl/fw_dnld.h b/drivers/nfc/nfcmrvl/fw_dnld.h
index 7c4d91b01..a8ed7bfcc 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.h
+++ b/drivers/nfc/nfcmrvl/fw_dnld.h
@@ -8,6 +8,8 @@
 #ifndef __NFCMRVL_FW_DNLD_H__
 #define __NFCMRVL_FW_DNLD_H__
 
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 
 #define NFCMRVL_FW_MAGIC		0x88888888
@@ -72,7 +74,16 @@ struct nfcmrvl_fw_dnld {
 
 	struct workqueue_struct	*rx_wq;
 	struct work_struct rx_work;
+	struct work_struct timeout_work;
 	struct sk_buff_head rx_q;
+	/* Protects stopping, starting, active, completing, and rx_active. */
+	spinlock_t rx_lock;
+	wait_queue_head_t rx_wait;
+	unsigned int rx_active;
+	bool stopping;
+	bool starting;
+	bool active;
+	bool completing;
 
 	struct timer_list timer;
 };
diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 81c760534..02ea3356b 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -185,13 +185,12 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
 {
 	struct nci_dev *ndev = priv->ndev;
 
+	nfcmrvl_fw_dnld_abort(priv);
 	nci_unregister_device(ndev);
+
 	if (priv->if_ops->nci_quiesce)
 		priv->if_ops->nci_quiesce(priv);
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
-		nfcmrvl_fw_dnld_abort(priv);
-
 	nfcmrvl_fw_dnld_deinit(priv);
 
 	nci_free_device(ndev);
-- 
2.54.0

