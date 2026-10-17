Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDCF3B2FCA
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255308; cv=none; b=Y7AasIoRTV7GtEb3Ja5Q/lTtG7zcMFfNk/FMfDo7L7CE2d+2htbVf+Zg/WYGm5ypfEoPbljxbtshOgS9NT8vCA8XC/mDtykySnTWOj/F4/YOdmrZmcm5bTU0re0ANMUDxytAmITN7cQZNTuIAmWE5+vjSGwCpe/o8RXdPdUgnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255308; c=relaxed/simple;
	bh=vtzRMlYWrVUFGImrGa6pKSIaWK0o77pm550E+QX1aBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWWuTY+0zlwi2PDCKVNyawB2MIVioUbTCw77hRMA3aGZezSiWreAguOSppOgVQquaFHYQG3WLyzHfJa8WtIJfW1E/p/tn7Pc5bfm2QA8gQksjfYRjdQDKd9oiHuFIhIxdomEAzPizjkyy1MvmYkFP1jb+GgzNG+mET4aWmN5nuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX9EfQY2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX9EfQY2"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab98332238so666578a91.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255307; x=1792860107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WX9A5FgatI9/iBdXsBlHi3tZ5RBdWBYmZQ1Rjaj24QE=;
        b=TX9EfQY2rerbx9YCHDfwtKArfAkKi7w7bP4TwtgQxOnYSWtE3/bIT+2o2xlFsN4p74
         A5gTPkbb0UWDqkUlWUR0RK9Pc2kYPWjskUvsZIZxe1VIVNkh3kCTGhqRMNRJXbQdEMNc
         o/oObsX4Lr0VNUP0jMiJwk8mQTfwhS824le/7ii3RdwXXEqn+m4TrO33FgPvI88wyY1M
         rNf6/5bjCGvqQfZNGsKm7PFkceVkXTDz9XdoN7LfbEby9PGCuN4u0ZRLhAo4CMT5uMyB
         gHXi5jzH8a6zfteD4tS36oLVEBQPUd4PF1OOHNq9nN73yF/NvedRC9jC1EHTzmfh/uy5
         rWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255307; x=1792860107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WX9A5FgatI9/iBdXsBlHi3tZ5RBdWBYmZQ1Rjaj24QE=;
        b=b4nPeKpelY/3XMbpXKzWLfc76b8ee1o+nlfrumqjpcUFrytzwfeu7rCJnybNAgT34T
         V5OIKLHL0h8e9FB999JCQ/pALjFukBunWk16SJFxBUqPkNjNIHez3TxOCCJ8XiE79RNF
         gBNwmSqdRwPxJe5lIqKTza85IIUAaozyjYv2WRShbKBJ6CMYPqBBe3wGhDeDkhu9I568
         oHr9mvnEAWAlB/sixPme6cfJmB8AeAD2bNExUKVSkP1pDJHvbXJN13vaUzq3mX5gVzxB
         tSUUMKINg2PXyGDO7dtDWttYWL7GRKUQ8W8ynWTVv0pTmBE8E+5zdId+0mUF9hFMxjp3
         eGFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFQhnMnh83aoHRM0Hs6tdx6T/yX+u9UIIQ4ogCOwbRV6oDLzUV9wgivkeQahfF1Fu3GCpHDII=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/VyfOGpg3XbDquVpT+oG3NBTFd0owiBJeFptRpnMRdhIZDg7b
	eAftfOhQz8g+FQ7YxmPSMthLpB1Xvk3idT3vW6lY0Red3Tfdf/Br5lVW
