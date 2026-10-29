Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287894;
	b=B1Y6LATi1zgs0fFB01IGkOoHmibOGORf7u+X2HqsMeHi6Jwc80DKThxoT3csX72ipBIm
	 meFBs8lk6VmIZxDQ9eYoGGQeN3QqKk0EirQruYpTuhV24GL1LFgMkSlL2DkWrs5XN7E4d
	 rlLSekGN0339bPSXpkuysZopxPcX9NxjxUYmX7PEQJV6gMcKb8QubDQan2XqhKQKKprnm
	 pUhT6KeT9EJWZdzdM7at2mPyaUkDYiT3U3MNw7JmQRtcS+lWzQOV5RMnwbVFvIOBlil1b
	 8z7zlkUCvqo03zOM8ei1j7kjRxNhfwejOUpmJ85AsPBOsfjBrZu1ed0JhN37w7gGmpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=gQfrrk/iO7jyvp9eZryxKurI9QY+L9/vb4rJW4sJBVA=;
	b=Ain0Yu4T2GIwgPiJSbtcSgXT8+hD7gSv1vqRN9PO9SuS1k+SB1L7t3A30YVEQdJ2vlbZ
	 jLFiOthBIwjwn1Yoccvsng90QhCMPiIOy2ZZ+/vIGYyp7MNbxST1izbTVIMsnvAUxzdNH
	 UaBxaYB42icXEmTyxrjb4gR5fumqj+cXtH6+QQC5c3dr+WX2scdhmxChUMd/CO1sPLtfK
	 sQ90+H8/AvcROLCMEEGghx4tATFZqCwTcpUWGIMCEpWQXdT1iWvmRKArPddY+DCXNJhwO
	 Xl5fZ70QubB1hPjQT1TAIlcj0TWgcQdhnadl8Jga19dBwo97Fs6xQbK5Pq/BF1wgELg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSp4i0qQ;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9327606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9327606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSp4i0qQ
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c49df71182dso117780766b.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793287892; x=1793892692; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQfrrk/iO7jyvp9eZryxKurI9QY+L9/vb4rJW4sJBVA=;
        b=uSp4i0qQlOxv2EY5SIc4+ZKD/5JYRHzZ9K2dGRdWE/DXhPHGCydeDxZZeyH216IYyu
         FziSL/J1LiJ+rnjvBmdCHrrVhD2Zyc4A1GkH+ojr0kZL2lm9GMUJyT0uOFY4UY42Saqb
         X+K+OiVgtizzqLWsN8YtqjV5lbeR9WEZHTEVkO3cMJjbecLSMx8IKg/RgjbJla7h/11F
         RCK7e7eXvwhjS+NclcR6cX84IZHsGwmf51FPspuBQAbI+b5zL7LJIntpjqn+2XnC4B+w
         /Bw7GDMGaW0CKJywkHbiImETxsjf6dqLYqxiZ3Rb/PlRLQLUzvsJyxkDlQHlFA8Q9lvA
         d8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287892; x=1793892692;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQfrrk/iO7jyvp9eZryxKurI9QY+L9/vb4rJW4sJBVA=;
        b=Qa16L7YvAJqEHJzT09OoPKDI1GDc7p3wpM/rsBpFRc/qHFi8jA17N8m4TzdqsdjzKc
         6a18fAXcapT0RPEShyoW4GCEO70OatUUnVB3WgjugHWsSAiP8+FnQUgYYHUuNnOul6yc
         GG8C81g1exkIDuObanaU7i06JjEwqMp2O+DpH7QTw8kQkUOvH4DqwPTExXzFXNOIpO0V
         0lYysb2Aa3NLbSduCC6Cxsoi2T71y8wZHpKokfcwVt+/uKS5Ks+5tTQsjRqoMAywoENO
         2ACgjh3JB8WXf/jt8XEaS0w3fUlKsu3aRyptuFisDoE+RL3HBV2R8frAnTvgoAxb7QWT
         i8hw==
X-Forwarded-Encrypted: i=1; AKwUvBzmtTAqDWMU1G/A7OBlzme7+AxpXuNqYlMqUVlK6dxoQuaIaCT1lbW07LRpnbex+PXvDd990+o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTOhmtBVr/cZa0PdXdBHDdqzh/MjfdmUJBB/NdB2PuuEt2IQFq
	frV45tYmrrcNIS5qAwoOp/hE5Hi0UKW6HqTqhz0quy9BR0mtqLbnBqSK
