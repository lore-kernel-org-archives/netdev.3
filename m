Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA148460
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662185; cv=none; b=bf6L2ZAp2TIVsSFIfga7LZkxvcONg5MLqsZzaQXZbiK2ueRclZHgidGl0uhhZsWm2bA7JEKcn6YHoX/TkgjpkAdpBS2qxvHOr4W7HuwzBTPiEc9Dpce/f5DT8pLF0x4ekPCyUpeFFmPbohajT+9jHx14cV8rvAXrZSQm7nq5XRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662185; c=relaxed/simple;
	bh=t2nRP0VEBjoAykAAoJ4oNQ6spfklBcCjwKZn2cex6/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWCXXgbhOLzOfYdudYpxXpY4096eJHus3lW/PS04YPy0f/AnQkjxBpWWW29ASb1+YSqi2NryYu8r67mKNbnL0VkXaOwFtBQ8IMyzQW6KthxdfNuhbW7JWkWJAptgeDOKrd8nOjOHrEd1+7MXWht6ez0e1SIzfNayNJxtGkKHCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJBRxOVL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJBRxOVL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ee6d32402so1025122f8f.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780662182; x=1781266982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwKzwPDvG1cFhc0LM4+dg+6HLT8lqaSdVjB/A31B/ic=;
        b=GJBRxOVLd7WeMDxyB/uCLdlmJcasDp1rEvBSnz+JG2JV73s9boDctodLOE2lS0uc0V
         7F9lKgKkdOyW0s3g31GzTbl4ykmU13y9NE8h1DtRCX/v0VNRTjS6ux1XredD63KBQcDd
         ms+Tfo9tW32OliScHv+9c3p9RuFDrMaIRk3Byexch64EE3v2/oRJFE3m/sjk/j5+vNbh
         uCrK6GfGr41wi4S2SffIghkdBs4kmP9QNyvDiRedxsY+wWsjBWR5Fx3wpeMobjhlzR2I
         fif4YYZmVfRhAvJmmud0So26uju0LyCiheyMakGP5U5igSaheU/JGBdKA19OjZ27Q/rf
         l0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780662182; x=1781266982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwKzwPDvG1cFhc0LM4+dg+6HLT8lqaSdVjB/A31B/ic=;
        b=ArmaKDrtR0xUjBbper59Y5o6xCa54UlhFoExOQ8lLfMPWixMUad/x58L1NK0pJz/SM
         ZAwYfusrC2PUChum29lHnAHzjYxBxTN1OOFC6XWKnOYl4FV0NI+QzM7pEvCBdnyAbt+w
         hNcPlX1GDfzH3KVF5yOXpW60a2xJ/33iqx0XXpvV7Uyla15oQV2UbsOBTgP979/QcI8y
         IsjHrGRHXa/ezkJzK7p2kTi9YRYAOa6984gGL/toeWYfNV4EdtlTbXLC9IvVLpJFngsJ
         qDhK23J1XqTADPcQtm/gfpAdCvbd/cL4TmUwnAsvzAHAP2bjMwzwLSUjpqYNSGyIflkU
         W/Qg==
X-Gm-Message-State: AOJu0YyQkH0Io0hK/VarvCn9+j/FuRzWgycGfW6nT5D3JA3n7cm0VGFJ
	/Juh5WleTsFSGyKpGEVwyAGOPIc2MQnu1NvkGEnGG0fg8ODFQtClfRSzGV2YkZ8s
