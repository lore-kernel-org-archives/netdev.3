Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F7344DBD;
	Mon, 11 May 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496604; cv=none; b=pppwM5dtO6p9AKCa/Unch7hwKSGcYpy/D/RWn4J+YdVfR30pvzdoYOT/Cdrfs+SyTyqgp/rOMjtyT1ENxd174Cq29BiaYqbqjJGbtATl6GSX0CS+i7z6iq+hPwuGQuYxe9ZJRP6hwLK/3x4yjV8dQsSSM1ZH3nkF/ACvpBm49UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496604; c=relaxed/simple;
	bh=zmwlVeCuGb8e15Nr4SuNdxRdi8GRQGQTNCXUJdFwJgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qicPuF8GxygN6p8vAuuLuiEHzHafOg4c+Gb211uWq1CmqBGddWh7Ev2Xn3ysW0Vbjn/Cyq5E3GTOY5zgICrx12FEgF+BzFBjyYJEbrSDa9BfGB9KRkaOn6ZCpuwvAS4Ir9TPvhE7EJrzVepIT3vioZ2pax+qdTn6Lnd87PeQKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csz8Mnzo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csz8Mnzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D89DC2BCFA;
	Mon, 11 May 2026 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496604;
	bh=zmwlVeCuGb8e15Nr4SuNdxRdi8GRQGQTNCXUJdFwJgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=csz8MnzoUHz1HcdjmeDqMF2QUZh9s4mFhLZo5P6x/QfDq0qpP71JsxPxVh4BFq2vd
	 DBornmdg+SxLo+JAFcRwnxmydO+I82OhhjGSgwOCG1ySCR4Y7lIRkTf/eNaAKe8GqG
	 aDSt63HBjkKClREr7nse9mvmAi0V+ZSp7SgMsbDafA85Vrmk10W/+rUZA4nO8o4s/U
	 nMVIO/ZM/shqza4BqYefgAgzFI/UdenKyApnGyLb9WS5Kk9T3MH8BSR3Y4s3YR8bGW
	 9fp0hVeKWhEi5a3aL7PFmMNBW4zklxdILNDYYb/X3bpF++pkO6cN411v6ChC9pv8jE
	 5vQNY6FUewG4w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 May 2026 12:49:31 +0200
Subject: [PATCH net-next v6 05/12] net: airoha: Rely on airoha_gdm_dev
 pointer in airhoa_is_lan_gdm_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-airoha-eth-multi-serdes-v6-5-c899462c4f75@kernel.org>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3

Rename airhoa_is_lan_gdm_port in airhoa_is_lan_gdm_dev. Moreover, rely
on airoha_gdm_dev pointer in airhoa_is_lan_gdm_dev() instead of
airoha_gdm_port one.
This is a preliminary patch to support multiple net_devices connected to
the same GDM{3,4} port via an external hw arbiter.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 ++----
 drivers/net/ethernet/airoha/airoha_eth.h | 4 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e0cd401bbf67..3510b088ad15 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -73,12 +73,10 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
 
 static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
 {
-	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	u32 val, reg;
 
-	reg = airoha_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
-					   : REG_FE_WAN_MAC_H;
+	reg = airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H : REG_FE_WAN_MAC_H;
 	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
 	airoha_fe_wr(eth, reg, val);
 
@@ -1865,7 +1863,7 @@ static int airoha_dev_init(struct net_device *netdev)
 	int i;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
-	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
+	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
 	dev->dev->irq = dev->qdma->irq_banks[0].irq;
 	airoha_set_macaddr(dev, netdev->dev_addr);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index f1eea492217c..f6f59d25abd9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -647,8 +647,10 @@ static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
 	return qid % ARRAY_SIZE(qdma->q_tx);
 }
 
-static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
+static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
+	struct airoha_gdm_port *port = dev->port;
+
 	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
 	 * GDM{2,3,4} can be used as wan port connected to an external
 	 * phy module.
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 22f5f1bae730..047141b2d6d8 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -362,7 +362,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 			/* For downlink traffic consume SRAM memory for hw
 			 * forwarding descriptors queue.
 			 */
-			if (airoha_is_lan_gdm_port(port))
+			if (airoha_is_lan_gdm_dev(dev))
 				val |= AIROHA_FOE_IB2_FAST_PATH;
 			if (dsa_port >= 0)
 				val |= FIELD_PREP(AIROHA_FOE_IB2_NBQ,

-- 
2.54.0

