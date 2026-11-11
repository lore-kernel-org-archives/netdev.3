Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362625;
	b=mMOmW+u7clot9jSsz39i5P9Rcagb6EDxTpLk73tjMMuqjWHvnvKmdkgnPoo4KD4a6NSt
	 i/iT+cET3y6d2f5QN6WMvPYlbvlXjC5S+aHeYGFw8fX0ddk46Rrdz6vW4NIrUyhjHdP+k
	 +f+nmU1jcH/HxHy5CS33vPJpYwsePkbPaAb9o+s/SgsO9W1TXlHpR1sM764LAkisbLVny
	 e742FzfQ8txlcREigQKLmrx8ZNVE1MWyAbssc1672MystzIqUUkjK3WGaa+X7hVzKXERH
	 8fGNBJJ8TI2m/r9FxhqsjuYJnDF29OqHbfiKERjz2iwd1O6R1PhYUjrjvZVdC1zMpUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bj/u10sbUO7ZEgFG7JyqloStM8DoFc5VckSoqUrERFM=;
	b=0ykDftyyyt9psy0MXcc95/iUUqux1z30oD1UMdtKBjJulcwAk+P+RVediuthnGwOKZpt
	 Ih6YBe0+c49sIqckSjhO2h91L60E/jsx/SJcMKXbQ9yObcjeM5euwa8fSTH2GL/Q4vi22
	 xzae4L6qVi+SjJ3DrTF4CkcA4j2UtayWevR35Z45F9Sa7NDgdKnL95Y3R3EHGoCnQDJri
	 nD1c5snIeclBybjsq0FGzzKU74jGL2ZKAUlhNKeCeQx6NGRsNrzWgIwnrggtO73neL6XB
	 nvoPx2n2nm2n2Mv6E6dXUhPYr2zrEuKfzYAq7nhSlQ6EGF6amXtR9lJVidjgjRi1hdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TfohI4m5;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92F606A338
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D92F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TfohI4m5
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd6969473a4so1681063a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794362625; x=1794967425; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bj/u10sbUO7ZEgFG7JyqloStM8DoFc5VckSoqUrERFM=;
        b=TfohI4m5ilRCRpCRkPljGnCK4ZWXCu1qFpUWV38JEFB9ztHgk1kN6emJgUe1s8i4xZ
         zrumk4Mf/xzT6WBg/bxgzdCZu4QGCtQWTngk8/YZunAI4XvLOiav90psZQTNSk2EKOBL
         RZ7wCw6O0T4UpojpsA4h9BZHSWVd7aJRPavm62TqFknh8SfHz7YhFR1YhQklmwmLOWoG
         lsuQAVe4MKi7/awStTkloLqG+1C4Rhb2QbE6dEOMocHIa8kX4ohzFxhHP0kyd18zFHvc
         NK+1kB5dbxmh5BlbGDLT2V/xGykHQh2EjhvXpMkOMLe/csDPkxyYBF9TYwrVAAKgHmLk
         EPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362625; x=1794967425;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bj/u10sbUO7ZEgFG7JyqloStM8DoFc5VckSoqUrERFM=;
        b=qgCH/f3Hew3mAwbXETZ6j5rpL/UmVdLWMFDdUXN69UKMvaPalkTXzZvX2f1NM2QkoS
         Z/GkTrfBO4y+WiGJPFVHeAqcZMv3bH63/FD5Rre5pjvKJnafk8m278mQr0MCVibHlOd+
         zXQIvevY9m0NGzugxswRetLtsHb0M3K++GhZ50U4SgoQYCIn8kC+V5HakMpvjpJHvSsm
         0dNtCxlI1H7O8r7yPx99+UA3husO5ST0TA5zxQTkcbgzSVY0fenu7xtxpja0/npqQTc4
         R+gfY53Au2R8vFkJ3qWplnkZy62GigKsHcZTIm9N7YXrYyXCP+4zS9toGSbgmwOyJ6Mt
         IJ9w==
X-Forwarded-Encrypted: i=1; AL+hErHPJgwXVqKYnlUU3n/HA0Wk1zRVLSroJQZBLD1WWIzHbR2/Wo++I1/dgKJbAI4clLJYAvL9m9E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pM9V2blrF0VZQ1u5Mq8WemaSbRp+b6N/0BMc+y3aSZ9zAUDXG
	85zgMqVTqv8CU4119OJbgjHQ2wiNgvYXGH/zYh6+YhDA+oFcKElLG9QpZlsnJuH6kalZPcKAs8N
	PUlJCcA==
X-Received: from pfbi1-n1.prod.google.com ([2002:a05:6a00:a501:10b0:890:3943:6267])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a22:b0:3eb:aeb4:2c2e
 with SMTP id adf61e73a8af0-3f2fcf9ca26mr1007917637.14.1794362624583; Tue, 10
 Nov 2026 18:03:44 -0800 (PST)
Date: Wed, 11 Nov 2026 02:03:00 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261111020304.1532064-2-kuniyu@google.com>
Subject: [PATCH v1 net] tcp: Pass req->rsk_listener to inet_csk_reqsk_queue_drop()
 in tcp_check_req().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When connection migration happens in tcp_v[46]_rcv(), a new
listener is passed to tcp_check_req().

When either of the following is true,

  * the new listener queue is full and
    net.ipv4.tcp_abort_on_overflow is set

  * the packet has RST or (not stripped) SYN

tcp_check_req() sends RST and calls inet_csk_reqsk_queue_drop().

Here, the new listener is passed, and its qlen is decremented
wrongly while reqsk is tied to the old listener.

Once qlen underflows, inet_csk_reqsk_queue_is_full() always
return true, and the new listener stops serving.

Without the patch, this script times out while waiting for SYN+ACK
since the new listener drops SYN, but with the patch, 3WHS completes.

    0 `sysctl -q net.ipv4.tcp_migrate_req=1`
   +0 `sysctl -q net.ipv4.tcp_syncookies=0`
   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
   +0 bind(3, ..., ...) = 0
   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
   +0 setsockopt(4, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
   +0 bind(4, ..., ...) = 0
   +0 listen(4, 128) = 0
   +0 < S 0:0(0) win 32792 <mss 1000>
   +0 > S. 0:0(0) ack 1 <...>
   +0 listen(3, 128) = 0
   +0 close(4) = 0
 +.01 < R 1:1(0) win 0
   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 5
   +0 listen(5, 1) = 0
 +.01 < S 0:0(0) win 32792 <mss 1000>
   +0 > S. 0:0(0) ack 1 <...>
   +0 < . 1:1(0) ack 1 win 32792
   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
   +0 accept(3, ..., ...) = 6

Let's pass req->rsk_listener instead.

Fixes: d4f2c86b2b7e ("tcp: Migrate TCP_NEW_SYN_RECV requests at receiving the final ACK.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
one-shot bug will not be worth a new test file.
---
 net/ipv4/tcp_minisocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0ddfd5af6e58..a05bb02e204c 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -974,7 +974,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_reset(sk, skb);
 	}
 	if (!fastopen) {
-		bool unlinked = inet_csk_reqsk_queue_drop(sk, req);
+		bool unlinked = inet_csk_reqsk_queue_drop(req->rsk_listener, req);
 
 		if (unlinked)
 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_EMBRYONICRSTS);
-- 
2.56.0.611.g1030f0b940-goog

