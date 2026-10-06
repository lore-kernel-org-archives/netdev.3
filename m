Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DE4195C8
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314782; cv=none; b=Hcot9QRPTsJvTWzjwLqB0MFff/ANrX/R7NHlgOi/pN0UgPA3v3kHD7LiyCGgxHR27Ix9MHzyTLKLMXJ3aJZV6Qjeayd+4K0yeLGrmfEoTsiVdLdruc4xwsZQDyQVys/5K5l/cme6Wdf2osBOZdk9sJH4e+OUx95SvknOqIODysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314782; c=relaxed/simple;
	bh=aWao5GoSyeYsVEnRkw2XxTV0rOFFmhXm36Vs3Xcr6LI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JSG5+TrvXHuDRn4mPKhgYRK4PjqZNJrh7H5Npk0HCz0zVeWBHtmMk4wrdYWIZhhZipHI9Hqp4/yx6cl+cbS3Pr7v48FYaUQ0GwC94DqsIV0BNGoLYLiz9CgkNg4RIRpwffPlCm1bNa+j0dZAED7HlRUQYwDL+TiVZ8EZwThfBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YV0RmtFq; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YV0RmtFq"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so3356225a91.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314781; x=1791919581; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nTDws0c/dI7iiZeVn4428bfcEvuk0ywfHmaDzeWTq4s=;
        b=YV0RmtFq0eitnC9e2xnqLYSfzOKKo7JnL6WI4EkXokRgerMskz5tIYNPZZwQm0YHHf
         b4ZtQNa02Ha6pt/wr/WwfyYiD7GY8E/FLufMODvwOYZoz/ngznvOTuq3N4Y4GT6rTyBj
         2UUqJv+OuxwciTQFUCoz+Tri2uKxAVXANlkYWuIgpelFx45Ep2QjiqDh6D2fSZS1A/Z6
         b0bF3yhDhe4byJ2FYp+PKmux+YhfJZTuqwaYR45lsUPY8/Bxns0conJqQHMzY4c4QQ1+
         cmrucuGUvX247+gT3/AQHvzJAbqKwsI+6PWXUuJeovD5pl81C9NqNUOZOjADXU12+4VJ
         eGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314781; x=1791919581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nTDws0c/dI7iiZeVn4428bfcEvuk0ywfHmaDzeWTq4s=;
        b=vVEupLHrW3Nf8EnNYI0oc3Pyiqtp636xVG6f9QfjhNqsDy32RX9nHzehX1E+HtaUy/
         cKPbY4EFdyoqMoxImVRpNlooa4frdAD/b5eHIy13sj2yhBC4XVqdRBWrsYlNhGn0QXtD
         M0L0ztgzlyNJwU8f6/2Y2/4/gsB9mMFBIdP7Z0iAGDQ+Oe1rixquOAQiYN22ORkyk57q
         /o5pK2w9LZwC+HmhPqVevo7FzFvD01XvjQxWxk6tQk8PbGIPuYzcqzfj0tiKCoy6yGeq
         CTcWx8mcXjWOqIQsb/NngieFY21Qro4+KT28JWwdwvUpgCFXMyLBiOn1sFh3XaZB5nEt
         7Fyw==
X-Forwarded-Encrypted: i=1; AKwUvByBFvCdBGADR3c+yx+ntflLz1YNgd8V3XedRjw8bI7WPxVIx+Md7y+Hc9jayob0F6zNz+B1x98=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3Nw9jAAprTbNBE4LBwu2U2mjD3pPiN/Hi5Z64u337Kt99rQOZ
	DD0eFssjykEX9zscoIdI7bXUm7AZyAtbEIp8mWFE++0BnBE3S3Lsh0PZ/+PA7gNlzm9eVLxWhVg
	Ijx0Hgw==
X-Received: from pgmm8.prod.google.com ([2002:a05:6a02:5508:b0:cc7:d071:a17f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c7:b0:3a7:971:7470
 with SMTP id 98e67ed59e1d1-3a8a11b47a9mr155394a91.47.1791314780917; Tue, 06
 Oct 2026 12:26:20 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:27 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-2-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 01/10] bpf: tcp: Convert deny-list for
 bpf_{get,set}sockopt() to allow-list.
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

Currently, four bpf_tcp_ops callbacks are not allowed to call
bpf_setsockopt() and bpf_getsockopt().

However, the deny-list is fragile, and when a new callback is
added, we might re-open a can of worms. [0][1]

Let's convert it to allow-list.

Note that it can be written as offsetof(,X) <= moff <= offsetof(,Y)
but clang can optimise to similar code anyway.

Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.dev/ #[0]
Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux.dev/ #[1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ipv4/bpf_tcp_ops.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 681fed642999..1ada3b781bf1 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -210,6 +210,24 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
+static bool is_sockopt_supported(u32 moff)
+{
+	switch (moff) {
+	case offsetof(struct bpf_tcp_ops, active_established):
+	case offsetof(struct bpf_tcp_ops, passive_established):
+	case offsetof(struct bpf_tcp_ops, rto):
+	case offsetof(struct bpf_tcp_ops, rtt):
+	case offsetof(struct bpf_tcp_ops, set_state):
+	case offsetof(struct bpf_tcp_ops, retrans):
+	case offsetof(struct bpf_tcp_ops, connect):
+	case offsetof(struct bpf_tcp_ops, listen):
+	case offsetof(struct bpf_tcp_ops, parse_hdr):
+		return true;
+	}
+
+	return false;
+}
+
 static const struct bpf_func_proto *
 get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -221,22 +239,13 @@ get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
 	case BPF_FUNC_setsockopt:
-		/* The sk may be an unlocked listener (synack path) or NULL
-		 * fullsock; disable for members that can run unlocked.
-		 */
-		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
-		    moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
-			return NULL;
-		return &bpf_sk_setsockopt_proto;
+		if (is_sockopt_supported(moff))
+			return &bpf_sk_setsockopt_proto;
+		return NULL;
 	case BPF_FUNC_getsockopt:
-		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
-		    moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
-			return NULL;
-		return &bpf_sk_getsockopt_proto;
+		if (is_sockopt_supported(moff))
+			return &bpf_sk_getsockopt_proto;
+		return NULL;
 	case BPF_FUNC_get_retval:
 		if (moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
 		    moff == offsetof(struct bpf_tcp_ops, rwnd_init))
-- 
2.56.0.360.g66cac248cb-goog

