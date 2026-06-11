Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCA382393
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214980; cv=none; b=qtQdN3FzlUFIA+dz2JgfeqRyxMNmgARuZA6xr8i6LJCUSZFoC9FNZFAj5PKV6Y24hDf2DY6ESTHXIeilEPeUhpLiYskcYfPx04wboan98fYXnomf5Ej97m3kgtqU24CCYdhlBMS6oVTiKoNQVUDh7ykFBMDuv/EJKsX+uNBM2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214980; c=relaxed/simple;
	bh=foaGKsWxVAZ0fuBFg2cEoqbAwbMdUpEQM34UVEYbzWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxW4lmOjjIZaBkGaau+75XN8Ivf6HjijLs2GxlmOQd9kfUi1ixB31oMhUNtGdgQNZAZ8KDTuV2qsehE+ZE8t9VZSX427b99BittsQPO1cJZvJDva36rNDSaQ0xwksdoF0h/mVUnDS91OrH7AJGYuXzj+iPtMvUUsQNxqh3mYKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK6SGaPs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK6SGaPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CDA1F000E9;
	Thu, 11 Jun 2026 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781214979;
	bh=h+jOyHqba0rH4zTadn64tIUKChLC1NBW+TRedVk1PYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oK6SGaPsDW2j6XlmDQWopczaVXcGFJQWR2fciWSwg2Tv2gnevmhyKkvfnlACXLg8C
	 NvIz08p676br/fm4E2J3Ddo49dbCefLF0syUTK4dJnDuyEt0XqxlU4KIz5cNOpe7T8
	 jvknULHppaco6gmFxYYhAoXQBsAtR8XtC0kVfWEsCByUsf370wdAD2ymeIgKLkqoBN
	 AnrBA8LU9AABYtNhLzT63rc2OtujdBH2k/1fT/sc90onQFKFPQsb6g4CEZioIuvtf3
	 nw7t+7bsTxsPSuyCUqbnXs/OOWqyU24hBbYf2oY8mWJv/EYYZDKYnYVA/98HnBaJWL
	 7UgN3i0U7PIFw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 11 Jun 2026 23:55:51 +0200
Subject: [PATCH net-next v5 1/3] net: airoha: use int instead of atomic_t
 for qdma users counter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-airoha-ethtool-priv_flags-v5-1-c11de08486d1@kernel.org>
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
In-Reply-To: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3

QDMA users counter is always accessed holding RTNL lock so we do not
require atomic_t for it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 504247c8bae9..9eb9b6a139b3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1812,7 +1812,7 @@ static int airoha_dev_open(struct net_device *netdev)
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
-	atomic_inc(&qdma->users);
+	qdma->users++;
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
 	    airoha_ppe_is_enabled(qdma->eth, 1))
@@ -1866,7 +1866,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
 
-	if (atomic_dec_and_test(&qdma->users)) {
+	if (!--qdma->users) {
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 				  GLOBAL_CFG_TX_DMA_EN_MASK |
 				  GLOBAL_CFG_RX_DMA_EN_MASK);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8f42973f9cf5..24fd8dcf7fca 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -526,7 +526,7 @@ struct airoha_qdma {
 	struct airoha_eth *eth;
 	void __iomem *regs;
 
-	atomic_t users;
+	int users;
 
 	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
 

-- 
2.54.0

