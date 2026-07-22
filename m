Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF9351C31
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727758; cv=none; b=KR3IigZBz0jwYJvDyTYElV8ItygloTBmwoI96dH1bjtSRv/hIwonG0w/PkKa0DwHWk9+yc1vMBekOoCvib7nyGiY//BORwuK0/zfbZoV1zSZGtQ5z0WpxAraQ9CNtp82CDn2Or1Oj5kxTifswxvKHyyJqDGECRnrLERKCR07WnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727758; c=relaxed/simple;
	bh=Gaephhr8V+apYi7xr98UwbMvKOpwsR9XsVepILKepA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCTuSsQqVqRLTvpwV3JAzPNTI8/0de1s+YeyeOc/bHRVSL28QQnlmTlzwTc+q8WYLV9pjIPv+CW8CW5/xNfVHbbr2e4LqjEMkF4l+l3h0PJM84GkCX6vF4zDrEKCmJsve0QS4J+Rpz8UCvRij+SI7pVrfsth5sQhEa9UpYOIue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op6MJ9ac; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op6MJ9ac"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954df200ddso32829625e9.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784727755; x=1785332555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNZVfnXg/kqlOGN+wPScqefKCDQ1ogBFFTuRoaAgkQA=;
        b=Op6MJ9achXnoXv+bMuMCmsnxRC+Dsv2Lt0EQ7oAbKrTTefFiOa7STe3NWs8WEbEUOE
         mxCRZmuq1z/Y/nVQrj1BZGXRYgLve7nci4RvcBB9zqDyzEdOBR0nqQTEoNyODwHduoPe
         tURdMLiAt64DZq8pzOLtLU73UY1Nm/LSolog+vf6rXR1pRr7ie/gh7yo6+07HXXosSWy
         kQkMb1oA+MLE2xVHNuJSN0xxDZqbCEI0o1Fg46Tc4q+3MFL5SYasHYGudMBQcojtJfjW
         5GfCARqfN/O/Wq0R0MVuoYsVQr01NZbWNlL9SvCIPx7j5AOA7cJlcfEjtw9HtTIOhlyV
         U1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727755; x=1785332555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNZVfnXg/kqlOGN+wPScqefKCDQ1ogBFFTuRoaAgkQA=;
        b=X0N/JDLcfwsZtokiThS5PdLaran8YzAWm1zzv1oIO8oYMxfvjpQJxetY2eWMpjpqdd
         1mLApw4GgWRJgW3lWG2IbqS0WRGZ4sSZRDLizkVut2MwMbsBMTdaZk+09ntffVf4BZBK
         BJg9zypoKKUlYvWFp73G8fqRHFpyvs1rTPVagXgZzdWMkNElsQy2aYY6D3HRDJGmvgAQ
         Lcj61XvGZYXqivo8Uz0Kh0mtGHLhElMFv7kx0uyOvqOhtl+cvOCMSeC5al3qWnnv+0nf
         QEBqvqIeSX7S7Wunc1DG2oZ0OPnRggtH5WrBhlR0s0ip7pZJb6ZwfhjOBdBeFkCXabE9
         HuLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqpDExcRR4s0IhaXCTvZ5zX4JHR8eF8dQIvVURkZLI8uraF4mfV2OqzY7eieM3EksxElFRmR2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkwJoS+p0XIIynEcdFki1hIm519pnATB1nMuPRkt2zAPfFybL
	YZxtW5s/L6ICsdYq1jQvvZtX+qkWhfVXeaBnaLaId19NY5ZUrq0cUrUk5OvrXfcG
