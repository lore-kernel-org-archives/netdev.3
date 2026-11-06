Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942399;
	b=or/06dVg70fv5lqD1+UHBsRK2aGjcEihRtESY6lZD6o7NVgsrnMpwdDYDnjIaX6LJz2J
	 xECSiet6pa2yTj39OC6jgBfAxOlW713AbeE5SV4lTfzFOBso/mnBBsjS52v8mFjY8L1gu
	 Vkp9DPpAl4HXIVPxn3KiXj727lcK08XHrF7+6fL67peUL33euQIZZpHKL7ztwcb7wtV++
	 UxqU6Ks1dAWEpOkDp8PhnGXogLqzKfL1SuXgWkOaJ1G615f9M6BJsx3T6nN6CMSDABwLj
	 LcZxATOneYXEalF41w9u0D702oWzd2FH4887XYrcAqcwAmrIfhQziNhWqpZbguzskow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=poLO/FYmmqcs1GTxITc1aAz5v4ON3pq6sok2GYQflVA=;
	b=H9JGk/GNK7/6iVDsChzT3my9PmKbexLbinwDIwmrfx+DKEvVCauD19fnczJ+5m99/Ep1
	 35qfGrvhEWhvnNcAL6TCLtqxMDCIlutXJSG1pPqef8QioLesHAWtNT0MKgwmmRWpZRA75
	 vCLvwypCkuCjgVZ22Kav1zYC0VStH97pJnyM4/6qPGBGNzHhMn2IHbTTX2+WPziLaRIpP
	 7Tokm72/JRGHmvHeboxs/ajj2L790ZMtCrf3dVbgdpz43oNyvl9DU7HHP37TULtMjPFic
	 c1lVCXXaoTHA907P1yNhe1/c5No5Eb6CkcAcdXF6Hm0buLkWZc7LaB+fpDGdQi9LLww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dN0//pmJ";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EE606D812
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 05:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B3EE606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dN0//pmJ
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ed0890476fso1480495ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 21:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793942398; x=1794547198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=poLO/FYmmqcs1GTxITc1aAz5v4ON3pq6sok2GYQflVA=;
        b=dN0//pmJEAsF076fr7W5z5BEW5z1sCCCCExDgz3ojvuzceMpBTTCMJg3SFVrge2w5E
         QIlfFUTXmg1u1F9Rx8NJo6+w8LouBjqmsSq6w2BBpHOm4PZ5/7S5SFrCpJw3JaOHl+cm
         ebF1jrw5JlBru47P2yG894K7CYnr0KgBwzWvd7Zaflq3EfYhkPDzGAMgRLANXrLXwM0k
         okjGUDtEgBC9zBCtIpbdzFK+siB7Lsv2I1bhRzgkHdem/Zff187B4YIo76S4S4y2WQlz
         /OpY1tTt/UA8/TuJNZsxnOvjrxmNVLIwWDmdIK7h/3FYou/q0CfQlCKhc/6zcxfe2vXM
         LAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793942398; x=1794547198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=poLO/FYmmqcs1GTxITc1aAz5v4ON3pq6sok2GYQflVA=;
        b=zOsDcJ+G493NABmmjg+7+fkuJ8/eY6M17M+nIgxDY9q3dmXH5p4DO6Q5yU9/EGCIeZ
         fmiT/HtfTJ3Ml/7/s35jAlSNcP79COwKrntGo54myjtvXnxLlVyTqxFnQqVbYYyLLwj+
         6P8BxPFh1RYwY4vbeHSJmR+A48ICD90Qx+UIzIXMIMIscnyxNve/sP+E7uMOut2BU75b
         uQYH8f+fZP/YI/RAiKKDCysEOXnf59KZbw8Um0NNVpYY2FGvADSE9wtKJSSKi9IawciX
         WMVjU5DfzFVRGAwue6bSuGEeJMbiPqpyXTcLiBs3k46Hv6qtH2thlYo930U8aLhujwOS
         v0sQ==
X-Forwarded-Encrypted: i=1; AL+hErEI8atuqIFLrpzJ0Iey6n8TDdTUwTIYOQcozgKyR8lahqLayR/T4RpPuK5aKdhCiyDA8GNcdZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/56jAdK1Crb4jdl/0cZHhziKJFRSEGUaj0moGuGT1c5l54Duja
	HkIcxPL/+SBHQ4nKwHO6ORufrw0jiWP8UIvuRxvuvTUVHh6O/CiQ6l3o
X-Gm-Gg: AYBFou2QlG+1+nV20qOSoKGfTK9XghQUxXje1bEF+YL2ua8caKXumSC/WGV/VB2nEpN
	sUb2mmLBcP3EvaWamEargVHiEhfLTayyGSkxgtqMJDKQTaZNmC6P7IlOyMSMe/wAy5BSs1SSRTP
	FpC2FEDykJ4woO8HDuzC16eIJm7sjjLLj7sAOxW04uRTXG8gwTtEa9wf5cZFfVC9v5oOePjf/MO
	g6JOxJlqyrNPU4/+PtreSVCXbwwf3pwv+T77mP5Ly1bOhM3VnMpytPpJBH+QSFfFidaauHRfNUn
	XY4AY+KjDE+Io0cw9yg0qy1YvLv1/k+qzAmFtei+S8iyLmoEZxsia/vwIL+1XOcFwWUlJD2tRoF
	6UaneadabR3PEDbI6RKtFEHAsoYRqh3Wr5ZmXp7RcOYDW4CwVpVtjBapHpIbnD1zh0u++pv+RfH
	9y6r6CqLyuHGkAgJ1Y1nyxTq50EylIa9Ikk8hrY2Dyk9NBA04jHxQ0fuoImnAFVAWr9fZPRySah
	mjrnJm2puatQt4v9JofImxyAgfuDZQ8kQ/i5TaEtm11uPqUtCeNW5BUo5pofton2zNKszNgOsQc
	kEemaMRT6geZ9UnL/iLPvmV9SkF0I4jDO7s4+//1ybktM8bTUvPQXGoiG7a2s5jQKvD0jGLRVxm
	j+nv3bpfxUGd5NcNVvTyWDcGxnIGdDvzYKBTpMAGOGefYXuN3Z9QUwY99eGmjIewJzA4YA5ms4X
	/eH4TcGwv9dFxQN+bcuzD3TkOcbfYJ4abYIC1Uqz07
