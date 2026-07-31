Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414B4503E7;
	Fri, 31 Jul 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514778; cv=none; b=AR5f+0f24JB8Su/F0PRr7thhsGBEyu5nzIOi4/N1F7mfFqx+PPIP+CVb9gKDNu3kBRMCKQIKmHPkIKHvToXXPU74yN6sYuIejJSsPQbYNDTsNTYsug9UswwHEWrcolK8cGM+sgsYKxp/FdvfLumWYADbpiDXeRweUp4GFUvxgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514778; c=relaxed/simple;
	bh=RAKrO7jaZmWJ9w+4AwupmLMmZbLKdBG4OiMXS6ceL/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8vZnNwHWAhJM/B+Bx7+c8MJTV3uuR5dmcs+Y/l7hviRBifWqjmwFWRIdqlequFWK65NqGIPf3ifsEkvMCxBAJfs83mMZ6LlwH/DwNMsnxdF1sJhb7ZueluBNmkAZlu2iS5WtTVk8BaeX9MIV5OdknaDh1pblUvoXYfadCuVMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=woMRZEWr; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Gfbf3i/c; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="woMRZEWr";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Gfbf3i/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514760;
	bh=RAKrO7jaZmWJ9w+4AwupmLMmZbLKdBG4OiMXS6ceL/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=woMRZEWrByjt62nWOfG99vjo+cF6Ch3ruIBTemUGGD/6qVubDU+CLf219M7SJJJAm
	 OWuKmZwko98bmXoMnoiNKfWWrugNwKGtRHpINHSSQnw3gUwxjxxEPTOHzut+qNFa4N
	 euwzeDhYfLs/UuXy9WcwgruBO0EAGX1lAAWs57FrxHOZA/fU9TwL8i+/VHiqKsW0QD
	 vzW9xlkj5zgpucp9BsYqUpGa4GyS4CX/Dfm2uL4cZFmuRS7j/U16nPyA3XAYGWe3YK
	 pHspLzcQO/MaDXUgyaeUYevGd4Swp5+AGb0caHj0dd+w/w0xzt1PsF7LNqo6Zqk2Dv
	 Dmlp6HGaUHXjg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3154649506; Fri, 31 Jul 2026 16:19:20 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514746;
	bh=RAKrO7jaZmWJ9w+4AwupmLMmZbLKdBG4OiMXS6ceL/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gfbf3i/cF3sifae0Dip+E3BKLQyo0f4+FK1h6kdkUrVn2ShtVKNzC1S8ZZtnZsnPQ
	 UTgg/W8k/OzJIqIs/p9d+TTB1ylBpaRViSED6p0kuecNWUJvz239as/pWti1PG2K2W
	 lHsvnPlsqv8b9ebmb9pvdydMqnnlF+xxZQCQ5b0GVShxNdlwAAl8N6TVhtGqfHKr5W
	 m6WzpCdJQJRsCYt7OYn3j3IwA45DdozoGr53/dDhWsQElJRLaL72hi953cRUVRzPVX
	 Xq37vLpU3LzymDa2ncuzC+z8m2HvaM7/pGfvZC1J45hn8/afqjR61A4V99wyWC9oiv
	 IE4o3abzKUEpQ==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9D4BC494EF;
	Fri, 31 Jul 2026 16:19:06 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:11 +0200
Subject: [PATCH net-next v4 11/12] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-11-2cf1f71b1dd2@birger-koblitz.de>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
In-Reply-To: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
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
index d40b1d3238c86f9e4fb1e5996c239ab417544e7e..74acc377b1f6a21323c08707292cf98ab6f85021 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -196,36 +196,61 @@ int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
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
@@ -233,12 +258,17 @@ int ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
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

