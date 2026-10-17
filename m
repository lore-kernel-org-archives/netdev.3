Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288A380FCA
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255107; cv=none; b=ock4x8MZUtv+i5EIOupAU7xvupBJFU5tnrkAuHDdnF8strr7hVmB3RgIOeF+r4PQx37cRUbNfs/MbjmcE/lKYYoRUj23V0HVhOD388GPuHGEkqJPqgwga9aBkaxcCl3aAzIGt/zHTHQAAo5FeaoZ93ww/kBl4qLGaW+GXOrRcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255107; c=relaxed/simple;
	bh=pZ33VTUUIdr3Id42qBrlx9WaCFhb+RHlrLGHiyQcfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/VjCg5YZUjpRePyOt9B/CBYJstJX305CZGoHVMiwRwlraBN9G0jmtYlFmaTM7F3s/d0QxGOKZQN7o7Z/gnjlPrJKvV+cQJUVG47RBuEzGv2Ca+dlyZrNlSzEihNYYtCIAKw54M2WtQvdTuszmhzUaMnEq/KfG1PRz5pphuCytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAaktpJ+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAaktpJ+"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso561390a12.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255105; x=1792859905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7Y25xFI3opj7OoI+d09/Ii/VGS2yIeOd9lXy3hmv0k=;
        b=WAaktpJ+2rkbK58DBKCNbLNaQKuJ3WN+W5Zoqg6dPD7Mz8dHE4YkfcJR16JcvU5Z9K
         L5fJAvQqdD3GhFtq03TKRCfNuCl/mVJDeyqIxKpZK7pU99ry5+UWHoEkFJvh1Xl0+CtU
         +FW/ydH3tBZbSb56PPmsLeQOvRV1VORg/23rRFQcZEcV5ADE9Otf8Rz3K1cdHaqnkNRc
         vW/DJODDbDMAUrsZlzE6uDWGDxHr5qLg4gZznFCvnz+Q/k5yFRklA0P2dAShqa5VotfZ
         YYkf+UC+fhSv+rLJOZFLqWL09xADsEhK8Y1eOiQ9ozrR2Mr+6yY6XwkNDclThaJdIHw+
         T4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255105; x=1792859905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i7Y25xFI3opj7OoI+d09/Ii/VGS2yIeOd9lXy3hmv0k=;
        b=ZtjckiWA9A+cNsEXDNQHI+NRwfzCKNiQHqHBja1vPmUIBtK2mHR74qigDZw+5xXu/O
         rMiluOGv1Go/iQa0BAZfNjB0Y+uwnQpdNSj4YIMDlXOvco531wX0M+fdEtgXYMPUFaTC
         cP5qU1wzdKx1UmdHfy0umq4BNwc+GZJWtH5FNjfCuNqex7abr6uLvDXG59CJL2WmB58F
         KZ9ZCrw3eA92DVaaXdIf3CdRBGJ7NHzFUFrL9yINK6wJudngyBqgcMfnEwMkNhD7WA4A
         Ut37TaWWrQRWMyd7z3E4tSlT+sexdhn7DEXm46vB8yIik1a1iDe50soa1RDj3uM1WeKl
         Js/g==
X-Forwarded-Encrypted: i=1; AKwUvBwzSlGA03uUXV+45F4fPXOYiVG6KlzjHUhD6X+SCbjUUJ6pu1Vrhg/EXLHJDVR9jLldxH9iXnA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqyXRhdl69jcwmfhGgmo4+5dAbKZt2RNmWiQHbY8VIV85rhq8V
	+xhhMLCJDKPHSS4tKbEfN7ZU14pN0dNlpNgXY8TeR3AydS8eaPbvpDMJ
X-Gm-Gg: AYBFou1ioaz+vlkIYRBGojqds1mUox0nth0s9bNdjVX17Gnp1UnuUO1K68htX7DcYOM
	xo4jRbNgczjrGMBBXUkHUpX7U98LmPAmqV4zi8VylQ4YaArQg784k9d8qRyb3R/Tw2JsPvGHeek
	UbXPD5QWGvPagiLAjPkZqhVEzBrrPBDFz62ue7qZxqHBlfbqlAeieWuYswAGShUJ6OtpXml9Nt9
	v5nS6xqYqqbQO/VQAZbDND56h/8E8IeWvfYH0skgVcZJNVF9AzbpyzmuAWbBL90XEzGAhkb5Gu/
	nSbcDIDjXIk5IFUxufkdnsyIqLNCus8jyhJ/yL4XSjqjwz1JQoXnzrJvlhd5bDdvhcEnG3NzmBA
	s7KSyRRlS4w5RGr/1gplbSPO2B1vqj9kduN2+lWa0ulbse8i/ynvZIrbtQ0rjNc90/sKspYa7qo
	D6g61zMLDvuocNA8q9yURPq+Vn9LMa10Lqlm4vkzaletzL/Nsl1FTQGeVvY27jjZvNSbTiw9Q1f
	NuDE5ZfHZJEYhjHUfBgfkUXJXqOsDHMz5eKQ1ifW7L0X4by4or6SV5JjJbDm/dogUZfdPQU4Lyb
	+Yr7DL4HCIaePmrdpHwwyFFk36QByP/J0wp5VK1IXY0tUg/pW8KdSw==
X-Received: by 2002:a17:90b:5112:b0:3ac:450a:f9d4 with SMTP id 98e67ed59e1d1-3acef1544fdmr3002708a91.64.1792255105361;
        Sat, 17 Oct 2026 09:38:25 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm13655450a91.8.2026.10.17.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:24 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 06/43] bpf: forbid sleeping in bpf_find_vma() callbacks
Date: Sat, 17 Oct 2026 16:37:08 +0000
Message-ID: <20261017163745.3341787-7-alexei.starovoitov@gmail.com>
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

