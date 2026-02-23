Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A235CB88
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849256; cv=none; b=KT5crTOGRHYejGcddjsdiUonXTnAaTnyxOayKdc9H8eb9SpxCFZQKkQA/GRdZWnyemeqT7kDVcppSeKzZdP1RwhtXO3VIun9IkELbaQCx7iUwS/bwlhaOO0FH+ocWkXkmtyuCY5gXPhl3qlqoAHtVw2+yKM+MbEaGrToUOkv1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849256; c=relaxed/simple;
	bh=2iw31Z3kkBHhRKv6DMZP5bmlXP59rxyO/rw+K6orc28=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=dzzhBLmj7yQK4EqQLjLEFw68gen3V88cV+UFHkFUnht7Q8Whyz82HHcjPPuRnLizA6uWsAxu1MayvjXZbpr+eL46E+3seQJHK790NTgAWWp4AF61cuqyUg2lw6RcSJpQBR8F68IA8WEa2DT7m3Dp4CgLNntua11yHhB8VEpqnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X6C/85+N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X6C/85+N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WlXYakfMf+ynG/+XvFLVLTMU3fE1qwrOnQf6HbLOsMw=; b=X6C/85+Nwi1gOJWplZ32FYoSY5
	TDVf8Feo1ixuSE67TSMw0cTbesCppzibNmxdC5pWPcFd1gFoUhBAp1DaTfzbjoC1FTjV3bMNlj7uJ
	4RlfLj3XtWxkyqlOuDanF/VAtZ4f2a0pV2pEPvM9fRrunJ9RGrYuBqP7AdfjpujiMet5AyvYkG0iA
	wMe5V0D4dmsdajd+dP2rvioxi/TpjNObB1DlbjWnxAQanpDPfUUpBIILLBt3c/DeLu0u7+wyAGq/g
	TRKZCXog6espy1uvkC2Sq+HkK9BcP0C3NqqdS4P6bUUqvBq9uEzmxnpsVrz9XsgjRyndujc+3LPFA
	qapvn5BA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41386 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vuUvf-0000000043Q-3ja9;
	Mon, 23 Feb 2026 12:20:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vuUvf-0000000AfhS-0lJR;
	Mon, 23 Feb 2026 12:20:47 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: ptp: limit n_per_out
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vuUvf-0000000AfhS-0lJR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Feb 2026 12:20:47 +0000

ptp_clock_ops.n_per_out sets the number of PPS outputs, which the PTP
subsystem uses to validate userspace input, such as the index number
used in a PTP_CLK_REQ_PEROUT request.

stmmac_enable() uses this to index the priv->pps array, which is an
array of size STMMAC_PPS_MAX. ptp_clock_ops.n_per_out is initialised
using priv->dma_cap.pps_out_num, which is a three bit field read from
hardware.

Documentation that I've checked suggests that values >= 5 are reserved,
but that doesn't mean such values won't appear, and if they do, we
can overrun the priv->pps array in stmmac_enable().

stmmac_ptp_register() has protection against this in its loop, but it
doesn't act to limit ptp_clock_ops.n_per_out.

Fix this by introducing a local variable, pps_out_num which is limited
to STMMAC_PPS_MAX, and use that when initialising the array and setting
priv->ptp_clock_ops.n_per_out.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

This could be a user exploitable bug (although one has to be root
so the gun is already pointing at one's foot.) This is the commit
which introduced the problem:

Fixes: 9a8a02c9d46d ("net: stmmac: Add Flexible PPS support")

 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3e30172fa129..cf5506bf2198 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -334,13 +334,14 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
  */
 void stmmac_ptp_register(struct stmmac_priv *priv)
 {
+	unsigned int pps_out_num = priv->dma_cap.pps_out_num;
 	int i;
 
-	for (i = 0; i < priv->dma_cap.pps_out_num; i++) {
-		if (i >= STMMAC_PPS_MAX)
-			break;
+	if (pps_out_num > STMMAC_PPS_MAX)
+		pps_out_num = STMMAC_PPS_MAX;
+
+	for (i = 0; i < pps_out_num; i++)
 		priv->pps[i].available = true;
-	}
 
 	/* Calculate the clock domain crossing (CDC) error if necessary */
 	priv->plat->cdc_error_adj = 0;
@@ -350,8 +351,8 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	/* Update the ptp clock parameters based on feature discovery, when
 	 * available
 	 */
-	if (priv->dma_cap.pps_out_num)
-		priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
+	if (pps_out_num)
+		priv->ptp_clock_ops.n_per_out = pps_out_num;
 
 	if (priv->dma_cap.aux_snapshot_n)
 		priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
-- 
2.47.3

