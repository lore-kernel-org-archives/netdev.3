Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECD387347
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428903; cv=none; b=nrpl9V27WT+eITZQf+W0rBd87zn66+GhS/4+O3W1j4fHd7OR1TsINhC7qG59g4KS5sIOVc2Euhenlz/w/h3aA6wdacXfUDQ3MEaLkgqDBFL8kzzCnfDfFW6WAUgYhMFCXy5M1g85JCqIVRccbKSgxhEojk4RSQgkk1xBdn568gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428903; c=relaxed/simple;
	bh=94yg8Glm6wlqEV7/dURt9MeEZcqzC+ZT+f7IE2r22wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYzfW4ed5vZLe59s+ovNz1zX421L065C81SUkEZJuZwELq7jafnGBybKpAD7E+D0HmkJwKYq610GED/a4kCjyeP/pHMNaG32vtovFqatCnb2lz2NQFNkoSIRFV/KkFOWlbX+0Z4+MJGo70Xypabai3GJu+TZ3xk2YvhEbe4Dh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIGO7MHB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIGO7MHB"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e507b079dso78954b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785428901; x=1786033701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5G1izmpJSwaJTisXe0Txgx3GyutlrVgUX4te5pBONao=;
        b=IIGO7MHBofV6T5pbn8wEhgcHP/z4ZJp72eP3cT8rVG1TpdSpVdAbrx/v+/7wa3enXJ
         7U9xsuolQDuMtkVyzzOhdsvisZ7/Q1wKGiX2R/24Qyo1B16s++8Z2TBL5RShhU1SiHQd
         K2WrCXMd0awWqQnFq/5gKDuU3aDtOiI3exAHtjOg+OurdcAL5X1QKonleVf+4CkMs6q3
         UGL2ge39W1qvwMNpJ5uFb9uDoFF2C2Dr/tGBc+CpUm0gE59jWWY/jqB2bUigLTZ2qo65
         Fw9feXHnp7UJkvqoIDJ72fssQE6uTYiX3IvOhyP8zpwpQIThg4zvCc939jmPaMtPCIgh
         rRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428901; x=1786033701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5G1izmpJSwaJTisXe0Txgx3GyutlrVgUX4te5pBONao=;
        b=MN31vI1jhygvMsK1b9rw0P386Q6vZpqRUlSRQDIaDyNTWqvb1dJRVfTYzFIjUmppiq
         pR0OwJwU+VjUnjq9+1ERx8vNzH24s+9jsgqFtptsoQfOv+ATJu+vTEUgpKi3QpiI1EK8
         uVQ4SVtBlM9UA9u4LdMPKyTIzoJkOxfOXmZEfdXk1OzEl64zU4W6x67Qh1nzMVAk44dH
         z7gVgyW0CZDKLhjTy+oZO45w+rA3sTRK0B6mdI/w80YYv5dC26n4qqNcAUaSI0njLMM8
         awWdLQFdVWM2VA48P42Dajn7yGKyFnTtgwQTJrt5zX7IBv/wlH47dGJeesYSxUsh2ySN
         4UIg==
X-Forwarded-Encrypted: i=1; AHgh+RoBUoNk94hz7cIwm6B/QxylpogDX83AiDRvgS8C3/B1Y2/Y9A096ZnSb60QR+GvC7CXJj2ypO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXt/J8CzyA0pz4uqEKwevR28DprDe9ieOV943ouqmN4sMdE3WQ
	8ptw5YmphHO2kj7K2UfSOOg/v4ckyxcNaW+f4SapYiNWFWOO6IYg6Zy4GXt8CLiu
