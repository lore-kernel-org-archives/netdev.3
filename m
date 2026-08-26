Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBD466B09
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766490; cv=none; b=YsRU2yNSzuRoH2GS6Seu5SnUJ2ddVezVozTpojFEjwHPjT3Q6XHEKuLna3kkVYN0khnkXZP7GcoAdX3tx0m9SOBmtQ2/jWxxI21ZGSjO7kKvd7sslkNlgwIioHWATJ1K/30wKp+/uhy9Dewn352QOpaKUaFXgH2a8hz1ty8Hy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766490; c=relaxed/simple;
	bh=P1HH3DMtBQJOM1SksocwacfbzwECsIBU39Kmr+yQMXo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BZeG9Qd43z3n1xb9FdEATOOxtmiVfUxH1uUR4aaPnHZHQDELRoCBkg+8KNolXJp1ahx08rKOM6dqEHPXiIAtQbzeJOyO4zlTD+MUtsAwKq6Mn2aNmloA8lzb2uanR1Y0YpHeRex+51wPLE7xz3+YZfInvh5kWXMISV6YwJOAwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL9w8SdI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL9w8SdI"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1286699a91.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787766474; x=1788371274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAxdLOzeJb37jL/MC5ouL9U6AoU2dm5PCu1totmLfzg=;
        b=CL9w8SdIMVXrptpaW2Wpw87SizRiJweHbaufG0QingIv8XuAwMNje5XoahtvQOd8qh
         7eCDeFiMDftNs0+4eNB8AvGTa06+uCYK0slJkU9nv0/7QSvwkkc8K28SgT/RpHW9vdQn
         YFRW4fKz0B7p283P4D+0KaNOCkEjS4KjvuKStHdEgrN2o0rFSCqtvxbKs0nTOaIRMfyo
         ITNIhO+Wvw1Ngyf8u78bnVCwkEef9T5bYasnq+hiBaX1qgEPa6hs7A+zE37pSLBfMe65
         DbjRutKIH8kPMKIhtfsgafFl1/qNyCRv9gIz2ZN06H7DKpX1eEe9R2vPZoVLfjclTS12
         Rjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766474; x=1788371274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mAxdLOzeJb37jL/MC5ouL9U6AoU2dm5PCu1totmLfzg=;
        b=StkV3FnpisRSX3+gI20az/EPLMC0ypSHdCsnNNpxEg/aEPTX+e6/Ul8OlieOj/YIRG
         fciKSUfzIl5wH1hNZr5II6EVVgkhXZGKKwGTghc4W94qhmHMhc6mw+W3B9bNfJQzTpii
         Ez6KBAQLUFe+i1KkZO7GTZZDB+irbb+y3AMXC0E3uz06RGIC6J9TKa34cQFYg7pDuKRC
         uc2IV1hyxP4WGbUjen4p9zScHzhM8HB/2BXnwkhuue9wHOGjMe+GUH8JopmqM0ik+0W/
         fGz+qO4I7RN0aTP4UN+5CvJpA0Ip2GrAtfABpARtQv+p2FtxvWts5VAt5Q7gWJA7oyia
         JuBA==
X-Forwarded-Encrypted: i=1; AHgh+Rp773Qz83JQheZa04hs0Y9Iv6aMbGgBTDfPbBn16TarP8nC8wgLq+2FxKFbFaEEv3xMHTtecaU=@vger.kernel.org
X-Gm-Message-State: AFuF++kq8GbIdBGYrTzHmTQj9qQFGQ8GtPkzvWdG6GJxj703bIG9w4ye
	pf0cthEPq0IVrGN1jR/fEGGhi/ioebyXW5z4Q1s5/xNKSwFhqEOK/kYJ
X-Gm-Gg: AR+sD12FIhrCdVD5n2PSKA1yN/jWSY1/hAa1u+ROIa+1Db6fr/L7q5kqzZ+6yCRIQLi
	2rx9oGEYqPhh1T/Uo35lxFooRC/80F4d4Jlgeu8R6Wp82Z1Ac2r6uvK0u3TKg6Q/ORdJ85k1voE
	FO3wu9Pn1wi2APETqlRnwupgk3KCP2VcJua5BKDeDwZROmjchcdyUX7wYrLPN5uBKn6Iqniuvs0
	eqS2n/RyYrJxHRWbsNXXD5/cz4dqCMBj6rBxoM8NL/TZ/1T1OXFFR0GXqaA5zaDkk8+jcq09BJq
	RJXicQWF/Rm/d3YxwkcoUebTAuRgqnSD/zCt+6cTL1x01S10a83PPyRtpjq0wVIf3v1yvmoJe7V
	YJGt6/G3xsL3haO+PBNiTKEIzDVRrXX2OoHXhymS0uBWNwo+29TufTymQiNF4p4tZO7MYv5KYU5
	kWnO0Xwov793wxUbDzhZ6hV8sgjzL37yyr4Y3bxbLvhtxAugftRrwJVOHNDlDqe55KvavQaNRrP
	4BDPIgDwfzxp6ziGKgYDXNKVbZy2cofdQ==
