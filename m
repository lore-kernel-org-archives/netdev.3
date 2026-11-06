Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949705;
	b=lfqEjZkIPqHLcuN2wWZ1g6gMus46+hYwtI81IsYZLrxPwu/FlHu79hQJ3qb27Isq9DeI
	 uPv8Ld8wbi7Qspad0Ek8EBhc0/cmUoCOttRWgulb9BR24YfBPa++/6vdzYiSMkKLullKb
	 EptfmMqnjYb/XukmlySdP/rQqxj44aORta0B5vmEy8+2aXrkkFh7X9RUVoAJlQewNfhUk
	 0zxc5g1v13pug4/X8qMq5SLmbowwzBDhw+sEucO8gKRXpV3fvLdIdByvGyKHa4shTngA8
	 ut9soPrY9A/gYqO1abI/p8wXxzO36u7mlfNr8E5fwl41P4hwnzjIGasvkTznrZJ5Yzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949705;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=/Bn1UWSqe/x7wRcIRhV+YWmEErOE4N8bWv5vbZ8rj8A=;
	b=L4Um40tSoUH8zIaNG2chU6f07IMU+8bT7GSKsJMSK0enUqyoWzgCC8yBxH3iMxJLbsuW
	 rwOCxHirBOaIK/+kPKaI5/NfMhmhqF0xdsmfvFXrS+KhfEFLqHLXgjdx8DhsF7ctKH5ra
	 /iY/B8YjZ0GlkD2YnH8XWvwT2IrYjr2eqH5j306bSpkky6w/qRdqdgm/cgU/RFkaWKCab
	 vxF4D1wgSv3GliXTAA0GAK1O0HeWc4DDCRosM11oHcr/zAWNfIJoMSSrMt60OpNM7RWNf
	 AEVIQnrI0lEK+Gk0FxyYKYvnF9DQ9M3LJhrmwzjl59USVZBN3fT0ezUVTvYNjAIj8Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=oKiWHIcL;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=XeIKluzk;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED396606D836;
	Fri,  6 Nov 2026 07:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED396606D836
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=oKiWHIcL;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=XeIKluzk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949703;
	bh=wbyh46mLbRX2HAkQs8o5MxoEDkveQAGJhXB98EFdgcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oKiWHIcL/aNokAtq0xsNHmsLZLNI5C97R/90M0ydO2G77urbAYGhlVI1g8zqe2h3D
	 xFxMF7yb7tBohl7FT6MqRV7gqPkVnx3iK9o9wn08p5Q2nlM+f+WXNXuZKYsudJOTWN
	 Zt1l/rhzQ1cIqF8NLRKdYQPHSfBrMwxwelkAgnJI0NJZcFKpHjzhWzhQcDYCW2rCzd
	 dQGgcNxR+cDOR6zFnOCTYbHO97J+nfc8+6Q+tU2Y6HuAqllbyddg0KKfoDRITbjA4s
	 lJ6PB/kYEUQbGe+k7592L10NayYVL9HRzDQ9usBOLRUNwAW5DHIslpFCHAzKI8B2jb
	 Z9zewxs9Coptw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9262048BB7; Fri,  6 Nov 2026 07:21:43 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949689;
	bh=wbyh46mLbRX2HAkQs8o5MxoEDkveQAGJhXB98EFdgcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XeIKluzkztNDIagzrLM9WcfRLNY3odtXDfVxr7pkSCsBrKTSQ9vJ19seKg3Jv6irE
	 sSMvSIq/77zQ/3BCOklWdLx1UCf/HQhOPdwrV/EdzQ5u+CocsIzxvqWlgexKPdvgmy
	 FyUTw+0T56+o+2bOP+eL+p9vW2GA1KdwJ37aHvzJRTUtdo5IGMZYTyoa9Gn0LSBegw
	 51oCG0kHf2rEzUOnEAVpU4AvBWnbpsnqRjSy0muuk59gvlgTgRaqJhqaY1py/haqCM
	 xeUbEifI2DInWhLWmGVDUOQf5kC/j7BRKeFe4QT8apTIloxow5nBCFzFrMo11uszIa
	 v7/CvHZVZBsJw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0F98C48B89;
	Fri,  6 Nov 2026 07:21:29 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:27 +0100
Subject: [PATCH net-next v20 12/13] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ax88179a-v20-12-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
In-Reply-To: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Emir Beganovic <beganovic.emir@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX88179A/772D devices have 32 efuses with 20 bytes each,
which can be randomly programmed. The AX88279 has 16K FLASH.

Provide ethtool read capability for these devices. However,
no write access is provided.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_lib.c | 56 +++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index b54e98e781f334c5aeff0b3d2861a5565934454c..d5bbaa0c4e4c6f978722a6ec4461bb1d45679e15 100644
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

