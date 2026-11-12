Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501225;
	b=F8h0XvGVyGkCVqMiXO8JOmwxq/IBd7sl9aflpHx9qe1BTvtX3jsCed1pvrtkMya1xKpB
	 s8Bv0pBrz5/AV2O8S6vl30cl2QIeSQwDEX39vpZI0W2LtMHD1H/xnJnd09Xq2jWon2P8g
	 31rpV9r5KSMtklv43kaBmyDFocrUcX1KRKNLdUarNv10nociu0dXFW8xZuW4Ti4pFowkn
	 tt6haTamDAHf6lLOrcnEZIr+yDidV4MbjNOacXDqWJ7INZXdOZtKxFcbuAqgKKgnrq/HN
	 HQzZj9FKXHmK/ZQkI8Goa0TxWiZwXutSF6dND1d98Jv9l0L+cDc4NDBdI0CV8N8/tBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tbdfNX28L/i/5oHG446ychVES0ZdkWJVAEz8POMkBqY=;
	b=ljK4o4n1HS+OaTMWExdQWTGPLju/gIdbIbJ1iyxZUyYNjd3TGKamqa2eB4g0+3o+7IJj
	 g06wxCsOuPKTrwzAT8FCP6cDEcnN6bKbQahOJrlqRsaTr+q7DCvCgfVWFoyjkrcTzqGVc
	 x+I3TEDTX8luPkkkBz5ADSoza6Gc7qv/94hieRS7ekSbRdbHSqKIkdElQa/YJz48LY2oV
	 mMMn8L1UJaS56iueeGKHLTxGexcIkiD4/TX9jAD7oqq4T/NdTKHIyxvTIOqjbA8YRa9wU
	 s0J01xdyRwlix1opP9K6rAKmJk6+h9jSL1zXgIjUUKyscvlgcCOdrxJyBu5Wqkk5fZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2AaKfmQ;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424960A2623
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4424960A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2AaKfmQ
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3ada81853so4186603c88.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501224; x=1795106024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbdfNX28L/i/5oHG446ychVES0ZdkWJVAEz8POMkBqY=;
        b=u2AaKfmQMcjkan1aCxxE9geaP+hEcpgc6e6VbKe6MHvKKvLl5OiquJ8t3OiCA8tFUH
         71+y/xp39lOCobqJzEV5TxPX+NqchZESmE3yrZxyDc523SbckeZIJVHZETvwg5rZxsyX
         Ieb2wrQzIQzHz5CXixJaeE1f8rCKTSGh0MqmL3z1tjwgA0FDBi8t1qjtT0+ekiZv99B2
         3P/zd+UE1ekNbsRYKBOo0gCY1CnxCgDdhopwG5uFfVqmkX4IaZD7ErEvvbiZSvxuYheU
         Jx1CA49JBenGJ7OH/cI1fyhrbxITDhiNtIcoXXi4bKeMAYCJGHtUGb2qTHAkSztKEj5h
         XULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501224; x=1795106024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tbdfNX28L/i/5oHG446ychVES0ZdkWJVAEz8POMkBqY=;
        b=cpO98uv0QQKTcdKSWMDTv8gLAcQhrRs50wYC4AcogtI3X3NaegDjbN4x3yK+scpSge
         VgLUYaFAgc309cv6/DfYhDsiKWnTCiBiZJexwwri5DhczDk8BpC6oVz2igtINfWGoIm6
         M9c25KmU4YRSfJ0VqIWRoAjONc67PR+2cSsx8Yo07H9FWy2fd1yctqJFjxwV+x8k2+pt
         gzuxwfZbjzPgk1RhdkI3QVOEFW0di9aATXjBU0G/u2MkWhVUnKB33PBD7hSWAPMKSBNV
         K9tkx+h01Yfv+y3QFMvML7f+NgY+mMRvHw9Xfer9bztCUK/f7agiZmGGuiocw2TjcQuo
         Kweg==
X-Gm-Message-State: APuU4Z9ivTNiaOZJxV1BVCGCFUIK0cQH9hNN/CeJS6dWvIbXbT7aZOel
	g/d8b7WutbNZqAR99tFSrBmFcrn9afoKwk8KyZ+lPYRO538id6bVHxPK+b6ch4uA
X-Gm-Gg: AYBFou2vb8ZytoE16/Rq5uuyamzmmuWd4IE+g+dTLdgrftOERW/h1/j4PWwk1X808i4
	Nn1Zstlz+0JyxCullyqDbd6NhYqo5O7XamAruFZFm9wsY4VUH6LSVJWq1rKizQSq1ArSJbBSnzd
	mTd61/iSie0JX1Rvc3LBQOium+Y6UP/uiRE0pYbHeFybe5TrXIaTttqzfIFcx/Wm0EyiuaZg88o
	YpElII2J6eFvH3gBEHDaX07tkNA+XkVJKb0Ovmi+Ymu8UbqIald6AAd/pSSrPKvzJyLrs7cEqR8
	qoQBjYR5uxCezr2EqmaNrxIKlq/ZyZUcWT2k5TYsjaCwNu4NhMk6xvl+KMwY60q/GdZYbjx0isN
	O7zkemDbEJOZbeiNooT2Ad8LP1j5Rc1kGAK2XGDRCgNUsbVpYc8OQq1VCPjxlsodF/QGBxgKGLS
	bU599rLFlLnj/Hc9zeqP9E4XOwc5L6NaUEzgjaF7/Wg7husrQNddtXpGMhp0WMpGtWC0cVHRb3c
	y0gc0oP3c4COxMIr/Hs3vxIo5RIJEnd9IIYQwovn8egYy1j8629+8uVUa7lpjQgR/sF7PyWkYPv
	LXPZ4xDg5+hyezlqQBaXRAWpKEgQffJa+lcn3LYtE0wm9rimadzjDqHc9gKsFH8Tvl3GSXnyMrW
	V8N4KMxSgLSRsro6LnDSsppUe75FODBP1G3lAWccLJKNaaD0w6DF5eUAEGY8XadCIub5Vp/+v
X-Received: by 2002:a05:7022:f20f:b0:1b3:b53e:b4cd with SMTP id a92af1059eb24-1b5031003e7mr96230c88.21.1794501224164;
        Thu, 12 Nov 2026 08:33:44 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50300e5dcsm230248c88.0.2026.11.12.08.33.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 08:33:43 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] i2c: xiic: allow platforms to require 32-bit register accesses
Date: Thu, 12 Nov 2026 08:33:30 -0800
Message-ID: <20261112163333.12523-2-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112163333.12523-1-ahmadexp@gmail.com>
References: <20261112163333.12523-1-ahmadexp@gmail.com>
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
index ba560462d..8425a540f 100644
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
+static void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
 {
 	if (i2c->endianness == LITTLE)
-		iowrite8(value, i2c->base + reg);
+		iowrite32(value, i2c->base + reg);
 	else
-		iowrite8(value, i2c->base + reg + 3);
+		iowrite32be(value, i2c->base + reg);
 }
 
-static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
+static int xiic_getreg32(struct xiic_i2c *i2c, int reg)
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
+static void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
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
+static u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
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
+static void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
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
index 2e3683c23..afad9a49c 100644
--- a/include/linux/platform_data/i2c-xiic.h
+++ b/include/linux/platform_data/i2c-xiic.h
@@ -16,6 +16,8 @@
  * @num_devices:	Number of devices that shall be added when the driver
  *			is probed.
  * @devices:		The actuall devices to add.
+ * @force_32bit_access:	Use aligned 32-bit accesses even for byte and
+ *			halfword payloads on bridges without subword I/O.
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
