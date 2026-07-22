Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3483E2AB6
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693627; cv=none; b=XIqczeVwzXSQDvHv1kL5Re4PN6TAlMaMb2rg9mMu+xdddAJ1crqErq8YBjFxOvBKbsPT5vTUc5NrLCDhQxYruSVLJlL/sLeAuMfndhFPEXKrwDvebrOtj0YWKyOeSDk5Rl9/JPkubpJ04KWlJzkaIp5YsA/c+B3raIGrdUQwJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693627; c=relaxed/simple;
	bh=5Rlfb7IRvyZACUul8AbTPsLZ7MmRN3ZjmLL+2cCwNFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kn+7SbV+KZ5RRez5J3YsCDcG70WnnXwK8E4+tMLVZZeLvFMUpTmYtQsYUXDcDWQXHKPrkTX8vr9YsW9YYZqrXqymNZK7zqRJn/M9LrY23aQjc9cLyGKZBmRi3bs9OhwLZiVE3pCqb90ruPLtFXg621QZ9qQivM2s1rJSKAPGhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcKZCk1h; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcKZCk1h"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80c5cb9a888so100859257b3.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 21:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784693625; x=1785298425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eDoqtaAb2RoFtg3L+fFmgGxjGOb//nGgM08klsidJzA=;
        b=YcKZCk1hn1zXVP1UW/o/SIICTVOYCBa7YsiJUIuEXR3OCh9U8JpzOi+pCORrMY+gzo
         wWAicts28VTewRs+J3JaRIffwiP4YgZZIY9PkuBqdQWXaOME3ABymY3qXhyqwvLjpeYZ
         C9eG/V3yNYjz5PaJzYaqoVw5KO/dbJytGej0HgOBfaP+gES7yISnd8BOnHxNC6wUGhnd
         /HM2nyk5LWj358nxd5+PHymCa+wo2iO5gvkTSHHBRTCgVLORqkQm/Ltxe/PXNsiunsbQ
         vEQ5cxRGWZRVTKCrFLuS23fwTc8zFCGfj2Z2LLfbn8B8A1EXKMMLS/cHTp384sq5xYBe
         iLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784693625; x=1785298425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDoqtaAb2RoFtg3L+fFmgGxjGOb//nGgM08klsidJzA=;
        b=hgYSOM3WuMt+0U3jyyJlJpHlUNfMo2aMesikAcivOvYD8h+IdCVa0+eywFuKldb46V
         +g+p0swvwwc3MpxN6GgCzEoGo2EO9ANb9qkcWDUmemdxuZvxR1Yio+3Rw5TWp+wM6/NO
         xo/QJXqVzCnh67HH3y4aAvC9Vzd623T2EI8+mY18HgyHcssd/9ETHinwrbIqk2t55Fb8
         c8uGi18AXXLX5bAEZ3ftic+XjfgDElZIP6PmFerG6wa0x7Lv+TjUaqZ8mis6PKEoGEWt
         y5anfv8uT3Tksm6/6c0LuVJ+1eL7V8yreFJO03uxmRCNovJXB3jPDSwND5Z3yGGSzsj0
         FHOw==
X-Forwarded-Encrypted: i=1; AHgh+RrJAsGrlK2iJceS+iqNB4WGdqtzf+ZREfWhnCmCUlcyfhzJUX4qvPyBtMsR9f8igNwo/YPpOu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqknU5m6tYSPrhworUEZGquZRo4+5yZ++PYJoMmwuBiwwyoZu
	OaRn/B0GGCV399bm6jJn9FFI3aJdtQkIitOgLVFsp8D1Y962fj9arf54
