Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2532E13B
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786310516; cv=none; b=hMvFcAjnvwEO80O0lEqAPvI33BSgsqcOmGtS0grh9PV0MhuxuF+rryeNhdQoNP35cQ5/M9oKhARjU6ivJhI+JgaIhOSZei+JVRVmHj34VOgU/0PuzGuONlWvyecFE4Q4ptX36ISCV/ZcOzFAlWGT0mTZkpFiZQW1sSJJ6YQlMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786310516; c=relaxed/simple;
	bh=Ev5PDBY9I8R1z4RSgMnCQb8cWChXhBLV4yIGh4xuDfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua/MexXchDg7U4i8dpXFfS4fgApb8ddF4TVAzgzY761oKMqjsl7WN5sxkCu4Yb1LHSIt7wxndHFSq6GdAGNbiPPDTl4/XU90gG6iN9NtT8le7pm7nEKU6khOPD2EuENkZHDus0/O4Y0v5edHCT4tTw3N4QtbF1mGnFnlgREbOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YUC5p/iE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YUC5p/iE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4813ea321cdso368333f8f.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786310512; x=1786915312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQr0Y6Z1zecVLdE6e55W1Pdqxb+peoEZ1K00Y1X/ylo=;
        b=YUC5p/iEkUuzhQX8CSBhP4VtZqtDaoIc6OZ+Zl7/ysEe87iby/jW4sue+1igHiBY3Z
         pjm6XLvmFDECrqb+2Eu8aET8PGbMeOrMEJBTJhRutsA9swcAsGdFmOk3c0QB7gCxldHw
         Me2ZKmg5ScaFnXtHYkZIAP7wc7WVkXX2PX6XVjyaHNBE4/XHDAEBHSEv+LVsztkWsI8w
         Cu6gR381RyQ5wwa/E2kW8krZM1Z2jt/Mb1Mr2arW/Kr3hwR6KygyX+BUPvak19geis/E
         5n61a9cQUIcJROqym47G+W5u+9qsoA6udglGIaL/2wDMY/dSxYXQw8wW0U18q3DfaJTs
         rgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786310512; x=1786915312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GQr0Y6Z1zecVLdE6e55W1Pdqxb+peoEZ1K00Y1X/ylo=;
        b=i/rJn/0SB3zK++Lz5jl8+++FvsgN//vhtJ5dtVTLOnUbeHIGxqJJkxA8e6MKgchp8j
         dKGescDAtOD/Hv75ZYPwc7nyGO8pKiO+koeusYtwiMWgTAX5X8W/jipLcGI49B2ajOQ6
         knxhQWj6w4HGGLYWml8LOUc+QhVMyzae7OF3ukouhgi0GzUmtJXRYOyDM5enZJHXmLM4
         /aaJ9u4TgFaEu7APjY+C/Dc+ZJcOxGHOBDeE8JquIyiUnD0N52MIg2Sigp6pWsYG5uCV
         aiX4ZV3bfGyF0qgZcWg2freQ4sDiTgpiLtLJFN8mAORkbLZ8Wz+B57f0IDu6ME9l6cS5
         Lpyw==
X-Gm-Message-State: AOJu0YxfaQulbd/bJ3VqjhF3FznRFXslEnLm6+U8OzmxRjWjJyuEtJM3
	/PnXO7VV3/r99JInNAqkNOKoYiDfmLLjbnxWh19QCQwhFmby1mQ7D5AMw4APwqVxD3ez29LSQxf
	X+M+1yWuRrPRWoLDv2ox6JFqXL1zeO+xfz6iYZqZ1ig2FeCNdCPdZc63vgwEGhYtq
X-Gm-Gg: AR+sD114itDO90EFqxHNZneb/5SKOmB+LQo94s0HtzDGddVbK7BL6eC8wx7NZ2Z1M+s
	KLlKMn7YhdYQUKMmYexJnrfhlYqU5mNeh2so9vOlh4eZ2oBuNPC57W35VuWtvsjTiwcN+Vg482M
	iJ6tbtvbFvARA4QAyUr82Jae6Ym77QVDk1VgZqab238QpXjsryc2vjwXiehPYPbNMcPp/LDju+a
	H4Ef47wIl0aV0w11NXSdSxHLJHSJfgexjWGe47hLRU0QISN1EdnPGlS7L6rrkR2TgAGbUJbLHxx
	eMbPttduQvtc35VOGhInIdVx7oDhD3SbpWUKOLhsVZiPbooPx8oYd1XRBVoAfEK9i9UxVtwrNUP
	R1VX5Q2YIlN/EPMA36ktxYmp7dWF5xfsRR4sX4B9o408xdvP8RkV2mP4d7nNULrZtTmgQLJanXD
	W2gdQQ4gVXY+bRVI6EKdqTmCK07yWy2tqF7VartNXVyh57hRVxltO89YAN1HR00tT4I7prfSlzb
	loxkZGwC6oh
X-Received: by 2002:a05:6000:1446:b0:481:2fff:2a09 with SMTP id ffacd0b85a97d-4813198078emr14216004f8f.14.1786310512480;
        Sun, 09 Aug 2026 14:21:52 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:58c9:fa0e:8293:9eba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002206effsm24976651f8f.32.2026.08.09.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 14:21:51 -0700 (PDT)
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
Date: Sun,  9 Aug 2026 23:21:28 +0200
Message-ID: <20260809212142.2249027-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809212142.2249027-1-antonio@openvpn.net>
References: <20260809212142.2249027-1-antonio@openvpn.net>
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
index 168cfe9b59a9..0708249e9607 100644
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
 
+	ovpn_wq = alloc_workqueue("ovpn", WQ_PERCPU, 0);
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

