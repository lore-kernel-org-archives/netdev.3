Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69E194AE6
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733822; cv=none; b=Eidu+hZhiDVDSb+vaXtNgpan8UhPV4X68O8fI+uGUrfOLmjDpS3/XbchkX7185vREv5gi6Lun3b4LSbP2+9JB8o3s77AHov++LxDipmoQLql6bYAhpruZNvWF+UlZuf5HXvzRZ6JZLpWT2AYZtz2Vw6gcR2LCL8yhoQRF0iff2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733822; c=relaxed/simple;
	bh=zjBCLixLHvRboyUseTLBPn9w9WpYjxLqjB5qFzsA01k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=p0yQ08fedJHct30lU/kC0wV57qwg+CQ5kgQajYTDX+RVFLfk7w5tQ7M2h1wonhen+hLljk8V/c4N02OP6g6KrsGWjMf+JWBtL3V53vs/KTzIzHrXkbCDRoVZ2QSZfKSWNc9CTDqEOlbOb9u2rfrBmiWuHCspj01QYRei5oXwJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MWTCshwQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MWTCshwQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BW1hhmXXWTLU0JxQeAvbat9bJsdPkpNBSt+Ets8c1vc=; b=MWTCshwQGA7nyqyfIrzSr69yBp
	PGajwaeP3i/NgsVO5jck8ZWH547IBneEu64GYq0VNux0ysnLIbsCxDj90eDn8nildZbHEZx+d/qBA
	yTHJu0sawC1x1SlytqfWkbfUDo1crg9kYf5pZ3esN/na69lufoIXA3NT568DNcGhPFzPY5CoD7+22
	usFqn1jdBKNrT9uhAt8V+L42WaUeRb8n3+qgT9UDZADVaciFfUjbvTYYGp80+p+FnwKqTvwl+wOi6
	ffZpgowJtPz8L7aqB8DncGRXBO6/hZp17BxQnIWTggxOZNTxaJAZOGBQTyGq1pkVAxvv8OHnjZxhr
	ndIVN20Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33086 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w6bKu-000000007S5-3odc;
	Sat, 28 Mar 2026 21:36:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w6bKu-0000000ELtr-0U6v;
	Sat, 28 Mar 2026 21:36:52 +0000
In-Reply-To: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
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
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 03/10] net: stmmac: move TSO VLAN tag insertion to
 core code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w6bKu-0000000ELtr-0U6v@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 28 Mar 2026 21:36:52 +0000

stmmac_tso_xmit() checks whether the skbuff is trying to offload
vlan tag insertion to hardware, which from the comment in the code
appears to be buggy when the TSO feature is used.

Rather than stmmac_tso_xmit() inserting the VLAN tag, handle this
in stmmac_features_check() which will then use core net code to
handle this. See net/core/dev.c::validate_xmit_skb()

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e21ca1c70c6d..ed3e9515cf25 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4419,19 +4419,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	u8 proto_hdr_len, hdr;
 	dma_addr_t des;
 
-	/* Always insert VLAN tag to SKB payload for TSO frames.
-	 *
-	 * Never insert VLAN tag by HW, since segments split by
-	 * TSO engine will be un-tagged by mistake.
-	 */
-	if (skb_vlan_tag_present(skb)) {
-		skb = __vlan_hwaccel_push_inside(skb);
-		if (unlikely(!skb)) {
-			priv->xstats.tx_dropped++;
-			return NETDEV_TX_OK;
-		}
-	}
-
 	nfrags = skb_shinfo(skb)->nr_frags;
 	queue = skb_get_queue_mapping(skb);
 
@@ -4932,6 +4919,14 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 	features = vlan_features_check(skb, features);
 
 	if (skb_is_gso(skb)) {
+		/* Always insert VLAN tag to SKB payload for TSO frames.
+		 *
+		 * Never insert VLAN tag by HW, since segments split by
+		 * TSO engine will be un-tagged by mistake.
+		 */
+		features &= ~(NETIF_F_HW_VLAN_STAG_TX |
+			      NETIF_F_HW_VLAN_CTAG_TX);
+
 		/* STM32MP25xx (dwmac v5.3) states "Do not enable time-based
 		 * scheduling for channels on which the TSO feature is
 		 * enabled." If we have a skb for a channel which has TBS
-- 
2.47.3

