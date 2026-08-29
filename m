Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193E353A84
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787981172; cv=none; b=b2c+J6QBN4jALYRGoSH1e33Kto6I9kaBIf62fEA7nnLWmpk16aToHkzz/8h31PHf0slw/a86PUZ5xRexjM7SKebcieI/bFH3L8srtwIrf6lYloQ1VDxOBaafCJMhq1KD1w6cRoPBphpdTZOE36KqXBQzv0f2SKoZ/JsaoROZbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787981172; c=relaxed/simple;
	bh=mReJ0qk+WPzQHug/wzwZgzokeoGyjEKDx1oAK0frKb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTDniWGGTY/MANDYwRyjLYGlO/pG3FMXVmObY1uFt9R7RRwnoGLYITqVTWzcT4bszBeWw7RS5eDx0+1oNEutJ9Ix4lPN1zr+jNZrKEUVHt32Nl/QzWlutoSG5StzHphUmFO2Vlh5/Lft5RdYtET6TiICydQgQ3sjyAkVL3qNj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=asHm3tRA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="asHm3tRA"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so2189880a12.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787981166; x=1788585966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puUVl7pjescZC2ZF+/6D0mZfkH713/A5cm+7yIXo/uY=;
        b=asHm3tRAHoiEpC9ghGkTDl5b88n4CecWvpmU0rK2CiOBriP0ooN1Zqlv9WmsI8lNAK
         QtDm3xmrenEQmqFauuN6bK4gbGKNyhllrnCqlKIgrFbc2oz8E3Y1fkhyZE0lC13xC/9P
         pCDPEnY9nsDKbhcUKnLKduN1SOSQIH1MXk74a4dqPjTmIdWQVniUYng0p+sLeOICYqaS
         wtLS9BSogrtu9jzzKoZ+M0A8pw7zkLZZo7/tHMo3bxZoiicfOdeQNOph8/+OazpI/UkI
         D/fSUyvo9U3bBzP5bIqVsvYbFkG3O7AvrauZk6i9bb+yzHIvS0VTq8CJqq9U295beDnL
         WXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787981166; x=1788585966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=puUVl7pjescZC2ZF+/6D0mZfkH713/A5cm+7yIXo/uY=;
        b=UbbZWS8slKn2GUj4b+JgiUKjjtBXvG9eRFF9ijov2sx/+W4b+b1tIw61sRs0NvpKUr
         uvPUGwL/rAuG6SQHgkfUPvC4BKDSou66F+TLavfMYxZS8td8phJ8U1/YrYZD5Ir2kA/i
         rBBMfo84AIEe6gb8ffFqEhgMX1cIcbNIiaZqLS8I0tGt+uSNztjnvPFUVL2WarO2LC6K
         vaPyHS/lyJQhi5jLkDQGE3CluMNqoifP+/SoQzWQh/2da9Z/RgFrbCCz3ZVp2Xv8YICW
         KZXVcDFPghs8pAyOijDfvesTFbzwF44UMK0ByePQ8MgtU5tigfm7zXFXsrQebcArl5Om
         b+Vg==
X-Gm-Message-State: AFuF++nPjEibDp5jG7fiRLRThQnRRD+eGEd1FoZrzixqbQd/ODRNb79v
	uAThNIN0WD9A0uaXdN1i5fauCVOHICxtTs22Py86O3qAMLJUdPvlrzFb+eXo/4i5zE0tfSfyZAE
	gcP3EyqmZpw==
