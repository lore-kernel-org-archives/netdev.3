Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F33C0607
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742006; cv=none; b=Eif/giIu7nr7MEuRxjmq+05hCEHRCpYkwKh4umIrbbhWIFa5NKBmKM1cPi3393FIBTNQfpS/XGEnV8iTKlfscbuBeOHuerQRJ3rA0mrCoyfNTjRZUd+yVCuggNMyxwand/NsYdrEba4vGKu4BrNjtaMQ6XA2pwQEBiXfMEdkZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742006; c=relaxed/simple;
	bh=5gYdbcSBZqSesON3t3sdM6fmCFYLijiVhGzYp3sWjGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAyeUbtK1ll3PmbuxiAMMmvQF3wALrzaFL0cknrpybTj2KPUFXdGrKXQKFYLbr4ut1XgPnRL1LQ2g/NHNF/3Bl49iHCaArb8IDF7YoXqWcDLusmy15geWTH0FkMAcLkXJsoUQwNBDywKaC9x1XzRI3HGGOYuuFJxyyYGu3bDCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJWw9pRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJWw9pRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CD91F0089D;
	Sun, 11 Oct 2026 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742005;
	bh=3/MpgewILMinV1Vsy0/lJIHXgteBsckrBYAn5UdbQEA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dJWw9pRnTxkIrKeXxXxCxHysQxDKfPa5ZF36i+Pt3el4+/cx8uj0w9OnWevPme6uR
	 Q7CseA8QF7lz9bqxC9st5xNCPqrYa0iYYvSOfaap2y/XUgvvnbXXUskQYCLVfsOYAv
	 8jnawIIaYVgRBtL8C8d+7hqmP5kTtN0MIw0f8FePamkVuMOR+6RuN3P0hXRYPOIfcl
	 RXlJsZ+nnNv4hyG89mHpvPhj++TPG5ihbNzclW3H/FhGVjo98O5UrLLo8I5a1cog9E
	 LM2hSQYhQMwMImmWTVI+XAA87CRt1/IyFyMncdpplRx0NfnOf2fEswrvjXWb4wz2Vc
	 bxUQTDQn25+Ag==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:22 +0200
Subject: [PATCH net-next v4 09/15] net: ethernet: cortina: Rotate free
 queue page allocation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-9-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
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

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index cd5ded7384a5..3bb96c51e0b7 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -174,6 +174,7 @@ struct gemini_ethernet {
 	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
 	unsigned long	*freeq_page_bitmap;
+	unsigned int	freeq_page_cursor;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -745,12 +746,20 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
 
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
@@ -1112,6 +1121,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
 	geth->num_freeq_pages = page_slots;
+	geth->freeq_page_cursor = 0;
 
 	/* Discard pointer state belonging to the previous queue geometry. */
 	writel(0, geth->base + GLOBAL_SWFQ_RWPTR_REG);
@@ -1142,6 +1152,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
+	geth->freeq_page_cursor = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1170,6 +1181,7 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
+	geth->freeq_page_cursor = 0;
 
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,

-- 
2.56.0

