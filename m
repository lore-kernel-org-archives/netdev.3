Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63B4ED188
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675559; cv=none; b=J8BVBZa7WlygAePGDDbfyP4RXoHuogMwRz+P0SyfbD81yQvo3S+zVI5hIQt+LHfFxGg7cJ7AoDM+7JDKUu6DBe8k503d5f2XoQx+opDFzQhnBnjyEp06RdDE8i2sBb91hEt6j1A5ILMQFQOFCBLjlIa76keFp+mdcDfs3Kgomb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675559; c=relaxed/simple;
	bh=aeKRILbP5X4aweEX5ge1txahPtTcZkjKLoTF/0jhg7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEVzxcvVZGuZXolfT36yoR97/7g71OGB+neW1Wux0vW2vo93HF0EIwdxtj6cG0bXEvdRwpI1HvgzrYMm+ZVNrt0RMmS9c/1k4xJHEyI3fPfHrptzqPe/Hkm3ZDd123rqL8Z0o3Wu5M++LHWYeVNt4XRqMcnKNodE38e/iUSUc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esicJhN1; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esicJhN1"
Received: by mail-oi2-f13.google.com with SMTP id 46e09a7af769-804f7045f3eso512960a34.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675555; x=1790280355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxz9DnrMz0dzYUlJHI01PCp5M3Gsxuw+kPCL3fHdkcc=;
        b=esicJhN1nGvJjbPQTNGMeRilKUWUsBl7tHgLvzy2jJA32aqOUADvB+6Vxwdoh7sDLI
         sMqSG4k0gYpdk7mQ/cA1QtRKJ66ceaYWeOKTnvlQGLkyjHUSm6f4MtukXF3JoPuQ1+SV
         P3sNvXlhDY2Pf4lvxhl+AeYNBf9S7FqUmH+vCDE9KT82ZOmLpPEls05NnT9/4Cv3aiMi
         27YDjISNgT5xi77I+pwr1kTQFOhxkvCpM0fGSSFh7dIO5AQdvYMLfpj6lrz/yKvTba8B
         7tkYwjGAior217/rYTWLPygGnXBvYlzlPD11R6PLo2JUJziHKdnhZpatHjpo4NJIOix9
         FdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675555; x=1790280355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wxz9DnrMz0dzYUlJHI01PCp5M3Gsxuw+kPCL3fHdkcc=;
        b=1D6IO2p1etwobEBBSpzbUU+UFtWxC4YLjoAREZyqIemRUbROI2OSarXDZMA57b/dBU
         ufODowHeD9Ktyf0T6nEpC8NbAvN4ljR47nAibrlZSyWbKOKVv1edNCFuOnKdDLfkBnNq
         deVzqybAuAyi0VXbl5fmN3b1HH2M1CtLq44kPwuaM+i32bIwApI6+oPqJ6r4AE/ZFnAd
         phlOFVP4mHTtZjLU2n7Yf7OE9jFh4NqMCfCjXj9SqXXcJy3oTpidavhtO13WwtFnpPoa
         jYwL4/YlVrH4JK9cYJLeHj1WLJhdQWdQXwsm9ByzbzAR1uA6Fxwinw93Wp0gA8Z2YvxH
         vFdg==
X-Gm-Message-State: AFuF++mbLGZf1Z/TDYV+7t07CetRayEc9+cxsJR8RVcvbv05yCOZxH9N
	iZFjafOY0ai2b+tPWPEtTiowEHcNfU0rDkl1BwBtBdYCJMLumARW4RSQ
X-Gm-Gg: AYBFou0iRQFaQS0k+AePY4LMCZwUTJhwpez+mVMK3TcmQjAZ4Fb6jonT62HJ7w6T8Ap
	WWpMIHvkeji9N/izaENRdRgMCRLYRdPfh0Pzv5HKNQLu3reg5mNDsj39Nn57T40ihXaa9b9GsBL
	8mJHvsYhgdO/rc9QCybdXG+oF3sz2bbRNPPNjT9Z0iIFaLp24kpZFP7uTvbuZPBIBGwlxu1MO4T
	5wQTMUb1zRgFpTV1eOt2ztpBBkVqa2dxDT1agx84KLrd+exzOKWQxPbajeZn2OxzR4bW69zX5xe
	24iQ77md6ntozMxS0pJVVnm9NfusGdisaPBKKg2Vo/3MJU4bbielO3ZDnnQ4njymKvgRjSn/Csr
	uviYehjq3/hRPX7tq2fzsP+ggSHeHobihASQ8FsrlW4u5uiWjpG5CP9h1eUjldxGRQkXDvRwrWl
	5N23EYLKME834vwxuCpuqVx3fV19ZMctE3x7eBVyVYxEY4QP2ORLqHFhvKRIvGdQ==
X-Received: by 2002:a05:6830:4407:b0:7fa:ab72:9dfd with SMTP id 46e09a7af769-80de38ecb66mr232904a34.21.1789675555065;
        Thu, 17 Sep 2026 13:05:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c46dbacc7sm3822607a34.17.2026.09.17.13.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:54 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 05/15] bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
Date: Thu, 17 Sep 2026 13:05:31 -0700
Message-ID: <20260917200542.3689605-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

prog_list_length() and compute_effective_progs() use !prog_list_prog(pl)
to skip a 'detaching' pl.

When pl->link is not NULL, prog_list_prog(pl) returns
the pl->link->link.prog. This does not work for the upcoming struct_ops
patch where pl->link is not NULL but pl->link->link.prog is NULL,
because a struct_ops map is attached to the cgroup instead of a BPF prog.

To prepare for the upcoming struct_ops patch, this patch
replaces the prog_list_prog() test with the
"!pl->prog && !pl->link". In __cgroup_bpf_detach(),
both pl->prog and pl->link are set to NULL, so testing
"!pl->prog && !pl->link" is the same test to tell
if a pl is being detached. This change should be a no-op.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 2fee0cbe5dfd..6d865e765d58 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -408,7 +408,7 @@ static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
 	u32 cnt = 0;
 
 	hlist_for_each_entry(pl, head, node) {
-		if (!prog_list_prog(pl))
+		if (!pl->prog && !pl->link)
 			continue;
 		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
 			(*preorder_cnt)++;
@@ -482,7 +482,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
+			if (!pl->prog && !pl->link)
 				continue;
 
 			if (pl->flags & BPF_F_PREORDER) {
-- 
2.52.0