X-Received: by 2002:a17:903:1b67:b0:2e2:d77b:e587 with SMTP id d9443c01a7336-2ed40abb311mr24361185ad.18.1793942397995;
        Thu, 05 Nov 2026 21:19:57 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d7bd2esm1594465ad.56.2026.11.05.21.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:19:57 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jann Horn <jannh@google.com>,
	Kirill Tkhai <tkhai@ya.ru>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH net 3/4] af_unix: Fix scm_stat.nr_fds leak in unix_dgram_disconnected().
Date: Fri,  6 Nov 2026 05:19:04 +0000
Message-ID: <20261106051905.218638-4-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106051905.218638-1-sidchintamaneni@gmail.com>
References: <20261106051905.218638-1-sidchintamaneni@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a connected SOCK_DGRAM socket disconnects (e.g. via connect() with
AF_UNSPEC), reconnects to a different peer, or observes a dead peer in
unix_dgram_sendmsg(), unix_dgram_disconnected() purges all unread
datagrams from sk->sk_receive_queue via skb_queue_purge_reason().

Because skb_queue_purge_reason() frees each skb without calling
scm_stat_del(sk, skb), any SCM_RIGHTS file descriptors attached to the
purged skbs remain permanently accounted in u->scm_stat.nr_fds (reported
as scm_fds in /proc/<pid>/fdinfo/<fd>) for the remaining lifetime of the
socket.

Move scm_stat_add() and scm_stat_del() above unix_dgram_disconnected()
and dequeue each skb in unix_dgram_disconnected() so scm_stat_del() is
called before kfree_skb_reason().

Fixes: 3c32da19a858 ("unix: Show number of pending scm files of receive queue in fdinfo")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 net/unix/af_unix.c | 52 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 44c0a81dd423..47120d81aca2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -609,6 +609,28 @@ static void unix_write_space(struct sock *sk)
 	rcu_read_unlock();
 }
 
+static void scm_stat_add(struct sock *sk, struct sk_buff *skb)
+{
+	struct scm_fp_list *fp = UNIXCB(skb).fp;
+	struct unix_sock *u = unix_sk(sk);
+
+	if (unlikely(fp && fp->count)) {
+		atomic_add(fp->count, &u->scm_stat.nr_fds);
+		unix_add_edges(fp, u);
+	}
+}
+
+static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
+{
+	struct scm_fp_list *fp = UNIXCB(skb).fp;
+	struct unix_sock *u = unix_sk(sk);
+
+	if (unlikely(fp && fp->count)) {
+		atomic_sub(fp->count, &u->scm_stat.nr_fds);
+		unix_del_edges(fp);
+	}
+}
+
 /* When dgram socket disconnects (or changes its peer), we clear its receive
  * queue of packets arrived from previous peer. First, it allows to do
  * flow control based only on wmem_alloc; second, sk connected to peer
@@ -616,8 +638,12 @@ static void unix_write_space(struct sock *sk)
 static void unix_dgram_disconnected(struct sock *sk, struct sock *other)
 {
 	if (!skb_queue_empty(&sk->sk_receive_queue)) {
-		skb_queue_purge_reason(&sk->sk_receive_queue,
-				       SKB_DROP_REASON_UNIX_DISCONNECT);
+		struct sk_buff *skb;
+
+		while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+			scm_stat_del(sk, skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_DISCONNECT);
+		}
 
 		wake_up_interruptible_all(&unix_sk(sk)->peer_wait);
 
@@ -2058,28 +2084,6 @@ static bool unix_skb_scm_eq(const struct sock *sk, struct sk_buff *skb,
 	       unix_secdata_eq(scm, skb);
 }
 
-static void scm_stat_add(struct sock *sk, struct sk_buff *skb)
-{
-	struct scm_fp_list *fp = UNIXCB(skb).fp;
-	struct unix_sock *u = unix_sk(sk);
-
-	if (unlikely(fp && fp->count)) {
-		atomic_add(fp->count, &u->scm_stat.nr_fds);
-		unix_add_edges(fp, u);
-	}
-}
-
-static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
-{
-	struct scm_fp_list *fp = UNIXCB(skb).fp;
-	struct unix_sock *u = unix_sk(sk);
-
-	if (unlikely(fp && fp->count)) {
-		atomic_sub(fp->count, &u->scm_stat.nr_fds);
-		unix_del_edges(fp);
-	}
-}
-
 static void unix_orphan_scm(struct sock *sk, struct sk_buff *skb)
 {
 	scm_stat_del(sk, skb);
-- 
2.43.0

