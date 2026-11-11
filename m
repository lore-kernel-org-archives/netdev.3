Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370755;
	b=WpYHsPER7uZf80aCxZKABrc1wF5MDP7uK6+MaMXE5GEgIED0z05ScL0LOoC0gNYbmRnJ
	 5niaC18sPI5tT6FM9JEiyphy04GYkpeNXtQDwQqOC2LmogA8tGc7zVkX85KDNVOM/c5Gn
	 e84NrER92m7kqPXP53rOlWuYdPI0fWmyZQ/vRtdMn3rqcDGPpfWiz7USeYNTV1UgdHm46
	 LAKLDc45DkbPg/H3WsA3DqpS/nJJFxAvX6xX+t8QEgP+dPCTqPz7XIu5Srz6VJBVMR08x
	 dqLZRbvPQ7wMd2Z4RO/mVYF7t1ZvuTxIVzA9Fqzjn0hOCMOEt7GaRHA7FGRgswcs5jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tioxKfo0r6ymDmT2sdreesWQ9Kk6NZ3UAliEfKE+GeE=;
	b=u0FrkvBdVXJXWen1iZwCR3J+IlNAkQsTjlEGX924CpLwUDczqyn7kNWDhSIegYaztcks
	 7hSfnQgiKL6T2PSOVNc8u4aCMsxGBRixV81Ro8h+fDCzWDLTR1e0+9u4oQ9B6MrMDVJva
	 HiLPARx3/IKAel886GxMLgYF11vBH38VvaqdoIeIM7+YoEhV/oRnxi8hFQ6N//OJ7pu8I
	 8eZvsglPtKLZ8Kzo5zoIHn3Lh8UEKYIM7A7wctiGaqYmOE5xPeVys/2fI7wWy6wYnxRjU
	 gB0qUbv6mQGuE5WdY7GWxesa0PGyHIxo2tymj+h87uFCcA7Lx1tzzeektsBshoTj8Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxdSpsSH;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE37606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FE37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxdSpsSH
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a315ed211so3095020eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370755; x=1794975555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tioxKfo0r6ymDmT2sdreesWQ9Kk6NZ3UAliEfKE+GeE=;
        b=mxdSpsSH6+mr7crxIK8lbMW88P9Aekvjbv2subpODZ62WB5uVpeytOGowg6t5QATYR
         M24Mdfg3i8/ukpLW/FuLj3DaVfbtV7PbkDrOQppUMi3xxOmqRSDTKBYvaSGLBh7gAphS
         lJGwuOBLRhutjzOsq2KMfk3tBFn4pf+k2Bz+FjxqrECQ8j39QULw8qduwL6lofdLjxxd
         IfhIMSrkYPFZPOXqx0fudF8/PuVZzIW6SCjroA1mXtUz/pUZMDukHwgQtBoHJ3dUeukW
         ATrk5LPOtw7f0P535hNwihOg3WYw4AWabKjwElzpBB6n/QRUbS0hTT5v/rzKm4tlsyOw
         4mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370755; x=1794975555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tioxKfo0r6ymDmT2sdreesWQ9Kk6NZ3UAliEfKE+GeE=;
        b=tff4KNGuuhVF08Jq3lYuVFw4h0edTBJw2pAXZiot5JfgICAaApuqgsvlYG9kHdQ36+
         4iCmMp8ZKtP6DpyxtsyVbasHiHKOn22jU+uonIN5Lq/17RdYQSs9smla/ErTgR+MEKjg
         fvg7oPnYCv/8XjA9ToDhdCvJWJ6d/gNyTTzCIKjkTf1iJNvxAPfAq30tMEUQ9iRHpqIa
         u+Hc0fEJiCRTPUP4puRmP6zlOwSfVslE7mDQYa8rEg4jwtQY/8uTI3jTQk6PuT35p84n
         wl7mErz4OMfCglg2kzh9+baM+pHlCqm6AunFtRQg70bh21r7G2gLBcU7gS2wp504M31J
         Lhdg==
