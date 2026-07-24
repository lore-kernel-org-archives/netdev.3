Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920E3AE71E;
	Fri, 24 Jul 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878626; cv=none; b=b4RAll+KjVuF6u+d5PRoS3x2tB/NYWx+KCs0wGCViWr4FvzXStSRwkdcXI4uzThOJbzgA7kARx6J6fNnF1w7MfbmxSMO6gsbZXMpiJsmhAzz71RF/Ti5kgRrsN//CsgVD5bvf9yFdSK51YZRbDX4E+19WMySw3G0J+8L8uxKv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878626; c=relaxed/simple;
	bh=i7LmyMhtu4hXYIf0Axfzf2NNZgFwjVFEAkQQi6jrUkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+xZctCkBJx+nwEWbWbKxyniTRGthCCAaejK5FQdXa9eMNOia/MYWVpx+h1GEB8GmoC555c8xVsb2ITBWnu44+89F8bIiXT41qsvXMti/P6hgtyb+icGXLqZC4cZzThws8BPCMsQOcGukUcfKN1cNakEikpksreAPRUu96RES8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=XaCtmoEa; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=dQ7Ggtzc; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="XaCtmoEa";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="dQ7Ggtzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878622;
	bh=i7LmyMhtu4hXYIf0Axfzf2NNZgFwjVFEAkQQi6jrUkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XaCtmoEaao7kQNGBnVAcWbcWYCaghgyHYYyAFNiKKydm4ZpvvKT3s+KjO5GG6oF0D
	 T3VXEH4Lk5VVPkbDrMtEZWyqKap8A57iIbJktBnmHw2cJ2ZZFsTuE5fXTC3rIS7c27
	 PIHXb5aPxQExg9YYvuMYGTpbOWaB0QjTl41kBCACboDFcN/cD1C/behQ7eq+HNO2PP
	 Dhhv27OMmKj32zwWL2YYVo3/yAJ9cMOQxpKvYvJHlvfVzMAEYFZqW4S0pIvDpRICJ3
	 x7sdR+TtFZoEly8K45p8UonwD7lNBXHLG4p+TEjuXD56FkCKT6w8mxt8B+gNvyEyqI
	 dwI7FJ7PvVrLA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2F03649374; Fri, 24 Jul 2026 07:37:02 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878609;
	bh=i7LmyMhtu4hXYIf0Axfzf2NNZgFwjVFEAkQQi6jrUkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dQ7GgtzcxudiToLVTpU3Ee13aPov3tczOEJXqNHpkFa5sKLJsUSiJCaQuzJ9GMO3M
	 JulNyl47MstVMzARhXe+GtOhoY1eQ0NJC1CUi0WxcYQ35yrvkibsDHPQ52JhFCGP/B
	 /4hev1Jm5n/PCQjObMkAV1i2eTiMgFHuNd7R8TOx5Lm56mPaDXWXEaLqnveZ3m4XJY
	 WRD9REEnLw1Ugo1onPW9ppNVy80uAPo/yoQlTsxQNJbshTeu5F73MgY2pvma/S/fwU
	 0gktKDoHBfhD/PNogW6n4BxHHqQKES9hMbw2czI5ml3PwiKVxrZMmhd8dBc03plV6h
	 QGCL9jh/wIgNw==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B1AC04931C;
	Fri, 24 Jul 2026 07:36:49 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:54 +0200
Subject: [PATCH net-next v3 11/13] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-11-bdde4f905883@birger-koblitz.de>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
In-Reply-To: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX88179A/772D devices have 32 efuses with 20 bytes each,
which can be randomly programmed. The AX88279 has 16K FLASH.

Provide ethtool read capability for these devices. However,
no write access is provided.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 74 +++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index ae07bd1cf5eb1b15a089b3f67d2f89cf56c10f8f..2b3393e7a3b2221b85bfb7c7b6b7ea6d92fc1deb 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -18,6 +18,8 @@
 
 #define AX88179_PHY_ID				0x03
 #define AX_EEPROM_LEN				0x100
+#define AX88279_EEPROM_LEN			0x4000
+#define AX88179A_EEPROM_LEN			(32 * 20)
 #define AX88179_EEPROM_MAGIC			0x17900b95
 #define AX_MCAST_FLTSIZE			8
 #define AX_MAX_MCAST				64
@@ -38,6 +40,8 @@
 #define AX_FW_MODE				0x08
 #define AX_GPHY_CTL				0x0F
 #define AX88179A_FLASH_READ			0x21
+#define AX88179A_FLASH_WEN			0x22
+#define AX88179A_FLASH_WDIS			0x23
 #define AX88179A_FLASH_WRITE			0x24
 #define AX88179A_PHY_CLAUSE45			0x27
 #define AX88179A_FLASH_ERASE_SECTION		0x28
@@ -868,41 +872,74 @@ ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 
 static int ax88179_get_eeprom_len(struct net_device *net)
 {
-	return AX_EEPROM_LEN;
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *ax179_data;
+
+	ax179_data = dev->driver_priv;
+
+	if (ax179_data->chip_version < AX_VERSION_AX88179A)
+		return AX_EEPROM_LEN;
+	else if (ax179_data->chip_version >= AX_VERSION_AX88279)
+		return AX88279_EEPROM_LEN;
+	else
+		return AX88179A_EEPROM_LEN;
 }
 
-static int
-ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
-		   u8 *data)
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
+static int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8 *data)
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
@@ -912,12 +949,17 @@ ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 		   u8 *data)
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

