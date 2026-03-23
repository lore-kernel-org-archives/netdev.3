Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56D387357
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258783; cv=none; b=frxwXR4gjBd7At4EXL54SNvpFj8Zn0sHge/RwimE/DkDNuAosFkoLZUeIum1XPwCiApnU0mQz354juowRGojEag6sgyqsTaAKtK7OQrKUYR/6wiI5yeQR07Tm8Fiw7983UN+6foIQYFa8JKE3ySY7yFFkoyLxqxr6Yw/ZgYkQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258783; c=relaxed/simple;
	bh=RNR1EUTKKAcgh1q7y4WEUB3H7fiwM2yffGl/eVpVGFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOUWOFqbBw/TDhD+ILTlWbt6q44Qp0QkkfMP0Qj7sKF79do7jBjcGXaEMhApQajkgGVfTb97DLH0hW1TZzHlOcohDTAWLHk6kQSu2oY3V5geW4IfcGhlFCasxmjgsngX3afXakJHZFYJQEc+Q9L0vPTNLZ4CSH7c3XDNilbc3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jz597tg+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jz597tg+"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4390119C0;
	Mon, 23 Mar 2026 10:38:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1774258702;
	bh=RNR1EUTKKAcgh1q7y4WEUB3H7fiwM2yffGl/eVpVGFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jz597tg+/+oDtwoeNTVEJxDpoCB2j/j8tMfYwO/579aOfKZ6UzeMHA/YFWmKTSbkL
	 3N+p5K+tF1QF1bVZUi5KL2WLWcbHar2bIE/3iHbaN2c76PIsRtVFVMfeHBUsK4wfcr
	 64cbtV6qKxgByjKhtX24wJ2MPOtsAX9hJapGO57k=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: netdev@vger.kernel.org,
	imx@lists.linux.dev
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] net: stmmac: imx: Disable EEE
Date: Mon, 23 Mar 2026 11:39:33 +0200
Message-ID: <20260323093933.1785583-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323093933.1785583-1-laurent.pinchart@ideasonboard.com>
References: <20260323093933.1785583-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8MP suffers from an interrupt storm related to the stmmac and
EEE. A long and tedious analysis ([1]) concluded that the SoC wires the
stmmac lpi_intr_o signal to an OR gate along with the main dwmac
interrupts, which causes an interrupt storm for two reasons.

First, there's a race condition due to the interrupt deassertion being
synchronous to the RX clock domain:

- When the PHY exits LPI mode, it restarts generating the RX clock
  (clk_rx_i input signal to the GMAC).
- The MAC detects exit from LPI, and asserts lpi_intr_o. This triggers
  the ENET_EQOS interrupt.
- Before the CPU has time to process the interrupt, the PHY enters LPI
  mode again, and stops generating the RX clock.
- The CPU processes the interrupt and reads the GMAC4_LPI_CTRL_STATUS
  registers. This does not clear lpi_intr_o as there's no clk_rx_i.

An attempt was made to fixing the issue by not stopping RX_CLK in Rx LPI
state ([2]). This alleviates the symptoms but doesn't fix the issue.
Since lpi_intr_o takes four RX_CLK cycles to clear, an interrupt storm
can still occur during that window. In 1000T mode this is harder to
notice, but slower receive clocks cause hundreds to thousands of
spurious interrupts.

Fix the issue by disabling EEE completely on i.MX8MP.

[1] https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideasonboard.com/
[2] https://lore.kernel.org/all/20251123053518.8478-1-laurent.pinchart@ideasonboard.com/

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v1:

- Fix | operator placement
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 9d1bd72ffb73..01260dbbb698 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -325,11 +325,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
-		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
-
-	if (data->flags & STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD)
-		plat_dat->flags |= STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD;
+	plat_dat->flags |= data->flags;
 
 	/* Default TX Q0 to use TSO and rest TXQ for TBS */
 	for (int i = 1; i < plat_dat->tx_queues_to_use; i++)
@@ -366,7 +362,8 @@ static struct imx_dwmac_ops imx8mp_dwmac_data = {
 	.addr_width = 34,
 	.mac_rgmii_txclk_auto_adj = false,
 	.set_intf_mode = imx8mp_set_intf_mode,
-	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY |
+	.flags = STMMAC_FLAG_EEE_DISABLE |
+		 STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY |
 		 STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD,
 };
 
-- 
Regards,

Laurent Pinchart

