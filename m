Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC069476690
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108799; cv=none; b=gp6S5lY206Q4frydc2NJ2CHZGfRrQe1FTRkdg16HknpIwyudRXyvOtE18d2XIjMk/Fjfm1F2q+f5DaAW2x8c7Wmbvd8ShQ6rBw7iT5rDYcYoY8zT2+kbhL0wAlaMGf4ap0xj9WSWMxyWUTcBbva9KxilPeVoVE3eZccxKO+T36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108799; c=relaxed/simple;
	bh=ktmoXFZuFIGeNodDPoCN++Z+HEof+owlAdKgvlHsDPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bc41BP+0yIoop02Y4G8FYPp7YQJdAo75KkqTTXn8ost9XY9LCeATXDJAX9FR0ZLgXrAdjwUQlqNr1wbphp51+EFNy4fAh6z8N7Z5idtJS5nlJr6jqw42GKmQZqENKEhSAIXnfqfdYOT34RLSAjszTCWqjUvdCeIRGf0Nbx+iLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOE6f2xS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOE6f2xS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so20744295e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108789; x=1786713589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQhF0TcWQVe1xV9f/49SFwwFGfCjJ2hCpO6NQ7/d1Qc=;
        b=ZOE6f2xSDcb2xuZ5ZFFH5GQDmqT68p1J+CvC+/0MiNdnQFOlm3c2yfvGy1iap+J2Av
         Mvcwu/xbfDAGEn9XDRJbVAResLjl47/xRr8pkuCwpFPSCeCntF0jGfwKY+ilrv73YarY
         ESBUOEaJme9m09Ve52AwJjO9bFSTGGa4r4dDe2qHb7VzB0TiRtfmvfkjv/gSkLW81f9v
         n9rfad6AEnBLSWzOvG0sAzdByH4DG7L0l0buZ1iC6lQmbtXqPvmX3IOLfbwAInfhnDUA
         vMtjKgeBH19DQmXDQOg30lMLxjC8hm4lblSVzWfNX+Y129f9Fe33ediPvKD1Ug3VLc1+
         1rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108789; x=1786713589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iQhF0TcWQVe1xV9f/49SFwwFGfCjJ2hCpO6NQ7/d1Qc=;
        b=C9xE8hxOxgt6RO8BgtMKEwJbYlk6hqpGCXpsL7zOVQy1N7ekAkXIYh3zxPkPzB/gtd
         wjsoilH4VtcHIQk4DCgocKJGrqlkEea8+GXToaKFqS+VIfmilQkXncUBwo/WGxjeYfNk
         jQ6DNnsAW2tHI9EQZusCxtHULYmUsH7q4JOzQ5+PQIDbjbpY1F8wvdijLBGRxeHEVt3G
         uZeY2z1b9+9RbBvm3LxqX2jHBb8rX8OhNG3Z/4Rj4IJqg0O7ZZTA+RFvc0NWDWzL5R34
         OyQMWB9etcZ7pGrnDHK0DmyebkDF0HWlooIRcL4Kt22cagEv8E7WuPVWfEppitEjA1iF
         rTJA==
X-Forwarded-Encrypted: i=1; AHgh+Rp17orFj0Caa0hW61fXryl2yk8lVgi6mrxfoX4NCjTiYstQ3/tECjyrymfJZ1iDpVxuawlnJu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9jqIhb1tWEz0i+jCB9+wq/Kuk8OMWv8Ub8VxWF+1aCilxqAe
	8EswQxuJDOdqXebxKqCMnCUK8CJ7YY+HNdGLsVsRT/XdpG5kHhQKbVYOxjwzV70Z
X-Gm-Gg: AR+sD11DvqhloJoSbkY7xdl9wb8N/jQlHfvZpxzT9JtSCzX+qUmfauGbqHZV9gZU6Q6
	L5EfmMccbGIIgineCUtlrIpICmD3xgZ0/L1aF0otnrd8EcLFPsmvfO2djtsAOJfaMuVOqn9COFw
	MW2iZ+/GJYcWw3ncyWe5+8v2IGud6sI6pdrlQRrUNWubyuGBudzMqEPBxwzst7yr4Rayb5sKfx2
	zkOtqhytaiEE2IC8jxF1ZFoUVSt/dStrdCLtCKrHUAtYEg5TSsB7GvwzOozUtW/LgtcH/8tyy5B
	03XHzBXAA++Yx9Dr24etSLa+m5KhSRMDIQSKbbkYzxrz+9UdwCxHV26RFwuTjAlaOon+eq6SjEv
	zh78ud6TgdoSv4FXcE5VdWv0H7KYX6lkXnYREXMLLtuYXBAuaavP0B93HYOtUo4K+oMdNQLwItm
	6o7lCGiy/Zv6aTP1jJDru9mU+jXnaG3Jb5VELPj0LEv9UW3S/XKWuV9MDUx9wnNHb3+6+zZPIBG
	1Q0yfRB4bg8jUzAqK4I8GYzm6DAkPLbn+kNP2PIiSKxeRu9iQYW/yrml21nzhZjY+pHoTnXJWa9
X-Received: by 2002:a05:600c:a202:b0:495:7838:7e25 with SMTP id 5b1f17b1804b1-4994e7d01b1mr234241055e9.15.1786108788678;
        Fri, 07 Aug 2026 06:19:48 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 06/16] io_uring/zcrx: constify area_reg on import
Date: Fri,  7 Aug 2026 14:19:24 +0100
Message-ID: <2cd4a3e43875576587c900ebdf8f1fb4af266e4a.1786108672.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786108672.git.asml.silence@gmail.com>
References: <cover.1786108672.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_import_area() doesn't modify its struct io_uring_zcrx_area_reg
argument, add const to enforce that, it'll make later modifications
easier.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 691206a7721b..50d075fb3825 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -136,7 +136,7 @@ static void io_release_dmabuf(struct io_zcrx_mem *mem)
 
 static int io_import_dmabuf(struct io_zcrx_ifq *ifq,
 			    struct io_zcrx_mem *mem,
-			    struct io_uring_zcrx_area_reg *area_reg)
+			    const struct io_uring_zcrx_area_reg *area_reg)
 {
 	unsigned long off = (unsigned long)area_reg->addr;
 	unsigned long len = (unsigned long)area_reg->len;
@@ -208,7 +208,7 @@ static unsigned long io_count_account_pages(struct page **pages, unsigned nr_pag
 
 static int io_import_umem(struct io_zcrx_ifq *ifq,
 			  struct io_zcrx_mem *mem,
-			  struct io_uring_zcrx_area_reg *area_reg)
+			  const struct io_uring_zcrx_area_reg *area_reg)
 {
 	struct page **pages;
 	int nr_pages, ret;
@@ -274,7 +274,7 @@ static void io_release_area_mem(struct io_zcrx_mem *mem)
 
 static int io_import_area(struct io_zcrx_ifq *ifq,
 			  struct io_zcrx_mem *mem,
-			  struct io_uring_zcrx_area_reg *area_reg)
+			  const struct io_uring_zcrx_area_reg *area_reg)
 {
 	int ret;
 
-- 
2.54.0

