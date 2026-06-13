Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3841F94F
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309418; cv=none; b=dg5wqLpiekL94LYWWz/NUkLKCGiGDWGSiDPm8QaGID8PGhuzjpljdz9CNGA4xQcYMAg6nVMnkV8tNAZG0kkKamaVq1oBnmEbzZ7enSAl+0mb6SsLMwPGlY59SkVEfbJhMCPerS6kG1qOJDZ9v1fE+Q9D8KCwf+O2aWYmKfeVgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309418; c=relaxed/simple;
	bh=c0Q49lpbntXNXsuLl1k74yDPvD9eCdJopUkpac70rjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGFJB2jDXM7tEBXQMRqLf0s5Y7r6shut+KGCDDaht2lKH2eRhOuQ4SufAGjNRRIjxZf0Zcs2dMCCg8tPt3LFjEmzUk0bB5WIwBi4ugHb+phTRFDpek4e6fTcfF75fId+PWmsttnma5BJTvGWt3tt5luhiqq9zlIJ7N2ouI9NubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DA2CCMNE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DA2CCMNE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422a0eee68so1990701b3a.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309416; x=1781914216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/YGgUT7Uc36MorqsAsmMwEDPJGbRICV4QU2IwdKQo=;
        b=DA2CCMNE18tSTB8R2nZCGKO6vpDH4JpNW8vPFx+u3kEtnmopDWTIV4lHu8lgS7DyZ9
         o6M6xKIdHWo56ECXSMATCvNaT78iP9g5DfxoEH+SP7Nc9lMToT4ierR9HEsn98Twapdc
         i6BLj1o2RfuGoy7HNvmJX9LiQvUcHw6yqo2bz0HaYSqqRE53CvYt2LDeAtYOHdsEOqt9
         xncte5BnWZLX0y64rT7A+3Jaq4Chkb2L8AMbrPn28IyLPtfEfljTouWfd7ZFWmOZTuyh
         Y3d/IjOOfNoceMZFji/bcQe5mrdZQ1csh1jIY16SLCRRt4edTFjIr5n3vKBC6/rD/D2o
         WLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309416; x=1781914216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/YGgUT7Uc36MorqsAsmMwEDPJGbRICV4QU2IwdKQo=;
        b=ki5ts2eWbZ8A1rdFOIqKgmc3gRCikpA1auYwvkMcU/bQe0IKSW+8efqzeZUW5py1pe
         k0rCJRPIMLZoBY1YKLzKtRcJQgCV5aH4wbA5HDReUSt4ARXCQAxpwjYmdy+R8mcv9Ans
         t3R5HHto3egQypl83GyiXC+fyfwSUzZfm06DbYNGjTssn30ie6li1ky2z4nu02bFgvCN
         1Z7YYq+8KNbH1euIFy5EPlgC49IOvwQorohtsbjA7Yk3MRdScWnpIs3mbRxTlEf078As
         771wPSFVRJa7Gd07i4AyO5oLqWdsLdgBz2ugRih8jWG8LXNKBFPaWp6xDI25X/MmK817
         kpWQ==
X-Gm-Message-State: AOJu0Yz7QUtsmztunjSP7aOU3I1Isr7s3WGqvUAOrJ6RK6/OBSe9iDqB
	dfIjGzHMuIQdJ+G4WOM1axiXM8ho6IltdTWbBCAMEMAZsMBr/nHwA10lC3pCUBnnA6i5SS/7rl1
	8b+r3S/ZE4GVBismx4TrBReHmrThGqoeiqNqteZFdZ7vDk/Spaa7DmnkPmBX25yI82A+D0bZiYN
	47G6xtYQE+1cP0O38pjs0cNGeuenE+dA4=
X-Received: from pfra26.prod.google.com ([2002:aa7:8e9a:0:b0:835:3df8:d72])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1404:b0:836:3f6a:3e77
 with SMTP id d2e1a72fcca58-8434cd4b0abmr5407830b3a.17.1781309415402; Fri, 12
 Jun 2026 17:10:15 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:09:52 +0000
In-Reply-To: <20260613000953.467473-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000953.467473-1-tavip@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000953.467473-2-tavip@google.com>
Subject: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Export iov_iter_restore so that it can be used by modules.

This is needed by the virtio vsock transport (which can be built as a
module) to restore the msg_iter state when transmission fails.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af73..067e745f9ef53 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
+EXPORT_SYMBOL(iov_iter_restore);
 
 /*
  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
-- 
2.54.0.1136.gdb2ca164c4-goog