X-Gm-Gg: AYBFou0EFNaF99wu+hpgbn8XMnBK5Y+pUSi28UnLZ0f+EYunHCtqghQBPXqjdRGgfLs
	ic399pW+HicaNT/VlqVmBKFAorVhMCdUq71KY1eRdREI4TekrRSlY/1EjL6++Rvl78EzwHubYK0
	Qe/1At5C8jNFHb+npfd58qGplnmvCscBcSYtgxjTMk9bl5CtSPxfRocnpvA5l5EBWTfu1Rw4mu6
	8RzZjyk5g8bAolxk8CrZFDl5ALtFvODxoUAJSVxPwNccTx2WPOoIQTzfbSJFgaAIp0IwvUzgC1K
	4c7duYXVNglo/Nk2k9LCmuiV4Zum0h4OXcgW74cx7GWZvLZ2z6xpxP0ma1yZI4Dw/Lwui2OBSO7
	mCoBXygS6Pg8hVQWI7FFV65MVec+1WCy/Zxz+lABQE19oywfGmPA13UBmX/5VPVJxH7DPSlaUMb
	ldwBltyJ/CEbaNNKV+Uc/yEjI1/nsExSWVmWaSz12/gHzE0SMgwevdOglwkzce1Z38RUuy+QDW9
	HSrzQq0OnYwc9FOHvFvW251S8jpvsBAeHLywHOBAv6R51p+qAWmD/UnRMTsqqjZ9lmyQve5WkUX
	Nq5Xqg5XtIHkCo4G7mTydnlrQ/rQiSoJhwKtG1Cma3v0PSKX7tkO9w==
X-Received: by 2002:a17:90b:28c5:b0:3ac:4e18:237c with SMTP id 98e67ed59e1d1-3aced87290fmr2713831a91.0.1792255306961;
        Sat, 17 Oct 2026 09:41:46 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7548sm13855935a91.1.2026.10.17.09.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:46 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 39/43] bpf: Refuse the prologue for an extension that cannot take it
Date: Sat, 17 Oct 2026 16:37:41 +0000
Message-ID: <20261017163745.3341787-40-alexei.starovoitov@gmail.com>
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

A program that writes to packet data starts with bpf_unclone_prologue().
It takes the skb from R1, and if the skb is cloned it calls
bpf_skb_pull_data() and restores R1 only.

That suits the main function of a program.  An extension gets the prologue
too, but it starts with the arguments of the function that it replaces.
If the first one is not the context, something else is taken for an skb:

  BUG: KASAN: stack-out-of-bounds in skb_ensure_writable+0x84/0x1a0
  Read of size 8 at addr ffffc90000270ad0 by task uncl/105
   skb_ensure_writable+0x84/0x1a0
   bpf_skb_pull_data+0x32/0xf0
   bpf_prog_853eb1991d35e093_ext_slice+0x4f/0x321
   bpf_prog_9eb18752b5d0959a_t_glob+0x2ac/0x2de
  BUG: unable to handle page fault for address: 0000000082298821

And whatever R2-R5 held is lost, while the verifier goes on trusting
pointers in them.

Refuse an extension that writes to packet data unless it gets the context
as its first argument and scalars beside it.  A scalar is still clobbered
if the skb is cloned, which the verifier can cope with.

Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fe59e3114d82..32911d7f494c 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -858,6 +858,25 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * The prologue takes the context from R1, and it can clobber R2-R5. An
+ * extension gets the arguments of the function that it replaces.
+ */
+static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
+{
+	const struct bpf_subprog_info *sub = &env->subprog_info[0];
+	int i, cnt = min_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
+
+	if (!cnt || sub->args[0].arg_type != ARG_PTR_TO_CTX)
+		return false;
+
+	for (i = 1; i < cnt; i++)
+		if (sub->args[i].arg_type != ARG_SCALAR)
+			return false;
+
+	return true;
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -909,6 +928,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
+		if (env->seen_direct_write &&
+		    env->prog->type == BPF_PROG_TYPE_EXT &&
+		    !ext_prog_takes_prologue(env)) {
+			verbose(env,
+				"Extension writing packet data must take ctx and scalars only\n");
+			return -EINVAL;
+		}
 		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
 					env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
-- 
2.55.0

