Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67828030E
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984271; cv=none; b=p/np4PdsSOfA21Els98apqM5eRsaLln4bdjPFlZ5jm4B/IKAPTRWvFMaMk5Uzkcicblp9oWBhzVnuaii8P52iXQN4oDRazeOLMNf/ROWHf3ON8uNXsim4z+w19x7ncapFPUVoHWHZfTBSAxWUwg2Bwx4+DuE0r310Wvq/cVp/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984271; c=relaxed/simple;
	bh=IxviFxU7OWIzCfAKkK8ggiNhp2pfy50+vk9ncs6Gl3U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g4u+9L0jFjds8vwD1y8UimFxX3kA5aZ/OZEFH+em12qZQn+MC/Py4jX8vSrMgBO4Kbk1dEVJBX8WYA2oGXOP3C6QpuRzWP61yxN/gdKwrgadPRSaQj5hGRNS+XD6ILQ2yoAvzY0h1Oce2W4wtRQUziOeymzMQVvj0mpvAAu7/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dznRmOH4; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dznRmOH4"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb37db8b79so525613985a.3
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770984269; x=1771589069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yB7iEvX6JIyuNaN0OWmfbxYgNouhe+5T5B0xFTT77/w=;
        b=dznRmOH4FsTEHjwxTqr857l/J39NON58XL07+44W0BSCzjD5uh7ZoTypObxGdL7NEC
         JLCEtkdcJngBkrgfi7NnRSRzumcT2+6oe0RfFl1/auy3R2bR5ivEU/NquDFXMvnPZir/
         e0JOPutLGvttvC+c0KXIm7rr93IL/XUM/GXlR3C+AA9SUaVXwIP5RHgr+9BWlyr6zvco
         HMFIRtk9zAI0JUWCgaxUbAgLagdWHzA7OdGDV898DvPBbJDmkOgX4N91H5zbAObmm3LE
         U6ZmfV964UTpNYmmrJJ7F9Cdj8awu53mknt1e1vRiDW7Lq80sNlbHkwa1Aq6yIcqVyJ1
         6lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770984269; x=1771589069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yB7iEvX6JIyuNaN0OWmfbxYgNouhe+5T5B0xFTT77/w=;
        b=azJjfH8VcMXnvfwBOBN+T1IlUgPKYJJOimesOcIIEcymdc5Z6nKkU0QCPe4IR2hUFe
         Cm0Vyps0VeXoM6epLrM/zt5AturHsxpgapocvt3i4fh1/58wJFpP5PQIcShzxOEiEFCO
         iYzW6KuMcfTcFzhqY/7sAupEuO7Y8iM4/XTLE8QWi3ipWj9ZUuijaBez7GNGT2rpvNKy
         XFwwGLNYi4A8gzHlpX5I6SJh3JhBtP+Dipgm4bd6xnjOSSl62Xx9cZGHPX2zHZtpjG7k
         ex8dilB+Es9ti5qo+zDqjrWlb4mxPWDFNAjL6o2XLbl5VcPu1pMKjx5/Lr2xEQLi5JD0
         6zGw==
X-Forwarded-Encrypted: i=1; AJvYcCWe+9le2RfZnLHT6aIwd1BkTMXnANZfQFc2COxm5uzy6C7nYdI3V1Qk5LUQ0nAQqXwxP89i0VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HrI5POoCuBHhqtvpovZyNYy1fcpjtoseJdvggdv4WG6TMfSe
	yhKjsnGzqSQOaDgYII0+9WvZ3mwWIoyfl1qFc7RuvXTdFDOL6PpsChrI+oN9I1EkBHX79XjLqcX
	/fA/BckqCBtyoXA==
X-Received: from qktt10.prod.google.com ([2002:a05:620a:4a:b0:8c7:a37:5a4f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2807:b0:89f:8bb8:c103 with SMTP id af79cd13be357-8cb424219b6mr166951485a.49.1770984269020;
 Fri, 13 Feb 2026 04:04:29 -0800 (PST)
Date: Fri, 13 Feb 2026 12:04:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260213120427.2914544-1-edumazet@google.com>
Subject: [PATCH net] net: fix backlog_unlock_irq_restore() vs CONFIG_PREEMPT_RT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

CONFIG_PREEMPT_RT is special, make this clear in backlog_lock_irq_save()
and backlog_unlock_irq_restore().

The issue shows up with CONFIG_DEBUG_IRQFLAGS=y

raw_local_irq_restore() called with IRQs enabled
 WARNING: kernel/locking/irqflag-debug.c:10 at warn_bogus_irq_restore+0xc/0x20 kernel/locking/irqflag-debug.c:10, CPU#1: aoe_tx0/1321
Modules linked in:
CPU: 1 UID: 0 PID: 1321 Comm: aoe_tx0 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
 RIP: 0010:warn_bogus_irq_restore+0xc/0x20 kernel/locking/irqflag-debug.c:10
Call Trace:
 <TASK>
  backlog_unlock_irq_restore net/core/dev.c:253 [inline]
  enqueue_to_backlog+0x525/0xcf0 net/core/dev.c:5347
  netif_rx_internal+0x120/0x550 net/core/dev.c:5659
  __netif_rx+0xa9/0x110 net/core/dev.c:5679
  loopback_xmit+0x43a/0x660 drivers/net/loopback.c:90
  __netdev_start_xmit include/linux/netdevice.h:5275 [inline]
  netdev_start_xmit include/linux/netdevice.h:5284 [inline]
  xmit_one net/core/dev.c:3864 [inline]
  dev_hard_start_xmit+0x2df/0x830 net/core/dev.c:3880
  __dev_queue_xmit+0x16f4/0x3990 net/core/dev.c:4829
  dev_queue_xmit include/linux/netdevice.h:3384 [inline]

Fixes: 27a01c1969a5 ("net: fully inline backlog_unlock_irq_restore()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ac6bcb2a07840671b0910ab1d2a5b588feaeebf0..96f89eb797e891c75f7e9b467e27db7c1a6f92ae 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -231,10 +231,13 @@ static bool use_backlog_threads(void)
 static inline void backlog_lock_irq_save(struct softnet_data *sd,
 					 unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
-	else
+	} else {
 		local_irq_save(*flags);
+		if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
+			spin_lock(&sd->input_pkt_queue.lock);
+	}
 }
 
 static inline void backlog_lock_irq_disable(struct softnet_data *sd)
@@ -248,9 +251,13 @@ static inline void backlog_lock_irq_disable(struct softnet_data *sd)
 static inline void backlog_unlock_irq_restore(struct softnet_data *sd,
 					      unsigned long flags)
 {
-	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
-		spin_unlock(&sd->input_pkt_queue.lock);
-	local_irq_restore(flags);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, flags);
+	} else {
+		if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
+			spin_unlock(&sd->input_pkt_queue.lock);
+		local_irq_restore(flags);
+	}
 }
 
 static inline void backlog_unlock_irq_enable(struct softnet_data *sd)
-- 
2.53.0.310.g728cabbaf7-goog

