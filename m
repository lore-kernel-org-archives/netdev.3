Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491927;
	b=D0OS1SJ14HbC7jqjx5nNkO7ZKm4mjkz2kA78EEZZf/FEH9u6q7rWb2JITWvn0UOeKXy2
	 xdPy8K23Ap0gQSMcpo+A74qaZW1kGQz2u3QMV0Omudh2zeAaCcl74ft4lAONzo138f/WY
	 GTR6HvVMR04s5pNVtKy09PH5U3JCdfw4y2+Z5kdCOm2bTmFhhC2m7DpxigvFUxIYRB4jX
	 rHFlQQwj3FT7/MwEXRFRzXFTSjLjIn936kNsTYmTJeKH/RiDYRStlGxfy3UTj0EC/dJZM
	 e1ErGh4UF5lYGUZa/7KgC+tOi77FqlebmCFC0f1UeUAEXwsqlzJfbruByMgCKjS1gzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tj/xhp8eO5mteFOQm/83WBlltt447nmI1KW5Yxilil4=;
	b=GbBhTh/+MDsUG+beeQlqa2aWVzhhJRQnyblH+2caqGt0b28c4bfmWp4AzfsrQz3Jejvo
	 uRbda5jNPHFMStCyIa0FpqrzC/ODMUaG5BoPM3BALGmQJ5v41REYjDacq4JK0vtFFhTva
	 a7igXpC76SedPuk+szWlEnM2BHLku5i7MX3jlVRjQAUEjHjaDxv10hbpKh+uxytcmDXQa
	 DDcvtH29qZyivmGLlTkMtVPHdj+4TTK7siv3yN/hFfQAKKIKtyjv6oHeP1RzUZFJUzzYI
	 h10FOekFtXN/phf1tuGiEuLZugEDq4+d6YbNae5m8Lj8nDEjKwb2AzmM6Nl1KAXzmJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j4hTvYuP;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C360A2611
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A47C360A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j4hTvYuP
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so21836785e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491925; x=1793096725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tj/xhp8eO5mteFOQm/83WBlltt447nmI1KW5Yxilil4=;
        b=j4hTvYuPLNfyDBDbJizvNiuMcA2oY43YtEk073ByNMa2aK8bGry1sbkTt7rjn9xgo5
         1+w7hlmJPHAgkob2hAzu9yz8uKeHbnYvMyL0fkYGSJRDD9sEe+s/Y+aTouzUYrUbmGSp
         jHYPQA+Mg7MoqjSHpNytvbettrrqoZVMA/K8kJvedx/uDntC9u+tsRxdYQZZSIMbAFMX
         2eN2Z2rilh9mKU+LK/jAMxgNG86LC+F8KW9p7k0gGSsyFZMQpd0RkPdOOxk2WINvH5/R
         dPfFTwL8WMl7ABI0FJrVGfrKB/V9rtT+3Xn1sQLg4BBFaWBN5PLro5U0SL4w6hPmAADo
         l1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491925; x=1793096725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tj/xhp8eO5mteFOQm/83WBlltt447nmI1KW5Yxilil4=;
        b=V4ao9Inx2/afDk+xa2VFL8ystWHE0cwVtVfnL9ortpx/KkgvjPRJnutSUft8wdcODf
         fzPYj2l/KvXUT/Y3AIWRiEWnnBPIHyyb0+9r4MMKqy+ABX6EeP0KE8LpaRRiZAtHZ7Kw
         6gk31iXtcw2O1BzUPQ8DxxuslwFgHLiOTAA0w6pX3ls3tBvkigZK0xVrkwK41mGAlV9g
         Mzy4qTl/GvmVLc4dC2yxz325uYACwrJs9uzGYF3cLQczCVgm7xZLknscXmEHjGer/gAf
         Hy0/K3d9wJbfM+KZ5SMnmN+QKufGoYgFpFuIWdtEonD+f6bL6mG1NYF/OOsO2KYYiglk
         IXwQ==
