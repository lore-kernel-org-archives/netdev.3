Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7083B6379
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255222; cv=none; b=gZu7twbl+EvySwn1ADLfhiAjlE/qoaz8QGiR0OXL/tJ1MCQPTg/q2cVdy3frDBrvMo7nO9dgUuQpWkssVmJCsCnEVWV7Pcxq37QHem/q5VFfeMv8bh1OOiIhCKrt1S8G0CrmGmTSKUwUInV26B8nkaNUbKUmamMHbMignbo3yls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255222; c=relaxed/simple;
	bh=pGOCrlht/5JKJ4wLHC/LTfvfNyE+Tah6Y4Jh+6xXwO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiSbmWAfw/gy4bAgSVHKgfmGFSqsRfNY898Q0JN6wF0xkV9HgAn7rriZWHzlCN4iY4pDKtDcJWYoXBs3cny0xfc28j08kek0fGOdtbqcFh4U1o2mFB8qbj7VyjkTtb/8IfGAxgLudPvYnMmKCrSvSwiwYLjydr+gmw9l784iPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7mLPm/9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7mLPm/9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so4563785ad.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255220; x=1792860020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQIOxyhf2PbQQW6RWNbZBxmEX3PKBk/yK3ayrqaRkDU=;
        b=s7mLPm/9ClECu3KiVa0UvmfMOj0iTq9Y4GOpcaXfTH29g7LV86Ud94SGW0OC5CZ6De
         bjC8utOATk9wn7JMJ9XwLon9NjwrV5yQoUAs5rhnfXQQBTGPBLON/Ef9/gJyUBO5oS/i
         3vJLZX2cdjHWC+Lg791n8jKdRkuv/GGr2LzFDwl825JwFLcIV8E8L4U0I7ZH0ym25CKk
         2Yfp97xzdhRCHqJXBTjbgNUNi1SjEZlO5KjUPRGvbJ+PoCLdCOb429sWM1sM8YVrfPZq
         0wBwxQeRWWTlMElJK4q4mb3neVjDTiFtTWMGw/pENg299h+BHJ76cJFqLi5jrS5jkLGN
         Uypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255220; x=1792860020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQIOxyhf2PbQQW6RWNbZBxmEX3PKBk/yK3ayrqaRkDU=;
        b=Qn23lD79Ae5ZooO1nyoZFbO5TJcCeLyF7/wmfMrUwBg8Hkg/KEWUIJlyZ7uxk7qaiW
         GXqLKOsItcy4bfGsDPh4BQEW+OrxRVhayTvCiSzvFWDluL2Zgg0HRvm3Dacz3YZt4EBk
         ACUqUNU6ep873H+HpGNzQXFcSEQ/rXXkQYraO9ZG66uGwHbtjjfmSsk2ln9WJiI0Qtgk
         NuyLyWKeirzIHEcOqPL3gBgjh2sf00fVM9nI6kqfZyu7zXgq4aW3TRrCTwpjBg2piOON
         TpZiO4VSRhOlsizwz/TjgvuRU099ob77GOGduzVSjR9L5HgcYCgzpZcTd45YXfUMPvzI
         smmA==
X-Forwarded-Encrypted: i=1; AKwUvByCc+7kvm4zRPe4Ec9wl6DVl/ur4dgrBkgZblBW1smUZ5Cb1KPqi1fAUKBKzhH3DRaOkQ8u2kU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+da+/MBm53tfxwh9kb3X9RWy2ycaYzzlb9ny1wkkT5ak+r1xp
	d0yh8vAQ7MfbrUlHEbngDZCOCCUWkOuZ9U9yPrd+FWHEiYQa2ffUR3xt
X-Gm-Gg: AYBFou0ARReeKisZHigz0WrOGKs5SAJgV8gjk/rulQFkFu7btASYbpc97n95eNkHbk3
	HiheEyfSVoBls+Eu+VRMFFAepyDI75WMczKdiJUR6K5ZQJa134MaJDu2lNRIlfC4yDmAp86Gosh
	BrHao/9nLE+C7p5U71SMde2np+WjjpjNzlB8uxxBSnIDWKRmeM3lFJKzqkTQx2ii9zvh9ooeXfb
	K5XL3kIA4nXISON9/1sNxNhZJNiEmB7ep3pP44JiQl+uDULrl0X2pS8s7SL5mBgzGPZm+jfNqNv
	Pm4RoXzqiNSyUVd4Q3YJ+WI63tta7ZoT8TTIA19/wMJUMzPwVc678gqFInX1W6otks+M3VsS4lp
	vbLZpoxNzpeFFmS6VMN6NgYuDQfCHU36GkS5kwbLNKJhvYODlHESYQmZrFS5pgEMAYi3XJCzVt+
	mJmhErnjmKFiBowrJ0QmAvq0E/Rte74IcXRb2lOWlClP942I7jsjqEb0pRWbu2Vzt3XFgvU7N6j
	uNBf5OOkDPWmbtGJ9L4Tbtjt1MO52p+GiD3Z6iQVl4QX2m/wCQ+Q2E6xQ25/r6U6hRadRdbMxXY
	/gABmNl2SOCjqKAy/FYaxykrObXZHXVM2R5kA2Iv9u5sFhL82zXycvA=
X-Received: by 2002:a17:902:e80f:b0:2e9:740c:371 with SMTP id d9443c01a7336-2e9a6c03017mr28106065ad.38.1792255220056;
        Sat, 17 Oct 2026 09:40:20 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d7csm22367845ad.15.2026.10.17.09.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 25/43] bpf: Assume no bounds for buffers behind a tail call
Date: Sat, 17 Oct 2026 16:37:27 +0000
Message-ID: <20261017163745.3341787-26-alexei.starovoitov@gmail.com>
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

The bpf_map_elem, bpf_sk_storage_map and sockmap iterators hand the key
and the value of an element to the program as buffers.  The verifier notes
how far a program reaches into them, and the iterator compares that with
the map when the program is attached.  A program that does not touch the
buffers passes.  It can tail-call another program of the same target,
which gets the same context, and whose reach nobody compares with the
map:

  BUG: KASAN: slab-out-of-bounds in ___bpf_prog_run+0xa46a/0xae80

The program array can be filled at any time, so there is nothing to look
at when the link is made.  For the same reason a program with a tail call
is taken to use the whole stack and the whole packet.  Take it to reach
as far as can be into the buffers as well, so that these iterators refuse
it with -EACCES.

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Fixes: 0365351524d7 ("net: Allow iterating sockmap and sockhash")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 608621d7f225..002c3935a8eb 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2151,6 +2151,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			if (!bpf_allow_tail_call_in_subprogs(env))
 				prog->aux->stack_depth = MAX_BPF_STACK;
 			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
+			prog->aux->max_rdonly_access = U32_MAX;
+			prog->aux->max_rdwr_access = U32_MAX;
 
 			/* mark bpf_tail_call as different opcode to avoid
 			 * conditional branch in the interpreter for every normal
-- 
2.55.0

