Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4094D9909;
	Thu, 23 Jul 2026 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819359; cv=none; b=euMNl5pdJ7ucOSOZo6sZDZlZjDi5KpynHtKeZBFqqbeNQLsxILdA2L40A+BG7FJtF6+2/PWRa9nessZCVDuGNDlQ6Aaz77kZ8YgHvsLRLNUoISK7t32ctX+7nFltsV2RqI+4sVBnIpxKYwyDT/A1o4sn5imZryj81dlkaDIyHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819359; c=relaxed/simple;
	bh=Ep7QIHIwqR5kXmbBPDYoJBxX/hv9X5V/FBooHT5EH+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBfW9rjYfsZ15VQDwBlox26QFr3k/sI2sOrCH85DkWSnmD92HBysGsHGavlZFT/rwY4gfRku4N4kbTs2EboGstfT3qVJQd4pRdoFM0AKissSuuxWPhdr9XS3vHN82RCszf/KNf/zOVUiDWh5sf03gQKsdpThWxeAsFbVIKdDH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gfkhGFeD; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gfkhGFeD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Vx
	AgqF8QnmdJqXaOwIDkeV19kvytxzOZ8ULPDgp+m4E=; b=gfkhGFeD3FJIpK+gVi
	FzvjxcBzEXWFiRlwug5SxTCeJ9jS5ruOlA74jLTxwkwD0PGww1xGZ4DKC5H1CA7j
	DZ1bU3o6RmlW7RwDAAYq/K3X4GWqDfBo207scTO7gwh+Ys3E0WWXTx5HADbdQshV
	7asizqNN5NLiu9E5hCzqYy7vQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with UTF8SMTPSA id M88vCgCn7v6DKWJqBiDxBA--.3163S4;
	Thu, 23 Jul 2026 22:47:33 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: [PATCH] net: skbuff: replace magic number with macro in skbuff_clear()
Date: Thu, 23 Jul 2026 22:47:24 +0800
Message-ID: <20260723144724.6492-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgCn7v6DKWJqBiDxBA--.3163S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1kJr1rJFy8Gr1xCw1fXrb_yoW8WFW3pF
	1DK3sFqFZYkF4I9rWxXFnY93Wrtwn5KF47Za1ktw1rAr90qr1FgFyvyryfAr45Jr4xKFy2
	yrnFvay3uFnrArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNAaeX2piKYbF9AAA3l

The number 128 in skbuff_clear() is to split a large
memset into two smaller ones, so the compiler can inline
both calls instead of a single memset function call.

Replace the number with a named macro, so its purpose is
documented and the value can be easily adjusted if needed.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 net/core/skbuff.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9..e3f8a93bd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -228,6 +228,12 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
 #define NAPI_SKB_CACHE_BULK	32
 #define NAPI_SKB_CACHE_FREE	32
 
+/*
+ * For offsetof(struct sk_buff, tail) == 184, the 64-byte loop in
+ * memset_orig() runs twice (2 * 64 = 128). Splitting here for inlining.
+ */
+#define SKB_CLEAR_INLINE_CHUNK_SIZE	128
+
 struct napi_alloc_cache {
 	local_lock_t bh_lock;
 	struct page_frag_cache page;
@@ -319,10 +325,12 @@ static inline void skbuff_clear(struct sk_buff *skb)
 	 * with two smaller memset(), with a barrier() between them.
 	 * This forces the compiler to inline both calls.
 	 */
-	BUILD_BUG_ON(offsetof(struct sk_buff, tail) <= 128);
-	memset(skb, 0, 128);
+	BUILD_BUG_ON(offsetof(struct sk_buff, tail) <=
+		     SKB_CLEAR_INLINE_CHUNK_SIZE);
+	memset(skb, 0, SKB_CLEAR_INLINE_CHUNK_SIZE);
 	barrier();
-	memset((void *)skb + 128, 0, offsetof(struct sk_buff, tail) - 128);
+	memset((void *)skb + SKB_CLEAR_INLINE_CHUNK_SIZE, 0,
+	       offsetof(struct sk_buff, tail) - SKB_CLEAR_INLINE_CHUNK_SIZE);
 }
 
 /**
-- 
2.43.0

