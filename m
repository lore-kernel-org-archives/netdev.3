Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947652C032E
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223492; cv=none; b=dLiTMlZH8rbO9hQd08fLsp5tWFLH3S2a8kkBHOYjP+rZLZP3GqcZl55ukLwvZvVHAvb65+/k2zi7VAvt5y0k4tiBqPwYZkfUuPaz6sfytHejrK73AZKCNDmgUrJ5ZDWIZ8PNIRNkWLM+S3A+M8GsPy1A+SP6QszEVkG+eNGDv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223492; c=relaxed/simple;
	bh=LiD75WaDj/nNjJkDcjE9w7295/2dOZf6vbD32NlQZI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kh9UUWo7pbtStPf4tTtaWs+CWQ3jZqSV+2dbIdnPvqrdAvCzbzwnAEeAuZujUZaToW080g5GScl6Em/L/DUnh27/12D5DahBGylDsc1GvegA2wfEmtBMW1lEnLSf+fBaowpvp9yy9Ai92nUt81j0gv2rajArKyW4GBRZz16YKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjOg5Smw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjOg5Smw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8582b167f7so192775a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781223489; x=1781828289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUo9GSEHGqFt/lJLpzmBjgRQi1upn5qNvml1cjFSyZ0=;
        b=EjOg5SmwXGlma9LSuW0WsqxNb4NPj2F1BL80dI2GDXBxJQ+dsBrZGwHvEzZAcWLTM/
         Jg2SsUa1HDSYXDeampATtnd8+49wUPNQk7Zcse4qMbMAxI9AgREG1BqGATJhbAX2rM7R
         eWg9aJNMJmoI/REkWSEx383KV/gZpcD9zk2YrOd/FTw0ZbJP952G6bOChHExD2CS7Csl
         VV3A/CKgnV28X5YT3nbk3vlVvXl0qkbnwPDNhv6Qh9Kz30og0U6UERZWbXVf9+rWjYl1
         ZIEvJflw3m74iPuy7qxHv4/Z0xOUBl62HnLnOx4Pl5Jfv+bQVxP5rXkQX+TLOh1ONT78
         +kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223489; x=1781828289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUo9GSEHGqFt/lJLpzmBjgRQi1upn5qNvml1cjFSyZ0=;
        b=S4VShnBOcwxAZ32e7ORbqtmP6cH4syH7Tw3Tf29fp9crcFAbHkRWNWdmlhCu7JrCBr
         Yu2M/RfiOsi1Z2D7FT4tngQet0aU79YTnblKQ/SaFWlM+E8BvN9GgMXZG3vXGJmtO1Ls
         gxSB4KdgH6T/1+rQcqZ+xToQkBsHWAbsgdBRokpKtnCmZlSd56GeIwk7hn+/2vxTicaA
         +JxtW3kVeceSyM7TqMN17SMnZ5c2rYvdSvI7/ijdkgitB4+VtkLrAcYfQa2JIO9/OYAs
         SNaRU1mwyJiHp27jDE4QM/m9cUEVSNEYR92n7ncvmtVMvFutGLzVpJMNRI6unj6VmiJt
         o19A==
X-Forwarded-Encrypted: i=1; AFNElJ9/ZTpHzWEekGxgO7jcUKTJrsljllts4WdsjirkhYyAIGygd4yKzxCEojQ7mZ0P+eoFof626hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzhehiKSGqfwxy4oqqWyPMwDsYMx5HHvk0BuNdCI+bkcRmv2Ft
	rNn3Vgc0yi8uKACyxgq9mV+Fb3HBgn0wlrLFRuL3zMvBAtJVYH0CdQupGuM+PhysgHvZO32RPL3
	C80wPkQ==
X-Received: from pgbct10.prod.google.com ([2002:a05:6a02:210a:b0:c76:651e:6d72])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:210f:b0:3b3:1a00:1f4a
 with SMTP id adf61e73a8af0-3b7840857c4mr629804637.43.1781223488593; Thu, 11
 Jun 2026 17:18:08 -0700 (PDT)
Date: Fri, 12 Jun 2026 00:17:33 +0000
In-Reply-To: <20260612001803.23341-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612001803.23341-3-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 2/5] bpf: Rename bpf_kfunc_set_tcp_reqsk to bpf_kfunc_set_sched_cls.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently bpf_kfunc_set_tcp_reqsk is registered for
BPF_PROG_TYPE_SCHED_CLS.

We will add more kfuncs there, but the name is too specific.

Let's rename it to bpf_kfunc_set_sched_cls.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80439767e0ee..acdc66aa4f27 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12498,9 +12498,9 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 
-BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_KFUNCS_START(bpf_kfunc_check_set_sched_cls)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
-BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sched_cls)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
@@ -12526,9 +12526,9 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
 	.set = &bpf_kfunc_check_set_sock_addr,
 };
 
-static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
+static const struct btf_kfunc_id_set bpf_kfunc_set_sched_cls = {
 	.owner = THIS_MODULE,
-	.set = &bpf_kfunc_check_set_tcp_reqsk,
+	.set = &bpf_kfunc_check_set_sched_cls,
 };
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
@@ -12556,7 +12556,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_sched_cls);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
-- 
2.54.0.1136.gdb2ca164c4-goog

