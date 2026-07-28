Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800D40DB3D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228211; cv=none; b=haH+bxF1LdpkZaoume9G01ffnSSf0OfhRRxTt8qfUndGtHSOwwfLhff7PFyYonQV7lWKA/6U3P0/DRkXWzDaGkQDvNi85X6bEghDeEK3GzQs8xHZROPk+btEFv8HW3nH+q5FWaRDwdFiLelj5B/Jkh6y3FGk/BUIoTbW0bjFPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228211; c=relaxed/simple;
	bh=05FD9Q8MiGxbmhMqb3xelmGLNDiAwBg44gqAs0Q5qYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am5l0pS8Ysk4IZDiUA5xCshMM50QAuGZ5mNVTsA/wkkqp017VOU7s/kEhigpRpxOAIQFuacakRs5xZCWdCGG1JWt3LzOTP6SQrGu5aLpnuEChNPYs4Qmg7MtRToG/Xiv4MXllCKCjZTOGXFgmYNTVlVAiH7S2OI1e7/yixrT374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVluSiTS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVluSiTS"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2347378f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785228207; x=1785833007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVaU5aBNCpHteSlHa9KIXjavIsGZ1Ok+bRtNiOCJLQ4=;
        b=eVluSiTShVd+MD9XV1S57uam+K7ghagzGi1Szl4kkEtmV1BXKVNGzCAfUTMB2o0trS
         dCtB+P+F1bcvv6cVdmOE5KrRqgKXeIsY/F8mHbGInHNl7gbsyL+tZpN0sTnczBa0pTOV
         umOtSeHazegr9d0jMxfZsgrvTh0s4Tu64InFVlcBCqde9TpeIMbj4fL4ZF0O/EQ5VaXl
         P9VjNKvNzN37yiOtA8NWXyCAJ0KHWhmxjVsvdVWaKdWThgWonXvPVsFELvwSjajtTsiV
         hYXenccgfKnUaXk/MmZQ28GqFx5TUcUusXrJ2VCplNf8LXRQWCepUXIx7B57lfgE3BIa
         nKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785228207; x=1785833007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVaU5aBNCpHteSlHa9KIXjavIsGZ1Ok+bRtNiOCJLQ4=;
        b=UaXkzPud6KQfHqVzHzs2rVlo0jwRBkyPO4e6NEOiyvMHKH2dFs0HB01yUIRqNlKulS
         ELQg/TnyNXlGUU9yyW59SWtSHjWFauzsoiZIPbbyw/rQQKYTZjbIoqnBarUexsE5iHqp
         fPakQQUWfFHkTVauxd3IzFM43Y1nBqIQvlSLTQDNNoJjxGCde2DS3mm8Ml2GlvhKkwdA
         slF4Fl+VFM/wclwe04Oy5OLJrDi0Z5LfqtRCOsJm5RFyEzs5OrzlFvG7yz4w57qVzDq7
         ZZWapr7IUlevKin7stgQZrYWJEfBEjKkdofBsnpmDYJTUOTxXbGjUJWIAEQxQP367RpT
         tjVA==
X-Gm-Message-State: AOJu0YydFoETOIC+5RG5pQ+cm8wVUFuqY3ROvjaEHSvEr/iHNQON7Prd
	AZo/emfFQbWbnXt2I5MPtiw8V99BRh70SxP1b65eKuxQR9MUTDItGYju
X-Gm-Gg: AR+sD10U5lC2nbZFRawt0cihV8HkFZIVrBF2v3jHUY22EskQ5SP+MDlZHmNpyUS1X37
	20C3WJI7/SFQtXLd4OvyxZYUIu+T0gS31j5JoO0su62q5en2FpqD2yR87kgww0/QfQl9093KVJ3
	GbfUTbrM7lbercQi8y1nRslgRqETTr0Zppitgi8A+YsZUa5BoL9wjQL7GOYAjJF8RVV6ssOK8+A
	CaXSp9Hbg1jmu4FGM2Ntg3QZ6/Y1ugBxx+WJn6IszvOmHmMslreYP9rPUDZNy0hF4u880lzXGKF
	t94BM2Ms8RqtMGBE1uR4NKrRovBsuunk1q/pXfmLm8xhxWmdyd3Y6XIl9NDBTaXHwX0Dtq+BobF
	GWAuuIHvUAUOgxN8UROLVy7EC4vbuOWF+TBBB1HEVN1Y2gqfhBXUxJ8p+AuCeR35Ha0C+DfSRzU
	QvjgIO
X-Received: by 2002:a05:600c:45c3:b0:495:7990:a1d0 with SMTP id 5b1f17b1804b1-496c658dffdmr15337525e9.19.1785228207046;
        Tue, 28 Jul 2026 01:43:27 -0700 (PDT)
