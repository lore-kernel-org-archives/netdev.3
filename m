Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEF33B6C9
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787374454; cv=none; b=VN2gSHyCUGYYhGo2lpA4h1ulVZwIYhm96mDnPA/wbdse5zgM4FEw5cXKpYHlLbGpvNtg0fNMJ/g/CaUM8O+VV8n0hNMBAOmiSnsu0knvg/R8QSWaz6vof6/weh/a2mQ1kPhTtOk8V21pwDNGbQqhpsev17hto6cm2vP++JJgFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787374454; c=relaxed/simple;
	bh=wsE5WdwIC3CEDYrfXTO8tE7gP/TeOFk3B+rRYhV5QGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFJR9+/2R/w71nmvPdEqYuUhUTSK60/I8lQyQ6qyhsWNRxowU5j6IBX0ZFkW1/ejRMR5K71/PhHwPH3y0v1QZp9B/hgilQU0eTwTGddjYBcI86MOLppfNGR7dq7XuoBlf2c/3bybtWrw5wKhenfWdFZhqXjEugNl9BpMkrkl3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvRjBBiF; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvRjBBiF"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66c711b7f2aso2660539d50.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 21:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787374451; x=1787979251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LS/ctWdJ5BX4Wthf8LoVOviLxicTThUmXqKkE0CHN48=;
        b=YvRjBBiFh2QsjkSFbCwGtSX0apmh/IstH10q0AR781eAG4mB/3Oz4xaXhD53W/+01K
         Yc5M4kthegs7m12OYe918apQzCItPyUbhgf8CKhGT1Qc3W6uKrrQdszmSuoUcYx9FeRK
         QFBJ5W7cCGgzCkm5ddDKyrsJQQU/DKik4ZCXL7K8pzb89HTKERD9bCArSH7Gn4vlPW31
         dytCF+Xj30X3ZdziQvQNlBPZQEa8pJuCsC91NBRhzQ7+oMmx381jGnZbCb5nEkI2DRWd
         N0v1Tk5KuS0ErLt3o2TUfyA+Lq9cNmFVfTyfYFXp+c65bs7Tka34gQlKGCpligXoBe+z
         HaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787374451; x=1787979251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LS/ctWdJ5BX4Wthf8LoVOviLxicTThUmXqKkE0CHN48=;
        b=oeG6gvJHBF4X0NHKVJh0+Fq5tGMeadMCB7CRLoG6ggM4c7chBYO3a0hfFJFo5YrFVY
         gnTWp+pPkaKre9l76c0U216yHz+0eegrc6ZakvWyDwdVLPmuatTZHJPzDaVuwOc8aEsb
         zRmAnSBKoP2zH4GO9B8njYzyhXoQaKQR+Hq4WgwJRatXTn7n18Q7hEUd0iURq0SYgcrY
         q2/uX7e/PwYXLO2f07FgoMsBTumvxoDB2N32D6CTPmUzKKGEkpIt9XY+F0Guxb6YRUpt
         CCNU/jL/RdAPYYVrvAK6WzHqJ0yg3XNRYVk8TnWRfQOWckF5Cz0Dvi5gEPRIsQyEV4bC
         t9ig==
X-Gm-Message-State: AFuF++lYE7uCnEztP6YU/Vk9emS83DcXtN/YNky8RAgQr4/nlxHkXc+p
	WtzHW/CoFKFHG516aMtltHNrNtXjCPC0rVUXtw6trckHvzV+C/whrMmX
X-Gm-Gg: AR+sD10Vzn8Af48U2rz857C0nzML2acXBQevvi5O21JKdOioF0pEhaJRcW3ag4TY8Ba
	6fjIhenzVvHqNL/ThR6L3EF1JKtfHMBFTyzWq5qvzbYJ+Odyda7ZC5+XZv3y2PiLaDwtJLQ57M8
	LnXdX2rMkJTuA1GnZ+YcT/SjmAGSphR4YWNbrlEJex1tlu0AvtNxMEnho6yRPoGGFC2Gc5HPBrA
	PHGwgtfK78up7XEzsbLcJfF74X+KVTcRKD/YDwtLEldTNqYPGtOvW1Zp5yG5afoEAljWmdahB/A
	/TfYuwctDGPlum//JPfT21pmUUe2hCOz0rkpk2aa0rkGkxoQEOSVRJp6swQdl/ikKIhhsLpHqtZ
	MfK3fK6V8+z4cgu79Wk1P3jCmZ/wWAwSAPSyvVf/8Mc8Q3mQNFsquvPk97N56SD+0BdB/eYZaXs
	C7a9/oMzpqO+WdQh8iJiZHVdB5XB9AJBZJHbsVIsHNUpkSuEa6j9PFpdc9xs1A+Q==
