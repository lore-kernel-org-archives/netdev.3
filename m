Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE83BB11A;
	Wed, 23 Sep 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168289; cv=none; b=NeDx4HuVF55ffR/QCxTMD9zlrWPo/+e9wg6nw4VzmJpzIAXfCs1zmy2t6jiG8s8yhluanASi63mEcP+bh39M492/j0bJ6rMjdZ0eEIkqw3GBoIu6jnmp2TzTLxpX3AGS1yQHQnIwatw3Bwa4nhtzZiciASJnNFexw6xi/GMfCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168289; c=relaxed/simple;
	bh=1cvulwbZpc7KtbSdU+12nmY0R1TzYL2NXqFn2pPAuro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1rA+0dKsJDKqUzrwyYLcKLi2vyu+ERM/RQpwZ08HJ6hb+Mhiy7X/SI9kOaYF6vWdcxIhb4Gx/fGA0GEH2dsQhnJ2anKVsr0qiHSdO5/UAlLOl4i4viAlVo3MG2vhf8tE1Emw5Cutp6Ha7B2BXafH2xjVrijwVAWAKn2zIAEvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxH8ftYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxH8ftYH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35855C2BCFC;
	Wed, 23 Sep 2026 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790168288;
	bh=1cvulwbZpc7KtbSdU+12nmY0R1TzYL2NXqFn2pPAuro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KxH8ftYH3nVKn2okzSpD/OqhipjgwCt17OoEGJ9RLx58oOdJJYnWJitjU9Wr51lCn
	 g0BilU7QUodmH1wYPCYRgBZVz0DY1TRcWPEFOud9suCvOXvDi6Qj9e/f1V8lKpcFxi
	 CTYYcmxvD89mC32mFAC1kdr2CkgDBq77BTME5sQDPsZCno8FES3nIL09PKmiqYztyg
	 ha8Nwg5TSOAL86oPqNq/7uPKIg8If6olRYJwuoUGf/++JulqWL7j/ThGuco4qMJLm4
	 1v3eM/pvcyCYPiYpNuAFg6X4iirlyNM7L6M4uQFH9XHsrCaGFm5bKoPlpQqdh2pUGA
	 CeSTbzGhcICPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16552C9830B;
	Wed, 23 Sep 2026 12:58:08 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Wed, 23 Sep 2026 14:58:01 +0200
Subject: [PATCH net-next 2/2] dpaa2-eth: DPNIs without a DPMAC should be
 virtual devlink ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-for-upstream-dpaa2_ports-v1-2-b59c865edd00@free.fr>
References: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
In-Reply-To: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790168287; l=1873;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=p/tRI7VLwMp8un0siHeJSm+K06WfFyI311A5CyvuR9c=;
 b=7UbZF4ftv6wUuedkckRvkZ6wyYKYj1SZyQUot5FiHlSjeBR15Ae2+Cr53MJT0/YyFBSDN7j3H
 WCnHvtUiin9D5wAM/lXCz18PUxt+9X9RGCt/ZrDliqWpASckHlu/dev
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

A DPNI whose endpoint is not a DPMAC has no physical connector: it
may have no endpoint at all, or be connected to another DPNI or to a
DPSW port. It is still registered as a physical devlink port, number 0,
so userspace sees a physical port that does not exist.

A virtual port has no phys_port_name, so only the DPNIs that serve a
DPMAC report one, and "p<dpmac id>" never collides.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
index 8b2addd3f83a..30e6cb2190db 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
@@ -230,16 +230,23 @@ int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv)
 	struct devlink_port *devlink_port = &priv->devlink_port;
 	struct devlink_port_attrs attrs = {};
 
-	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = dpaa2_eth_dl_port_number(priv);
+	if (attrs.phys.port_number)
+		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	else
+		attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
 	devlink_port_attrs_set(devlink_port, &attrs);
 	return devlink_port_register(priv->devlink, devlink_port, 0);
 }
 
 void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv)
 {
-	u32 registered = priv->devlink_port.attrs.phys.port_number;
+	const struct devlink_port_attrs *attrs = &priv->devlink_port.attrs;
 	u32 current_number = dpaa2_eth_dl_port_number(priv);
+	u32 registered = 0;
+
+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PHYSICAL)
+		registered = attrs->phys.port_number;
 
 	if (registered == current_number)
 		return;

-- 
2.43.0


