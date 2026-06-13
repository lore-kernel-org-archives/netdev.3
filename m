Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A713957E
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312445; cv=none; b=P7PYyXrnENR1JEYOWAw9RyKcN4uRoOdb2j1TcqX+6PqnSdSCFLUBFrpdeulVv2/kFwfgnzttMaRDRA86P+12Cy/Wcsr8qLgCM1kpHVONpndUUGt0PWpgc/y/16xa39Ge4vjixBNeogphE+AAM3/Fhg/LFHb24gJkvone4ryVg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312445; c=relaxed/simple;
	bh=LiD75WaDj/nNjJkDcjE9w7295/2dOZf6vbD32NlQZI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZvQGE2WZUJvAggqhlZSENqKa7ZWx/wA7Cj6Q7FILpG+fk/HbgbKnlX0rCTUYNX6b5wIM5iz+CqwgBvJ6qCeeuG27uedtOA8we/V6tu6aTexyPSeUavHIMD4vng6ZdAY/Yb4160dzd7hG6nAEHZA7MDBpusZyq9owasewtIYo/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPPCagDl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPPCagDl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2c665easo1386678a12.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781312444; x=1781917244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUo9GSEHGqFt/lJLpzmBjgRQi1upn5qNvml1cjFSyZ0=;
        b=mPPCagDlRIwikUkztUmcWghcymgi7GtNRXF/Yih4y66pCpMN4MEKWjlKhamMKaSlNa
         ApboMRb3nW6cmBg2VqJmP5UVhEHfjq1j7v7VmCbonc6Yuzrw3KRQK7VFvCmSIQW879JG
         GAVHPpTTBWPCHJFXM9PEsB73S3jbYsYUbPfVJOR3VwNKxtzLatvRDuWYExaqhXraYgfz
         aPTLtLxgYpgEGzET1uGsVem/ZQdnAnT7aupuFTbiF40rt/97JT5/0wUIu9yiEiWqEGaM
         8J+GBPiSr3aeCmonCqDMfXkc4r74HLfsEA98lI1U8dJYo5FTL11ko4AUzXt1qi5fIJeY
         PG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781312444; x=1781917244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUo9GSEHGqFt/lJLpzmBjgRQi1upn5qNvml1cjFSyZ0=;
        b=FuKUthVJl9Om9Lp/28gNJXnBryEHpeqtWnTJ/H//W/BqsNUTkHQFUgIHubew/PM5V+
         tPg7i+kZgZgSlzMIsDzNgC5Xppn/UloWpq2+Z7xLIGhScHELeji0xLXnKKlLF1M+K425
         5oRsYttEd8gLfWV2Z2SXUS/qYliYWQg3SC87LmUC3T6zL9hU2VvUSsswFBqTWw8FotCN
         6t/kRT7V1cwOwhrKkaSlvCALGZR7aoHUOJNhNChHK6sZolvMivVXz1CfUkZrRiCkbuS1
         QiRmOl22u9ZQhsnJBh4oVhmwvxul+mRXTTfPSQu2X9UI0qJn2ky5rZcw64rdtRQ/wPOm
         7dnA==
X-Forwarded-Encrypted: i=1; AFNElJ9GF2PTKe5gQwtH/w+eCBnoSRslDiNfyCl/WwljQBCgWmuID/T0Svsi0/WAa/pmaKufz7BahoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtYdwjofcaqJk6wGF4ZkqnoUmNQwlPY37w/SumJga1FNYvhzZ
	FE4DUCjCw1Wmmv2LAaXJ2vQfJLuunHBu03OPJt92RhUocV4EJlE6Acl1f7nYicLcnpY7syqM9P+
	p2GCh2Q==
X-Received: from pgoe18.prod.google.com ([2002:a63:9a52:0:b0:c86:4cf0:705a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:115:b0:39f:3efb:e888
 with SMTP id adf61e73a8af0-3b79636aa3cmr2144573637.25.1781312443829; Fri, 12
 Jun 2026 18:00:43 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:59:59 +0000
In-Reply-To: <20260613010039.1362312-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613010039.1362312-3-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 2/5] bpf: Rename bpf_kfunc_set_tcp_reqsk to bpf_kfunc_set_sched_cls.
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

