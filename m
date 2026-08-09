Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098313CB560
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786274594; cv=none; b=UcAGHyaBFlAEPQs6s0L3v6zC27M+JHxyzNCJlCQuNDLdw4AtlJKIufeU+aV9Wo9UgyMHBEbwN3cX5ZBsCwuve8qrzyJ8E+vM11mucSnkYHH6Vc86fPIMru79ySRs6mpO+p/S4pPCgYkV9RQzZDRUvIco2STgif4rdck4a1ekojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786274594; c=relaxed/simple;
	bh=pzYpQ797y657BVY4mkizw6DZgajQxwz7OOWTQ6yw72U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj4MBePmOPkKERXXpnNCN/GwwvelHtXtDECHKIhHLV3Ctq89sAjJMZZaTstz21QZ51qo4SFnBYOOIW2i6c0Z+1Y1niNLeJPwCQPX17G8LABPacwnFW44jRcIDu87qBCOyco5TSUfKEmvwVpY7+KvykqwkiHkpTdFYlh9ksB1rh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ob0Ao7Rp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob0Ao7Rp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49954b88fffso9237735e9.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 04:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786274590; x=1786879390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6O9SJha7ztWfoszuLgSQHz7pEOz4ENXF3i886rvLw4Y=;
        b=ob0Ao7Rp2AEJyknQK6FSKiY1aEOP78TYTvI1vICAaZhLmiq04bseA9SFeG92QX1DuH
         nZOnJDvb0SQWaAKtvxZixf/kiZUfLsHgVI3Datrsd3juMfm/WpZe3J+p6uiCMHHjTBbG
         mUXy2NqG/4zRPTfGdyndGKsDw+EBZxpsMOsAlekpry5dA9dT9EmvlvF8bGNmjMUkzc+y
         03ELOGKHjmbBYprKVQHYxgev5JxDlhxAtmBY+7HwXnAJW4iInMdtHSA9GWhL67NQxI2i
         7hRQeCfVccUum4/t0kObAuKY53pxHic/K8tFlLHNjVyD1y4z3xxmzXY8GuEBs44+SFsq
         XZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786274590; x=1786879390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6O9SJha7ztWfoszuLgSQHz7pEOz4ENXF3i886rvLw4Y=;
        b=qkMt1uVFAdawMCUCdI4pZnIhU1IUDa+2GVFoNw6y30Poc6Il9M5ThK/4osqzMXrfne
         LLMSZOcWQdRlViTkBKvGIEzeimFbbgRNB2sWf3Clvbm7OOggb9KNoJtGiVMqa6BLhrmr
         4Mc58MuRwBgGJi+/ZSIRgttCIWdYwtfUYOPZc8hlWBnaWIleb0u18RL74wri4ImXZgTl
         hMO2OFptkjiNXYwz0T4vcUQPxh9DKZ/bxpYYgJ6QWMXWodT/TasdaMiUGSqddixtt7iV
         NlQ8FHKnbQizxOs6DxcYcCxOqdvrVagJGIV7EAHXnaPHj0m19TnJuHJwJARM3AiYeFuZ
         zNeQ==
X-Gm-Message-State: AOJu0YzpceubAVW9+fn2rDRb4ZmBCbNjK8O6pRuc5CjGA1FCbH2uRye5
	7xJLdw9kYEsl6FwfoVVsYMc/JxMZAZ7FD+hTf/tyq+nFrDfPSY7j4PWZ
X-Gm-Gg: AR+sD10SjesV/mpgdy5ryvOnfMmXmbJU4XwA8PBMAWZVUW2Vh8/ec6EvN2gxhTa6OJB
	abR1ae0FwI+32O+SYyvi38TUWYJ8qAqcHMlOQbh0NPGeiRzlJq6jcSvzTfyqiPHSt3hAWkz7jle
	4naEaD8C2NkLmIw2g9AP9CReug/lZLgQL/rRjI+eTCqlrD++y1mannm8kocVb9yoHe3wMPMhQVp
	lyZx1JAFVNwto1QevD8OT6h30IhxQgcMz7+c2OBYwM3VJLW/mjtgNnVQT2YTKPqKhXnjIC/yhou
	qLITLEE2jSFk5A34w1S1l5zCrksHbbHMHnV1kyQISVA8A6zmSEgJkDA/QXMelayCyTjrK+ue+zs
	Vjdnl9TI8ifLiIlb5puhrOdiskS++P0U/pob7rKbQOxpmsys1omE9id7ia4uhkFWv52ClEkeQAf
	s3w+y6grXRDjVp1QCJ8hom/PiY1slel5YbjAaT5VzKrmFXJF0fisP6KSz5DeOGuQDx9ex8t4A/w
	Q==
X-Received: by 2002:a05:600c:3586:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-499619833admr159175595e9.11.1786274590131;
        Sun, 09 Aug 2026 04:23:10 -0700 (PDT)
Received: from builder ([2001:9e8:f105:3c16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm23156775f8f.28.2026.08.09.04.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 04:23:09 -0700 (PDT)
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
Subject: [PATCH net-next v12 3/4] net: pse-pd: realtek-pse-mcu: add I2C transport
Date: Sun,  9 Aug 2026 11:22:49 +0000
Message-ID: <20260809112251.5797-4-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809112251.5797-1-jelonek.jonas@gmail.com>
References: <20260809112251.5797-1-jelonek.jonas@gmail.com>
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

