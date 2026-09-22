Received: from mail-pz2-f23.google.com (mail-pz2-f23.google.com [74.125.228.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDE577E5F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097654; cv=none; b=ApjqxQ7UUtf4Qi/A7wvzezP/hCr5ybCbykICvB0eFrr+TZU5zaS7TDUs21Lk/gFKadC0rwY2AOVy/1DagolPOVyhLKdVtLVa2RHq4SWmcl7M2RtyD3Og2uxHpjbtRokyFJc3ASa8o42+gt4/UbVPwTFN7DJDAtffzAVR7EHu3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097654; c=relaxed/simple;
	bh=E/TPExh1jjASY70ZzGIGurLuBPP/eWZW8hPMLwtO8CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkeXNC+3TpS4hkJ2fuyYg3U3iCWy5VZhxfoDXLCFcRmCX6RcFhCsIdZOK8Wncf2qVG/OkagjfMNEeLW9a0RCHlO8Qv3yslQfcgssWQ3KTNcs3dKvAQpL2wk9CIhqC6p4hdokOjZGY6G9qrzm3oEum2qSYuXVGw5l3mlYDSAoAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=B1OgW+Gx; arc=none smtp.client-ip=74.125.228.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="B1OgW+Gx"
Received: by mail-pz2-f23.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso140702a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097647; x=1790702447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=soLt40mP+bRJQKkxwxoTXZXIMy6sUfgHio+5spPhnfk=;
        b=B1OgW+GxxMbIA3DYsDk1X07BipTZ2s3NSJ2uuoVXZSwVJtTQ8ORl1bnkSiHtaMALhb
         C+yJi3yQ7+sQXuqbVTQ5K9DpGrOkF+TQ7EOUaTHKz0FdOq1Y/h7U8oVWixwIWg468Nyj
         oVs18l9+ai4XEeMSVm+Oqp5jF+ikCBXZtOIyc7i392PwY3INO1Xaw7OlGSBdlfEh1saf
         VolOaDzTRpCJzAHd/kD96IK7G8WwkAaXI95i44lIo9Q9OX/wn8SQmIAwDhMkxqeIBSC4
         ahCzONR1m6U6sWdBpm6QjAomnsjdyHlq1NQAo9XnbQ2IKl5ZYlAeIDZGPq+4Rws8h2+m
         MHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097647; x=1790702447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=soLt40mP+bRJQKkxwxoTXZXIMy6sUfgHio+5spPhnfk=;
        b=O75OoX0/0guY7jXtPRXyBELb0/aFH2cYfL7UBUe8+Gezxei42ToIk+xbF99KKfcXjw
         xHj+VWOv9EuxVYNrYaEeGI74eF5J546khpcOUhCqFYKunc+BPBvl0HBdbHYLgY0sVucc
         ldc8HCWB4xpJu+Y5SWLVb6nqKT3LqtQlD/h3XDAohbGpvUDmBsdjxay0lZ5lPEmpJT7O
         2TdS/09Gixg3NdLP80koHMDiDJ84gf5AiJDBdVFswy+XqKf36pRn3a6v6/7Ns9IGOHsB
         k+DEfxW8kE7w2p9cQ2a8pIgiLQ1mDI84ES5wI38bhBtuIV8GN9YGLsXn6p/Qf4pY+SPH
         ATVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLbBzaViRZuMV3dl67tDJUX+pXhJnvZp+GaCe+NCVj9VmKk8nfuDpmbEvI+EXv+D+nziXPdPY=@vger.kernel.org
X-Gm-Message-State: AFuF++niL7y6DGeSyP231RGIh6MUaVyw0yYwD/HkJ6XPuUFS1ldR+8jl
	VoqVDQZuFCufVzhT0KH6pqzTOPKwvjaO7fMFqCGid6IaykB0CjboORkdZtkYKTSKkA4=
X-Gm-Gg: AYBFou3aR0b9MIvdjIBKu0/WI6Y5aGT8vnmARVqY2zJqV0RDhtgmpTfs8sGj+G0RgKv
	V3mivc9LpgmVXB+Rqs8Jww9cNa9PUHkOWNyBN1RcfBXXqiKJn1NbUIkCWjWjZMou99lv84LVvBP
	C6AfaFHSznwzjSwwaKkibxH6MqxY7HHRQAgaqLTvfHYDajMxYtpy08qvmbyfJZE5bQwpvmdL3Ni
	YnX0AL4C82rRt7MnVZo8g53MNtKROI/9lABR+6S+jGRxrdeqfKUXngB6eoZPOamaEwkIC+5uyNi
	HkSukpbpEPxl5rfMHXOi+ztL898/Pllvx7AMCkKOb3ih9aH8XC/v4un3YkbFeM2XZNPdubxYDts
	n8PqbsS0b/1cUN2lTQVgX5H9P5TXYBPMrFYJSFzsC/6ijjPjywS/k4mBvfQ9zkgsGyuLAOfHlu7
	mPkKPXTi1c1CqvHbp/Sr18HZcSN35Lrg4+3rUlhNZzfxBO9maieI2j2F4l4yrDhXTD880QMp1TK
	fqK64FmZM9rSClgDuL1Rfgq8fug57v+XLYbGvOpwmQ=
X-Received: by 2002:a17:90b:3e4c:b0:39e:6a81:f352 with SMTP id 98e67ed59e1d1-3a07e6be17dmr122474a91.44.1790097647174;
        Tue, 22 Sep 2026 10:20:47 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:46 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 08/11] selftests/bpf: Test for mixed arena/nonarena code paths
Date: Tue, 22 Sep 2026 17:20:25 +0000
Message-ID: <20260922172028.6269-9-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
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

