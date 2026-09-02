Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0314AA017;
	Wed,  2 Sep 2026 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368256; cv=none; b=DmS+JTBIl8honi5cbINARMUjJTrSsFEMBXOleo0TtiWlCMu/Mo23iizA8dru+J/XcxQAgIKmCQh+y9Z1/nEP8w92CzyYaaWCgFfDfXYcDh/t/EEC5SkypQaK6KUPR2ivwCLgO3J89Aq+AE016+NvytQSjZ9x5vNvx6nKRXGNeys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368256; c=relaxed/simple;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uL1GmHS0Krghr9eLUcjlBxsx0wVJQ14sr/l5sFSL2QcQo4pP3tRzxCCNfYpV/egUhtavYn+xgCO9GJjknxgOnUEDgo8SwZH6+oPzV9/4/GF3Y1bkFeBWpyxRDX73HSRPAeEUdCTvdQU+Q5vS1Kq1V4rbTHP07Vcbb2gHCvzBgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RaUZ7Req; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=j9ekPeZY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="RaUZ7Req";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="j9ekPeZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368246;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RaUZ7ReqvpAVdxKiAIR09sPzT9P0hONKXOerjOcFB79T15IjBHMELh8wvWKv6PPQu
	 SfmkRT9DdnuoxPNJFOpqRVrNTtfrksIeoimyK9Xp2+5YFKTjtnsrHKa3JW9KuxLiIw
	 gt/ZrKKwHrblbh4O7bZyadkaCwVhCz8obtBxLLzdv+Wjg3Yyl6Pmg31kavpeOu6Pjm
	 KWf/UFaqyKA/wDkZNEt5SEBMvFqNdZvr+UxOK3NiFaJ0g3uTtsZk3cF5ElQmdvL1jE
	 skcGqbBneWgZMRmZHf3eeHgYLmiz45W22rgo7A9zgD2H4MPeGJW5OPKJPaRwAtX0Ch
	 FqwSXm0P6WebA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A9BAB3EF3B; Wed,  2 Sep 2026 16:57:26 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368244;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j9ekPeZY19HnilxAxTCKOX4BQ9LqjbvFGBVQfw/HXyaFmEIO5T4YQYgY+onpi8bD8
	 9dwF8r5/TmXKYR+YDek5ejJdtGlHpR054C/lNvpAuGTBvD5D/cjPTchj1xAwocYPTY
	 FhivqRJ4I+fKvBikbXgbT36ccKAkycC6e1wi9JunGUQXQY45P83v2Y52xKN1eExH32
	 rlgUHcTHDBSPBf2juKeDM0FLcnhmE2xX0As8f5zaimp8vxmPa8sHt8cVqnTOjwWWhU
	 bYyUKIxMv7RH9jxIrPnqCCNj4vWJpdvBqpcluSakzp3WcdAFcfFyBbiBwKE9T1ms7Q
	 yZPP2e6qHlliA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 07AB73EF08;
	Wed,  2 Sep 2026 16:57:24 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:17 +0200
Subject: [PATCH net-next v9 03/15] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-3-8e6d7710a2ae@birger-koblitz.de>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
In-Reply-To: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
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
index 81d8412ce8e2fac981df076ea1385e6e87525cfe..2ed46ab62c0065d32040439f31d44f118d7e9952 100644
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
@@ -1619,11 +1619,10 @@ static int ax88179_reset(struct usbnet *dev)
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

