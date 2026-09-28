Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70947141C;
	Mon, 28 Sep 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630371; cv=none; b=ovLrYxYlfKzIzQjNoWZo5NF0i7+lsIeNkkTVFpMX8CLo1Ly8GyzEZbfp0aaY8JE4xSAUhhkFWIGoPp+hUbeQDoH7zXM2e3DA49q/HPuuibvb/jPfhgeYqN++Ph9GNd1hBqDw3AnZQ34ocsmHjskQEx1QnEHioxm5J3DC7+IB6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630371; c=relaxed/simple;
	bh=7SYgDh+LGJS5bZnPuhGNBV3A3QhKDfKMMjmZEgL9O+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djk4eWVfaENkk18/y/Ix4eN40s0nUZ1JUVRgUWCTAuDxGLHPSUm4h8ONy61V44ufeB3MUMAQpHc0P0tAq75G8LbtJzxitbb9AIq/IXneyX/hKmqCUcXyvaKkonlO4mmgzn3nc8fk5EsFm65DySDuDt2XxlSeUSXs3lP1Aptk/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKOEeAin; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKOEeAin"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4419C4AF13;
	Mon, 28 Sep 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790630370;
	bh=7SYgDh+LGJS5bZnPuhGNBV3A3QhKDfKMMjmZEgL9O+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hKOEeAinOvYV5G4AsPpLzCF+7QwYjI6MwIaqgYR0rrSqABM4wH9s4sNyXMPk5Bv7P
	 JUmkudg3ME7RrqnzvZF2LN1IDhdEJVsSFdM9qlAHiAHhi1Gtezeedv411WwJf1o+bI
	 Qx2SAP0H6Fqfv2T3BPEfsNQj/nDy+pzB26aFlLCPjPTPSxF7ios1FPGWOXjM/rXLkS
	 9yIEQacd9vZmYzKjvrcjGA2Mptw1BvrsoX533cEzq3cUu/SxhGIHBUICMUxxzazwB6
	 PvA1MQ7CJp0Sgp/U2nq5NuDknPo0254VPshg3ja/XEgAMHLZb9LY9PKpy2IZtTdfCU
	 qVYCP6kL+uTlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E19CA5FA9;
	Mon, 28 Sep 2026 21:19:30 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Mon, 28 Sep 2026 14:19:04 -0700
Subject: [PATCH net-next v2 2/3] net: pcs: rzn1-miic: Fix miic register
 initialization loop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-miic-validate-dtb-v2-2-1ee3d33748e9@reliablecontrols.com>
References: <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
In-Reply-To: <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790630370; l=1506;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=MeWwaPFPGgQ87CIdgWZjV/qJ5i7/Sn8eqK39QKBx+dg=;
 b=P9B0WRGYWgL47uKob0ASKkRxyPSYsKI1IB4Df8MMYW8pQDVkDcON+wMUMfm7a+xNK5MvCkpq0
 UW/9sSe73TgDBiDbJ1ISSNMaCEf0MldaNlM48VSzvlRbO0Vy0M4TXo+
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

The function to write default values to miic registers was looping from
zero to miic_port_max, which might not cover all ports depending on SoC
numbering. Determine the port count from SoC data and loop over that.

Fixes: c112520de041758e ("net: pcs: rzn1-miic: move port range handling into SoC data")
Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index df70309c2d97..9e830932ce49 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -520,6 +520,7 @@ EXPORT_SYMBOL(miic_destroy);
 static int miic_init_hw(struct miic *miic, u32 cfg_mode)
 {
 	u8 sw_mode_mask = miic->of_data->sw_mode_mask;
+	int num_ports;
 	int port;
 
 	/* Unlock write access to accessory registers (cf datasheet). If this
@@ -535,7 +536,10 @@ static int miic_init_hw(struct miic *miic, u32 cfg_mode)
 	miic_reg_writel(miic, MIIC_MODCTRL,
 			((cfg_mode << __ffs(sw_mode_mask)) & sw_mode_mask));
 
-	for (port = 0; port < miic->of_data->miic_port_max; port++) {
+	num_ports = miic->of_data->miic_port_max -
+		miic->of_data->miic_port_start + 1;
+
+	for (port = 0; port < num_ports; port++) {
 		miic_converter_enable(miic, port, 0);
 		/* Disable speed/duplex control from these registers, datasheet
 		 * says switch registers should be used to setup switch port

-- 
2.43.0


