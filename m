Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186943C3F52;
	Sun,  2 Aug 2026 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688371; cv=none; b=npFEos1qfWLJV5Kf7y7ni3nwRM7SV5v/Ni1P/dlThC1SEViigrDOEKmVPdDl+iSFthHgOfVflDuzD8Vr4hBWNSNkDXGIRk50BeyoKgY4QfIeiiYeriBO4dXxhPQLZc8cQR6UytzLHPvj2NRR9BI6To0GmsIzGE6X5gUxUoFyWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688371; c=relaxed/simple;
	bh=jShhd6P/W3mf0dYLRwM2NXXvZDo9conzYgts+79W70E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNN/X3Qv4vz3uQiLltaATVrrXLfuHdpiSkqzv2w7OlLeAknthoi7DLik/fa4vli7WBUh4jZaiMaWJMfODLk6HL/yVtnAokKOhuGWTVEdb6EpL6/zTyW4FzZZZP1olGehzjBsK5Va6N0Z2NSg5JZpZx3vdVhh72Zw2huOMRC2pEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1PPiqZQ+; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=TsGD2429; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1PPiqZQ+";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="TsGD2429"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688367;
	bh=jShhd6P/W3mf0dYLRwM2NXXvZDo9conzYgts+79W70E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1PPiqZQ+wyO+/Dk2jtghBj/O42FvhD8Y/pINwSLqe4ZTKJJTGOeAWc1G/yoYl6ZJf
	 uu2RPEIuVwHH4gebXALh7n6wFHXTTYyFeXScnFF6PpE9G1VadjIYifi6P9LKAVtupq
	 QDgjwZoe+OIzq0t4T/z3LuuTFJ0OXDl2GXjf8O9XAIucgTPy3TB/1R+yhV/96AKu3g
	 W2UpVriI7Iblvve8VUCsaz6HWkF6bR2iZsx/PEQvAwruYfHy0HKCHostYejunpBg9h
	 I2cT0+Fg2wCV9lmP7ZAsgPpvPgjMzf5RWrHpkGi/Q2N3tlulvNt8eBMHMd550krcX8
	 oKYtM3r7WjE6Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 33D4649657; Sun,  2 Aug 2026 16:32:47 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688358;
	bh=jShhd6P/W3mf0dYLRwM2NXXvZDo9conzYgts+79W70E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TsGD24292kzZRItsnwdXfX9QrAskkkc/5kgkZuXcYpWCaH95dN33wJs6XttnMDJ4D
	 Q6RLqHnUF9xDdQCPPKTyF/oUGvBTPsbnxhDMuB1S6SO56UnJu+ln0yXY7AxiLVV9B0
	 XpGGP96LK386bbeNUzHiBm/okMCVhXQArlK3lvBSTZyHGmiMjcPxGBDppC1k31CIXL
	 oogiXNujg5QkueUItaurrMfarX3/qX9IGNIFNbRxJ3t4zNEH9kWtLJ1XqTu+LL3YS7
	 MGU6zbkFL2BjH1a9/S3fm4AWpPB+iNTgnFTV+gNRCz60wTM2sj8YyVo5Tejn8xHIVJ
	 QUUglVMb9v7Dw==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id AE7FD4964E;
	Sun,  2 Aug 2026 16:32:37 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:32:10 +0200
Subject: [PATCH net-next v5 12/13] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-12-dcb9fea4acd4@birger-koblitz.de>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
In-Reply-To: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
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
index 6d6ee39b342e9b4e008bb2c1ee276dc27279a2f7..be72ed955b6b8b1700d5f3624c59d7dea1b3d1dd 100644
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
index 8aa5489d4bbc46faa1545cdfb85f65d8035c0c3c..22209640734c884a0c83d76ad72e4364dd29c653 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -203,36 +203,61 @@ int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
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
@@ -240,12 +265,17 @@ int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
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

