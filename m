Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFDD3AB282
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269860; cv=none; b=fxCjV/iZnwLABS+8xvELV9q4MWUTmmFMQ2fIdm68AcMy5Of4EnSO+ZDU1QBwj4NMf/FuqDsuq/mmXkfhqZb9R379yvRpYElCd8uZ9g7/DqeLz9alx9vMmbB21hNV46cPet0OBjwr8pVho+1rLm/J5Hm64tWc5Mpu1R7YgqF3CAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269860; c=relaxed/simple;
	bh=YvFfpu0cuPKpW4kEi3UTWKISmEL4Rzrrzs+1a6/PrR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+q3sFW+kDA9wY+Rj+2tM0jbMAZ9dpsomIp9eUOKLqsX/80JAYn18hqaODqtEBIizxWb+3vMu4HhHriUnJXJeqOhVF5o8Biv2+f8jIQRNq3jUo3PNH1b57ECofXsN4R1+gxUrsnKgyUWsqmzvUVZY10+vv3JBeJtZs5kSNECYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr1S8NXI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr1S8NXI"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so3632663f8f.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269858; x=1774874658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhDZL/FEmed9ML3cHb7wLCvxYEZQp1frpGLjKPfKgpE=;
        b=Gr1S8NXISrDBJkRp+vztFLp6abbi787AQpHKerPpJC9bd/M1i42L/2dhAHeckbt91s
         SpNVWThXdr9kAU8h7Vnh0pDNtK45mmrkDhJAxDT9fxOlDgum4LAwVs8to3J0KnX+Ydri
         R4/ha+d2RO+4V67Nb9tCITB9ZAU0vGzHr3r+TAq0kBEvcg2Md4KoRiS5WjmPynE5RsgR
         X9D85FkS1HN9QqYnc1jvvSfh2YbBJmmB2WGmSmXB7+0jnM5BpI8m5BIJAsYBXKXXuq7P
         L+byAMxb/BEk3M2ifO56fDrPfQf3cbvG+azlMMPsouyP6llaFWqdVzyfRbPHwEzDwEtO
         j36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269858; x=1774874658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhDZL/FEmed9ML3cHb7wLCvxYEZQp1frpGLjKPfKgpE=;
        b=E1wlsPxgffe1ps8tCByQZZW/DGR9fSBUjXRMa4t6fUHpXtQjqGJJseS8TH8/PfsIOs
         +Mtea9EV3qNeXprRaiD0/rIPkot3Rwxx/+eshebfxJ19YgBjddW8tlGqG29aFz88aCCN
         bmLG936my8YBIsh7YJVGwtrRsTxXPX/dkP3rTVNaNPnt4vU6SDLQHhmzkZ1t+63qJl6G
         Us+v69cOrQWDgAjq3Y0VX7NGev5sLEgqW9jJSd1FBDZ+zZ64r/GWoOqMf6Yp/cxy2eqY
         2mzwnRFaIObVyQVWEoow6lrqHPYOYV8Fn1EiTuB65dZcAIEgYy4cw9PypxXdak71nwJ6
         aTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzZiOOcQA57kcgJTLIRIvDu52HhFPeUY2IzRvFXwo6S/W/T9kwHUyyPEeg4Ndgw+nPyy+ANzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+v3x67dxxWArFKiFPkKoeH6wPrwWlpXXRPLLhrd46JmgWfWU
	eWY6GtJTks6qiOsYh1Y7c3LpAye3rgJxZv+FDmE7s/s5o2zkb2LfFbYa
X-Gm-Gg: ATEYQzzHM2/LtOtnhldBN1i+6xwAr/Yac4IozoLbhlAZQWNuRvy01IdWbaWT0EHwbWu
	gF4JqfknrmynoT0nnWG4vo4efDy9Ao1KEFS1foJw/7sWJSNAo4lzlZI4LFpGpkKUvvdVhkUvRAT
	8LjByQeFK6+BvhNWDvXz2P9iG4g4WBXA2+QrBx2G0qPrzs78Nupx9TkulxT14PajQu+F12u72nr
	mjhz/5m6zKV8UDwvrC0OyGRVUCDcXfKc/Ihk5cCtwR252/28O1iZm3Wl+MR0zX/L0CRWqczZ9nx
	+yo4ESil4K7bgO1izwUCSAqUPq2z/XyGP5PKHnQjsNaX0CPu14RSvuZGXSW2LIDSZQ6MjsTZGpA
	JgMbx6sdvPC/nz/rfgNwVcurHAStWQcdrPEU1gvhlO/O7jP30vF+TDs8kxrvDEUVPRtM1Yb6ot3
	2kW0VS4SXwMtQLsK6I7QyaAiQ9/XeUDMBSBwpFoAVeEnk5MEtvecdMJL4B2fQXstZH08mLb/wRy
	XphIpDuIA==
X-Received: by 2002:a05:6000:2502:b0:439:d755:a895 with SMTP id ffacd0b85a97d-43b6426d7b8mr18136402f8f.42.1774269857520;
        Mon, 23 Mar 2026 05:44:17 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:17 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 13/16] io_uring/zcrx: warn on a repeated area append
Date: Mon, 23 Mar 2026 12:44:02 +0000
Message-ID: <28eb67fb8c48445584d7c247a36e1ad8800f0c8b.1774261953.git.asml.silence@gmail.com>
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

We only support a single area, no path should be able to call
io_zcrx_append_area() twice. Warn if that happens instead of just
returning an error.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index bf3dd15678c9..265b3a744ac2 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -423,7 +423,7 @@ static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
 static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 				struct io_zcrx_area *area)
 {
-	if (ifq->area)
+	if (WARN_ON_ONCE(ifq->area))
 		return -EINVAL;
 	ifq->area = area;
 	return 0;
-- 
2.53.0

