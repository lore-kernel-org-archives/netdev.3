Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE33E4C8C;
	Thu, 14 May 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767510; cv=none; b=RdSPiTBJtKBIRO89FaOVZnaRuiwH5HerQJB3yXU+OSSOr5ZKTEi4lVG9wo8TAeCZKWq8NYpZxw4kDPbzKbK8J7KYrQx081+LgZ4dxwvXDEtWzLL1/ilJtfbzRbRw6pEqcYH0EX2lwQfhLxm5bRLCprPyNitEdvhzpCHcLUId9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767510; c=relaxed/simple;
	bh=UW9LozaCWhzBJU1oVOiF83obCfIySHe63FPCPr3Zo90=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5SloP+2TjuAfwgYk0H9ltNLDCy/gczw4ly8+QBTZyJjbkeXVezy9GY0SaCotatnsr/RRik7TNxubbt09MoOc2QlBgEHd6TpSeHyLbnMPYtKA0xMz0jrMM7Q+P+MJ8e1FAMt/clmbj6X0ihtcBl2SGLdU7wi3GwPd84t0qR5fd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wNWgR-0000000046C-3uKu;
	Thu, 14 May 2026 14:05:04 +0000
Date: Thu, 14 May 2026 15:05:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 4/5] net: dsa: mt7530: clear flood flags on bridge
 leave
Message-ID: <cc8d2f494dd202304a6f68332f3a90ea0a8a4618.1778766629.git.daniel@makrotopia.org>
References: <cover.1778766629.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778766629.git.daniel@makrotopia.org>

Flood flags set by port_bridge_flags persist after a port leaves the
bridge, causing unknown unicast to be forwarded to standalone ports.

Clear UNU_FFP, UNM_FFP and BC_FFP in port_bridge_leave so that the
port returns to its initial state without flooding.

Fixes: 5a30833b9a16 ("net: dsa: mt7530: support MDB and bridge flag operations")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/dsa/mt7530.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 752ba92b0851..5b58e42bfda9 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1767,6 +1767,11 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
 		   MT7530_PORT_MATRIX_MODE);
 
+	/* Clear flood flags so they don't persist across bridge leave */
+	mt7530_clear(priv, MT753X_MFC,
+		     UNU_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
+		     BC_FFP(BIT(port)));
+
 	mutex_unlock(&priv->reg_mutex);
 }
 
-- 
2.54.0
