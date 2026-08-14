Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C93472536
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714225; cv=none; b=aJEp5NYGvMceePdcwGz1zf34YnGuAg3lV6cxO+UkDJFUjXzlhH2/0Emh+6dni+Fy96RMtArQVanU0bfgxzJP9cJaHbsfAhrguGv0OXodJK4iWTRXLac5mmyTkkK1//6VhUNyihZnsRdYmtq3ks0/CcGu6d1IsNX+1q0dQni4HWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714225; c=relaxed/simple;
	bh=Uh2GB1/qrA73GWb7hvofXqCjGqlqeTl6zZuVZvbQuC4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lVbCTv4Of1ZbrDYBoNHELUfuO91z4eMRVnfr4hy0M5usTkSylQwVfBb6tZiuvYgd0zStat0o9HbgsCcjkRz7tuq0tjuVHLKLMm+sixho78N2gFw3Hn8WsFPaTi9huyRpYONykClWdEu9f1NbAqKHgdvLneaTcF6SUjvpDQQFNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLpDY5/F; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLpDY5/F"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998590d392so10763975e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714221; x=1787319021; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QltvzOeHMR23w+hq5zaVdr4TzSIx2nreQRoyPMgK+L8=;
        b=nLpDY5/FUzL7sC6Cbby9kojovLsGRD7qZRTQsJe20m1dupi4b2eVPvK5JdPJxCiFXM
         lx4VdynCNGagGeCttK1XuxSXgbMfIjh2QXrG2oOxX6XoxK5xn/kBhulpSfvhTviHGRrh
         PUMVGEpr+UmHdQSu34XPZjovsdyrDXLrN3ky3ZkC4LWh5VCdCdyLEQmGGMBwfJW1NGl4
         IEOC1zJn1queOG9NFNSSL1sJ9FEDn5wAlPlYhTNbgL20CqfliYk62x07gm6UZHYJ4HhT
         x4pCNS9VVoYQbcvs3Jil88qNm5VNWyLqhx31Z4Ugaugx/N99yDkByfTZYkY3bkDNVKQS
         0BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714221; x=1787319021;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QltvzOeHMR23w+hq5zaVdr4TzSIx2nreQRoyPMgK+L8=;
        b=NzsIpqwvWPw73UaiaDDg5FUe+o5JgqktpiXXqlFy/dD4SkKa6kTKdDd9rZVxsAQXLw
         EHTQ2m/NfweiWj8eOe3DFq46vOxnKMQzYe+FPIOP3Tmc8IpwPikurE0z2B5ooGOqNa4Z
         82PGV9t+7t8KGq8iP5fOvF1TSeU0Xw+Urwyc8SyqrQfO46728EG3qofs/xNfw5EUvDvf
         oqizL2gLdLp8txi2IERyAdf9Wga3KODNsiVrnhiDRdXOdccKDhQYJD+bB4tc5mbUH17y
         V9woY/4bVMQEc3WcFnOdXuh+JKcmYg3/66RgfAmPoqUv8UE+RYCfAyHHjRbjQgkT9aUq
         qh1w==
X-Forwarded-Encrypted: i=1; AHgh+RoPp81wtcwVBFNJbtyC55ZwoKVh3sP/S/AisD0OnJ0bQYrUdhqnNY0TqJ3Yoh1zibHumWJ5Szo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEgGOgOjrvL6rYCzx3jzkkVHNYQjZpVATXNSnO3CqBtU93ev+
	VSXe4Ia+w8MSxA4Ksw1CxHccnNLWdjipa1xa8zkWu73otOyK7S1ey80T
X-Gm-Gg: AR+sD13fj52CdRFjzWaT8gtOF2ZeVC1xweVoClmv+g3u42HvZ82sfj1u0xy2DjPo5zQ
	I40F7APmgnFuHdGnWCc+Q+5XYF+yBun02uo5cosUJDzKJyerH9hefC6MrnqYjSBlN6ks6hfhNIb
	jX8T9Nn4ujNCGNNTdi4jRhh+xLUgoFdkEwKpll519ejZMatMuXgpyYs1vauqxJg+3UQ8osMVJy4
	kussiAelrcBCMTfHm8AUhco7MnJ+OAbJ2kiEvcwdIECaJNfDk7TflrXzVobeBOMy2YzXBUh1DjN
	gw+1P3LgRkAqGYriA9kDp0+X3S4C7zvssUQjx3JTzC8Cm7BnIykOxrRLK01e7T254aTJvYwBCoc
	egqQn0QpoQwoV/4R7DSWcRSSy/qo6lcjaQ1eYP5jL0DKEnB5oNeg8r+1u5p+FsLWpABzwZeQGM5
	WG+h5d61pHf9hbIlOteVuUlqyJT5s5wm5X/JBfaBrNJFY6KuxAWM3clTUpq2ox+PRcE+ncNUY1w
	Y10HAzZdghkQUI=
X-Received: by 2002:a05:600c:198d:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499879a213dmr70583895e9.15.1786714220681;
        Fri, 14 Aug 2026 06:30:20 -0700 (PDT)
