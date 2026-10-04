Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B697262E
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791153550; cv=none; b=KVuDp7YGe0OzvHt47bUMthCD1jhM4fogfUJHiYdT8x0K5/9CDzeVOQfuOb8OiHA5+nyJe03NUZLrAVcykBorEJ2L8bTw/2cQW7s0bIXjEyISrZ6E+qpZ+DYoXCwcGhBEVsb55CEuQJtB+9pIBBqEkdJCptyFy4fmPV+jHZimrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791153550; c=relaxed/simple;
	bh=kpfoFP85QxskQMWdeJTmn1cMu6N17HV/5+t0UmRxMyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XEGJZXyZmqm/hzPJCft3XBE9KtRTFwQa2+DIJP7snWEY1uiVwZHYd0bZhp7lzfOP9XQNBw+gfrp4T5BiEbWN1ODxZBcSxdjosgzG6Wa6z9e97I8yVKbB9GTw04YAbMHxjoLW67WPcvGT6h5XIZbulgp9XrHHRUs/V9OciUbjFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bThpFflN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bThpFflN"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49ff680331aso11718805e9.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791153547; x=1791758347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FCS9VK4fVIFomf4fJxIO0n4SeDZ0WR6fIeRqcF0W94c=;
        b=bThpFflN/QNVriZxgcZsBD/dXosCo9iDrB44FDnmAfJZAOxZ/ueNph+KJ3SQAVKyef
         k1d+qBLIV1iX8PCykD+LFjoIxSklEuI8CuFC7XusQt81y7ST/YhopJtl0U4p7DsM4wLl
         SOCNNCnEh1xWn89LFwmk5YDgFVrIRId17PUZ1WOT95/3jM2jJ+RinwTadEiODDbuFUSt
         9fkk3vsjI4o2dNlQCBtbimQOWK3QeVSkP/B7FMyVUrJQTtaYvamIuynwSTcckcirtGVv
         w+mArk7GalQ/ssiy/IMVA5vRoqOr7IIzh306lnHs9vT/CfIGqZzO7aeOMBEMZIm40qFc
         qIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791153547; x=1791758347;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FCS9VK4fVIFomf4fJxIO0n4SeDZ0WR6fIeRqcF0W94c=;
        b=ffHJ43Hnm5hWhmCW3VvMjl6xtQOjzgJWVASCdM1BNHWchF653lAX5z+s8DSUuqwvLT
         ih3j11Pn2viYg8Qz/kxh3ciGmOnhZPCvlI6aih6D+zqu45ffoibXrC3NppjpuPpeL3cg
         MvMbNUCe2QQ66qz4kZjWfzkqnF3JpxXbbD6XU5S1xUFXPwVwDdi7emduspq7SAYtVd3o
         1nYqij7YXfg6VGPYhllwTkrTvUiCv8EYLTrYxo4tjPsDw5Q4jbqqevp4IeSi3yFOsyqV
         o62UongWUeO7PBToCgkF6GVzZwDIzix36CtcPyt1LJ/4WhMz35NumSzvFYGdIhkU9KeQ
         yEzg==
X-Gm-Message-State: AFuF++mTZepcGY6U2dEJMfJDrznPZ0zXqMtqS1fnloOyQdYvubRp3UYY
	3JsP37HGFy0emilXNk4F7DZn+7jciJvBKo1iU6ZYEJoMxtaY+7byY7s7f91brkhLXVU=
X-Gm-Gg: AYBFou2f05v7uEjiZ2oOjvxykPk6+QkBraGY5t48EKQdrrN4pT5xBtFF5C5smORbwtZ
	TSpK4qKcZSUDZp4jyuw4EUeI6NgC59Yi7P02BWdIrB+WqEpwgvAv2pIArERbCy1vKlqiWkq01sI
	g9Zv+iUhLsfunVwreZCbndlLjGxA6K9X3Mb7oobI5ik4P+yvRcT4ju9QlbTY4g94kTp0oq+CLMc
	3g2o4gHzlvistru8Dq1Sfr0cQAEgdoLGqrUhW1PkafY60KLj4FgAmQAA9g946+cn1uXeFDg3RQk
	iM9B/wPvNWKa447QMDMNin5XB5urDtk0Y8VyU4IONR7PbL8TN41P9Fto5ifLlaGh7G9wfmS4le/
	5nAZfsb/A6FVOESJ+Hdq1GPXABsVNhmcDTHUu7BRnfG326xdyYMz5FvIUS1kl0bGPyXYULYFv0U
	S1rPDnp63/qXsHn1Rd92EQawsBePA54XFRF8LBK5Jn7vagV6ICojC7EztV0q3vAY924/nzkTL+h
	tvCvbQ=
X-Received: by 2002:a05:600c:154f:b0:4a1:714d:eed with SMTP id 5b1f17b1804b1-4a1714d1071mr31807835e9.14.1791153547399;
        Sun, 04 Oct 2026 15:39:07 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1698f7910sm97775755e9.3.2026.10.04.15.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 15:39:06 -0700 (PDT)
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
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
Date: Mon,  5 Oct 2026 01:37:24 +0300
Message-ID: <20261004223852.312487-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbnet_resume_rx() uses local_bh_disable() to synchronize with
usbnet_skb_return(), but local_bh_disable() only affects the local CPU.
On SMP, usbnet_skb_return() on CPU0 can pass the test_bit() check while
CPU1 runs usbnet_resume_rx(), clears the flag and drains the queue,
leaving the skb stranded in rxq_pause until the next MTU change or
device stop.

Fix with a double-check pattern under rxq_pause.lock: normal RX avoids
the lock via an unlocked test_bit() fast path; on the slow path the lock
is taken and the flag rechecked before enqueuing. Move clear_bit() in
usbnet_resume_rx() under the same lock to make the flag and queue
transitions atomic.

Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 drivers/net/usb/usbnet.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 0288d89e1d13..5eba2cef8bac 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -329,13 +329,15 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 	unsigned long flags;
 	int	status;

-	spin_lock_bh(&dev->rxq_pause.lock);
-	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
-		__skb_queue_tail(&dev->rxq_pause, skb);
+	if (unlikely(test_bit(EVENT_RX_PAUSED, &dev->flags))) {
+		spin_lock_bh(&dev->rxq_pause.lock);
+		if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
+			__skb_queue_tail(&dev->rxq_pause, skb);
+			spin_unlock_bh(&dev->rxq_pause.lock);
+			return;
+		}
 		spin_unlock_bh(&dev->rxq_pause.lock);
-		return;
 	}
-	spin_unlock_bh(&dev->rxq_pause.lock);

 	/* only update if unset to allow minidriver rx_fixup override */
 	if (skb->protocol == 0)
--
2.55.0

