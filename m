Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186584915BB
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587667; cv=none; b=HTPZfUjJGwIHrQe21K1UuSe/24phjxBQ11lm+BkTk843wen3OKs0EpVCMoteoVWFZsNB4svBlZNrGQ9k6/B0/U3sthItodM/1/n/edSy3qkd6v3BE681kJzlWKDSWAeXUygVodnnfVZI03TtfjUbMUstjTa500QLZ0p89+slyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587667; c=relaxed/simple;
	bh=4puZtzJaKYo/1q57mb6OxUXH8KPxfZwy50xJZM76zDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbafcpF6Cc8Pml1x1uyR9fnGrp6v48482JuUpXoK0/3uaynFHFdMK0FYV2OmOVCWAmKJVil4tZ9uUpA9i1S8qeCfkguNmUDb37akrG0myONF7A0guvjCZU7ATZ/9XWvnyRTo28P/rKUnUoKtOOsfklAHyt/6oWKL4v8fekfGCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=xagqdtwm; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="xagqdtwm"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af3701927so385995166b.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587660; x=1791192460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YX1prY/id3ekFTiUGJNGWSS7F0F93hJiA33/wr3GsQk=;
        b=xagqdtwmi6/he+CY2+VpSiwM7jMpJ9Wv6pnDjtUk311sx16R7tJKuL6AZTC0dumEkQ
         FnhTPMhFGR8MCHLPOaXdxL/tYVmyQ+4yExlTNOCODOh1RJ6otYt+PZgIGsx4leihN86b
         HoGG9qZCkzpS6lRQk3GHmlEwLAIpDQiJVJ6+r1zLsRMaxf7epx8mvnhLVJ8N5gEDTNCW
         lhE68+mAd1s0xfIQgtHhOJLdPex9yCR2GqLMlokdYOYarSDXTXBtBa304kIjU4b2xHmC
         q9/pyriD86HOWDDF5qiQSy0i6ACxPXyEZLHqhwM2zsrafIS8S4hivOpyHZ3qpwTHyZbH
         MWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587660; x=1791192460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YX1prY/id3ekFTiUGJNGWSS7F0F93hJiA33/wr3GsQk=;
        b=FqOFuL3gvxPCnJfCPlevTY/rMMZxFe5zGSJJpzxpeX0s1v4SwEpUxuqHluTJ7cFCxo
         SBW1MvYL6OrGyrZUdNGqSVTHFsK7n5lp43sehLlcUAfHyI3ZLDHjRi20xuK33dyyTH7V
         sWU8g9kUHLXAEpsblxSy1/wubGOZS8eurQMw9Z2qPkuMKQtpEWnEYBMVOH5M51lhwKla
         PKK5UxZZ6AtwnQ1QMKLmIyU5LK5cNPYbfe24I3lmBwVMXyQMmuW6hn2kixzGEzMlf6qB
         Sw0o1nuepJcnhyLkDV6babrCFI8KZgRTxcjwz0nqXYlaCdD6/MFaxuNR1tlj63a2i6T3
         fq3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwcSNaARsYeu+dzQw7HvThrOPIV/wLymv+npv0aA6/7mVhZ7voifE8OiKOKziQW/GlHl32jeUU=@vger.kernel.org
X-Gm-Message-State: AFuF++mR6WWQVUKMz9bLLUnWgxcsn8pKaxfuN5nPc43xH1W2LGj0ml/3
	ZkMI6zIDOtW2805HpYwUWoBgWI/R0emye4J1BXMdClcN8Ug0GAw6PE8OGSP9St5PSgRS
