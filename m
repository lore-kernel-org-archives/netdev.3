Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3444E037
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991262; cv=none; b=dIcwmLDZGu8qMmq0nG8y1Hk6rf/+k5KMJqc8BiBX8qN6k9tKC+rmuFIqzI/TB+E2mIglHGOJtgLRWLO584iEX9oRPR0ocUk2yk2pTwcxaOOooBRiMfYak1cfiPYp7LZUVa2EOdukEXZTlAXLQp4DSL6S0TMY2k7wFKOemDfXRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991262; c=relaxed/simple;
	bh=1HxAxGz21Z+mV4nQVkIRzMQr3cqtoOeT3hoEcNfGYlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krMfNl754AWlCqOyMOIWfYxHtVk2iwN2dgMIkwUFTFp/exxBUnWW8CbEzBsoeLGoMakJh1YW99rEFdc8g3jO+u6v0AJW6idrM1ZRpybWn08Uz/6pbezZ1fO29NirgMXzV+NDNNhr8FngCdFe3QLuab3Y7rGHy2wmwvrEOBHXp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGz9sz+a; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGz9sz+a"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so4538768f8f.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991259; x=1775596059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E8cpgSiBnzd/+76DItta3KLSsX/PyTBe1odLIcto+8=;
        b=FGz9sz+a3qrC4rH69SrjtdPGV4y0y+hsv3n0ypRg8tfMEj8WiHWhLkasqhFRMaJlee
         9tipIm9LkQTdmI4FqWS6ipumGfUX38VoSfXT7DUgHFakvcF1a6vqCkZh50FdP6P8oLgh
         +IYScxuMxrjsWMInb4Z4X4mPXxnDFYug1EekhjG/eUE6pmuAU3AqZP+XU3z4VDI7GuES
         YEeOky/e+ranekmp1Mg4Qunhl6H9Uf+arqL03p0qzexlclHtDfbeUCxA+IqVnzeQT37l
         qtJFaK8NonjZv6MIRVSAsa8Z3zJ2LPqJ7oEjRbNA3djG4hZ4M7TROxIVvfaG40wWRqb7
         79Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991259; x=1775596059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9E8cpgSiBnzd/+76DItta3KLSsX/PyTBe1odLIcto+8=;
        b=peNqC8fbFtbqRu4vTLYtumh1Ei+I0hyBLLX4JSiqmD0gt1sEqakZhVqNKNiL5fWfwG
         3dasRk6G6mqcwx45U+P1DBeq++wKRGmQPm6j5xYh77cKI7hS79k+IYBkyrUvTK+aULPV
         p3DIwBuGmODQhHBXJAp5Bx5qWGtmrLSvZZI8gCEANOMsatoW8rbKBHJ/hoGxFyRyfPfG
         H9Oit9iuAG3uu3+Q8Go9NhFwwRqG3glMGhfdKOROE/MylCCaVtjXE7oY3KCWlvJsUwYb
         la0HpnqjW1YzpbCVSS9LF6pWrcK80D58qi5nH6b5Twh7jDOfTmG6B2tP/zgfTYz1IyAf
         ky/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3Dr67ApwZDQ5sBn/zoDNo8esq64yS8UlYUD5i1LKoyK2NkmMaWZ2gfR5MHHxHfPtwlADGGk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8BuJVpsj4jRISQ+fZLAgtAt9XB0g2Yh/4G2Uh8G6TYIRD2Wk
	4m7HIXQ6N8kovlO4hHl04XHvtld2IGHUKnYeSDp3YfeQUZa0SBG8Y5zj
X-Gm-Gg: ATEYQzzoYyDcBH7pdm6/dJXYCJXyk3Fz7vuQP8NsGGXZ7aTJniFG0Glu3d4WIXjb0bb
	0RCyh07tbIUZpxDPUO1efQBUYFJCr0/z4Et4Nb2oK5o56VjI2Ip2D5MJbig1j8re/zkN6Lf8tAG
	4oycJmRfCfvrjsHnKGFJBL2VPLlXlEfQnyaNkR2J0V1kdFeIkZxQrPxfMQichSgqYyXi+lWdKWe
	oJQ4zpn/jTy0YZqV9TzSmBMZZ9oVIRPJ/Uo0kIM9O4JwfOIopPC9u3H55u4esEUosJbIOPzdHkj
	ZZeH/pW7uAoVf0oOmDJUpSdDX+7yTaa25LNuPJ3iX0GkOUOqZ++p4cudE8tjR/LNHK8KQwVSYRl
	51G9nAH4hiqp/tp2oNgBgrtm0tSqxvEpuV5CDyGeqV7vHE65s4CMt880NrmPQWbbs9+i1Pd5vYl
	zdyQlaAalEyw3LcZx8Xfhi0v1xHhIXM0QChSMiiwOnTQqO6DKT+wCApuRqtINIDtqhHEc+mbxTb
	R7cl3kysJZIPxrsrH2yVTf3G7Ih6Q==
X-Received: by 2002:a05:6000:4205:b0:43c:f737:a3fa with SMTP id ffacd0b85a97d-43d150e7f47mr2017516f8f.30.1774991259283;
        Tue, 31 Mar 2026 14:07:39 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2570b18sm32431393f8f.31.2026.03.31.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:07:38 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v3 6/6] io_uring/zcrx: use correct mmap off constants
Date: Tue, 31 Mar 2026 22:07:43 +0100
Message-ID: <fe16ebe9ba4048a7e12f9b3b50880bd175b1ce03.1774780198.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774780198.git.asml.silence@gmail.com>
References: <cover.1774780198.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zcrx was using IORING_OFF_PBUF_SHIFT during first iterations, but there
is now a separate constant it should use. Both are 16 so it doesn't
change anything, but improve it for the future.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 3bf800426fd2..bd970fb084c1 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -386,7 +386,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
-	mmap_offset += (u64)id << IORING_OFF_PBUF_SHIFT;
+	mmap_offset += (u64)id << IORING_OFF_ZCRX_SHIFT;
 
 	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
-- 
2.53.0

