Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835C3BBFA7
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766458; cv=none; b=HzTxMhwJN3pbZq+Cw2sIPj36ys1suM4pTAY5jPRjtyk9wGUC0x+6IWmOnA72ftXPNscnhQqeZ1TWrcfkuqGVK1z2bgk/b8G3z8h586U/xpgK5zVeKzaXWmccAp7r3JBj7Jx7fFtdgsLIiRN8dNJ69XC4ddPurrGzH4lxdsdwIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766458; c=relaxed/simple;
	bh=iblavB93AxCL3yvmozWyZOBWp012W9mfxgmu0H2OZkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irSY9hK2dtLgt9cCipU6fogBMZ6apniwlpknUmEb86nqlZpfgtzdGepQ/olWQ/VISA6jenTvPfEvVxZ63sE6Edr22pVvqYMRddfMJTzmIForuxcGTGOuKBxE6A2rgJIlruU+SVexUiGKo5E6IugPBqWFFxHx5eM3bXzDY6EK2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku8UA5dV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku8UA5dV"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so2484224a12.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766455; x=1784371255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68WsJOLW2BWox2TMFnGxaO7ba3MkU09Qn66t4UUeZYA=;
        b=Ku8UA5dV2oOHxFdO6/DrzXb8YYVLDzHtwazH+YJTejjqZMjtHAZWagArfDgTNbr5/n
         Z4vELg7hiOEprdQNUu6xJVecOJbrjvro5URW0TCTYLFdlOykSSlglZf7TAJaWCp1D99p
         1CqSRmK4DWt7xqQZn+2McwaP1pRHnfjYDyPhUzEQ9ExV1rG+FQwmAq9nIjTXQx8fmc9c
         cwE5dl21vII64t22s0tuh0yNpJ+BlPteg0KhR91CNsgoLLTkec5OrfR5c2c1qBnKiRpB
         2M8HYGrsEFcXRvpXzKcfz8Ic/i+Q6gqmxdPkNrYmokhoAdyiGzV6eLna5phbyU+4KFLk
         CBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766455; x=1784371255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=68WsJOLW2BWox2TMFnGxaO7ba3MkU09Qn66t4UUeZYA=;
        b=TdEp1ajkgHLHsMQJfISQpUu4yvU57RTYQdkKW8vgaP6+t7fWYN+Gg9IMKBbxB471nG
         7Ce4cQTou792wfWeW2PsnrLVDFUQztv0hb558f9qeVeHnG86VF2sQa7cC8c7oFQaSiW9
         vgbbdnOFtuLnigm2YNUzNwuNUdDXD6jBWHjykdP+NvjNSGoBqZs3Mrcb3CraCrPQ9Ncn
         EYsu8gctL1466p74W5XyMRuRZBfFjRPcwHoC8qI8WoDv8/gxNECUlx1SZzI/WgyWZHMq
         ii8lWhb2kASq6rkxu47cUaV3foYzuwlqoC9nz6cjkF6BMufmjw9FdDCiJStFyWXhcyHb
         YRMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKa/HhUBMayDvIxHzZs5RgMuk2RxmogLr1IEJ/ja3CRjtMBl6qQezFwa8AmW4EYt0mJ+nZ0jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX98zoqspFAfYpzvCZIeJnv6K7ijGSO+6FK5XNMg6Cli9kPKym
	tGxhBd9eDZsL8KWmhV3ljpblCPmT57YuxAQOe+69oYA+EmBjqQY8YAMNDWS+ag==
X-Gm-Gg: AfdE7cn6QMShZBeEeIxDrbWWgfc3I0SXLz0EoxXDspWk6XfxRic6PPBova/n90csy0k
	NUXHIMqgDt45zQMX1uThwBzeTmwfC0WVY/jWCXx1N00ODyZKAajjvyzXMdxBtowtRB0yKwPj7jM
	Yz+DhVymznnZchLFUIswRo58VgUvoYn0TEeVna4mOkroq7bfPMvst7ILjDWKJcQdx6M2c8oa1k7
	x3FUNF8e+xl2zpS875fypTL3Jjo4Os74hwC/IgCtnnD3kMjL15GE3xcgC/Q4r5QsCYcdoLDJocZ
	L7FIHEalj0xQTijswq6VO8u8mT21uGc1kK3lXdHhts2iNdmn1c7CA6m95eOxzKSWJJVd1nsxnfh
	mtNxS/eoYcA44dB79aIcyYRkKmve/CWNukEn7+FpY4PwhxSxqfG0kXUWhGy4NoACcm/UqWu6gKD
	DMK0+tmIG4I240AyQSJ74GUlZJzb3ER/ryeXd8w3bOkCf+tjpb93EbgnIu639jU6CVdQQjAyHsA
	KIm7TRf4Y5I/jE/xVQ0Xg8bUCOwU7mrQYAC89iWF3lXqfexhg==
X-Received: by 2002:a17:907:3f20:b0:c16:13c3:b1ef with SMTP id a640c23a62f3a-c161e97ef9emr83665666b.24.1783766455259;
        Sat, 11 Jul 2026 03:40:55 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:54 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 09/17] io_uring/zcrx: split dmabuf unmap and release
Date: Sat, 11 Jul 2026 11:40:02 +0100
Message-ID: <81b362f58b0f8489c17f03f2d984f499e8ab74c4.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
References: <cover.1783616211.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260711104002.UCYhKy95e-2rm_gM-6uZPuI7Ird7Q10FbRt3CNo7K58@z>

Until now unmapping and destroying dmabuf were the same thing. To keep
it consistent with non-dmabuf, split it into two separate helpers. Unmap
destroys mappings and attachements as it should, and release only
putting down the dmabuf fd reference.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 79099a78f8cd..86e8046e98c4 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -121,21 +121,25 @@ static int io_populate_area_dma(struct io_zcrx_ifq *ifq,
 	return 0;
 }
 
-static void io_release_dmabuf(struct io_zcrx_mem *mem)
+static void io_unmap_dmabuf(struct io_zcrx_mem *mem)
 {
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return;
-
 	if (mem->sgt)
 		dma_buf_unmap_attachment_unlocked(mem->attach, mem->sgt,
 						  DMA_FROM_DEVICE);
 	if (mem->attach)
 		dma_buf_detach(mem->dmabuf, mem->attach);
-	if (mem->dmabuf)
-		dma_buf_put(mem->dmabuf);
-
 	mem->sgt = NULL;
 	mem->attach = NULL;
+}
+
+static void io_release_dmabuf(struct io_zcrx_mem *mem)
+{
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return;
+	if (mem->dmabuf)
+		dma_buf_put(mem->dmabuf);
 	mem->dmabuf = NULL;
 }
 
@@ -190,6 +194,7 @@ static int io_import_dmabuf(struct io_zcrx_ifq *ifq,
 	mem->size = len;
 	return 0;
 err:
+	io_unmap_dmabuf(mem);
 	io_release_dmabuf(mem);
 	return ret;
 }
@@ -317,7 +322,7 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 	}
 
 	if (area->mem.is_dmabuf) {
-		io_release_dmabuf(&area->mem);
+		io_unmap_dmabuf(&area->mem);
 	} else {
 		dma_unmap_sgtable(ifq->dev, &area->mem.page_sg_table,
 				  DMA_FROM_DEVICE, IO_DMA_ATTR);
-- 
2.54.0

