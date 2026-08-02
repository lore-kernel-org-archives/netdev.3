Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ADD38CFF8
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672371; cv=none; b=hngWTDF5bQ0VDHhisarR1RoiUfaZ5oOzi5tZIjYa/FFY0dzT8iV7YM0QUekApFYyJsHa1HrlyP/S12XOxpbBNwNX0kg1MbR1Yf9hGVpwRwm8u1Ebwa8F/BhtMSgRTGKNMRDxH/00nHm7kVR+rcSuskBMO9w2i8KRWnCARCpHKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672371; c=relaxed/simple;
	bh=ja9SEZY37py2LPC3UCzbojlbnwIXzxtJJQ0uGcIg/sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THz8Oq/1oGqFmc1GJ1vqdbiHB3YsA/jOJsYSZlsQPNDyyvzaQ5O0VKNvJaZRwsUHvAdAuzgvLSzHeS4ro39ooa7HJWJktETsXzviLmNkWbLujs3JfXe4sWQIMjlRmMI4wtjJC5+BFBye6kkSaAMtX804tY+6EKkGVWDLqFZllZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=dgpKf/1V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="dgpKf/1V"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f6de72faso7875755e9.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785672366; x=1786277166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YmI7MBDeloKectxU/BNiRN1jB4jCnA25xpecmEwYe0k=;
        b=dgpKf/1VX/V/XUhdm6FM3HK3/hMzv9nsCRIOy6R61ouRFAXv02jm+AyOcOJu87XgPd
         RpEixcxwjNs1eXFeMGUrHULio5bx7oNjwj0Vv8ut8kRDoDusqtrl7DTE3sbMNEKGzl6s
         T6d9CBEcGP2HoR/8Ov66/12Uu0hrIKHKDRmZEBPLng4QSi4Hr5CeXgK4kIzHOl9Vjm6P
         odcqZsrzPB6DzUWg2y+GN44ChXwp8eU5gXndFY7tZ/AI1PiaM9c+u+L+b2KlSJHoU7Va
         bXKpvLiovV5TWbh0E/YyvyzVXKDuOV/JquH/2ijGvuYDeMq8wRuWYjbCNmccWh5kyBla
         Ev9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785672366; x=1786277166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmI7MBDeloKectxU/BNiRN1jB4jCnA25xpecmEwYe0k=;
        b=CQ4EEVF9NyXsOoxU1cp0rA2gco9hMZw6MkRtt6q7MEDD72oxdcLdvJ4OqZYU+EhJkn
         JYslDgpSkeIzNVzkmbGtsfVN93xTwsV0njqz+MVYa0FnUJi/N4CzDR4ytLfgh9Co+y6A
         NJdAfvOUa7OMh27S+TT5ml1SiFTR3J7aWkQdCRb7NNlGg2f2uSzAPwKSfsPwu/KHFlOX
         4LRkiXJB0hyZys+4NI2IHz0SXtvD+m3J28Mon06a0OP+6M+OF6+9N4x0KbJr1Z/rs0Yx
         Wt+87fqrkztw3hj6MY52P5YEajl1OrUY6qMmj0nS3enjGeaYTqpiWk4RlgPCwoM29I1q
         ru2A==
X-Forwarded-Encrypted: i=1; AHgh+RoJCZP654t0horzInjRB0QwhP5RFNl4iP7aZo2BpVbObw3xfV8ZovlESqtYdX7Rl64iu3ZtDZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXK2KIzx+/8fUWV5NAAmpdjM13JQZ+jRjd/zbwTmWshDjesmdw
	oiM1fIs+6ICy7w7alAI2t1lSYQkRdQSjz/swNyuyZWo2iti74rGlCPXFaMgdiovdyb9o
X-Gm-Gg: AR+sD12R/ESjiXO0/EGPUmwBX6qopDbHGgJYmEONJjjynhuR+T+7ylgHCub5++Q3jZZ
	Kv+/48dUo1bfpMCj0zNv5K+JLUn3NF9C8vITNgvV4dbQu8NvVMMR2D3qViMp6olNG25CV1eeVmW
	2LDSB7UxwckJr7gLqBzxjhXppDWNgWxgNJ5Pon08bEcQR9j/7CtoD8C6gJa28yN8hYC9NLRzMDk
	ZpX9ozDoTZEbKAE/v37nXYACB4FgQ0BrunD6NwP/z6NvruCtw4g6v7hU9k3ZXJhmrdnSfnJoILF
	3DL7q7A92WNtMV0BJihRJGgZ50KetrK4/DZNKPLHvWnJxbOaPF4vRFdaOjv1lsujt7gBmN7GVpN
	/SXwXu1fsI2EMVomMKTVwrqDPVkMQKhLeaRFBin1wS8BA4+rDoESUiIOSfx7O97J6rODlDfNVmG
	BvCjpj9EZc/BUdGeqamjDOI0INwa8sTCOkJG2Ht5oEZ5p2+aSRvTaaK5S7yM3WXe27JoALz3YK+
	x/TZACwUsbju4HFFUin7xLLmq+hYriXHfvczM85JMwy0fNflMT6AHvOpkT6CIdlXjNgsEeqYQGs
	vxKBNGiDhl+/l+prTA==
