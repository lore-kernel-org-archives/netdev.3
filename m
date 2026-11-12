Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519591;
	b=xyzfvdGxS98eHvLixMvhOhrqoh3ylktMNN33tqgoxS+aBcLYYpka5mNLzjqafbol58H3
	 3x/0k3Onn3SBRhS5R2u5eCRvTgPxad3KgOCBx76uF8R55pol2RDLqNH7ob3zUebliL5fu
	 l3bL+rYBXaxC51LcoanVH0neU1SRa+KWUUXF1+s1NFr7hVDbWIBj/cebK27OadnMirnQv
	 T8TfpVRGvnBo+Uy2v53ubRIZF6aaF0/Qg7n+Y/br3EuLecpMoGpaTy6TKaGSuny4VMIuj
	 SOc2BQ+dUezXcSuuXvlOTdt+Y1XvLL40R1lZFCSUrIuH9VL/JNnnuIXYNABjqlcJluA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519591;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kC3bFQJa3sH8peY8DR6++Vxef8QEFila5H495e35WVg=;
	b=yb8AkzSKCWy+Elyp38mAyGqDv7B9FZVE4vmqdrPJ8AzaANxoOYsHEQsg3zY24WfCWWbi
	 z9N6lq51fn8SpfJaq0WtQL7sPC1oswcKNnzm8JJhWIwsxNG+RTgEyAQtSKH3i8we/J2ag
	 75m79WhB6jOH7ni17MizzT18ZKz6UNOGDbKR1hXEGcnumCaz7dXiJLub4EIVL6g7aqAEX
	 ojhGKO5I1Xnp+DxMnGdslPta5xIoS+DE+RBWzr7XZcIh7R1v+qBYxPvZDJH06iYLRxWRZ
	 Ake8XpXf/EhdlzyG/hp4/ng4R/OEMvDE9kn9wBnWTfLkfuk9hw8AxGh5J28DwhkIHzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONAhlEb7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF96606A31C;
	Thu, 12 Nov 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONAhlEb7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794519591;
	b=NN4Byk1m3MdGXFh44S5IOt6x3kAMwRPkSZehE2R9t7UiTYM0tPG6W1xUS+bVLc9tXHMj
	 0emEjGzoYHygk2D5MA5Z4lzfHhjUO4dZ9SCWxg6O0qH+OIPCgsF3SDSWCr5lz6VDPGIlv
	 j5JrEX4Gjq1ugpTxMG9oNXWHPS5dgjXkDpXmeFkSoqLbxA/s/yz05BL3L4zO4uQABNds5
	 DRV0I6876Tg/noMcBcPnHYyk6U9NyqG2V9zZh7cqMbHq/a1Z8IlHxiTMMy6Vot07qKHt6
	 ePlnkIIJAlVwr7Oj+DdnVzfUDGygiz2L9MkC7011/TWxY94RSDNwX2xmrquT1xHkBJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794519591;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kC3bFQJa3sH8peY8DR6++Vxef8QEFila5H495e35WVg=;
	b=2lycXXgm2X2NKJMrFg2bbAjqZD5erVaQJciOe64T6yX8GoLJm59rmPoaB5fswWfeJkgb
	 Qoo0kvWWEfUHQlFACXHIRrfTGoGYeMjlyCzm4/IF31o2oNzNCBu4sCZOrTkwPNMe/E1HR
	 Xb3ZxJtbwvd/HWd6/5fY7/JDL7sC7sBd0WZFxgXcVoww5AgzwyiD+Gd7wWlzlwE5mBdH8
	 4ocOHtTQLAg+aoFBMkYw/3B1NZGuMyuc/haURDNDdH7kZ5NzpmAENgF7Tq1mwWNQfvHJi
	 GQ5L7TUs4csG4Dmah+LSuKG/wNHAXGNj6yVVimVXjfgkwel5atkik2qEh95ENuTQaQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0C7751F000C6;
	Thu, 12 Nov 2026 21:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794519591;
	bh=kC3bFQJa3sH8peY8DR6++Vxef8QEFila5H495e35WVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ONAhlEb743REUh5LubLvpfpTCXd0YgevO4W9VHM9dmHTfpisiVufiU8Efi+U6GUys
	 dmbfox+qRkD7OeBCQpMWvcX5UcpIJklibeLeZQebfOXMHQ3UuzjWigLCTMJxfRvc6y
	 roG/XCWk2I9UOUJzgt1eNDNudYEzQZz2uV1Jh4UCZwaJfqn2LAA0YEyYNZRXGXJpMM
	 3nmyVY8uTrK8oEZrC8gOkMS8HKyi4WKjQU761N5S+WGiXSs/Ai6rvMoh9NcUr5PJ9T
	 ySMtPhsPTFJ9fX4aWmrm96vMEZbx5lJnftf/wP80hpzfFD3VjmJF8ysfQyDtQjCb7i
	 YoHY2lIFrQsPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 88EA647513;
	Thu, 12 Nov 2026 21:39:49 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Thu, 12 Nov 2026 16:39:41 -0500
Subject: [PATCH net-next v3 2/2] net: dsa: mxl-gsw1xx: reset the switch
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
Message-Id: <20261112-mxl-gsw1xx-reset-v3-2-863e82074893@telaak.dev>
References: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
In-Reply-To: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794519588; l=3553;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=WZYxeaFGDWxSpN7GzuooSUNjWaVXrTqutE63YR5JtU0=;
 b=gBIElyAt9sK0h91F8d58bV1C+Ls9eNK6vVg0iJzPMMHj54lGxmP2K0mGcfX/Zf1nnV6pB0WUe
 0Gq71vWKYwcBLZa7K2oTk8pOtDEXMLCKA2l2wfsiOy/vxKAzYZN4lai
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

The reset also returns the RGMII slew rates to their power-on defaults,
so a board that uses reset-gpios sets the ones it needs in its device
tree.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 26 ++++++++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index a26f78e1a4..f69856a65b 100644
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
@@ -737,6 +739,30 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
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
+			return dev_err_probe(dev, ret,
+					     "failed to assert reset\n");
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


