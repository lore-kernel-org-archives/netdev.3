Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD13ACA49
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255113; cv=none; b=O+VM4WSiuck+wLBVdgYUVCF/pdrVhOvcsHaDpZFUSXgdwsdT+2y5Rat+lz+2qEUvUEchALgUaNK69/bLpbusjAmAB2GCCjVm1QJficbo07lQcpikK3zTq0azT/aB8LPArRxp/9zPPoUJYRFEaYXV+5Sx0REvrM6PMboNgvKjKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255113; c=relaxed/simple;
	bh=OQc7ovHnX081mUlFOYqUF0sNSICI9EspyAQcDauXQNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1uIQXwNN+EHZPgPtAWT2uFLQpZgevGzHGTQFaa1ZvhbHx27BJiWel5YOf6SUtvjlhj15vdRevwfbZrTeejx1WD8YwbY7ixidu7+RqihJKUz1AjyQEIODpxfFmsVTsnp5d+p13M6H98s/KIQlbYiTMEumTRJwwNlGHndzDh3rMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIKEu1FO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIKEu1FO"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so584765a12.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255111; x=1792859911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ty8oBQC8ZzmKhKgO/ClpXA/s1qlF/mePfz8ntL+VDOA=;
        b=XIKEu1FOoVTxl+eP6isKEpcjt31ih6ipOQWS8uhdxFlxrZ0o61MFGOh+dbr3QjCUZi
         qqDkxgDCiuSpADalucMbYwVD6wiu6QicijK4d2moogJ3H/mrsBVAQPPdE5JFt+cg0xGQ
         RxDji35QLCmc/vFKmQmSbou1RZVv920vYBl1SN8CG/tUxu0/ZFOmsypv/r8JwByJPJiI
         2ca1VGz6e1tefQdxa3KoPPaWNYUv3BnxJO6qIvpZ1OUGdYkNkAzC5b+psaMapB5aR3BZ
         2pkguwIItmoUF5pIJNFOD8aRjeFkX0e4WaMbS6PUxQw7ewdD/JmISN3IpcyjisfoQTw4
         4k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255111; x=1792859911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ty8oBQC8ZzmKhKgO/ClpXA/s1qlF/mePfz8ntL+VDOA=;
        b=D3EWloayKC/zNvonX7/E/88vqXRHwcs8brPAt3I+7IMEsUEWVka7GjVNsZ32PyE0i8
         dfOT/hJTBTL9OeXLxQRdhVH7wnLd0ajtlx6BhbXyWda2AUOiHhh21IkhROlsqzhI/eXk
         9wW8/YrhBYdPmvGu9tTkyKxoxt3RRbIKkTJ3IAQVs9yEOY8A88tO1jej7PYNd7Jpjc1c
         2tRyzqYLBkKkcexo/KyStVDFZQ5HK/sfp5os3BByMtL+ZXJTc4JtGElkTVDC5sWHWASR
         8DgI4TiJNDDO6tc5+y+BTBxqB4efPLxOAiJCUEbklmNb79Naxaa0otU64XR0xvYLEOms
         nAMw==
X-Forwarded-Encrypted: i=1; AKwUvByu+SXwqsrNigLqpHXT/yOwIYu/drJBZ0t/KCZgmY7S+lubGgduxOZ9SGlWz76rklleCC2bNa8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKf0KGq3lqeVW5euB9oueWeLSHh17h1jVnTJhOID6FRRqGK6RxY
	9dRF86es3l2CR2HUZ/UOgjEIVv2fmx7SG/t85ssvgb81F9/8KQ7kn97Z
X-Gm-Gg: AYBFou2gegZodkWwtbBx/0wY7qvnw8Gh5Rrp30mrrIW5tGZSQ6dJ9GypqHrUKUYAznA
	IIZuXgZvRTfe2WuyNiAr3IySJ1ARW/26eQr/fqxsSHJYAvsMacmYSLUB054lzKRALWYiKzv4nO1
	MwbR3gtHYCEviRh/f1LPtJnLHOQaUIPNVpUTQlfehVnqzELjQLmej1CtAQLCEtpKQ7rS/vdPmSx
	qeOcczLq3QcQCgt37UV6pQtmwyleu67/TkvyyUbpBExK5yj+BvmqUdLkD5CF3sx6zGxMVrDUjlU
	lc1Ri1LdqQ60+crI6bKMwEy9KJgfS+Cd8DVobpIVjpZXjMJBHEGYRs74BPbv3LsWLxnpxWssmFJ
	Z0iYKi9KiIVOZaNAEZ8bI5QIUI7pID4m8jL1XkbrIXCZ1cf9zlbwJqOh/aKeO6zNUU1XzcJSaza
	27jBIkSTitrab8jcAZDIWk9/8nJLqrtHcdLz/1xYFmdVk/Vv8YqrUOqjhNYPL6JDRKV4T8jwfqX
	QeWWPt2VftdWYL4vYZqfjeefsFFNSgDucwEm4VX579uwqaxogJs38ru4iDutox3a9QpWowbuBmI
	XbPfsup67H5nbRZRWbUD+usWs24yL8dKg19VHmD/9yAQh55cgPvF6A==
X-Received: by 2002:a05:6a21:1f88:b0:3e1:ff9f:1c67 with SMTP id adf61e73a8af0-3e2260e7737mr2157940637.61.1792255111269;
        Sat, 17 Oct 2026 09:38:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549b6171sm2256462a12.14.2026.10.17.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 07/43] bpf: look at all 64 bits of a BPF_JSET mask on 32-bit
Date: Sat, 17 Oct 2026 16:37:09 +0000
Message-ID: <20261017163745.3341787-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

In the branch of a BPF_JSET which is taken, the verifier can learn
something about the register only if the mask has a single bit: then this
bit is set. regs_refine_cond_op() tests this with is_power_of_2(val) and
then ORs val into var_off.

val is a u64, but is_power_of_2() takes an unsigned long. On a 32-bit
kernel it only sees the lower half of the mask. For

	if r1 & 0xffffffff80000000 goto l

which is a BPF_JSET | BPF_K with an immediate of 0x80000000, the lower
half is a power of two. So the verifier takes all 33 bits for set at l,
while the branch is taken if any of them is. A mask of 0x100000001 from a
register does the same for bit 0.

The log of an i386 kernel, for r6 = bpf_get_prandom_u32() << 31:

	3: (45) if r6 & 0x80000000 goto pc+2
	from 3 to 6: R6=0xffffffff80000000 R10=fp0
	6: (77) r6 >>= 63                     ; R6=1

When the program runs, r6 >> 63 is 0.

From then on the verifier works with known bits which the register does
not have at run time. It accepts, for example, an offset into a map value
which it derives from these bits and believes to be constant, and the
program can access memory outside of the map value.

Count the bits of the whole value.

Only 32-bit kernels are affected. On a 64-bit kernel unsigned long holds
the whole mask, and this patch changes nothing.

Fixes: 960ea056561a ("bpf: verifier: teach the verifier to reason about the BPF_JSET instruction")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 430d5309eb5c..d0ba7156ba4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18145,7 +18145,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		 * this restriction. I.e., !(r1 & 0x3) means neither bit 0 nor
 		 * bit 1 is set, which we can readily use in adjustments.
 		 */
-		if (!is_power_of_2(val))
+		if (hweight64(val) != 1)
 			break;
 		if (is_jmp32) {
 			t = tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
-- 
2.55.0

