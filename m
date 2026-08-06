Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC504CA27C;
	Thu,  6 Aug 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044972; cv=none; b=MVIeb+oatWNBLfdtk4FAJluUmB8qL67eyMehgFQtaop6ewewatAKgI25smyOJgqavr72YxnvaSRI7o9xWksy4gCIEhYPh9Ra5dqZcwO5UNTUF9dT0WDW//nblJYxvU5ngXK6eQMmIAbzJJMKMBxla49KDxlQAP+L3gpxjEMscvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044972; c=relaxed/simple;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qd8OMwrIZUzCNEKTIy15Hpjb69Ed4AKrSx9x/jsfnAKqwvCG+V6EohIrR/pRzqVghhslQijl2qyNRBWiqD7uguraRu7oOp4HWMKQ281UCv25GAZyGjLU/6+J6bSwc/x8Y9LOtO9dwUtmFhbtgWmhHkB5gUHlNONYoKSnVXGv/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0Gw9g8JN; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=IO2uGRMr; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0Gw9g8JN";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="IO2uGRMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044969;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0Gw9g8JNjKJwP3PKajjFE2RB8AW2P3SBNETeR49SVdgSyxZzLWGUzswwPTIjtSLTO
	 DOCUkLB3386mj2/emB6Dsff2HJYBz+Ry3+IPfXCtzfN6oPQALng5Yz9pEpVOctKPUx
	 mn+TRNts5q9XJ6dD6+Hskc7WqORLiTCB+5CPEoMkfHIkUNzKsyirIrH/xfa1xT5HB9
	 NPC5w5wfyt0a13AOUEotUaJxWnCAZoC29eMS1axHnoE/DOri+FXmje+9E9d7c92bs+
	 HUhjP1g08Crvl6yRXv4ImagKXczAEh0S4jlfTTmGxhdwBAKzkqNXqMYT/T4VRPlDuk
	 NmFm2vnHZpkaw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 54C5C49706; Thu,  6 Aug 2026 19:36:09 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044966;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IO2uGRMrHL1FmFTJFcQQVmxVT7CCmBmi0bg/Hq9ydAFLbbttvnK4FpqRfcIzYopZu
	 5viz3d+jD87RL4Axx//oIy/B4BUS1XCCCDfQ2naD2yrqwClo0pvkdGn/5GoATccn6J
	 RyGIVJeil+5lJFxpGMvVvuAFAki9QawPxSm66gEaAWcD/uURZvMz30DM/LnsogvlFS
	 hYH6ZkoZKU+qbo2Z+FZaK+TiVnO3iWidYj/V1j3myvjuEVg3Yp4D/z1QmGjDe1cVHz
	 FsSqZF1nQ58nPj6F+KH6QrYnQcjeeJN0DKCANXPJEj0iYJ61vebM+yfJapwtUm3QD/
	 URGSzTjyaFv9A==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E9BD7496F4;
	Thu,  6 Aug 2026 19:36:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 06 Aug 2026 21:35:59 +0200
Subject: [PATCH net-next v6 01/13] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ax88179a-v6-1-fde7414619e6@birger-koblitz.de>
References: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
In-Reply-To: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
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