Received: from localhost ([37.30.50.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49989ae1ef2sm26281515e9.9.2026.08.14.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:30:19 -0700 (PDT)
Date: Fri, 14 Aug 2026 13:29:59 +0000
Message-ID: <178671419949.2648204.15668657474779239190@gmail.com>
From: Bartosz Chronowski <immersa.bartosz.chronowski@gmail.com>
To: syzbot <syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com>
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>, horms@kernel.org,
 linux-kernel@vger.kernel.org, syzbot@lists.linux.dev,
 Eric Dumazet <edumazet@google.com>, Jon Maloy <jmaloy@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, tipc-discussion@lists.sourceforge.net,
 syzkaller-bugs@googlegroups.com, syzbot <syzbot@kernel.org>,
 David S. Miller <davem@davemloft.net>
Subject: Re: [PATCH] tipc: defer local Nagle backlog xmit from receive path
In-Reply-To: =?utf-8?q?=3CGV1P189MB1988F6301FA670CA9818F7FCC6DB2=40GV1P189MB?=
 =?utf-8?q?1988=2EEURP189=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: <631b75b4-d1e3-40ea-a129-5ed090f914bf@mail.kernel.org> 
 =?utf-8?q?=3CGV1P189MB1988F6301FA670CA9818F7FCC6DB2=40GV1P189MB1988=2EEURP1?=
 =?utf-8?q?89=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-Kernel-Ph2-Extid: 10a41dc44eef71aa9450
X-Kernel-Ph2-Human-Revision: 2
X-Kernel-Ph2-Patch-SHA256:
 c82ee5c8d899d19d7675bbc18b1270d670d74fdfb455a3b39c182d07fbeb4958
X-Kernel-Ph2-Fingerprint:
 f2657cd81fedfff2f7fc01adc5a1ff647de95ce6d4031968585e19411fffcc1c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1590cf0329716306e948a8fc29f1d3ee87d3989f

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216d35ae4fe539576b6e0be89b84ddb..0bf259672827db095046cda5646df047002dd663 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -94,6 +94,7 @@ struct sockaddr_pair {
  * @peer: 'connected' peer for dgram/rdm
  * @node: hash table node
  * @mc_method: cookie for use between socket and broadcast layer
+ * @backlog_work: processes receive backlog under socket ownership
  * @rcu: rcu struct for tipc_sock
  * @group: TIPC communications group
  * @oneway: message count in one direction (FIXME)
@@ -128,6 +129,7 @@ struct tipc_sock {
 	struct sockaddr_tipc peer;
 	struct rhash_head node;
 	struct tipc_mc_method mc_method;
+	struct work_struct backlog_work;
 	struct rcu_head rcu;
 	struct tipc_group *group;
 	u32 oneway;
@@ -143,6 +145,7 @@ struct tipc_sock {
 };
 
 static int tipc_sk_backlog_rcv(struct sock *sk, struct sk_buff *skb);
+static void tipc_sk_backlog_work(struct work_struct *work);
 static void tipc_data_ready(struct sock *sk);
 static void tipc_write_space(struct sock *sk);
 static void tipc_sock_destruct(struct sock *sk);
@@ -520,6 +523,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	sk->sk_data_ready = tipc_data_ready;
 	sk->sk_write_space = tipc_write_space;
 	sk->sk_destruct = tipc_sock_destruct;
+	INIT_WORK(&tsk->backlog_work, tipc_sk_backlog_work);
 	tsk->conn_timeout = CONN_TIMEOUT_DEFAULT;
 	tsk->group_is_open = true;
 	atomic_set(&tsk->dupl_rcvcnt, 0);
@@ -2417,6 +2421,17 @@ static int tipc_sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static void tipc_sk_backlog_work(struct work_struct *work)
+{
+	struct tipc_sock *tsk = container_of(work, struct tipc_sock,
+					     backlog_work);
+	struct sock *sk = &tsk->sk;
+
+	lock_sock(sk);
+	release_sock(sk);
+	sock_put(sk);
+}
+
 /**
  * tipc_sk_enqueue - extract all buffers with destination 'dport' from
  *                   inputq and try adding them to socket or backlog queue
@@ -2434,18 +2449,30 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
 	struct sk_buff *skb;
 	unsigned int lim;
 	atomic_t *dcnt;
+	bool deferred = false;
+	bool owned;
+	bool local_backlog;
 	u32 onode;
 
 	while (skb_queue_len(inputq)) {
 		if (unlikely(time_after_eq(jiffies, time_limit)))
-			return;
+			break;
 
 		skb = tipc_skb_dequeue(inputq, dport);
 		if (unlikely(!skb))
-			return;
+			break;
 
-		/* Add message directly to receive queue if possible */
-		if (!sock_owned_by_user(sk)) {
+		/*
+		 * A local Nagle backlog may loop back into this socket while its
+		 * spinlock is held.  Queue the triggering input for processing under
+		 * socket ownership, which keeps a concurrent sender from overtaking
+		 * the already queued output.
+		 */
+		owned = sock_owned_by_user(sk);
+		local_backlog = !skb_queue_empty(&sk->sk_write_queue) &&
+				in_own_node(sock_net(sk),
+					    tsk_peer_node(tipc_sk(sk)));
+		if (!owned && !local_backlog) {
 			tipc_sk_filter_rcv(sk, skb, xmitq);
 			continue;
 		}
@@ -2456,6 +2483,7 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
 			atomic_set(dcnt, 0);
 		lim = rcvbuf_limit(sk, skb) + atomic_read(dcnt);
 		if (likely(!sk_add_backlog(sk, skb, lim))) {
+			deferred |= !owned;
 			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_SK_BKLGQ,
 						 "bklg & rcvq >90% allocated!");
 			continue;
@@ -2472,6 +2500,12 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
 		}
 		break;
 	}
+
+	if (deferred) {
+		sock_hold(sk);
+		if (!schedule_work(&tipc_sk(sk)->backlog_work))
+			sock_put(sk);
+	}
 }
 
 /**
