Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9593C1414
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492970; cv=none; b=MLPQCjPUhSP6wJ3v+/GaP2mJUDu3Lz5EM2J1B9VCZmhSiWErL71gnsbyYMtuSJTk6v5RaiDVja42PWrNu9PRKW9wz43rxzYvU+hF74RViTzOqQdh68MEDQSOjhtHaI4OimU8gYbfNoa8LHSWhjMZJB8yPK+68v5AMGwbd7tDlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492970; c=relaxed/simple;
	bh=3cvDH2ogBgWUXeiB23nQO4H65NytXXjQK0vJcHcU0bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bH4e1a+ez18hT8lA2LOjPotxmYl+AdLJqQZanapAHHw6KjvPaE3d7jZn2YWCBP8AEQ5xuiLPMMWAM2owtHutqcc6ubMb9BZJPGkHgMJhQcNSjFII2/fPkL4Und09GEwrV+UhgeHqGH8Ci8Wyzj8PT+4se9wMQj5MJbf8yLkISyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FrDEbBZ3; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrDEbBZ3"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d9336581a2so10026745ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 20:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788492966; x=1789097766; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+zh0O86jLlL5jpuk61M7Fd7ZM3oooHjkLfEhTz55GQ8=;
        b=FrDEbBZ3/Xm2L45z3boqqCh4q27eO9B8eN/zmmHzwXfPwevCRwkpefGyIVFRXXXWe+
         neXvKR2uCydsRtvHkC4gTZUcvinZq6Uy79dZhCLAS92nNBQLiFpf0jcb8EP/wywLn4Cn
         hdBtHRO8AkW6FV3XgId5soQ0V1EQrugiY5DZZfOR2tKPh5VQoZs+YIIjceI8RIx6J+V9
         3p74bSM2Bs3fzpdKuOKV3GxWxrXzdXElqdLvB77EkDXTvQuDsgFIsbtK/8pXzUYiwLRB
         dosTo9n6ExziOgHU+9wK5LcDpmCRNZBRqRBDxpksBTFGNml4a/uuJNTdq33ZEyAN4zYV
         Uecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788492966; x=1789097766;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+zh0O86jLlL5jpuk61M7Fd7ZM3oooHjkLfEhTz55GQ8=;
        b=XtpScUznWjseXMArva9j0gVct3PXfRuF5Owx51L2uywKGXgFwltZnW4EfQP+XCPCDC
         WAGYrEkxwpgu/+7UU4wASynLq8x01ELEmM7274AP66kAn/25ILsqakOQjBX26t3iuEtW
         C4xiPVe+iM0HAq6+5hSLdwwjOwwqDw3O/e1KVUppvo5bQbS4+UJgo3M6XJqNOPV7KXHh
         /6bYltxtj46UCRX0XykOpDB4Toihy/VV1QN1MeXfipKi+2xRn1DOr4wLDsU68w2Ykpht
         99VrQDBDO4/WYxPjAk183xIY7BTWXQ181jWwu6n6Yn7qeZJc5JdFJpfPgvV/fyT4KscT
         Rkyg==
X-Forwarded-Encrypted: i=1; AKwUvBxVnmSFGm5c2uT+BWDJqFpH1D28ISA0rYKH0qSPVrHrB1LBvI1L2EdPfoB8X+w9XENOKXhr0nw=@vger.kernel.org
X-Gm-Message-State: AFuF++nAw/Nplq4hROqv/0TAWpahBpsKvgAxaVdF2Nl3BXJykicv4tvv
	JtkbzXKzheX/1N7P/LVk0CdogBsc7y9hBOCyRBwGmu7gFYuPzHp1nLMZ0qDLn8CSzRvwhiml+7R
	jtyHVxA==
X-Received: from ploc20.prod.google.com ([2002:a17:902:8494:b0:2d5:ca52:6c0a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19d0:b0:2d9:2688:8be6
 with SMTP id d9443c01a7336-2db126346b3mr48991265ad.19.1788492965386; Thu, 03
 Sep 2026 20:36:05 -0700 (PDT)
Date: Fri,  4 Sep 2026 03:35:28 +0000
In-Reply-To: <20260904033543.2635540-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904033543.2635540-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260904033543.2635540-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/2] tcp: Do not allow buggy transitions between
 ehash and lhash2.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, 
	Michal Luczaj <mhal@rbox.co>, Hyunwoo Kim <imv4bel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The following state transitions have long been a playground for
syzbot, and recently AI joined in, reporting a lot more bugs.

  * listen() + shutdown() + connect()
  * connect() + connect(AF_UNSPEC) + listen()

All the fix attempts would add more code to the fast path, which
is not worth it.

Instead of playing whack-a-mole with these edge-case bugs,
let's disallow these transitions.

Note that unhashed_state is placed in the 4-byte hole after
icsk_pmtu_cookie.

  $ pahole -C inet_connection_sock vmlinux
  struct inet_connection_sock {
  ...
	__u32                      icsk_pmtu_cookie;     /*  1208     4 */
	unsigned char              unhashed_state;       /*  1212     1 */

	/* XXX 3 bytes hole, try to pack */

Reported-by: Kyle Zeng <kylebot@openai.com>
Closes: https://lore.kernel.org/netdev/20260731140512.566464-1-david.lee@trailofbits.com/
Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/netdev/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/netdev/20260824033331.1084971-1-imv4bel@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_connection_sock.h |  1 +
 net/ipv4/inet_connection_sock.c    |  1 +
 net/ipv4/inet_hashtables.c         | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 433c2df23076..903499581db7 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -94,6 +94,7 @@ struct inet_connection_sock {
 	u32			  icsk_rto_max;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
+	unsigned char		  unhashed_state;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6257459bcee2..560ca861b6d0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1253,6 +1253,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	memset(&newicsk->icsk_accept_queue, 0,
 	       sizeof(newicsk->icsk_accept_queue));
 
+	newicsk->unhashed_state = 0;
 	inet_sk_set_state(newsk, TCP_SYN_RECV);
 
 	inet_clone_ulp(req, newsk, priority);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae2bb..5abcb0debb27 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -803,6 +803,11 @@ int inet_hash(struct sock *sk)
 	inet_init_ehash_secret();
 
 	WARN_ON(!sk_unhashed(sk));
+
+	if (unlikely(inet_csk(sk)->unhashed_state &&
+		     inet_csk(sk)->unhashed_state != TCP_LISTEN))
+		return -EINVAL;
+
 	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
 	spin_lock(&ilb2->lock);
@@ -832,6 +837,9 @@ void inet_unhash(struct sock *sk)
 		return;
 
 	sock_rps_delete_flow(sk);
+
+	inet_csk(sk)->unhashed_state = sk->sk_state;
+
 	if (sk->sk_state == TCP_LISTEN) {
 		struct inet_listen_hashbucket *ilb2;
 
@@ -1058,6 +1066,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	int ret, i, low, high;
 	bool local_ports;
 
+	if (unlikely(inet_csk(sk)->unhashed_state == TCP_LISTEN))
+		return -EINVAL;
+
 	if (port) {
 		local_bh_disable();
 		ret = check_established(death_row, sk, port, NULL, false,
-- 
2.55.0.1003.g10538fe699-goog

