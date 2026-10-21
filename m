Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568000;
	b=nZ9JxiambazjCUQZLO2pvXuNx/QMqpBcHX9PAPUsWirGtefnsJZL4iaoXFEc6IetypNk
	 UD8XkRggZC5a/5PmdImVLJn4z7wnxlwcYWWj/+0TpFe8QtD55DsGUoJuaIaytaMD7hfJ8
	 HfnAXPr0nqyFdKnhEdXU0YIrudpp2Qbo2ly2GFnq+1bhcNkcufLp1RcpPwIXBcgj+EKV4
	 Wniz4Ih/m5DbgfL6BZelSj0Jd9RcBWB12AQN5UUUZ5e4a+GXRuNE+BwEm/0ZrJHgzv19x
	 LVjCmC+FNhQUIYS9xXtiDZRJrV0tRIpRcbiUAmxsQ8Rw9IpEtGQ2TMvemr0ujzcDh9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=epyalV53Yd1ayP1dh9BRgh3jBqUbmF5KVHB1Kw/mzLk=;
	b=Vt7j8ZCTCre/xUzTZlxpLZK6uybWT12/82UhKDGjJ7aq8xfCNA7BM3JoK+DOTabTSJvk
	 QJf0JjDmH4biFpQ0xe/dP6Iq/PtKQ3TMomEJkI61r2NGjX6zLh1jqzmbDQb06aH8o/AAd
	 hYLGX9T0eGLVIVvQ/ihjuFT3F2xHNu/g6Vv2iTzEjJCEVlIyHn/AMFQKMgYLxZpUqavfz
	 mkSF8H0ZiHi4h96cQ2pWf8PwBanCUL2Xu523CnLmDlANVXRkMzGyR0O6i3uVnd7MmsZj1
	 1hDToEOdaA4askoIoFXtlbVpDFkwCcIh0wNDiqZQDzDiLGE5zkJ1B28TtU4ynZXDfmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riptides.io;
	spf=pass smtp.mailfrom=riptides.io;
	dkim=pass header.d=riptides.io header.i=@riptides.io header.a=rsa-sha256 header.s=google header.b=bdLL6PKS;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9A606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68F9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riptides.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riptides.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riptides.io header.i=@riptides.io header.a=rsa-sha256 header.s=google header.b=bdLL6PKS
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso2915915e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riptides.io; s=google; t=1792567999; x=1793172799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=epyalV53Yd1ayP1dh9BRgh3jBqUbmF5KVHB1Kw/mzLk=;
        b=bdLL6PKSPa3VeSTm1ePhiSezv41ffNVfJB2j/PAj/vaHy2gQmfZIIRUI6eaY8aIQPV
         qF1G3RWUSxq0513CVEkBRnkxAyrdNXbNMAU9OvTNrqpU3QhmPk3s+cpkxLZ2xycepDIE
         ufUU/TrUzfJxQG7XqN2Jwc2B01oCZmh9oLqLGxsaf+SaXniEFbKY8sgCx6o8+qE55r6t
         AzvwXi4zJqUUMeZ55ncwQ+fgvyy/I422DQGviTqDMafERRv+BExm573DzW8ZKkBGqMY1
         F+HpKU5TiYdCBwzDzOdQtlfSSlOir1OIOJXx9EUcm4fBo36mFcuOU6UX7/dcOLY5G7fb
         bhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567999; x=1793172799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epyalV53Yd1ayP1dh9BRgh3jBqUbmF5KVHB1Kw/mzLk=;
        b=vUZRC2DNTtCxsnus/JJvhTjINaDZVFByGm+qul5q/FdhnY/5M7tvoManx6puMeszq7
         bb+4SaRhWPsGyNb0mfcV8bA7zvFRBGu0UX7OtI1SpTU/HSH1TMYTwT1LhV/d8Aj05vcE
         FkAEHp5yUBS9bD4Us/kbn4qH08pTfFK3qKo54cj1HIEh+u4jaCfL1FwU2ZJuSbHSm6FG
         7k8NQzYRJAndA1D4pfehElrKIP4Oo3Sgrsbt1Fm4VyZND3zGzWSw6SeQ8BC4LPfIUF/y
         CmWOtptp/bLojYb8IjtegSo4cAqeYBuNytyevGIRW7amKPtHjDgsWvXKgCkZABZkhc/J
         6gDA==
X-Gm-Message-State: AFq9FYLb2EfSdrQWDocURV8Bnzt5QPZZPCQHdUYH/bbx1GAsGqH0BVmZ
	EEiLYnUXxGhE8p4AENdn/BvZcfo0KfbhsF0QukhMgUGdqJ+yHLiGz8YRJQgK3JE4lpo2XUdqmW2
	hoX7IwGONTg==
