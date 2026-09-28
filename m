Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50344A5C54;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594568; cv=none; b=NyIjP7oFLMQ1tfsYTNPU3rWdQevbGzDHF3n4OtPaIuGVFGVmLRvrktVlw23s1hiv3A/VBDv5l+/xrsJJUZ34Y+7pCHkCIEMn90+Gsok7Y5p0HyTsDayQC4djX2lpLsBCVLkXdsFbbTNdu5BiW4ONUbq+cb7lNiQEEFzhTw6SadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594568; c=relaxed/simple;
	bh=I8FU2VMH9Cg41tf2voAO5j1Vslvoq7wOp6q/hU8Lxlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+Pjtm96/zHrWTkmc8yayMemjpCOH9ly2BFZO8ktNjGTBLHbFYXORClP9IUbeucILxlXxbJ/dTZSDtsEvdyjdistvkYHnfpbYQ1MJf5wLbqCKDyuUdFJ5Ck+QhYdQ6YYkuwrtdeiWkH6erRdGYbVm/rZuLGGAalHtQC6flMWrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JReAxmyF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JReAxmyF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6BFEC2BCF6;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790594568;
	bh=I8FU2VMH9Cg41tf2voAO5j1Vslvoq7wOp6q/hU8Lxlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JReAxmyFuUZQjuZWYmhHDVR4ThDXwSB1BiAKs+8cHpwA4Thzs0ZvVu+psKEzCLl+Z
	 6cKymtH7UVat7x2RNShEsjl4XwRa7rkgK6/pExBoCN8N/TS1a8xk8wsYzOkj0nYG8I
	 Tv97zDQUKRXif0CEUTGYcyrAV1AMMvCzAK1QlUFPArhQHNbCxdURB0sWlrg61yDG98
	 pboCANFh6pyWM/WxuLmckO2eV6GGZV8m8iOohWGJSeeDGTe8K1i+t/Xm9XOzgDUPKI
	 1+SPWtCJvVOiSFdBS8EDZkfzyRC2fX6Pgi0GddFBx01YaDgkVakjnMwHmkA93B9Ibw
	 EZJU1NvRSzZQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A39CA5FA2;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Mon, 28 Sep 2026 13:22:46 +0200
Subject: [PATCH net-next v2 2/2] dpaa2-eth: mark DPNIs without a DPMAC as
 virtual devlink ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-for-upstream-dpaa2_ports-v2-2-1cda148530bf@free.fr>
References: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
In-Reply-To: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790594566; l=1468;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=3YGJMDPaMDzgW71kznvDVaigwXmYnYuAduxFzGsju8g=;
 b=gpjUniYcuC+Qe5vrx3IlrqALzspy2ZUXoss6j4BUCCbJkk4umwE8zC+vKI0I2iUlpRnCRCEnE
 FzIuJpaxXe8AxIhMRlH2d2DReQwZbxw8WLsDjtpJydh1r588O23Y3Tv
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

A DPNI whose endpoint is not a DPMAC has no physical connector: it
may have no endpoint at all, or be connected to another DPNI or to a
DPSW port. Until now, such a DPNI was still registered as a physical
devlink port with number 0, so userspace saw a physical port that does
not exist.

Register these DPNIs as virtual devlink ports instead. A virtual port
has no phys_port_name, so only the DPNIs that serve a DPMAC at probe
time report one, "p<dpmac id>", and those names do not collide.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
index 4c0a04c2d458..6defc00199bf 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
@@ -233,7 +233,10 @@ int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv)
 	priv->dl_port_valid = true;
 	mutex_unlock(&priv->mac_lock);
 
-	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	if (port_number)
+		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	else
+		attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
 	attrs.phys.port_number = port_number;
 	devlink_port_attrs_set(devlink_port, &attrs);
 	err = devlink_port_register(priv->devlink, devlink_port, 0);

-- 
2.43.0


