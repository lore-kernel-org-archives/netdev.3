Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5DC4D9561
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231505; cv=none; b=sLEzPFdVB4yjSGdgRUxM0SMlIw09dX7rpwCJjRCu1YFAY7CQtcR4J21ecFsDUH2BSl5G0p4POM4r0L03hVzzDuT9L6ibrg7twRAtHLbfuYRuBiTjTYR0w1IqHLGsb32n3d57GeeXGJZCR2E1wMSZpkZnvP2KS4OFUNexeBm9HfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231505; c=relaxed/simple;
	bh=BXoFvpeLE9KoGidUa4e0smSWqKCrh9rC2ND9HlaDXpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDNFzl/kR25cyS4eZZMdehyWk8N042oHGU0XdzPkT3e8nM7201vd4pCx3xRpKcJN2j3mzzqu7IgGAIsMSlcE7Kc7c8VKdA2fNkPEKe4YKWyB4niSn/OhVDFaeXao2PGPTag3Li/o81QKx9vFN/CS11aOSmelpOuE9z4h2mQwZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q92ijepU; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q92ijepU"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a834ff6565so165256a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231503; x=1791836303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UaqXT4ErWO3i859O4DLN6R0LDK8LuXc4vcaqlzX/HHc=;
        b=q92ijepUkteqdvbpwBJ+Q9rqk5H07n+2J55qNuy1I1QxHjZ6pwiTUJ0MBn5WmxPYcn
         XsPKR/miPhuuHD5Rg76ez7Gn8ScmGkTNNHJNakzLEHqr1zsfIYbQrHWQptOKnwEU4rdz
         bgRpOuhrEgtk0LJRqeVqyNtD6Lo1FIJiJ3MUbVnpvnicu3B6K6WacbZPskjtuBvqC/OQ
         QQT/kOpyXxiQF88mB5KXGUeNjgSPbofTUBXNvhkc5fPz6TFYv4I9wSvol/MSqFe/XBws
         N/NG/yj/wBX9aDAXCv2XQZ8wB0ZwRxTPIpRpKXwuYOx125w7tDftDATSzzHQp2syMVGd
         HmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231503; x=1791836303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UaqXT4ErWO3i859O4DLN6R0LDK8LuXc4vcaqlzX/HHc=;
        b=Zs+lBTJ4Ie3MEfj9T6FcjKjRZVxNdIq9rz/hda7hJXb6gK/hH6JRoTn0TVs8wFUo+U
         TWCim5dPOCUAy6tV5+TolLwHHHnhrMlsZkNB4Dlo8ns12JxR+YOUNG7SF2SE0y+D2Fpr
         U9I0RgQORFL7e82dDsrvI5+r1sQPK28KF2CeR9SLitTe+g+Do/MjfyOmb9NIq3oAdMir
         Ylnm4DGAhDasaAza1USBt8cX9roJdRS0BqguQ57Bm07+FwLH26mYIcpKO0xm/dkQpJsN
         kvfxdIXTq/MJSuqJ9GWLwkHJ0QBtnutP215QF3Rxrp9mTXPvDUt1fGem4bgFAwYQSscr
         ysvw==
X-Gm-Message-State: AFq9FYJy0HQtRYSeuu1Fooc+FDCwFHwTn3uMprMpo/zfWox/NUMcjzhS
	RsIWOpwe6vI9icH5JDAQL2R3/hqh/Jonr6fxNN6t+6p7ZEesS3AMo00IejUxt4iK
X-Gm-Gg: AYBFou0DdkAyw8O779sdt97v8401lesXA6aunTVONUL2UBVOsbUBMpAu5MEJ2xmOetK
	JL61a/bQj1CFgWDFN6lqk8PyyQ1Tr1Fp/lXdZTCSRwJUJvabUwDqCwNi75MXMHPFjGImaTPNweI
	62SiA/qSlzGEaecp6CZJ2RH3pzNP30Zej6TXimQnbBTFLQbxl0aCO7xDgByRae7rk1K7rHyWTGD
	6uuJw8Wo9CzuXEc8QqFRvkeANKgDWIFL8IzrbGQ6R6kcAn+/GemL1HBHlnrfmqt1G7e9icKr9fn
	1AV+fpdLtKgXN0inI9xeU/oayNQyWtk43IRzES+wwo/ir53fDCdEVBjUw1YhfM+EUJwjJgJDxDy
	bTktp3HYGdACznIwgSSrkrtaCmZKwHEm3kdGro9MjHGBcoUJaGsop/tMRSZgqG7kHMxqm1lhznh
	eRRnp4Dlqr9nBJJ2sapwBkkGoFkieZQksmpnb/jdOROYhXkO38yfvVo2SZRGBsP40MI+l+bZlUr
	Ko=
X-Received: by 2002:a17:90b:582f:b0:3a4:ee64:f492 with SMTP id 98e67ed59e1d1-3a85439e2camr322431a91.33.1791231503215;
        Mon, 05 Oct 2026 13:18:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853d00fc5sm1125229a91.16.2026.10.05.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:18:22 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	horms@kernel.org,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: devmem: remove net_iov_area base_virtual
Date: Mon,  5 Oct 2026 13:18:22 -0700
Message-ID: <20261005201822.3060658-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 083e64a3af77 ("net: devmem: replace gen_pool with
freelist"), a binding has a single net_iov_area covering the whole
dma-buf, and base_virtual is always 0. Its only reader is
net_iov_virtual_addr(), where it adds nothing. io_uring zcrx never
uses it.

Drop the field and the store, and compute the dma-buf offset from the
net_iov index alone.

No functional change. From review feedback on:
https://lore.kernel.org/netdev/asPUZ8DPllHd6Yu9@devvm7509.cco0.facebook.com/

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/netmem.h | 3 ---
 net/core/devmem.c    | 1 -
 net/core/devmem.h    | 3 +--
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index cc97611632dc..0cc8572f62ca 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -102,9 +102,6 @@ struct net_iov_area {
 	/* Array of net_iovs for this area. */
 	struct net_iov *niovs;
 	size_t num_niovs;
-
-	/* Offset into the dma-buf where this chunk starts.  */
-	unsigned long base_virtual;
 };
 
 static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 71c83730d73d..07c62e2e3088 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -252,7 +252,6 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		goto err_unmap;
 	}
 
-	binding->area.base_virtual = 0;
 	binding->area.num_niovs = dmabuf->size >> niov_shift;
 	if (direction == DMA_TO_DEVICE) {
 		binding->tx_vec = kvmalloc_objs(struct net_iov *,
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 28d6fa7bcb57..1cec10f0257c 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -112,8 +112,7 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 	struct net_devmem_dmabuf_binding *binding =
 		net_devmem_iov_binding(niov);
 
-	return net_iov_owner(niov)->base_virtual +
-	       ((unsigned long)net_iov_idx(niov) << binding->niov_shift);
+	return (unsigned long)net_iov_idx(niov) << binding->niov_shift;
 }
 
 static inline bool
-- 
2.53.0-Meta

