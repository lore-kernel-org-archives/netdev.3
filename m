Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC3385D96
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785064974; cv=none; b=UHN280n01HjkaZt0Pe1fOxjpW3XFM+wMNFHM2uLcrbURk9kmGThGR7Bnybyqj3orQOhMwbWDWO7AXxJMan0g729bHXyGOZ8/fBbWlElzCmgewURo79KzOzoKyen9nd/5CyNnqgoKwWuv3ZWCGhPJoSGecpZNFXirrrC2J0fWONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785064974; c=relaxed/simple;
	bh=05FD9Q8MiGxbmhMqb3xelmGLNDiAwBg44gqAs0Q5qYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfs/iVdhOIsjjeavNVGNS14eOzgVN4O/RVboIhz3Im0SyyQgt2hTnS4zi5faqEyNX+sVuJu5rEVixuwh+Qy6OHY3Ud86mse0OkKsOUK6L3p/8UljMma/Ze0sz8j9ntpPq0L5qhpbxaHX5aQ9wmaC0SkoCyNygAUeChB6hd7Kpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcP64eny; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcP64eny"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so757955f8f.2
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785064968; x=1785669768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVaU5aBNCpHteSlHa9KIXjavIsGZ1Ok+bRtNiOCJLQ4=;
        b=jcP64enykVSAhEbvKwgvUQkyG/zATkNHmq7G7HIdclQ52ml7UnB2ZZno9rI6kfxI4M
         yEHVgzotiuYbI133d4f5KPvct29svIajIU+q1Ue3ShZehg9aUf5okoz39i6654bbHf3I
         xX3+KmueY7MzGcuOS4yjOjqhQ+Aj7sqIjVcTUvxQ8LdT0Qiv5T8S5VYw3yNFCskjD/UV
         a5qMot7ijfmLgLEB3Av4jE8enptIabyc0UDOLLIOZ9ZCZbNmsNRQ8jwZFPDkXGGfOh5R
         kJrVjkEmFOsyPdpF8s9raRH5Se1usgwEX/YRfL2EsixrvZAVtCsFGKjka4yrMbE0+ulT
         SwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785064968; x=1785669768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVaU5aBNCpHteSlHa9KIXjavIsGZ1Ok+bRtNiOCJLQ4=;
        b=tDyMoQR4nuCFX6+1cSaSuj+mp+XFPzuttCt6MbKr/VbuA+vxpH+yAPsoEWfelHa6fp
         c7APtl8B73fZIc7LF8BE04HSx/lcXq3PfTjtGCY55KQGwye45b8bbUFf6ZWarWJcoFGK
         PJhSFFx3ycbtnLHLWPOtl4OU76tY8V9sr0F8Z8qW2Gprmqz1eLmOVE2tWM/CU/iDQHva
         FpiUMLd0sCpW7WoDxTaNIk2dY+uPh11KiQJeqI+ufSIbZNUElolfg44A1tTjgWbFEC05
         dzDTRQS+8PinEDKTUAo5XzBaE8sNMF/dKEJ/T3W2m+JibWOTGapv4KFAGy2wu7+VMtxc
         dt+w==
X-Gm-Message-State: AOJu0YzkmlpFwl6CabZI/VblepCbOxhO+tUDi7aNEQMqGrU7M0RK6w3M
	ouxvU8rf+P4s1EdvlAQ+HxKz7+peym/2JBrUWc1ezvm6c60Gy+P5hANA
X-Gm-Gg: AR+sD13vInaXrZrOGzWcedmGSstOgGFy1fwoLgGaStGpQHm9A9nr3FBEIC1ELyJlGLi
	H5pHotsqYZHe+vPaSVMsl7zMuoKG1YgFUtHDggFdEGFigvGCl1BdP3xuNXaRevB0tYbDuheUmOy
	8MOsvey+gTHTkonrh8IlK2hZroueZFOHIY4tjt2Vkgp63hDmsiZ2qABjcBWrTJEMk6o2UpXUieR
	0zOP6nPl+tMVMJ+wE3LYtRfrQewH1gHY0hxBxlYgQgRujjYFlWTc9hSS/GLuDhT4WN0FXTGirpU
	fsH2vD+hHxEqKd0qgvCXhi4UjLaS+UkVMJ7EclwJWpqmjBN7xPOixhOaH44HanTixQC9T2MOylR
	01B7PVUhJWeo6ftQKClVrKc1BSL88LlYH1CLeZ3DAYJrjR7F+rafgukas5GB9oV4T2ZUTZN7SUE
	VJspTTtmIuZSshKsU=
X-Received: by 2002:a05:6000:25c3:b0:47f:4e42:669 with SMTP id ffacd0b85a97d-47f9fe94c5fmr5622582f8f.22.1785064967508;
        Sun, 26 Jul 2026 04:22:47 -0700 (PDT)
Received: from builder ([2001:9e8:f12e:8416:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f939c1465sm24902981f8f.26.2026.07.26.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:22:47 -0700 (PDT)
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
Subject: [PATCH net-next v9 3/4] net: pse-pd: realtek-pse-mcu: add I2C transport
Date: Sun, 26 Jul 2026 11:22:21 +0000
Message-ID: <20260726112223.1286074-4-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726112223.1286074-1-jelonek.jonas@gmail.com>
References: <20260726112223.1286074-1-jelonek.jonas@gmail.com>
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