X-Gm-Gg: AYBFou0XVxpaaHe+yL4ELJejw1ceJLNTAzpyKZqoXpRWDZgku3E3b+tUyZzSCnqLGpL
	fFYuUPTfDQB2OeQ/9JHyxlQoahPjWpjEIF2/V0uzMHhkrYxPKq14rqlQ6nVZDeFPHhcMyspYMt5
	Ec+006yb+X6BuIKWwqFRs1sSuBKsCzFyQY1AxDEIZcpGiw6rYY8Q9pPxZCJfjDFpx00q1WBNPGi
	qBYC/ssSZC/4b/RJuRFVERdgnuaU7w/cpty9pbluWiNIinyOEFMDsDJvTBjEikiuz+LmsnbURL8
	WnGxnnVK4lKYKSD0/WozV4plGXdR8FIcy9lwI+JdXFWRcRr96j1Cni4ImI0cTotoOJppVbvCjc8
	rcuqiTZeCbLR3FM4eAmqgN99tmKdyRYQTMswfsGhGWcvPrktkDwNaHFvpF+hnfez4WqtY7cjoQR
	Ajg3Q1OMl7tGLGwjAC1ta8P24S1OVnRSFDLbXSxyB9zOLvbmqWHSNWXBZtrpHkgaehfEZrEGrOp
	TLKtA58CBlsl4dQejMDUZrS9kB7HpcoIt4H98K/aQ+mbttF/7I9x6wxYqGo3dldtvAtqFGAidD7
	g9+ERhJa5GaUlHYJP/g6jZjZo7BxvgRpqmA+mr4XhlhF+TZVxKCP+A==
X-Received: by 2002:a17:907:d402:b0:c41:44f2:f7d2 with SMTP id a640c23a62f3a-c49bdf2c6b6mr452095066b.24.1793287891707;
        Thu, 29 Oct 2026 08:31:31 -0700 (PDT)
Received: from localhost ([37.30.48.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4ca26f196esm1875266b.56.2026.10.29.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:31:31 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:31:30 +0100
From: Bart Chronowski <immersa.bartosz.chronowski@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>, 
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] tipc: defer local Nagle backlog receive processing
Message-ID: <657t6njsrgnpnfs2mc2lv776442fhv5zsosg3vxya5vqrtpag7@nq3uxt6ymw7s>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A local TIPC stream can soft-lock a CPU when receiving a packet sends
queued Nagle data while the socket's spinlock is held. Local delivery
enters the receive path again before that lock is released. The nested
call cannot take the lock, so it retries the input queue without
making progress.

When an unowned socket has queued data for a local peer, put the
incoming packet on sk_backlog. Queue work to take socket ownership
and drain the backlog through release_sock(). Leave the older data
on sk_write_queue, where later send and shutdown cannot overtake it.

The owned-socket path already puts incoming packets on the backlog.
Only inspect sk_write_queue and the peer node when no user owns the
socket. tipc_sk_enqueue() holds sk_lock.slock at that point, so a
user cannot take ownership and change those fields during the check.

Hold a socket reference for the work, and drop the extra reference
if it is already pending. Queue the work after leaving the receive
loop, even when the loop stops at its time limit or finds no matching
packet. Set up the work before publishing the socket in the TIPC
port hash.

Fixes: c0bceb97db9e ("tipc: add smart nagle feature")
Reported-by: syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/GV1P189MB1988F6301FA670CA9818F7FCC6DB2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
Signed-off-by: Bart Chronowski <immersa.bartosz.chronowski@gmail.com>
---
Changes in v2 (since the posted v1):
  - Ordering update: keep older output on
    sk_write_queue, where later sends append and shutdown pushes the
    queue before FIN. Defer incoming local packets to sk_backlog
    instead of detaching queued output into a separate TX queue.
  - Initialize the backlog work before publishing the socket, and
    inspect the TX queue and peer node only when no user owns the socket.

v1: https://lore.kernel.org/r/631b75b4-d1e3-40ea-a129-5ed090f914bf@mail.kernel.org

Validation:
  For the reported soft lockup, the C reproducer stalled all eight
  unpatched guests. None of the eight patched guests crashed during
  the 270-second run, with the same base and config.

  For send/close ordering, a framed AF_TIPC stream test kept accepted
  data in order in 300 later-send, 300 shutdown, and 300 last-close
  cases on the patched image.

  A complete workqueue trace recorded 547 balanced callbacks and
  four requeues while work was active, with no overlapping callbacks.

 net/tipc/socket.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 65cc0c4964b31..b03dd4a3d3ea2 100644
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
@@ -499,6 +502,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	/* Finish initializing socket data structures */
 	sock->ops = ops;
 	sock_init_data(sock, sk);
+	INIT_WORK(&tsk->backlog_work, tipc_sk_backlog_work);
 	tipc_set_sk_state(sk, TIPC_OPEN);
 	if (tipc_sk_insert(tsk)) {
 		sk_free(sk);
@@ -2428,6 +2432,17 @@ static int tipc_sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
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
@@ -2445,18 +2460,30 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
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
+		local_backlog = !owned && !skb_queue_empty(&sk->sk_write_queue) &&
+				in_own_node(sock_net(sk),
+					    tsk_peer_node(tipc_sk(sk)));
+		if (!owned && !local_backlog) {
 			tipc_sk_filter_rcv(sk, skb, xmitq);
 			continue;
 		}
@@ -2467,6 +2494,7 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
 			atomic_set(dcnt, 0);
 		lim = rcvbuf_limit(sk, skb) + atomic_read(dcnt);
 		if (likely(!sk_add_backlog(sk, skb, lim))) {
+			deferred |= !owned;
 			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_SK_BKLGQ,
 						 "bklg & rcvq >90% allocated!");
 			continue;
@@ -2483,6 +2511,12 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
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
