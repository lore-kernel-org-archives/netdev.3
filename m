Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793776568;
	b=vbUxG7EzmuRc+wpxoliOYRK2Cif8H4+kVym1kTd+lx1rKCidW5zRQNbgacAKWR8y6uo3
	 VJRb0/FAtRyfqFWWD/YJ4E9aJKEVEFwAzIAdK5lSDw6vR/9OSZSgExDVtLohrmn+xM09Y
	 iWlr20rxJCpLr7wWP6EuTeAMQMy9C8Ksre9QLHKXDeKPtpYv0Svzy64FN9br29tj8n53p
	 uoT+0gIfXggh5+xAQUQ4WhQKw1n3e42UWGsoQVBMr7JhXfnZyM8VM+rtz5KYMN5IjLVLp
	 hsXKebqPjKEk7DpUyFuHlKUzoH12TZDmJOz22ki2Pyqex5jFRVFvSyeV8jNs6RfUloA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776568;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kWziskZcZLbDi4Q3CidHYxTSalhBtT6tNzyPkdNgHUk=;
	b=KlzEHgpSRnKFDlNzsHA0Hft8xhjj/Wzb8qxOiPnBvGEeN7kRrTqRuqDGjEHyqCJv6wqh
	 4XcMpvVPaXcwlkdt6yJHWlqJrleuZNv/SJvEmq4/+cd8ttzYAlviLF9dVYBzFbsLzm8ca
	 DvkkdlUsUZYc/PUV4KmCaOO5GPjRXrNKEhR1lSjGQMP++D6K6kOPgaISrAlikeA/BJrbW
	 BBnvbq38r1sucteb/7jqR5Jnp2cRYl6I/14bScr8EsNmPzozL3Pcrr+ohTA1E6rOtJDOS
	 vRQn958f4jCkLbseJqpz+oVR5fAhdT1qbr5LD67AuVty39qIjPU0UBw+MjPU+VPoIMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/BQbYJv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F5606D816;
	Wed,  4 Nov 2026 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/BQbYJv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793776567;
	b=kYLs5a5FFnpvQjku/3BmN9N2JOG3Cndqp2lZvkCvQ2rV7wE0e4UN69gyIcj6coV3zcTc
	 vxPqTCEE39mjmY/KbfixIa2N94LHnSMCuKggZY4rgJSZQlsRSFkIkXTqyVJimCHChZTrX
	 YbHEspui3QfZwDpXUeTC6qGPf3rGdcH/bkv0bkxRKKBWCbi8ncbUDZ2XVxaSogRodtP0K
	 6IgM4ESuYIGHt0UhoUI+SLrmz6Un1IaTxsF9Y6bODY0vAmP1NlgPWN2ZsZDjqYYAOWLOI
	 7sRlBiJoOCsmsq4hY6JXcwplSL6EznW/WGvv4Af9EfbtRFa6feRFnP6XkoNVZ1/eUMA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776567;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kWziskZcZLbDi4Q3CidHYxTSalhBtT6tNzyPkdNgHUk=;
	b=dRvFiHcpp+egYf7Cg5LppNLyEgkkUZMorvtsUrbG+7LL7qYuAiu4n6/9jqx+6Xx4Ng4v
	 eojeDLbuAWMTX+OCcjqMZMhUxKtuXzAphx5Jmr3BujxetyuNlywoHRhpILeXqLAI0fr0b
	 N/gRTT8DlcJ2RnUIDJ0+/agLyt2OtQZ6wPcwi2LdCXzAL//e9WiICT5Fmvi7Ju3maK1Tb
	 nktI/pW9RNQn7BC6TKvt7XLoDLgh8YU3vekdy3E5nKq8sJXA780p2B3f0OeCUlkxuX0EA
	 ljchKTahycxJhnFx4lZl/A053X++XTzLWKXwybns0qSmtiT8Wo6rJh9e7iawRSFsHLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7B90F1F00A1C;
	Wed,  4 Nov 2026 07:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776566;
	bh=kWziskZcZLbDi4Q3CidHYxTSalhBtT6tNzyPkdNgHUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=X/BQbYJvYRUbGHHXlge5HJyr+NA9liv1QhRcHY7Qefu+XxVH2/OlEtwC9idEsdRQS
	 vct9rFmMElTsjsUo/g7B5l5SaFQQVgYfwaU5fJ4WrJCL4UT9okDlRZrtBa03tcnmyq
	 mFyCnWqoFndiqifJr0RMW08+fT5hLQyQxJf62ZUo3YqwYlug2/wU/5g+g9dESLVULX
	 BhERFS3iYRWq203kjjjJiRbBtzoI44A0Xv7qKLn9E0MP8IJFpAl20AAxDGp6Bk6cgB
	 9UAHda0gN346SS2UGB58DLpNO4w86DxKQBZIUE0jBesDk/IaC553YqcsAkGiIRPmXj
	 Z7mrbra++NVSg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0BABB46CDB;
	Wed,  4 Nov 2026 07:16:06 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Wed, 04 Nov 2026 02:15:48 -0500
Subject: [PATCH net-next 2/2] net: dsa: mxl-gsw1xx: reset the switch
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
Message-Id: <20261104-mxl-gsw1xx-reset-v1-2-53839bf5c88e@telaak.dev>
References: <20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev>
In-Reply-To: <20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793776564; l=2985;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=uztjZiDQnh4Ex7diNq4uofcWFk+cr6zOCxuZ3l2XlYg=;
 b=4cWp3cP7Blg0M1aZhb89CvDwiLWOaRhkkQMswf6pp/ckEDthOZ2N5ReLWTY0bc6KWr74oq12O
 12uuKsNlIncBHieETviuLGLK10lNLqGEZI1YTI565wf96Mr3wTx3FzK
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
port's address belongs to the neighbouring port. After a hardware reset
every PHY is back at its port's address and all ports work.

Request the reset GPIO in the driver and pulse it before the first
register access. The timing follows the vendor driver: asserted for
2 ms, then 100 ms before the switch is accessed.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 16 ++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index a26f78e1a4..8767c8cf1d 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -11,6 +11,7 @@
 
 #include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -719,6 +720,7 @@ static int gsw1xx_serdes_pcs_init(struct gsw1xx_priv *priv)
 static int gsw1xx_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
+	struct gpio_desc *reset_gpio;
 	struct gsw1xx_priv *priv;
 	u32 version, val;
 	u8 shellver;
@@ -737,6 +739,20 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 	if (!priv->gswip.hw_info)
 		return -EINVAL;
 
+	/* The MDIO core handles reset-gpios only for PHYs. Reset the switch
+	 * here, so it does not run with whatever the bootloader configured.
+	 */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		fsleep(GSW1XX_RESET_ASSERT_US);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+		fsleep(GSW1XX_RESET_DEASSERT_US);
+	}
+
 	priv->gswip.gswip = gsw1xx_regmap_init(priv, "switch",
 					       GSW1XX_SWITCH_BASE, 0xfff);
 	if (IS_ERR(priv->gswip.gswip))
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index 81bc00eabb..684bb135bc 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -19,6 +19,10 @@
 
 #define GSW1XX_SYS_CLK_FREQ			340000000
 
+/* Hardware reset timing, as the vendor driver for the GSW150 does it */
+#define GSW1XX_RESET_ASSERT_US			2000
+#define GSW1XX_RESET_DEASSERT_US		100000
+
 /* SMDIO switch register base address */
 #define GSW1XX_SMDIO_BADR			0x1f
 #define  GSW1XX_SMDIO_BADR_UNKNOWN		-1

-- 
Git-155)


