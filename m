Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024732264A7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062186; cv=none; b=hK13L+yYdTQ8mpBDj2KPLvkadi0JbbuWsW+hUPLv/OOnJk1R8PgNdX8lVavT7iooDSIGrfp6pIt78sD7YpHLl0gCxisB+DgmzVfh+IWwKBk0qGwNjq7oi+K4V+0nK5qrLMC5+yfu5QcDZioJI9XP1LwHvLngU+07LJhqeWPDB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062186; c=relaxed/simple;
	bh=ufWNiZrM5rD2bQeziPTxz604KRHjCPJKUWZQnTymXPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2HIqVB725um9CiJsKYkDn4BG1iP9PYZZ4EzIU7vM6f1yQ+CHHkvc6T/Cun+ydpVc1BCDgku/A9MXJWzdcRb5bjRoOqb6GjAbTIJJm7sP5MK7oFd5J0G/bomYe6kuRwSUnvHZfE++ZA9f9A8VfSqiArKssbj1z1yPPNaYG3fRMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SYk5xz/p; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SYk5xz/p"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47de0093c42so2067711f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 17:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786062183; x=1786666983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XS9ofCOAzIcEnuqvpsiHDoEnabb9ar5ylHVJ/bxSzTA=;
        b=SYk5xz/pQnsk4QvlmO7bStQiFVr0AT8rqO1ifzVDO3hH/+Kp2jjX6LIq8MGtMF6T9s
         9I5J0gLzF0JZgur7w1cTq+fiB0d960DtxzFy76YnEzoOxTDAyHhiPe2wnm8N4LWUTcHt
         jd8QfbgqH3EPEUPryLk0vgXAuLDJJk5U1UWz0DF4xFqAWe4fvgkPHAghZtjzvvcrHTV2
         n4Jmy5QKrv0ELSP+sZ2U+/B8d6zsvqoySv5tECE7SiUmWkdqYV88sP7ovWGDADeGojiC
         ot81d+mNXJzkyeAVLuzx9NYbJoGTQw0O2GRUwAUkSz5j3bX75IDoztvjFUh0Btvga/yx
         Omvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062183; x=1786666983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XS9ofCOAzIcEnuqvpsiHDoEnabb9ar5ylHVJ/bxSzTA=;
        b=J1BAPuVcOdDdhKqFNg6noP6BvUYxFUFMF+cFWnte5OygFOO4zkvGvN8mikun486t8T
         7w+wYpv2VjBufC8k8t7CX7XaGl3cH4fN0aw0nP6/yZzfLvvg/PBT0qFz/v2JutNGwoQn
         wu59GSmZ0opd1AtCnWdy1XBRgw7qqJj+9moNJawBWjVp+H+QTZqXIPgFvNNHKKTOhN0N
         w5uz68k0PFg0U2TFBIvUdxNYa42PyWsZad4xVFAACy1xSh5etZ7bsaXew3/nw8WBBM+K
         e7R9apzOUCHlNShx1FQy0A9SQmZQOJlq7MBwMF0ghTlFlR6rviyrKH+cMbLaYAAAt3bY
         8R9g==
X-Gm-Message-State: AOJu0YwdxYSx/svBKbUPPstEUWTvoSJ+uHXhKa/jogQtOsRatkzvtOrH
	qbtyFIXsP6MaoB4dqcAl8c7DWVCQ/BjJNF7cqHTNJNr/eOSxicgrpR8wi4A+QTfzYvOSV/Z3n2p
	ezDNOvnTiC9J4qhx7fcGwOSLVMjjBDB03ONPTDIoErARaRT5mbzcfyeGlqOqQ9L6u
X-Gm-Gg: AR+sD13dw0oFOfPm452F9J7DlV9NylUU84pyL/owLz2n75vvkot2CVI+5+q1D+ZzVBW
	bikFkZ8Dox2lxFoj7tugaBOa86Zz66ENrbTlErKPy/Bp+TDhv+y+qzh6RkFsN6Cw2jhxP2fZ11c
	N4M1pnZovL9jdOTcEjqFSnM8RDhrUQ+LEsDiit5gzm/6gZxXIANKmU5MOWuPJv9d9sJw92ayV1O
	mAWJqgjlkvPihZO5idukHAvkTmOtQ0htfB2wyoefwAjay2yc09z1140dKprKbB/8Qer0iyI7VCy
	2N04UokaK1GzHGMOZIBmDKm/MhjHlPXNCoDRcS6BC0hW2Vu0pzorUbY2wXjn8B/tPBsjXSIhoed
	PiwKG1T5DSlI+BqcqDmtIbHuJg3Wf70QPU/2VJq15p6jHPKPFydudayVm+TjJNN6R90ZOXktZPd
	99fcVZNMwmrAYkmv/kMTnJNvsHFrFx6UNUMBlK2Q2IHWTz0nnXuR/0O6fHtZSWpVvwx/8wYtwyX
	U2Vw7hnepD7
X-Received: by 2002:a05:6000:25ca:b0:47f:9568:ebf0 with SMTP id ffacd0b85a97d-47fec52786bmr29820198f8f.23.1786062183265;
        Thu, 06 Aug 2026 17:23:03 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:6db2:29ac:6c1f:5e1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm359215f8f.22.2026.08.06.17.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:23:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/4] ovpn: run deferred work on a module-owned workqueue
Date: Fri,  7 Aug 2026 02:22:43 +0200
Message-ID: <20260807002250.1817498-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807002250.1817498-1-antonio@openvpn.net>
References: <20260807002250.1817498-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

