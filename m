Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794178814;
	b=YZl8DB5RtYw8NZXOpHaFsEfkO2cn/vzaogw3wgaaVcqtQdXXb0mhDpyjpeDFfah8px9O
	 iO1MToInR9GN5p6EZIFgCp8AgAl09ykxEvewp1wI7MuvoOh6nnFA8NvYRES/CV0lZnI7N
	 q1Fm4KJsz57tKOVrZ5oiuUb/K9MgvS8Bo/tZXGV7/rkDRqe886Ox9SarzjQraR6cFc4U9
	 mQrYiNvjXF3ufMYgA9b/fm+Lel9Ht4xEGGKAArrgV2tQBCerJa591i3+I+uuAIw+0HMxH
	 gceDbdcgvPeX5hyYdh7q0TxzOWbb+v9s3GkGAb5neS4U6i6DQpGd2R0D4JSk/TDJgZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178814;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZIqH1DBoM+uJ3EDiaYlTuS1iQpgxlgvaEPaM7goYc3A=;
	b=zTdoN9mll224kSu6Int6WF1gJnzbMt+XXUwP5t6FjSdZzJ6bra4vEMz/rYpBmqPC/RwU
	 RPfPwvHiq5PJ+qtWSI5xngQ/iN4vTGmPNaSoMx469Vv015IIGiCBsS/czgxZFVjK/x911
	 Lg5pfd78fa48PjZWKUaFaZX6EBl1TGofOfpscDImI5rBZz9qC4u6QmPOnPggJqmCZ0U5Q
	 45x3cHNJtJvi6ZP9TWumv7zF+ccGl7RazWI6DMlpx5bRTwMJuVOJ0ij/L0tzVTlx9l0yN
	 L/hHkDxXq/XbZ8pLj0pv57a+WNWgzOYQiSB1FVkChHPWbwvLBgLp5lxsTa2eGnjSUWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YF5fZsMj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51D606A320;
	Sun,  8 Nov 2026 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YF5fZsMj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794178813;
	b=W6kUSl/AiJBPkx5Ok5GHBa/7UYM3vf0q7t+de4rJy7Ft8jblnOzcsAgip9IMIoKok+tL
	 fZ8N58xnvScQjUrPhhvqGb1Lko/6I7a3/AF0qnRN6aOAvw3Cfb0v9nsAJGtIXprIXzCgC
	 rQNUzGJJIZzt5nEhlQP6HiB8nfA1Jn5dQftXjUW0oDmYeqOXPNMzcEa7hzb5sUTuveHlX
	 fspSg0H0fXelQD0bgvyVz366zhF5FCpRWIYCs0j4m3tILEyXIHh1X17YtJ6fz3/4cywmS
	 D2vzsoQcBUy5yYtO7CAP16bOS2qav8+Idr0FMAY3HBp7fkYGNfPQOX7V4dKUFbYp+oQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794178813;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZIqH1DBoM+uJ3EDiaYlTuS1iQpgxlgvaEPaM7goYc3A=;
	b=DDJLWcTLex6/NiycXhEXfxOC7eIEid+LS2foUOFhkROSG5v1RbWK5YqG5lygZhFO3B6z
	 oC7Xjd2DAcvX6dL8v9JVHitGYdBHVyj+Iptbst0SZu71zikkvXK6us7cpg51cObnPDzsM
	 1hNWRUpCiudevpwHuaRqHDAv+ezaVAKTh7OC3pS2CBFO9A4WOJfr0Iemx+UHKJY1z+Bpw
	 /dY6ydhFW4xgk+wpVQp1leWBw1YnjaQAxnTvOVXwOi1Jx5EIa0rZpd+ipNu5lcfvKeuZa
	 1iVlpINYoYQSt1h86ByG+saxYySdTQTmEoa8ZlK5KDO2WP9/jK0pqpZKSEltzlKSmhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5BB111F008A4;
	Sun,  8 Nov 2026 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178813;
	bh=ZIqH1DBoM+uJ3EDiaYlTuS1iQpgxlgvaEPaM7goYc3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YF5fZsMjkI2C4GgvDDDHKmJLSoGAl2KMyL/ta5az1WOytbXUIfXo+EliSMJCqQfGw
	 qfap5fQvjBmI1n8+pFPnd/Yi2t8Rp9PnRpg2Onv0VKg7U+uCexuiqMDn63wJpcf5X5
	 Ndfv0f0EUnHyubPFvUAzHtodE7kg11FCaecLQS5qf49rkzck/KwNpetJM6fgF55X5i
	 01/ZNXxFxt9eTaUBlOSYzFlIoIYJkNMIMqtdT0ZQnhK7xU+Bi5M1WVLbMdEcGAQg8W
	 BG2j9ZCox5rG7xPmxS032xmRLyfbBVTRXo+M2m1z44tD6ywqpRbYgaiBpdgC1v32MW
	 cKOZIUxHMFMzA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D3BD148157;
	Sun,  8 Nov 2026 23:00:11 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Sun, 08 Nov 2026 17:59:51 -0500
