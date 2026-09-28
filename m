Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F64B1D13
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595646; cv=none; b=cn2nH6ZIn/P9qo0g9t7C1ma/xwyu2gvAF6fvHhUVeUi5i2iVIpMZBl1+/LFITGzysSxcgZ8NfxSlGbCiT7hEOTVnd/o+OuKuLkqkwE69Qpg3CLAhrw3kFd3HGrVtsIr4uJgzQ7SHdnPCr7VveJyM7IzuuDrqmgolsZqIjUbej34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595646; c=relaxed/simple;
	bh=WqyYNMC5d/8MARDcxhdBuh3AHy533kJQLlUN7+YZsSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3TVieNbebbQodujp0Qcjw1HgOrixQYfW7wnJcen8LVbwXbxawew6vUTtcziS1TIsBou0IBdXwfVmg/uc4H58Ya6PgiY8jneFzj5Y83Yah679EVREs+12b23d7ZYowX3W5/sOAMIKRuoBqdQn+dqpBs5iGezx6n0J7I9WSMidkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IZQ/sAHx; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IZQ/sAHx"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so395938766b.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595643; x=1791200443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZMQ7WCArv8Ogz70RYuZlV98Dj+aoJtdRziAtn6CZFs=;
        b=IZQ/sAHxzZI+8LLaOVtylpt4n4VMiq0k1tbGmsnfFf6XoPTsNEBDyjBR3brOyLhiIn
         e4dzZ01iwbNWf35VCP3li3oZ7nm+XRUVHLzSC6agqECTtoSOnQOPD2CJ749mm0EGPLtb
         OueeIYDqD+0yhcVolEkSKaXkavaCgBxC2QGd7/I67RpXXzuPO77QuZM4mHBK4fk03jtM
         axYQ2FWpDeH1Mkwr3s5KDblw1B4QZSsWuHbLGRkwYe/QO0D7P9j/vsitUrsaeDzVk6rp
         64+u8dOEUhqFlUbFQAGraFtCMjE0rX3GSUguMwzfgf5lmrQVq+Itux8oV07SzIrFAW4r
         GQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595643; x=1791200443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZMQ7WCArv8Ogz70RYuZlV98Dj+aoJtdRziAtn6CZFs=;
        b=Vn724rkEE/CacEKQ8XcrKBEtGqrZEYIy6ls5Pu57nXtt3pvPsVw4c9LZq8nIAiJ/fx
         O8iWjB6eZhg0XfQ87SuG7Ew/OX0m4KpMLq+1CMKrY3+/uftwqMSApTtI5bf5Q+wWuvsm
         hFyOP6lNwR2QoUaxcmSzmlMVgUYLmrTO84C5TydqUj8pyghHAIuDftoiWJyhJy1o85SO
         i6wWmPrzteDNfs1lYpQzSWbOhmyuwZ0IFeDxwuiPsD7ddQACUPWhnt3iVis5fpmAnH33
         7G4fgamS7zOeER3/egMZM+RZsbYeI6xfAsRzG6Re8rRA7xuGXvkdI7pdi0glbuY7fxIa
         uDXw==
X-Gm-Message-State: AFq9FYJllzoFmXAU+wRM0fSIXuv0G3aMg8/rtPPTMQUJt8kY6IQmRp6j
	BBGaGet6ORUuttKUv2HAjP5cRBeoKIBetz2oWSjG5LC70eei7prBMO6zNRObn1BcJ9g=
X-Gm-Gg: AYBFou3T2WKQRIQNsmNKLE18T7wyPr5IFntXuitf+Bkk6Y1jdOdiNQi9h0VOfhUyZVA
	ePbh8/gQFfXS1fmEti9W3IJ3TZtHXC8a/5SXt/5kE1rTBUdsfacsMf27eMrn+YBl84YDfNtP8ZJ
	ssx4m2EqynN8yxCscWcmH8+jRRWcs8e0pqFoyIkooor9CRI/L9MH5whnPlT7HeCzv36/7RBVFPM
	vFMpPqgA4g1x5pTTTOL9uSDRPj3j69rCHBVrwnsyCxnMTWHBiYP05Jq4HRPsPY4gI4eHumPyrq9
	uXeNNHWrsT9c50CCGkWZ4qB3SxHUI6K5l0Cg0gRT1tOapeLN46+Wc31+Y3a0Jo/H/QZdqLxQaLl
	Ya6PqyZYQjYaMUE4BqjNnkD0vBHFvK2ToW/nzoYQ92WREuTdqpqcgGFoVwBWlkAMpegbn8h/q5L
	10OfCk9oVTZDSS5tZkEr+CthpYamavrr9EaCm5lp3sweudFg9UwpeNYR7CGDn1q9Day2kd6NInM
	6v9TdWL0IKrDyvpveEM/x9yRipb/zaDTl5WsnmuB5oB3z+yRh+3IIx9pmpfmSr5LAB6SiHNTUXn
	KHmOADgK3cBJNmCd1uMUnCE=
X-Received: by 2002:a17:907:86a5:b0:c28:599b:7782 with SMTP id a640c23a62f3a-c2ac23dc23bmr1028148266b.21.1790595642899;
        Mon, 28 Sep 2026 04:40:42 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757857bsm450257766b.24.2026.09.28.04.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:42 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:32 +0200
Subject: [PATCH net-next 15/15] selftests/bpf: Use non-trivial test payload
 in xdp_context tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-15-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

Replace the sequential test payload pattern (0x01..0x38) with
higher-entropy values that don't alias common protocol header fields
such as IP version/IHL or ethertype LSBs. This reduces the chance of
false positives from stray packets.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c | 8 ++++----
 tools/testing/selftests/bpf/progs/test_xdp_meta.c             | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 0aafdb1b8feb..e40c9bebdbb3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -22,10 +22,10 @@
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 913caff5a35c..55ad17fdbec3 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -24,10 +24,10 @@
 bool test_pass;
 
 static const __u8 meta_want[META_SIZE] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 static bool check_metadata(const char *file, int line, __u8 *meta_have)

-- 
2.43.0

