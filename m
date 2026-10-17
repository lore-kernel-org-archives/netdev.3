Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E63A0E85
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255101; cv=none; b=qz2MgroSTL9lWaDA19ulLsp0MXcq8QvBCtYQYvVUkQZlgayn/E1ePxwt2pmZ4Q7kQJwZSlW1Hvnl7d8h1mo7Ftd1KsASGlJDE9ttxA5CWWnb0dpsY8w4PsIUrnit+UiorLcBvYd4ruov3weFoij23ImevveMFlyb8Ir3HNPaswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255101; c=relaxed/simple;
	bh=fybVEtCas+7DMsFNUiwkqaOZclGA+uKG6xT1qFhkCLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee0P4t1slbFkZb0RTQLCVBLSbC/WDYtN+TzVFXl/exHT5nV4vkW+NEj5iWutrM9KM77rKxJDKCcaQaJG3y5C+2x+vveRiBGOZmivutNrfgoV6iVO0dvnCy5T2EaU8k5NUr8E6esfcPT9eeaztlcJYj+A0/M1dw5rOK9MsvZ/r4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBDtKmqK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBDtKmqK"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso765486a91.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255099; x=1792859899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BXXtFQVJAY0RHO2SY4ciAs6hnS36rdIEF3aYK67XVQ=;
        b=oBDtKmqKcNNOjliocahH9nm3dv1D525ZJ08KXpU10ojEGqTNYK1eq+DGGv71YXEC2s
         ngfmOAAxy885Oa4KlqWPHVdlRSaD4GRztqB/LetRXbxuMVWJOtNgiEQhc5KBJY08ar5L
         nt7F1b+xu2XL3yBr6ysfLOBnC15ImEQ2qoTv/Y6wgYB5+16j0iVSk/Kp2y0FYD9AEQ31
         bTaRBhS3lLhe3QVWFP703lQvJn6WmIJhbkEoT3Ap0yrVaM0aS0LP1Ok3oMH+rhiJ0Sh3
         4VWe61/PU7MHefDU6wllOO923mODpEuq5K6SVvE7h2peoM9sS9e6S76u3XWMCP1CUm5A
         0wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255099; x=1792859899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9BXXtFQVJAY0RHO2SY4ciAs6hnS36rdIEF3aYK67XVQ=;
        b=RmWI0VMSkOogupBx0J7lpqk+xUMjOYudTfUVXZlW83CDmsuJE7INR1weaDslifPHjk
         imt+6/IrOQzDk9kgYhz7TlrtsxM25LO5OXiPV9GY3N4W3qZ6Ntw2S1FqQy7tEE9XItLp
         iEsw4mkIJsNZOg/STEEPq3sDPf4Rgybt/738zEtR0npLgViDtdSC3GaMaWABdI6gQY+u
         ZZAevGR+RBKoxZG3KcRkFDctvSllKEQV76GrBztetFFScHxJw8YV+P3bLJXoRPYuT4ZB
         CmR+nYOCrer/kCsEq7k60v31UF3fWF9zL7DpalsNdGjnsTpwEtZSGT/c1EVl7VQWIolC
         gO5g==
X-Forwarded-Encrypted: i=1; AKwUvBxreTg72LvHFM3UpM4rkkbdhGT+DcC3CO6oZfKsf2dRk11/6MvooDc2WxFq4Bqekhx3WZjUZ0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/8bSCu4Z7DvuguS1FChoJoqj1dVRNE/37y1ua+EaNsrVRK9Ap
	42WOdxCS5zyeRR5H+EmDiamg0JT82cgA/nSRIHUYnDxb5tVK6rnkTzEu