X-Gm-Gg: AYBFou07qzXWnLlI5lJ+9DfpoyGbP3mHGr04p3qOCTF5aEWimT339sB7IhQOyU5wU4G
	BRXeYGiO4lGVYkDXfYq3KLRfEigwAKrQUxG3TsWAtyg1SwGrGvf+rd9HPp54S2t/x+2FwMGaDOc
	9w8QpXSMI6AhfYxJv9FIYNVf5RC1I6ci9b2KhYTQUSCaRRyJI1fHg5LaSiKpqmSJJS/7rcFp/+L
	3rBaewwXZJHVnpUjrZxsyBxa5+AgIJv+PoY1eTOa77VVT0vyT2YwxCZgW4hd5/0ccitEeWnXFwN
	yN27GoxNvf2ro6pG1oU7JcEfFLqinqBTwLbDcyfuzWkz8ng6vZiQU+uPJKxf3KgZMLIlMW7msvn
	188aQvjFxqhUQGNEjEYA3LgaALV1U6yICGYq8hKfh2w7ZVn6wtoVv794vPadLqMgpgwoX0onlFQ
	Hu6lEaeUdZhkTqr+bgrPjotsvXMYV5uLu5VrQZtzZIADnygBFoJy79r2r0W4y3SFJcmRsA6W0Vc
	WQ0jf0+uAvoe/ZOp6iDBdX6diGv8fh2ubvcNNz7lg==
X-Received: by 2002:a17:907:9689:b0:c29:4147:f4e2 with SMTP id a640c23a62f3a-c2ac20e18admr1050086966b.15.1790587660169;
        Mon, 28 Sep 2026 02:27:40 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:39 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:12 +0200
Subject: [PATCH v3 05/10] net: turn sk_peer_pid into an array indexed by
 pid type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-5-532018a91b21@amutable.com>
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Currently only the struct pid of the thread-group leader is recorded
for a socket's peer. To make room for the struct pid of the thread that
called connect(), listen() or socketpair() turn sk_peer_pid into an
array indexed by pid type. All users, including bluetooth and the
coredump socket, keep using the PIDTYPE_TGID slot.

Nothing fills the PIDTYPE_PID slot yet. No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 fs/coredump.c                   |  2 +-
 include/net/sock.h              |  4 ++--
 include/trace/events/landlock.h |  2 +-
 net/bluetooth/af_bluetooth.c    |  6 +++---
 net/bluetooth/hci_sock.c        |  8 ++++----
 net/bluetooth/l2cap_sock.c      |  2 +-
 net/core/sock.c                 |  9 +++++----
 net/unix/af_unix.c              | 14 +++++++-------
 8 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 6114839f5178..9b267d3c0ed7 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -722,7 +722,7 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 	}
 
 	/* ... and validate that @sk_peer_pid matches @cprm.pid. */
-	if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid != cprm->pid))
+	if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid[PIDTYPE_TGID] != cprm->pid))
 		return false;
 
 	cprm->limit = RLIM_INFINITY;
diff --git a/include/net/sock.h b/include/net/sock.h
index 14df0fb68259..efc64c60e4ac 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -301,7 +301,7 @@ struct sk_filter;
   *	@sk_type: socket type (%SOCK_STREAM, etc)
   *	@sk_protocol: which protocol this socket belongs in this network family
   *	@sk_peer_lock: lock protecting @sk_peer_pid and @sk_peer_cred
-  *	@sk_peer_pid: &struct pid for this socket's peer
+  *	@sk_peer_pid: &struct pid for this socket's peer, by pid type
   *	@sk_peer_cred: %SO_PEERCRED setting
   *	@sk_rcvlowat: %SO_RCVLOWAT setting
   *	@sk_rcvtimeo: %SO_RCVTIMEO setting
