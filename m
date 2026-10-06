Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4912BCF46
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291483; cv=none; b=ShnFE5ePw+2+zu8m/PWC0koxKNs/VIXun0SiUZ+BwRRMD0JXz4wwnEa0ueVujewwocm2nccpGRUChQrcVneuei32iw7QmL+tP87Oy9xUMad8apB7yXn2bEp6pHDAkhH+cDAti4ej/hCjxVE5mwu0XMmCswHxZDX1n9jpdFn/n6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291483; c=relaxed/simple;
	bh=S1AWXPdMqP9fWMAPIjgH6HcU79AG0t2hd0D9Pa/LaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibk/LdQQk3lCBLkorynW8aqya2mJJ1EfdazLKEj5oixawUURt+/dbapMs34OxDH2cXtnJMJ3ndd9q8x2yu8aGF+09ilo78XegVgoinO3JKl/7AYXpOi1Sp1YTFZ36UAfk5fCmOLXPKXEuPY7KreAI+K51MTw0zH5LawSm7gBDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=gEkB92Ir; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="gEkB92Ir"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2e8c710847so71411066b.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791291478; x=1791896278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6GyRcaTB2G6/+iSdmqu+Ru7NPglY3iZB2zj/8sP57oc=;
        b=gEkB92IrIq211U3Hk0ZhGzyxOK0qUK0xZTjHKG7QypkfVvN6SMz+1OLVkeip2GO2/C
         gYbBKhsWmVzWSQ7M8e/G5OyiD9ViDboAn+QqdOoos0BhobA9T5JJy6l7GxfG8ECKNiMH
         IHtNQAZrPIwkmEdbnaZq24ITNIEy6oCLKZe79lfqkDbpp3mKnpWn7MeLoOvtkrGNjSkB
         Vv2m3HXRqy4m71UqvKzxRlCzC+yHwVkcTCPidi31yjX8srzpAEktySJfh1UC8tPjIrDM
         J5jhU/SKdfmoVbVDKSeKwfMf1RQZgkNXMOMbK2roGyT64xTBAGOdcccLFq13aIxJhluN
         KTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291478; x=1791896278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6GyRcaTB2G6/+iSdmqu+Ru7NPglY3iZB2zj/8sP57oc=;
        b=olEz2XxIc2DvWlgOllxzEQWNqC5DffupYsTXpmN/ayTJ0JLPMOBDALda/qTmUhbjGB
         gGR3h7l8ofwPj2+8/G2LDDo2VOZS5QIkE3RXPTf9qHTlLcOiSNeELlN3KRz8o+52/ROd
         y8JkkqdVJOmpqxzoX+ohkARBunQM9VusT3bd+U8VSAbdYxnm31pF3uRoC0y/xrFityhi
         UKXH7NoZQ/+OPYqMT91kWjPLajOC11qCbHKTe+qqNqu2JCW7WA8V/qIwSSxep01eFalv
         1x4saqsgM2v41ZftloKXUXxJJSufF27+6u1dzXkh1+/rqwQiDv7lXMEqajHRlwDgLWD3
         ZNyw==
X-Gm-Message-State: AFq9FYI8/uSdOEVVF322IVAKjzyu5S+gVLBe/ihRhBgemw6JlRkOnNoJ
	Pv70A52cKwcwKE3Jg6S72M64s6PMl/3UcjhDld0AxcRCRk4SM3Xla2VC14lX0PhHPg==
X-Gm-Gg: AYBFou2lNHLOsQPJyC2YL7Ndz0EnTxaIYnEGX4pCiPkZD0v+cUCfBgRGCzdtbjvgjpO
	OfWxDJrju3UIF7Udp8D2ZrSX9O+AcmAmISFOXrWw1pcmwxeGKK28SHDX373dwLAtmSb0/Qs2uhi
	DnTdsxucvBcrrIer6d/Owga0E+xNc5tmVggyLau6jjlGTQg3XvVroXDA8e9HCBdMfnWvphT8NTC
	ooQAir0YB/AFZeZAv4SVPrvHHXr1raYZASBjw715XVqQ/GuRsPPMBttfoejsIFWzcFkDjkIN5Ha
	TuWqJhnJuopwBnxG3N1Q9Bh9KLx0Qiz4gFoJevuTdYbLTzs7pvxNWu7nD94K4PGQuU1AMqEe7pM
	0Ptd1bM1lu2x7DsA3cmikC5Vr7i0UX5YX/JbLbv76IfSIj1X8+YS7irDUFwq8JxuddD1BQUKAYf
	nDOnyDAdwTkGJOb0kmAxMqR7oo3ENgcetZiW3pHbfd9RosSkKViCuDNmjPcH702OyUjZH1h9O4A
	DuFTnXYqVVWWSf2oHVL7A==
X-Received: by 2002:a17:907:2da4:b0:c2e:2fb6:ff37 with SMTP id a640c23a62f3a-c3169fb09ffmr141582266b.21.1791291477565;
        Tue, 06 Oct 2026 05:57:57 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31562da31esm201740666b.38.2026.10.06.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:57:57 -0700 (PDT)
From: hengyul@cs.unc.edu
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring: do not charge the SQ/CQ rings to RLIMIT_MEMLOCK
Date: Tue,  6 Oct 2026 08:57:32 -0400
Message-ID: <20261006125732.3425762-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

Commit 8078486e1d53 ("io_uring: use region api for SQ") and commit
81a4058e0cd0 ("io_uring: use region api for CQ") made io_uring_setup()
allocate the rings with io_create_region().

