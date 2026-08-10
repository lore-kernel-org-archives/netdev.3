Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A563DA5AF;
	Mon, 10 Aug 2026 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365235; cv=none; b=IPKkZY/CdnjqAdWG0GcS33qNNRfgZMmYTZ21RpPD2oRH80YGceNQdjueOATfcyvdYLpcBpABnnYfaOSz9+BJ/k2eflmYe8qeqmzGti4pruMf+oIgw1xlr05bgMxgOcd41boo6Qj5PDcIo+CmCwTLvQtdgZ4XNvmFSxRMt1PLVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365235; c=relaxed/simple;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWL7fAGvUncvn3l9ABWroM1yN56/zVlxLYddCNbzi68kMFO0PHzOuaSbdy/2hmuw49WV5YhuwHtXEcbSMJLA3xpcHuI+AKZJtZ2/cZsGQJat7iUsi+q1LklQXIDajRa6I+3E/tJYMyckq8+Itl/kubmI6bQuvKSY2Ej/unx+ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qBLY07XP; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fG31YjOG; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qBLY07XP";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fG31YjOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365232;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qBLY07XPN8FKZb+PqRR/0Wx0MsMnBAFVZk5w54BzkL65aUvoQnVCDFUjrnUlrThwN
	 Zp9PfId4luIoawUgCyXkVykxC3pUcDKaig/vOR8n93W3L9KZWFV8lsdXhZWCv7pJN5
	 6DztY1Fr4vckeDxYqbHNCboQdxMe57k+b0zVwdGls8WYyVLuASH5j6MU2QHx8VcZ9Y
	 WnCvz7+M4ZSvfHccvN+EcFURCJJQyCXyg6g7OIL+oilTrbz4a9ULHKw6I3H79KtYVK
	 NGl0IbCneK1zdSDdNqemGHLc5PxB6urPKTXUMKVMO+uBXVA0ukhbAsAsKe9FfbM2yo
	 RQ0Z+enfrp+Vg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 326884978D; Mon, 10 Aug 2026 12:33:52 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365216;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fG31YjOGghkQaa/PvdJz2Az+Vknx6E1xUtOzcqx9sjW2aeLVnchGpXBgutwv/Razs
	 750g8eUNwupzfIlepbQCX88ho1XEzq7q0TcEXzpCK2ts7vdOb66TfLW1CWm8abkjvy
	 wZY/JxP9JL19ciqdE3PiIcHuD2n5cUXaGXO+wzSZRNE5aSf6XWd3+smda7hGr2QUen
	 68P+hmePXdVkvFFW5o1SRyqFf5OuYxnNaZPUSmb5gy5If08eoKeZhbNv6bb3k96lCI
	 ++Q6/f7Ob9sU8JilTUUhJHMvAAQlhC9Z6GQV8NBAWDrdPiumFbT31BApdvnRADdk0e
	 N1d8vfm5OfPRg==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 70EEE4976E;
	Mon, 10 Aug 2026 12:33:36 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 10 Aug 2026 14:33:27 +0200
Subject: [PATCH net-next v7 02/14] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ax88179a-v7-2-da633191c129@birger-koblitz.de>
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

The 16-bit pause watermark register is little endian as
described in the ASIX 4.1.0 out-of-tree driver. Correct the
register byte sequence but also swap the configuration values
used in the code in order to keep the current behaviour.

The endianness is relevant for 16-bit writes to the register.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_178a.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 98f899ea2e9462f1ba99281a875385241745458b..945c071dfd1d2f0816c779e1a401ac158adc8d99 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -32,8 +32,8 @@
 #define AX_ACCESS_EEPROM			0x04
 #define AX_ACCESS_EFUS				0x05
 #define AX_RELOAD_EEPROM_EFUSE			0x06
-#define AX_PAUSE_WATERLVL_HIGH			0x54
-#define AX_PAUSE_WATERLVL_LOW			0x55
+#define AX_PAUSE_WATERLVL_LOW			0x54
+#define AX_PAUSE_WATERLVL_HIGH			0x55
 
 #define PHYSICAL_LINK_STATUS			0x02
 	#define	AX_USB_SS		0x04
@@ -1617,11 +1617,10 @@ static int ax88179_reset(struct usbnet *dev)
 	dev->rx_urb_size = 1024 * 20;
 
 	*tmp = 0x34;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
 
 	*tmp = 0x52;
-	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH,
-			  1, 1, tmp);
+	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
 
 	/* Enable checksum offload */
 	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |

-- 
2.47.3

