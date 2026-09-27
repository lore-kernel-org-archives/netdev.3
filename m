Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178293E40F0;
	Sun, 27 Sep 2026 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502248; cv=none; b=e1XBEqivEybWASpdTQr+oQn43a7hHJnkNkWmCMI5NiZY2g7h4fRZhR0/zyynaK3NxIarGXql/DzELpymzStkGGIZ2tWwBrXQU+iVFKOyyCDbtngx4MmGcHQK7HBOUMnKv1nfgQlaynr4pdahv3V/Yrr3scLIe3Ieu0LP5ef+8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502248; c=relaxed/simple;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5uhqp79epC3/YyYeqnRph+nc+dnNBcGjSvdEqCaiXn6RHq9aWVZYJWpGsP2QlIK262b/G4bU4B3WtdByolx4aGWJT6fxCNIGSQ8lDuz7CUkzIOqZJmRtCpzRanPqbyUlHwr9oZcDvP/jxGnrL9XsH/Lq22ecWzueeHb0WTlzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KIKDXmVZ; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=GsKdiksQ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KIKDXmVZ";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="GsKdiksQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502243;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KIKDXmVZ0aE/cRTq2BJcFba90f3zBKcTmMbg6MHCexipTxED6n9zPCtJ5zopdGQqF
	 PSMZkH1SXjTlKxhPmnB6FZRIbi+ne5KGPqaudzApU4BssqiBGanXXBGVqZwAf0xg4g
	 f7XBS4dF3qEIjkZIj05QjogXMUayrRKtlto0eHwP0mCkYr7NgDqt3K7LG4PgwkLRnq
	 Gdqkni1cjlnhRcANO8/ebJbsr1EPCGdeHR90Mc6LA3aF6l/gkO4J9BQiLmEyNa22/k
	 09WORJa0AG5wsJC4tIsXQkk8cdL+lI2JGnXQTIc6YQ8UPj0VFIgWvGKNBpaBQBZ5vp
	 Sgfy6fNaVktuQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5804741F78; Sun, 27 Sep 2026 09:44:03 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790502223;
	bh=aIESsd1MIYvyD9ig8en/i82IfOWwWDuZSS5pbC1x0Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GsKdiksQws0Jg2q8vzLf3cdeSKy2YuaUXfFkyqzO9MFskotgwWGKYLLIVVG0j4s1/
	 MHxF/b54512HziR5SO/a+kfhkjhjvfnUXD6Fp9SEWD7fB3TIATg2+x9arxCYxvoDb2
	 ayg61S/mqPZYMIJqTeBE9ykM/VKMzra6pmd5YHr+T5LpbY8tgmMkLMFHl5cl+TCaNy
	 uU6rwvAi83N9lC/Kk54TlzkQixriKPFcwSEVmz+wH3ktNKCI5/4tbQHseh0sl020/L
	 S7VbEn0vDvbSG7bot7ivftRMbqmxoisTSrSakkDyVDgclym2lg4UoxQx1vXNbuqoNX
	 23gmEES9YFnnw==
Received: from AMDDesktop.lan (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 59841420DF;
	Sun, 27 Sep 2026 09:43:43 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:43:51 +0200
Subject: [PATCH net-next v13 13/14] ax88179_178a: Add support for
 AX88179A/772D/279 EEPROM access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-ax88179a-v13-13-4fac6b3e032e@birger-koblitz.de>
References: <20260927-ax88179a-v13-0-4fac6b3e032e@birger-koblitz.de>
In-Reply-To: <20260927-ax88179a-v13-0-4fac6b3e032e@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
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

