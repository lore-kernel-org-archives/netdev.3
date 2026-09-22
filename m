Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34F515969
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109853; cv=none; b=AiIZPdbloquYKF3qq6wzsDIejtvz4qBDi/vg06qQvUdh5NF/Z0eGgAYkH5qJTQfFxCPGlJlIMoRW/xdMu3R+NmZLtPTIHFluB+kwQKe8moahqj6NQoRrvbVeKpSvjEGRkXJqChWzWF3wraBCdV2zDCweJIdmzDSMl6xfVVPbHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109853; c=relaxed/simple;
	bh=OWLnRy0Kyd8FdV/E9+5Qi5HN1AFVDCBPd909vqVd4d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t69M60cPPBFtWl4NfmYQEf15Tx6+wS2xdhs8cP7x2td+hBar0+DTNcirzfi6RfgThYhJSgtFc53yOm4EjtdLwV2U1KPPtgLgO9xWs47Qwvz9F+EtLbdXyHIhAeZeUYg/VzhXVJtmYuvheqtXxCIDdGMHyGinT+NT9p5U5U5GVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsW/y3zj; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsW/y3zj"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd9bce707bso931355ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109833; x=1790714633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWtkhPsIR7rUvSSAcPaCXCFRGMGm2fhAVUCymwEWeyQ=;
        b=LsW/y3zjvB6uh21uuruh/Ri7fkZYm4WKusxPX4jKNVvoGlr21HDedY5cMenr46pwEP
         9/gfmdW0U9WhuDu5TEqyCnkVctLyU16gjfA5hLkTySocRoAwBlRyWpAW4bpIiipShmqe
         F5PlUQlbGF3jZZS8+Gc9zPvuCxBSMHAbxn/FQezpxhTqumXa+e9jpx4/zLPQdKIqqwDI
         uFHDF4yqYA5qK7zc4fW2wF5dd7kJReZRgtWKUHQ42DkW7eQ5vugrqLsQRYnrhJSY/wR7
         29Ags8MMbggZA1pmBWShQQCGLPrDUFBQRlt76jDkbKDHl7ebXPColxqRO1glX2ybNt6p
         GgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109833; x=1790714633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWtkhPsIR7rUvSSAcPaCXCFRGMGm2fhAVUCymwEWeyQ=;
        b=cWFwY2prVy3msvdRMZuP/QQR2PoHNp5bCSPWoHK2KneRnH9LHgyGg2Z+SwUwQZnUhb
         U9o9R4u6eQAYtJkpODqGQ3fZU/EJumV5UBgV553aefC/TwlCEfGeCUVxKRVOxtspUabv
         NLqw8kguFObrAPlRcwqZtMVwruEZGVHlwsN5TFEEVHjeEZpML7IRWge2WLaVuCf7h/0f
         aSBbvubqjh05WZZ8ZXxE01x7FwuMcPzRtRQ4HFzWERgphuFeSqsZtDmC4A0C8MXZgzrp
         8r0A7V4R0ET1gr9LiFoazrDNE0lshzcn2HAjv1pWZfToJ5Jy6yXg5olciPNQKGrXTE3T
         f8gw==
X-Gm-Message-State: AFuF++mmd9VMzL3BR0H6dp0w/VT9oizAFa0U8RZStS+ZEkla36xOVxBi
	Gr82sJbynsvFUUtQ04TY4SBmbuzBCDiUCwtYUOBUKwRdCh0T8sTG4lYLqOAxQyWR
X-Gm-Gg: AYBFou2qQL51yPj0T69sh5NG6gFp5BMZSOGsS8jdtf70jj7XQC45b/C13NrJoqZjy/o
	8qTe7QCGQCtX2IpW/rFPzVub9FuspIVYq0E5XGZgGG0YCjghn4i/aaR6t24neCqkin6FRdN8d32
	F2tz5bc315k69BJzQfrq5whPllFlxlI0rPeW3uRilkbMvIXyGZK7hlUU4SSFrKSZ4u8ODc5bF1d
	kD+dzAQTkBsjjurlZUIriImM2zoeoJliw4DzITcs5n/qpHsO+RB5mX4ybB5Eyd85Xdx5kidaAH8
	hc11CwSrIZN1RjKF8DAYogHY4JmQgEaxb1FEar1zq8ynqhg7lADSZoz9W9O22v6Bw1DVu6BQudR
	SwsFPMoEhB9knsVW23OJ14kE79sOElpXAnvNDqlx1kDxpLAr9jE1xqiBWdnwnhVAOdl3yXlAtle
	diuwrZyyMy7LcU2XjgtqtvVewmhBqZVKPGHKt8rCgCMx7XbqEWnc/LvZpaRwnxoQUGjUcsmyKol
	/w=
