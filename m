Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790B3E1D07
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502182; cv=none; b=TXsM8slKqaiNve/AwAndqUh+xdzbDNwia/QobFXBYI4mOvVjKIBgNXC2jV22sBRESPnQNtd+pg1L3dz/qSZcoQwxhiyeAKNY9HZPmi7dbE8RLm2r8VIt5U3UV63R5PuU3TO4JFIRfE7/zlTOE4vFaz6oz4adJQ5B5/8G0rFmexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502182; c=relaxed/simple;
	bh=kyZelXdAhr50xldaDKCpQbxJzuE0MnKuRlZUHLwPqG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQl+GLppNN2ZHMalu774/tHNWG+oLQG0w0bryuPu6LQK0QSR3ydPGGiElS0lYF/1O8BOI5/b6s1U0Z4yVNDqll5+5Owlu+DiM5+KwCJYwc/k+k0ERwyDzk0Ltio9aS61mYxWfJ0smfItR7mDfCPurYLoUVj1MOhR12H5u7pW+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dha2pUvY; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dha2pUvY"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6681e7911b0so1144721d50.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785502180; x=1786106980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6+bsZsvLjgWGQPi3EMCs77AGqgUuxi4LRoiemM6mPsU=;
        b=Dha2pUvYDmQdQEGmfsnMSJRAkn4nYAhukLf6kxmhqUAe2as7U+zrMvKV9AgXRH9fQG
         OdRJ0YqY7kONiFPMzTxm/KCSCT0RaDL/xxjDCobeYLVXpx72dgxtOm0YntdYNErBSisq
         Q1dVUKe/RfgdkY9kvo+VigBTMFInJot7o+1G4IfJJVH95R5TfegjuTSukiVmuX5Dzg9n
         PBJTrDbN456NEtowi44Y5E/I8yvk03QHywBmj6+M4icYlxIAXjO7QHzqEcw9qq/w+mU8
         UUWhTquvrqUQJUVwopZV9wcI1NVbauOMop8GCv29EkNwX4YqjLAEVv9iSOFcYe8Nd/1o
         pzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502180; x=1786106980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6+bsZsvLjgWGQPi3EMCs77AGqgUuxi4LRoiemM6mPsU=;
        b=aIKIPvyjkr9Jqqb2m/B8m/dwBjr1MXkcxWd2ir5L94GSYDuAO5GmIunAELHGAAGJ6D
         GdwZXoiYm2smT3GjSZOM3Lv1v8z/da5qntL4asv6idAiv02sQ1ne3F/Q1ZInzOBJD7hL
         WiRvQrinQy5NENCr5GkxBnR9MSKyGmhoe2gbak0uJY7aC0YrfhaNkI4hfyGMHgXP9DWa
         BYIULlfgszRiLsFf9BSpSatn55xB3L4UUWesc0v+YCwIr6hdTrrgAZS2OPYFOvRa3QdV
         7RrZEAP2l2vvKKFhw1R7xx2ciwuDJt/+WHJJNBe+cNKQd7FaB+JvjxHAfEzxlQQmCGu/
         tdbA==
X-Gm-Message-State: AOJu0YzpF29gwdEDKdzl3jcFX8bSd/XHFPkwZdhXeEaGxlffPt4jS+bM
	iQBxMo7HAUzMS8STVP343EfngDw7KmBuKOkoNt2MKA3Re8a7VCKwoZT8
X-Gm-Gg: AR+sD11g8nmEzcTGUWs7/ZesU/nePOrzpmPW4r5issxCoQm5aBJjsuDki6CPvuCY5DB
	/sotyIdALMBbp4/3Z/Dd3eN8sFeE0x6fpUQUZ9uJOS2V2CkgdDl6UnJPhGKXKliyyxOXmRksSJV
	kM56gRCskAb2aRT2jA2r1H37tMS16GDAyIFDTPwC2DqEnBTRAjYecKmbM0EOBlHfzkEmotelIeI
	j1ADUTCrfNbdj6qrNb2fyWKQygZA6RSPhax2cLoZQpqYn0OgsytGpVjag9e4OI1WPsFi20yE3MI
	/8o4D8IbPy1DpFr6bU3VNfgXDu7VG10KI1x35SGmWHy0BfBPwYIAY5golAiTzj/lajc5YAdPnna
	5gQeK3c3v6uZKbWTrmoQRBoH+/MRRzGK/xgVtOZpDC6Z3n/DfBXIHTJxlcJtP2j4jny6HV+CZUq
	wjASOdoVx6APiVIKz/l9a4tYC9fVWj19WqzJg4HGuX
X-Received: by 2002:a05:690c:6f08:b0:7db:ccda:a409 with SMTP id 00721157ae682-81fcb971568mr16571697b3.9.1785502179974;
        Fri, 31 Jul 2026 05:49:39 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd108f0bsm5695367b3.35.2026.07.31.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:49:39 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 1/3] libeth: add __libeth_rx_sync_for_cpu
Date: Fri, 31 Jul 2026 08:41:07 -0400
Message-ID: <20260731124109.99065-2-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731124109.99065-1-tactii@gmail.com>
References: <20260731124109.99065-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deriving a netmem's page pool from the ref requires loading a pointer
from the netmem_desc, which may not be cached. The driver may already
have a cached reference to the correct page pool, so add a bypass.

No functional change for existing callers.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 include/net/libeth/rx.h | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 5d991404845e..fddac084e001 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -118,36 +118,51 @@ static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 void libeth_rx_recycle_slow(netmem_ref netmem);
 
 /**
- * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * __libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * @pool: &page_pool the buffer was allocated from
  * @fqe: buffer to process
  * @len: frame length from the descriptor
  *
- * Process the buffer after it's written by HW. The regular path is to
- * synchronize DMA for CPU, but in case of no data it will be immediately
- * recycled back to its PP.
+ * Variant for callers which already know the buffer's pool, typically
+ * their Rx queue's fill queue pool.
  *
  * Return: true when there's data to process, false otherwise.
  */
-static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
-					  u32 len)
+static inline bool __libeth_rx_sync_for_cpu(const struct page_pool *pool,
+					    const struct libeth_fqe *fqe,
+					    u32 len)
 {
-	netmem_ref netmem = fqe->netmem;
-
 	/* Very rare, but possible case. The most common reason:
 	 * the last fragment contained FCS only, which was then
 	 * stripped by the HW.
 	 */
 	if (unlikely(!len)) {
-		libeth_rx_recycle_slow(netmem);
+		libeth_rx_recycle_slow(fqe->netmem);
 		return false;
 	}
 
-	page_pool_dma_sync_netmem_for_cpu(netmem_get_pp(netmem), netmem,
-					  fqe->offset, len);
+	page_pool_dma_sync_netmem_for_cpu(pool, fqe->netmem, fqe->offset, len);
 
 	return true;
 }
 
+/**
+ * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * @fqe: buffer to process
+ * @len: frame length from the descriptor
+ *
+ * Process the buffer after it's written by HW. The regular path is to
+ * synchronize DMA for CPU, but in case of no data it will be immediately
+ * recycled back to its PP.
+ *
+ * Return: true when there's data to process, false otherwise.
+ */
+static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
+					  u32 len)
+{
+	return __libeth_rx_sync_for_cpu(netmem_get_pp(fqe->netmem), fqe, len);
+}
+
 /* Converting abstract packet type numbers into a software structure with
  * the packet parameters to do O(1) lookup on Rx.
  */
-- 
2.43.0

