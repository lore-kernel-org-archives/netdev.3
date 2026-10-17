Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A643C0624
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255314; cv=none; b=dLg2gYpGVJw+U7CBFTybAUswRC71cRvKVNLfKpHOQEHZJ9lpH2YSql4sQ8e5rk7Nw+TGbNKEAmH0/QtKn/DHkKxtdeS+IZ8ppZfGD9WxeQskPGBAXVtTU8xRpi1a9XvxAOCEe0U/FP74xgL6gPIxItxYxHEuhB2g8XbBNrzJlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255314; c=relaxed/simple;
	bh=R+DPCBEkdgYI6avsD7xgcl46Y6TXpa2aAM83O0WBiXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHw+zdhTPUC+IAAVFPcK+k33SWOvgRbCjnU+xGZneLyBiZh3YXHK3P5nsd+i5zDP5QADZ4uLgvEvf09U8QaJTaMk55os2sKBpV7QayKMuF8FVEEzeOyjQmCSesW9zA3jvOcGyw7B3c8wnCOpXKlJNOhff7pIN8m4RzE6i+jreC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldXI+/CT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldXI+/CT"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-881269371acso857364b3a.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255313; x=1792860113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGbfhlZclnf0Sz0zZg2NrkKRp/tNpyz/wz+xRYKuPic=;
        b=ldXI+/CTCUGRY8L0DoIDVPS8rnOCrQYiT8EKYnGYEQhAJ4FIdxN5VirF2+0z5RmMTa
         EWbrWk7GwSgFjTrhuGUHxN07nGTkvh6v8EkaEluqdZqfiE7knKLLmJMhZXCbVlxQ2TbG
         n7woJaROkHSXReglBF6lrUdl9g4oIE4dhYSnEIgpyhzCqQbyp8c+RsyRUtzuqN/syUuM
         7Q9Atrm3BMtrkvogs6IQWG5NNWEol9OtnUoGS0TwdM4k0B8INWvz7pP/v8aRnQR4QOJX
         lbF28mxXbJvqOmLHpB3V/t5dM3BZREZ1Fr3q4g6rYmQcPH5m5Rf9GRuqsoUo716FvhU/
         cD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255313; x=1792860113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGbfhlZclnf0Sz0zZg2NrkKRp/tNpyz/wz+xRYKuPic=;
        b=YoDzjpsz3BhaSw31MexzSvFxCrCYP00Os3RGjIsE7FPXTtquFy2IRVVPnjfWifcL2D
         xS7SCJAS8mbAouM2bopwlS9U5wKcyhx3SUB5x7FBRwdo+ANp6bvGdApb9tR1p6aH+MCR
         OzacOOtRA3DjTs04IJgc7tUOZqdC2ap+bO5SPy8Z5+PPlQVbaGG7Z6yC2ZWvxa9SCivr
         ElgVwO4rgCLOPtqAlKC2WzZKig2php9aQi/NAbxINlL0vOgf+0paBq6xNKjGd3hXrM8w
         FQbhRiVj2/7OzBan0mejYqvJju75tS0OpqwvnBPTQrfoIIHMTvacO9Uh4Ror+HzvcxoG
         vihQ==
X-Forwarded-Encrypted: i=1; AKwUvBwA4WT9bD4dgNi4fPcevhmNIrhV20AVeFfqZnWwPLshou21K1J5Bvhfbv79qalCXZrz82ZciQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz08A4hHIQy1BE5GSl4uTkiTStyUinEj+UTKyiCH2fbRfXPZbM
	6gNHP0N0jzPBNzafXZncgecxis5L9XkaAHwCb6e/HUB0YlLujB1hXf9r
X-Gm-Gg: AYBFou2gvjkJK2wcF2YCyp2k4kr+YurdXaEEYFj1wqQVwmaoo86PedwqYmxmh93VPLj
	XyikebYAttZ+AJNkqZuCnBx0Ud7baXWMotl0aEHt7MoHeWIooFN3lF5fsTZn/+waXRXUR7TmkWC
	/2FdATJAG4zL0xb9r1AhsWlDt9orbJuX0kJTfdZ/1CM07veoMtCwmS+pmYFu9AVNJa0F/KoWFT3
	m0z7nQgIPwIDOqaX+QymX1LyGAob0vjUwIhq8dpUKNMXvYAHj9YjdQBW/VqGQl9m+gXOMK7NYRW
	VkJ+iBoYYQz+SlnwU0Fhm7V+0pauR+h5L0fikOYreICO5Vdxsh6hWxWhJynXUW1rgm4n9rk+Xg5
	MUlqhMyBWwPMTTHtt1W85CkH2axdsak3lJi0meEl8fF5YH9Q2zLSLTqab8/A5fxYXPON5ocrecf
	K6PfjsuZpSwmv3ZFTgDSi9SbBniw/R+NyAFYQ+V8VM9RC1JgSt41wflSrnWybxGm1ah/LzDxHkW
	D0//9iuukRD80J1it9c5ibaitKDCgrOCEEslTeHhW+VxLelYWhDbvdv9ObaZwK/cmJIky7EkjM0
	aImBT6kwFzIJtvrFXEiqZ/vhU3AUm9mAvMo5awG6KY3jj3PMjJdteG4=
X-Received: by 2002:a05:6a21:7e82:b0:3e2:2b6c:2e7 with SMTP id adf61e73a8af0-3e22b6c0795mr1299944637.28.1792255312990;
        Sat, 17 Oct 2026 09:41:52 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2277863a12.20.2026.10.17.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 40/43] bpf: Unclone the skb for kfuncs that write through a dynptr
Date: Sat, 17 Oct 2026 16:37:42 +0000
Message-ID: <20261017163745.3341787-41-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

bpf_dynptr_copy(), bpf_dynptr_memset() and the kfuncs that read user or
kernel memory into a dynptr ask bpf_dynptr_slice_rdwr() for a slice and
write to it.  For the linear part of an skb that is a pointer into its
head.  bpf_dynptr_slice_rdwr() counts on the verifier to have uncloned the
skb, see bpf_unclone_prologue().

The verifier does so if the program itself calls bpf_dynptr_slice_rdwr()
or writes to the packet.  A program that only uses these kfuncs gets no
prologue, and changes the data of all the clones of the skb.  A packet
socket, whose clone is taken before tc ingress runs, sees what
bpf_dynptr_memset() has written there.

Treat a call that may write to an skb like a direct write.

Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d384b9ec3d93..47e2969928a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15689,6 +15689,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	    bpf_is_kfunc_pkt_changing(&meta))
 		clear_all_pkt_pointers(env);
 
+	/*
+	 * These kfuncs write to the head of the skb in place if what they write
+	 * to is linear. Like a direct write that takes bpf_unclone_prologue().
+	 */
+	if (is_kfunc_dynptr_write(&meta) &&
+	    dynptr_write_changes_pkt_data(meta.dynptr_write_type))
+		may_access_direct_pkt_data(env, NULL, BPF_WRITE);
+
 	proto_slots = kfunc_abi_slots(&desc->func_model);
 	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {
 		struct bpf_func_state *caller = cur_func(env);
-- 
2.55.0

