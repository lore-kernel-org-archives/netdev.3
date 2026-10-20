Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512946;
	b=sJtfXMN7K3IuZ6wBvMCooqieICiZ3KVNBA2DJ7fhPggbb8cQ5NiOtos1JTA6gTMHj+le
	 nzV7N002nwAON9bna8m1MN2ngLbcTnqI2xQPwpcyDtpSH9gTVhJ2IJO03fl49y6V+JQ+/
	 EcFs0UnV2PHlqGebsFZs1mrzzqs9ngwUXTzXyBqx4HakHe2hfw+VkI+H8Tnyq85j2Y+Ds
	 dPdtbzlHIgtRg2eX75FU2OD0ruE8zXWrtBGu4OoNRFkt3pX5m1g2+5sawtaqzYWL8m0p9
	 9ZcUtmCMCzWvxvx+Bg11Gf/e6fAZACxnCIyvsAJbpGI1EC/M+tIlw93HhxEsU6Ot6gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jhi+Gy6QvyViB7QdmrhjBmEWelHbbWlA/V7dTA0A7ck=;
	b=LCngLMmWKKSYMoLIYgBOwf19QBZel6SoJ53VAOwwkMF+iomj4w/C801waWqgvNty7ma7
	 pbrKO9Ajxn8IVPY0PRZB1gM1VJm76Q1ytTCMpm2zykZVUpuTcsY4XiQX4A2l6OqgZ6ASB
	 FU13vgWx7Gy5KaKPwZt3O/Itzj4I1mc5r8hI2AKY/nG+pJveW0/KlDVy0BedQAMgKsrjE
	 EexVeph1XPK2dAbTXs4+y4wJ+3K0nRdmQG/twhWwR3vAzzv7D/cvmp2lhdVVILgfU31ZP
	 OtM+sqzGd6KT0VHDXxY2ccELnK0wo50sF7/wByUU24wdrgnULI30Upy4xBTOlhQ0COQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZdC17DZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D33606A32C;
	Tue, 20 Oct 2026 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZdC17DZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C801F000C4;
	Tue, 20 Oct 2026 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792512945;
	bh=jhi+Gy6QvyViB7QdmrhjBmEWelHbbWlA/V7dTA0A7ck=;
	h=From:To:Cc:Subject:Date;
	b=VZdC17DZqza6hbz5Oaao6qPBCDRXocil0B76rRBuTmzIcmvv2HTX3V6HU3Fe7sjQ6
	 QsRsKpSu8DiOLOWfsl9GizT5Slp5eLMriM1B1tFYIncWTw86Xpx522fH0quiuMlmqH
	 sYzY18PGVBGGJurM++wavsIgoUMACt2/AXZp/AOhisy1PA+kyDyvLqru4RR0n/s0Nz
	 X8papsIyD/A+A/DYUAmc4qXFwss0wpPRWf+2R30UUiviYnb4L/C3rWmcJ3VTt0G85g
	 jTuiC+phlcP4IywfpO4DzSVm/aU6qofP5yBBS2gXioUlZi+Nv+8/X/zKU3m6N3o+h4
	 3Mrjer0aSA33A==
From: Sasha Levin <sashal@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Javen Xu <javen_xu@realsil.com.cn>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Dennis Piecha <d.piecha@ymail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] r8169: clear TX LPI on RTL8168h at link up after phylink conversion
Date: Tue, 20 Oct 2026 12:15:42 -0400
Message-ID: <20261020161543.3712208-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3cdeaef1754a ("r8169: disable EEE on RTL8168h/8111h") disables
EEE on RTL_GIGA_MAC_VER_46 with phy_disable_eee() but keeps the version
EEE-capable, so that link up still calls rtl_enable_tx_lpi(tp, false)
and clears the MAC TX-LPI bits (ERI 0x1b0[1:0]). rtl_hw_start_8168h_1()
does not clear them, so a warm reboot from an EEE-active state could
otherwise leave TX-LPI asserted while the PHY no longer negotiates EEE.

In net-next, commit 8a3c76523e44 ("r8169: add support for phylink")
moved link handling to phylink, and rtl_mac_link_up() does not touch
the TX-LPI bits. The merge of net into net-next kept the
phy_disable_eee() quirk and its comment, but not the link-up clear it
depends on. The only remaining clear is rtl_mac_disable_tx_lpi(), which
phylink calls from phylink_deactivate_lpi() only after
phylink_activate_lpi() has enabled LPI. With EEE disabled on this chip
that never happens, so the bits are never cleared and the comment in
r8169_mdio_register() no longer holds.

Clear TX-LPI explicitly in rtl_mac_link_up() for RTL_GIGA_MAC_VER_46.

Fixes: f49defea7668 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
Link: https://lore.kernel.org/all/0e0b727e94d046b19ad463e7a1a9fe68@realsil.com.cn/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
llminus, an LLM-assisted merge conflict resolution tool, found this while
resolving the same net/net-next conflict in our integration tree.  Not tested
on RTL8168h hardware, and the warm reboot case was not reproduced.

Javen's proposal in the linked thread, returning no LPI capabilities for this
version, has the same gap: phylink then calls neither LPI op.

 drivers/net/ethernet/realtek/r8169_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 88354e7570f00..cd4ebc654dd0b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6428,6 +6428,8 @@ static void rtl_mac_link_up(struct phylink_config *config,
 
 	tp->speed = speed;
 	rtl_link_chg_patch(tp, speed);
+	if (tp->mac_version == RTL_GIGA_MAC_VER_46)
+		rtl_enable_tx_lpi(tp, false);
 
 	/*
 	 * Note: This hardware does not support forcing flow control.
-- 
2.53.0

