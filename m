Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216430F951
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186049; cv=none; b=Hv3WEZEmm/BGfzbNKH24P6enq1J38X0bDyfYPcVifzgQ1XjdQ60mjvo2MucwDzUMBy1LimpuWr5sZf8rcPAokQMiyOhqwuAmp47iPSKBuQPuMlc538KF4hNJnJ12KkJMNwswMgNC2IsKR5LZcy38rTP1PsrXyyAHD+SCqocvLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186049; c=relaxed/simple;
	bh=evlWwRpQocCTtsky9/1dW6fL/XC9eaZI58HHtbgsDyQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gUETCw0R9iygRrfqDnXXL87TsUCPqnIcfxd+tcmjQbXT2650+iYzj8C2p9qL/QRu3WVTPkxkqFMslxJxkjtME1YEXL9+HOW/M0JbTldqop/2YAfUM5cWI64rjk0Y2OjmFSidDhrvQTkUxXT8Z0foWFvrZTsbwJ2wuKcaqtdj+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KE8f+Eon; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KE8f+Eon"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eS9rupgpIxcOxJ6kq6XUeoOt3FlGtJ7fyDMVdsz4J5Y=; b=KE8f+Eon/Ske70O71uDarOGWSQ
	ss6RTWJ/Y/i2my+egHuGkpv+eJ33D7WWphnwN1qfUVGqZJzGGdtofXP4lT2aG763Iq5XyMlwkc9AY
	Ru2I1B6s2E99xQoAbY7pBRtZT+PdA3u9KOQbAd7DS01gLFwHgmLnRKNyg4iyJi2ol1eB0XKyVvBBu
	ow8iCs78bb3pQQRsuUjO3FgGqMlRt83Nhyc08+cCKI2/ixsDQnNM6j9N3Fbzfe59l/pPXPMtgBu4g
	fVdKibFAWnVBlLGYbTFRIAEbm6wRUjz7mvJWq7FiDy0InHicaBdgqiYaa9OftFzZ0uBL35EDBraDO
	VEfeJQ6A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42706 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuXc-000000000dk-24Am;
	Fri, 27 Feb 2026 09:53:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXY-0000000AvnF-2ccv;
	Fri, 27 Feb 2026 09:53:44 +0000
In-Reply-To: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
References: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 08/14] net: stmmac: remove mac->xlgmac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXY-0000000AvnF-2ccv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:53:44 +0000

mac->xlgmac is only ever written to by the dwxlgmac2_quirk() function.
Remove mac->xlgmac, and the quirk function that then becomes redundant.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 1 -
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index d26e8a063022..42a48f655849 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -635,7 +635,6 @@ struct mac_device_info {
 	unsigned int mcast_bits_log2;
 	unsigned int rx_csum;
 	unsigned int pcs;
-	unsigned int xlgmac;
 	unsigned int num_vlan;
 	u32 vlan_filter[32];
 	bool vlan_fail_q_en;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 7e69ff4b9a98..1fcc91be7589 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -97,12 +97,6 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *priv)
 	return 0;
 }
 
-static int stmmac_dwxlgmac_quirks(struct stmmac_priv *priv)
-{
-	priv->hw->xlgmac = true;
-	return 0;
-}
-
 int stmmac_reset(struct stmmac_priv *priv)
 {
 	struct plat_stmmacenet_data *plat = priv->plat;
@@ -293,7 +287,6 @@ static const struct stmmac_hwif_entry {
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwxlgmac2_setup,
-		.quirks = stmmac_dwxlgmac_quirks,
 	},
 };
 
-- 
2.47.3

