Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D255361DA7;
	Fri,  2 Oct 2026 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916506; cv=none; b=Yjy97fbe2B+cRg0/uQhmXA5ibBfLxnRM0pMfHk0PocAnsFK4nfxpkolQKCJwHz0qyNqOs/mJJtEVf6XiyS7FdVYQjfq5j+ey3gZEA/VhrEelGip1VZzphfsdcUAgXoQI2aJQBNDPR/Bx4i0E6bz9tkBqVjN1LjqNeE3VA7O67yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916506; c=relaxed/simple;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSbAv7PC+4ZZJM20a5GNQfo/2U3KcxlJvAkwdfKsdd8hcq1TESTCV9pF2xLz5WmKJcCZvTS8YVjj7E1kPkBVRSyb0wC5KF2EIQwz/y7pCPlTgORean08WPeTDypj9Vajeoe+j2NyXqZh/DxP4bsHIL0Ti4kelkUtI8aWl/m80PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ghNt2oVh; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xT5nLKeA; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ghNt2oVh";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xT5nLKeA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916496;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ghNt2oVhI1pmWtiffusSz3eR6gCkUxi9P5YtNKtl8TV0gsQwRYNV+ro2kfohJIvm5
	 73hFaYVD/HJRBqm7ZgBz8YgJOEIdpmJPJiT9zdisizBbvsEbQKQa0nArmir9lmuw2k
	 TVDdL4N6gSVhTaUAaAICxWTdeCsEZKt9sFdZ2gdyAO+cvW7XJm24j857HV084JP1KQ
	 l9y5QdpNHzihul2+bg4NlMsj3FoOAgUr/JLFH4CHs+AuL9JTFeLyt5qYw9k0yRYyXL
	 2i5q7dl3w4VFWXcMYRCcUbF9hqf9E2OV8O0VpItOtTkrhqGUjpfrETTpvgCZc53cBU
	 ynE9B8RvOSDdA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D2C7147E1D; Fri,  2 Oct 2026 04:48:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916480;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xT5nLKeAIHWSMx08QoIpktrefSjbReitE4W1mpnLg5hoBt7kyXN70TfYlnbdEDVDz
	 k7LmBpfB8ni5rmkDbfCcf4zvt0PUz9VjQflV3Deo8D13LyN41vr5Ouqw80WAaIQ8Tp
	 G9/P/mpRJZs3ihSIMeNyniO4VrYKZBL0grmJnt6HVC5Ns6yKMRPPhKd/7hBhEOB52F
	 uoxoQ5EcJYtU4WomYXJqtGSZldc3Io5ROmoUKLxPE0yo7lqlYqSggjnsB9XNOwp//+
	 50W0EPWA+rVYdnASdiR1tmhTaxIwHafk4oy9YD6Kc7iivWhsutVQB2MfMnBYEVhc3m
	 GcU9gqCW7tVhg==
Received: from AMDDesktop.lan (p5798b2cf.dip0.t-ipconnect.de [87.152.178.207])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 69284481C1;
	Fri,  2 Oct 2026 04:48:00 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 02 Oct 2026 06:47:56 +0200
Subject: [PATCH net-next v15 12/13] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-ax88179a-v15-12-131d9286fcd7@birger-koblitz.de>
References: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
In-Reply-To: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX88179A/772D devices have 32 efuses with 20 bytes each,
which can be randomly programmed. The AX88279 has 16K FLASH.

Provide ethtool read capability for these devices. However,
no write access is provided.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_178a.c |  6 +++++
 drivers/net/usb/ax88179_lib.c  | 56 ++++++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 8b52994e2a604101b61ec9cc0d698a0ecb520a14..7ec71438054844c7263c82ca911e42ea5854a682 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -724,6 +724,12 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	ax88179_reset(dev);
 
 	return 0;
+
+err_nodev:
+	kfree(ax179_data);
+	ax179_data = NULL;
+
+	return ret;
 }
 
 static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 6f32d4da601ca11d19cf428ecb79206ab4460f3e..de849650f7871022290fc1ba3e3d463434e42fbe 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -210,36 +210,61 @@ int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	return 0;
 }
 
+static void
+ax88179_eeprom_access_params(struct ax88179_data *ax179_data, int i, u16 *value, u16 *idx)
+{
+	/* AX88179 has a word-addressable EEPROM
+	 * AX88179A uses EFUSES with 20 bytes length
+	 * AX88279 has an EEPROM addressable in 256 byte blocks
+	 */
+	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
+		*value = i;
+		*idx = 1;
+	} else if (ax179_data->chip_version == AX_VERSION_AX88279) {
+		*value = (i * ax179_data->eeprom_block) >> 16;
+		*idx = (i * ax179_data->eeprom_block) & 0xffff;
+	} else {
+		*value = i << 4;
+		*idx = 0;
+	}
+}
+
 int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
 {
 	struct usbnet *dev = netdev_priv(net);
-	u16 *eeprom_buff;
-	int first_word, last_word;
-	int i, ret;
+	struct ax88179_data *ax179_data;
+	int first, last, i, ret;
+	u8 *eeprom_buff;
+
+	ax179_data = dev->driver_priv;
 
 	if (eeprom->len == 0)
 		return -EINVAL;
 
 	eeprom->magic = AX88179_EEPROM_MAGIC;
 
-	first_word = eeprom->offset >> 1;
-	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
-	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
-				    GFP_KERNEL);
+	first = eeprom->offset / ax179_data->eeprom_block;
+	last = (eeprom->offset + eeprom->len - 1) / ax179_data->eeprom_block;
+
+	eeprom_buff = kzalloc((last - first + 1) * ax179_data->eeprom_block, GFP_KERNEL);
 	if (!eeprom_buff)
 		return -ENOMEM;
 
-	/* ax88179/178A returns 2 bytes from eeprom on read */
-	for (i = first_word; i <= last_word; i++) {
-		ret = __ax88179_read_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
-					 &eeprom_buff[i - first_word]);
-		if (ret < 0) {
+	for (i = first; i <= last; i++) {
+		u16 value, idx;
+
+		ax88179_eeprom_access_params(ax179_data, i, &value, &idx);
+		ret = __ax88179_read_cmd(dev, ax179_data->eeprom_read_cmd,
+					 value, idx, ax179_data->eeprom_block,
+					 eeprom_buff + (i - first) * ax179_data->eeprom_block);
+
+		if (ret != ax179_data->eeprom_block) {
 			kfree(eeprom_buff);
 			return -EIO;
 		}
 	}
 
-	memcpy(data, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
+	memcpy(data, eeprom_buff + eeprom->offset % ax179_data->eeprom_block, eeprom->len);
 	kfree(eeprom_buff);
 	return 0;
 }
@@ -247,12 +272,17 @@ int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
 int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *ax179_data;
 	u16 *eeprom_buff;
 	int first_word;
 	int last_word;
 	int ret;
 	int i;
 
+	ax179_data = dev->driver_priv;
+	if (ax179_data->chip_version >= AX_VERSION_AX88179A)
+		return -EOPNOTSUPP;
+
 	netdev_dbg(net, "write EEPROM len %d, offset %d, magic 0x%x\n",
 		   eeprom->len, eeprom->offset, eeprom->magic);
 

-- 
2.47.3

