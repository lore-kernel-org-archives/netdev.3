Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864783DB96B;
	Mon, 10 Aug 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365261; cv=none; b=UKTIyA7t/V4Ad5oY2r29usPLs3aw7HHvF5Y2HV0l4ysjzvkn+aRH3WMrPGSqJYNXS+ey43CGCfue/nYAZv6LERWLDIEiDRfkNKIW4bkcONZprww1h0PO3QXqmKwK2vzMDSqu5Pzqm/auWupcrI/XtIRpZtCaBv59VJfziKsPd3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365261; c=relaxed/simple;
	bh=ENDLOvvZwM3IKyDzVjoDFXlac3oXz1v+rdzdaJcWODA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHC179GIzhGCXyk0fpgBxBWRWX3bkokN82YTYg66Oxnvu/BBeAM34OeAMz+V62c5HNgEfMqNY7gBP5CRhDeIAdQ6zTjqIAfZ68O0+YcMoBJgQbS3cMfseteQ7kfK0x6jQbAuBWGRd64yeTolCbW8fxt0xN+ea2MDeAqXH+0hPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KNMrLZWi; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WXupIYlb; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KNMrLZWi";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WXupIYlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365254;
	bh=ENDLOvvZwM3IKyDzVjoDFXlac3oXz1v+rdzdaJcWODA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KNMrLZWi5siBre1VOUvOatYfUfFFZpGvDx/SudB3wXUai3RD8M89mhbsCP6FwDTa9
	 zTDoaHaZ2xmkfZFG+UPv5s/e7hr2+4vYeyb9wqCvqsruPrqa6/JPbofF2tJjYP0kze
	 rLzZUGZa8ookWem4T2Jt9xN4a9yKupGwUjM2gh94B0LF+zb0dlx2Gx6xwpTrHIzwA7
	 h8Qsny4jxag7OQAj/hEcp9JWfgTAHmoE/ruehBSyoMx/ClPIt+kOLgGAytVd1wzEIs
	 cDNImOBTp3WjabfGaayx7gzYmi42zPBYLD5JbVuEczy1vlkDCq032iE1Sdvhbccr+7
	 JWfjQxDy98VKw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A3B7949777; Mon, 10 Aug 2026 12:34:14 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365220;
	bh=ENDLOvvZwM3IKyDzVjoDFXlac3oXz1v+rdzdaJcWODA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WXupIYlb2i9E1qzmk4iWT/5WabyWaLIyhAG7Nkko8QBEcNNZWwxVBw5XzMm1fisYG
	 rPGet+pb9CzayvLOGpQ9ShG7YezONllE0M2OsQwJ7kvY20fySW0hisCRRFgckaVDU5
	 OmZFUVditJOlv0UcoPbm2pFA+cfQ6nAlF+q+wrwIdBbOjkQ9ZpP548dxduMAPwGwUP
	 3+1QcOjegwDTWveyV+pvdT0kcCs3bqdBC/XqUyal62Aw7/sLRU3Ib3+ROOyEXwT8c/
	 3KaNyXaXl8DEv49C88KWLZCmUbxVusIq05KBlEKgkSPwh6Mm4u9wq6krWoN1Th1ZhG
	 fTPYRT1pQAr7Q==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0B7294977A;
	Mon, 10 Aug 2026 12:33:40 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 10 Aug 2026 14:33:38 +0200
Subject: [PATCH net-next v7 13/14] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ax88179a-v7-13-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
In-Reply-To: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
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
index a4a49a4242db4949874072e67a73693f2f01baad..9b91ad831333e14522916dfaa67955f4447f66d4 100644
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

