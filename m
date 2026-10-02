Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02654F4CF8
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958310; cv=none; b=IDUNV4C/maaqKs/v4edyoOmU0VfO6gQMeB7pB3XST/os/HcRJGd9JTAGPgSg7TrqSUzoCXTTmxHZZZA6c4kY9UDilpG7ko0DFsW7KCKKECteU0CdEeqv6oP6ugQ7SfU7SM+7KYpr/fGk/INx9I+9tvML2zsSSnycsgFIP8bLo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958310; c=relaxed/simple;
	bh=5avW5tSTUbimjlF+wRQM9RHoLcDbWco8LNjbcA2YiMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLP/7wyyI2WXPCO/WONjK9xm1wKmUUiwyzGEXANkpTCgYuJykzDyXOq/svFu5H0LX0QzDPpx9u7acb6zv3SYr9hl9QG6wG+9B4gVdWWFBtOHlbsuxdlFIBRn30DDpOZvbaEgrGbs4kwM/+J28KuCSqIc8JU6SPOsOoE64QZba58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNfQgqtG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNfQgqtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9091F000FF;
	Fri,  2 Oct 2026 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958308;
	bh=ZpHAkAUEr8Xl3PYCBuALwZnX7kTAqTO4j89M73nBzd0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iNfQgqtGgT3dWHPL27LYCxX8M7xpbJaGHO5iR6zSzjzhWDl+o//WG9WvDMN2IXiT2
	 gTJ0uxJsuZMP8Fv5F+WdFKNUyUKW9aKRCBWfK9dbdggn8nMKChj/ptgHzXbAATyRYp
	 wcC6XMHSL1V3TK9xd2MzuOgGrvRVFl3Q8I+3cUNYkQKge7OOkR24oGUeB5Q/AQQPQI
	 ojHwB1gkeGWXYys59a79PSGJMapLfDADFYDITg3tPYGuL3Hl7szfhZz6MRSjFdDuXt
	 BfdvtpPo8xSQCmg5oi89wWlSC+TzM2bc6EdaF1jDjigpyQupHXoD8sV5Lxv81CbEcd
	 C4XuPihm7sxVg==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:47 +0200
Subject: [PATCH net-next v3 08/12] net: ethernet: cortina: Rotate free
 queue page allocation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-8-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
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
bitmap search at its end. This keeps allocation cost distributed across
the metadata table.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 2345d582cb59..87c537ae83e7 100644
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
@@ -1110,6 +1119,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
 	geth->num_freeq_pages = page_slots;
+	geth->freeq_page_cursor = 0;
 
 	expected = len - (1 << fpp_order);
 	filled = geth_fill_freeq(geth);

-- 
2.55.0

