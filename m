Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64304517BCF;
	Fri,  4 Sep 2026 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542948; cv=none; b=ZsKYsFpBUdmnmGQvo+e+vWm8hmsw1QqRNQwOORVDullSHZHqenVuq2+ufNcEgDThLOc+lRPhJFAbttD+UE3fOdxvkcxc9jEhY2K8iT1shuV++QK+3b6Va1ZCd1a6xmx9t8NTCGAovV4tgmxoUG98mUnpQ0eEgwSGn/NV87bVRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542948; c=relaxed/simple;
	bh=Vs8kCnN22Z+qLs5Czfaa/Cs53Fn8mkbv+W+xbBDEH4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pw4kTF6U7gMZhWDBnMxLM2Zv79PgrS1rEoYZtzqVT8jXpCQYahRZh666SqxWy+R9GC1w5BGjBj8Z/Ln82hQsIgJPIWQ+aVqQ0BLhX/E5NbSh0IhewEFK6JvVbigbWOSvBXbx+ZC1u/3QnqY2QDi/nsxXFEchIh9QeUlUAIXru00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vRO+lEJ1; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ygp61Wgj; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vRO+lEJ1";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ygp61Wgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542931;
	bh=Vs8kCnN22Z+qLs5Czfaa/Cs53Fn8mkbv+W+xbBDEH4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vRO+lEJ13bPWawVV6ZONlX6H8W6UNZ+KE7KzNljGrdNicRwVHhgT47fewx7pkGHpT
	 X24jRIlhp3tBCTEz+coK9RV7BFbTDdMXXEhPgR5UzIER6GS0ZuWV3bMMHAZdGztTqd
	 5byGOllUdgYdStm93F1BTt1rWy0TtqmBgeHkNB5pQ48ULFygPYnmu4FGjvSImK/Cl2
	 On5W8KH3eQTP6xtwvXhSz8Noiff1A3OE/ZmvdddGwQx0T5BN+rwLEhy9PwufvK8+F+
	 Jq0EMwvcigLWwyXhXSN+KN6SSSlib+gMdJAQPRPKmSQdBw8R5VdV9jBhg7yEf6Y6YM
	 itCvVyl9ym1BQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9010A3F0D8; Fri,  4 Sep 2026 17:28:51 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542918;
	bh=Vs8kCnN22Z+qLs5Czfaa/Cs53Fn8mkbv+W+xbBDEH4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ygp61Wgj3iK/APbmwsaOwpoxtRH/5ZDGM7hYJsG94LjV9WVh8JdUrbAdjgTT+xhkL
	 z29e9EtYeimNx/uj3UVdAdbQ2IJQFvvN50DxJNaSOnEPBk+9Hr9rTfylw57CsNSMLv
	 Lxg2z7FgSXNdgzTYAjYhWxiG/vSDtvEvUqiCHk+ZYeh7uQNNspiQ+VTfi7AVgY74Ps
	 CuBmGA9eIV+B/PGzTm2FWOCgwYil4wQlvgBHXYZPgrcU/3/XY9kcRDuYPxSlKm6tHg
	 N28e6rqn9oCQOWBNfiIrB7vu0bo1Dl/XFvzy/cZrWsLIFBkV6/gToHPWih9UCrczdz
	 l2Q9TtIRCcqVQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3BE623F0E9;
	Fri,  4 Sep 2026 17:28:38 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:39 +0200
Subject: [PATCH net-next v10 14/15] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-14-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

The AX88179A/772D devices have 32 efuses with 20 bytes each,
which can be randomly programmed. The AX88279 has 16K FLASH.

Provide ethtool read capability for these devices. However,
no write access is provided.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_178a.c | 19 +++++++++++++++
 drivers/net/usb/ax88179_lib.c  | 54 ++++++++++++++++++++++++++++++++----------
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 1d35ef90eceb77b27e8d96e64a008c63b40f4bd7..55564aa0ca63f09d5f592415e15df20368c3238a 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -687,6 +687,19 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 	ax179_data->resume = ax88179_resume;
 	ax179_data->suspend = ax88179_suspend;
 
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_CHIP_STATUS,
+			       1, 1, &ax179_data->chip_version);
+	if (ret < 0)
+		goto err_nodev;
+
+	ax179_data->chip_version = (ax179_data->chip_version & 0xf0) >> 4;
+	ax179_data->is_ax88772d = 0;
+	ax179_data->ip_align = 1;
+	ax179_data->eeprom_read_cmd = AX_ACCESS_EEPROM;
+	ax179_data->eeprom_write_cmd = AX_ACCESS_EEPROM;
+	ax179_data->eeprom_block = 2;
+	ax179_data->eeprom_wen = 0;
+
 	dev->net->netdev_ops = &ax88179_netdev_ops;
 	dev->net->ethtool_ops = &ax88179_ethtool_ops;
 	dev->net->needed_headroom = 8;
@@ -711,6 +724,12 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
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
index 3b498206c50d5b5d9d5cd489114ef28bf280fe97..db77b7d4539ec52756a93d3c56d46155de5570df 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -194,36 +194,61 @@ int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
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
+	} else if (ax179_data->chip_version >= AX_VERSION_AX88279) {
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
+	for (i = first; i <= last; i++) {
+		u16 value, idx;
+
+		ax88179_eeprom_access_params(ax179_data, i, &value, &idx);
+		ret = __ax88179_read_cmd(dev, ax179_data->eeprom_read_cmd,
+					 value, idx, ax179_data->eeprom_block,
+					 eeprom_buff + (i - first) * ax179_data->eeprom_block);
+
 		if (ret < 0) {
 			kfree(eeprom_buff);
 			return -EIO;
 		}
 	}
 
-	memcpy(data, (u8 *)eeprom_buff + (eeprom->offset & 1), eeprom->len);
+	memcpy(data, eeprom_buff + eeprom->offset % ax179_data->eeprom_block, eeprom->len);
 	kfree(eeprom_buff);
 	return 0;
 }
@@ -231,12 +256,17 @@ int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
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