Subject: [PATCH net-next v2 2/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-mxl-gsw1xx-reset-v2-2-46c1da093893@telaak.dev>
References: <20261108-mxl-gsw1xx-reset-v2-0-46c1da093893@telaak.dev>
In-Reply-To: <20261108-mxl-gsw1xx-reset-v2-0-46c1da093893@telaak.dev>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794178811; l=3387;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=xTEUcIE9O7Lvlm7PCL2ChxhTq2KKtfCbbxYcvy8dALU=;
 b=xd3+dXoaRFn9bQGadtug07XLwPcs7wywu+21B2gVr+qS7gd08iwXUi5MwLK3UqJboWRgrkZaH
 sSGallL3n9DD57DWvseVUJCEA9C/spHU89Uiql4YZQoxpjLh0ZjoYFj
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

The switch keeps the configuration the bootloader left in it, and the
driver never resets it. The MDIO core asserts and releases reset-gpios
only for PHY devices, so a reset line described on the switch node has
no effect either.

On the GL.iNet GL-SFT1200 the bootloader leaves each internal PHY of
the GSW150 one MDIO address above its port. Port 0 then fails with
"failed to connect to PHY: -ENODEV", and the PHY that answers at a
port's address belongs to the neighboring port. After a hardware reset
every PHY is back at its port's address and all ports work.

Get the reset through the reset controller API and pulse it before the
first register access. The reset core hands a reset-gpios property to
the reset-gpio driver, so a board that wires the reset this way needs
CONFIG_RESET_GPIO; without it the reset is skipped. The timing follows
the vendor's driver for the GSW150: asserted for 250 ms, then 1 s before
the switch is accessed.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 25 +++++++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index a26f78e1a4..94a7eff5e0 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -18,6 +18,7 @@
 #include <linux/phy/phy-common-props.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/workqueue.h>
 #include <net/dsa.h>
 
@@ -719,6 +720,7 @@ static int gsw1xx_serdes_pcs_init(struct gsw1xx_priv *priv)
 static int gsw1xx_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
+	struct reset_control *reset;
 	struct gsw1xx_priv *priv;
 	u32 version, val;
 	u8 shellver;
@@ -737,6 +739,29 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 	if (!priv->gswip.hw_info)
 		return -EINVAL;
 
+	/* The MDIO core handles reset-gpios only for PHYs. Reset the switch
+	 * here, so it does not run with whatever the bootloader configured.
+	 */
+	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset),
+				     "failed to get reset control\n");
+
+	if (reset) {
+		ret = reset_control_assert(reset);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to assert reset\n");
+
+		fsleep(GSW1XX_RESET_ASSERT_US);
+
+		ret = reset_control_deassert(reset);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to deassert reset\n");
+
+		fsleep(GSW1XX_RESET_DEASSERT_US);
+	}
+
 	priv->gswip.gswip = gsw1xx_regmap_init(priv, "switch",
 					       GSW1XX_SWITCH_BASE, 0xfff);
 	if (IS_ERR(priv->gswip.gswip))
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index 81bc00eabb..bca8e3223c 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -19,6 +19,10 @@
 
 #define GSW1XX_SYS_CLK_FREQ			340000000
 
+/* Hardware reset timing of the vendor's driver for the GSW150 */
+#define GSW1XX_RESET_ASSERT_US			250000
+#define GSW1XX_RESET_DEASSERT_US		1000000
+
 /* SMDIO switch register base address */
 #define GSW1XX_SMDIO_BADR			0x1f
 #define  GSW1XX_SMDIO_BADR_UNKNOWN		-1

-- 
Git-155)


