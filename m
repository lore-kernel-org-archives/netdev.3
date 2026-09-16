Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7383BF676
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535325; cv=none; b=PsAKb9Kkob8SeduUKhtwJx00uwcqbaqiOrvdrx8zI2Xno5vY1WBeAnn2m+KmfEzq9fn+Uc4e/VWNI+++o8hw9RNhglBqfxHQRsvw67lb9eFO6KJHK+elRF2Q1tVv2TAl34COPU1BD6Tey9QO1TPGtOFYP1L+w34umQqhluRZSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535325; c=relaxed/simple;
	bh=E/TPExh1jjASY70ZzGIGurLuBPP/eWZW8hPMLwtO8CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNU72DFdUf6msCMi6+xsMxatjxOkLzsvT1EQ0zRD5F/4gf4u9Br3eOOJ9/4mTTBgg4F7hjJ3NTMaecPZ4XLJyuBMhRxVRq66RYWCbP9R02L+lxnadCYLK5DUwalwSzNAeA47XUZHTwrFJFOVQ5EbXf+hxOByfLukOUzIC8b27yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=tmrKBssr; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="tmrKBssr"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso412681a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535324; x=1790140124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=soLt40mP+bRJQKkxwxoTXZXIMy6sUfgHio+5spPhnfk=;
        b=tmrKBssr8Ytw2tdS+vjeSz4ttrA0zjGM0KonLq673xLyROmAhJv94fTV/1h1j4NlQL
         7jpk2HNihKsKBW5W64BkJzk1DJ/JXNNJcweJLkmtRDn8uvksDnmHbd8RYp4KXUSZw9d0
         45I4gix1LpZwVTFhwOkv/RsjHTNZlIIZsqYqJpqn6tz0JKNCZZUp22jgoZMXQXwwKf8B
         V0jy5Z6Mg7WfWr+gK/Dngvsc/Yv4Fp56C8bwP4q50ozFsTKx14yLXBViBagbs6+RWG9Q
         4FpLW09B2UkEHumNHFXQXJMu8bO7q+7hrhlZExas9NXYSGMaY5ON2ujGMab0FZvWeJl7
         rALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535324; x=1790140124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=soLt40mP+bRJQKkxwxoTXZXIMy6sUfgHio+5spPhnfk=;
        b=gMjDcf6pJGMongkS9S3ezcNyfFLwVhyHKXcgFO/CAvssHH7HofC+fcpNjYoob9mIUN
         Ife6skEVOUaBlH0PXn2pYpeMrsqg3JecYwdNxfPdxjXBuVZ54bY/oo+i5lb737AZn6NV
         pOpNzD79zqzgrtomGhp71gamCiAiIrN9mPmsNy9b8PgCiroOKwLHcCVEBgjLy39FInEe
         OPh63uqVD95RXrXHq0P77Qxjyk7R5WRWjSSQQAoI0/6ErlzVEVH8ifiztOn4O6VL1St4
         rPD+3UnCbm+pHvzwgSq1chgDjkD8ITW9UId8K7yIBBbSmKJU+F1qXBIN/DZ56TT84y8y
         p8xw==
X-Forwarded-Encrypted: i=1; AKwUvByQie5jRXNJbrijqlCQTZNmdaGwLSgz3L1UxnYxe3ShP/2ZY8gEC3ADZOkBfyG6rlj30iZanQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++mibKby7pmohT4EhfEWL6aHPPwM/99+1YzzvSsqMc9hOQGW751p
	Vnen0nYYa8QxNlL1C4xmbf0SXRbes3veS5wEhjCn4vcwhyqnARF4ghaw5FWIWUi70aM=
X-Gm-Gg: AYBFou0yRgjRQpKfVbEMKzNhsVBJNZPpC7PWQs+n8q1rLWyhO2I8gyUhYwLcRE7wI5U
	9Q3sZJazC0I2FtcDJJIufZg+IA1o08UvJC9rL77V5W20maoXAh6T0WycEw/RsLuMgFx9GmvvBJw
	f+lWCSkcNeMT95E8Aqdn6JZNmr4iCcqTw7+Xv/URpqZxodaBKP4fukzVS4I0mLyr57KSpdXNK6h
	QyAQPcrlJfLnGYPUq1kfl9Ymps1u0hWbVbtWvGa9dQJ3IfflYA1avvshyg1KXDE6561TwpxgENS
	7DxzQrNkwVxJLB3T2i7RjcLrNsm7F+Kt0zFh6ZqmpZNuDpafR8M7F4Qc5j8V4ASjWB65jxZXPKI
	AcXM+j0CEzdVkf8TIzFzV0bcXyZVuWkJgORW9P/SNUDsue/qSEYzPaTJN3/X6ltgAV73n28A4+c
	ao9iBn3MoprO9D1r4ORRhrUtEO0vI4ttkTAgaImx2XiZy5WRZJA2J7lwrb6PsVkI4HH+KmX6ZAf
	g2u7zh5zG5khzHydGjEg4Csnrk12orrZBP4Zg==
X-Received: by 2002:a17:90b:2c88:b0:39e:26a7:7aca with SMTP id 98e67ed59e1d1-39e26a77cefmr213612a91.23.1789535323786;
        Tue, 15 Sep 2026 22:08:43 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:41 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 08/11] selftests/bpf: Test for mixed arena/nonarena code paths
Date: Wed, 16 Sep 2026 05:08:26 +0000
Message-ID: <20260916050830.8774-9-emil@etsalapatis.com>
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

Add a selftest to confirm the verifier rejects ALU operations
that return arena or non-arena results depending on code path.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/progs/verifier_arena.c      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 332322c9b..1ce9c4b78 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -561,6 +561,55 @@ int arena_ptr_add_arena_ptr(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__failure __msg("same insn cannot be used with and without arena pointer")
+int mixed_arena_scalar_alu64_scalar_first(void *ctx)
+{
+	volatile register __u64 reg asm("r3");
+	__u32 pick_arena = bpf_get_prandom_u32();
+
+	reg = 1ULL << 32;
+
+	if (pick_arena) {
+		asm volatile (
+			"r9 = %[arena] ll;"
+			"%[reg] = 0;"
+			"%[reg] = addr_space_cast(%[reg], 0x0, 0x1);"
+			: [reg] "=r"(reg)
+			: __imm_addr(arena)
+			: "r9"
+		);
+	}
+
+	reg += 1;
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("same insn cannot be used with and without arena pointer")
+int mixed_arena_scalar_alu64_arena_first(void *ctx)
+{
+	volatile register __u64 reg asm("r3");
+	__u32 pick_scalar = bpf_get_prandom_u32();
+
+	asm volatile (
+		"r9 = %[arena] ll;"
+		"%[reg] = 0;"
+		"%[reg] = addr_space_cast(%[reg], 0x0, 0x1);"
+		: [reg] "=r"(reg)
+		: __imm_addr(arena)
+		: "r9"
+	);
+
+	if (pick_scalar)
+		reg = 1ULL << 32;
+
+	reg += 1;
+
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int scalar_xor_arena_ptr(void *ctx)
-- 
2.54.0

