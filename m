Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D03A6F14
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269858; cv=none; b=dKq171UdneWqWBtPAdAUZWmVxIX4TIPlK908fyNZyHnipXNQFNUREuYm5NPki3kl6NQ+MQtWROWhcuw6pcorOsYamiH6HzOyApWwuWShfY0E9CfxyiUgrAedYhr7i/kwOM3MYDkGtZomGBtTFTOTBbtZXxEVPI3IMIdXpchntUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269858; c=relaxed/simple;
	bh=nyXujVSAemKVxOwc/hOhlsm7BVV+CghXkk7bTjUaOtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZa+5xzTodGKG/D+W/VlZ9/pkdsC0W1QFPVsqg29h24s73RsPitMQltPAbl/RNCYlGmC4a9R2Tc+Z5StZ7So31Dy5nMR9+zI/xLZPVLxHmfTgkyL1FW8B/9s6fydnweQ6UGts5HOpcXRflg0NYz2davmkq2qITgGPj794kV7k8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5n7BmjV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5n7BmjV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b6d9c981so2873056f8f.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269855; x=1774874655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhAZLUfx73ma5vDDrIJbD3hLCOk/0Ar3kV4twmTvWvc=;
        b=j5n7BmjVrFq1ophIpLLZsjq2gibL4XxCDO1BjJKsZGprxB4RL7OP6MhqED0MYE5QXe
         gbm1Bw4bfoRH79NLHV2EQvbEqvfY70/GWZb61GMinqQJR2hkCkgHj2y2rjWgfLSG7KAI
         Nf1rvEjbAwhNf5FC4Nzi3qRF87bW7mtJQ1PQu0Gi2nKLaFSOgxjlvZRNCrYrmtpHO4ax
         jFua1rmlGq97x5955a133W5spsqBOFJWWnJ6exsT6rOM6lxFLKdmpPr6M+p6nG/1WP2U
         7G+KPXbx4LDZSo9f5Ne9NW2FMJPOx952rXBDkPUk6yndFYdReyhV0i/RrUDXUKKp+MrD
         0obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269855; x=1774874655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhAZLUfx73ma5vDDrIJbD3hLCOk/0Ar3kV4twmTvWvc=;
        b=JeKts2JsvtxRV0QEIaiALFM4YyVE6N7NViKPF8mxGVfY+TlSwyUq1Vut+aH0Ze+apV
         H+YRkb36TJiJ67/Peyl5jEvrN0TMl/eQ/q7kAEGxrnFFJKkhE5Th0skVIviUJQLcKjoG
         qFtHLGEyPv35gamMRkvGPNFW//6FwuYLXk+pRo6VeCDy52Bu8VnWRVhM3Mj9Gq4VzK0F
         fi/4uSBfucGJKPwLnOpEA3NqRQUEIYx5DctKUMruaHtj/+fZ4FddiOEJ1rDRpROEDVnL
         PRy0YTNL87bok9L+qKHs6H+KcO5trDKm1zmOEjigFawc64YTP9IIxUYE5NsNuCZE72p0
         5X3A==
X-Forwarded-Encrypted: i=1; AJvYcCW9tnuELavBZB2z7ddS0Eywabk9II1LHfESQRovConeVkDirxzRKV+6/wHljmpGZtkfNmhX8Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsDVE69DZ6eLerXLK8vKFdusXgTDBOD/DRyywtgZ5MPv/2GzA
	yStEdXETa3uctN2Mv30OrRPdmskfrh4i/V0/lDlLVUpj3VNfV3ocGT9b
X-Gm-Gg: ATEYQzxDvlktkR+/ZuOpCap+CCp45h+vJMFZ0rk6uXq350dwc5FDstho1s0yYnwvFqn
	9Q+rkctb8lnoS/OTaYoSPR4mAnpNx53gPvO+W174PkLBvafKZMl9uR1o6qaInxBSYuuuQly46IJ
	DlhCreiua/du9V8H6W3ihwekPYLhZUa32Bvub4FcbOGmPwpCWWLM54i/o/+vqbLC6ZX2FMOAnuE
	+X61jit3bhsasw6o06miTC4L4BwUQjpcgWdKbfm0q0bR+ApyD8nG2LPgv1wE3BTRloJPDnzQFUD
	EXe0HvXf3n5PPTu6FJ0/k6/RDcgn3VwKJl/0tK+MJStlHiUjZ8B9Mwj6NSBWHF0AmU+6T4S0smF
	OcJP3HegIzA/JPK/mOvlLyj8WGp/x61MYPtj4Da63BwbG4+qaXOHM0g/YKwnalRXxtqCT1jr1Sa
	LXV0OL7oqCV1Ldb7YmQviTX7U+M1PZSmWRcbfG7C+GZbVKIVtrD7jLzoBrSzBzNT/rG50n1neWQ
	E79+zj4KQ==
X-Received: by 2002:a05:6000:471b:b0:43b:46b0:fc3d with SMTP id ffacd0b85a97d-43b576e6f50mr24969923f8f.5.1774269854978;
        Mon, 23 Mar 2026 05:44:14 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:14 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 10/16] io_uring/zcrx: warn on alloc with non-empty pp cache
Date: Mon, 23 Mar 2026 12:43:59 +0000
Message-ID: <9c9792d6e65f3780d57ff83b6334d341ed9a5f29.1774261953.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page pool ensures the cache is empty before asking to refill it. Warn if
the assumption is violated.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index b4352c7b2d84..04718a3f2831 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1073,8 +1073,8 @@ static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
 	struct io_zcrx_ifq *ifq = io_pp_to_ifq(pp);
 
 	/* pp should already be ensuring that */
-	if (unlikely(pp->alloc.count))
-		goto out_return;
+	if (WARN_ON_ONCE(pp->alloc.count))
+		return 0;
 
 	io_zcrx_ring_refill(pp, ifq);
 	if (likely(pp->alloc.count))
-- 
2.53.0

