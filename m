Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30472361640
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200082; cv=none; b=johxfcy3pO21+MNLkTrWYzg9oN6dUS6nqalvKFiOJcSiNwB5EYc5t8n6jh+Uwqc+zSOE9QuzI2G48HXpTgIjbwKXoGy+KqS+C1pEl7UIyw7/8zm22cV2m6q6RHOKICzcGvcGmRXyqT/pfZmanXbIHmnU+fjLM/70KnzMQH30LDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200082; c=relaxed/simple;
	bh=pZ33VTUUIdr3Id42qBrlx9WaCFhb+RHlrLGHiyQcfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkNDFCw6qTPEa3wN50NxpJ6l3n2YUA7vbpqm9RByRXCQIhPEC1QdJWRQT40galtHC7MMQNqSda3twm3u30OZ1BCYvQXMPNkJdVgy131CPstYpvaGeIouu8VmSjmE1qnRkfiyI8/aD68HR+yh4Gtxo6iws+lJPlaaPOoOxKJs4w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ko4juwK/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko4juwK/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89d6bd67045so293395b3a.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200080; x=1792804880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7Y25xFI3opj7OoI+d09/Ii/VGS2yIeOd9lXy3hmv0k=;
        b=Ko4juwK/ZuFLPUUK1kDXVxxiHrMQF69AswYiXm1RMUDtncIQDTHm34NydLQHHmwirx
         raTVgMicHjgsanRSXb20bhU2Urkcon7WbPqkuNmAHg3aW9tXeeD4UwHfO+4DVBhf86ol
         QwJKG97ReejLP3ms/fYfinCEBF+8TBD0utCVIH+oMXI5vM/QCGJXsco9xNJ+dLI3wqBh
         cGrK0Hz/05YglwdU3G7svcMe2ZFsWk7OJVC+CQWShXcVFWGx8Cxde4TJPWk2sH2hQoql
         e80wVEB/lEPCp96KozMEW6X6xl+FqR3LH6bbjSr8CPPv3eKOu6rNE1XMziYwtvmW4vyD
         upkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200080; x=1792804880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i7Y25xFI3opj7OoI+d09/Ii/VGS2yIeOd9lXy3hmv0k=;
        b=ZYAaKLVruICd4TUpzetJQ3PQC9GPbrx2+50VvFaNxZVRt0PWSE0znZwCuLy3YdfKIv
         Nu4ScBcgN27q3brGrQy5tUUf2/bekffrCz/886pqBQJzUJoEyD77wwvL2bGJ1hSRcMEu
         711AXVnMFYbqdhxUffnhCs9BowE2Li/7WEWBbOuJeNWMUmM4NxOPuYlqoVztW9+l5n+3
         D7MNY2woGEeuZphYKWLhfdEyvl2+meUZXXeqp70pwV+N9lgBBj39B4/aq7gdTli47KHl
         oXFWzrwepGQopggclZ9TV8lJnjVB4BQ2l9ogdnKDBUQtj8GuxYDGRCQIXAzEWjph36hm
         N37A==
X-Forwarded-Encrypted: i=1; AKwUvBytVZwH5LZjBao/nMBRgDrKQ6we8jfZnts4pFs2CkqdsLmjzTZ27f2nc3fmX6MS8hGUzxYE6rc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd9p1kcGupbD6Lr348ZbVQ0vMhY8IVhJY1SDDsUqbYXcyB3muz
	Owpnxk6m1WywTc0mwp2YsYr+pgJv2vDRhmZQyD2dlCnJBUav5//SzTnf
