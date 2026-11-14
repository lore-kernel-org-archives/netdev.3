Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628868;
	b=1flUSngfT6zPJUsrq9bDoeQYE7bbJotDpC3I7NsE6m1AoZQ793toxgAPJ81h1ZRbCQ/6
	 pcDaxa8NVcL/F4gHP/TLAnteRypn26ly0cbAXpq3tcMwPmDvknmtNbVErkdV8B1ZajXfJ
	 wmvCVB7IKXu2HZQzilB7pSkbPZQJz4VcHCSfLBj+uaocco140iAo2JQUreIO38qbFVAYD
	 jRndyZqMUyNPXChRBQXSl9/W1JQ5Ru8Uuj2eEqX+HEI/i9OOlzccYwaR9huB2CDh/1oSt
	 ByqxIBBbAJa7sjwhFXSSs+NydZhZVDonB2rSeoPhVl6LA+wF7YHxRmTG0YVrIYinElg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BN9IctddKIieganRx1MQ7ZF4ilx8imwl4pBmCAWf8gQ=;
	b=HReJPVpd96Iu1eUG3R6soy6pKSxBaMof2Z7F5MYdW2aKdc4mwGzl7rqvGX1jmRkrinan
	 2z0LtQdwj1uwJCGwVCBVKJQde5QgEeSDIEMdg+NS7kL2y9t0cSBju7cECVa0BUrjlBzEh
	 fszm8l/kl0bC2+lRSe8NEvmJBAhkWUAxn3IyjzlCeQfeRHLPWE0rxMKvvcH/RZMvrBgXv
	 gA4aYNGH0/i65F1cNnX3Twbk/YE+UI3rSBo/7EVB8dXpc9AZzawTCUvLAFTHVBeqDaTJA
	 hEe7p+9KXLz2yE+kQbvQ0nZFLfQjNiT2p3XC1rRutwJJWi7NCDxvYiBjYF22ysln+sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZVqZDssz;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEB606A894
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61BEB606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZVqZDssz
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b32efd7ec4so1650915b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628867; x=1795233667; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BN9IctddKIieganRx1MQ7ZF4ilx8imwl4pBmCAWf8gQ=;
        b=ZVqZDsszswdx+mO81JtkmxbulOlpLsSUBmQcYxCI9SsV3h+aUbdTik5o/oWWEfKgc1
         nBQ8oLchTg1TE6yVFVwfNX/jhr8ckGVwxiCHtMMfVa5TSz6qMSwFsdByTaq5NeyoY1+t
         ffUZ71Sjnz/m0KaVqwuRmDsXt6tq8JbfJuIRAbQ3r6F8jKDJDtEXJr+UqdfpFVXNXLkZ
         BkmbPfPl37JnepHi+g27BDKMH5a3Xu/wvXsILvwqlohycKjEAWq/GE0PV3dBl9RF/rb0
         V/Hg4xF2MF+tY6O1xYBaqvQrGDN5n/yQ1kIvtO+vA/Vq/PBo7dLF4wbD+lRvK5wYCZMJ
         fv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628867; x=1795233667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BN9IctddKIieganRx1MQ7ZF4ilx8imwl4pBmCAWf8gQ=;
        b=s9WQqZmcT+FjuqMRpLFv4h9U+P0au1z4d+p5AlnCw0LcJyr49e8Pu8kiwqr+r8CAcP
         o0iEWKxCXoAHuReO8IaBWKzA8niCZvcSp6UDRU5ixEkLq6lJxf1nkSMoRyNE9A68JVWj
         wDqqeGI3hXCWZ6GCsQE53oa5Ixkg8i/WHtdMCHREGlgJELZwTTGeVJ9m/XHK/FPPxado
         UYXbtzV9bvcz7/qO/PkzeVG1YQyfh235ayQ0NmQY861F7IiWOnAgr7z0mG75SGTg8Zhv
         VVSol7wra1Sis9qB38icEE0CTJzbiCpGGx0a1Df1OAxlu1/AAIVc72NoS1e2YjWEslfx
         F8xw==
X-Forwarded-Encrypted: i=1; AL+hErG+wKEmUQaI0kVXOTU63sWY3mjCxU6ymvyZ39dTbuYUm7JhoF4AKnvZWqVuR4w3L4NNCFo7viQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9axXz8ROW2iQyPmr5Od1eUQJBsygu8r4+jmFU3CkK9+ncqrM9u
	onlsSUBXHrNpy7gdaEbobvLBIrC3epndhjA1qARBTdRiItPFfkw3d++PG1vMkMHHCm2LtDk3n8a
	XdJ5FOg==