@@ -546,7 +546,7 @@ struct sock {
 	u64			sk_ino;
 	spinlock_t		sk_peer_lock;
 	int			sk_bind_phc;
-	struct pid		*sk_peer_pid;
+	DECLARE_PIDS(sk_peer_pid, PIDTYPE_TGID);
 	const struct cred	*sk_peer_cred;
 
 	ktime_t			sk_stamp;
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 3a43638c9bc2..9e172ea22d95 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -1037,7 +1037,7 @@ TRACE_EVENT(landlock_deny_scope_abstract_unix_socket,
 		 * updates.  The peer socket keeps a reference to sk_peer_pid
 		 * through pid_nr(); sun_path is the reliable identifier.
 		 */
-		peer_pid		= READ_ONCE(peer->sk_peer_pid);
+		peer_pid		= READ_ONCE(peer->sk_peer_pid[PIDTYPE_TGID]);
 		__entry->peer_pid	= peer_pid ? pid_nr(peer_pid) : 0;
 		__assign_str(sun_path);
 	),
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 411d66f24393..7758e9ea3848 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -161,7 +161,7 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 	/* Init peer information so it can be properly monitored */
 	if (!kern) {
 		spin_lock(&sk->sk_peer_lock);
-		sk->sk_peer_pid  = get_pid(task_tgid(current));
+		sk->sk_peer_pid[PIDTYPE_TGID]  = get_pid(task_tgid(current));
 		sk->sk_peer_cred = get_current_cred();
 		spin_unlock(&sk->sk_peer_lock);
 	}
@@ -235,9 +235,9 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	 * socket is allocated by the kernel.
 	 */
 	spin_lock(&sk->sk_peer_lock);
-	old_pid = sk->sk_peer_pid;
+	old_pid = sk->sk_peer_pid[PIDTYPE_TGID];
 	old_cred = sk->sk_peer_cred;
-	sk->sk_peer_pid = get_pid(parent->sk_peer_pid);
+	sk->sk_peer_pid[PIDTYPE_TGID] = get_pid(parent->sk_peer_pid[PIDTYPE_TGID]);
 	sk->sk_peer_cred = get_cred(parent->sk_peer_cred);
 	spin_unlock(&sk->sk_peer_lock);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 6d56c77741e1..4c40068ba5fb 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -284,21 +284,21 @@ static void hci_sock_copy_creds(struct sock *sk, struct sk_buff *skb)
 	creds = &bt_cb(skb)->creds;
 
 	/* Check if peer credentials is set */
-	if (!sk->sk_peer_pid) {
+	if (!sk->sk_peer_pid[PIDTYPE_TGID]) {
 		/* Check if parent peer credentials is set */
-		if (bt_sk(sk)->parent && bt_sk(sk)->parent->sk_peer_pid)
+		if (bt_sk(sk)->parent && bt_sk(sk)->parent->sk_peer_pid[PIDTYPE_TGID])
 			sk = bt_sk(sk)->parent;
 		else
 			return;
 	}
 
 	/* Check if scm_creds already set */
-	if (creds->pid == pid_vnr(sk->sk_peer_pid))
+	if (creds->pid == pid_vnr(sk->sk_peer_pid[PIDTYPE_TGID]))
 		return;
 
 	memset(creds, 0, sizeof(*creds));
 
-	creds->pid = pid_vnr(sk->sk_peer_pid);
+	creds->pid = pid_vnr(sk->sk_peer_pid[PIDTYPE_TGID]);
 	if (sk->sk_peer_cred) {
 		creds->uid = sk->sk_peer_cred->uid;
 		creds->gid = sk->sk_peer_cred->gid;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1194c37e466f..872d8fb31b6f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1890,7 +1890,7 @@ static struct pid *l2cap_sock_get_peer_pid_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
-	return sk->sk_peer_pid;
+	return sk->sk_peer_pid[PIDTYPE_TGID];
 }
 
 static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
diff --git a/net/core/sock.c b/net/core/sock.c
index 3b5f28573752..dfe98463ad0e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1921,7 +1921,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 			len = sizeof(peercred);
 
 		spin_lock(&sk->sk_peer_lock);
-		cred_to_ucred(sk->sk_peer_pid, sk->sk_peer_cred, &peercred);
+		cred_to_ucred(sk->sk_peer_pid[PIDTYPE_TGID], sk->sk_peer_cred,
+			      &peercred);
 		spin_unlock(&sk->sk_peer_lock);
 
 		if (copy_to_sockptr(optval, &peercred, len))
@@ -1940,7 +1941,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 			len = sizeof(pidfd);
 
 		spin_lock(&sk->sk_peer_lock);
-		peer_pid = get_pid(sk->sk_peer_pid);
+		peer_pid = get_pid(sk->sk_peer_pid[PIDTYPE_TGID]);
 		spin_unlock(&sk->sk_peer_lock);
 
 		if (!peer_pid)
@@ -2394,7 +2395,7 @@ static void __sk_destruct(struct rcu_head *head)
 
 	/* We do not need to acquire sk->sk_peer_lock, we are the last user. */
 	put_cred(sk->sk_peer_cred);
-	put_pid(sk->sk_peer_pid);
+	put_pids(sk->sk_peer_pid);
 
 	if (likely(sk->sk_net_refcnt)) {
 		put_net_track(net, &sk->ns_tracker);
@@ -3799,7 +3800,7 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_frag.offset	=	0;
 	sk->sk_peek_off		=	-1;
 
-	sk->sk_peer_pid 	=	NULL;
+	memset(sk->sk_peer_pid, 0, sizeof(sk->sk_peer_pid));
 	sk->sk_peer_cred	=	NULL;
 	spin_lock_init(&sk->sk_peer_lock);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6cc2873d9a4f..66a26a10871b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -737,7 +737,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 }
 
 struct unix_peercred {
-	struct pid *peer_pid;
+	DECLARE_PIDS(peer_pid, PIDTYPE_TGID);
 	const struct cred *peer_cred;
 };
 
@@ -749,7 +749,7 @@ static inline int prepare_peercred(struct unix_peercred *peercred)
 	pid = task_tgid(current);
 	err = pidfs_register_pid(pid);
 	if (likely(!err)) {
-		peercred->peer_pid = get_pid(pid);
+		peercred->peer_pid[PIDTYPE_TGID] = get_pid(pid);
 		peercred->peer_cred = get_current_cred();
 	}
 	return err;
@@ -762,7 +762,7 @@ static void drop_peercred(struct unix_peercred *peercred)
 
 	might_sleep();
 
-	swap(peercred->peer_pid, pid);
+	swap(peercred->peer_pid[PIDTYPE_TGID], pid);
 	swap(peercred->peer_cred, cred);
 
 	put_pid(pid);
@@ -772,7 +772,7 @@ static void drop_peercred(struct unix_peercred *peercred)
 static inline void init_peercred(struct sock *sk,
 				 const struct unix_peercred *peercred)
 {
-	sk->sk_peer_pid = peercred->peer_pid;
+	sk->sk_peer_pid[PIDTYPE_TGID] = peercred->peer_pid[PIDTYPE_TGID];
 	sk->sk_peer_cred = peercred->peer_cred;
 }
 
@@ -782,12 +782,12 @@ static void update_peercred(struct sock *sk, struct unix_peercred *peercred)
 	struct pid *old_pid;
 
 	spin_lock(&sk->sk_peer_lock);
-	old_pid = sk->sk_peer_pid;
+	old_pid = sk->sk_peer_pid[PIDTYPE_TGID];
 	old_cred = sk->sk_peer_cred;
 	init_peercred(sk, peercred);
 	spin_unlock(&sk->sk_peer_lock);
 
-	peercred->peer_pid = old_pid;
+	peercred->peer_pid[PIDTYPE_TGID] = old_pid;
 	peercred->peer_cred = old_cred;
 }
 
@@ -796,7 +796,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 	lockdep_assert_held(&unix_sk(peersk)->lock);
 
 	spin_lock(&sk->sk_peer_lock);
-	sk->sk_peer_pid = get_pid(peersk->sk_peer_pid);
+	sk->sk_peer_pid[PIDTYPE_TGID] = get_pid(peersk->sk_peer_pid[PIDTYPE_TGID]);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 	spin_unlock(&sk->sk_peer_lock);
 }

-- 
2.55.0

