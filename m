Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348826;
	b=UEKN0KAMrOMNhOfjiBvXgA1c1wqY1l5IzDqScl76i64kXVdVe7+hlpod9snf3fRhQE1+
	 r4ct3nlE62XVQWBo/HDj8xsF6VlNECt6UlpLMdi9oBfRb0GwQadnPdm91Q8Vx/TMmx4Zi
	 ZDit1l09mkGXa0cKmC3UEwWv4tOI6uudjXZgN+So0OZIrGeCGbb8Nqlq99ccQVRY6iSir
	 oCMl3fezGHzHdXIehvylcdr2guRQ8zmNV8yzrK10SKo8qzmfxG6M/0gqfcmAdpAY8D0Kp
	 4wcsGZOl8YaRV8zm5SmM3vu2y+u1zqY3damS33PDurJIiGGS7qkDPJqUPS7BoApRULg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348826;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=EWepFTZe9acWwIdPJvXqeFd/FqqILRIGMkdapxHcILA=;
	b=PTzhCy/TU+fQiTFfPGe8yO7kiVFrYMjDopn7oiw8DVNmVb4EXPa53m+OC5uwL82o5LYb
	 0EKUFIZGUNNXOHStouIlTarehaey8Z7uOqO+CgNA9CRr08np8Vkt0dcnd7Xe4RheEVZ31
	 pNLjZlx/vIRQXGYxzX5LNk5eVjXjKu4tN8B7KLWK8tphOoWCgdQy6RB/5RGE0zYUsnsJA
	 dIyrkxKDNgIVpmj0YuAg8IwYRs6JRHSfF+O53qzHz+tCeYa6Jt4UhfIAdvy+z35uALYvH
	 FEIYZbsP6D5p4PyLRDlghwXt95FK/sY6FSaRWK0+jBF+AQQXI4eyxqz3vrcUw4yes8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMxEXomB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B04606A333
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMxEXomB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71541F008A4;
	Tue, 10 Nov 2026 22:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348826;
	bh=EWepFTZe9acWwIdPJvXqeFd/FqqILRIGMkdapxHcILA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TMxEXomBWsT2fQmvRkWr6FLWtd/09fnwNssNT6ifZaJFKvkvm4zEZYdVPblQ2pmI8
	 wA3/IkIOW8XAvhYVkB4g2iGg584+tlwJfiLS7TseGrIbpo82scpIz3VVP+mtUgBufa
	 9PBV/G/xQ4qRytzO9Vw/yY5hCLjaniIjXw+4ChZ8bA1f8D6sF83ijaBbs/BMqVBEPA
	 Jf+0aPYuOlTl0/mHowMQA+rwxItoe4tvoPJ049xzIXxJNIhuZNcoCOfIyXlDv0FBC1
	 SBUQFv+YqnBiLRwjPftzOtzlDYB2Z/s8qK3gM3pdnsym6iOIB0qEvC/euFZFCD+mYz
	 Hd/A7TybRgI1w==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:23 +0100
Subject: [PATCH net-next v7 08/18] net: ethernet: cortina: Rotate free
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-8-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
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
index bdbbc6d7844b..b9d6fffd19b8 100644
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
@@ -1114,6 +1123,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
 	geth->num_freeq_pages = page_slots;
+	geth->freeq_page_cursor = 0;
 
 	/* Match the software pointer to the retained hardware pointer. */
 	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
@@ -1145,6 +1155,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
+	geth->freeq_page_cursor = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1173,6 +1184,7 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
+	geth->freeq_page_cursor = 0;
 
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,

-- 
2.56.0

