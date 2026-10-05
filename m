Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6374CDDC7
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215151; cv=none; b=K5N5Y3AAPZ7kLQ6AnKx8NSO4qOlW1Liaz6X977INJBPYyEKztb+sx3dsrKd3Xrq7oh7RTe+YJr6KajBexr2WdUrVPZMISNr56A2BEsPzqTBNQrnL0ap6gFrFBt5kMZ2y/3rULMoFg0pxbqZWCwRTeASR6EHBb4K//Qbkf9S6U/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215151; c=relaxed/simple;
	bh=z5cDJQI3/M+plwLU9Hcfu1muYuJUuwYatY6RB/hqIgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ovxRlL6gk4fd54DPWJ1RFr0szfhT9eQdMT7OpFNE35uQTWIMsyZHXBjDLSunc/+c+3ApeY7YZLjAXxP+pAZihICxB9x2J9GvaOa/XJlA9zaEf7vbHd5pZCQ9tbZpTU2wKxVWxJ+KmsiENWAzwtP8kigUacLBBDELGV9Ti2ObD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USJjQk3/; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USJjQk3/"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so3513711a91.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215145; x=1791819945; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iU6ETzFEO6tgjj/RV5i5RcrfDfOqrMTPXE0uUCNCBIQ=;
        b=USJjQk3/JQIg1FJ+pXLwFMy4Z5GCQBYVbEgknKaFoNA6jGP56liTXkj1bhEf3rkPIx
         /OxC+C6YYhZpaFEgXW4P1sahsekIVETI4XW7trNGXb3h1aJKeBi2ZvxBDQfGnc+xqIAP
         dL5rpkmGeBTo4KhtDwzL8ES6Os1o3c28v+DIstZ8m9PYeCDqGxgjlP/OM9vwsnKXukzD
         DshR8QVavxdxX4f+2nIT1uOUrF1tFHFdAxo5Bn/g+YiJ5Ny4rc7oJT24bzF/7tUIT9QZ
         v4cJrQOUg1bXHel43KG1bXV6ggv9PdtAScE6lbEdlf0OFzkJbRccEOw7qfpyCBccMQQE
         Dk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215145; x=1791819945;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iU6ETzFEO6tgjj/RV5i5RcrfDfOqrMTPXE0uUCNCBIQ=;
        b=dmignPraN6zp7qIYxElfdp5pzgsGDBfmWUWaAHYy/QbQ3qchXctYkJRH8Y+R2DHK2p
         LKJges0PSnUXxZNq7ttTeqXh0eDAVjxB2DlX5p4MoSs/bhiwnBuKWpDCROkVeCWp5nUu
         6pQGm9iEmRXlV0LxugEAHeZRJu2t/pMZfcWWNfY4CU2enbP+96enQZlnOQxcWldNLGB7
         bV58ONpXiDMEtOncbpNixKhVBzH9m81qlQ94DJbO6eIV2n6bqndjFG+yep2BKEzLn4gq
         LZynWrFtfBAuV+JH5KB326xMOb7l30dSHGMFGKOMzBJ66Lr30CjGe3ZWwldK6+eXXH0J
         Pn9A==
X-Forwarded-Encrypted: i=1; AKwUvBwphCfYOB4Xzgj2JPpSf6DGnx8YQxS71m8WPby8uvprxzfMM/G028eA40KT7LA+BYLvOCVQWVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4gYxR4SOW3Xz4aTDHNhQs6VBOwAu7FdRRztEJk2hNlY7D7HZr
	pDe0uaAJy6Y2i5q8gjjZauAct9cjf/rFdVhOJz9HZy6bhpfzIyo4PSWxfXzU3F36UePuujUXqDy
	Eolh+pA==
X-Received: from pgby20-n1.prod.google.com ([2002:a05:6a02:6514:10b0:cc7:a87e:e8e5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2804:b0:3a0:50bf:d497
 with SMTP id 98e67ed59e1d1-3a6ce5fa39dmr10345180a91.3.1791215144654; Mon, 05
 Oct 2026 08:45:44 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:49 +0000
In-Reply-To: <20261005154533.4147685-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-8-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 7/9] bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
to bpf_tcp_ops.

MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
so we should not allow calling __tcp_set_rcvlowat() on MPTCP
subflows.

Let's disable BPF_TCP_OPS_FLAG_RCVQ for MPTCP for now.

If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
extended to properly support MPTCP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/bpf_tcp_ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index dafe2337f9fc..c73d3478a8d5 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -347,6 +347,9 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_sock *tp, u32 enable, u32 disab
 	if ((enable & disable) || (enable | disable) & ~BPF_TCP_OPS_FLAG_ALL)
 		return -EINVAL;
 
+	if (sk_is_mptcp((struct sock *)tp) && (enable & BPF_TCP_OPS_FLAG_RCVQ))
+		return -EOPNOTSUPP;
+
 	old = READ_ONCE(tp->bpf_tcp_ops_flags);
 
 	do {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

