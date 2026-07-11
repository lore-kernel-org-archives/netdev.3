Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB003A4505
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766985; cv=none; b=oTva7Gm3LIds75qZTNnv+JBQYqIuYepi+uoizj8hndKBmLQuLghqoRNYtMXA8BJJMyq9hBVzC2JOIYCIXZR1mET2KEUc+GoelCBRCAJJBFm8hi4Gn/zz78JRGC0ikE2xCZxU2rN0YK6IN75kXKPPvKCMxct7sZXDvpcR+NPAQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766985; c=relaxed/simple;
	bh=GOpsniia9YGwJC5+Tf9jZp7skqJgnlIpNpZfRP/ds68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzXH3Vw+6YvrO+EiY8pAUgZFsS+Pp9IYxRGeJ+hIgmxR+QEq/qWikaiZ8csNNQ46s0sE7Mv54xrUeA3KaFYmoRquTr8ZFqmS4JZd473zDD6QPrKrGlE2XNH2qvv3T/A5LizzEwvPovEtYcdxZI75uoppIJoBo3jKElrefKNtoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2jGj7rS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2jGj7rS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15f020a223so245647766b.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766974; x=1784371774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
        b=J2jGj7rSYfVeg/+f6IVxjKjjdACs6FUFKbw1AtR903opixoeHsQa6159UsbRcn+rvD
         XwOQg0W1EaPN9L99IoPRX5BQJ79uIgIoKHPfxjKW6/Po9xORL4+wvCuDTN1Cy0OA93/C
         glgbJcaNqFPF8tAx7LzObJ4EyG1tBypNcFndYXa3NtRI6ubX+HPX+rUSF3bxcQHg2rUr
         SuRhlsJvPVlVPMKj2OOY4N2sFlUFPmGb6udMFgZbiShjcZEyL02l1v9PRPKdXOxPa8ay
         ufOzHoDf2unypITLTtFUVUzGUsnlA7HU1uk9lf//hf7DNMeGvPMfeDp54HZuiUotYisD
         lhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766974; x=1784371774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
        b=H2R7hY4ox/NFgW8NuGQXpp6REO2sjUL7MxthIfbAQp61wkirumZDzQyL9ECEfSwdGh
         4kefuzGbv4e9HGRInIwtJ5/8UuLr66uyTT93o+RJSPWFUvCUSq9FSO4idF6W/lT2wiQM
         B8PdvPLZXFGkU4GYEiOGSVegCxSgReTFbE75veNMAAr1JW44UkKf/1oe471Z1zRPuG+j
         8thVKpmgsCs1Nh0MhmgfUmK5gvrXD+gMRB/Qgj/dvipK2hVjENdWDs6/ZCO3na/+zUt/
         tTXZxQKM8b/qeihoHcu7OQ16EcTxvB+I2aVMuosT8X5EQ6aH6Gx9bBnlWXg6VQ3WF/aL
         +22A==
X-Gm-Message-State: AOJu0YwQEg7dmZEy3nCeGaJX95CTMzqRcdfgdrsxi9l2bTeeTXrcWLww
	eQVsne9wUwwjZVtbmaDryyU2kUN0wgIIR0INanr6lRQKoeaCZuSap8LCU8b0lQ==
X-Gm-Gg: AfdE7cka4g7BTE++0yR7o7DbSepdp3gXMG6U4Qznw6YfEc0ZnKT5a8s7NOJs6B5/m2F
	ysP2TSCxKePSiPMhY4INUNqwjtTgTsHX+95V4jrlhvx2cEVxT+OyOFAjv/hKAMC5ZJlXghYU/7r
	3D2FKv2f69+W4RGrksHVwiCXLKFLzzsj3SPqUgUGL68IfIlEs4hsic9yKp5Kh24B8aXyXMqgY7O
	m7Ny7KuxMrFPNleKFUrPC2NIZiaF729IYPDES6+qCS4QVlxHy5LqYtIX6uAy1bw3kQNBsBNTBUd
	JrhlIh6i37x1Z772PhXKD1P1P5NVXeVbQRfqs0x5QefjzXN2+AJdMqgMHP/xzPxBz3I1ZLKvruG
	DRI3iYlAEC+raP3x40oKwdlI89TXEoXi/Su2gdW9ndyzhgv+Yfb13gOxanCyWLki8NtDLkGlCgR
	qGJCBihcMLsWioiVbphRFndtJQlLxLPNZ7c4Ys06WoJEF8ugum8BfS+0wCFkW+ycrcx8zTrtbjl
	hoLS6Kuepqm2FAAMFq6Alw4SjMlSxAf485vEvRHQ7io0dIFeg==
X-Received: by 2002:a17:907:706:b0:c15:d4f8:dade with SMTP id a640c23a62f3a-c161e8e7d15mr90880266b.2.1783766973894;
        Sat, 11 Jul 2026 03:49:33 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15beb53b86sm609123166b.25.2026.07.11.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:49:32 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 07/10] io_uring/rsrc: add uncloneable regbuf flag
Date: Sat, 11 Jul 2026 11:48:36 +0100
Message-ID: <23e6c268dd474997765caebf90ec9bb39f481917.1783614400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783614400.git.asml.silence@gmail.com>
References: <cover.1783614400.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 24fc3232a66a..d57e8a0380b5 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1381,6 +1381,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -ENOMEM;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 98ae8ef51009..83aa86e6f320 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -29,7 +29,8 @@ enum {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0