However, io_create_region() charges the memory to RLIMIT_MEMLOCK, and
the rings had been exempt from that limit since commit 26bfa89e25f4
("io_uring: place ring SQ/CQ arrays under memcg memory limits"). As of
now, a user without CAP_IPC_LOCK gets ENOMEM from io_uring_setup() when
their rings exceed the limit, which is 8 MiB by default. PostgreSQL
developers have already hit this in their io_uring tests [1].

The issue can be reproduced with a simple liburing program, run as an
unprivileged user:

    #include <liburing.h>
    #include <stdio.h>

    int main(void)
    {
            static struct io_uring ring[64];
            int i;

            for (i = 0; i < 64; i++)
                    if (io_uring_queue_init(4096, &ring[i], 0) < 0)
                            break;
            printf("%d rings\n", i);
            return 0;
    }

Before those commits (v6.13), it prints "64 rings". After those commits
(v6.14), it prints "21 rings".

This patch makes io_create_region() take the user to charge, and passes
no user for the SQ/CQ rings.

Link: https://www.postgresql.org/message-id/flat/667f7dcf-404b-4898-a426-57ca6e0617f6@gmail.com [1]
Fixes: 8078486e1d53 ("io_uring: use region api for SQ")
Fixes: 81a4058e0cd0 ("io_uring: use region api for CQ")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 io_uring/io_uring.c | 10 ++++++----
 io_uring/kbuf.c     |  2 +-
 io_uring/memmap.c   | 10 +++++-----
 io_uring/memmap.h   |  2 +-
 io_uring/register.c | 12 +++++++-----
 io_uring/zcrx.c     |  2 +-
 6 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 61053421d809..26890f4de206 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2068,8 +2068,9 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
 
 static void io_rings_free(struct io_ring_ctx *ctx)
 {
-	io_free_region(ctx->user, &ctx->sq_region);
-	io_free_region(ctx->user, &ctx->ring_region);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	io_free_region(NULL, &ctx->sq_region);
+	io_free_region(NULL, &ctx->ring_region);
 	ctx->rings = NULL;
 	RCU_INIT_POINTER(ctx->rings_rcu, NULL);
 	ctx->sq_sqes = NULL;
@@ -2733,7 +2734,8 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 		rd.user_addr = p->cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	ret = io_create_region(NULL, &ctx->ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret)
 		return ret;
 	ctx->rings = rings = io_region_get_ptr(&ctx->ring_region);
@@ -2747,7 +2749,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
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
index 48c0eb012412..d4d716946971 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -204,7 +204,7 @@ static int io_region_allocate_pages(struct io_mapped_region *mr,
 	return 0;
 }
 
-int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
+int io_create_region(struct user_struct *user, struct io_mapped_region *mr,
 		     struct io_uring_region_desc *reg,
 		     unsigned long mmap_offset)
 {
@@ -230,8 +230,8 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 		return -EOVERFLOW;
 
 	nr_pages = reg->size >> PAGE_SHIFT;
-	if (ctx->user) {
-		ret = __io_account_mem(ctx->user, nr_pages);
+	if (user) {
+		ret = __io_account_mem(user, nr_pages);
 		if (ret)
 			return ret;
 	}
@@ -240,7 +240,7 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 	if (reg->flags & IORING_MEM_REGION_TYPE_USER)
 		ret = io_region_pin_pages(mr, reg);
 	else
-		ret = io_region_allocate_pages(mr, reg, mmap_offset, ctx->user);
+		ret = io_region_allocate_pages(mr, reg, mmap_offset, user);
 	if (ret)
 		goto out_free;
 
@@ -249,7 +249,7 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
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
index 02bc103bcc9d..d11a53d68431 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -480,8 +480,9 @@ struct io_ring_ctx_rings {
 static void io_register_free_rings(struct io_ring_ctx *ctx,
 				   struct io_ring_ctx_rings *r)
 {
-	io_free_region(ctx->user, &r->sq_region);
-	io_free_region(ctx->user, &r->ring_region);
+	/* ring memory is not charged to RLIMIT_MEMLOCK, hence no user */
+	io_free_region(NULL, &r->sq_region);
+	io_free_region(NULL, &r->ring_region);
 }
 
 #define swap_old(ctx, o, n, field)		\
@@ -529,7 +530,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = p->cq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &n.ring_region, &rd, IORING_OFF_CQ_RING);
+	ret = io_create_region(NULL, &n.ring_region, &rd, IORING_OFF_CQ_RING);
 	if (ret)
 		return ret;
 
@@ -559,7 +560,7 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 		rd.user_addr = p->sq_off.user_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
-	ret = io_create_region(ctx, &n.sq_region, &rd, IORING_OFF_SQES);
+	ret = io_create_region(NULL, &n.sq_region, &rd, IORING_OFF_SQES);
 	if (ret) {
 		io_register_free_rings(ctx, &n);
 		return ret;
@@ -730,7 +731,8 @@ static int io_register_mem_region(struct io_ring_ctx *ctx, void __user *uarg)
 	    !(ctx->flags & IORING_SETUP_R_DISABLED))
 		return -EINVAL;
 
-	ret = io_create_region(ctx, &region, &rd, IORING_MAP_OFF_PARAM_REGION);
+	ret = io_create_region(ctx->user, &region, &rd,
+			       IORING_MAP_OFF_PARAM_REGION);
 	if (ret)
 		return ret;
 	if (copy_to_user(rd_uptr, &rd, sizeof(rd))) {
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 86d580d4410d..62cabfdf0206 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -431,7 +431,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
 	mmap_offset += (u64)id << IORING_OFF_ZCRX_SHIFT;
 
-	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
+	ret = io_create_region(ctx->user, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