X-Gm-Message-State: APuU4Z+ZI4/lWtcrTfqojwagpoteY9laJw8r5g3tIt1UJaSYjr63yPr3
	78Mj/LcSv9za9wdqqIt4c/8px2i+T/5yNGuuzV+QfwJh2PV2cRDdFnRFPDaKZRDz900=
X-Gm-Gg: AYBFou1YwWetepv5XkdlQX5w+SL7QIpoWBeEIuSj4vTHtP2bv5jdeKywAGvPz32JioC
	ebFSHI1wMpXgXwabHOHOzmgjwDmeH3cCS4vbTd8tcY4hshkTJVL/GMuujOkzhq/DxUV1GRFtASP
	QVR1hQ/pIXry+b4LrqxCsuOY4DuEQ92CwUSiOxqXTplAomny9JuzFf+nVnCr7oMAv0QDYn7cboS
	K91YWbWCoMgGJ1UP5rR4dvjefZ4y0/UHO6tCphkTH/7AQiXvtTNHWpc75AFVNYyT7Gxqd/9bvcf
	Af8CuK+Z/h1tZmreZX+Ov14yxrB394qV1evwXsRihtD5lGzVL2ep4fLek+BQy5ChRWqZ9/LTILY
	9yywHjcLKfBn2ae2Jgvfz1mDVUzx0AZgYJv2ANpdJRJ5MRdV9jfVoV3+kf2Hc3oU4sVswPDwhFW
	OBv8v4MWWm/edYX/tI7mNd807JAjMCgnHd7AEfrjBFs2hs5pt7tFUvuEICD+M6bZmHhv5ppM3lj
	9hF1WxZpN6xPCaJqECBV7rkhMQMF8r5il4sZn8UuUPxvugzf1g2khIVJyOV8/ADYqhDc/f7AV7f
	KBMv20bR5BCykMBXwMcdfH1NYLszxKC2Gt2MOGPH8p6JF4mfXr8rcK9SIpIakrnGCzbsFrp0eQ6
	HWjTU16LUmib6Z+n2wEJLNLS3VfUuKx/qx8uu8sai6TFPAhpN2nAM3jkIW3lSlytj0DqQ6BIT
X-Received: by 2002:a05:7301:488a:b0:36d:be15:2dd6 with SMTP id 5a478bee46e88-37686b42aabmr1877422eec.11.1794370754436;
        Tue, 10 Nov 2026 20:19:14 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11820704eec.15.2026.11.10.20.19.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 20:19:13 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] i2c: xiic: allow platforms to require 32-bit register accesses
Date: Tue, 10 Nov 2026 20:19:01 -0800
Message-ID: <20261111041904.48916-2-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111041904.48916-1-ahmadexp@gmail.com>
References: <20261111041904.48916-1-ahmadexp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LitePCIe bridge in the WiWi Time Card production image cannot safely
service subword MMIO accesses. Bringing up its AXI IIC controller with the
existing byte accessors caused a fatal machine check. Two crash dumps
placed the faulting access in ioread8(), called by xiic_clear_rx_fifo()
during xiic_reinit(). The affected register was the IIC status register.

Add a platform-data flag to use aligned 32-bit accesses for registers
carrying byte or halfword values. Keep the detected register endianness
and use a single transaction, not read-modify-write, for FIFO accesses.
Platforms that do not request this mode retain their existing accessors.

With these accessors on a WiWi card, the controller probed and at24
registered the board and MAC EEPROMs. Repeated EEPROM reads and I2C
interrupt delivery were tested separately on an earlier Ubuntu port.

