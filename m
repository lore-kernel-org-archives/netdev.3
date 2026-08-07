Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DB48664C
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108806; cv=none; b=nDwraDlteUp0PgnvG2rdGqaCjrM65+n1M3aOn/bgM/rGSw+s8aR34aQBBnFOX++mQiGptU5GCY8gwSCRFmjNFKVQEouDxv8J4Y2giiiD00FhGK1PX1NJsJwbxSPleF3qC/HD4E7rnLrFz2sTr9ZgslCzpHPPVYzB6LbQdM7CEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108806; c=relaxed/simple;
	bh=NG+/rgzHAv6MDNfeFWrG2P9/U23Edpgb2yNwIiBT1Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8kK+yEYsod1pyz+Eh98MREtae+4+ftrkVliaOxHp19sKpDMnFN9yzJj3h1IzVE1jANW4mrg0o1zkUjrvhfrtjhN/qSUK7JlLMyUt8H7F3+tBhmAn74qovw/jJ0euVrplNyJRpm7cAncjf3LsxwZygC1NadaCOQXYy17Bnwh6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGkB5VGK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGkB5VGK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49553515a8bso50395685e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108796; x=1786713596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+9t8ch659Yhm+Hv1XmNdLGapWGQy+4Zla8E93djIqg=;
        b=bGkB5VGK0dOVdvbaIHIszpbNamnVjga78RxB57hXoJf/vZYP1KYx5H2aa29AnhDzID
         6BpjF5ou/QQdzErWsFYg3nS3kkk2pcrwQuLq/CMdo16wpZS1e924vRS0Q7D33ZhzNRsq
         KAPDhmaKmRvqNCZAXemxA85WcPqgYV85lpIoAyB0SjNq5Ozs2C7babdR3ts6gC+LM1R1
         5HRMOT7vmQwNXkMQC1MCDkkGqYVkzxyRdVctbSxxjb4BrBOkCdLO9OklbJ9CeCECLHyz
         pgmprGLYyP8vhX3QCNXPlDkok7M/0I0BvjBx8t0rJzv0New5JyzSWfVpyvDjPr1klUhV
         6fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108796; x=1786713596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D+9t8ch659Yhm+Hv1XmNdLGapWGQy+4Zla8E93djIqg=;
        b=bXTIS+S7pVq9TH2MeORXYUteZi/p9nNcvFw0iHm/fka7r3aJhtIfpwcp9QHhdm5oeS
         xL5n3S0kKa1lK+Sgj/zbakWRCio4htBxGcVm1qToh71+dY77cxYlTKwVZMD+e4ALJKYa
         XB7uhoMl4BQfLT8SjGX7Wdpqv3KMrRSgTHlqMjiVTVKc6HV8TsdbAAqRB7QGsTX4LiVS
         GobMqBkfAqXHdZfMDVrBVqGQHaONWXmu8VQWAlQocUlCiFe+zcuhGBe0DFwZz6DAo3u5
         Ct5YiUsyR6gppRAwfdfFW6X/duh5uYXWbdQkUt2ziWhvzn4uiPkBt6IBehctTIIQnjM1
         gARg==
X-Forwarded-Encrypted: i=1; AHgh+RpA003dbdYoVtUWDdE75I1zl3atIJx7rMZNby7Vskz7NISMWWZjqvwt9P9OOv0ADG/D5g+tEsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz03REuHv0woaQ3n+8WfyDEW3Jurn2Fi+hlLTlN1KzM5lOdTN+t
	s6cm9mOL7nAbcI2Bvey17xt/QI5C+YobOL8J3soeTKuZeHPpXCUEJP6v
X-Gm-Gg: AR+sD13MmSFM69JgWCMzmQUwzBPddlCVErnZyTdIEMfQjeexTvxgdxhbIcZcqmJT1/G
	vwPCYxYXSxpkUuncJpiSYXbUMhV3RPBKd2vI8TZnxSCVJXDKBRkZu6GHjbaFrZa7AuPYurZhax5
	FqhMFXLfPum7ub81TUdk2KhU93gUz2pLUMoMDWVTwwPtyabGbtvNugACfFN/M+bwuq7D2SquAJ/
	PDRMeSBdmi7hkwPrd91E7jJ0lAm3BwNIrg26+O+CWgTgfNGeoz/SNs/YXGFn+o5WeLGfLq4YL60
	uNUcg6FAIMfL6mXlWUz7Z48pAN7xzmqeJrDCKTdXqNclUuNKT2qFm2iwIlupc6oaWR8iRLIMYUT
	LMJfyXhPDC+Gw99fSEfivUrYd6G2T5px4pq/22HXq7sCBFwjV8N4JxJ/z5O9lGST4l6qa70lZaD
	xZzehcblgk3BSgx6MGouPf63FDcwK89vyOs1ZFfqfgF2rYbS3yTP9kmpfxT2kEpS+rPxJZhnDle
	SztldAktft9eXBOQ/JD5A/GQRkMGcVPWfS4B1NQbYFQeCPECjzzD+Q/5WeJRGUmx1foYNg4kn7Z
	Xg==
X-Received: by 2002:a05:600c:6c50:b0:499:48bb:417e with SMTP id 5b1f17b1804b1-49959e0176bmr101727645e9.2.1786108796252;
        Fri, 07 Aug 2026 06:19:56 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:55 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 11/16] io_uring/zcrx: split dmabuf unmap and release
Date: Fri,  7 Aug 2026 14:19:29 +0100
Message-ID: <bd8c1fd8dac85ce0cf839b389ecd6050761965ca.1786108672.git.asml.silence@gmail.com>
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

Until now unmapping and destroying dmabuf were the same thing. To keep
it consistent with non-dmabuf, split it into two separate helpers. Unmap
destroys mappings and attachements as it should, and release only
putting down the dmabuf fd reference.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a142d6035f7e..91d0d823f482 100644
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

