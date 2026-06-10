Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE12E7391;
	Wed, 10 Jun 2026 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087150; cv=none; b=T8xKyaUkEiJj7kOy3trzi1BI72iZ3AlLC8lkSF/wVTNdnAZrxVmzn7f0151rrtrk1cJDKkEp5QfajvoTJ6yvE9+p6dK57KLJo4tMD7L0n/ZczVieU0wxmfzRJ4JozQbouzkpn7FXiFnguTPdXRXZk/9Yg408pNPbzqIMQ3i8gqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087150; c=relaxed/simple;
	bh=oX5BbV4IA5VtIuaY4V4jV1Z7lUBoCENJkyeMDCdExhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+WLFENC6cpg2xOo4c81bOF9bwzUXA7VF8qfbDsoibSfQjTw6gT8zNQc9w7uKImLLByZVokVr2+sL1m1pvlLiijb/80Vu1hM1LnI06bWxUqop2NZjaiJ2qMFzcjCYePOBK3AYtLJshmQDLaAXGw0sunZWQj+/k9eRcwVuNvCQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=21fhzstV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FMVWnfJT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="21fhzstV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FMVWnfJT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D7A081D00160;
	Wed, 10 Jun 2026 06:25:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 06:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781087147;
	 x=1781173547; bh=ua+MsSfJ1nq7xIj6IRwVYByuyNZmqWGOfAM4XPEugRU=; b=
	21fhzstVTlOp2AL7nxGOfK1eLofFN5zUnufa7gM/libcKNE2Bg/JWMFX+/Gzz5z1
	jSUmhKdEdZfXJqwvP7LvrsKsMtlH6hjgP8Ug6Lq9xM/HZo9JKHeSBX7W2TRsi0i5
	5JBvGX46tmBiS75yGjG0bTF5AHelSacqvLgvrRazfPNsN+3265vv39GtGXhexvh6
	gGRpK07l0or7vXpf3Sgkh6O+nuR/28jbCU4sw+jIwBCKpeA9hNPY0qThdOOAA3Uc
	KwOQx6657XDa0oB8TZWtafjo8jGuSJ1wEKZttljCwsltfR0q2vh6Sa1w/+WYpsIn
	NG0JfjMWwwp9+nt5nRNIpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781087147; x=
	1781173547; bh=ua+MsSfJ1nq7xIj6IRwVYByuyNZmqWGOfAM4XPEugRU=; b=F
	MVWnfJTfa2jnTsBpbVgCODED3HfyMnusOkgsOlppBfiTAg0MQVlhytaCGuLWori7
	bhrVHdGXQdRwdc80JrXGDm1oAiXceudckwQqiwcw085esFCbm8VA/3c2vY1wLgRd
	6rH+mvz9EgoRAm7lhoahpdEm065VyPfxLA7cJm9b6yEBNkluf5uhI7gcQa1rNOGR
	ZmSVp4SO+oCZ6G2D4atmc0eaidJvNRDkcHuGQS5qU+j/93RYVtfEJC1x1l2ZQg6z
	mlXVnSu7OzBhdJKId/sLS4JJYoKGdmR+f/IwdmsJpPrgr9dZJi4CKal4tirW6o2u
	peRoGUdkoIZzrdw0+rEew==
X-ME-Sender: <xms:qzspaprCdepDgLpKHOHUi2AJTH3tOMGPqjr2cH8ElMLVzN_h8D35vw>
    <xme:qzspahJXkd0MHgXhfVVmUg7o9b_iuZacKcAsh2PFVUGwG9VDBCnJi3yR0lXcz1VYM
    FxoeUHrRsLCd3X2lpcEx9qOtez8HKPQ8UnMUyK-cpaoJKp8uAKWFKc>
X-ME-Received: <xmr:qzspaujVzi1v-oASCBenUvQBM-o78yzuPKoP2EC2qbkeQnoZA2eJg0aPagR-TmnFQZLiVXrl4iimUZxH-59zJqd11-cHqfSgPtGD>
X-ME-Proxy-Cause: dmFkZTFUwBTAUIylSDRD/bGl3yGNPD5wJUQnT81UZNe+JWC4FSEgQz4+ANh4fEW2zKTIoI
    KS7kHZjnKpn2CDNJXxmj8ahqhyJ2du6WpXcqG6Yq6P++8nSoW9JAJGyxHIXi6N8QSW0geK
    1OZvtGnj+h4ATXCfV2pJ2bZsJDjK6Cix0kxNFXywfE7yc0I65o7ExBMR85T8XCN47RVqSD
    LBERs5pG2HpNha3RvhFhoCbr7PP+UTxjZRZ32lcxKRHfYWjqTzQA2PjK1twkTT/x75VYM8
    gKt36IwzoDgjN6gLHKb+CCgPd3hqulw0xEPnF/pYbqrzUvQzHhb++BLhMMq5XHTNgDTqj6
    VrdyZrHUpqyTB2VzyvR0w75qZhN1EFSgNw2yNu3uEEKPn3eNjfaIyoUogbaeTxry+1GK6a
    9mSFZzrocU+6yVpsQYU+u/nXjkaVcgPdlyRKtadT5bvsiNT3oG+mOn7CoGMzSJI7KGyfpV
    EKCnWQScFkzvlD++D/4i5ZeQFybumXTyNgQOwW5EA9OpMJBExERdvFFWgdTJmx9fpNqK/P
    XPaIXzommbPf8ZGnUKvd5W5xnJTNcJPG7TKNiKQcDqvWHV8WTlqp7X1IhtNxqQ2PcGKFVU
    34apiqRuHeQG3L+mwxci5hIWtniQ8xcyk97LvXI/5I3f+JnPArTY6bcaiPNw
X-ME-Proxy: <xmx:qzspai9D1lJR2PBQBD2uyw-GkH54iPmm809WRwvEtSkZSgN9_H8V1g>
    <xmx:qzspaqqL4Xo1D-HKIfzyUCXS91J2GEOVLbc6xWvnGGY5xfT1ENTFKQ>
    <xmx:qzspavM84TcjsA_nM9WNfGTUdUfq_6BqsuP73nitZiPO09WoFkTPNA>
    <xmx:qzspag6jkCbtQOa1hvg5dNUpCdgj0ph_v4JMjQ1cDIxY1tyF2Tj7Yw>
    <xmx:qzspahsIQr0zF4P68LQc2rJKUVPSFAxXifTs-QGyqIeWFR2wa2EP1Pfc>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 06:25:46 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 1/9] net: ethernet: ravb: Remove gPTP control from WoL setup and restore
Date: Wed, 10 Jun 2026 12:24:24 +0200
Message-ID: <20260610102432.3538432-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit a6a85ba36fd0 ("net: ravb: Move PTP initialization in the
driver's ndo_open API for ccc_gac platorms") the gPTP clock (if
supported) is stopped and started by opening and closing the ndev.

This makes the special case to stop and start it when resuming from WoL
redundant. As the ndev will always be closed and re-opened when
suspending and resuming the system.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5f88733094d0..77c0645a1c4d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3179,9 +3179,6 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -3201,9 +3198,6 @@ static int ravb_wol_restore(struct net_device *ndev)
 	if (error)
 		return error;
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
-
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 	napi_enable(&priv->napi[RAVB_BE]);
-- 
2.54.0