X-Forwarded-Encrypted: i=1; AKwUvByq0MICsHV6vnYbJ7b095Tz929d7egtIqd20KC6Ds7J1xrlgbBqFnN+u8gRfEs459CdxXRdsL4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrRBV/Ywpj6Sis0q2tyGif8HaEzmbkF5U/m3eArUQit7Y613UB
	1eQf6GHG1SKxK8vADwtAEL+KFT/oF0+A9u/HPXn82lkyzwisud0KvPsu
X-Gm-Gg: AYBFou2Al230flxq7qxZ0oHgpdgeY+SwslBmN2t2Qg4Su8dvoisvfqt8/gKsNOVDPPF
	RZu7G68NBvwTnHVpxNdZO3egk9IaavK+ur3EzRH8ZVh83rffZ88l5kIrWv/QvwHBsWDnsW+mN1d
	Rt0qTKMWSIBxqzgqwexex/ka33YPu2auevbw+d2fKD+A3S5vG2HTaHPKcC5Kil3KVaeM5lykzS7
	Y93GIjCMllvK1kta+RY6qz3cOUAaF2Ih/oxq/vgIMsIfioKg7yOsVQ3KyzyarZKLou7YqEhDHpk
	DC8SumSqpgx0udK3AZIVrKFltiwnrt2aloFGmM13zxglnuftB0W4gBQFBaC9Z2G+xr5/LzBuU2p
	zBqe7UxQcielFRhRtA8OhYgPhXTQF+dPqpJTGl2ipniA90zsIFVI1udLuyB5BtLCSqSnQkzrtI/
	+d7Qjn2R1y8xFp6oFtUADd5Azafe7GmUsPD5pzCeLH59rqqIIN3tV/ss7CaT30yiSJwfoNeMauI
	ChaN1l5LeMHTrRnfuiSg4s3i4NFhNPrX4WCYxIJ5J/KFw==
X-Received: by 2002:a05:600c:5248:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4a1e57b67e1mr140123695e9.26.1792491925013;
        Tue, 20 Oct 2026 03:25:25 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:24 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 4/8] selftests/bpf: Test verifier filter for ksock connect on LSM attach
Date: Tue, 20 Oct 2026 10:25:08 +0000
Message-ID: <20261020102512.518479-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that the verifier filter prevents bpf_ksock_connect() to be called
in a LSM program attached to security_socket_connect() as it would
create a direct recursion. Also checks that the other LSM hook unrelated
kfuncs can be called.

Moreover, checks that calling bpf_ksock_connect() is prevented also from
security_socket_sendmsg() as it would allow to create two BPF programs
that would call each other in a cycle through LSMs.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
index 740ed370d28f..7b5d118e5750 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -48,5 +48,64 @@ int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
 	return ret;
 }

+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock_connect is rejected from socket_sendmsg LSM hook")
+__failure __msg("calling kernel function bpf_ksock_connect is not allowed")
+int BPF_PROG(socket_sendmsg_ksock_connect, struct socket *sock,
+	     struct msghdr *msg, int size, int ret)
+{
+	struct bpf_ksock *ks;
+	union bpf_ksock_addr addr = {};
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		return ret;
+
+	bpf_ksock_connect(ks, &addr, sizeof(addr));
+	bpf_ksock_release(ks);
+	return ret;
+}
+
+SEC("lsm.s/socket_connect")
+__description("bpf_ksock_connect is rejected from socket_connect LSM hook")
+__failure __msg("calling kernel function bpf_ksock_connect is not allowed")
+int BPF_PROG(socket_connect_ksock_connect, struct socket *sock, struct sockaddr *address,
+	     int addrlen, int ret)
+{
+	struct __ksock_ctx_value *v;
+	union bpf_ksock_addr addr = {};
+	struct bpf_ksock *ks;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return ret;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (!ks)
+		return ret;
+
+	bpf_ksock_connect(ks, &addr, sizeof(addr));
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
+SEC("lsm.s/socket_connect")
+__description("bpf_ksock operations other than connect are allowed from socket_connect LSM hook")
+__success
+int BPF_PROG(socket_connect_ksock_allowed, struct socket *sock,
+	     struct sockaddr *address, int addrlen, int ret)
+{
+	struct bpf_ksock *ks;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		return ret;
+
+	bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+
+	return ret;
+}

 char __license[] SEC("license") = "GPL";
--
2.43.0