X-Gm-Gg: AR+sD13mKhKlKqdJQSbAhM77j467njzi2HN2rOAwAWUcZ/bgUmcwNpmCtr5563VFL5Y
	qLGoTbRoimFxExcdj/38pDNK3HNCP0SV4syBg13SsqOwaBoVGPaOvV2wIVELYC6zBwyi8flvNGi
	1+aFMP6+egC4BXHNy5zSjH33wKSiHYvT3k36QWK3wXisTuLKpJZh5JyCWlEWkbPtWsC4BqZckSz
	Z9SOr+5F+dLjLSGSapuvxdSR4gsMmtPtoeXFw6G0L9PapPDw1GxvvZhQcdbqNHNMY4u0vvsH/h/
	RIZLl/o+NZZ+SLxDuHvhqkzI6byS9eaBYQ2vmgxNGDF/xjstVMCmhYw0G+evce+rDeB1EyQVAod
	RdRDEhgOTcYsA/5nRt/49GtM1V0eAWBNKWM5gQzmg3Jw/Yh7Q1MkADbhvdhQ/gklBYQXV7k7G1X
	YVwTgFCJhBuF36mTMUn+MGi7kDSCwrcywQ2ASvJtGgJSct/YNH4RjtLXzxh0BwtYMZ4dQp3QtI8
	GJCLyUbHbIbmw==
X-Received: by 2002:a05:690c:9b01:b0:816:a321:5629 with SMTP id 00721157ae682-81ef287498dmr60481117b3.71.1784693624931;
        Tue, 21 Jul 2026 21:13:44 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c2df04sm7882287b3.12.2026.07.21.21.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:13:44 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: sdf@fomichev.me,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2] xsk: reject undersized tx_metadata at runtime validation
Date: Wed, 22 Jul 2026 00:13:26 -0400
Message-ID: <20260722041326.75199-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no metadata length check before accessing struct xsk_tx_metadata
fields in both xdp_umem_reg() (registration) and
xsk_buff_valid_tx_metadata() (runtime).  Thus, an invalid small
tx_metadata_len (e.g. 8 bytes) passes registration and later causes an
out-of-bounds read when xsk_skb_metadata() accesses fields beyond the
declared metadata region.

KASAN reports this as:

  BUG: KASAN: vmalloc-out-of-bounds in xsk_skb_metadata+0x4b2/0x500
  Read of size 8 at addr ffffc90000f11000 by task exploit/148

  xsk_skb_metadata (net/xdp/xsk.c:837)
  xsk_build_skb (net/xdp/xsk.c)
  __xsk_generic_xmit (net/xdp/xsk.c)
  xsk_sendmsg (net/xdp/xsk.c)

Fixing at registration time would break backward compatibility with older
userspace applications, so apply a runtime length check in
xsk_buff_valid_tx_metadata() that validates tx_metadata_len against the
fields required by the enabled flags.

Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
Reported-by: AutonomousCodeSecurity@microsoft.com
Link: https://lore.kernel.org/all/20260720155210.34229-1-blbllhy@gmail.com/
Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
V2:
 - Change to runtime per-flag length check as suggested by Stanislav.

 include/net/xdp_sock_drv.h | 22 ++++++++++++++++++----
 net/xdp/xsk.c              |  2 +-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 46797645a0c2..5c54c7462c45 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -260,9 +260,22 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	0)
 
 static inline bool
-xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
+xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
+			   const struct xsk_tx_metadata *meta)
 {
-	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
+	/* covers flags, XDP_TXMD_FLAGS_CHECKSUM & XDP_TXMD_FLAGS_TIMESTAMP */
+	if (unlikely(pool->tx_metadata_len < 16))
+		return false;
+
+	if (unlikely(meta->flags & ~XDP_TXMD_FLAGS_VALID))
+		return false;
+
+	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		if (unlikely(pool->tx_metadata_len <
+			     offsetofend(struct xsk_tx_metadata, request.launch_time)))
+			return false;
+
+	return true;
 }
 
 static inline struct xsk_tx_metadata *
@@ -274,7 +287,7 @@ __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 		return NULL;
 
 	meta = data - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta)))
 		return NULL; /* no way to signal the error to the user */
 
 	return meta;
@@ -469,7 +482,8 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	return (struct xdp_desc_ctx){ };
 }
 
-static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+static inline bool xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
+					      struct xsk_tx_metadata *meta)
 {
 	return false;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b970f30ea9b9..75b2c97e41e4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -809,7 +809,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	meta = buffer - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta)))
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-- 
2.53.0