X-Gm-Gg: AYBFou2TgeRgpeTdnyXmr58WC099/v0WTP6JQKfwh6ecn1rm5AcATLM1kufopl8zrFB
	Lj+Q+/+LU3qYiDniEvipgTUwbXrKITivTO9C/fGK4+kanFhPtNCOUkVQpKmtorswZQjXuZOLPC6
	/tlL+I1NXuns0U9uDudgw5GpLHHOF+75R55uQ90tN5rzoI+V3p3P/R0cJdWo4lQ2W2FUmKfPXrE
	Pdu2PtsOjtRCOFrIGaPzOQktC8W5Y+hDWYo57q9rcxZv3R8I1IL9zEjedNkzXRuQCJmZ35rgkFI
	R7Ya0NqzuEsGXmAUXu6n7g/EPouiT4X9jPi+ovl8mQswt+FSIbAidCO2/Lun4J5dMO4pzddtqwq
	fpA2+m/DvtYf18JJbYP3JNFdkkd41YPSJIR6uqhzvxYGkbD1tNbLblPJY9v/IP7HWjz/VdB59jg
	iVVpEhAQqJQS73ztjct0rswnWmkFsKCtiU2yOlXX8brg==
X-Received: by 2002:a05:6402:e95:b0:6a6:32fa:1e9c with SMTP id 4fb4d7f45d1cf-6a632fa1f14mr123281a12.20.1787981165662;
        Fri, 28 Aug 2026 22:26:05 -0700 (PDT)