X-Gm-Gg: AR+sD101GZtzANPJMQwl4a1R8YmD6cagbjcMIuJnR5l/ccB/O9yMiNaS2JgkRI01ghS
	TmgCA0lvFcSu9eWqtXHYGfaxnl6oB6eOw3QR9SdaZEaa6xOHZ2CfLm+iM/Nh/jwlwTfkTeCaBgy
	Q8+uPF6YqjSIJ7i2vH3icet4a5ShEGbl2yNM3mqjouqHHiEkLy/OMuWK/j8g8Nyw8nxcyOz1uZt
	4ZyF2h/HeOmGTFEPsbt4aykVEhI/bG66iI40GRCKQJ7AMsFpxr7QSExmf7D5Na8+2pjMcj3tS3C
	e9r4hvfW4HRUVpb76oj7AV5VvGjMKfohX7SzKgzWVLOfhcRINkadCIAUMK7AWjuzcU3ETCSQCNu
	ykoRX90snwl4DjH45j5zcd0xhE4R3g0DxIjplKm/j64hC1AxBNtk6ACDU1ihvi784DJkYeXj8Ll
	gp9gPYUD4gANqry9b0pfaO+icTbj3kyG1VNA3xLt+roED5hVpo1quNSgLcv1wfnEEJgZfrDqaq1
	qC+Uca6/O3Gj+h2H+U=
X-Received: by 2002:a05:6a00:2341:b0:848:48e7:437b with SMTP id d2e1a72fcca58-84ebc46625dmr3159559b3a.69.1785428900932;
        Thu, 30 Jul 2026 09:28:20 -0700 (PDT)
