Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490243;
	b=nK8l93baOqRyVR4zSOh8ZpsSKmJ4DS9C3OspdSn4Ie/GgBTPsY+ZE2uKh7sxV4lZy4A4
	 aIkIjS/CboZSqyv1JNNkjXLBFEIOaIseO4dyOE6bxlXxBVKuCiA7wfyetiVmnn3Pw9fJn
	 QjhSWiTccL2ucHPI+arrsAQTcGgnv/GtCzs5y7Q9tj6RxqmYrz7MJPHIqVreO9MP3JgUY
	 2Z4tTB4sHsDBYBme8x0nXlGFuqSaADvgxpaviutZQ7mO+DvTQS19t0hjFx/ak2y3X/uIK
	 /OHx2HLAmElSpO6kd/QJoYD7ms+B0cZkpbLMHBb+LrNDZhdGJoN4H2NyhFgtHpZiMbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490243;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=pgRdYCDU1fUPRdvIC/IX9gWA7NdVJoptYd3Xbm9Oygs=;
	b=Y/Ou8a6lngz6Hr4u1glvkSJYXPCmKk6o81GbKE6S24SB//aoMQgbkKxjNKDAdQMqeNtF
	 QHTIYn0RaBL8I5NPTiDMoe+Xmh/vFEobkaNUJfVaYsIzTcfRoz/OdWuq0Mbf7R0bMzMdK
	 MzsnT1PHTheS4iVQDjflUom+qIH0+4AzqmzhdZ2nb9cq3gXoT7dqOhNEpBnWNYxa0Ddih
	 R/YKnnLSXw1vDMgZUexD2OXUzyyYfpiNEak7bMWwefyUM7RAaNOE1RlFdpEQEcx6azV8f
	 LQW1QaTKjyavbb2QTo/RFcFSBZf365DAkVc64rxybNa8TW+vb1fec0RYo5oZ8teMblQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N/B/LMvX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0B606A33A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/B/LMvX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FF31F00A05;
	Thu, 12 Nov 2026 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490243;
	bh=pgRdYCDU1fUPRdvIC/IX9gWA7NdVJoptYd3Xbm9Oygs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N/B/LMvX3oZK8AhuGHcpkV06YkET+Bt3eeZsaKBICvGC+6F5V6JUOHFU5kv9hBDc2
	 IqIfBWlLiExLyfF5WBhUeW+/76wOp3viH+yTMt8mFjtRlmmmdetTosEbnVxx/pCV7N
	 KSOxk6Cf8XDQC6VFkrxKtVKWcTcg7Ha5upF+gqOI8gKiLu1m73/2/torglqBnolq+j
	 cTc8DrB4GBl7yx9ygVaaxu6GYf6eUl5qDxfptdowVg97oMM4oygHoZQUgbbRBEP8IH
	 sw3uiwN92ns9/lwTDcqctqf8vsYIXM0hUd0T2KsddS+cfmA6N3bPra0v1kFz/XxyB/
	 Jpv27K7C/00Ng==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:23 +0100
Subject: [PATCH net-next v8 08/19] net: ethernet: cortina: Rotate free
 queue page allocation
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-8-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The free queue metadata bitmap currently searches for a free slot from
zero for every page allocation. Under sustained traffic this repeatedly
scans occupied low-numbered slots.

Remember the position after the most recently allocated slot and wrap the
bitmap search at its end. Reset the cursor when the bitmap is released so
the two remain consistent across failed setup and teardown. This keeps
allocation cost distributed across the metadata table.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4b0c10d732ab..64c8c7e463f2 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -175,6 +175,7 @@ struct gemini_ethernet {
 	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
 	unsigned long	*freeq_page_bitmap;
+	unsigned int	freeq_page_cursor;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -779,12 +780,20 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
 
 	lockdep_assert_held(&geth->freeq_lock);
 
-	slot = find_first_zero_bit(geth->freeq_page_bitmap,
-				   geth->num_freeq_pages);
-	if (slot == geth->num_freeq_pages)
-		return -ENOSPC;
+	slot = find_next_zero_bit(geth->freeq_page_bitmap,
+				  geth->num_freeq_pages,
+				  geth->freeq_page_cursor);
+	if (slot == geth->num_freeq_pages) {
+		slot = find_first_zero_bit(geth->freeq_page_bitmap,
+					   geth->freeq_page_cursor);
+		if (slot == geth->freeq_page_cursor)
+			return -ENOSPC;
+	}
 
 	__set_bit(slot, geth->freeq_page_bitmap);
+	geth->freeq_page_cursor = slot + 1;
+	if (geth->freeq_page_cursor == geth->num_freeq_pages)
+		geth->freeq_page_cursor = 0;
 
 	return slot;
 }
@@ -1147,6 +1156,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
 	geth->num_freeq_pages = page_slots;
+	geth->freeq_page_cursor = 0;
 
 	/* Match the software pointer to the retained hardware pointer. */
 	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
@@ -1178,6 +1188,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
+	geth->freeq_page_cursor = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1206,6 +1217,7 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
+	geth->freeq_page_cursor = 0;
 
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,

-- 
2.56.0

