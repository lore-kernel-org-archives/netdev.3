Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965048CD50
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585457; cv=none; b=Lh4rdlutNeQLKdWd5r8z5dCr9Viqn+yjAkeK6BPWCBmhW2/rNKUz9q43llKczrYg8IZYmzW9Da6AvSPF+95qY3NK6Coib2m7JLXKlOFEgw5LgVS0xXeiRlcR/8hBm5kDIrx6YnCaTexVHisndZcjs9GrWr92h3tKQyhgZJ4D8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585457; c=relaxed/simple;
	bh=8zF61l7XUYfPF/S5G0yQdjRwCBSBU/86WUkneKAj49I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fv5Gond8Pq7oXf8fKwDARzwgyf7AkODRHILQuIS2GejRGiq+vgzDTMfBb00bd10as6XG6iqPQNFKzyWycnK+OsMqFPbpWfJBlaUs4PtZCX/ENuEiz1mpXa6KK+3bltFq04n6PwKSPb7AtjapEa7wDleialOeCYA1qIuCdxRH4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYUmyW+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYUmyW+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643891F0089A;
	Mon, 28 Sep 2026 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585456;
	bh=Y0HxyvWLDosZc5xoDwHVRTARrpEGTve+PHp4YKgftjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KYUmyW+BaiVQ9eaCXMlXub0b7FVy+20KbeJiMmA7wEis9lOT3u4QpXT+541Bv8gEg
	 u8zE1qPjOi0++UXn3Sac7eSLLYW6p+KaJeFcp+bqaMEEhbIhCcZphFp9aM+AoWRAVD
	 den/fg2Q/vOqMp96WD9aPDhVej++M7Rroz8vEWBPqL6XtmCpACY7Xn3BB15lB0Odbn
	 QZ5z4+14GYj0vXsZAmflUG8lnHoJTENkoC/Tf3PoPNCqdi/kY/gIGLF+G72gGV4WKt
	 zzvE45cNounrTKa9XN99krzVU1cA0Vg8vSOA9D+gaJ9SZKKJx0Acf/qDVr8MRpJsdy
	 hXN1FTxJ0Sl/A==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:32 +0200
Subject: [PATCH net-next v2 06/11] net: ethernet: cortina: Rotate free
 queue page allocation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-6-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The free queue metadata bitmap currently searches for a free slot from
zero for every page allocation. Under sustained traffic this repeatedly
scans occupied low-numbered slots.

Remember the position after the most recently allocated slot and wrap the
bitmap search at its end. This keeps allocation cost distributed across
the metadata table.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 8d216fa45287..385b78fd6653 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -172,6 +172,7 @@ struct gemini_ethernet {
 	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
 	unsigned long	*freeq_page_bitmap;
+	unsigned int	freeq_page_cursor;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -743,12 +744,20 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
 
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
@@ -1072,6 +1081,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
 	geth->num_freeq_pages = page_slots;
+	geth->freeq_page_cursor = 0;
 
 	expected = len - (1 << fpp_order);
 	filled = geth_fill_freeq(geth);

-- 
2.55.0