Tool-origin disclosure, as required by generated-content.rst: Codex was
used to analyze the supplied crash evidence, implement the accessors,
prepare tests and draft this changelog. The request was to support the
WiWi card while retaining the existing behavior on other platforms.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 drivers/i2c/busses/i2c-xiic.c          | 56 +++++++++++++++++---------
 include/linux/platform_data/i2c-xiic.h |  3 ++
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ba560462d..d13cfb012 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -66,6 +66,7 @@ enum i2c_scl_freq {
  * @rx_msg: Current RX message
  * @rx_pos: Position within current RX message
  * @endianness: big/little-endian byte order
+ * @force_32bit_access: Bridge requires aligned 32-bit register accesses
  * @clk: Pointer to AXI4-lite input clock
  * @irq: Interrupt number
  * @state: See STATE_
@@ -95,6 +96,7 @@ struct xiic_i2c {
 	struct i2c_msg *rx_msg;
 	int rx_pos;
 	enum xiic_endian endianness;
+	bool force_32bit_access;
 	struct clk *clk;
 	int irq;
 	enum xilinx_i2c_state state;
@@ -282,52 +284,68 @@ static int xiic_i2c_runtime_resume(struct device *dev)
  * Only the least significant byte [doublet] of the register are ever
  * accessed. This requires an offset of 3 [2] from the base address for
  * big-endian systems.
+ * Some bridges only support aligned 32-bit accesses. For these, access the
+ * entire register in its detected byte order, without a read-modify-write:
+ * reading or writing a FIFO register must perform exactly one transaction.
  */
 
-static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
+static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
 {
 	if (i2c->endianness == LITTLE)
-		iowrite8(value, i2c->base + reg);
+		iowrite32(value, i2c->base + reg);
 	else
-		iowrite8(value, i2c->base + reg + 3);
+		iowrite32be(value, i2c->base + reg);
 }
 
-static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
+static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
 {
-	u8 ret;
+	u32 ret;
 
 	if (i2c->endianness == LITTLE)
-		ret = ioread8(i2c->base + reg);
+		ret = ioread32(i2c->base + reg);
 	else
-		ret = ioread8(i2c->base + reg + 3);
+		ret = ioread32be(i2c->base + reg);
 	return ret;
 }
 
-static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
+static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
 {
+	if (i2c->force_32bit_access) {
+		xiic_setreg32(i2c, reg, value);
+		return;
+	}
+
 	if (i2c->endianness == LITTLE)
-		iowrite16(value, i2c->base + reg);
+		iowrite8(value, i2c->base + reg);
 	else
-		iowrite16be(value, i2c->base + reg + 2);
+		iowrite8(value, i2c->base + reg + 3);
 }
 
-static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
+static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
 {
+	u8 ret;
+
+	if (i2c->force_32bit_access)
+		return xiic_getreg32(i2c, reg);
+
 	if (i2c->endianness == LITTLE)
-		iowrite32(value, i2c->base + reg);
+		ret = ioread8(i2c->base + reg);
 	else
-		iowrite32be(value, i2c->base + reg);
+		ret = ioread8(i2c->base + reg + 3);
+	return ret;
 }
 
-static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
+static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
 {
-	u32 ret;
+	if (i2c->force_32bit_access) {
+		xiic_setreg32(i2c, reg, value);
+		return;
+	}
 
 	if (i2c->endianness == LITTLE)
-		ret = ioread32(i2c->base + reg);
+		iowrite16(value, i2c->base + reg);
 	else
-		ret = ioread32be(i2c->base + reg);
-	return ret;
+		iowrite16be(value, i2c->base + reg + 2);
 }
 
 static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
@@ -1480,6 +1498,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		return irq;
 
 	pdata = dev_get_platdata(dev);
+	if (pdata)
+		i2c->force_32bit_access = pdata->force_32bit_access;
 
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
diff --git a/include/linux/platform_data/i2c-xiic.h b/include/linux/platform_data/i2c-xiic.h
index 2e3683c23..df1aeb42c 100644
--- a/include/linux/platform_data/i2c-xiic.h
+++ b/include/linux/platform_data/i2c-xiic.h
@@ -16,6 +16,8 @@
  * @num_devices:	Number of devices that shall be added when the driver
  *			is probed.
  * @devices:		The actuall devices to add.
+ * @force_32bit_access:	Use aligned 32-bit accesses for all registers, including
+ *			byte and halfword payloads, on bridges without subword I/O.
  *
  * This purpose of this platform data struct is to be able to provide a number
  * of devices that should be added to the I2C bus. The reason is that sometimes
@@ -26,6 +28,7 @@
 struct xiic_i2c_platform_data {
 	u8				num_devices;
 	struct i2c_board_info const	*devices;
+	bool				force_32bit_access;
 };
 
 #endif /* _LINUX_I2C_XIIC_H */