X-Gm-Gg: AYBFou3ZZADY5Gn2z7GGkJkfBvOvVuKT16MQKDa2HGhhSzFxEE3Y8OX26lISL/azIan
	MzfLgnjOiDQv8Ha7AaLgoKNrn0pe2kyU5npgUtVysruqyxXZkaUH1KN2D9cQp8k0LE9NZwWrklU
	TowM/tLIjOcLYdS5bV/tk4BMbRSC0Ey6FyDr900ljpi+5jepzePESUZhQ7JoYzOIhIQo/OihrQA
	uo/tJlhd9E+X/qkzu3piY+Ku4mMaDYJkMhy7O4iW4ZKJ6oEuxs6QeGItyZI4uFR5tuVmDC2lxlF
	CQNdBHFFjPbSvdQVgmQW1viCkud0vOXo76aiuKQ3gIh2hUX9LDLRVrYU7e8z4L7XUWDWx2vXymE
	dd4Mz3R90VtF3kKJJglIir6zXhNYYjrhkHARXPyVAIBH5sSnQZhTVayi0YMalFBc7/7QTKfCv3D
	cD5ioUUAE0yLKMtZPw8abcMAQhUdc8D4OLLhRvVNJhyYnIpWqmRGfi3/RnfCNJjq9Wl0c08XdDv
	Cdfswu/gmjIiRQ5+kfgLBn5StwWnoE5WIjPfk4dkXVvnGbEjxPw9GafPZk/zBiuhqtJaIGpKQDr
	fpb1nDElNQQF6zBgRD14t2AsiGBZqc3omt8bV/dKYMwX6RtYW5e9ZA==
X-Received: by 2002:a05:6a00:22cb:b0:886:f833:1649 with SMTP id d2e1a72fcca58-89f20dd89c5mr3210259b3a.19.1792200080196;
        Fri, 16 Oct 2026 18:21:20 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58017c70sm1840215b3a.48.2026.10.16.18.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 06/38] bpf: forbid sleeping in bpf_find_vma() callbacks
Date: Sat, 17 Oct 2026 01:20:26 +0000
Message-ID: <20261017012058.355787-7-alexei.starovoitov@gmail.com>
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

A sleepable program can call bpf_find_vma() and use a sleepable helper
such as bpf_copy_from_user() or bpf_copy_from_user_task() in the
callback. The verifier accepts this, but bpf_find_vma() runs the callback
with the mmap_lock of the mm held for read. If the user copy faults on
that mm, the fault handler has to take mmap_lock again. Lockdep reports
recursive locking, and if a writer queued up in between, the fault blocks
behind the writer, which waits for the read lock the helper already
holds:

    sleepable prog                  other thread of the same mm
    bpf_find_vma(current, ...)
      mmap_read_trylock(mm)
                                    mmap_write_lock(mm)  <- waits
      callback: copy_from_user()
        page fault
          mmap_read_lock(mm)        <- queued behind the writer

This is the same problem as with sleepable task_vma iterator programs.
The verifier checks synchronous callbacks in the caller's context, so
in_sleepable_context() is true in the callback of a sleepable program.

Verify the callback like a hash map for_each callback, as running in an
RCU read-side critical section where sleeping is not allowed, and actually
hold rcu_read_lock() around it, so that global functions the callback
calls, which are then verified for a non-sleepable context, see the RCU
protection they are verified with.

Non-sleepable programs already run the callback under RCU, nothing changes
for them. A sleepable program whose bpf_find_vma() callback calls any
helper, kfunc or global function that may sleep is now rejected by the
verifier, including ones that would be harmless under mmap_lock as they
don't touch user memory.

Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/task_iter.c | 6 ++++++
 kernel/bpf/verifier.c  | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index cf2bf388e181..2fa6b8dae8c4 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -810,8 +810,14 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 	vma = find_vma(mm, start);
 
 	if (vma && vma->vm_start <= start && vma->vm_end > start) {
+		/*
+		 * The callback must not sleep while mmap_lock is held, and the
+		 * verifier checks it as an RCU read-side critical section.
+		 */
+		rcu_read_lock();
 		callback_fn((u64)(long)task, (u64)(long)vma,
 			    (u64)(long)callback_ctx, 0, 0);
+		rcu_read_unlock();
 		ret = 0;
 	}
 	bpf_mmap_unlock_mm(work, mm);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 883cf148235c..430d5309eb5c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11629,6 +11629,8 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn = true;
+	/* bpf_find_vma() runs the callback under mmap_lock and RCU. */
+	callee->in_rcu_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
 }
-- 
2.55.0