X-Received: by 2002:a05:600c:1f8f:b0:493:f478:4c71 with SMTP id 5b1f17b1804b1-4980eba0817mr106984535e9.7.1785672365325;
        Sun, 02 Aug 2026 05:06:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm175226825e9.3.2026.08.02.05.06.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 05:06:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: agk@godking.net,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: usb: ipheth: fix carrier_work UAF on disconnect
Date: Sun,  2 Aug 2026 14:06:02 +0200
Message-ID: <20260802120602.42595-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipheth_sndbulk_callback() re-arms the carrier-check work on any
non-zero URB status:

	else
		schedule_delayed_work(&dev->carrier_work, 0);

Nothing ties that to the interface being up, so the work can be armed
again after ipheth_close() has already drained it, and stay armed
until the netdev whose private area embeds it is freed.

On unplug with a TX URB in flight, ipheth_disconnect() drains the work
through unregister_netdev() -> ipheth_close() ->
cancel_delayed_work_sync() and only then calls ipheth_kill_urbs().
usb_kill_urb() completes the in-flight TX URB with -ENOENT, so
ipheth_sndbulk_callback() runs after the drain and re-arms
carrier_work.

The same completion also re-arms the work if the interface is only
brought down while a TX URB is in flight, and
ipheth_carrier_check_work() then keeps re-queueing itself once a
second. unregister_netdev() does not call ipheth_close() for an
already-down interface, so nothing drains it on the later unplug
either.

In both cases free_netdev() frees the netdev while carrier_work is
still pending, and ipheth_carrier_check_work() dereferences freed
memory.

Tie the work to the interface state instead of chasing the completion:
disable it in ipheth_close() and enable it in ipheth_open(), so a
schedule_delayed_work() from the URB completion is a no-op whenever
the interface is not up. disable_delayed_work_sync() also waits for a
running instance, so it fully replaces the cancel_delayed_work_sync()
it takes the place of. The work starts out disabled in ipheth_probe()
so the enable/disable counts balance from the first open.

Reproduced under KASAN on linux-next (next-20260731) with dummy_hcd and
raw-gadget standing in for the device, driving the second path above (the
interface is already down, so unregister_netdev() does not call
ipheth_close()): 15 of 15 unpatched boots report a slab-use-after-free in
__run_timers(), freed by ipheth_disconnect() and re-armed from
ipheth_sndbulk_callback() via queue_delayed_work_on(). The
same trigger on a kernel differing only by this patch reports 0 of 15,
and the carrier check still functions across open/close cycles.

The reproducer needs an attached USB device that stops draining bulk OUT,
plus a link down and unplug, driven as root. It is not a privilege
boundary crossing and no exploit primitive was developed.

Found by 0sec (https://0sec.ai).

Fixes: bb1b40c7cb86 ("usbnet: ipheth: prevent TX queue timeouts when device not ready")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
 - Fix this at the scheduling site as Jakub suggested, instead of
   adding a second cancel_delayed_work_sync() to ipheth_disconnect().
 - Took the disable/enable option rather than a netif_running() test.
   The test would sit in ipheth_sndbulk_callback(), which can observe
   __LINK_STATE_START still set and then queue the work after the
   cancel_delayed_work_sync() in ipheth_close() has already returned.
   Disabling the work closes that window.
 - Now runtime-reproduced: 15/15 unpatched boots splat under KASAN,
   0/15 with this patch (x86_64, W=1, no new warnings). v1 and the
   earlier v2 draft said compile-tested only; that is no longer true.
   KASAN was confirmed live on both kernels via KUNIT before trusting
   the negative, and the two kernels differ only by this patch.
 - v1: https://lore.kernel.org/netdev/20260724134250.34360-1-doruk@0sec.ai/

Note for stable: disable_delayed_work_sync() and enable_delayed_work()
first appeared in v6.10 (86898fa6b8cd "workqueue: Implement disable/enable
for (delayed) work items"), so 6.6 and older trees need a different
backport.

 drivers/net/usb/ipheth.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index bb1364f85bd1f..2b490114d2327 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -490,6 +490,7 @@ static int ipheth_open(struct net_device *net)
 	if (retval)
 		return retval;
 
+	enable_delayed_work(&dev->carrier_work);
 	schedule_delayed_work(&dev->carrier_work, IPHETH_CARRIER_CHECK_TIMEOUT);
 	return retval;
 }
@@ -499,7 +500,11 @@ static int ipheth_close(struct net_device *net)
 	struct ipheth_device *dev = netdev_priv(net);
 
 	netif_stop_queue(net);
-	cancel_delayed_work_sync(&dev->carrier_work);
+	/* A TX URB can still complete with an error after this point and
+	 * try to re-arm the carrier work. Disable it instead of cancelling
+	 * it, so that such a schedule_delayed_work() is a no-op.
+	 */
+	disable_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
@@ -629,6 +634,10 @@ static int ipheth_probe(struct usb_interface *intf,
 	}
 
 	INIT_DELAYED_WORK(&dev->carrier_work, ipheth_carrier_check_work);
+	/* Armed only between ipheth_open() and ipheth_close(). Start out
+	 * disabled so the enable/disable counts balance from the first open.
+	 */
+	disable_delayed_work(&dev->carrier_work);
 
 	retval = ipheth_alloc_urbs(dev);
 	if (retval) {
-- 
2.43.0

