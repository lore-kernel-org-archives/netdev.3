Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ACA3BCD3A
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535319; cv=none; b=LkRj/aiiaqRe4Qewihi306e3gFrltEgW5DJTKxCIFTpCHwMWCcMjsG8u9zVVRFbWUGwXNvBHpVnjMzQCidDfBAGZYhtRizEBJ9afPAem+sBskKjPGoWce61Ejz/atCTzeu6bPgoQdJ6WS9R2naj/4oP7HYOvL7QQmgyotGeOjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535319; c=relaxed/simple;
	bh=v9l7tVvrVmZba6RbmYUyb8MQTP/pDEanXcjNhFrjUxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5QUFTj1jK8gcEavf0vtRPqjP+60MIaCEEXRJ1Ge26UIYYk/nFDpllcxYoFg6+19c2xQlBvVvrpbqQQq9ET0aRk1xnbh2+zFedb2pJZxvCcmcsCsLVLiiiWn96J0TUKNrqjRXex4d6o2eA+8ztBvpCTjIhhlsFFRo1tWrWG1LLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=jJw1dPLh; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="jJw1dPLh"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so360153a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535317; x=1790140117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wuJ2qCnS/wmK7OW9fsN5CCesdI0U+o2AEkrSo+G4ms=;
        b=jJw1dPLhJSnuG9Gh1vMwSr+ktNh7SQLON6ojgVMcpCAHSstTny8Q8VVrv3Yqbq9ILg
         tyxC9mn7wfhPfjcF3YlK9PMq1i0hvDTyplpvXByRhtWXYKWMPmK23R4RlkRgwWSG/bdq
         MMf+OesyLBaFdcCwnAhdwwZBNJiAraaT8L6+gWBbEEhxVNeRHfkMmB4hR5pneHdLUPqZ
         zgOtivJ4LO2LZdPfnx3y2tZ8rGIVWxaUOtgGGGtymdTTacBEuRF9jwLnXzgcHYQksc6u
         ALn2wZhYXvvCJt6wKZP1JWLdvhn06ONjRvEkCztf2Sm0JKwguxmraXi14Dt5PVE1mPDZ
         mZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535317; x=1790140117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wuJ2qCnS/wmK7OW9fsN5CCesdI0U+o2AEkrSo+G4ms=;
        b=kym8by/yYpbLWENjZh0MQNuuPAKCvCnRX+hLUuUuBr44B00/kxvVLEO5OavXEFtfY2
         n3lMjtdmphqRZf1TFiqTSCPbyj9c+QTaIVO6yZpZQYrFZvKyFmFTirYPAfX95Y0kCa4b
         YHv//UALpvhvXTtaouOPmvQe3atsQv/BHtIUITiaPWMKTimRtN2W0BY5cqZURCk8djNH
         1nFw30RvT0Q+/hQUPqPfIPQXywROARmxAJx25yC7chNe0+HVO+eJyxLbsaT8H7TMG52Q
         UXgFNIeAxmd8liDoD/jCY6z8pgkdBCG2rCTogc8wd51EEOCsFLJxvATA1SCzw7rgKa5c
         q2lw==
X-Forwarded-Encrypted: i=1; AKwUvBxjHnLyB7RX+L8C8hmrYT6+rvcVGItv0nUYzfv6qyIVqjo0fAC1ZRLZR4u6cgFiX57vAmxbHcs=@vger.kernel.org
X-Gm-Message-State: AFuF++ljnMUqD6BxuoNV4Gb9KtRF+VGtD5QkuywYOC7czObBGq49Mhf0
	fLwealMnwpoc+DOR4gL9JtD6BCVadKkJ8CApJxFJwoPRny7XkQbi+yJhp6mVwcKATLA=
X-Gm-Gg: AYBFou2nWuZjRB8+HBUKjX7Z6u0/pIvlIppfJTjqPmhZumlgItJKx4DuUyOCp3Rq+Wt
	e0z7xFczDX8e26OlegT0dQ0ZI8wwcUw0eLIuL5Dbzl33A4ksLsw/b18XjnT8y30/0+T2L8UhC8a
	rYq3UXJF8ODX/pXxH6lt1yhRK6FxTYCYlPdkphWlaDui4c3T7y96tu3kuPbUmmCaDfobvNTQZQi
	RpFphwTQzEhsBb5URKRUTlHhHWJmF+bAbAKBoXh4AiqsS2Oe2Ff6QwwWUPjV4czMM8pjtD6zYgX
	jeGmdcc7ln5FzWO+45Vh+2ZrQ54uvHkR1f8nLPDbFVRRDjDeROkTrQxuNsYOFwCfrCtS2zKGafo
	Kx01n83pF7mc7WSnJItArjlcf1CBCvKlnGLWOPU1zAqn9RujiHybTfgVOLvwriRcN6U+kaex5NI
	XeH85yhm4V5FdOmsPKzBPNSyg3SqtPdZ7ZEjUkG0iMEBwTsBt/cDdcGXsm9hcMi8UkvZjPd4zdw
	H1jen6tmUIbpYvdnF6UaD5Y7MsolFL70kWqe5cBUbMuHp2vPg==
X-Received: by 2002:a17:90b:3c91:b0:39e:1310:cb36 with SMTP id 98e67ed59e1d1-39e1e5110e4mr2908224a91.20.1789535317119;
        Tue, 15 Sep 2026 22:08:37 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 02/11] selftests/bpf: Test dynptr slices past end of skb
Date: Wed, 16 Sep 2026 05:08:20 +0000
Message-ID: <20260916050830.8774-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to ensure dynptr slices cannot include
past the end of the linear area of an skb.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 10 ++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 20 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 5fda11590..439656036 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -9,6 +9,7 @@
 enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
+	SETUP_SKB_PROG_NONLINEAR,
 	SETUP_SKB_PROG_TP,
 	SETUP_XDP_PROG,
 };
@@ -32,6 +33,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_slice_non_linear", SETUP_SKB_PROG_NONLINEAR},
 	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
 	{"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
@@ -94,7 +96,9 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 		bpf_link__destroy(link);
 		break;
 	case SETUP_SKB_PROG:
+	case SETUP_SKB_PROG_NONLINEAR:
 	{
+		struct __sk_buff ctx = {};
 		int prog_fd;
 		char buf[64];
 
@@ -106,6 +110,12 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 			    .repeat = 1,
 		);
 
+		if (setup_type == SETUP_SKB_PROG_NONLINEAR) {
+			ctx.data_end = ETH_HLEN + sizeof(struct iphdr);
+			topts.ctx_in = &ctx;
+			topts.ctx_size_in = sizeof(ctx);
+		}
+
 		prog_fd = bpf_program__fd(prog);
 		if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
 			goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e0745b6e4..b668ebd61 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -10,6 +10,7 @@
 #include "errno.h"
 
 #define PAGE_SIZE_64K 65536
+#define TEST_SKB_LINEAR_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr))
 
 char _license[] SEC("license") = "GPL";
 
@@ -211,6 +212,25 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 	return 1;
 }
 
+SEC("?tc")
+int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* Ensure we cannot read past the end of the buffer. */
+	data = bpf_dynptr_slice(&ptr, TEST_SKB_LINEAR_SIZE + 1, NULL, 1);
+	if (data)
+		err = 2;
+
+	return 1;
+}
+
 SEC("?tc")
 int test_dynptr_skb_meta_data(struct __sk_buff *skb)
 {
-- 
2.54.0