X-Gm-Gg: AYBFou2tA1k7KIWQlaJhotmCtsPiWHopMSw6MKea8yEKWpNEHw6uDuKtPBu66oVQnmi
	v4YnDfZVeQPviYVHy1MWXeBda9yBLeeJg/8gN3pZ5aINbhpY+x4zBF5r5yDvPwWSjtJPBxzPZDL
	U8annrap7y4CWRLfugnvmbKM4wqiKNfbG9E3f2KA60c3JMuqr7NvQoY1cEtLJvVRTUQZeWwZ8nl
	l8VfmjS53jc8N6t8EKPY6UbiDgveq+NDdhBHh88Lv0FC/lNeRbrxICytY60eMqnncLP4Ie34S24
	oOHEMj3rRSZEEZ0Cq+96AWRYgogDPgrR5XOjF1rG+S3X6Y1maU2bbB3A11Ghikdoy1UdCel0zVF
	xgiiopNtZpIr30CU+KrBed034uuYwzXK+PMLbPTemSNTRek5CHV9voBRAlYCRO1hYkGdu2AH86N
	xncAfrwI0QPmpYndWr/z1QuzdERu3HngjCV+SCaU4xH+a4qTggniLpmZd/gpOuOAp8IWPcVfUZu
	GBF90aViYDPUoeCam02/ab5kx14H55qcCgc+4KttcbUEcPtRALxJGqE2Uc9ob5HRgvrXoNYkE9s
	lIFjAFdBAFEpC9IJ9bbD2mVTvwkg8pFBODvQycmXGU4aR3zz9tPV9A==
X-Received: by 2002:a17:90b:3148:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3acef60f597mr3016047a91.61.1792255099383;
        Sat, 17 Oct 2026 09:38:19 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487e509sm8691828a91.9.2026.10.17.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:18 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 05/43] bpf: reject sleepable programs for task_vma iterator
Date: Sat, 17 Oct 2026 16:37:07 +0000
Message-ID: <20261017163745.3341787-6-alexei.starovoitov@gmail.com>
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

A sleepable "iter.s/task_vma" program can be attached, but its ->show()
callback runs with the mmap_lock of the iterated mm held for read. As soon
as the program runs, bpf_iter_run_prog() calls might_fault(), and any
bpf_copy_from_user() or bpf_copy_from_user_task() it does may really fault
or take mmap_lock again. With lockdep this is reported as recursive
locking of mmap_lock. Without lockdep, a fault on the reader's own mm, or
access_process_vm() on the iterated mm, has to take mmap_lock for read
again. If a writer queued up in the meantime that blocks behind the
writer, which in turn waits for the read lock the iterator already holds,
and the read() hangs:

    reader (iter.s/task_vma)        other thread of the same mm
    task_vma_seq_get_next()
      mmap_read_lock(mm)
                                    mmap_write_lock(mm)  <- waits
    bpf prog: copy_from_user()
      page fault
        mmap_read_lock(mm)          <- queued behind the writer

The reader waits killable, so the hang lasts until it gets a fatal signal.

bpf_iter_link_attach() allows sleepable programs for the targets that set
BPF_ITER_RESCHED, and task_vma sets it because cond_resched() between VMAs
is fine with mmap_lock held. Rescheduling between objects and running a
sleepable program inside ->show() are different properties, though, and
task_vma only has the first one. The open-coded task_vma iterator does not
have this problem since it hands out a snapshot of the VMA and holds no
lock when it returns to the program.

The vma handed to the program is only stable under mmap_lock, so the lock
can't be dropped around ->show(). Add a feature flag BPF_ITER_NOSLEEP for
targets which can't run sleepable programs although they can reschedule,
and set it for task_vma.

The check at attach time is not enough. BPF_LINK_UPDATE replaces the
program of a link, and bpf_iter_link_replace() only compares the type, the
attach type and the BTF id of the two programs, which are the same for a
sleepable and a non-sleepable one. Do the check there as well. That also
closes this way around the existing rule: so far a sleepable program could
be put on a link of a target that doesn't set BPF_ITER_RESCHED, like the
hash map element iterator, which runs it under rcu_read_lock().

