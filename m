Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7641DE02
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439561; cv=none; b=e2+ELUaJAQpl66aMBqVhmhkqfG09IyVEWl88/q0jDlY2wkFzSXQqB72S5P1AXOegKOG3KC3IvwKaAscv76MvNuEgCiVj3xbdBeOp7+rM5kaGBupQnqwEJs/nT41P3Lfcx5xzQOL5hLxp/DvJyEXm97zub+OI+c4TOMytfTS4npg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439561; c=relaxed/simple;
	bh=G2Wwzt722/1Ifk7rbHswK8hKuwDeHSmtanyvf0DIBtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dyss2l3SBotEXfGIn4Q9NKI8Qa6sZVnIiuci2O0NNYFI2KJQ3P8LrfjOmN9F84z2+H7d4JCwrDWM26Wk5MkYbLbZU4hSMJKBoPUOJ0B0s6DgW8l1EWu9E/8Rmr5a9ZlhPB6NitOL1BrC+Saha0X+ZemWve8AnO/rnMBD23X0J38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv2GYBuU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv2GYBuU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso5764815e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786439556; x=1787044356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ajLNEKbiFrGrGONVAVBp+4RfE2iK5zfEjqZtkLbguo=;
        b=Wv2GYBuUTz1ihxvICiw+vvrPuPY4VsFhwvjWDxpFIogABlp6mWWCVcthVS6gSiLSXS
         kUiY7yZ79i265eMnj/uJu68BbjszU2bJWKtOA9wTFFX/y3wlfacLrduxA/zt2s9sJ9CB
         mah/G3kTmdFIUZrDpwbpfvlOa+I0fjPa/u+cEDFpbYy2/ognJn39pCF07P4ZHbnfWDMs
         33qgj0xgk02EXB36IvI8emdruqGLBAbFqtsWF3q4dO4CdkexTHLpQoEhP0gXDCOpGMh4
         wuE6JXi4VAC2Q06x6cfCbhVNY7/iG2/SeOeBB/2GNGq28yy+m/lQV6SbMyfBPoHpAP67
         A06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439556; x=1787044356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ajLNEKbiFrGrGONVAVBp+4RfE2iK5zfEjqZtkLbguo=;
        b=kVs8FwHO7EaGxXfLyxrai+fkWd3jNUw2Voc9LrOaZ4MqbGj5aRQ88cTl+0j9BqeJMB
         9kaRepS2Lhl6ZAFH+Yb9rMUHvVJJ58jFwilNOXetqGQQcex8PwTdc4Ik5p8a73SyBdEl
         M/OspI1iaKUreDuutb60S/y86qxhicDLagSQ5PD8Ja30DJf6dploIxocoQPR1nmpP9td
         v/EhwwI/OKHgWPHH/kPenCQr9Zxo8q/qvqt7+DE2KFYFbJMW4IcjImOkKfgVSExgQel9
         XnQ0z7nbpV79Cey+0OR1Bsu48hs9VyVAHC3IsaBipPqpyzKDGbj4VeAYulby+AkPwZxs
         hdZw==
X-Gm-Message-State: AOJu0Yz9y6bzghYFWtobjRoqbRVWC00YHpvtaZ0UXVdUQm4j3pinp58D
	AC8uaP7EfHuyoJCtiZalNxaakOUju09cWtayRKDkkrNQNBXTWjGkCTbh
X-Gm-Gg: AR+sD134yPdnW3D1j/b8UQ58DLbN+DYDKVGOuMOoZhoJ77Wb0hzXp6MiClQ7oWhX6Pu
	575sUFbVSsX760NDxT4rLWGkgLGzhwYfQ5ySrUxvwtptLbC4eVW+t749AsYR0IzaAO5ozKliTsF
	HCWsj8VVVqEQjQgJLh4+CB5dsIqLVWJaUsD13XCyGX8pbHKh8SXRf783EzvIGCC+kOHqrb/cKL1
	TWzrANwG6qkAlAy3yDS8lbY+RhXtU4knFpLVDklEEK9lQc7VORaqIsHomt77asXdjHNxX3nvoVc
	xY+w4K5gMqri85+Hl5JUbi9Nz4QIWNz1R9K8Xj4cjxSZTEQ/DcTpKF5AQyHXxLVUJYcDvPzi6xZ
	OdqTkn/qKRNwD2uTigAGveyRu789fN9He5at6fIeFIgpnFpMUCjhsWHSIxnl7Ch4jaY5LZZt69y
	tb4UeWjRAALDVuPUG2bfAF3B/Tfmo7GWrZNmYOa5m/pDRsVEFgLt3hruFHwG8JPe0=
X-Received: by 2002:a05:600c:a49:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-49978ec80f3mr23486315e9.3.1786439555479;
        Tue, 11 Aug 2026 02:12:35 -0700 (PDT)
Received: from builder ([2001:9e8:f10e:2116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788f17ccsm25738935e9.11.2026.08.11.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:12:35 -0700 (PDT)
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
	Sander Vanheule <sander@svanheule.net>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v13 3/4] net: pse-pd: realtek-pse-mcu: add I2C transport
Date: Tue, 11 Aug 2026 09:12:15 +0000
Message-ID: <20260811091218.353399-4-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811091218.353399-1-jelonek.jonas@gmail.com>
References: <20260811091218.353399-1-jelonek.jonas@gmail.com>
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

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/Kconfig               |  11 ++
 drivers/net/pse-pd/Makefile              |   1 +
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c | 148 +++++++++++++++++++++++
 3 files changed, 160 insertions(+)
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
index 000000000000..b6769ac1d470
--- /dev/null
+++ b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pse-pd/pse.h>
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
+					      (const u8 *)req + 1);
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
+	int ret;
+
+	ret = i2c_master_send(client, (const u8 *)req, RTPSE_MCU_MSG_SIZE);
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
+
+	for (tries = 0; tries < RTPSE_MCU_I2C_MAX_TRIES; tries++) {
+		if (tries > 0)
+			msleep(RTPSE_MCU_I2C_RETRY_MS);
+
+		ret = i2c_master_recv(client, (u8 *)resp, RTPSE_MCU_MSG_SIZE);
+		if (ret < 0)
+			return ret;
+		if (ret == RTPSE_MCU_MSG_SIZE && rtpse_mcu_resp_is_final(req, resp))
+			return 0;
+	}
+
+	return -ETIMEDOUT;
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

