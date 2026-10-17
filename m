Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A253822A6
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201156; cv=none; b=Gz21JZGtG6sygreJwTRDSg1zE/UDsDN8JYolHtpM3qCxcLwn0CiRhOO+UKa4q55g6XXYnsSh9Zmg4ZVZw5CqJkpk09N2jSywRKyPolXvBBJ/OIx5CsKs7tSkgcQkFwaiOWVZYKn2a1YQWDc6BGXO8VVyPI1PZDkTHX07IAc6BvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201156; c=relaxed/simple;
	bh=I37pMbBMK09fuZLQxk+ge/8C15QqmUXK4gTQH+hCLlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeUw9qe77i7HJhOWiW199fWGjsffLl4GyeAE+gtjSnALoVw6CKrIm7uaTzaCzvOnJk7FlH9YvR+TaJCE4Rd+GqiYwLZwk3H/ti2sBAdrBn2k5XSEJc4df+rMRPSrnQTK0fL6+l87XXy+kX2EfJAUz0/wOnJNJBdjwxdZEYVqNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPLmUEPz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPLmUEPz"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso353784a91.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201154; x=1792805954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+u3iWGfpZx0OzA6csEp3TZcwFGh8ku/nVnLWwC25+E4=;
        b=HPLmUEPzOzwh3aRIYVmr8fnzqMMuoeKHq2kGW7mopaYWdHqXNiHnxi+3lViuwpxBuP
         xXvlFsnv2MirfLzUgNH2AmI9Kh9lo1T5naqsBYryhiw2KKuvj6QPnD2Fd/HF0HabPmi3
         geCh36Kt5/iNyC58+owV751atYOtZyfoZ6hkzy047Ai+FkVWNAKX2UUeKTKBnmAZSbbp
         A9K5N3ltnUvjXMim+Ow1hbQtFT20is2/TUPEu/vqkrurNSzMJf5ne8phQsCqZxsk1sdG
         m+4Ij7ouQxMBfgm1o0vIfEsrmWu6v3kftMANH/BjZqwZ0v0qnILmasRYDCTsizB9837o
         CfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201154; x=1792805954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+u3iWGfpZx0OzA6csEp3TZcwFGh8ku/nVnLWwC25+E4=;
        b=tI0gsjd+YBFecCnnTY8m08Uxfhe4i/Bn8/aX1+z4SJySCCVWnbieX5J2nrM6NdMd/n
         gEQ/vOVwqv0dFU3rad3ODDvcU1JPOClhFwRiphFo6FfWH+/ZPU0IqwmJ/0AFqyLkAMOa
         8RIRCBiq4FKPJ0iqfKV9uqXTndujotmWnfZK5CerbMDdL6xooDuruvtZSx+P4aVo7dp2
         UpKNnZB/0safww12fIOHrKXoo6w12WRUZKPLmaXuCD1XDZGYMyiY/xenkMf3SxATtcP0
         RlZJzs2ThHFgk+PAYd+sH0TsQp6czfg+3UGhQS7xBUvcsUN9tyqPdI5mlS6+vN180izq
         yRtQ==
X-Gm-Message-State: AFq9FYIYVl+of7VKxwQZPlM6UDStrhwly/6gjQJniN3NTueV7TZT1Jl4
	rrZuiEIEHoxpQ/vPTDGqtIiQDhRrJW8F/0YNZKpRTg9BukuUnHTfC3ugI9ehuiwy
X-Gm-Gg: AYBFou215sURDYFuKV7B8FrBqpi5xZQsPeGVZYUub1tD4tS2ul5VbOf4NvZM8i4cnaH
	SUmYn1ZnsRiKPv+gzBbPIue10tMUtuTrzeZWm3zbT1PkhDRMKX7f0rcCA6NqEwZznLURkmLdfOT
	sIsJbYoI+BLakRurOSgZj/WclorSftuNecHuGFNKeDHlgSd8U8io37Xwrp72aNw1rzJyzTa9JNc
	+4I1/l21/spxr0rIIn2XSrC3Xf784AY5OVjdAsAJvAmgpkjTwjPI4i6nUz0sOg8GGmkBS1BL73F
	/sd3DrshwwA24Qlm75/eOfkcC7seyei/wOiT1iUIqPPgzZOhddwosYxvBRYTPSXkI6mb494gi7u
	fPS2DMwlbauucb1Dq+Opn1TCh2yZmGjr+SevoPxKDDuPDLHjXMDNbZ2bA65JVNN/R4KDgJ1vFo/
	QyfeUgzjkMxXHOIBd/NQ/KTL/bdv7heeBWUCmxUUHfhNz1Do54L8cXOCP5u4t6DDw4lP9fDzRnl
	Sy9IVgxRz0SnNjr/OmXXaDejBhl9gFaTNQOobQQeFrYmjtUOgsMc6CeWnFwqVDwZkvqLJsPEj4l
	dYeL5MBIbnf0nHPpiBosgX/BbxgETKZj7UiIupgi8uo=
X-Received: by 2002:a17:90b:1f91:b0:3ac:b3e5:426c with SMTP id 98e67ed59e1d1-3acef10e078mr1178226a91.26.1792201154417;
        Fri, 16 Oct 2026 18:39:14 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549fb556sm1985639a12.22.2026.10.16.18.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:39:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: [PATCH net] net: free the policies if a socket's clone fails late
Date: Sat, 17 Oct 2026 01:39:12 +0000
Message-ID: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

sk_clone() clones the IPsec policies of the parent and then its BPF socket
storage. If the latter fails, the new socket is freed with sk_destruct
cleared, as it is still a raw copy of the parent. No code which knows about
the policies of a socket gets to see it, and the two policies which have
just been cloned are lost. They also stay on the list of all policies of
the network namespace and in its count of socket policies.

bpf_sk_storage_clone() fails if memory is short, or if the storage doesn't
fit into net.core.optmem_max.

Free the policies before leaving. This can't be done for all users of the
label: if the socket filter could not be charged, sk_policy[] still holds
the pointers of the parent.

Fixes: 8f51dfc73bf1 ("bpf: support cloning sk storage on accept()")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e8551df8330f..d311f56803ed 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2577,8 +2577,10 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 		goto free;
 	}
 
-	if (bpf_sk_storage_clone(sk, newsk))
+	if (bpf_sk_storage_clone(sk, newsk)) {
+		xfrm_sk_free_policy(newsk);
 		goto free;
+	}
 
 	/* Clear sk_user_data if parent had the pointer tagged
 	 * as not suitable for copying when cloning.
-- 
2.55.0

