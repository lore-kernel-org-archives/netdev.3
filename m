Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB933BBC0
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200078; cv=none; b=JA+6KCdQb7N6MmuS8qTDtsZ6VLgc9IVqBfwfBmCUdDkQezk1k1HsJ8HTpK1QtyDw+uiF/Fws6XmOh+P35mxBKMWSi2TGFQABbyVONP3ca1NLdcWuCUOVEKW5hokI8A0xTPA3kme1NuoNXz6dujF5j2ksGv3qoAbDL6jU3+eFo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200078; c=relaxed/simple;
	bh=fybVEtCas+7DMsFNUiwkqaOZclGA+uKG6xT1qFhkCLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyhjDT82PW2+aqW4fwbgFCilZaoUBZ4Lhwlv/4vvaoZYLY/FhunOzN7fQ2mWCNJbJ4lQ5i9L+lRho9a7f5jOReCeRd+t2Bu20MnO169lvHUiD9ON0LsJftk/yu9oj/kU1WeloiOJPiM2grfNpK+WnHE+tx+F0SP7XMVtaJp1nC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2/SKNUr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2/SKNUr"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so261119a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200077; x=1792804877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BXXtFQVJAY0RHO2SY4ciAs6hnS36rdIEF3aYK67XVQ=;
        b=l2/SKNUrlD0orOJWsvC+LPvBIXDMc2/5Z7F6z1H6qOqWFXFIbpXK+1zYWU3tf8GxOX
         TycWC4ip/+LABwLy54Paw8X4F/RQRYE/usXwhohwD0XKEnVaP7gU6rgHs3zDcvbh5tT+
         BTCYC6CnBEonlqaUbXML3E07zaXnkUICopyH1LxwnuDksOWWtNB3XTDJCeBTbhzPCI+i
         igFImxmrY/Z6Irv9hnolgUMO/zV1yIIGQ+D2PdbZWFcTVAFz84l7KRSoSQmC2hDqalem
         1RE11FR1YhTJJWAS2N8cqnAxuSNaCpzEoQAe/PbhroVOPTMx6wAT/0SSqdT+xc4gr9KS
         dgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200077; x=1792804877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9BXXtFQVJAY0RHO2SY4ciAs6hnS36rdIEF3aYK67XVQ=;
        b=u4wwXvzHZhGGPRE6UIwBOhrYS3Ghuw53aa/UXBO2Nens6878FoNY53QNgkCA/3MGL1
         L4sVFDN+4cbsbAnT0dl+9LWYl8rwnD0NxMcXiTR2BApKvSTPR//CyZjq7L8xvIc9OZdD
         8k5sE0qgXynv4w9gC7FCTYHBAxyOe9YVGtdVM6mjQfoBdKE9+vwxwJZa22qMDzsLOxO1
         M1DieHTDwNSB7ntpIkaWrnWVmZYIrvy1q7WzSrpcN+aSw9Gn+nKBsSzNPp8SQtZgK0l+
         9EvsO7o6xpfAFxT8E3tV8WMPNTEJRqke92Q31pOL8XB1jzCzXLXAAU30M1vNoQp/xYjw
         QQVg==
X-Forwarded-Encrypted: i=1; AKwUvBwst5omK43/X7Hbnasd+2EiZqMzWaMFTNpg+5et910PGIqmyZnQFRYtEjfggt63GEUkDZ4NCZk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLN8mpsE6W3h14+P4YxTOAV/Aq6z7TCmAe3CX8v9BBuTbNZlkWm
	8EI5kyvRVV/iaR05ATtzTcuuU4iqX3hwwHa1mS8/M1tV0TPfHQCYWRbMxpsEbF2w
X-Gm-Gg: AYBFou0XSkfbsfQ58i7eRCfJRxLWlcilAsLOcuT12kLpG0o8krr5iqaNb2BV+Pi020Y
	X64+YNDw/wBvkoyRqZUF/ta++yaIXZx2+0rBF1eo5I1E/Pf54hLWYVn8Dj3TQrDihSXpm+qgsu6
	YZFER2NybWl8y6EAKVzCiJycO7HEM45FjQqW+CTBq4Zz1kGm/p2+Pn7LZ6W9fsAApftWB2nmi1V
	UA4s82BjoojWTp4knLj4irDGkjQ4umsl41DRXI6WDHJC0Qb1JWrjGohsQY9O8L9soBMsOD4cdBJ
	HoK0CPy/gmU+sdCVpBqhwRB/ogztuNOQyrQqVSSej8mf3jRcpOxL7x+DZIZDECx0DKSpvI8yCIc
	fJ3VAAvofTieU0xnKA+6LC/xi6aC93rwl+dPazJuQDROC64abw5hWEeT8SiVVJHMzSAES7fW08Z
	DsYgBDWy2DREAeZk45+RsMYgmbd6MiJqa96casDkkFXB8poOwkelqNUQg95HEvdVf9gj2l3Ovfb
	DI92P/dH+iNq86VGt4X6YiqFEJkDRq7izw1LzoBKMHcmfMsc77H8MBsIKnZsUJXJq3l5DVE9vsS
	UwrleIrtyPbwMJs0TzdJtay5ydueoIeZlyLOYHEQlQ4=
X-Received: by 2002:a17:90b:28cc:b0:3ac:a11a:7c8d with SMTP id 98e67ed59e1d1-3acef542f93mr1219976a91.59.1792200076490;
        Fri, 16 Oct 2026 18:21:16 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549b6171sm1733046a12.14.2026.10.16.18.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 05/38] bpf: reject sleepable programs for task_vma iterator
Date: Sat, 17 Oct 2026 01:20:25 +0000
Message-ID: <20261017012058.355787-6-alexei.starovoitov@gmail.com>
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

