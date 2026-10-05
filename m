Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30A4CA286
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215150; cv=none; b=th1NM+NPjm052wv+w7ZwoJY19IQ4DJcEmeOkyvsmPWkYR/W6WnUhiXzXXPoeXFMgiFrUzySBcCCU1oPdpg83B/vgMhIUWbJw59+gmo240U6TycWFyc2GxwuMj6CuErc91AXQogVISr3hcVR/B8NvEe0nso26JFqQCbxrHVyODKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215150; c=relaxed/simple;
	bh=grXjC+RWArzI3tzi0SoTo2hHBgPqHDVNZ3pu/PVgW/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EwlJRgReeb3PlMBhrwX5g3xtzQrwbRyagXKshvS1LpEI4inD6n9KhtyhA7Sy5kXO3KZH8e2iIbNq4kaUhuyfTO0JAxPHgn6ZbOJR6UxcHfgiyt/Gsnzt4nB8KUHGdkvA/MfD0vvam1hIWv2FniE4xO6s5NXrqRio69CapJ4yQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noYdtSkK; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noYdtSkK"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cca35cf9f77so1079073a12.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215144; x=1791819944; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TM4sAzqsrZVGsKN+8W1iOGVIdabPB8yZVWr1rVlN1A4=;
        b=noYdtSkKrWR57TpMvfmfplDNJ869m8gD7dONkLUrPFr2eWlHdGBN1/aMmTVNQfhCb8
         U5+BepqTmBkQONV7a9LdGWeKA2gKhppVz2U2EJ+jeCOi6Tfk2xAA6P49KSlz4sijkTKK
         O2JLn/X2gMMrYUC/HMFTZ85HUv+OC5XUDO0kC4o4Ti02IOLj/BGF5KLNvvgZ73Ln97Hf
         oK1clKXLngD0arWruIbaU9V+ZSUPnW8uEes6Vr7QkLc2PJ81pJEE38M9qXlIc7RwqBm/
         yRC3rpOm4G9VXGIWsPgSx0ave8azGrLyoVjSEl3eiEalIeH3O22a7mJkkBmqqadTSEcI
         sR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215144; x=1791819944;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TM4sAzqsrZVGsKN+8W1iOGVIdabPB8yZVWr1rVlN1A4=;
        b=gRXftnXxeDqQoluJ0tn9FxjbseYxYjEHYR8wp9Ank8CV/fYiSxPKg9VFqP9QTi5ohN
         Mq3+HZaFg7C+FPDkgyawJQxZWcia1JZAgXKSbdMSk6Lc9RQ8IFMpyIsfpEGDeAc526E/
         goPOIzztRQjhTi9s2sQcOIM3dobtLtCaTCw5gt1gDCsrf/hlD9Fz0z5REAkXCFsRhyzP
         0soAvb/vtamw//xpk8OC/7DeXSrweMzUFohBSmvB0IFB7HO4SgKxNCH2IFKiUeS8GLRr
         w/iluW+kiqrZAbYH1nmzMe1+AfJh4giCjFeJIzFD/PNm6/iOdwMl0dDnR9z16ADxqIEn
         6AiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP9FiwDWLyg8llI2xeq07g7nlU8p7fAOImUfRS4kQG//fVZUKTS/UibcTT8elAJqtiuC5YeYM=@vger.kernel.org
X-Gm-Message-State: AFuF++kMSDJsvJgT8BYH1sMhbq4mVl7CrwpJBeSIICvF6xFYrJBJC1ZX
	r6hUBX+FMLuk7fT9I/7kkOf8TYvhU1TyDCKb7vMg80OYUcnhN33ahkwVrfgXxqcLVvJ29K6o6Om
	wP0xgGQ==
X-Received: from pgsb4.prod.google.com ([2002:a65:67c4:0:b0:cc7:a4ca:364])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d11:b0:3de:4516:27c9
 with SMTP id adf61e73a8af0-3e0bd009f99mr11361427637.64.1791215143770; Mon, 05
 Oct 2026 08:45:43 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:48 +0000
In-Reply-To: <20261005154533.4147685-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-7-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 6/9] tcp: Split out __tcp_set_rcvlowat().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

We will add a kfunc for bpf_tcp_ops.{enqueue,dequeue}_rcvq()
to adjust sk->sk_rcvlowat.

These hooks are triggered

  * when the TCP stack enqueues an skb to sk->sk_receive_queue
  * after data is dequeued from sk->sk_receive_queue

In the enqueue path, tcp_data_ready() is always called after
the hooks in tcp_queue_rcv() and tcp_ofo_queue().

If tcp_set_rcvlowat() were used as is, tcp_data_ready() could
be called twice for the same skb, which is redundant and also
confusing.

Let's split out __tcp_set_rcvlowat() and add a flag to control
wakeup behaviour.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/net/tcp.h |  1 +
 net/ipv4/tcp.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7f4ab50f08c7..adc8d1a5f926 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -512,6 +512,7 @@ void tcp_set_keepalive(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int flags);
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 void tcp_set_rcvbuf(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a1e2bb3974ce..ce35060f82ee 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1827,8 +1827,7 @@ int tcp_peek_len(struct socket *sock)
 	return tcp_inq(sock->sk);
 }
 
-/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
-int tcp_set_rcvlowat(struct sock *sk, int val)
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int space, cap;
@@ -1841,7 +1840,8 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 
 	/* Check if we need to signal EPOLLIN right now */
-	tcp_data_ready(sk);
+	if (wakeup)
+		tcp_data_ready(sk);
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
@@ -1856,6 +1856,12 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	return 0;
 }
 
+/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
+int tcp_set_rcvlowat(struct sock *sk, int val)
+{
+	return __tcp_set_rcvlowat(sk, val, true);
+}
+
 void tcp_set_rcvbuf(struct sock *sk, int val)
 {
 	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