Received: from remote-01 ([45.85.105.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee75a36sm163750666b.28.2026.08.28.22.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 22:26:05 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next 7/9] net: mdio: en8811h: add the nested pass-through bus
Date: Sat, 29 Aug 2026 05:25:44 +0000
Message-ID: <20260829052546.1152446-8-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829052546.1152446-1-f@lex.la>
References: <20260829052546.1152446-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registering the bus is what publishes the PHY, so it must happen only
once the MD32 is running its firmware. Put the PHY on a bus of its
own rather than on the parent so that the device tree can describe it
normally, interrupts included, and so that the MCU keeps ownership of the
reset line the PHY must not touch.

Only the address the MD32 answers on is passed through; every other
address returns -ENODEV, so scanning this bus cannot produce anything but
this chip's PHY. phy_mask would express the same thing but is not usable
here: of_mdiobus_register() overwrites it before walking the children.

Take the parent lock with MDIO_MUTEX_NESTED and use the __mdiobus
accessors, which is how the DSA drivers reach through a child bus into
their parent.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/mdio/mdio-airoha-en8811h.c | 128 +++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/net/mdio/mdio-airoha-en8811h.c b/drivers/net/mdio/mdio-airoha-en8811h.c
index e16211da3d70..b28e116289e6 100644
--- a/drivers/net/mdio/mdio-airoha-en8811h.c
+++ b/drivers/net/mdio/mdio-airoha-en8811h.c
@@ -17,6 +17,8 @@
 #include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
 
@@ -47,6 +49,112 @@ struct en8811h_mcu {
 	bool warned;
 };
 
+static int en8811h_mcu_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct en8811h_mcu *mcu = bus->priv;
+	struct mii_bus *parent = mcu->mdiodev->bus;
+	int ret;
+
+	if (addr != mcu->mdiodev->addr)
+		return -ENODEV;
+
+	mutex_lock_nested(&parent->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = __mdiobus_read(parent, addr, regnum);
+	mutex_unlock(&parent->mdio_lock);
+
+	return ret;
+}
+
+static int en8811h_mcu_write(struct mii_bus *bus, int addr, int regnum, u16 val)
+{
+	struct en8811h_mcu *mcu = bus->priv;
+	struct mii_bus *parent = mcu->mdiodev->bus;
+	int ret;
+
+	if (addr != mcu->mdiodev->addr)
+		return -ENODEV;
+
+	mutex_lock_nested(&parent->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = __mdiobus_write(parent, addr, regnum, val);
+	mutex_unlock(&parent->mdio_lock);
+
+	return ret;
+}
+
+static int en8811h_mcu_read_c45(struct mii_bus *bus, int addr, int devad,
+				int regnum)
+{
+	struct en8811h_mcu *mcu = bus->priv;
+	struct mii_bus *parent = mcu->mdiodev->bus;
+	int ret;
+
+	if (addr != mcu->mdiodev->addr)
+		return -ENODEV;
+
+	mutex_lock_nested(&parent->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = __mdiobus_c45_read(parent, addr, devad, regnum);
+	mutex_unlock(&parent->mdio_lock);
+
+	return ret;
+}
+
+static int en8811h_mcu_write_c45(struct mii_bus *bus, int addr, int devad,
+				 int regnum, u16 val)
+{
+	struct en8811h_mcu *mcu = bus->priv;
+	struct mii_bus *parent = mcu->mdiodev->bus;
+	int ret;
+
+	if (addr != mcu->mdiodev->addr)
+		return -ENODEV;
+
+	mutex_lock_nested(&parent->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = __mdiobus_c45_write(parent, addr, devad, regnum, val);
+	mutex_unlock(&parent->mdio_lock);
+
+	return ret;
+}
+
+static int en8811h_mcu_bus_register(struct en8811h_mcu *mcu)
+{
+	struct device *dev = &mcu->mdiodev->dev;
+	struct mii_bus *parent = mcu->mdiodev->bus;
+	struct device_node *np;
+	struct mii_bus *bus;
+	int ret;
+
+	np = of_get_child_by_name(dev->of_node, "mdio");
+	if (!np) {
+		dev_err(dev, "no mdio node describing the PHY\n");
+		return -ENODEV;
+	}
+
+	bus = devm_mdiobus_alloc(dev);
+	if (!bus) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	bus->name = "airoha-en8811h";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	bus->priv = mcu;
+	bus->parent = dev;
+
+	if (parent->read) {
+		bus->read = en8811h_mcu_read;
+		bus->write = en8811h_mcu_write;
+	}
+	if (parent->read_c45) {
+		bus->read_c45 = en8811h_mcu_read_c45;
+		bus->write_c45 = en8811h_mcu_write_c45;
+	}
+
+	ret = devm_of_mdiobus_register(dev, bus, np);
+	of_node_put(np);
+
+	return ret;
+}
+
 static void en8811h_mcu_fw_poll(struct work_struct *work)
 {
 	struct en8811h_mcu *mcu = container_of(to_delayed_work(work),
@@ -60,6 +168,15 @@ static void en8811h_mcu_fw_poll(struct work_struct *work)
 	if (!ret) {
 		dev_dbg(dev, "firmware %08x running after %ums\n",
 			mcu->fw_version, mcu->waited_ms);
+
+		/* Unlike a missing firmware file, this does not resolve by
+		 * itself, so unlike the poll there is no retry: surface it
+		 * once and stop.
+		 */
+		ret = en8811h_mcu_bus_register(mcu);
+		if (ret)
+			dev_err(dev, "failed to register the PHY's bus: %pe\n",
+				ERR_PTR(ret));
 		return;
 	}
 
@@ -86,6 +203,7 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
 	struct en8811h_mcu *mcu;
+	struct device_node *np;
 	u32 deassert_us = 0;
 
 	mcu = devm_kzalloc(dev, sizeof(*mcu), GFP_KERNEL);
@@ -95,6 +213,16 @@ static int en8811h_mcu_probe(struct mdio_device *mdiodev)
 	mcu->mdiodev = mdiodev;
 	mdiodev_set_drvdata(mdiodev, mcu);
 
+	/* The bus registration only needs this once the firmware runs, but
+	 * a DT hole should fail the bind now, not as a work-item error a
+	 * second after probe already returned success.
+	 */
+	np = of_get_child_by_name(dev->of_node, "mdio");
+	if (!np)
+		return dev_err_probe(dev, -ENODEV,
+				     "no mdio node describing the PHY\n");
+	of_node_put(np);
+
 	/*
 	 * The core only claims reset-gpios for devices flagged as PHYs
 	 * (mdiobus_register_device()), so claim it here. Owning it at this
-- 
2.53.0