X-Received: by 2002:a17:90b:17d1:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-3966d20b09fmr16290418a91.8.1787766473937;
        Wed, 26 Aug 2026 10:47:53 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d69065sm9799883a91.13.2026.08.26.10.47.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:47:53 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v4] xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Date: Wed, 26 Aug 2026 23:17:44 +0530
Message-ID: <20260826174744.3394-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a circular locking dependency involving &net->xdp.lock,
&port->pnodes_lock, netdev_lock_ops(), and &xs->mutex:

-> #3 (&net->xdp.lock):
       xsk_notifier+0x3d/0x2c0 net/xdp/xsk.c:2106
       ipvlan_device_event+0x310/0x4e0 drivers/net/ipvlan/ipvlan_main.c:834
       unregister_netdevice_many_notify+0x808/0x18b0 net/core/dev.c:12518

-> #2 (&port->pnodes_lock):
       ipvlan_device_event+0x85/0x4e0 drivers/net/ipvlan/ipvlan_main.c:795
       notifier_call_chain+0xb5/0x410 kernel/notifier.c:85

-> #1 (&dev_instance_lock_key / netdev_lock_ops):
       netdev_lock_ops include/net/netdev_lock.h:42 [inline]
       xsk_bind+0x331/0x11d0 net/xdp/xsk.c:1627

-> #0 (&xs->mutex):
       xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
       xsk_diag_dump+0x2e0/0x4e0 net/xdp/xsk_diag.c:166