X-Gm-Gg: AR+sD108DFtHIOsdAQojA0A7rBQAgcjHrNjeiJakkThnan8tTYNMGtpc6aOo6E4b7Gd
	dmh3Vz27beJEs+2qDgvLLidLtpBXmRz6A66yBZQNmvqNIBqzCXM79AJTjeY4yiSCodBsx7qYo5p
	AeHNJgxqUNqMJqr7MyM+rqIJwfBeQ2z6me+V3AEtJcS+XCxT5FG3x0jqlSz8/ymJcSzP8/Tn5Dg
	PJrVYjjiuJZw8YlUne0sXHHpK80MQeDbemdQUjR/PghS22i/w2DUudz4web9A+M3e5zaQlgqFuq
	pMgWhg9xD/WUpX8VlnS7fTXmfj4L7c6vzYZ2vEVDea0TQhzFhmN0b3THr7WZQypp/W9+QE7N9jy
	dZhOJxaREXXeLVIdiBIlSUQIIdF/w175PdQILL5rCZg9Z9gZZu04dIzmYctq1O6+qtPRu/msZf2
	qeMANBjcucTZYPloYJjPJOnN5K2Q61Jf0M6cVHMIKGSw8IwIaas6SC3yzH55E=
X-Received: by 2002:a05:600c:46c3:b0:495:642d:4486 with SMTP id 5b1f17b1804b1-495642d44c3mr108166315e9.27.1784727754455;
        Wed, 22 Jul 2026 06:42:34 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:c15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a63fb10sm73403015e9.13.2026.07.22.06.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:42:33 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@meta.com>
Subject: [PATCH io_uring-7.2 2/3] io_uring/zcrx: rename ZCRX_NOTIF_NO_BUFFERS
Date: Wed, 22 Jul 2026 14:42:16 +0100
Message-ID: <29bd4fc069bc89691868beba0627ffbe570c2722.1784726895.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1784726895.git.asml.silence@gmail.com>
References: <cover.1784726895.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ZCRX_NOTIF_NO_BUFFERS tells when page pool fails to allocate memory from
zcrx. "No buffers" could be more confusing, rename it to
ZCRX_NOTIF_ALLOC_FAIL.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring/zcrx.h | 2 +-
 io_uring/zcrx.c                    | 2 +-
 io_uring/zcrx.h                    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/io_uring/zcrx.h b/include/uapi/linux/io_uring/zcrx.h
index 99e56ec26ead..abb898d59a4b 100644
--- a/include/uapi/linux/io_uring/zcrx.h
+++ b/include/uapi/linux/io_uring/zcrx.h
@@ -69,7 +69,7 @@ enum zcrx_features {
 };
 
 enum zcrx_notification_type {
-	ZCRX_NOTIF_NO_BUFFERS,
+	ZCRX_NOTIF_ALLOC_FAIL,
 	ZCRX_NOTIF_COPY,
 
 	__ZCRX_NOTIF_TYPE_LAST,
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 53dcb5110719..872d5794d3de 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1244,7 +1244,7 @@ static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
 
 	allocated = io_zcrx_refill_slow(pp, ifq, netmems, to_alloc);
 	if (!allocated) {
-		zcrx_send_notif(ifq, ZCRX_NOTIF_NO_BUFFERS);
+		zcrx_send_notif(ifq, ZCRX_NOTIF_ALLOC_FAIL);
 		return 0;
 	}
 out_return:
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index a8d301b6191f..d16206eb9e30 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -11,7 +11,7 @@
 #define ZCRX_SUPPORTED_REG_FLAGS	(ZCRX_REG_IMPORT | ZCRX_REG_NODEV)
 #define ZCRX_FEATURES			(ZCRX_FEATURE_RX_PAGE_SIZE |\
 					 ZCRX_FEATURE_NOTIFICATION)
-#define ZCRX_NOTIF_TYPE_MASK		((1U << ZCRX_NOTIF_NO_BUFFERS) | (1U << ZCRX_NOTIF_COPY))
+#define ZCRX_NOTIF_TYPE_MASK		((1U << ZCRX_NOTIF_ALLOC_FAIL) | (1U << ZCRX_NOTIF_COPY))
 
 struct io_zcrx_mem {
 	unsigned long			size;
-- 
2.54.0

