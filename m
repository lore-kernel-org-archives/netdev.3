Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CD350A35
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753694; cv=none; b=ntPwssXzCnYSSAQBc4iiDQb9+M+PcOJkI3BIEmsxBEjbOFJ/klOr6/Y7vNXp8Xph/BwDRoSIggDlXitS7hyL7cZgZaW36wCnndWrDUK+zdVOPQKukp9L/esq8zghIglUtczTYZmARfN8xtKVyE2FRcQqzG88saEhsrE6ESepRug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753694; c=relaxed/simple;
	bh=aP9eg7JNMr+Sqf8a4611CWNsVBnZSrZOf6AsEfqwacc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sc+qKbddnetQu5VuY/zobOoQ/XnatASos2rkYrMtcfnMAyyknj5zd9BWmPRtsINHi5pT50l80wsowC2x4Mx2Kx+TFKDBxtbOQ03GU66xjOBVPjFXEP6YwbcuBLwTwl19tcXuvuNF4oFSV72VaKGnvThjdzskpq1SJ9JLpTaVYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btm8F3fg; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btm8F3fg"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so10295930a91.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784753693; x=1785358493; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NVoj/2YG159LTraVREbVbsYae4F1QoabgYd8//PdHa4=;
        b=btm8F3fg6l1Dynid2Rq43QzJNN7vLq140tsr8vCA6+SWqq0PFyHZ1tVI7TxVkyLUeu
         OXBR+SEIkexWYEmKp+3WsfMiiI5gCVXL3jWAhsKcyk3ibSWLwdUG0vgknddXafvs0Zpy
         viADIVxivzmPlFM08fboV1ouHsjRxEtXkSAXGyHZpBWS4P+/496ZP6h4UjE/bmPe2eHj
         yJ4GD0XgsSdsYjrgkkfxCjEJsFYxyNrQJHSRsfVLsmu5oKDlDLpsMNKRvr7z0fYtraKf
         aGSiKRqzx2VWEB2t3Ig3d6AAXkh2evaPf2l62YIxZDhAJuhfc94OFnlyiPJz6xqZn5yi
         aFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753693; x=1785358493;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVoj/2YG159LTraVREbVbsYae4F1QoabgYd8//PdHa4=;
        b=pQdf0U4ORNkg2T4pzf/KbGKrrIYaNzgyE8/IIu+6KlNUpbwbp1H48rmuUsaiqnhdYJ
         gqS+N0LFQl4SjdD8Pvz6VJbgIcPHq2Ej70wwMeCgVexJdTZi7Y4Xt02usEuTjMTfzKKK
         TNqzGMF0KC8+sm0tTB7ctHWpgqAmMKBrh+D5FXhRJ2WWqzthq2iGoqWcZdtOsXxfSqdI
         ydWXnQst/jaFWFzj5Ycm0DxH6zClIVgB/SjXgwQVyzQmlrHTgV34Oq+wIXEH6uQJ2540
         e4fZ5QSE9cawKEcJuOVKFHrDDRd0KrhNpXIXxJEO/2qYW1dz4iN4ODkAa1Gh404IfUQs
         D2Gg==
X-Gm-Message-State: AOJu0YzQNa5nAnIwVglpHIDL/5fHZQ51pxSUgduJV78tmPk4q5ZScvqD
	+elX6f5JyqYqyOF7Gp8WW0QyqfzDsdd3JR/xCDnkVyTnRK7A2TKujzsULFh3O2K8rau8AhGvECF
	aXS5w94bNuPywNdUUEg==
X-Received: from pjblr2.prod.google.com ([2002:a17:90b:4b82:b0:381:11e5:d204])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c0e:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-38ec648ac8amr292295a91.5.1784753692538;
 Wed, 22 Jul 2026 13:54:52 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:54:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722205442.1894665-1-tjmercier@google.com>
Subject: [PATCH net-next] selftests: drv-net: ncdevmem: Open /dev/udmabuf O_RDONLY
From: "T.J. Mercier" <tjmercier@google.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobbyeshleman@meta.com, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

Write permissions on the /dev/udmabuf device file are not required to
issue ioctls and allocate udmabufs. Applications should be opening this
file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]

Users are pointing to these selftests as examples of how use udmabuf,
and encountering permission errors on systems where write permissions
are not available on /dev/udmabuf. Apply the principle of least
privilege to selftests which use udmabuf by removing the write access
mode from drivers/dma-buf/udmabuf.c and drivers/net/hw/ncdevmem.c.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index d96e8a3b5a65..ffe1d5c1fa4e 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -150,7 +150,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 
 	ctx->size = size;
 
-	ctx->devfd = open("/dev/udmabuf", O_RDWR);
+	ctx->devfd = open("/dev/udmabuf", O_RDONLY);
 	if (ctx->devfd < 0) {
 		pr_err("[skip,no-udmabuf: Unable to access DMA buffer device file]");
 		goto err_free_ctx;
-- 
2.55.0.229.g6434b31f56-goog

