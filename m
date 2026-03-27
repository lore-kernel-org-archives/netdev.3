Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E139DBC4
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774647287; cv=none; b=mbduLtH6NQYA+sJtvnLto4Vj1a9Yen3/SIOwwdvcH2S0IAIO3vldMlXKwiEKeO6RfyeyR5tnJVIza7H+jDOHCvSaVMhzIzOc/+EtKJ4y3M8L4o+KeoAUwHbZkkWLwqe1GuAjKPvSfpM6toVy70h3tg90GCTdSOXrLeskX6vF6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774647287; c=relaxed/simple;
	bh=5nR1ngLxmMq8UEuESNVUn29LOUuMj/vfTLBP5VqIjak=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jYDjr+lnFeARctbrIM6E9M9fRWVjooxPuAHr8r9lgci1Odl9slRbttFw58fVI+yNYTGsnMCqmiYoVCwjaN6XwFDby86CijenRIlHXsSJCRjUIFLUqf3GLJFw4e8MyeLmQqS11fOYPorMNRECPnirbU8NhPqxH3c3JzCCXFJwKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H98b1hfX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H98b1hfX"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so2407699a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774647285; x=1775252085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bPuS/pWZaNCqWvWNSrB3xY4cOu7IqsnNqUHAgUKc9/s=;
        b=H98b1hfXjqMhzCOsXjDjlulez6gkzKu759NQktI2iorQFgYUq7GnbsMFj4gCNV45u1
         /irJW/zS/Oe09T4dA6x9m4vWUwK30ZddaCNn7P+rfiz9ZcUa/AzSqTsJ1zJ1vdxp5xnB
         GVS/w7AlLbCW7cRmJflIs6yQ7E43HDQfksGfCvLYzReM55sktkhA3rGJ9HjiatnSYFMF
         qeup2DQSpxgBalJTOzFfQaxa3TN5jxphhdVOhHkLPTqJg2hw2MklkFXaZZF2/K2v+83H
         ApFiEPIrV36xD18JSaO5fJrHfGO9FvwBAyWoS3XdPOZnuCTsS2cuIH2qm404r0lNhOjL
         nXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774647285; x=1775252085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPuS/pWZaNCqWvWNSrB3xY4cOu7IqsnNqUHAgUKc9/s=;
        b=NmqtO0xpNrc7YELvb93Jh9E17YX8hb90+HKsPf/KmZZNFmrtgZIxAZCDvm0tvrmGLW
         JvkdfqiwMqno+DVbuMZiMxq1fHBwJR/3ncKe9GpizlJT4aUCBi5dP2lUSRoYBSZogb3G
         mrkw81U61fg096NIZRTRgKph7afYzjydabHL5tc2MHrMDMFrR8j5ZcnpfLBYhqTAn0TA
         5jZ7vwISPZ96UJ0aD/cVLUzXGX2fluePqB3hE8NHtV+/K5ysvj1/EfqR9BAfRxs9l7Yf
         jmW4lU1kt+BeYzFXal/ngiEHdqdahGyJ24eEs9xZ954YdtFowMmoofrhX6Sw6oaz1rCK
         UH9w==
X-Forwarded-Encrypted: i=1; AJvYcCV0u2ktGA3BYQoFZaDeXfIOfAm9kVTPS6QVVC2b5BkXJLFh6t5oS/l8LOqIc28OtIgLPEDg2Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvhaaTYMYW5jrr4qnf/C6/iefzZ0k/n0+XhHAkRkhpmdceGF5S
	xIsrXkDNqpDo1skjE9ZNv3vETd6Or1xUSo5SyiI+tddrZaGqCQe7Xj9K0k+UwnF90RVpuAKnTDn
	Tg0VQgw==