X-Received: by 2002:a05:690e:285:b0:66c:a3e8:afdc with SMTP id 956f58d0204a3-66ce4b5d4a9mr3184348d50.50.1787374450708;
        Fri, 21 Aug 2026 21:54:10 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5189169sm6850717b3.9.2026.08.21.21.54.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 21:54:10 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] amt: fix tunnel list corruption on device stop
Date: Sat, 22 Aug 2026 00:54:07 -0400
Message-ID: <20260822045407.28983-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_dev_stop() calls list_del_rcu() on each tunnel without holding
amt->lock. amt_tunnel_expire() does the same under amt->lock. When both
race on the same tunnel, the second list_del_rcu() hits LIST_POISON2 and
panics the kernel. An unprivileged user can trigger this inside its own
user/network namespace.

 list_del corruption, prev is LIST_POISON2 (dead000000000122)
 kernel BUG at lib/list_debug.c:59!
 RIP: 0010:__list_del_entry_valid_or_report+0x13a/0x200
 Call Trace:
  amt_dev_stop+0x2c3/0x500 (drivers/net/amt.c:3097)
  __dev_close_many+0x17e/0x470
  unregister_netdevice_many_notify+0x729/0x1f00

Fix:
1. Quiesce RX: clear sk_user_data and call synchronize_net() to ensure
   no RCU readers are traversing tunnel_list. This makes list_del_init()
   safe (it is not RCU-reader-safe unlike list_del_rcu()).
2. Hold amt->lock when unlinking tunnels in stop, using list_del_init()
   so amt_tunnel_expire() can detect already-claimed tunnels via
   list_empty() and skip them.
3. Use while/list_first_entry instead of list_for_each_entry_safe,
   because cancel_delayed_work_sync() can sleep and the cached next
   pointer may become stale.
4. Use disable_delayed_work_sync() instead of cancel_delayed_work_sync()
   to prevent amt_update_handler() from rearming the GC timer in a rare
   race where a packet arrives before the socket is fully released.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 drivers/net/amt.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index bddc24e1856d..a5db02d81291 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1348,6 +1348,11 @@ static void amt_tunnel_expire(struct work_struct *work)
 	struct amt_dev *amt = tunnel->amt;
 
 	spin_lock_bh(&amt->lock);
+	/* amt_dev_stop() marks tunnels it owns with list_del_init(). */
+	if (list_empty(&tunnel->list)) {
+		spin_unlock_bh(&amt->lock);
+		return;
+	}
 	rcu_read_lock();
 	list_del_rcu(&tunnel->list);
 	amt->nr_tunnels--;
@@ -3068,7 +3073,7 @@ static int amt_dev_open(struct net_device *dev)
 static int amt_dev_stop(struct net_device *dev)
 {
 	struct amt_dev *amt = netdev_priv(dev);
-	struct amt_tunnel_list *tunnel, *tmp;
+	struct amt_tunnel_list *tunnel;
 	struct sk_buff *skb;
 	struct sock *sk;
 	int i;
@@ -3077,9 +3082,11 @@ static int amt_dev_stop(struct net_device *dev)
 	disable_delayed_work_sync(&amt->discovery_wq);
 	cancel_delayed_work_sync(&amt->secret_wq);
 
-	/* shutdown */
+	/* Quiesce RX path before tearing down tunnels. */
 	sk = rtnl_dereference(amt->sk);
 	RCU_INIT_POINTER(amt->sk, NULL);
+	if (sk)
+		rcu_assign_sk_user_data(sk, NULL);
 	synchronize_net();
 	if (sk)
 		udp_tunnel_sock_release(sk);
@@ -3097,13 +3104,21 @@ static int amt_dev_stop(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 
-	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
-		list_del_rcu(&tunnel->list);
+	spin_lock_bh(&amt->lock);
+	while (!list_empty(&amt->tunnel_list)) {
+		tunnel = list_first_entry(&amt->tunnel_list,
+					  struct amt_tunnel_list, list);
+		list_del_init(&tunnel->list);
 		amt->nr_tunnels--;
-		cancel_delayed_work_sync(&tunnel->gc_wq);
+		spin_unlock_bh(&amt->lock);
+
+		disable_delayed_work_sync(&tunnel->gc_wq);
 		amt_clear_groups(tunnel);
 		kfree_rcu(tunnel, rcu);
+
+		spin_lock_bh(&amt->lock);
 	}
+	spin_unlock_bh(&amt->lock);
 
 	return 0;
 }
-- 
2.55.0