Received: from LAPTOP-6GJJDDA7.tail156a05.ts.net ([49.228.123.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02f9740sm3322851b3a.37.2026.07.30.09.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:28:20 -0700 (PDT)
From: Woraphat Khiaodaeng <worapat.kd2@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: David Wei <dw@davidwei.uk>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Woraphat Khiaodaeng <worapat.kd2@gmail.com>
Subject: [PATCH] io_uring/zcrx: don't clear master_ctx from the import path
Date: Thu, 30 Jul 2026 16:27:41 +0000
Message-ID: <20260730162741.1125-1-worapat.kd2@gmail.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

import_zcrx() attaches an existing ifq to another ring.  It never calls
zcrx_set_ring_ctx() and so never takes the ->master_ctx reference, but
its error path still passes @ctx to zcrx_unregister(), which clears
->master_ctx and drops its percpu_ref whenever ifq->master_ctx == ctx.

That condition is reachable.  A ring that registers an ifq with a
non-zero event type_mask gets ->master_ctx pointed at itself, and
nothing stops it from exporting that ifq with ZCRX_CTRL_EXPORT and
importing the resulting fd back into the same ring.  Failing the import
after the refcount bumps -- an argument page mapped PROT_READ makes the
copy_to_user() in import_zcrx() return -EFAULT -- then clears the
->master_ctx owned by the original registration, which is still live.

Refcounts stay balanced and nothing is freed early, so there is no
splat.  The ring silently stops receiving ZCRX_EVENT_ALLOC_FAIL and
ZCRX_EVENT_COPY: zcrx_send_notif() returns early on a NULL
->master_ctx, and ->master_ctx is only ever set on a freshly allocated
ifq, so it cannot be restored without tearing the ring down.

Pass NULL instead, matching zcrx_box_release() and the zcrx_export()
error path.  io_register_zcrx() only gets away with passing @ctx
because zcrx_set_ring_ctx() runs after its last goto err.

Fixes: 00d91481279f ("io_uring/zcrx: share an ifq between rings")
Signed-off-by: Woraphat Khiaodaeng <worapat.kd2@gmail.com>
---

Found by code inspection, then confirmed on v7.2-rc5 in a QEMU guest by
adding a pr_info() to zcrx_set_ring_ctx() and zcrx_unregister_user().
Writing A for the ring's io_ring_ctx:

Before, the failed self-import clears the binding:

  set_ring_ctx:    ctx=A           -> master_ctx = A
  unregister_user: ctx=A master=A  -> CLEARING   (failed self-import)
  unregister_user: ctx=A master=0                (ring teardown, nothing left)

After, it survives and is released where it should be:

  set_ring_ctx:    ctx=A           -> master_ctx = A
  unregister_user: ctx=0 master=A                (failed self-import)
  unregister_user: ctx=A master=A  -> CLEARING   (ring teardown)

io_uring_register() returns -EFAULT either way.

The reproducer below needs no hardware: ZCRX_REG_NODEV leaves ifq->dev
NULL, so no net device and no DMA mapping are involved.  Plain syscalls,
no liburing.  Run as root (CAP_NET_ADMIN).

Reproducer:

#define _GNU_SOURCE
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <linux/io_uring.h>
#include <linux/io_uring/zcrx.h>

#define AREA_PAGES 64
#define RING_BYTES (1024 * 1024)

int main(void)
{
	struct io_uring_zcrx_ifq_reg reg, *ireg;
	struct io_uring_zcrx_area_reg area_reg;
	struct io_uring_region_desc region_reg;
	struct zcrx_event_desc ev;
	struct io_uring_params p;
	struct zcrx_ctrl ctrl;
	void *area, *ring, *ro;
	long ps = sysconf(_SC_PAGESIZE);
	int ringfd, boxfd, ret;

	memset(&p, 0, sizeof(p));
	p.flags = IORING_SETUP_DEFER_TASKRUN | IORING_SETUP_SINGLE_ISSUER |
		  IORING_SETUP_CQE32;
	ringfd = syscall(__NR_io_uring_setup, 8, &p);
	if (ringfd < 0)
		return perror("io_uring_setup"), 1;

	area = mmap(NULL, AREA_PAGES * ps, PROT_READ | PROT_WRITE,
		    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
	ring = mmap(NULL, RING_BYTES, PROT_READ | PROT_WRITE,
		    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

	/* non-zero type_mask is what makes zcrx_set_ring_ctx() run */
	memset(&ev, 0, sizeof(ev));
	ev.user_data = 0x5a5a5a5a;
	ev.type_mask = 1U << ZCRX_EVENT_COPY;

	memset(&region_reg, 0, sizeof(region_reg));
	region_reg.size = RING_BYTES;
	region_reg.user_addr = (unsigned long)ring;
	region_reg.flags = IORING_MEM_REGION_TYPE_USER;

	memset(&area_reg, 0, sizeof(area_reg));
	area_reg.addr = (unsigned long)area;
	area_reg.len = AREA_PAGES * ps;

	memset(&reg, 0, sizeof(reg));
	reg.rq_entries = 64;
	reg.flags = ZCRX_REG_NODEV;
	reg.area_ptr = (unsigned long)&area_reg;
	reg.region_ptr = (unsigned long)&region_reg;
	reg.event_desc = (unsigned long)&ev;
	ret = syscall(__NR_io_uring_register, ringfd,
		      IORING_REGISTER_ZCRX_IFQ, &reg, 1);
	if (ret)
		return perror("register ifq"), 1;

	memset(&ctrl, 0, sizeof(ctrl));
	ctrl.zcrx_id = reg.zcrx_id;
	ctrl.op = ZCRX_CTRL_EXPORT;
	ret = syscall(__NR_io_uring_register, ringfd,
		      IORING_REGISTER_ZCRX_CTRL, &ctrl, 0);
	if (ret)
		return perror("zcrx export"), 1;
	boxfd = ctrl.zc_export.zcrx_fd;

	/* import back into the same ring, with an unwritable argument page */
	ro = mmap(NULL, ps, PROT_READ | PROT_WRITE,
		  MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
	ireg = ro;
	memset(ireg, 0, sizeof(*ireg));
	ireg->flags = ZCRX_REG_IMPORT;
	ireg->if_idx = boxfd;
	mprotect(ro, ps, PROT_READ);

	ret = syscall(__NR_io_uring_register, ringfd,
		      IORING_REGISTER_ZCRX_IFQ, ro, 1);
	printf("self-import: ret=%d errno=%d (%s)\n", ret, errno,
	       strerror(errno));	/* -1 / EFAULT */
	return 0;
}

 io_uring/zcrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 76b9b0d54af9e..fea2b27272ec2 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -808,7 +808,8 @@ static int import_zcrx(struct io_ring_ctx *ctx,
 	scoped_guard(mutex, &ctx->mmap_lock)
 		xa_erase(&ctx->zcrx_ctxs, id);
 err:
-	zcrx_unregister(ifq, ctx);
+	/* the import path never took the ->master_ctx ref, don't drop it */
+	zcrx_unregister(ifq, NULL);
 	return ret;
 }
 

base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
-- 
2.45.4

