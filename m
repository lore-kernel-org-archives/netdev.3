Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581B443E56
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347311; cv=none; b=ioZWGJwdLogFdRGe/bRUQWM/xlY8TwlkFq8qdHxixtHHXXqNOUcZnI544HiQO+1tVti7PQkb1LJMW+kFrCZXH+gci4tS/zgbQyfV55SFPNSSIDgTm6PgISoce9O/3yvp53o3R7qJadGPi3Jb+rKyvTMark4T2hZ+11Ep/4GRi6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347311; c=relaxed/simple;
	bh=VFSKskxgDHx5fT3EPPJmXZo/npg+dCPd4M+lblx5Mco=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ToD98UoQ0I6VdgNEJv1hur2M0CdtwSbGy0ow6+jtRgJaB16AwrqCi220snnlYgQul9GMlTOUzEdgWJwNlEQ24CNMpdi2mAiS6sYrUPZnFiE4DxYXjY5o092rQ02Do+YWsq3tBAhJqdI3vniq/48/RNksmgm00RCsaPlG41PFedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRcE7Y6/; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRcE7Y6/"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3284bbaa89dso3698045eec.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790347303; x=1790952103; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iCD1F0rsHrDkiY4pRxJCOX415/PKxhu7KHy9EzhTZRA=;
        b=XRcE7Y6/v+sefw8k35CjFKujA9P/r0Tas8uvGr4l2qJaMdBUtXTD5ZqGDXtMpyxbvn
         SylMAM7x4ODaoTXdRNO/oPiUS17ZHv5L/BmHT8zw1t61SrIYpNQ+UCX5yTrcyeLs+2Cz
         iIVsT55l836k2lB5a8X7scLiD3SlHxCs3JvSiWqkjr2szfWARb5pxVFgyti41nfPDi2M
         f9e8YIDNkyEtvhybuS8YEZaSIF6dlkfgQoa7V0vtKJ/dCqeWqWbs94gUGmI2vkpPw8kp
         GzlgJQMMWsnfJUuQMveyienM0cUhw9o3yL4YCXJ3lGCC2qEZI8owzY7mUNc/jTLvldtx
         MuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790347303; x=1790952103;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCD1F0rsHrDkiY4pRxJCOX415/PKxhu7KHy9EzhTZRA=;
        b=08n2tY/vvwFD3fxZj5DiR2H7GlRw/OAbXH4kfj/WcDqQ/rJ4e6ET5pycj3Bo3i71pl
         rrl4BIO069VcWtYUaoVTMCnuymSMDud8taDxTyZXJ2PbupfGCdYLESrxBI4hZB5Wc64x
         PU3hkUazzpja+33T6CRlUm/7wSPKCPT2bd1cEkAaBDzqlWqNJ1bi6GRogEjKERwP0vVL
         qelzQ78ynbBSKQt1mwlGTZT2/sq/u5UIU5ipWqIpLc4HD2BnOSM7hett+8S+L2SLnOOJ
         lvSR/kT63wIIUD9uoY3I+2XfitloOyGF0k8HFlD4BHT3qJbDK+21kRVoNRBybLX4pLcC
         5v7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwK29aV5CxXREcUU9jdrsMgfFC6CB/5rtzBWqZZdZ794gTx4zxGZ5GwFGEXhYMkBIe/OXNSrJ8=@vger.kernel.org
X-Gm-Message-State: AFuF++lFofD2DZ0yHLi0QlsIzg5qIMFM07pwn2p2FOS9yia5eAq8Lcpq
	OizjYCZnPSPZr74t6g5Y+nPwfnb+sYJ024HKPO4wUHsCfrZkhRq74L4QZs3ys835ghMGhtJY5P4
	vSYDP+OZ4ElWL3NxX/6CShd6UwQ==
X-Received: from dyclv17-n2.prod.google.com ([2002:a05:7301:6191:20b0:33e:c489:c4d2])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1c19:b0:33c:130b:457 with SMTP id 5a478bee46e88-3427384926dmr372391eec.38.1790347302408;
 Fri, 25 Sep 2026 07:41:42 -0700 (PDT)
Date: Fri, 25 Sep 2026 14:41:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925144127.1445667-1-almasrymina@google.com>
Subject: [PATCH net v1] net: page_pool: fix use-after-free in page_pool_recycle_ring_bulk()
From: Mina Almasry <almasrymina@google.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kaifeng Wang <kaifengw@google.com>, Dong Chenchen <dongchenchen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_PAGE_POOL_STATS=y, page_pool_recycle_ring_bulk() updates
the recycle stats after dropping the producer lock. If it just recycled
the last inflight netmems of a pool being destroyed, page_pool_release()
can pass its producer-lock barrier and free the pool before
recycle_stat_add() runs.

Commit fcc680a647ba7 ("page_pool: allow mixing PPs within one bulk")
moved this stat update after the unlock. Commit 271683bb2cf32
("page_pool: Fix use-after-free in page_pool_recycle_in_ring") later
added the barrier, but only fixed page_pool_recycle_in_ring(). Move
the update back under the lock.

Fixes: fcc680a647ba7 ("page_pool: allow mixing PPs within one bulk")
Link: https://lore.kernel.org/r/179028939171.2160803.706522228583664641@kernel.org
Cc: Kaifeng Wang <kaifengw@google.com>
Cc: Dong Chenchen <dongchenchen2@huawei.com>
Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 08d7f35cf6089..d7c88c0b67e53 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -951,8 +951,8 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 		}
 	}
 
-	page_pool_producer_unlock(pool, in_softirq);
 	recycle_stat_add(pool, ring, i);
+	page_pool_producer_unlock(pool, in_softirq);
 
 	/* Hopefully all pages were returned into ptr_ring */
 	if (likely(i == bulk_len))

base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

