Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348821CC59
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200839; cv=none; b=Eqj/rXYFOiM8NX4B6tlO5CCNgjoyoTFCKrNCcMMdBFj7CPnL6RYup8eaBRpL+X6Zyv8BApfKM+FJSgHwdsodXTWZ8QtviI6+3RsC4DEz67zHvqKHO/qP1h0MGJPKJhqqqJvkwOl53+Q2lp9SghYZ/VEKZDxHuUMAagSIfqab6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200839; c=relaxed/simple;
	bh=rWcVk57bd7XJ6aqHjIBKbQ1NUfIUN7X6g0abtAxWmhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCHk0UJcOIwsVCpJX1z/N6nMNiDYcLlneLScLqrQcBgG2FV4M8UpZYHDH3otN1SjTa9dJ+LBYuiB7hjewBkYp7CXI7JLB88ObqQv5LMBlUsonFJCA6ZBapvpAlZZTJZnVntXAYuyDGvn8DX5B9VYea2hCyD/12Oswdnt0WW7K6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8pDwyLe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8pDwyLe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e96502e447so2896255ad.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200838; x=1792805638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdXziGzorg1BVqALTIMKJSo9S3AbmbdZUCYUiZVmWiQ=;
        b=K8pDwyLey//fMvcU+d9qKbAZw4OdtKEW22hPIgcgAIl5mHHhnzU9sHWcxEf/fB4In0
         r/KzCVhp4dPVvKuuQ5jlRRqUsYJzFFN2zdYQeyndAeNzCVk4g19pk//nFb2Xu8K+hsGK
         poFCCRk0utd7rkcPxthY3p0LO5TiGMtf/2qinE+TgYqLUiN2mznkqht+qhLlznTqrkWb
         2wo5otWAk7vRfPckJUMMlzGQxvF3HF1HeYRDO3jhVX8VeGkwmt/gUJ8dPo9ZviLAKcP5
         Ib8xlH91SBk1eKamalWae9+7UKHZXy7VQJFb0Jf2LMnmk1F1rGY2lQumYwSGUvN/JHRh
         eiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200838; x=1792805638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdXziGzorg1BVqALTIMKJSo9S3AbmbdZUCYUiZVmWiQ=;
        b=f5LuDLbqkWAiDaYLBTKM4OLE8vjn+cVuigxFaI+JIM5tHcRrWmtjTvB/j/4GvrpLY6
         9jzr/o4MnlLssATbRm4BDFusTMOSNji2jcj8MODxtyCgRoLv738sIiliVh2KUir3qCo7
         Dd4WvrY1nWGa1n6WwbWu/vYfkQgLxengHkbsaM4IzVQVs++z93M4GTSnSKGRJhPpy4O9
         dSG+n7cuB+63AH1ix75/j22Z6Omz9pnychbid428ViHN/yHHqDu/Ums5xfFb5Vd4kSYf
         JzW5H7xJmJMbHnozd/Kby3/K0RMC7YwOGue9BGQFPFaQxLqf+jGfFtbSU580bYn04XDr
         HMoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJllzPt7YcYTlmhVDIoPWgvCTjsPks4MNQPMAnFEEsUIhnsRygqXNPvKEVatQZcH2Wp5F6kTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKynEMAIUIPgztJN/JkF9onLoOv711Ix7tCYKW7hWX38tVTKu2J
	qTIK144yooe1UJEwATb7P3VvQH3+RE4Iil3MF2fy5c6AsCUG+T4qsOzz
X-Gm-Gg: AYBFou1xnl4+o+AuJLqq3l6gH9YciS31WqBMn3CUCsfbE6X4+04oFBjhZQRrhv5Y7xS
	y9BL/L0VsO59fRVFGldt+fw/aaqoMY7MsKu128TAVsHebtOWE/pRHicf6qGSnNnSP6mE+tiHDXK
	9/E6Llx0M+mMAl/CngfLnHsvIuElUa67AEsP0Lp956vx0izVmMDM2axAHt0oBWOHDGxyGXkT3u8
	VP36sfXnPWoiAAh7+4bsFSNTmE7SoIDa4inN2EppTILBLMl+7SoA/z4JJRFWPGVdsmZU6UNQj7g
	qo0BIkhTsidq7+S9EbZoeNpmQA7j/M/Pg8eh4DPULMRHbysEGjNmpX8eOxH11EuwxVkR+9i3pTK
	wyeo5ejX7bak3rLtJOp3qr7OJ9eTjnr/R8rXsjVR4w6J9Em5XYKtHWYikj6KY8Ije9QYmkROSYh
	k0q+piKzSjr+heg58rVj9QbFNNkdC1ERfa4ZzAtZS9F7OjWb9dksS6khPUUbyIDrgRhw8CvXlpq
	7NhGJs07FDys8Pobn0SFuEqs9FmLmVZdZ1Zn+QBHOn5piomt1eC9UlY5jLbkg7YpTouRDosAwCr
	qKMFc5CEmDE9Z+G9rL/Vlr2i8cF3WWKzdKjzYHZzVW48Zg==
X-Received: by 2002:a17:90b:580f:b0:3ac:9d83:8856 with SMTP id 98e67ed59e1d1-3acee728d5fmr1409074a91.9.1792200833215;
        Fri, 16 Oct 2026 18:33:53 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f4cadsm6093997a91.12.2026.10.16.18.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:33:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 34/38] bpf: Let bpf_dynptr_write() mark a global function
Date: Sat, 17 Oct 2026 01:24:47 +0000
Message-ID: <20261017012451.364800-26-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The caller of a global function loses its packet pointers if the function
may change packet data. That is found out by a scan for calls of the
helpers which bpf_helper_changes_pkt_data() lists.

bpf_dynptr_write() is not on the list, because it depends on the type of
the dynptr: check_helper_call() looks at it. The scan cannot do that, and
so a global function which makes a dynptr from the skb, or gets one as an
argument, and writes through it counts as harmless. The write can
reallocate the head of the skb, and the caller goes on with pointers into
the old one, which has been freed.

Let every call of bpf_dynptr_write() mark the function, as a tail call
does. The same mark decides whether a program may replace a function.

Fixes: b5964b968ac6 ("bpf: Add skb dynptrs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bce7b5abcfda..2ee950e9ac82 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -598,7 +598,9 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			/* nobody knows yet whether the dynptr is that of an skb */
+			if (bpf_helper_changes_pkt_data(insn->imm) ||
+			    insn->imm == BPF_FUNC_dynptr_write)
 				mark_subprog_changes_pkt_data(env, t);
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_call_arg_meta meta;
-- 
2.55.0

