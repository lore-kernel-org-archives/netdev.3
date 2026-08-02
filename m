Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE083B9DA2;
	Sun,  2 Aug 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688356; cv=none; b=Gq8Yabe+W5SCQOIPLPn4g93NDH6B0+yqqdO99I8VoqqgHfgsHMy+0kqDaRhMe3VY9z9DCFnTBZ//HaD9aYr6GSsonLeHN96PYLvOV/4Wi9oGuJDmVxFWYYtUo7AgXZg+QlJrdNuqSALNmYMbpC+PI/hwlGuwiGoDmPwC5wiCbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688356; c=relaxed/simple;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVjvDt/aAb38DEtiKHnux+RN18Sl+23mKcckcrebFSshcvnuurdR4yse0RbfCfkxBthSEWOJ5xONDXk3eyI2HSJXHVWmt466pK7+sB5TK9iEsWtmsJIeCWY0MA0OCy6vrxhL/Nos6aygPihwwxCwPbrVOmyllk2WHAq0eIZ72Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kgO2DNt9; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Fw+ehoN0; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kgO2DNt9";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Fw+ehoN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688353;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kgO2DNt9oJrPduZm8+Iq4ut2Yj2FswcF9kx2DPkeuM/1dz8LplT5J/FyOpFxfRyR4
	 ZldK9/fZFAnBi9j7NPJAJlkYbVrCdQ/+cs9UYUkQ+UNdSbzjmQsQVwA43S4X2SXs6V
	 h6n5k7s5eSTj51ngWVkHbSDo91jYpBLN85pFkgVGEgG8roqaaf0iuUrbY8ogWf3Rql
	 hSlF44FZPGUS+TicCvolsN0JW1kyjdcWpZ/dO7C+j09046WrdWLWw/3L7WwGdybdve
	 CXFcsn3BwJ5wsphzoNBU5Fk2ggaHQpQzAtaEwliAhhkllY/zjC5wPfr2Iupi46CxmT
	 hArreUzVlRDQQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1C70B49658; Sun,  2 Aug 2026 16:32:33 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688351;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fw+ehoN0jrFRn/ZtY5NZ8nxFCCAUEmRrRCZkpaaSHMAc0c6lKxdjSvdwtOvrXTauf
	 27ZbtG5AIg3Zy9XoaXXY4YBNGGB3L5bEK77lA4O2hNO4cYyI8FbsfBHW9FXIU94r5v
	 O2qWTg0Lvj7ATv4vdiFfxJcJBFzOqhOimg3tu+UvmcVhXsmftVZ2wK3w0DuF3UfCzT
	 Y08+qAcUfaxvNv7cdHXdC3b5do67PLF9WNeH4mguIMCZeQMpjOoALehPX73fPj7Ja8
	 NUwfbko/upw3+8m3Ef2xfg1osZ7UPk2G80VKc8Yywp/CThOQ9mfa72dDdsKiRUUUBk
	 YTnailLmf4oHw==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 630CB49643;
	Sun,  2 Aug 2026 16:32:31 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:31:59 +0200
Subject: [PATCH net-next v5 01/13] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-1-dcb9fea4acd4@birger-koblitz.de>
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