X-Received: from pgao5.prod.google.com ([2002:a63:4105:0:b0:c73:fc44:8bb5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d06:b0:39b:8368:d3b3
 with SMTP id adf61e73a8af0-39c7321665emr6871365637.0.1774647284492; Fri, 27
 Mar 2026 14:34:44 -0700 (PDT)
Date: Fri, 27 Mar 2026 21:34:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327213441.3781433-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dev->type could be any value on tun due to TUNSETLINK.

Let's not warn about it in netdev_lock_pos().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/tun.c      |  2 +-
 include/linux/if_tun.h | 12 ++++++++++++
 net/core/dev.c         | 22 +++++++++++++---------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c492fda6fc15..48194e567656 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2338,7 +2338,7 @@ static int tun_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	return -EMSGSIZE;
 }
 
-static struct rtnl_link_ops tun_link_ops __read_mostly = {
+struct rtnl_link_ops tun_link_ops __read_mostly = {
 	.kind		= DRV_NAME,
 	.priv_size	= sizeof(struct tun_struct),
 	.setup		= tun_setup,
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 80166eb62f41..89d9b7b0a044 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -20,6 +20,13 @@ struct tun_msg_ctl {
 };
 
 #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
+extern struct rtnl_link_ops tun_link_ops;
+
+static inline bool netdev_is_tun(const struct net_device *dev)
+{
+	return dev->rtnl_link_ops == &tun_link_ops;
+}
+
 struct socket *tun_get_socket(struct file *);
 struct ptr_ring *tun_get_tx_ring(struct file *file);
 
@@ -45,6 +52,11 @@ void tun_ptr_free(void *ptr);
 struct file;
 struct socket;
 
+static inline bool netdev_is_tun(const struct net_device *dev)
+{
+	return false;
+}
+
 static inline struct socket *tun_get_socket(struct file *f)
 {
 	return ERR_PTR(-EINVAL);
diff --git a/net/core/dev.c b/net/core/dev.c
index 200d44883fc1..bd91e0a3dbdf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -89,6 +89,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/if_ether.h>
+#include <linux/if_tun.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -526,24 +527,27 @@ static const char *const netdev_lock_name[] = {
 static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lock_type)];
 static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lock_type)];
 
-static inline unsigned short netdev_lock_pos(unsigned short dev_type)
+static inline unsigned short netdev_lock_pos(const struct net_device *dev)
 {
+	unsigned short dev_type = dev->type;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(netdev_lock_type); i++)
 		if (netdev_lock_type[i] == dev_type)
 			return i;
+
 	/* the last key is used by default */
-	WARN_ONCE(1, "netdev_lock_pos() could not find dev_type=%u\n", dev_type);
+	WARN_ONCE(!netdev_is_tun(dev),
+		  "netdev_lock_pos() could not find dev_type=%u\n", dev_type);
 	return ARRAY_SIZE(netdev_lock_type) - 1;
 }
 
-static inline void netdev_set_xmit_lockdep_class(spinlock_t *lock,
-						 unsigned short dev_type)
+static inline void netdev_set_xmit_lockdep_class(const struct net_device *dev,
+						 spinlock_t *lock)
 {
 	int i;
 
-	i = netdev_lock_pos(dev_type);
+	i = netdev_lock_pos(dev);
 	lockdep_set_class_and_name(lock, &netdev_xmit_lock_key[i],
 				   netdev_lock_name[i]);
 }
@@ -552,14 +556,14 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 {
 	int i;
 
-	i = netdev_lock_pos(dev->type);
+	i = netdev_lock_pos(dev);
 	lockdep_set_class_and_name(&dev->addr_list_lock,
 				   &netdev_addr_lock_key[i],
 				   netdev_lock_name[i]);
 }
 #else
-static inline void netdev_set_xmit_lockdep_class(spinlock_t *lock,
-						 unsigned short dev_type)
+static inline void netdev_set_xmit_lockdep_class(const struct net_device *dev,
+						 spinlock_t *lock)
 {
 }
 
@@ -11210,7 +11214,7 @@ static void netdev_init_one_queue(struct net_device *dev,
 {
 	/* Initialize queue lock */
 	spin_lock_init(&queue->_xmit_lock);
-	netdev_set_xmit_lockdep_class(&queue->_xmit_lock, dev->type);
+	netdev_set_xmit_lockdep_class(dev, &queue->_xmit_lock);
 	queue->xmit_lock_owner = -1;
 	netdev_queue_numa_node_write(queue, NUMA_NO_NODE);
 	queue->dev = dev;
-- 
2.53.0.1018.g2bb0e51243-goog