The cycle exists through the following dependency chain:
1. xsk_diag_dump() acquired &xs->mutex while holding &net->xdp.lock (#0).
2. xsk_bind() acquired netdev_lock_ops() while holding &xs->mutex (#1).
3. Device unregistration in ipvlan_device_event() acquired
   &port->pnodes_lock (#2) and called xsk_notifier(), which acquired
   &net->xdp.lock (#3).

Break the circular dependency by decoupling the locking in xsk_diag_dump()
and xsk_notifier():

1. In xsk_diag_dump(), avoid holding &net->xdp.lock while calling
   xsk_diag_fill(). Instead, locate the target socket under &net->xdp.lock,
   take a temporary socket reference via sock_hold(), release
   &net->xdp.lock, and call xsk_diag_fill() (which acquires &xs->mutex)
   with sock_put().
   To preserve dump continuation across buffer exhaustion, distinguish
   -ENOENT (when an unbound socket is skipped) from -EMSGSIZE (when the
   skb is full and the cursor must be retained for the next dump callback).
2. In xsk_notifier(), split device unregistration into two phases:
   - First, unbind all matching sockets under &net->xdp.lock and
     &xs->mutex.
   - Then, release &net->xdp.lock and perform device queue teardown by
     sweeping the device queues via xsk_get_pool_from_qid() and calling
     xp_clear_dev(pool) outside all AF_XDP locks.

Fixes: 975b11ae9077 ("xsk: add socket allocate, create and bind")
Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
v3 -> v4:
- Rebase cleanly on latest bpf-next master to resolve merge conflict.
- Update commit message to accurately describe the full 4-lock dependency
  chain (&net->xdp.lock, &port->pnodes_lock, netdev_lock_ops, &xs->mutex)
  from the syzbot report.
- Link to v3: https://lore.kernel.org/bpf/20260826173019.2917-1-ahemadkhawar123@gmail.com/

v2 -> v3:
- Fix direct AB-BA lock inversion in xsk_notifier() by performing device
  queue sweeps via xsk_get_pool_from_qid() outside &net->xdp.lock.
- Eliminate &net->xdp.lock -> &xs->mutex in xsk_diag_dump() by taking a
  temporary socket reference under &net->xdp.lock and releasing the lock
  prior to xsk_diag_fill().
- Distinguish -ENOENT (skipped unbound socket) from -EMSGSIZE (buffer
  exhaustion) to preserve dump continuation without infinite loops.
- Link to v2: https://lore.kernel.org/bpf/20260826162110.99879-1-ahemadkhawar123@gmail.com/

v1 -> v2:
- Avoid reordering locks in xsk_bind() to preserve errno precedence.
- Link to v1: https://lore.kernel.org/bpf/20260825152152.86092-1-ahemadkhawar123@gmail.com/

 net/xdp/xsk.c      | 16 +++++++++---
 net/xdp/xsk_diag.c | 65 +++++++++++++++++++++++++++++++---------------
 2 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4..e72344fccb 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -2099,7 +2099,9 @@ static int xsk_notifier(struct notifier_block *this,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
+	unsigned int max_queues;
 	struct sock *sk;
+	u16 qid;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
@@ -2114,13 +2116,21 @@ static int xsk_notifier(struct notifier_block *this,
 					sk_error_report(sk);
 
 				xsk_unbind_dev(xs);
-
-				/* Clear device references. */
-				xp_clear_dev(xs->pool);
 			}
 			mutex_unlock(&xs->mutex);
 		}
 		mutex_unlock(&net->xdp.lock);
+
+		/* Clear device references outside AF_XDP locks to avoid
+		 * lock inversion with netdev_lock_ops().
+		 */
+		max_queues = max(dev->real_num_rx_queues, dev->real_num_tx_queues);
+		for (qid = 0; qid < max_queues; qid++) {
+			struct xsk_buff_pool *pool = xsk_get_pool_from_qid(dev, qid);
+
+			if (pool)
+				xp_clear_dev(pool);
+		}
 		break;
 	}
 	return NOTIFY_DONE;
diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index 0170363eb5..bad0b13064 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -97,6 +97,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct xdp_diag_msg *msg;
 	struct nlmsghdr *nlh;
+	int err = -EMSGSIZE;
 
 	nlh = nlmsg_put(nlskb, portid, seq, SOCK_DIAG_BY_FAMILY, sizeof(*msg),
 			flags);
@@ -111,8 +112,10 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 	sock_diag_save_cookie(sk, msg->xdiag_cookie);
 
 	mutex_lock(&xs->mutex);
-	if (READ_ONCE(xs->state) == XSK_UNBOUND)
+	if (READ_ONCE(xs->state) == XSK_UNBOUND) {
+		err = -ENOENT;
 		goto out_nlmsg_trim;
+	}
 
 	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
 		goto out_nlmsg_trim;
@@ -145,7 +148,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 out_nlmsg_trim:
 	mutex_unlock(&xs->mutex);
 	nlmsg_cancel(nlskb, nlh);
-	return -EMSGSIZE;
+	return err;
 }
 
 static int xsk_diag_dump(struct sk_buff *nlskb, struct netlink_callback *cb)
@@ -153,28 +156,48 @@ static int xsk_diag_dump(struct sk_buff *nlskb, struct netlink_callback *cb)
 	struct xdp_diag_req *req = nlmsg_data(cb->nlh);
 	struct net *net = sock_net(nlskb->sk);
 	int num = 0, s_num = cb->args[0];
-	struct sock *sk;
-
-	mutex_lock(&net->xdp.lock);
-
-	sk_for_each(sk, &net->xdp.list) {
-		if (!net_eq(sock_net(sk), net))
-			continue;
-		if (num++ < s_num)
-			continue;
-
-		if (xsk_diag_fill(sk, nlskb, req,
-				  sk_user_ns(NETLINK_CB(cb->skb).sk),
-				  NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				  sock_i_ino(sk)) < 0) {
-			num--;
-			break;
+	struct sock *sk, *target_sk;
+	int err;
+
+	for (;;) {
+		target_sk = NULL;
+		num = 0;
+
+		mutex_lock(&net->xdp.lock);
+		sk_for_each(sk, &net->xdp.list) {
+			if (!net_eq(sock_net(sk), net))
+				continue;
+			if (num++ == s_num) {
+				sock_hold(sk);
+				target_sk = sk;
+				break;
+			}
 		}
+		mutex_unlock(&net->xdp.lock);
+
+		if (!target_sk)
+			break;
+
+		err = xsk_diag_fill(target_sk, nlskb, req,
+				    sk_user_ns(NETLINK_CB(cb->skb).sk),
+				    NETLINK_CB(cb->skb).portid,
+				    cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				    sock_i_ino(target_sk));
+		sock_put(target_sk);
+
+		/*
+		 * xsk_diag_fill() returns:
+		 *   0:         entry added successfully.
+		 *   -ENOENT:   socket is unbound, skip it.
+		 *   -EMSGSIZE: skb is full, retry this socket on the next dump callback.
+		 */
+		if (err == -EMSGSIZE)
+			break;
+
+		s_num++;
 	}
 
-	mutex_unlock(&net->xdp.lock);
-	cb->args[0] = num;
+	cb->args[0] = s_num;
 	return nlskb->len;
 }
 
-- 
2.54.0 (Apple Git-157)

