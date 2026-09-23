Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914947887B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199450; cv=none; b=WnJXE9gJdXFidvaDxXTnYzM46zEOrmUgOEODBAxJ9qD17Y+fX9kaQQkalEYgz0mcDsCVnZkaHDN/sQ519PzgE+pWibWzl/XAvM03xePpKA0XMlOLgCFyVsfOuzMPL2Ojdv39ppgn7dKYAPirvjhuj0RLKP0ihAEBkMo6Krsq8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199450; c=relaxed/simple;
	bh=gKYFBfLJVJUEpQ0adS/u0b8b2tFP7IzjSFz5nUXuXNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fL1XAEuWxdYuRjSGwGpe4xVe3jnQfgbQmev6qdk+oSgscvjoGa/eIIUxki0m5dXQ8sU12aM3eYIlRGyMWJKoc6IAkrfXfY7vmiDUYYAbyGIJ/uR/a4lsCfTk3Rlq6g4n0vg5tsJ3KQbpRIZdc/wMPYRVgtPrt3qTS6++OXzXB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhJgq+H1; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhJgq+H1"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso1443643a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199447; x=1790804247; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Y9MsF0lRPA5hIAPoWY4vCytE/2HcHQPyT3wBY48Wz4=;
        b=WhJgq+H1G+I0IenEi79K9rT7BHeR1NOXDVzf5UtJB4zurIjgF2TCcGphoDiPGXbAQG
         Q5Bt6MV3kSlWA5Zz8DooXwLgd+UkrA+9FYogTkq4ylesu+Fq+iA92c+MRpTZNS+glywW
         PbtoclfXITMVkFybjz3jwMR0HJ7VQNKcYvnruZGSWsTbI364lf6W9risUtMcAuCq3X5c
         QB6WuajqQF3FzzIYlzqwC+ByHubq0pySRuK7+pV/TPqE+2tkaLMErOwBGrikC/0OGcje
         lJUwchByEWPVKX2gxv2NRAvwcXcUZAFRkBouDKK/CrDOQCgv3jqBehFvU6S8FqT7JERv
         CpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199447; x=1790804247;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Y9MsF0lRPA5hIAPoWY4vCytE/2HcHQPyT3wBY48Wz4=;
        b=sr2x/RHZ1uwi5L4ipWdI4G8MZD8b1a/CCRMbHYsVyHeM0zcWgvOho/ymrFTWhZoYrZ
         j0hITA9ZQnP1Dijv+z0pQf/nOeCKKn66GoyZjkoQ3lF3XbY+KAsO9UJitrfpKJmuRj1j
         EJYK+b8qXKjJu83b6KVEr2bti/ffd6944vP5Iks3228IUYkzPg+4xRoGylvZo17e7R+5
         hUZnS4Frkx6DkF2OaE/Qiz9Dp/Fb/6kAq4PtQ/yxj+K3e6njyPtcxUplD0P/U/RhI2GD
         G+UePsoQUbh4N5rs6GvwRgdpd8xAoji+T/M2BvOvtSq/EDpke0BzVDJJRKHObQ0Vqpuz
         9pgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFej8kojTL45SXPKnid4yMi6vhaXOzDrKsIR+JOWfcZN8M8f+bVW33d3sJYBY4OZVZYywyq6A=@vger.kernel.org
X-Gm-Message-State: AFuF++lNuyNszBJ/6jw966HkjllhfO9JJLOTAynhSosHmfMCcIi7rrAv
	g2+AwZqP0ayhmrXquOZV4ZpPbXmF5XEUqT1XdjK6p2DJ4CBVL/78egu6ieA0yWmw57wEI9T9nLC
	PrZBhtw==
X-Received: from pfbgm2.prod.google.com ([2002:a05:6a00:6402:b0:848:5740:db83])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c18:b0:878:34d7:6a28
 with SMTP id d2e1a72fcca58-87e9bb85c53mr326162b3a.42.1790199447095; Wed, 23
 Sep 2026 14:37:27 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:36 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-7-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 6/8] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
to bpf_tcp_ops.

MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
so we should not allow calling __tcp_set_rcvlowat() on MPTCP
subflows.

Let's disable BPF_SOCK_OPS_RCVQ_CB_FLAG for MPTCP for now.

If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
extended to properly support MPTCP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/tcp.h      | 15 +++++++++++++++
 net/core/filter.c      | 10 ++++++----
 net/ipv4/bpf_tcp_ops.c |  5 ++++-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 07426e8641b7..d3cf655da9ec 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2932,6 +2932,16 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
+{
+	if (sk_is_mptcp(sk) &&
+	    (val & BPF_SOCK_OPS_RCVQ_CB_FLAG))
+		return -EOPNOTSUPP;
+
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+	return 0;
+}
+
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
 	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
@@ -2954,6 +2964,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 5feb99884682..f29c061bb066 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5588,8 +5588,7 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 	case TCP_BPF_SOCK_OPS_CB_FLAGS:
 		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
 			return -EINVAL;
-		tp->bpf_sock_ops_cb_flags = val;
-		break;
+		return tcp_set_sock_ops_cb_flags(sk, val);
 	default:
 		return -EINVAL;
 	}
@@ -6178,8 +6177,9 @@ static const struct bpf_func_proto bpf_sock_ops_getsockopt_proto = {
 BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, argval)
 {
-	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+	struct sock *sk = bpf_sock->sk;
+	int err;
 
 	if (!is_locked_tcp_sock_ops(bpf_sock))
 		return -EOPNOTSUPP;
@@ -6187,7 +6187,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
 		return -EINVAL;
 
-	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+	err = tcp_set_sock_ops_cb_flags(sk, val);
+	if (err)
+		return err;
 
 	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
 }
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 4b48711d92a2..b0cade34cce6 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -223,8 +223,11 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_proto = {
 BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
 {
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+	int err;
 
-	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+	err = tcp_set_sock_ops_cb_flags(sk, val);
+	if (err)
+		return err;
 
 	return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

