Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B65359A90
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288523; cv=none; b=sGJfHupPSAylihCWJOA67y0kWCII1mZz/5sk/tcTqNVtoo27lbaRuTwlbShGcmmLwljh0HdN8YOipVokvEH/eoYdgQ4Fyf9D31Gl+4Wa+SBJCg7b57YkCLHOxNnxGqYzOKpW9uBLS8uaICran9ZlQIwGvEhJqP0d9jdBTVDKqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288523; c=relaxed/simple;
	bh=3S1ODil890UZ3AlrML5DJqdlWzXaY3QURyOr/71QQd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFN7K+6rYAj4zIbFj5DL7K8vZWzJpMnNvQb1hzMpHfye9yPxkximturwYQBkfjWkDjYGDTTiITyHKUE8TCTy9KklvT8hD6P2DogRvPggZmSRt9tWANI0sJiQxKZiTyZRXpYUVgdaLQi5SDutqCq0ZS3erYE6xb0VHJlqjcII0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSfd4XNq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSfd4XNq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a17b4c6133so5544455e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791288520; x=1791893320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=je8cwPxHIss8SyidCLgD3aHQ+Cf/hSNGW28mAiVpfKY=;
        b=GSfd4XNqNyjiONUlHTtXWbR1XqwM/jOVdBPat1RoYDkLSbj5l0AkgO1g0hO7Rn6Ol/
         +xqOi4efd+/lxHBY8ijfSbbw1vE+pMSduBAoJu0g8DYPbuFBCVUBrnDoDtcB9ToQIngX
         S5EpRyQO/XXU0kyJN9lfbycQM1KStiigT/XA2KyKX9J4lZsEBcmV9kB0e1s+Umst8i9q
         J6m4S2tNidQ3ko5qdOsJL16FYy16K4g1Fx7+GAvC5bJa60kEoclYCGE6uwrpUl2M8PCj
         AHNpR71azcHXfFw3kRZ91zdrddVtq7TOi/gyPawoMi14GT9H9G0LEC4cQT2cQvgJLlwM
         G7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791288520; x=1791893320;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=je8cwPxHIss8SyidCLgD3aHQ+Cf/hSNGW28mAiVpfKY=;
        b=Sbn61QdBr4qsqshwOqk+OiS9mTNhyHbVlKpwh3pGCiX86bBJuNVgFWI0K4Hhzmulwh
         Je/2NefMNdZAla7+mvJ8oHTdwGipaZifkMDv384u/71bpxNzprTPUsE7BYcsqLzJngQs
         Rs0oeZ2XS3fkkwV6+nxyWqIB4GmkP5bqW9tiVLLgV9Sq6c22EiMatU98bmP3xaPybZnj
         lvNL6FpR1zT9D8g6RV1ps1F6xnV6SY7GyWNcTCQR4wk6/K5BCsVMsl1+ubo+SExq6H5H
         WmAgE9at9OhYjRYt9ZkkWjcOlAfFv8R+lAVdWWS5Jg79ZliXL4XoR8eZTf3yo/wBTjkS
         0Udw==
X-Gm-Message-State: AFuF++nxgHwKlc6peUyDi0IHpZraRHFby0zVa+MNH5q5dKZ4K/OzmfIE
	bWVCBDIfeK8xoZ27ia0yZzB4LSxRjel+zClX5HNVn7raG43uZBk+LbOxt/LTqqWi
X-Gm-Gg: AYBFou3EFx5A9Srr6TSyOqyQfjdwsDfyf/czVV8mEv4iVSTlr4f12n79jiMhgHyxWfO
	dKJxQPgkyEO90kyrvGH+J/368iwfJn1Q6r4RJEfXr0UIX/7nzXVoNt438Qmt3lLcDmVqQ+RMHwn
	jYqDaYhgCAvPCIqQt0iPVPa6SIHfo9BZaYO49qfbiga0kACK7UTq6fdfloqiAL1fJSf8Ev9ORXw
	SrmizIXeiSM7ODS/4L7Otx+xoKSLbiJ7q0pB00tJkR9vAV2Lml4gdc8nA7eJCeSY+aR9yfq/ZSd
	if/tKwAjRxEGnnjaMKA9g8jtk1wlUiKMZpe3ZMpumWLx/Sw/Cw4Kf/eDG+ZMXpRpzTDUEbV9OFz
	zTTglnsTCwN1BYgxmkg1j6S7qn3ejTYUBlLcWnrTBTgjFn7LxowwdANqfGUCk8ZLs9zSZrcVlqf
	k6+5M8fm/u+gLnL1F6sZrSMScK12tzuFtl2pF52ZNwxHRdBDFfhgsLRzhaqfx0zySczQ2X
X-Received: by 2002:a05:600c:c16f:b0:4a1:65d2:7912 with SMTP id 5b1f17b1804b1-4a17b527aebmr19859395e9.8.1791288519978;
        Tue, 06 Oct 2026 05:08:39 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394c937csm246918505e9.1.2026.10.06.05.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:08:39 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: netdev@vger.kernel.org
Cc: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net v2] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
Date: Tue,  6 Oct 2026 15:07:04 +0300
Message-ID: <20261006120825.342164-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbnet_resume_rx() disables local BHs before clearing EVENT_RX_PAUSED,
but this does not synchronize with usbnet_skb_return() running on
another CPU. On SMP, usbnet_skb_return() on CPU0 can pass the test_bit()
check while CPU1 runs usbnet_resume_rx(), clears the flag and drains the
queue, leaving the skb stranded in rxq_pause until the next MTU change
or device stop.

Fix with a double-check pattern: move clear_bit() in usbnet_resume_rx()
under rxq_pause.lock; in usbnet_skb_return() take the lock and recheck
the flag only on the slow path (unlikely paused), keeping the normal RX
fast path lock-free.

Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>

---
v2: Squash usbnet_resume_rx() fix into same patch; previous version
    only changed usbnet_skb_return() and was missing the clear_bit()
    change.

 drivers/net/usb/usbnet.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 84f97f448b2d..5eba2cef8bac 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -329,9 +329,14 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 	unsigned long flags;
 	int	status;

-	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
-		skb_queue_tail(&dev->rxq_pause, skb);
-		return;
+	if (unlikely(test_bit(EVENT_RX_PAUSED, &dev->flags))) {
+		spin_lock_bh(&dev->rxq_pause.lock);
+		if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
+			__skb_queue_tail(&dev->rxq_pause, skb);
+			spin_unlock_bh(&dev->rxq_pause.lock);
+			return;
+		}
+		spin_unlock_bh(&dev->rxq_pause.lock);
 	}

 	/* only update if unset to allow minidriver rx_fixup override */
@@ -701,8 +706,9 @@ void usbnet_resume_rx(struct usbnet *dev)
 	struct sk_buff *skb;
 	int num = 0;

-	local_bh_disable();
+	spin_lock_bh(&dev->rxq_pause.lock);
 	clear_bit(EVENT_RX_PAUSED, &dev->flags);
+	spin_unlock_bh(&dev->rxq_pause.lock);

 	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
 		usbnet_skb_return(dev, skb);
@@ -710,7 +716,6 @@ void usbnet_resume_rx(struct usbnet *dev)
 	}

 	queue_work(system_bh_wq, &dev->bh_work);
-	local_bh_enable();

 	netif_dbg(dev, rx_status, dev->net,
 		  "paused rx queue disabled, %d skbs requeued\n", num);
--
2.55.0

