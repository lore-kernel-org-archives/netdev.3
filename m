Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDBB3FF8BD;
	Fri, 24 Jul 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905718; cv=none; b=B88VTanS6Y9YcVJdiKUFnUo+/JbYvBSjCEjSpu68agPCDYmhvdbZC9tMbiRwZmdLKMIhmpddY3LTpPCvEsJu6rZkDFE4ltf6WYMk1NHcQmlqeQEPmi+yl5P9OavBD7JA4JbMKC6yU4RdFLnQaCNsQyAEDrcukCEewkd2ai+H2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905718; c=relaxed/simple;
	bh=3SkkbWAHZ44yKX9jj1iaFPrM5gTTgG5GkMdd/7wKq8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JoEys0AcWvXmHQYSPLaFpLLVxgpP+u1vGlpxs2iSmDvHfwhbwOoy9hLoWty/hQAljW99vr+hIiVB40c75KXMtD8OsmxXK0NKPwCYvBxnWgQHZciEbxd4QTSmNkOOoNKAqIsEOSjTke7kXxRVMsEotf1MkbDvifHNhEtNFkkPpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=R384tLAg; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="R384tLAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5l
	M3VVmgtAFAwI9A6tH3iBig09bLzOPg/hgYP0ILHB4=; b=R384tLAgdrjnQp71rf
	ksXrwZ/MgpAQ9Xa284BhhXkpscPQ7LMVBq6tN5dPzTD0dzaVTA1/jFxa4IxM48JO
	l9fPjUMHIZm9IuUK2Tf7IwPikyQwdR/AvepS4JQQSzk1l/woiZPTDg3Q3JpddFB9
	XuhvBmchA9xl1/oPfq0pwMRJo=
Received: from zhang.. (unknown [])
	by gzsmtp3 (Coremail) with UTF8SMTPSA id M88vCgB3v_+zf2NqHKYABQ--.4454S4;
	Fri, 24 Jul 2026 23:07:34 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: [PATCH] net: skbuff: Fix misleading comments for skb_put() and skb_push()
Date: Fri, 24 Jul 2026 23:06:59 +0800
Message-ID: <20260724150659.6100-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgB3v_+zf2NqHKYABQ--.4454S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1fXFWxJF17JF43CF1UGFg_yoW8Gr4rp3
	ZIkrW7Krs7G3y3Z340kr4rXa4Yvan5JF4rCF42k3W5AwnxKr4FgrWvkr40vr18GrWxua45
	ZFnY9ry0g3srZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIRaAQWpjf7Z-VAAA3d

Both functions only move the tail/data pointer, they do not copy data.
Update the function descriptions and @len parameter, so they can accurately
reflect the semantics.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 net/core/skbuff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9..35ad782ad 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2614,9 +2614,9 @@ void *pskb_put(struct sk_buff *skb, struct sk_buff *tail, int len)
 EXPORT_SYMBOL_GPL(pskb_put);
 
 /**
- *	skb_put - add data to a buffer
+ *	skb_put - extend the data area at the tail of a buffer
  *	@skb: buffer to use
- *	@len: amount of data to add
+ *	@len: number of bytes to extend
  *
  *	This function extends the used data area of the buffer. If this would
  *	exceed the total buffer size the kernel will panic. A pointer to the
@@ -2635,9 +2635,9 @@ void *skb_put(struct sk_buff *skb, unsigned int len)
 EXPORT_SYMBOL(skb_put);
 
 /**
- *	skb_push - add data to the start of a buffer
+ *	skb_push - extend the data area at the start of a buffer
  *	@skb: buffer to use
- *	@len: amount of data to add
+ *	@len: number of bytes to extend
  *
  *	This function extends the used data area of the buffer at the buffer
  *	start. If this would exceed the total buffer headroom the kernel will
-- 
2.43.0

