Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751081;
	b=XK9Xdx2l4DcpSx9bQYYAgM3eqNbqD2TpNpCHR9Ax3CzBwoTjg1CH8MiJDCdibbR5Mm7s
	 dJdIzaTcVzBAsO/YE5hlIRbjVWy1ydVY0N+PjRUMBQpgXJ2YzgSiFIbN1djqol0UW+Ihw
	 aAGM3Iv4/NPwe50MBYiYXleQNwBgvaXj9qQ7e7LqsX/ybjhI4YrhXrka0tONE2AFUKzYg
	 HHvepU+4SHlDw5ukFL/cvsQJG2eUmGoHdnBaEwzU2KWwnbMEH+kv7cBEV6cF8tbKVV0kh
	 BLLH2dw0xDkrQ7YdyjXe85Uo/+X1ERyY8gj3Au5DDJ0afz9hqVwAbh+hOdWrxns5B5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=odAhtlZP2Mip19/hHo5YdLy+LBq1jrxtalPsU0+TeJc=;
	b=PLvbL0A2dMchGrtFUFG1su+QvU3Th7vEJPaHXF3R7FQ0YR/5ZcHDQXnqotdxAqpOiUK6
	 j9/bAnTE4ebwrQIKB9NVULMzt6jaZmjw0JuMou3Z4F+gf+X2arJz0C9meMGbfbftqVYN6
	 rFzaOZOWo9s7/NqKEuKrDDP6KHjdiRR8ul8TeeIJneHa00JPto5vRPXDyG970TC8ak9ME
	 pDdr08ebvSbwWO8ait5jrl5mx7t2ZtdqOmNXZR4G4biMldBUvGyPYPoRhYEKbScSAn34F
	 CtZub7j9BCet0+bnLcZVctO4E2EJQ7Q3aQVOYDAu4kCnSo4K0LTTrFKoQcKkeP/GYQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXHE6ksn;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5836606A324
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 00:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5836606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXHE6ksn
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a208d93758so922735e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751079; x=1794355879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=odAhtlZP2Mip19/hHo5YdLy+LBq1jrxtalPsU0+TeJc=;
        b=KXHE6ksn0cc0tPq7Kle07za/kSTxhfPr99hwHVDSzJuC+C+gw90opoYSURyt1p8YzX
         RckSO4Gpkcbe4WuLRM0CisxaHEVmIcyAJ+drxEDs3tt9dWv+ABuhQY0K5WpXd/ACFpTW
         a2U3vFarnXuz0WSst+BjGFviRYaS1WMrO5mxYq+/bE34nmnd6mVhwI4i7apMR5CtkWvx
         4pgcHkZUMLi4BDJuEhtCRserrJepu1LT172tY0uUmcG/Q1abhoCib8Tp8bBF/D8PSyAi
         1iG6wtWjbS9bsr20XfPu7NG+xVSMn2neGF8U4fAp7cxCr41rB1oLVyi8a9nEGtBnIeU/
         fCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751079; x=1794355879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=odAhtlZP2Mip19/hHo5YdLy+LBq1jrxtalPsU0+TeJc=;
        b=Z42F4j0m0AtUU/+9f9hpoB3+xqIdkScuIKjJUhEqvnTgAf3a9UDJaNDXGAqSneajvz
         9Ds4yrWKyyFuFt1cKLPtdcP82Ct2uL754r6+t+KWLyCLitmAgkS0tMhHcO+arGdAHsGF
         umasujqb/v98L+Wu+Dzg8UZYGzOT0RD21IPM3RCl7zco1BFXKCXVgcM3V/OXcWYYrRqw
         lKvmWfA/3mKrDLA8LxQJEzZol/kPcHkFba5JYWlktd1yr5q63cApu9xn4pIg5epvH+cj
         Ag4+hQjmWLaD3I4CN++y7muq3ugTmoqAGevrRKoYSnMn0ZUE99givoHEyqLaLaCVJ4+I
         pwbQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9ew5bTYcEtFLO0WVeNLy7dexucTlwk/TZjY9ihdS2CPsRiFQUPmSp/nDhp7gU8wnE88WpnO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CgfVyYdDm7W0Phrw2IQ6ixDwf/2jGxuEHaNpFkuC9LGpQePoa
	Ln0JbgGCT1zSQ5SJaT5djGozMEA6UkwU9UEFLZmYcAMHRI73/1hcaJhC
X-Gm-Gg: AYBFou3lBbH8Pjxa4xsIWlus1rd90+bfmwKcbRuZdX/aSTVRdASyuDcUIaYSpUihMz1
	LVKAbJxfphhMv9cD2zcaAz//yfAc4uQLAKj1cjElv39FiAB5XEkOEJY+ZHXfTbb0I4nEGg8/c4M
	M0a/XVUTu3MkHW6j5C5ptVPBNlPmUdvzhLcFbcANvN8KDcWVFGjg6nwJjzouwiufaT9+m4JE333
	jux/RNV28Sw50ev5mjIjtR9wFfZDdwG+wQYs9psx5RK/OAZaOajVuTS5guKGr/GcJsjn66NN9TZ
	ogKdtKVxPONsl+L8qLrh4dH7L5NZBkOS6O7Hr+ZJ049gwnkcAy7cbhtml5ClrEs3AeNzLPmCzdA
	GOAciGsNP/kFdPWCCVFG7/x2yhp5kphLb2G8GsNMhKFyDDd6EpXMVlePLTnindFZJ5FRrD6G79K
	nHPieZ8twb9sH6zeRg5DyeMEVFQpRzbujfeuyLB1VFewT2BQ1NGcBhWiMy8d1gawrqjEeBtTFQ7
	TFpxYPD/SvTXYSXEoP42WLqs7MnvYSHXLiFRb9Bir/3CERwH3Ygd2UC+MJm+HIbfqYNaZcIr9pS
	wlTnkRlRNa2dztvmR5Fo038VcMCUq+GX9cuaagt6q57QCg5HIuLDVNYUDKIu/CHK5UzQ0Z6ve0H
	LaIIApGSw4ynuUzNpDFa+oxc9KQNTIehz
X-Received: by 2002:a05:600c:890b:b0:4b3:8529:eb27 with SMTP id 5b1f17b1804b1-4b38529eb48mr43679715e9.27.1793751079216;
        Tue, 03 Nov 2026 16:11:19 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa38bb4asm97050455e9.6.2026.11.03.16.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:11:18 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring] io_uring/zcrx: don't sync for cpu dma-bufs
Date: Wed,  4 Nov 2026 00:11:10 +0000
Message-ID: <2cf944dd571364e249af5fefcab07bc670bce842.1793623006.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma-bufs follow different from normal memory rules, we don't need to
sync it for the user. If the user space wants to directly access it, it
should use proper primitives like DMA_BUF_IOCTL_SYNC.

Fixes: a5c98e9424573 ("io_uring/zcrx: dmabuf backed zerocopy receive")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6d7abb1636e7..17e554bb774f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1425,6 +1425,8 @@ static int io_pp_zc_init(struct page_pool *pp)
 	if (pp->p.dma_dir != DMA_FROM_DEVICE)
 		return -EOPNOTSUPP;
 
+	if (!ifq->kern_readable)
+		pp->dma_sync_for_cpu = false;
 	refcount_inc(&ifq->refs);
 	return 0;
 }
-- 
2.54.0

