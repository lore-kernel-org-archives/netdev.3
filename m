Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F673AD518
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479258; cv=none; b=IiaJuDF2F8BklLXYKAncajdiqDSB6jArCtucxLfo3LA56K3O9mYtJF6cX1baYv/sZnCP8tt/qjLWoHXYXyZCfKpzNNdTJ3ATpP9fPqAddQK4R6KqpOpeNmTXnuCmpwxzsUxKSs8zSTQu8ukSyfZrmx0m38g0PiH+RRfoYdSlwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479258; c=relaxed/simple;
	bh=33Dvrf0ZV/aeuPuGesAW054aTSxFK3HRoP4sd6PhIN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDklPWc1gLrZyrN0OPfD+5KPHMebPG1qDL8OohZze0gNtxRXmmaH2hbjR/vrDg5Yh16poqFNtoDbtRWBDrTawONg59DpmGew9px79apSot9bzDgTBPM8wG/B/eSk7CUq6hCj8j6GClBjHw84dEixZB4jZIZ2BpRG+3q1XF7h0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=cEJKLbhP; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="cEJKLbhP"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9178510f3bdso39965616d6.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791479253; x=1792084053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5WQDUZlUdSGdBUBDUPyXWWv5kxzk6a1Q3FrCFwJ0JQ=;
        b=cEJKLbhPGMEc7J44uDLc0uqN8gtz+OafpVIyEfDM+sn8cAjFBhLiPHe7SPpXz6VFB3
         N4Z6x89hYi1zoH+bb2okzDjXYB5Asv2qvo6AMySAAzGzBmt18KpdZCOBpq3F1BKBsSVL
         PmFCddyIO1r9g9wgOYlKa5Lg5GSAJO7daxSnKYJ6rvvD+3twZPlRPyoLhdQZltSpAgH2
         oKlYvZAT52HHEuM9Z9EOg3rsVBjOOq704sEPtDwoGJ2PblCPTLyjP2c5+lgoZyS1Bgay
         IhkvNTCXf2ltUD5vo226fvbvB1lSq/l7w7Tlbf5OyhU+jXaPm7ROPv2OkHkzrlR7V9+q
         6pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479253; x=1792084053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f5WQDUZlUdSGdBUBDUPyXWWv5kxzk6a1Q3FrCFwJ0JQ=;
        b=ry2tfFVdZkHi0KkszcVmGiB/TGI0OtAzfpgebrWVjTe81XIu+8UytvEjov2+LqO7tU
         TdATs2NHfQdR/zaEV0qPSlNeRQzKVdZCCwAoIrj+Ix2wjUsaF7eMP0j2he4w7tAc1HHS
         aiGAd6cv+LWebNTB+cLL9k+5tkdUTY+dE/hCm9ctzG9n+ZMQvSwZU/hw3hyT3vVXtzWF
         yYOa59HATrP8mSWjU35fTBLHFKUBoFtRPZ2AJfAAH27Eky+m+wpiYPvUa+G4g5vbKIeS
         n+yk76JNhq7QFjPliVnN95Yf7PfBvnLH50udKYi5aDBK2NzsT27HdcOXv4iKCCjkfWXl
         S26g==
X-Forwarded-Encrypted: i=1; AKwUvBx0UWeXQIRaXP+OK2X8+WqWp0xD5rAcJPqjRe13Ybe4cQOnPfkcsL53BCaIf6iHlwgiOKpC8Eo=@vger.kernel.org
X-Gm-Message-State: AFuF++kZSnf/x0yQQnbiblSRI3y+I8U0tFp0grlLRUf9xAaXSr/VHdB8
	MzhkzDaeQle6DMgl3zCFym82aj2wuthcBi9MeefaWj2ewwUEaeqVRzpeVJNcBSHBeQ==
X-Gm-Gg: AYBFou1yV33SnkmffzSaSAMILE7QPRw2fUwCgi/t2sdAdwo8Yg45Fnce14dDeq1bEyA
	8vMKuKckJjZcwCIKziDNwaZzntuXdvydFwhIOA1FnKx6oIxOtbHjsFaBziCtfXicvAOmv9aX5pV
	+RcGKiwXlNuX8mrfIdkkZ2vjaQsT8eD/8DHJqRLJmz6XouzLAtTLL1kz04ovw3WW9Zj43QteBmz
	nwe1eTklibKCL4CUmFr6GlOUyb4KLilyUWKhwEf/BmDp5qPlE1p/OWxvcmvHTfEaKwmwwutnJvY
	pcCVuHuYI1mX+2v5KVoNZcPi21DMvcN302/g00zRwD1ppdtW6bZpnS56/OXAAK5HdAQ3S8dGgk9
	Vq6rmJLGtWsnedCfqA2bbwM2EkJCKaLKvC0Gdv3taX46RBM6CtqcwItm+/yugu3GvUo+R+FQbcU
	BId5P+aOhrDpoMNOeKn5gfiS3lWreghEtK4W0HNLqLphkjClHXHajimC4FsJBDspHRLidKUeIt2
	R2uUVYDoMz6U556Hy164ZheYyWgjhqi
