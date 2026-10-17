Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E303ADBA4
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255192; cv=none; b=UlDvk2WGMNVm9LYSWr+8bmcYrqmi13D/TDk5hG6fXp4mRrNuy8FaRM90limB4m0aPqTjMwKuvpK/4bhJTh1st8YXfwICUrBlFtGKGIWZ/XDalwuVq6tlHTmAEraTIHqZiHyqbFnZl1/Kx4AZGXmL8ptOSNCVZIRW8Ks2tYdqWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255192; c=relaxed/simple;
	bh=Ut+NdclNGKz5bIYdrV1R2RnVE2fF5BOTrGLUGrVbPAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvUrixptfapvpy8Ohx/MSSEprzshAXO/wuW6qyVBUE/7YJfA3Mq7YN1CKU2U68Tm8ES/EY6xY4gxi8kwIN3yHMCJcNiJLeynMII7n/S1uNGNlXCg/5CMiDV4gnF6Z4SploNkqTLx42DWVzNOwVJcYC2jKRBfZLN10AknEM66cmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf8W2zlT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf8W2zlT"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so325458a12.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255190; x=1792859990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ky0pnVFs2cki3JnG83UpHBKIb6uY7pCVzDIYJIyzmjE=;
        b=Yf8W2zlT8niiMhj4Ei6Ea2RVaKBMdm6RLAjLhA/2t+ptd0tDkAA0KkPpjx6IZuaEbh
         q8pHdxXsW2YdYP6WQCi75yXbMxP7z4Zp94DqvjmWITPmCie4nURIkHCo7hLNJJ+PCHVd
         D/hefzcyVNizQ78LY4mcUY8fe+focZ3XQcuUX6KmKs2jXuebtX/kH3RwdZzJubPrn1eZ
         lqqUEGtrcwzq+ikUx1JJ/nttYk1BfwY+Ylq0RrTNXsJGlb8fVc/9aESwYAxAxWjNMNrM
         nyAgy0uMe5dDM4AUU1TG2bY/hF+pnpc37HzMffOQx0UF5Fcosi1KDJWVGsX+R/+K88sO
         82dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255190; x=1792859990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ky0pnVFs2cki3JnG83UpHBKIb6uY7pCVzDIYJIyzmjE=;
        b=HvTqjaAIgEDc9gDZXpHDJ2awbQU3I3m1c0UY2M8ojccFbdaeveV7MrO9EZsFm44VW9
         13+4HU6bDJw8H8k0G0Ggn4yWm11StoVlocFgQbDnYozGfZQtEZ6EbBVtnK3ws/NKfLHo
         AResRwoWnsZr0nCpmMkk4tkQvBqUNJ1Us/sG7PeyS8WsnPqoevqQk/Z2szddFyaNIr1U
         75NllANi+czA8P1MbVguNFLNmdVXvEVsttc0T9H78q2JK21RVghosKHCVj/NdYUgB5/r
         /I2fs2MLeWHXTbGQS5ZNl9FGlXG4bQ0D07meHpQstBv2qSG0HG7D+iaiZMgJtabBxFw8
         vKMg==
X-Forwarded-Encrypted: i=1; AKwUvBxnOEfOgX8LyhHtKU7HQ5JxIGGMCAwL072ty5tqLrJ6DX5an6I3jVz4JhPsSJXj9ZEZipEeiIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOntwYP7AlybK3vW0cWPB3EYa0PRqVJ+f98b7Lu5aCb9BbhmjP
	kG19MgTG9qDPaZecN5jmHgqR34m+IhFxLzIl6YT7Nnu92XD+PKk3vNdR
X-Gm-Gg: AYBFou24sf0SPIygRGgJQWbJa5rYqZ03FB2HyCqTRSNt/C3XsX68YZ1D/anj3LGgCTh
	tCoy4/h49QGuzcy5SFnCkeMSEX+LGbAbfPiJaf+1M9YHV7zAWhrTA0DrCohxGMax/qWbJp82lQQ
	DLYp9YZD5uKI9CdA+svQ+q2eHQRkauxdDkMHt7SxzI8qQS47CKe5I1boB6OPuw+I5kRWbteXlvO
	t4H3iulMbFFAsjO+HVOlORObbp3wL00jfsUAdzWeUX58iHhhadcfKgGf4pkUtZhlUyYfdSUGAFD
	Kj25yeQ+nLOZ0YWrdux3y9uzRULXfE6P4jtUYgo/ljTFOsGVxJSYvo9BfsUt6yA7JMexQUoQ9ve
	Bd31gaiXxYbfSlfhiMEC+T8MgAWbo27IKX0DfA0oGFxWHAOgC3ZLny1m75ENxrzQTBHUdovRkZa
	35KRQJkGD/IE5otJCjJ54HdVnhZPNFw4ztdM4w4nwqZ8wQLzC+Iu1d0n1S3wRZBebFiFnA/g4J8
	0diQ1rUmBfKzaZU9uw+D3ob+ivG3gQ/oJ/Pnz2Ti8cL4q23j8YX68gdqEOu2KuNNRs/EOb72gHO
	PlfIdd+WtTcf0wWynUylJA2S5HbgBlJ1F8eDNovplmML
