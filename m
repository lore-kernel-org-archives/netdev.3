Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248752;
	b=0FLrTw6rMaITassNAXAr8Og13SVv1qaGYmeSQAL/v/sXYcrYFJdeEAp5N6x8A7NZ56tC
	 rUVOB4B042KN7ogZugV5PaDrOflCm5H5VoMClK/NrrFOfu4Ugv3CII0zJD0FBCeNQbPgx
	 +0zAahe48ZFR7uJdEUUfPlko+rGzjvqLZIUlcFWaOQ0/l+tTXQdAp6Ifi2C2Vkja8dv3P
	 +6H+yEKTpwVHgHTOhwxNJqyGJfPGkG1qjah/Vf9SAZ16nlipa8KE82fxu0EIYc6BbD7ns
	 WT2/7qWT6SVUp2upyXCTD4WkwgfjMy1rKtC5Kz5tkp+pHCR17O6fv/YadTB9hCanKtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NBXycfk6vA0iRzHtj3njzH1Lm9NHD4+ffX/6h9NPcU0=;
	b=zpvNQgK7V3aq0Izf0D4GO6X/IdpLICYsRnDD4qHAdUeXDz5p0YWmzF3fVRMwTfBZM6aN
	 hsp1dbshg2dGK3PQ947qsVFpuk4TdCacXdbRLKWzR6nz+aaUYk8mjapD5CwIwA/jS7k1H
	 ijKReRY3+aQKTf6l0l0WMinVxaryVL4yJex6KTnWxFlSp70NdrRF+NlJvSBJ67P2mFoW7
	 fhFg56N4ULqYesZBGTzou834bc46M5HQ/BKQi4Mz6Zp7DMHzYxnnANtI06AZdJeRJSLk9
	 mKfGsl+6HFrp75/zf8YNIDvjNJhx0IOKWmOiOljKS+xTgg4RhrkfbTk78iY832Uqrxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vsx6GRXj;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB884606AFCA
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB884606AFCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vsx6GRXj
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c4d4d132bbeso123813266b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248750; x=1794853550; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NBXycfk6vA0iRzHtj3njzH1Lm9NHD4+ffX/6h9NPcU0=;
        b=Vsx6GRXjXpakpV0mcP8sVIumeTeqEIHF6h+dSTgPaFOhDo6gceXM9wEVdXC7d8iNAT
         IYid/Rh4qH6naWSltAi65m3nNdZjVtAq9l077dlhEGc21obfZd5OQbVg1eKq7iNhcmtI
         GGRy8vkKE9iBQhnw1LAXz3ezkGERg7DP2Wb0ypF56at5ruz4at7LjmmeqapMzIK7g8+E
         8+APbH4TgMcrc1AK5w3etTgFu2rNB8FK77pibheGWMjKBk0jgfbD9Rq7DANVlyuPo3NX
         z02EXkPY97990oIFrzIn8XlvGcxPXm4nk+4AQXlrC8he3Z0ZidnZ+xUX97xk7541uqaA
         kh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248750; x=1794853550;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBXycfk6vA0iRzHtj3njzH1Lm9NHD4+ffX/6h9NPcU0=;
        b=liXGAj49QmwtcqL7H5VNQTQi/kBhRN3NOmqVg3yDv63RMid7DsAeyAnEVr9lryze8A
         R3UB9eni8lXwmqF90SjX/LSAEFurOEq9SKeLZM53tElhtdQmdat7E3b1AnrvL5G1wtHn
         x2hqiTrEfVf/JJgh8Z44L1wgHwajs1yOfl0omQXfbj4Wc29epC8a1X7F0usthy6y0pnC
         g0JtfL6McyHQyVTeEUXVlyaZow7IRIuXsNxqO0Cg1pz6OI4ZE4hV0437COdYiOMzdtCK
         J7Loca2MAvV/SlEmEVfx9rt8yl5vm9oTwvfufTG5dzOopvE/lDoo4h3Bv21o8RpN7JBP
         d1SQ==
X-Forwarded-Encrypted: i=1; AL+hErH7OirspwvgTHrQeHYrisBSUjRscl+OPxFzg5Hoy2OQIphSpV1rnz4k0wW0cDkCnBpXJxA/qao=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T7HAbr7j1ak4iXHQxjCmYiRVYItTp3fYd0uo/4mp4B9liJtig
	w6xfVIK8WiCNcbFGZ+c6dVU+Bdk7WmEpsQfcgp12AhVWuWfajynqEbpJEMgVosi00+3Q0h8Ww2F
	E14t7HQ==
X-Received: from ejbgr9.prod.google.com ([2002:a17:906:e2c9:b0:c4d:4f51:fd3c])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:d54e:b0:c46:78af:6150
 with SMTP id a640c23a62f3a-c5047a434a2mr29783866b.2.1794248750196; Mon, 09
 Nov 2026 10:25:50 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:21 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-14-lrizzo@google.com>
Subject: [RFC PATCH v2 13/25] net/core: Use PISA for page_pool memory
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

When a page_pool performs DMA mapping (PP_FLAG_DMA_MAP) on a device with
pisa_rx_bufs enabled, pass __GFP_PISA_RW to use PISA memory.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d7c88c0b67e53..91cae5ba78373 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -16,6 +16,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
+#include <linux/pisa.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -622,6 +623,8 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
 	 */
 	if ((gfp & GFP_ATOMIC) == GFP_ATOMIC)
 		gfp |= __GFP_NOWARN;
+	if (dma_map)
+		gfp |= pisa_rx_gfp(pool->p.dev);
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-- 
2.56.0.542.g3ef89b7020-goog

