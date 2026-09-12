Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25F33F385
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192825; cv=none; b=eAxt4ExqJDCeNLPjTuQTInD+fFBwvx/JoPt63R9p3q1TXdp8ZqxDEMKAkgWvUjyLvz9+Y02eYQhbY2L3r3k4/cf+5DG6gmKIZOJZUcX1sSvzUwYc3yi77O++G5f1NmeIoyobxpP76Q9NG6jJ1N8iy1UNIcZj+L+lkcgbp6roUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192825; c=relaxed/simple;
	bh=fAIaiTDWbAaKC2FvkE6RW/ZZkKo7oGownZgGjuo30sE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A59FtWTj33aszCQaOvHQyMcAX8pF67+LF6LYIUeHeeL7AvYptdUUWr49vIRaZyY46dNarughIbibDUyYQWVdZzJL9u8JJVVoQxOC820J6k/+LO85zAsV+cQesMHhf96WXXdgey3KPG59VUadHsKw3j6zrrslQPc8AB1MWmXG1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLqh3usi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLqh3usi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495437bb891so8615865e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 23:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789192822; x=1789797622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+zrxe47ZDJR0ZZ0e38jkzInleCbu1SGnjFyxJKHf75s=;
        b=YLqh3usiW3kKQGGy78nQNZr9XCPgmlDty/31iqpCAWTv1Moi6OXqEtzi3O8uW8i/x4
         iHmaBK19NdtCCRHp652WmKgAYzr2sxnqvJeNiVykiA9ehXcq45rLOcNLGW/fPlOqVzcD
         J36ZEX1Y3GoWtCViXGgl0mXznoJ5hoqqYUGEcfkWGa+GowIH8ObZEO5jjKCjpF5eh5sH
         BWBAIC4pRFijHUW55urkN3h8jVQviE8f3lnu0m6pCytY8Ks+hQo3BHafTRt4x5FCrcA7
         zP5UWu3Xa/JSIZT4i4Y+zyNk8sPuPrOlFhZZOMQ7ayrGplHX4O0mqhFxV1JevQn2DS4z
         OotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789192822; x=1789797622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+zrxe47ZDJR0ZZ0e38jkzInleCbu1SGnjFyxJKHf75s=;
        b=gCI46bPmKUUeYOFUKizgMppmXxs7G2L0bWvRfR0SRk6/ubfjIxfRmbkU7S46Ff1bdv
         9b/px6kPzJKKjDOMI+MnuMSHoRYAHbHeknjJhUHWSIRPcLd2JzFKRAzxSnL8eWLgOmF7
         j/4WdFtnA2EaG02QW9SXuNZ+VgEbKc2rBuDzgDUeyzaUgMgP0x6AKbYyDfPLXrqF9Jb6
         vZidR/C6QCmR6O64z3ftP615dz8HaVIm6zNEaSVH5UB7IJgbdPRwRpiYLorURYQ4r21V
         0soF4t7zqvj5l5qIYShZUqZP8WZkBMVmTQIUHB/AKx68+/3rgRwZeb6+FREwrDC2F+7y
         fZQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaZWSJtRcdYY8CKv4slTQDzmY5LKTLJpsiimReLdWIIK8cnfd2gfe2ruiSdqssnftARVmN9GA=@vger.kernel.org
X-Gm-Message-State: AFuF++kh5JkIx+74LLVjMQZAUXeTLcJd8z+w1pOrhkHuGQh4jcWI3JtY
	KkSnjPSubd0vb36hqxMkH3FzeIeBuoatHqABcGnutG9PVp+deBPY7971
X-Gm-Gg: AYBFou2prYUzeVxSt5ANNV7M0gxKPu6UrVv5OrXJ56Q3bJK7q6uVDw+l9E0vyS+088y
	AZUx9v6Hay4+7tckNiEQqF//7qWZDXpvpDRs3pwtph0tNmaYW6LOP1siwSEE3La83tOBxQuBRRi
	fm6okfNT+rKJiFf9krt1eS55ka+UlejMmDefoTubM4eil8oLX28hMB8dwiA6ok+5KhuHBOHC2GL
	aNWrJFcf8vA4YuYqNjEhPPUkQ3m08Si4MgOzv+5AQuXG2L4h6BFdyidg92anT5tx7Eax/XxYawx
	TX2u+G0vSd19PYUxQqw1M8ipn7SSFeZ3z4Szlpi4PoD3mt/WtbQ2O4aYXYNQYYwOQsYQtOedx/J
	OVOYiJkbYvFzzBzSuzyIGdR+WVQ3WgJMmtNjSkoayyaoL3E9GtNMDHkvwWAVjUa5WS5Exf3s6KA
	DWYDn+9ZcSZOZ58IvRzSnTBpvPqji74FRKX/IxqjMZmalgz4Kzya5BPLtgnQ8cQrcfXPVNtX8xP
	CfTPD8wI9LHUKh8gme862fgNTA2YsYIXGTgDwe5kEm92OLOqicCtY5auLSW9KPRQXcJWb2Ju12I
	3Ljz8ThT+3ojebMJHGP9Qjksa5/8pOArfR0c0eGq05wgu8TkbKtNPYvfQp8sg3HNbqrXwxBxdTH
	yv9HTAuk=
X-Received: by 2002:a7b:c8cd:0:b0:49c:e0e8:bd94 with SMTP id 5b1f17b1804b1-49d26d72858mr122826695e9.1.1789192822406;
        Fri, 11 Sep 2026 23:00:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35f3d9sm9654062f8f.35.2026.09.11.23.00.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 23:00:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] page_pool: Fix page_pool_alloc_va() reference in kernel-doc
Date: Sat, 12 Sep 2026 08:00:19 +0200
Message-Id: <20260912060019.39902-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment of page_pool_free_va() refers to
page_pool_allo_va, which does not exist. The name is page_pool_alloc_va.
Say page_pool_alloc_va.

The wrong name came in with commit 8ab32fa1c794 ("page_pool: update
document about fragment API").

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/net/page_pool/helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index e2730dd273b2843b790811d1a6a5f5acd68d3ad3..87a4e13886e15edd4942a933edee63f26bd15a80 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -417,7 +417,7 @@ static inline void page_pool_recycle_direct_netmem(struct page_pool *pool,
  * @va: va to be freed
  * @allow_direct: freed by the consumer, allow lockless caching
  *
- * Free a va allocated from page_pool_allo_va().
+ * Free a va allocated from page_pool_alloc_va().
  */
 static inline void page_pool_free_va(struct page_pool *pool, void *va,
 				     bool allow_direct)
-- 
2.39.5 (Apple Git-154)