X-Received: by 2002:a05:6214:20ea:b0:912:517b:40f4 with SMTP id 6a1803df08f44-91997853ae4mr117201566d6.38.1791479253136;
        Thu, 08 Oct 2026 10:07:33 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b51b54ddesm1067326d6.9.2026.10.08.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:07:32 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] io_uring: do not charge user provided SQ/CQ rings to RLIMIT_MEMLOCK
Date: Thu,  8 Oct 2026 13:06:11 -0400
Message-ID: <20261008170611.1285778-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b5a33433-b0b9-4231-9998-23e2a2202091@kernel.dk>
References: <b5a33433-b0b9-4231-9998-23e2a2202091@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8078486e1d53 ("io_uring: use region api for SQ") and commit
81a4058e0cd0 ("io_uring: use region api for CQ") made io_uring_setup()
create the rings with io_create_region().

However, io_create_region() charges user provided memory to
RLIMIT_MEMLOCK, and the rings of an IORING_SETUP_NO_MMAP ring were not
charged before those commits. As of now, a user without CAP_IPC_LOCK
gets ENOMEM from io_uring_queue_init_mem() when their rings exceed the
limit, which is 8 MiB by default. PostgreSQL 18 creates its rings with
this function [1].

The issue can be reproduced with a simple liburing program, run as an
unprivileged user:

    #include <liburing.h>
    #include <stdio.h>
    #include <sys/mman.h>

    int main(void)
    {
            static struct io_uring ring[64];
            char *mem = mmap(NULL, 64 << 20, PROT_READ | PROT_WRITE,
                             MAP_SHARED | MAP_ANONYMOUS, -1, 0);
            int i;

            for (i = 0; i < 64; i++) {
                    struct io_uring_params p = { };

                    if (io_uring_queue_init_mem(4096, &ring[i], &p,
                                                mem + (i << 20),
                                                1 << 20) < 0)
                            break;
            }
            printf("%d rings\n", i);
            return 0;
    }

Before those commits (v6.13), it prints "64 rings". After those commits
(v6.14), it prints "21 rings".

This patch makes io_create_region() take the user to charge, like
io_free_region() does, and passes no user for the SQ/CQ rings.

Link: https://github.com/postgres/postgres/blob/REL_18_STABLE/src/backend/storage/aio/method_io_uring.c [1]
Fixes: 8078486e1d53 ("io_uring: use region api for SQ")
Fixes: 81a4058e0cd0 ("io_uring: use region api for CQ")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
This goes on top of io_uring-7.3 (c746673517c6), as discussed in [2].

Tested on that branch as a user without CAP_IPC_LOCK and the default
8 MiB limit:

                                                  before  after
  program above                                       21     64
  the same with io_uring_queue_init()                 64     64
  30 processes x 142 NO_MMAP rings of 64 entries       7     30

The last row is what 30 PostgreSQL 18 clusters with default settings
create. The number is how many of them got all their rings.

The per-user locked_vm count stays balanced over ring create, close and
resize. Provided buffer rings and IORING_REGISTER_MEM_REGION regions on
user memory are charged as before. Every liburing test gives the same
result with and without the patch.

Not changed here: provided buffer rings on user memory, which is what
io_uring_setup_buf_ring() registers, were not charged in v6.13 either
(64 of 64 rings of 32768 entries then, 16 now). I can send a patch for
those as well if you want them handled the same way.

[2] https://lore.kernel.org/io-uring/b5a33433-b0b9-4231-9998-23e2a2202091@kernel.dk/

 io_uring/io_uring.c |  8 ++++----
 io_uring/kbuf.c     |  2 +-
 io_uring/memmap.c   |  7 ++++---
 io_uring/memmap.h   |  2 +-
 io_uring/register.c | 10 +++++-----
 io_uring/zcrx.c     |  2 +-
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c2ce83c7c1f1..2a16369894d4 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2070,8 +2070,8 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 
 static void io_rings_free(struct io_ring_ctx *ctx)
 {
-	io_free_region(ctx->user, &ctx->sq_region);
-	io_free_region(ctx->user, &ctx->ring_region);
+	io_free_region(NULL, &ctx->sq_region);
+	io_free_region(NULL, &ctx->ring_region);
 	ctx->rings = NULL;
 	RCU_INIT_POINTER(ctx->rings_rcu, NULL);
 	ctx->sq_sqes = NULL;
@@ -2735,7 +2735,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
+	ret = io_create_region(NULL, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret)
 		return ret;
 	ctx->rings = rings = io_region_get_ptr(&ctx->ring_region);
@@ -2749,7 +2749,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->sq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->sq_region, &rd, IORING_OFF_SQES);
+	ret = io_create_region(NULL, &ctx->sq_region, &rd, IORING_OFF_SQES);
 	if (ret) {
 		io_rings_free(ctx);
 		return ret;
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 7c309173dd19..7c59ab9cfc8b 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -676,7 +676,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = reg.ring_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &bl->region, &rd, mmap_offset);
+	ret = io_create_region(ctx->user, &bl->region, &rd, mmap_offset);
 	if (ret)
 		goto fail;
 	br = io_region_get_ptr(&bl->region);
diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index da2328b52b38..51afe5d40b1d 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -192,7 +192,7 @@ static int io_region_allocate_pages(struct io_mapped_region *mr,
 	return 0;
 }
 
-int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
+int io_create_region(struct user_struct *user, struct io_mapped_region *mr,
 		     struct io_uring_region_desc *reg,
 		     unsigned long mmap_offset)
 {
@@ -223,9 +223,10 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 	/*
 	 * Only pinned user memory counts against RLIMIT_MEMLOCK, kernel
 	 * allocated regions are memcg accounted through GFP_KERNEL_ACCOUNT.
+	 * The SQ/CQ rings are never charged, their callers pass a NULL user.
 	 */
 	if (reg->flags & IORING_MEM_REGION_TYPE_USER)
-		ret = io_region_pin_pages(mr, reg, ctx->user);
+		ret = io_region_pin_pages(mr, reg, user);
 	else
 		ret = io_region_allocate_pages(mr, reg, mmap_offset);
 	if (ret)
@@ -236,7 +237,7 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		goto out_free;
 	return 0;
 out_free:
-	io_free_region(ctx->user, mr);
+	io_free_region(user, mr);
 	return ret;
 }
 
diff --git a/io_uring/memmap.h b/io_uring/memmap.h
index f4cfbb6b9a1f..0714bb5a9616 100644
--- a/io_uring/memmap.h
+++ b/io_uring/memmap.h
@@ -18,7 +18,7 @@ unsigned long io_uring_get_unmapped_area(struct file *file, unsigned long addr,
 int io_uring_mmap(struct file *file, struct vm_area_struct *vma);
 
 void io_free_region(struct user_struct *user, struct io_mapped_region *mr);
-int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
+int io_create_region(struct user_struct *user, struct io_mapped_region *mr,
 		     struct io_uring_region_desc *reg,
 		     unsigned long mmap_offset);
 
diff --git a/io_uring/register.c b/io_uring/register.c
index 02bc103bcc9d..d79971c57ace 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -480,8 +480,8 @@ struct io_ring_ctx_rings {
 static void io_register_free_rings(struct io_ring_ctx *ctx,
 				   struct io_ring_ctx_rings *r)
 {
-	io_free_region(ctx->user, &r->sq_region);
-	io_free_region(ctx->user, &r->ring_region);
+	io_free_region(NULL, &r->sq_region);
+	io_free_region(NULL, &r->ring_region);
 }
 
 #define swap_old(ctx, o, n, field)		\
@@ -529,7 +529,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = p->cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &n.ring_region, &rd, IORING_OFF_CQ_RING);
+	ret = io_create_region(NULL, &n.ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret)
 		return ret;
 
@@ -559,7 +559,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = p->sq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &n.sq_region, &rd, IORING_OFF_SQES);
+	ret = io_create_region(NULL, &n.sq_region, &rd, IORING_OFF_SQES);
 	if (ret) {
 		io_register_free_rings(ctx, &n);
 		return ret;
@@ -730,7 +730,7 @@ static int io_register_mem_region(struct io_ring_ctx *ctx, void __user *uarg)
 	    !(ctx->flags & IORING_SETUP_R_DISABLED))
 		return -EINVAL;
 
-	ret = io_create_region(ctx, &region, &rd, IORING_MAP_OFF_PARAM_REGION);
+	ret = io_create_region(ctx->user, &region, &rd, IORING_MAP_OFF_PARAM_REGION);
 	if (ret)
 		return ret;
 	if (copy_to_user(rd_uptr, &rd, sizeof(rd))) {
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index beb35077f3ce..939885985333 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -432,7 +432,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
 	mmap_offset += (u64)id << IORING_OFF_ZCRX_SHIFT;
 
-	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
+	ret = io_create_region(ctx->user, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
 		return ret;
 

base-commit: c746673517c6ce9f5400cc0ea23e10ef5382eddb
-- 
2.53.0