BPF_LINK_CREATE of a sleepable program for the task_vma target, and
BPF_LINK_UPDATE to one, now fail with -EINVAL, also for programs that
don't touch user memory and have been working since sleepable iterator
programs exist. The programs can still be loaded. They have to be
loaded as non-sleepable programs, or use the open-coded iterator.

Fixes: b77fb25dcb34 ("bpf: Add support for bpf iterator programs to use sleepable helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h    |  3 ++-
 kernel/bpf/bpf_iter.c  | 17 ++++++++++++++---
 kernel/bpf/task_iter.c |  6 +++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..46d325aa178e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3137,7 +3137,8 @@ typedef const struct bpf_func_proto *
 			     const struct bpf_prog *prog);
 
 enum bpf_iter_feature {
-	BPF_ITER_RESCHED	= BIT(0),
+	BPF_ITER_RESCHED	= BIT(0),	/* may cond_resched() between objects */
+	BPF_ITER_NOSLEEP	= BIT(1),	/* ->show() can't run sleepable progs */
 };
 
 #define BPF_ITER_CTX_ARG_MAX 2
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b40eb404adab..fc3a75684ef7 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -72,6 +72,15 @@ static inline bool bpf_iter_target_support_resched(const struct bpf_iter_target_
 	return tinfo->reg_info->feature & BPF_ITER_RESCHED;
 }
 
+/* Only allow sleepable program for resched-able iterator that can run one */
+static bool bpf_iter_target_support_prog(const struct bpf_iter_target_info *tinfo,
+					 const struct bpf_prog *prog)
+{
+	return !prog->sleepable ||
+	       (bpf_iter_target_support_resched(tinfo) &&
+		!(tinfo->reg_info->feature & BPF_ITER_NOSLEEP));
+}
+
 static bool bpf_iter_support_resched(struct seq_file *seq)
 {
 	struct bpf_iter_priv_data *iter_priv;
@@ -409,6 +418,8 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 				 struct bpf_prog *new_prog,
 				 struct bpf_prog *old_prog)
 {
+	struct bpf_iter_link *iter_link =
+		container_of(link, struct bpf_iter_link, link);
 	int ret = 0;
 
 	mutex_lock(&link_mutex);
@@ -419,7 +430,8 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 
 	if (link->prog->type != new_prog->type ||
 	    link->prog->expected_attach_type != new_prog->expected_attach_type ||
-	    link->prog->aux->attach_btf_id != new_prog->aux->attach_btf_id) {
+	    link->prog->aux->attach_btf_id != new_prog->aux->attach_btf_id ||
+	    !bpf_iter_target_support_prog(iter_link->tinfo, new_prog)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -544,8 +556,7 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 	if (!tinfo)
 		return -ENOENT;
 
-	/* Only allow sleepable program for resched-able iterator */
-	if (prog->sleepable && !bpf_iter_target_support_resched(tinfo))
+	if (!bpf_iter_target_support_prog(tinfo, prog))
 		return -EINVAL;
 
 	link = kzalloc_obj(*link, GFP_USER | __GFP_NOWARN);
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 13e1aabe6f88..cf2bf388e181 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -737,7 +737,11 @@ static const struct bpf_iter_seq_info task_vma_seq_info = {
 static struct bpf_iter_reg task_vma_reg_info = {
 	.target			= "task_vma",
 	.attach_target		= bpf_iter_attach_task,
-	.feature		= BPF_ITER_RESCHED,
+	/*
+	 * ->show() runs with the mmap_lock of the iterated mm held, which a
+	 * sleepable program takes again when it faults on user memory.
+	 */
+	.feature		= BPF_ITER_RESCHED | BPF_ITER_NOSLEEP,
 	.ctx_arg_info_size	= 2,
 	.ctx_arg_info		= {
 		{ offsetof(struct bpf_iter__task_vma, task),
-- 
2.55.0

