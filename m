Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85322FDE6;
	Wed, 16 Sep 2026 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529072; cv=none; b=pdqoBjCu19KOtRoinWPD17fBBhUlNsTp9csKtmSUgetgWUJ7ummPWMJAAA2up7rUES9x4eWPtPy+UAoQviZA3STKGfhQ7Qi3ANQegMbysMb5l1f4ktTPO5MffeDNvSio7sgHg2YBP7Lu+573A2oWz69DtLYViyQvw3kOndfQfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529072; c=relaxed/simple;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oaeq1pZoO+u+ApiQ4NrOmIY/uAa2iFjbqzkuaeG8foPU7YDnL+6wltg3/vdlJB158wpIplGQ24KXLyi8hlUVHhxp9ucrn9TXdd2ByJdHrC/yxTgujM75gTC5n8SO22Q5ia0GHmIh22o9siB47QgjRJKq+OHk//y3B3Rrje2M9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=d9hGxStL; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=T/8f0C+F; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="d9hGxStL";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="T/8f0C+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529067;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d9hGxStLOX/tgzu3stA80+Y6M7OYSRMRT7ZzzFctaXF2NV6Avery05OHqykF2Da+a
	 ZP0hT8t6ftO36gDu35nMeFm3Z/VnHtU1Cgdg6rqm7wBoHOGwng3tMm4YSH4+Q9dmSl
	 0IerrqNv3TJ34o8MnIG5Qqs8stX4xaeGixkK3ofKiI2SbjfgdwHI7YgV0JgcmCFjkE
	 xVnc5ckTkswxpk/wVHDNkbPPfMBIeUn+hmzN64DY5xdY20GIAPI7cO9E6P+zCVRqKA
	 5wk8bQQZmfPVi4PfaioYtMg/OKTkkJphbVrnal2yBALlbmLUOHyE0llzYpZIQPK3eS
	 vA+bAb0LUHBDg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 36B013FA6F; Wed, 16 Sep 2026 03:24:27 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529066;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T/8f0C+FP9a3eZ6DMj5QxDRNyoFm2Himtx+wr7CDNrbq57SXToudsZGdGpsvJyQch
	 /x7sPtrb69UV+oz+P3shL4b2e3OVmYIIF+IlcdhzYWSDj4pYmxNzMA3n1CGSUVNhax
	 /Rxjvdu20LFn8hO9pqjNVlFFItH50loBVZL76EFJzg94p7j2Uq3WgkVQWX5FR50/6y
	 BB+Z4ZJmSnUuRWASihKMTPat9ds3ECj1DvwDGZlUhxSEpClRlsH+BbsKmr0gK4dJmz
	 a18AeSHxvsUcCm9b1JJXST7oKUVHzf12oiLMV0+kTxlgdu7lm1YBdqgC3R7mftf3RD
	 eiGJviKW3nNug==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8197A3FA75;
	Wed, 16 Sep 2026 03:24:21 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:02 +0200
Subject: [PATCH net-next v12 03/15] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-3-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
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

