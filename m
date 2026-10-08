Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395238237A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429371; cv=none; b=M+2ZNVYB2LLQOj8Y3Jgi+i3Ita0QN4tNCvnelrgW0Vb07XkOh/3vvXpJ26ilIu4KARTeK63iFarGTUBHfnEXy/5Nhzkr6UcT46k4kpo1LClgfbKtPRMgbK9tbrUnMsl+N4XTjiP0h2qivTLIPwiTvCXh7Qf87K2ZFyj2OkVZpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429371; c=relaxed/simple;
	bh=CPZHx6nPeBH37ffstlYZ4H23ROTe5Ar23zFui96a2SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tmlFBZDpGEMHwp0e3tK4M7MPpv8gZJJ60iW5Xo9IJwtCwIchPpPHjFA7FmMc7swF88PYd+YTkeTtOVE0swjjvodRyeqVo6XaqpJtV/etpXId9HZuij0mbg/M07fCL29tL3+55zCTjJi6uvm8bo7KChG6a3abzfskFQrPzBoj5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LsiZc9nI; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsiZc9nI"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d001671a54so57376275ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429369; x=1792034169; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9Uw6ZReSMOu9UuqEeLaMzynTv5QJv73MooXkF1Ett4=;
        b=LsiZc9nIpBwVMkrlGEMQGE6oW/5jd7SVyPWx3jX2CExdRgFdW2HbCqMfTigE+uqUjF
         z9FpNmMXqrwMepjFgL0l5+fc7k+t0ARF0/92c1eDEhwxs5+F2/Tyo1UC7kKhgGL8sNBH
         KtRyelofTI19kHhrpQldg6NzBNYhNgMlE8zLP47UmQFwqnVrHNJhxE4+sHGnMJyL49Zv
         km0W8j0ocs4BzWz0tBao6V4klAXkP1hansfvRSERFbDKutHRuEvawJrdd+z1Ed+NDQSj
         fPIdvBP7D/a/5rf+EKDVVjw7iBDOFQ5fwhOE8TRARu2VznYSh8yOYgv0WhjQAo3085kJ
         Cs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429369; x=1792034169;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9Uw6ZReSMOu9UuqEeLaMzynTv5QJv73MooXkF1Ett4=;
        b=FbPV9A8S5Za0Kr69R4hpyo7APm+LWK+VDqek0/N/3aHnZJwvY8JMtVRCclJ4oa8UOY
         eyRIauuxB4w8vq+UfYwgkT09O+FRkImxrIhC5U896hnYFcyo0HrZNtov7CrKEMudc3KP
         ZyFwM3KZesByx36NPJS/IPmRLMmJnhqrFr8jMZhmrYvV1zbyF0SLGOieCYXIrtrPPmle
         q/LMON3BjPCgVKRPRFKToxMUVKXMxO0uoSuwvuABIDB5KyszjcV2OnNmADs8cIhv5RsD
         +w0KgGufzZz07lRB3ueNC3rN6WEx8WGsNhik7824QFg3q7Nka39Ws6UspXT0NJjN21yS
         BTkA==
X-Forwarded-Encrypted: i=1; AKwUvBweNSddANdq/B7ClRK/h7sif0B0L4efq8GunXDCO3XC+qo/PyCEKNmBP8QqdpilgvgZ1UJPwW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrXpA8l4riaumsgyHmRdOq3Zh3sb+VGM0zL1qpGpQujJBi8ujz
	ox8x1DmOf031CjNkjOLL1MUVn+MXoxf1Jn40zrvul9ckCx8AFVOvhAoNNwKXY/R7zzq0nqYIwP5
	5Ol/RKg==
X-Received: from plbjw19.prod.google.com ([2002:a17:903:2793:b0:2df:4aa4:16d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1209:b0:2e5:467a:7a6b
 with SMTP id d9443c01a7336-2e6003b6934mr35307855ad.10.1791429369352; Wed, 07
 Oct 2026 20:16:09 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:23 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-4-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 03/10] selftest: bpf: Use bpf_tcp_ops_set_flags()
 in bpf_tcp_ops_hdr.c.
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

The next patch guards bpf_tcp_ops callbacks in the fast
path with per-socket flags.

Let's use bpf_tcp_ops_set_flags() to enable flags for
parse_hdr, write_hdr_opt, and hdr_opt_len.

Note that BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL and
BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN are used on the
server and client, respectively, for better coverage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
index f3e3dff13784..706e94d794e4 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
@@ -18,6 +18,24 @@ int found_cnt;
 __u8 found_d0;
 __u8 found_d1;
 
+SEC("struct_ops")
+void BPF_PROG(test_listen, struct sock *sk)
+{
+	bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
+			      BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL |
+			      BPF_TCP_OPS_FLAG_WRITE_HDR_OPT,
+			      0);
+}
+
+SEC("struct_ops")
+void BPF_PROG(test_connect, struct sock *sk)
+{
+	bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
+			      BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN |
+			      BPF_TCP_OPS_FLAG_WRITE_HDR_OPT,
+			      0);
+}
+
 SEC("struct_ops")
 void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
 	      struct request_sock *req, struct sk_buff *syn_skb,
@@ -78,6 +96,8 @@ void BPF_PROG(test_parse_hdr, struct sock *sk, struct sk_buff *skb)
 
 SEC(".struct_ops.link")
 struct bpf_tcp_ops test_hdr_ops = {
+	.listen		= (void *)test_listen,
+	.connect	= (void *)test_connect,
 	.hdr_opt_len	= (void *)test_hdr_opt_len,
 	.write_hdr_opt	= (void *)test_write_hdr_opt,
 	.parse_hdr	= (void *)test_parse_hdr,
-- 
2.56.0.360.g66cac248cb-goog