X-Gm-Gg: AYBFou05oyoUxYXRiw6oSqO9D8DhnRjvAsWaTQMmDfipeeuOtrvjxtngdwm15MjeT6F
	/8UFh+VGWVZHykIIldtMXZ0uQx9rCXB3hys7P03SFx2B+76Qq1SRlvDY2s4Tmum3yqNLZLV9ZJF
	/e5q1vzg9D4lah+7mwq3vdd0uZyjI/j7t6APGrkpNnhn/O3wNAC351urjgvBMBBb4XqPC3Axo5+
	Oq3VInbCGPpUeFWkV2ci7cUH7alVTeLASS9D3Fmm5qjl8HOpHbNzf+jFdT5mc9zJzlGo2LncmhQ
	gL+qkjkgWCXLd/OrT2rHJTcqBZWYI1HXfdW+RmMacGVkA3EdVHS1F9vBSvlxrNCXdEtWshoQ8Vz
	8xHW3Gd3hTgDq9Zs9mzGg6wabtQTDV+gZJ38ebHRuRS1zCWkaY8//R50E7pMwEQQVS6BpjVJZJx
	NJ+WQMw9/eFrT53FktRfFqcKHdyh0IgEHvrNCvmPaxWVu6e/Fc140U09r1uzg7Eykne8Ev5SgiJ
	MVncg9N08JI8CUrW5P3nJPbnZ324uS9DPrfUlJhL/lmirrEdSxUJ/wJrowMtAYjr/Gj6NFv/0jN
	ICIMxpXdjIx7A1vCqairBHFSTH+wfPhxhpQSSiJSlupQrbQl
X-Received: by 2002:a05:600c:524f:b0:4a1:9a97:c88 with SMTP id 5b1f17b1804b1-4a1fdaefaa8mr21401525e9.5.1792567998665;
        Wed, 21 Oct 2026 00:33:18 -0700 (PDT)
Received: from Nandors-Air.localdomain (catv-176-63-83-112.catv.fixed.one.hu. [176.63.83.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb95b390sm53230925e9.14.2026.10.21.00.33.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 00:33:17 -0700 (PDT)
From: Nandor Kracser <nandor@riptides.io>
To: netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Nandor Kracser <nandor@riptides.io>
Subject: [PATCH net] tls: avoid field-spanning write when copying crypto info
Date: Wed, 21 Oct 2026 09:32:33 +0200
Message-ID: <20261021073233.16720-1-nandor@riptides.io>
X-Mailer: git-send-email 2.54.0
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

do_tls_setsockopt_conf() copies the cipher-specific part of the crypto
info to crypto_info + 1, where crypto_info points at the 4-byte info
member of union tls_crypto_context. When optval is a kernel sockptr,
copy_from_sockptr_offset() is a memcpy(), and FORTIFY_SOURCE bounds the
destination by that member:

  [    6.948348] memcpy: detected field-spanning write (size 52) of single field "dst" at include/linux/sockptr.h:49 (size 0)
  [    6.948480] WARNING: include/linux/sockptr.h:49 at tls_setsockopt+0x9b2/0xa30, CPU#1: init/1
  [    7.001355] Call Trace:
  [    7.003146]  do_sock_setsockopt+0xb0/0x190
  [    7.003975]  __sys_setsockopt+0x76/0xc0
  [    7.005368]  do_syscall_64+0xda/0x4b0

tls_setsockopt() gets a kernel sockptr whenever a cgroup setsockopt BPF
program is attached, even one that leaves the option alone, because
__cgroup_bpf_run_filter_setsockopt() passes optval on in a kernel
buffer. With a no-op program on the root cgroup, a plain TLS_TX
setsockopt() with AES-GCM-256 triggers the warning above on an x86_64
build with CONFIG_FORTIFY_SOURCE.

Copy into the union at offset sizeof(struct tls_crypto_info) instead.
crypto_ctx already points at the right union for both the first set
and the TLS 1.3 rekey (tmp) case, and the address is unchanged.

Fixes: a7b75c5a8c41 ("net: pass a sockptr_t into ->setsockopt")
Signed-off-by: Nandor Kracser <nandor@riptides.io>
---
 net/tls/tls_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fbb274287..9b07ef8cc 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -701,8 +701,8 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		goto err_crypto_info;
 	}
 
-	rc = copy_from_sockptr_offset(crypto_info + 1, optval,
-				      sizeof(*crypto_info),
+	rc = copy_from_sockptr_offset((u8 *)crypto_ctx + sizeof(*crypto_info),
+				      optval, sizeof(*crypto_info),
 				      optlen - sizeof(*crypto_info));
 	if (rc) {
 		rc = -EFAULT;

base-commit: daac93975b8ff0a0a036a5e3562236c0b40c3e36
-- 
2.53.0