X-Received: by 2002:a17:903:1ac5:b0:2dd:c053:82f0 with SMTP id d9443c01a7336-2df69dc3fddmr4755005ad.39.1790109833271;
        Tue, 22 Sep 2026 13:43:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5f965esm879425ad.75.2026.09.22.13.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:43:52 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH net-next 3/3] net: devmem: decode DMA addresses for TX
Date: Tue, 22 Sep 2026 13:43:48 -0700
Message-ID: <20260922204348.717198-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922204348.717198-1-sdf@fomichev.me>
References: <20260922204348.717198-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit architectures where dma_addr_t is wider than unsigned long,
page_pool_set_dma_addr_netmem() stores page-aligned DMA addresses shifted
by PAGE_SHIFT. The net_iov branch of __skb_frag_dma_map() adds byte offsets
to the encoded value, so the NIC is programmed with an invalid DMA address.
This can trigger an IOMMU fault or DMA from unintended memory.

Consolidate DMA address encoding, decoding, and representability checks in
netmem helpers. Use the common decoder from the page pool and net_iov TX
paths so both interpret stored addresses consistently.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/skbuff.h          |  7 +++++--
 include/net/netmem.h            | 27 +++++++++++++++++++++++++++
 include/net/page_pool/helpers.h | 10 +---------
 net/core/page_pool_priv.h       | 14 ++------------
 4 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45451..3740d4b15b70 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3833,9 +3833,12 @@ static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
 					    size_t offset, size_t size,
 					    enum dma_data_direction dir)
 {
+	dma_addr_t addr;
+
 	if (skb_frag_is_net_iov(frag)) {
-		return netmem_to_net_iov(frag->netmem)->desc.dma_addr +
-		       offset + frag->offset;
+		addr = netmem_dma_addr_decode(
+			netmem_get_dma_addr(frag->netmem));
+		return addr + offset + frag->offset;
 	}
 	return dma_map_page(dev, skb_frag_page(frag),
 			    skb_frag_off(frag) + offset, size, dir);
diff --git a/include/net/netmem.h b/include/net/netmem.h
index da885d95ea63..4e06a647620a 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -384,6 +384,33 @@ static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
 	return page_is_pfmemalloc(netmem_to_page(netmem));
 }
 
+#define NETMEM_32BIT_ARCH_WITH_64BIT_DMA	\
+	(sizeof(dma_addr_t) > sizeof(unsigned long))
+
+static inline unsigned long netmem_dma_addr_encode(dma_addr_t addr)
+{
+	if (NETMEM_32BIT_ARCH_WITH_64BIT_DMA)
+		addr >>= PAGE_SHIFT;
+
+	return addr;
+}
+
+static inline dma_addr_t netmem_dma_addr_decode(unsigned long addr)
+{
+	if (NETMEM_32BIT_ARCH_WITH_64BIT_DMA)
+		return (dma_addr_t)addr << PAGE_SHIFT;
+
+	return addr;
+}
+
+static inline bool netmem_dma_addr_fits(dma_addr_t addr)
+{
+	/* We assume page alignment to shave off bottom bits,
+	 * if this "compression" doesn't work we need to drop.
+	 */
+	return addr == netmem_dma_addr_decode(netmem_dma_addr_encode(addr));
+}
+
 static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 {
 	return netmem_to_nmdesc(netmem)->dma_addr;
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 87a4e13886e1..cd021832c3fa 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -408,9 +408,6 @@ static inline void page_pool_recycle_direct_netmem(struct page_pool *pool,
 	page_pool_put_full_netmem(pool, netmem, true);
 }
 
-#define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
-		(sizeof(dma_addr_t) > sizeof(unsigned long))
-
 /**
  * page_pool_free_va() - free a va into the page_pool
  * @pool: pool from which va was allocated
@@ -427,12 +424,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
 
 static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
 {
-	dma_addr_t ret = netmem_get_dma_addr(netmem);
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
-		ret <<= PAGE_SHIFT;
-
-	return ret;
+	return netmem_dma_addr_decode(netmem_get_dma_addr(netmem));
 }
 
 /**
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 2fb06d5f6d55..430b97cd88da 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -18,18 +18,8 @@ void page_pool_unlist(struct page_pool *pool);
 static inline bool
 page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)
 {
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
-
-		/* We assume page alignment to shave off bottom bits,
-		 * if this "compression" doesn't work we need to drop.
-		 */
-		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
-				       << PAGE_SHIFT;
-	}
-
-	netmem_set_dma_addr(netmem, addr);
-	return false;
+	netmem_set_dma_addr(netmem, netmem_dma_addr_encode(addr));
+	return !netmem_dma_addr_fits(addr);
 }
 
 static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
-- 
2.53.0-Meta

