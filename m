Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379573F58E8;
	Sun,  4 Oct 2026 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092377; cv=none; b=o8zdxv6GT6bRFo+x6gB3ZPVnJULo8P2dMIlHV0TYZE3ibf8ugzZ8iwn+5FxC2ACnH5BmWqHAm4X2vtPBscjqwcLZTOX9JgE5DprdHsU59bmnVqyJLCJmveVaORzsbcgpw5ooFjSyhKgDHtPzo2vYuP/PDHq0Q3fyQ2IjYZId7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092377; c=relaxed/simple;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFcEg7Dwz5QN3beOgj7KNDysGaV5GPBZQacFeTf7g4zMW9AUcnyz/bIHhkOpTUTod3n8u3ZeYZH1YtIb6cYZhRJ4TVGtEazvBHeCccR9goJfADjenrGLewMOIK4PAhk585y/nsmQoHQcn+PM65RrhyB4Ica0PuM9eH422iNTT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=sYIhkBIK; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=XC6bq7jm; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="sYIhkBIK";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="XC6bq7jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092367;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sYIhkBIKd7clOls2ah96kwKfWVsEarM/iwycif9cP3zmtG3dktyJFUuamsnnZtFSL
	 eELsMbLNRt9FjtpW3oeZJb0zdeUbOAvsNuNY4anL+NhgRff/eLzl7qu+r2YPiVpoiA
	 l7Gz5X6vK1LiG2tBQg/FEeTvshmEVczPWQz2nxqzF+Vyq4MWGUOkk/GeeEYkj/AgYO
	 VsnZ5YdiXZLfIijUP9fRjrYElgkHHdQg1VjcYjQ/AmZGAvdVUhotc+yxTa1hrtIyGd
	 CcpYf0xBxh2RJGs6L+nT/IrEpFvDdUbe16w/hQ5v7r73JKZAJ1yCvsCG8shkEOIig4
	 bj426xGkefzcQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3688948355; Sun,  4 Oct 2026 05:39:27 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092349;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XC6bq7jmIMplAI7FhA47VHLmncYbGyM4nrr9f+rJKKCgkIdQgbkpJzcsMJx81SVFy
	 YeSjvA8O8uAITBm69+d5qAY9NELFulTNvbXwRboo7C0XBPHnFwPKWAzaZW9ng3r5bp
	 u3I8DwGIYvNUzt2BFXuXErbOUyo9hJmwpCPP3EyRlZMpKG9lQESz4hjMdL7cdvaIL2
	 lEI/srfRbCrKYoWqbPmdgjvZkhihpbngHbIlR0eB2s/erSGUyGWSCxwU2dLr7zhVCb
	 1kQ4PmWUG/QKeP3air9xaVmbhqefCYezRpWFLtdxML6LfeEaqCOOPasddKrOs9H4dS
	 Fp1GPv0/oRk/A==
Received: from AMDDesktop.lan (p5dd1ef42.dip0.t-ipconnect.de [93.209.239.66])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3E4F6481F5;
	Sun,  4 Oct 2026 05:39:09 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 04 Oct 2026 07:39:16 +0200
Subject: [PATCH net-next v16 12/13] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-ax88179a-v16-12-2a9ae4e68f7b@birger-koblitz.de>
References: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
In-Reply-To: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
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

