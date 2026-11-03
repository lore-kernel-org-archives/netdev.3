Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728300;
	b=cWRYuhilo2vKUiembdCmGONpfODOR5xAKLTI/8FVJMTOsEtJwqlP31o3o5Kw1hMzLsWL
	 pSWbtzPmP0Ybwpb2Hg2KUNuBfFTzquPmS/xIVWeiW/izH0yd28X2fyLRis1mPv9upiups
	 EWjRjYOYnXeJRlWZx5lJlZ9dfEaoLypuXGSaQ0s7bcTk83o/p2DPF6FUXnreAq3GFHGWk
	 dugqs19JcSHrcYBy6r7X6Msdy+39I1oqri0uKU24Mj09z1eaeuM28kAHjNxekRkAUbfzh
	 /LTNFdb9LVRnB+QEmNCdkfI65/OOG/rLNsmPOXWm/h3PxTcpHnIK7Yg7+UrWQyEn9yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728300;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=XiN5kgIFk6WXwzPbcpbgAPVJ3cN42G3Ee7NADkh/sXE=;
	b=zq8QuN7+/Ns3F4kMp95KzkIphfJocXdIeqG5VAOHBjYozh2EKxga6z2e+my1w/78PjSO
	 7eull2++vdCUJ57Qmr4N1uJfE2bm91CczDQqENOkI3fOTbGdtTNkqbQjEqpFKBk7UDxoC
	 5QoUDYYFfkxVs8Ckj4npeOEpp434LhKKXTGkV0SeAJT/3gbLfW+CHU6IqL4EpTPqcK1rQ
	 XjrEqFZAF3YK8FVrOpiq+j5ZJ9ztiv4BnmtMhZ4Dz5M0/EijVFQ9LNqCt0Pn8WAN5ry7n
	 Pmt/AA8kEVhmZ1XK9o04gEYqk2tVCdptMBxUhrgjxoiY6v/QR9wcV9SVNl0sXMTdGNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mL45y7Em;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4A606D804
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mL45y7Em
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590911F000C1;
	Tue,  3 Nov 2026 17:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728299;
	bh=XiN5kgIFk6WXwzPbcpbgAPVJ3cN42G3Ee7NADkh/sXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mL45y7EmfeEDkxCotuM2CoY/balYPrx+eRlVkp8v+l93qhxh/gxRsZEulnzMZnMbX
	 N5nr5VBYlxMIELIsXDd2cG+lGSf7DXQ4NCHblnifOVdgpsRRGP+XaagxWxOaabWhKb
	 1YURoY4nvo54hJDCWnd0Qz8mLu1zMKdj1rnJfZ4KlPQSolsaQ/YTTzdp2SyKA5sN44
	 YehXdq9vWKh5VveNZTUXZpJRD89puBhFzpf7mpBnaUODx9x3em9t9VU11pjAugYM3X
	 y2mA4OAamfu4MnYjZzWa/ILB57Q9oy9J4Onz+s+lnMHli7LBhmnwP/Tj97a9SbBvdR
	 Y39Vxo2g3cIjw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:19 +0100
Subject: [PATCH net-next v6 08/15] net: ethernet: cortina: Rotate free
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
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-8-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
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
index 9602429388b1..1befa8dd13a6 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -175,6 +175,7 @@ struct gemini_ethernet {
 	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
 	unsigned long	*freeq_page_bitmap;
+	unsigned int	freeq_page_cursor;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -746,12 +747,20 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
 
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
@@ -1113,6 +1122,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
 	geth->num_freeq_pages = page_slots;
+	geth->freeq_page_cursor = 0;
 
 	/* Match the software pointer to the retained hardware pointer. */
 	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
@@ -1144,6 +1154,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
+	geth->freeq_page_cursor = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1172,6 +1183,7 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
+	geth->freeq_page_cursor = 0;
 
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,

-- 
2.56.0

