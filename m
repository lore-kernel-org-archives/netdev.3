Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE336F8E4
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765454; cv=none; b=YUKi1QC7tb7H9PWzb9Wa3UjPSdsywqt+ZXHbMMVEjZg5HckPKz51YDPJP4Wly/jn0CxsEqHVXbuJpKVYyEMAAwygsumn9iVfTb4E20RSalsDeZc+X4/Twke3joBzlVlv42afss1IiRDGx5t8J78a0OmKUvwN/Fdzo0Qrmt0x1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765454; c=relaxed/simple;
	bh=F7dg4uV+SeFo2dFFxmjQAqsAB3A+dWqmfEPjWnRYwyQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kSFfdn/NNm/85xAXKA0Or0hk95iHXFY8t0Nr4UGKswKvbwCyo9WvyB7Y8cOAkbRWXM6PAXov5HdQvD9r9GKLyHQFzNxuk4Acqvu8TWV/GAlCrZpQQQEFZN2/05DEfQ0I5FiJbgiP4RwYrlPlkg+cYj8M5USM1qv5LucNZYqxxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tica4bzA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tica4bzA"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1550180b3a.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787765428; x=1788370228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNHz/4ifo+9tDQWoOhUiPBeOvf91b3cVWpu2DE1jbaA=;
        b=Tica4bzALy27jDGQ71XeIcNjB/ZWW6q215askPatfgZqNgfZRBk1u09a03iyAcOxlg
         Mpq8X9WVA2Zdnjk1n6yN3DZRGewgUpoHIAtc3IiGSbm7GvFXSxJEUscOtiZVepjlC0wp
         0zosrX9DXhC0q6DZQ6C/f+gxhY0PDTHfrbxdVgaa/5Bapw1i8pw4AOb5/zB1VFiY/z3h
         f6XJ4OWkkxU9Y7HGio4gh2u6jID2BfsQvBwFxrjZdifeY2mTV1t4cTGYXvIrHbJSIPsp
         6Osyb8VHsHxJU9bV4ELePMFzjsSqKvxlACPwUzfo7FHEKF4GQC/9GF4/DIKTVuPirU1U
         TvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765428; x=1788370228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dNHz/4ifo+9tDQWoOhUiPBeOvf91b3cVWpu2DE1jbaA=;
        b=Dzrp4AyivwbCW7v/RNkBOyhxllSoE74IgVubHuw8gVaba9YS9rNX0Gah3QV1ByWaZy
         bELGpzjuq++df7t8u8kvZH/RNtiZkKXpUZxjbcOAEsQCufcKv5ulbq2dkcRo8aE1vFxA
         ntrn1QE+ky7a3d/8TsdDVef/lD4Lg6PdmPHleJe4Avps9NjAbeQFEKeM95UID7Hs8FlB
         t9temhyFNhcCmbGB7/TYAsP+50qJrkM7hZ+nIKV6W+fXnN4uPXwfriie6sO5sGVZEX/R
         Pu/5YqYKg9EJf3BMARmhdCWXGjVlBE6ooJTpZt5zPAk8Q9NhWx16ifRL+mslwVDCeG0J
         uTwg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4+ba0JfYsJxse5tpn2KSdVIy1sf/TWWaymqkz7CfpHLIZxLJpybKfRaZCCeW4I5EWtVitkjA=@vger.kernel.org
X-Gm-Message-State: AFuF++mvQvyePY8S4cPWU6hLOCt3EcIkibxP02wUOheyn0CdzQQdemBb
	th5UJt7cYrtiqg93kyPlspjIOURVeK/NFckRi/ENdlBEIN3P55Ae7S+f
X-Gm-Gg: AR+sD11GzejVPthWrRkbEQS2LQFQqReguCyFGb+2KOMO6aCDYj+YpcUjSbEwW/+R2KF
	kWySVDT8Vdbg5BKXkJDdAz07n67Ra87Nco+lYMUslWN7KGczYYSG++WFedNxJRXuONhsMx4m/0n
	FPNmYGwlKGgV2c0Mwfw9WjAlmqZ33INzow0oq2VWDs/MUfxb77dB49OxYA7i5ZmyZkQDpVTo9SG
	ZXeAU6U/Qzx7wktoZB9aJFEAeJVADZeYCMLL17O11rmIrCoHBaLe1MG8y6kwezqVovqI/DCQLgk
	zpDW7mFd8bElHlhu4KThY4pSCXskZLij6N20/eI1Xv8I+H3R3R9rAZBxH6Bmorx6UoJnkiwCsjl
	K0ADaCYk8ugiyq0Xr/wrJh1GIpqoCqWmW6suNTLY/8B26V8PgGaUO4YcZOx39wQWWS+6NVA3SK3
	JHv909UX4/wDT+88GkLyaJ5QcpuHPC0sPftRcQzHrUqu7MZnJeavRjQwfum48ZPMCDewCkYeDQN
	/+1rLM2PJdYemA6hM6Iq5s=