X-Gm-Gg: Acq92OGdO6mDlu3rnzE1TrbLFh+w2NqG282ApF6BtSXjjygz31COpibrHvBg9CHXz9C
	4topCEVXw+Fb+DEW09tMmddf/Dp5iUl9v6OjLhB3TcPzYslHXSQxXePlzv421j0Z7BJ2rvql0Jy
	+nQYIuCUhTHhXXmlM0fUCbqiQH/k0JoIyrs8C+2jXBPJ6oeF7zVN58HTx1rvAxBmIm8IpW12fzY
	Qpu5+dHa7cGSLVhOGs88X2y0fQtIsqOF+XsuTRsw6GmKcgnhHUi+FIwLPZYhwBmI6dwfGk+xNCB
	vt/ZohtwqKzciz3D1ak0diQe5vIamhCbz/1QKqX2lu7yRkZF5WOzOIqzPErY+AbQdllamyQODUX
	21nxFQyUgkyYgPvA0PusDbRIMSU4euqxsKH2iSseLt2nKuf+hSvKy/t9EPMFJzcO8sf3WwF7eCL
	n0d16Y4uA39u8oQvqAzOVe6M4gku2wMcaWm48RADksw4aoQFoH3sU1ej2rwD357pTSv0y8x9t9r
	O3rn1/3VgGYhYuWw5k2G5NDPN+YTvzfkKPRfBD2qq1xEZq5gXAW1e6pqSUwLFdSwh661WoRrsaj
	gg==
X-Received: by 2002:a5d:690b:0:b0:44d:1338:46b4 with SMTP id ffacd0b85a97d-460304fad8emr3981968f8f.9.1780662181843;
        Fri, 05 Jun 2026 05:23:01 -0700 (PDT)
Received: from localhost.localdomain (host-217-59-207-212.business.telecomitalia.it. [217.59.207.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm27808021f8f.5.2026.06.05.05.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:23:01 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH ipsec v3] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Fri,  5 Jun 2026 14:22:15 +0200
Message-ID: <20260605122215.825-1-7991aleschino@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In esp_output_tail(), when esp->inplace is false, the old skb page frags
are replaced with a new page from the xfrm page_frag cache The source
scatterlist (sg) is built from the old frags before the replacement, and
esp_ssg_unref() is responsible for releasing the old page references
after the crypto operation completes

However, if the second skb_to_sgvec() call (which builds the destination
scatterlist from the new page) fails, the code jumps to error_free which
only calls kfree(tmp). The old page frag references captured in the
source scatterlist are never released:

  1 sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
  2 nr_frags is set to 1 and frag[0] is replaced with the new page
  3 Second skb_to_sgvec() fails -> goto error_free

Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
unconditionally unrefs the source scatterlist frags. Since req->src is
not yet initialized by aead_request_set_crypt() at the point of the
error, the source scatterlist is obtained directly via esp_req_sg()
Existing callers pass false to preserve the original behavior

The same issue exists in both esp4 and esp6 as the code is identical

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
---
v3: regenerated on top of the current ipsec tree; the v2 was a diff
    against an already-modified tree and failed to apply
v2: split the long line in esp_ssg_unref() to stay under 100 columns

 net/ipv4/esp4.c | 17 +++++++++++------
 net/ipv6/esp6.c | 17 +++++++++++------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 513c8215c947..dfc81ee969ae 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -96,7 +96,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -113,10 +113,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+	if (already_unref || req->src != req->dst) {
+		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;
+
+		for (sg = sg_next(src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
+	}
 }
 
 #ifdef CONFIG_INET_ESPINTCP
@@ -220,7 +223,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp, skb);
+	esp_ssg_unref(x, tmp, skb, false);
 	kfree(tmp);
 
 	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
@@ -569,8 +572,10 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0))
+		if (unlikely(err < 0)) {
+			esp_ssg_unref(x, tmp, skb, true);
 			goto error_free;
+		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
@@ -602,7 +607,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb);
+		esp_ssg_unref(x, tmp, skb, false);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 57481e423e59..296b57926abb 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -113,7 +113,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -130,10 +130,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+	if (already_unref || req->src != req->dst) {
+		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;
+
+		for (sg = sg_next(src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
+	}
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
@@ -254,7 +257,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp, skb);
+	esp_ssg_unref(x, tmp, skb, false);
 	kfree(tmp);
 
 	esp_output_encap_csum(skb);
@@ -600,8 +603,10 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0))
+		if (unlikely(err < 0)) {
+			esp_ssg_unref(x, tmp, skb, true);
 			goto error_free;
+		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
@@ -634,7 +639,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb);
+		esp_ssg_unref(x, tmp, skb, false);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
-- 
2.41.0.windows.3

