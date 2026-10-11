Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E19331EA8
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791741992; cv=none; b=JBDClDpRhiHP2x0f9edynWSHzkTnicHQRGDsmYQny1yiXS7h6XuWs5zZUM6vxk7B2OFPXhKqxncQHkuWBngspcWi/ZMA2nwnwbY77TQhZFzwpjhhJxrV1mr8fy7+bt3D1eml02Pm0P/nBgSvw9KSz90uh4p8IDyo463USWR22dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791741992; c=relaxed/simple;
	bh=PS8DhlHagdAJFAEV+imrDrUkOJuT+YQCVkJZOey7wEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/SO+aXuIAylaWkLcYaXszpMbNXfQJDs28eynaD4ODTysPQGxdAc2eO/MRWswW06eL5ZHew8ZQ1iqVhyMNHxMmt2gzAgA8YQ6FLdzvlqP6xByQOWzJlU7PUSN5COs3olzxel/y+Kb+sp6boWc629T9Lnac6Dr6xC0sAgAVvjRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6Gmfzxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6Gmfzxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54491F0089B;
	Sun, 11 Oct 2026 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791741991;
	bh=E4XrRCLBNE/SzReQS5fxbIgsfRDYV6W3vtVWDPWoABs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A6GmfzxmMmRp6H1Rn3nsjiRwXZNO2dNtEIHIh67DgWaNbtfrDNhRH/RlZF8x6aTWo
	 6LvYDYoUCECFjpXJr+PyuIloVyEfuqR8ISzl6kN094YL/kweXrCbogMpcTAIGiQ6hv
	 R0EF0CPVNrPsPmnVu5nZYYUlRVa1RoavDxrowIlWMoZQaS7gbEMTeOncqyaUX2CYr5
	 VW5rXKuBC6As0m4/XBN+3qWQmJh6o0NM82dBl+72Zm2emg+1vYVBZCN3/TpLD29Frc
	 ZfTzVQegrhWvZ9S7ntrxn6h1TrC0BTRK8qih+Vau6CY3MkDK3Rykbs2X5sPlif+BYU
	 SpwvyN5pUYaKA==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:17 +0200
Subject: [PATCH net-next v4 04/15] net: ethernet: cortina: Normalize free
 queue pointers on rebuild
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-4-4b1631b08f5d@kernel.org>
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

The free queue pointers can retain positions from the previous ring when
the queue is rebuilt at a smaller order. Using an unmasked pointer to
index the replacement page table can then access it out of bounds.

Reset the pointer register before initially filling a rebuilt queue and
mask the page index to the active queue order. The mask also keeps the
index safe if hardware retains its read pointer while the queue is
disabled.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index c03541deed49..c3d1abdbebf6 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -887,6 +887,7 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 
 	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
 	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
+	pn &= m_pn;
 	epn = (rw.bits.rptr >> fpp_order) - 1;
 	epn &= m_pn;
 
@@ -958,6 +959,9 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 		if (!geth_freeq_alloc_map_page(geth, pn))
 			goto err_freeq_alloc;
 
+	/* Discard pointer state belonging to the previous queue geometry. */
+	writel(0, geth->base + GLOBAL_SWFQ_RWPTR_REG);
+
 	filled = geth_fill_freeq(geth, false);
 	if (!filled)
 		goto err_freeq_alloc;

-- 
2.56.0