Received: from builder ([2001:9e8:f139:f416:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c444304esm57730845e9.0.2026.07.28.01.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 01:43:26 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v10 3/4] net: pse-pd: realtek-pse-mcu: add I2C transport
Date: Tue, 28 Jul 2026 08:43:05 +0000
Message-ID: <20260728084307.2129515-4-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728084307.2129515-1-jelonek.jonas@gmail.com>
References: <20260728084307.2129515-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the I2C/SMBus transport for the Realtek PSE MCU core. It registers
the MCU on an I2C bus and provides the send/recv callbacks the core
uses to exchange the 12-byte frames.

The MCU firmware expects one of two framings on the I2C bus, and which one
is part of the compatible: '-smbus' (reads carry a leading command byte
and a repeated start) or raw '-i2c' (bare block writes and reads). The
match data flags the raw-I2C case; SMBus is the default because that's
what the majority of devices uses.

Because i2c_master_send()/i2c_master_recv() may DMA, the raw-I2C path
bounces each frame through a heap buffer rather than the core's stack
buffers; the SMBus path is unaffected.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/Kconfig               |  11 ++
 drivers/net/pse-pd/Makefile              |   1 +
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c | 170 +++++++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c

diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index 3b0c245a2bc7..6d14c8832e8b 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -19,6 +19,17 @@ config PSE_REALTEK_MCU
 	  Shared core for the Realtek PSE MCU driver. This is selected
 	  automatically by the transport options below.
 
+config PSE_REALTEK_MCU_I2C
+	tristate "Realtek PSE MCU driver (I2C transport)"
+	depends on I2C
+	select PSE_REALTEK_MCU
+	help
+	  Driver for the microcontroller (MCU) that fronts the PSE
+	  hardware on various Realtek-based managed switches, attached
+	  via I2C/SMBus. The MCU exposes a message-based protocol; the actual
+	  PSE silicon is not accessed directly. To compile this driver as a
+	  module, choose M here: the module will be called realtek-pse-mcu-i2c.
+
 config PSE_REGULATOR
 	tristate "Regulator based PSE controller"
 	help
diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
index bf35e2a5b110..ef869bba5ed9 100644
--- a/drivers/net/pse-pd/Makefile
+++ b/drivers/net/pse-pd/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_PSE_CONTROLLER) += pse_core.o
 
 obj-$(CONFIG_PSE_REALTEK_MCU) += realtek-pse-mcu-core.o
+obj-$(CONFIG_PSE_REALTEK_MCU_I2C) += realtek-pse-mcu-i2c.o
 obj-$(CONFIG_PSE_REGULATOR) += pse_regulator.o
 obj-$(CONFIG_PSE_PD692X0) += pd692x0.o
 obj-$(CONFIG_PSE_SI3474) += si3474.o