X-Received: by 2002:a17:90b:3851:b0:3ac:9e76:aa93 with SMTP id 98e67ed59e1d1-3acee2939b1mr2314386a91.7.1792255190138;
        Sat, 17 Oct 2026 09:39:50 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm13322867a91.11.2026.10.17.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 20/43] bpf: Fix stale offload->prog pointer after realloc
Date: Sat, 17 Oct 2026 16:37:22 +0000
Message-ID: <20261017163745.3341787-21-alexei.starovoitov@gmail.com>
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

bpf_prog_realloc() moves a program that the rewrites of the verifier make
outgrow its pages.  It updates aux->prog, but not the offload->prog of a
device-bound program.  When the device is unregistered,
__bpf_offload_dev_netdev_unregister() hands the stale pointer to
__bpf_prog_offload_destroy(), which faults on the freed program:

  BUG: unable to handle page fault for address: ffffc90000071050
  RIP: 0010:__bpf_prog_offload_destroy+0x3f/0x310

It takes the right to load a device-bound XDP program, CAP_BPF and
CAP_NET_ADMIN or a BPF token, and a device that can be removed.

Commit a1aa9ef47c29 ("bpf: Fix stale offload->prog pointer after constant
blinding") repaired the other place that replaces a program.  Do the same
here.

Nothing keeps the device while a program is loaded, so it can also be
unregistered at that very moment.  That frees the offload, and it may have
read offload->prog already when the old copy of the program is freed.  In
both places update the pointer under bpf_devs_lock, before the old copy
goes.

Fixes: ab3f0063c48c ("bpf: offload: add infrastructure for loading programs for a specific netdev")
Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Fixes: a1aa9ef47c29 ("bpf: Fix stale offload->prog pointer after constant blinding")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  |  5 +++++
 kernel/bpf/core.c    |  4 ++--
 kernel/bpf/offload.c | 16 ++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3fb3c7d22d99..0de5947dceaa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3792,6 +3792,7 @@ int bpf_dev_bound_kfunc_check(struct bpf_verifier_log *log,
 void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id);
 int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr);
 int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog, struct bpf_prog *old_prog);
+void bpf_prog_dev_bound_moved(struct bpf_prog *prog);
 void bpf_dev_bound_netdev_unregister(struct net_device *dev);
 
 static inline bool bpf_prog_is_dev_bound(const struct bpf_prog_aux *aux)
@@ -3853,6 +3854,10 @@ static inline int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog,
 	return -EOPNOTSUPP;
 }
 
+static inline void bpf_prog_dev_bound_moved(struct bpf_prog *prog)
+{
+}
+
 static inline void bpf_dev_bound_netdev_unregister(struct net_device *dev)
 {
 }
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 642f0ab8eb2d..69285abcf594 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -269,6 +269,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 		memcpy(fp, fp_old, fp_old->pages * PAGE_SIZE);
 		fp->pages = pages;
 		fp->aux->prog = fp;
+		bpf_prog_dev_bound_moved(fp);
 
 		/* We keep fp->aux from fp_old around in the new
 		 * reallocated structure.
@@ -1558,8 +1559,7 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
 	 * know whether fp here is the clone or the original.
 	 */
 	fp->aux->prog = fp;
-	if (fp->aux->offload)
-		fp->aux->offload->prog = fp;
+	bpf_prog_dev_bound_moved(fp);
 	bpf_prog_clone_free(fp_other);
 }
 
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index d855399812ee..5a10f40a7831 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -96,6 +96,22 @@ static int __bpf_offload_dev_netdev_register(struct bpf_offload_dev *offdev,
 	return err;
 }
 
+/*
+ * @prog takes the place of a copy that the caller is about to free. Nothing
+ * keeps the netdev while a program is loaded: once the lock is dropped, no
+ * unregistration is left that has got the old copy from offload->prog.
+ */
+void bpf_prog_dev_bound_moved(struct bpf_prog *prog)
+{
+	if (!bpf_prog_is_dev_bound(prog->aux))
+		return;
+
+	down_read(&bpf_devs_lock);
+	if (prog->aux->offload)
+		prog->aux->offload->prog = prog;
+	up_read(&bpf_devs_lock);
+}
+
 static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
 {
 	struct bpf_prog_offload *offload = prog->aux->offload;
-- 
2.55.0

