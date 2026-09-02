Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD6647DD79;
	Wed,  2 Sep 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374256; cv=none; b=cQBpD/QWS4jrCbbi0Ld8Xiw5vTljOVc1DnIQpTvzNzn4gyb8WNn3aYC0M1DK69PpkAazII7MfstJTYOPbvsRFksfehzPTXvMb8yGFmvG/Ywyon4+CI4aWCxuGI5iCFVhnZdq9kCfbmX7I/Fe5xjK3zgoj4F5E9ReLCddwIfqjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374256; c=relaxed/simple;
	bh=V/1UstqcdN1RXWpfcFWx4DWNsEz/FVYAw2CVF01Y1nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HteAWmNCyJWVLhW+IZQKHKamET8RC+2hCE+HXRgjUdCIoZ50L8ce1S9nvpQwHlayD8PSWDLeL3FQ7hTpMKeWYU8ROHU9k4s0pbOlUsLsnR98hZaQsOPnLwo6FobP9G7Y2vFqB5ehgQNNet+yC/rTUFdq8W/1ctvOJBlpe8Or0ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZHoN9Wn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZHoN9Wn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E28FC2BCFA;
	Wed,  2 Sep 2026 18:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788374256;
	bh=V/1UstqcdN1RXWpfcFWx4DWNsEz/FVYAw2CVF01Y1nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jZHoN9Wn7CARjZwKfObbuXnqqb8hifbp/RUqbBlneOqOJVGaK6JdAf2+82CSujDls
	 bL8v76iVxqgDAo3LZyYVrEocokyzC14R2lEwXehVecKjLKG/L6AGWi98V2ABVvRUs4
	 dA3q54goq3ojB0yuTC611IxeJGdAAXI6E7r4kB0EouhvfAH+dDJI1fYaInIKhgGcdq
	 aFQVs1tjA3PDVfuCNw0cH/Iiwoy1K6w+WEYhN087XEyf4f5WKhl54KtjLuO0shTA/j
	 fjEMfAcO/KryJDaUtDf6oq9ETPy7ZmFz/Yj1uZAjvL1Z8wrjHiFomrdqCZ2GN+QKTb
	 KKwvX7Yc4ym4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28ECC624DA;
	Wed,  2 Sep 2026 18:37:35 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Wed, 02 Sep 2026 11:37:36 -0700
Subject: [PATCH v3 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
In-Reply-To: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788374255; l=876;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=8y+5McTvkwszKCn2II2jDDP1RMF2tNDKh17/+uJhtIE=;
 b=TkRRZTNT5I0U+Kq0Oxx8yAwBDBXPZaXnYpHXZq12Bf8aLwr5perqcOOOV9mncntB9CPTFWJRq
 h9nNZgOwzdFBWI2A/JdSdrHedtqo/qpqCpoFbi6PfGgXzoCDn4iojb8
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

Add check to make sure port number is in range before writing
to dt_val array

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index c50b65d064fa..3ee40eb9d545 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -692,6 +692,12 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;
 
+		if (port < miic->of_data->miic_port_start || port > miic->of_data->miic_port_max) {
+			dev_err(miic->dev, "Port number out of range: %d\n", port);
+			kfree(dt_val);
+			return -EINVAL;
+		}
+
 		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
 			continue;
 

-- 
2.43.0


