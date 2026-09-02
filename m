Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965EB3909B5
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380527; cv=none; b=EhRUK1DiqFyNU4sIyf/ncennTKNxLLGsk536akoE1BTHeVvYLSx4k+lSBzkbBfSMMYUVUXYLKCPBW+bPo872fgq8tvrr1lvW8Z57dX+1pFJN9hfyOKqOZqJY6HcrYyIkeGJe3IUm4LGb0urgXl248Z0QBXAAy6xD90UG5KGB3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380527; c=relaxed/simple;
	bh=6LnK7q6zGIvWdlK63KvYVATiw7Ef0/UeIArN0nce0NA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lah7CP6PGJQ4u27N74eVMXkkIGb7YipC5zM70bHAXSstA9gto9dqyFwFZY97HaQKl3ilZtZ+e5iaYlp6+mwXQRhqUTrHGea12suGoHU8nAJETCgT3S9h7vFgkooOCsdzEkHrOSLqq718iW3+F7ume5ZMA9z9qecPVE8LIuEI47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7cxL67Y; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7cxL67Y"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-395543dc382so2077837a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788380526; x=1788985326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qen5Ux+GGayn4cMUhvPmSroxT+QXpITMr+juIfolFiw=;
        b=a7cxL67YyUMAXKPxU55HgYvvJRF5VTawCV+LMg9fGGQVSp16rjevXXynC6xOJVwc4g
         5uCl3lUcGDTJ7PmuZ4KPcICEpovHedErgNIaP7HABAD+4k2VZDQHk1BKOk6gHwoUjODW
         u+pSijltGDPA8HhQQy8A20mlaOo30IblHgZHciqNSi+qo0upljy9/g0cghhT/yM3Iu2V
         Z/u+CGSs5HiNqat7vDJHw5n/hT0kUZPUSD8k3I5ywRj4UzraIu7RyzTJTYBtgNTnhapH
         11vW0xuTyqWmslwjrzYQupsUCeTzPSfXOPRMpvNeV0pbYO3iOIjPE6wXmqBJQ2DQYU7T
         E2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380526; x=1788985326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qen5Ux+GGayn4cMUhvPmSroxT+QXpITMr+juIfolFiw=;
        b=UXAvv0n9Lbz6FW2s3EyBsa9tp/uZpFmTm2+MjptIditNMKt3u0bZ0MRQoaYVTdmeZN
         WjFmh96jax1tVdMm3gfWAGpLrXW2KIP8LBgoZUokqCJO4P3AU5F8F/3tV9K8ayDDilNF
         I0u/uch8vYDGUSG66HAj2aMsxOVx1BKh5Asa31fblOsSb+daDpVQ7ZrOMjiA+JkqpH5t
         okzU7MnB9M2KfbStV0oNlg2bh/phuc5ULl2UvDX0Wjk6dLj217UhnWHIWkx6sDCC6LZx
         6fLYFARIpSYb1SWIYz6OV2a9Q/fvlOFQFFWlW/szTuI6SkixJtkwS0EDmERSu9bre/2p
         0vbA==
X-Forwarded-Encrypted: i=1; AKwUvBygD9Xa+2zA/a2Hh2mzziA4r8Ns37pz3fzT9TN0iw5oM0lPnGwnFvNgcXPJ+wTJ6vOJMgbiORA=@vger.kernel.org
X-Gm-Message-State: AFuF++ki2uBAP+WI9XRX4ElCoU7xjnQtTaKZVwlaTbq2QP+UosSttfPh
	MmQ3awzPDZAXB+8xO5k4GTPwxFhatgnSmkNAzLiRPZ5cQwZvfcOLk0VoWEZ5PPcxuEovP9VkH1f
	m6kpJQA==
X-Received: from pjbie23.prod.google.com ([2002:a17:90b:4017:b0:398:d6ef:84d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5208:b0:37d:f206:a2ac
 with SMTP id 98e67ed59e1d1-39aedf0d47amr12270537a91.7.1788380525751; Wed, 02
 Sep 2026 13:22:05 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:21:50 +0000
In-Reply-To: <20260902202202.892676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902202202.892676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902202202.892676-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/3] af_unix: Update last skb marker in manage_oob().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Fahad Alharbi <fahad@codepure.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fahad Alharbi reported that blocking recv(MSG_PEEK) could hog CPU
due to OOB skb.

In the following cases, manage_oob() skips OOB skb(s) and returns
NULL for the last recv(MSG_PEEK):

  socketpair(AF_UNIX, SOCK_STREAM, 0, sk);

  1) skb -> OOB skb -> NULL
     send(sk[0], "ab", 2, MSG_OOB);
     recv(sk[1], buf, 0, MSG_PEEK);

  2) skb -> consumed OOB skb -> NULL
     send(sk[0], "ab", 2, MSG_OOB);
     recv(sk[1], buf, 1, MSG_OOB);
     recv(sk[1], buf, 0, MSG_PEEK);

  3) consumed OOB skb -> OOB skb -> NULL
     send(sk[0], "a", 1, MSG_OOB);
     recv(sk[1], buf, 0, MSG_OOB);
     send(sk[0], "b", 1, MSG_OOB);
     recv(sk[1], buf, 1, MSG_PEEK);

Then, @copied is 0 in unix_stream_read_generic() (zero-length buffer,
or non-OOB skb is not yet consumed), and unix_stream_data_wait() is
called.

However, it returns immediately because @last is not updated in
unix_stream_read_generic(), and the thread busy-waits for a new skb.

Let's update @last in manage_oob().

For MSG_PEEK, @last is updated with the skipped OOB, and for the
non-peek case, @last matches the returned value (when !copied)
because OOB is unlinked.

Note that manage_oob() is inlined and no stack canary is added.

Fixes: 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
Reported-by: Fahad Alharbi <fahad@codepure.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 13f9926bf205..6861370062df 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2812,8 +2812,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 	return 1;
 }
 
-static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
-				  int flags, int copied)
+static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff **last,
+				  struct sock *sk, int flags, int copied)
 {
 	struct sk_buff *read_skb = NULL, *unread_skb = NULL;
 	struct unix_sock *u = unix_sk(sk);
@@ -2827,11 +2827,13 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		if (copied && (!u->oob_skb || skb == u->oob_skb)) {
 			skb = NULL;
 		} else if (flags & MSG_PEEK) {
+			*last = skb;
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 		} else {
 			read_skb = skb;
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			__skb_unlink(read_skb, &sk->sk_receive_queue);
+			*last = skb;
 		}
 
 		if (!skb)
@@ -2850,8 +2852,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			unread_skb = skb;
 			skb = skb_peek(&sk->sk_receive_queue);
+			*last = skb;
 		}
 	} else if (!sock_flag(sk, SOCK_URGINLINE)) {
+		*last = skb;
 		skb = skb_peek_next(skb, &sk->sk_receive_queue);
 	}
 
@@ -2971,7 +2975,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
-			skb = manage_oob(skb, sk, flags, copied);
+			skb = manage_oob(skb, &last, sk, flags, copied);
 			if (!skb && copied) {
 				unix_state_unlock(sk);
 				break;
-- 
2.55.0.970.g62bdec98f9-goog

