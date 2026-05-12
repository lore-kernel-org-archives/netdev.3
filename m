Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865DE349CEA
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581532; cv=none; b=jSmZ/bPSFL9dnrGG7m7ZHQUWoxv2h71FrR6xRAji29zSDOIMbWdXTyOvY8lRXaO+oVTveWeSlSUwzRwDMpu8yj0imRkxjEFgKzZzLJTTKvlavloNysOwqDVxj7MUiyPjuna1KPQW7WqAzt6moXXz3/QCTEsRhYtjAxEuPmYOQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581532; c=relaxed/simple;
	bh=Ig0Rm0l3tWYwnngupYRibeBBbXl6IALnesfeULDExOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx1ukhLBgAzStMwknxgZYzTevFvSHUIXlfe5N8yhjhTo53GnUGH00oH5It0hJ45EMYEWCJojlaq0EKl1Y1WDdMLE8YZN2Wz6L0oCooeLS3T6D8b4Xy3/rKqQH4+82LixfUM26SGIF3zNW/ke2gBKabM+DYdUj64riozFu46Qz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZnD0tr3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZnD0tr3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so90378765e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581530; x=1779186330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzD9Va0RuvonNeF0FpRZsFq6mTbQSj2d4JnlAEySAww=;
        b=aZnD0tr3OxrvXgkGbyeD18NTZjne7KxEw4bn5Kt9vU8n0qe/de+EfuzcKP83L6KCU9
         v93brpA/9OiocrwKgldHFo/0imiux/is9ANjxQtHnIisCLxLXH4wejGNB8q+X5vd/T8E
         4GZdEG/ec0YJRbwTFH0ydQsZ4LQIOVK673q4zAr7AU9VHzNXe7+hyNAbqn1lUei15BCR
         SYdz28cTOnHNHTyUMaLxKjRkyclSZ/7kmDa4+Lwk/20SJGfYNHz6J+koaHh6kz/Z2A8N
         pMtonUTHkY9QFUIN07EwiepZRm0qMCh28wTbzBpIZfilIl6eJurEBN8+JBs2NNfX6r71
         YtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581530; x=1779186330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rzD9Va0RuvonNeF0FpRZsFq6mTbQSj2d4JnlAEySAww=;
        b=T7nSwali2K5P9hsB6aHqwj9EaPHQBLuyoPH6gO580Xnw9JIXgeJhWEHGUvysLJdqoX
         QCzPn6F2y8N6ZQybT0g7lrMwDt3nzGHdgaDblD/+1iOoofYydGMuuQjyzfW/nfJ0Cb8X
         k7fdn2GThT0+ToFfyAnbr/vcc6rieyqOJm/SQmA7hfoEdQlp5WxTxHwIy4ksb1C1Ypiu
         y+vmS4RJtoP0BOOJVOaDzFmNh7RMstyw44g3eUGr+zl37q4uYQqfwP5r/hDDM8nikneL
         jeFMwPtg5R5jUfGYckTkVCReelquYewO/jwEZB6pGV0arcFKh5dh4TWkue5CEFkMOtQR
         VcSg==
X-Forwarded-Encrypted: i=1; AFNElJ/by5H+EUl10RATnl/CbFBP2gqGLcQJf7Mbz8jm1f0n6x5VW+nd6giGR3+iW76EOIpRjkCWv9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw282xOyLF/2DYYyIHoCRbzuYjf58JGhOgjMuLDTmhHapm+U0eI
	qfsNR0Vjs9p2ufG/zjfVfFjP49946FnINL3P8jIXyw4FWOGK/ie6Kuxm
X-Gm-Gg: Acq92OHuDrf+7AS95FdmA2lFdjP715iqFmrz7xpBdMRSb+p/tMy7/zm599bFImsUmvx
	4uqagumbli8yM2MKNZK/2kEXEZ/c5XdOpjUbyOAFN+NaulILFaqCp3X0RD6UZ5itAHmxtOmfqpt
	I3gEEG6WjUQa8eTFrXASnjs/wv93J5xq4vr3euYnDRWt8xoI0Ofo7tQwtMb26mgx3blj7k8KsbZ
	fkZCbdJx90MmbAGNuMqZLNggAZRzgVozrQZxkxmLCl0QHnjgReBVN5oMXUGz6tbO7XkNg7Cqu63
	1Pjaegc06ehltGPXMDR0pcmQF0bLyuUh6Q7rdjB1TZWSxTgYcVVtW73wFBD5NlMzpokyHRG0sXK
	kEJGjMggMFITpF0MvPw18J+BsTF1G5m35s0ku559Nfdlj/dI8n7aaT/KvKOh8BLP0hMHfitMdIJ
	watM6LeNVgmi0yWJ8uOeAT7nCZCTo8Zsvl+tb/c9/tBG2PllN2c5VzujeG+aovNn9KOT6mgKnVl
	ygZBUVGgw==
X-Received: by 2002:a05:600c:4e0c:b0:48d:46a:6e5b with SMTP id 5b1f17b1804b1-48e51e19110mr465285955e9.7.1778581529976;
        Tue, 12 May 2026 03:25:29 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052c9fesm74352255e9.1.2026.05.12.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:25:29 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [RFC 4/6] io_uring/zcrx: don't pass ifq_reg for for area creation
Date: Tue, 12 May 2026 11:25:04 +0100
Message-ID: <7ac1e9fbed1aafd31a654cd66eb64ddf50bf18c0.1778581283.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778581283.git.asml.silence@gmail.com>
References: <cover.1778581283.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We might want to create an area without having an instance of struct
io_uring_zcrx_ifq_reg. Extract a helper that doesn't have the ifq
registration structure as an argument but takes the buf length
explicitly.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0ec491587a36..0551b05d53ee 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -466,21 +466,22 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 	return 0;
 }
 
-static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
+static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
-			       struct io_uring_zcrx_ifq_reg *reg)
+			       u32 rx_buf_len)
 {
 	int buf_size_shift = PAGE_SHIFT;
 	struct io_zcrx_area *area;
 	unsigned nr_iovs;
 	int i, ret;
 
-	if (reg->rx_buf_len) {
-		if (!is_power_of_2(reg->rx_buf_len) ||
-		     reg->rx_buf_len < PAGE_SIZE)
+	if (rx_buf_len) {
+		if (!is_power_of_2(rx_buf_len) || rx_buf_len < PAGE_SIZE)
 			return -EINVAL;
-		buf_size_shift = ilog2(reg->rx_buf_len);
+		buf_size_shift = ilog2(rx_buf_len);
 	}
+	if (WARN_ON_ONCE(ifq->niov_shift))
+		return -EINVAL;
 	if (!ifq->dev && buf_size_shift != PAGE_SHIFT)
 		return -EOPNOTSUPP;
 
@@ -550,6 +551,13 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	return ret;
 }
 
+static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
+			       struct io_uring_zcrx_area_reg *area_reg,
+			       struct io_uring_zcrx_ifq_reg *reg)
+{
+	return __zcrx_create_area(ifq, area_reg, reg->rx_buf_len);
+}
+
 static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
-- 
2.53.0