ovpn queues several work items whose callbacks execute module text.
These works currently run on the global system workqueues, so module
exit has no driver-owned drain point that guarantees the callbacks have
fully returned before the module text can be freed.

Object references protect the objects used by the callbacks, but they do
not prove that a workqueue function has returned. In particular, a
worker can drop the final reference that unblocks device teardown while
it is still executing ovpn code.

Add a module-owned workqueue and queue all ovpn work items on it. During
module exit, unregister rtnl and netlink first, flush the workqueue so
ordinary ovpn workers finish, run the final RCU barrier, and destroy the
workqueue last. This keeps the workqueue available for cleanup work
queued from RCU callbacks, while ensuring no ovpn work item can outlive
the module text.

The per-device delayed keepalive work remains explicitly disabled during
netdev teardown (disable_delayed_work_sync in ndo_uninit), since
flush_workqueue does not flush delayed work that is still only pending
on its timer.

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c     | 19 ++++++++++++++++++-
 drivers/net/ovpn/ovpnpriv.h |  4 ++++
 drivers/net/ovpn/peer.c     |  8 ++++----
 drivers/net/ovpn/tcp.c      |  9 ++++-----
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 168cfe9b59a9..0d23a9d5ceb9 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
+#include <linux/workqueue.h>
 #include <net/gro_cells.h>
 #include <net/ip.h>
 #include <net/rtnetlink.h>
@@ -26,6 +27,9 @@
 #include "tcp.h"
 #include "udp.h"
 
+/* module-owned workqueue on which all ovpn-specific work is queued */
+struct workqueue_struct *ovpn_wq;
+
 static void ovpn_priv_free(struct net_device *net)
 {
 	struct ovpn_priv *ovpn = netdev_priv(net);
@@ -264,10 +268,16 @@ static int __init ovpn_init(void)
 
 	ovpn_tcp_init();
 
+	ovpn_wq = alloc_workqueue("ovpn", 0, 0);
+	if (!ovpn_wq) {
+		pr_err("ovpn: cannot allocate workqueue\n");
+		return -ENOMEM;
+	}
+
 	err = rtnl_link_register(&ovpn_link_ops);
 	if (err) {
 		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
-		return err;
+		goto destroy_wq;
 	}
 
 	err = ovpn_nl_register();
@@ -280,6 +290,9 @@ static int __init ovpn_init(void)
 
 unreg_rtnl:
 	rtnl_link_unregister(&ovpn_link_ops);
+destroy_wq:
+	destroy_workqueue(ovpn_wq);
+	ovpn_wq = NULL;
 	return err;
 }
 
@@ -288,7 +301,11 @@ static __exit void ovpn_cleanup(void)
 	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
 
+	flush_workqueue(ovpn_wq);
 	rcu_barrier();
+
+	destroy_workqueue(ovpn_wq);
+	ovpn_wq = NULL;
 }
 
 module_init(ovpn_init);
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 5898f6adada7..84499140e4bd 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -15,6 +15,10 @@
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
 
+struct workqueue_struct;
+
+extern struct workqueue_struct *ovpn_wq;
+
 /**
  * struct ovpn_peer_collection - container of peers for MultiPeer mode
  * @by_id: table of peers index by ID
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index b0519f9840d8..c95656ca7c35 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -62,7 +62,7 @@ void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
 	/* now that interval and timeout have been changed, kick
 	 * off the worker so that the next delay can be recomputed
 	 */
-	mod_delayed_work(system_percpu_wq, &peer->ovpn->keepalive_work, 0);
+	mod_delayed_work(ovpn_wq, &peer->ovpn->keepalive_work, 0);
 }
 
 /**
@@ -1371,7 +1371,7 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 			   peer->id);
 		if (WARN_ON(!ovpn_peer_hold(peer)))
 			return 0;
-		if (!schedule_work(&peer->keepalive_work))
+		if (!queue_work(ovpn_wq, &peer->keepalive_work))
 			ovpn_peer_put(peer);
 	}
 
@@ -1463,8 +1463,8 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 		netdev_dbg(ovpn->dev,
 			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
 			   next_run, now, next_run - now);
-		schedule_delayed_work(&ovpn->keepalive_work,
-				      (next_run - now) * HZ);
+		queue_delayed_work(ovpn_wq, &ovpn->keepalive_work,
+				   (next_run - now) * HZ);
 	}
 	unlock_ovpn(ovpn, &release_list);
 }
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 0af14055c39a..8fe8a8e750a4 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -151,7 +151,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	/* take reference for deferred peer deletion. should never fail */
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
-	if (!schedule_work(&peer->tcp.defer_del_work))
+	if (!queue_work(ovpn_wq, &peer->tcp.defer_del_work))
 		ovpn_peer_put(peer);
 	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
@@ -284,13 +284,12 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			 * stream therefore we abort the connection
 			 */
 			ovpn_peer_hold(peer);
-			if (!schedule_work(&peer->tcp.defer_del_work))
+			if (!queue_work(ovpn_wq, &peer->tcp.defer_del_work))
 				ovpn_peer_put(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
-			 * which would lead to more invocations of
-			 * schedule_work()
+			 * which would lead to more invocations of queue_work()
 			 */
 			return;
 		}
@@ -487,7 +486,7 @@ static void ovpn_tcp_write_space(struct sock *sk)
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
 	if (likely(sock && sock->peer)) {
-		schedule_work(&sock->tcp_tx_work);
+		queue_work(ovpn_wq, &sock->tcp_tx_work);
 		sock->peer->tcp.sk_cb.sk_write_space(sk);
 	}
 	rcu_read_unlock();
-- 
2.54.0