X-Received: from pfdc23.prod.google.com ([2002:aa7:8c17:0:b0:89d:3267:4348])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c6:b0:898:9b2:605b
 with SMTP id d2e1a72fcca58-8beb7b1affamr4542982b3a.56.1794628866461; Fri, 13
 Nov 2026 20:01:06 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:47 +0000
In-Reply-To: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261114040101.1043546-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114040101.1043546-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/8] net: Move SKB_SMALL_HEAD_CACHE_SIZE to skbuff.h.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch needs SKB_SMALL_HEAD_CACHE_SIZE to precalculate
skb truesize for tcp_collapse().

Let's move SKB_SMALL_HEAD_CACHE_SIZE and its dependencies to
skbuff.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/skbuff.h | 18 ++++++++++++++++++
 include/net/gro.h      |  3 ---
 include/net/tcp.h      |  1 -
 net/core/skbuff.c      | 13 -------------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1d6832878930..d36fbb88b3f6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -269,6 +269,24 @@
 #define SKB_MAX_HEAD(X)		(SKB_MAX_ORDER((X), 0))
 #define SKB_MAX_ALLOC		(SKB_MAX_ORDER(0, 2))
 
+#define MAX_TCP_HEADER	L1_CACHE_ALIGN(128 + MAX_HEADER)
+
+/* This should be increased if a protocol with a bigger head is added. */
+#define GRO_MAX_HEAD (MAX_HEADER + 128)
+#define GRO_MAX_HEAD_PAD (GRO_MAX_HEAD + NET_SKB_PAD + NET_IP_ALIGN)
+
+#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(max(MAX_TCP_HEADER,		\
+					       GRO_MAX_HEAD_PAD))
+
+/* SKB_SMALL_HEAD_CACHE_SIZE is the size used for the skbuff_small_head
+ * kmem_cache. The non-power-of-2 padding is kept for historical reasons and
+ * to avoid potential collisions with generic kmalloc bucket sizes.
+ */
+#define SKB_SMALL_HEAD_CACHE_SIZE			\
+	(is_power_of_2(SKB_SMALL_HEAD_SIZE) ?		\
+	 (SKB_SMALL_HEAD_SIZE + L1_CACHE_BYTES) :	\
+	 SKB_SMALL_HEAD_SIZE)
+
 /* return minimum truesize of one skb containing X bytes of data */
 #define SKB_TRUESIZE(X) ((X) +						\
 			 SKB_DATA_ALIGN(sizeof(struct sk_buff)) +	\
diff --git a/include/net/gro.h b/include/net/gro.h
index 7a19d4486456..4eb755c33a26 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -11,9 +11,6 @@
 #include <net/udp.h>
 #include <net/hotdata.h>
 
-/* This should be increased if a protocol with a bigger head is added. */
-#define GRO_MAX_HEAD (MAX_HEADER + 128)
-
 struct napi_gro_cb {
 	union {
 		struct {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 25d11fab1b03..9fcc5e5223f8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -67,7 +67,6 @@ static inline void tcp_orphan_count_dec(void)
 
 void tcp_time_wait(struct sock *sk, int state, int timeo);
 
-#define MAX_TCP_HEADER	L1_CACHE_ALIGN(128 + MAX_HEADER)
 #define MAX_TCP_OPTION_SPACE 40
 #define TCP_MIN_SND_MSS		48
 #define TCP_MIN_GSO_SIZE	(TCP_MIN_SND_MSS - MAX_TCP_OPTION_SPACE)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2e81aacc998b..421776e3526e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -105,19 +105,6 @@
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #endif
 
-#define GRO_MAX_HEAD_PAD (GRO_MAX_HEAD + NET_SKB_PAD + NET_IP_ALIGN)
-#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(max(MAX_TCP_HEADER, \
-					       GRO_MAX_HEAD_PAD))
-
-/* SKB_SMALL_HEAD_CACHE_SIZE is the size used for the skbuff_small_head
- * kmem_cache. The non-power-of-2 padding is kept for historical reasons and
- * to avoid potential collisions with generic kmalloc bucket sizes.
- */
-#define SKB_SMALL_HEAD_CACHE_SIZE					\
-	(is_power_of_2(SKB_SMALL_HEAD_SIZE) ?			\
-		(SKB_SMALL_HEAD_SIZE + L1_CACHE_BYTES) :	\
-		SKB_SMALL_HEAD_SIZE)
-
 #define SKB_SMALL_HEAD_HEADROOM						\
 	SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)
 
-- 
2.56.0.611.g1030f0b940-goog