diff --git a/drivers/net/pse-pd/realtek-pse-mcu-i2c.c b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
new file mode 100644
index 000000000000..e10f8c633b68
--- /dev/null
+++ b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "realtek-pse-mcu.h"
+
+/*
+ * The core has already waited RTPSE_MCU_RESPONSE_MS before calling us, so
+ * the response is normally ready on the very first read. For commands the
+ * MCU produces more slowly, keep polling at the typical response cadence
+ * up to the worst-case ceiling.
+ */
+#define RTPSE_MCU_I2C_RETRY_MS	RTPSE_MCU_RESPONSE_MS
+#define RTPSE_MCU_I2C_MAX_TRIES	(RTPSE_MCU_RESPONSE_MAX_MS / RTPSE_MCU_I2C_RETRY_MS)
+
+static int rtpse_mcu_i2c_smbus_send(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req)
+{
+	struct i2c_client *client = to_i2c_client(pse->dev);
+
+	/* Send opcode as SMBus command byte; remaining 11 bytes as block data */
+	return i2c_smbus_write_i2c_block_data(client, req->opcode, RTPSE_MCU_MSG_SIZE - 1,
+					      (u8 *)req + 1);
+}
+
+static int rtpse_mcu_i2c_smbus_recv(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req,
+				    struct rtpse_mcu_msg *resp)
+{
+	struct i2c_client *client = to_i2c_client(pse->dev);
+	int tries, ret;
+
+	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
+		if (tries > 0)
+			msleep(RTPSE_MCU_I2C_RETRY_MS);
+
+		/* MCU needs 0x00 as command byte for read */
+		ret = i2c_smbus_read_i2c_block_data(client, 0x00,
+						    RTPSE_MCU_MSG_SIZE,
+						    (u8 *)resp);
+		if (ret < 0)
+			return ret;
+		if (ret == RTPSE_MCU_MSG_SIZE && rtpse_mcu_resp_is_final(req, resp))
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static const struct rtpse_mcu_transport_ops rtpse_mcu_i2c_smbus_ops = {
+	.send = rtpse_mcu_i2c_smbus_send,
+	.recv = rtpse_mcu_i2c_smbus_recv,
+};
+
+static int rtpse_mcu_i2c_native_send(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req)
+{
+	struct i2c_client *client = to_i2c_client(pse->dev);
+	void *buf;
+	int ret;
+
+	/* i2c_master_send() may DMA, so the buffer must not be on the stack. */
+	buf = kmemdup(req, RTPSE_MCU_MSG_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = i2c_master_send(client, buf, RTPSE_MCU_MSG_SIZE);
+	kfree(buf);
+	if (ret < 0)
+		return ret;
+	return ret == RTPSE_MCU_MSG_SIZE ? 0 : -EIO;
+}
+
+static int rtpse_mcu_i2c_native_recv(struct rtpse_mcu_ctrl *pse, const struct rtpse_mcu_msg *req,
+				     struct rtpse_mcu_msg *resp)
+{
+	struct i2c_client *client = to_i2c_client(pse->dev);
+	int tries, ret;
+	u8 *buf;
+
+	/* i2c_master_recv() may DMA, so read into an off-stack buffer. */
+	buf = kmalloc(RTPSE_MCU_MSG_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
+		if (tries > 0)
+			msleep(RTPSE_MCU_I2C_RETRY_MS);
+
+		ret = i2c_master_recv(client, buf, RTPSE_MCU_MSG_SIZE);
+		if (ret < 0)
+			goto out;
+		if (ret == RTPSE_MCU_MSG_SIZE) {
+			memcpy(resp, buf, RTPSE_MCU_MSG_SIZE);
+			if (rtpse_mcu_resp_is_final(req, resp)) {
+				ret = 0;
+				goto out;
+			}
+		}
+	}
+	ret = -ETIMEDOUT;
+out:
+	kfree(buf);
+	return ret;
+}
+
+static const struct rtpse_mcu_transport_ops rtpse_mcu_i2c_native_ops = {
+	.send = rtpse_mcu_i2c_native_send,
+	.recv = rtpse_mcu_i2c_native_recv,
+};
+
+static int rtpse_mcu_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	const struct rtpse_mcu_match_data *match;
+	struct rtpse_mcu_ctrl *pse;
+	bool use_native;
+
+	match = device_get_match_data(dev);
+	if (!match)
+		return dev_err_probe(dev, -ENODEV, "missing match data\n");
+
+	/* The framing (raw I2C vs SMBus) is carried by the match data. */
+	use_native = match->native_i2c;
+	if (use_native) {
+		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+			return dev_err_probe(dev, -EOPNOTSUPP,
+				"plain-I2C MCU protocol requires I2C-capable adapter\n");
+	} else {
+		if (!i2c_check_functionality(client->adapter,
+					     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
+					     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+			return dev_err_probe(dev, -EOPNOTSUPP,
+				"SMBus MCU protocol requires SMBus I2C-block support\n");
+	}
+
+	pse = devm_kzalloc(dev, sizeof(*pse), GFP_KERNEL);
+	if (!pse)
+		return -ENOMEM;
+
+	pse->dev = dev;
+	pse->pcdev.owner = THIS_MODULE;
+	pse->transport = use_native ? &rtpse_mcu_i2c_native_ops : &rtpse_mcu_i2c_smbus_ops;
+
+	return rtpse_mcu_register(pse);
+}
+
+static const struct of_device_id rtpse_mcu_i2c_of_match[] = {
+	{ .compatible = "realtek,pse-mcu-gen1-smbus", .data = &rtpse_mcu_gen1_data },
+	{ .compatible = "realtek,pse-mcu-gen2-smbus", .data = &rtpse_mcu_gen2_data },
+	{ .compatible = "realtek,pse-mcu-gen2-i2c", .data = &rtpse_mcu_gen2_i2c_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rtpse_mcu_i2c_of_match);
+
+static struct i2c_driver rtpse_mcu_i2c_driver = {
+	.driver = {
+		.name		= "realtek-pse-mcu-i2c",
+		.of_match_table	= rtpse_mcu_i2c_of_match,
+	},
+	.probe		= rtpse_mcu_i2c_probe,
+};
+module_i2c_driver(rtpse_mcu_i2c_driver);
+
+MODULE_AUTHOR("Jonas Jelonek <jelonek.jonas@gmail.com>");
+MODULE_DESCRIPTION("Realtek PSE MCU driver (I2C transport)");
+MODULE_LICENSE("GPL");
-- 
2.53.0