X-Received: by 2002:a05:6372:a711:b0:3d0:88f5:f813 with SMTP id adf61e73a8af0-3d088f5fbb1mr6818831637.11.1787765428001;
        Wed, 26 Aug 2026 10:30:28 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1bec83527sm1183458a12.26.2026.08.26.10.30.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:30:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Date: Wed, 26 Aug 2026 23:00:19 +0530
Message-ID: <20260826173019.2917-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a circular locking dependency involving &net->xdp.lock,
&xs->mutex, and netdev_lock_ops():

-> #2 (&net->xdp.lock):
       xsk_diag_dump
       netlink_dump

-> #1 (&xs->mutex):
       xsk_bind

-> #0 (netdev_lock_ops):
       xsk_notifier

The lockdep dependency cycle arose from the following relationships:
- xsk_diag_dump() established &net->xdp.lock -> &xs->mutex by calling
  xsk_diag_fill() under &net->xdp.lock.
- xsk_bind() established &xs->mutex -> netdev_lock_ops().
- Device unregistration and xsk_notifier() established
  netdev_lock_ops() -> &net->xdp.lock while also invoking xp_clear_dev()
  under &net->xdp.lock and &xs->mutex.

Eliminate the cycle by decoupling the locks across both paths:

1. In xsk_notifier(), split the unregistration into two phases:
   - First, unbind all matching sockets under &net->xdp.lock and
     &xs->mutex.
   - Then, release &net->xdp.lock and perform device queue teardown by
     sweeping the device queues via xsk_get_pool_from_qid() and calling
     xp_clear_dev(pool) outside all AF_XDP locks.
2. In xsk_diag_dump(), avoid holding &net->xdp.lock while calling
   xsk_diag_fill(). Instead, locate the target socket under &net->xdp.lock,
   take a temporary socket reference via sock_hold(), release
   &net->xdp.lock, and call xsk_diag_fill() (which acquires &xs->mutex)
   with sock_put().
   Distinguish -ENOENT (when an unbound socket is skipped) from -EMSGSIZE
   (when the skb is full and the cursor must be retained for dump
   continuation).

Fixes: 975b11ae9077 ("xsk: add socket allocate, create and bind")
Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
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

 net/xdp/xsk.c      | 17 +++++++-----
 net/xdp/xsk_diag.c | 65 +++++++++++++++++++++++++++++++---------------
 2 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c2f47182dc..e72344fccb 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -2099,14 +2099,15 @@ static int xsk_notifier(struct notifier_block *this,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
+	unsigned int max_queues;
 	struct sock *sk;
+	u16 qid;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		mutex_lock(&net->xdp.lock);
 		sk_for_each(sk, &net->xdp.list) {
 			struct xdp_sock *xs = xdp_sk(sk);
-			struct xsk_buff_pool *pool = NULL;
 
 			mutex_lock(&xs->mutex);
 			if (xs->dev == dev) {
@@ -2114,18 +2115,22 @@ static int xsk_notifier(struct notifier_block *this,
 				if (!sock_flag(sk, SOCK_DEAD))
 					sk_error_report(sk);
 
-				pool = xs->pool;
 				xsk_unbind_dev(xs);
 			}
 			mutex_unlock(&xs->mutex);
+		}
+		mutex_unlock(&net->xdp.lock);
+
+		/* Clear device references outside AF_XDP locks to avoid
+		 * lock inversion with netdev_lock_ops().
+		 */
+		max_queues = max(dev->real_num_rx_queues, dev->real_num_tx_queues);
+		for (qid = 0; qid < max_queues; qid++) {
+			struct xsk_buff_pool *pool = xsk_get_pool_from_qid(dev, qid);
 
-			/* Clear device references outside xs->mutex to avoid
-			 * lock inversion with netdev_lock_ops().
-			 */
 			if (pool)
 				xp_clear_dev(pool);
 		}
-		mutex_unlock(&net->xdp.lock);
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

