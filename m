Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937838D3E6;
	Fri, 31 Jul 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514749; cv=none; b=Tc7E69IlCYw0nktbRJ3blwah9R7ABaU5GjYcOsqGk3jGsX1pt2D1TPTGAAOWdso8S7A7EiSb0XXI57ZrEYiFD827iMEdbiv3mL62KNUG6keYTLf0D8kRYLXoILYFRqKzhCP2pUNZSHo/eXoYdjekUtz+Wj6UxuGtmVTQ4AqzGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514749; c=relaxed/simple;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXGokVsmYDJ6VBaT3YxaLJ9hxzCDixVQu3mM2m8vQNPMW+/8ozs4OeCj8s/jp4zIS5ymIsMiaSBb0XgvhS3uAz6jJO1cFLU7T8usCCXZEO3zrkH0pHae+0plz6DtUE/i14TP71VU13qMDY5Lo3SSvcWt/X6EyqgfPIVdM8oxOzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=MIvF+C2f; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Bn5J/hov; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="MIvF+C2f";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Bn5J/hov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514744;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MIvF+C2fRfWCTJlFQGBsce5TrMFFCVcuuY97/oQtSZvSQy43rkaC6egY3oQe3DdNz
	 UUbwZ5EIFUKkoEuK/0gttRFHL21DssRmCYGezYimTC90JgJq5n2ySaJb5VMOvj6XwX
	 7trDjoy8Cr4vAVMR1X91bcBFJzL4klZp74oRCa0tBUqWY0phLqBODtOC5K+wfE7UWA
	 7+fQMqDYC9tbh16aonRJ81BlXdJQSblEPnmMZNQjiSGDB/tbIcgO7vCP4qkH//4V4U
	 0QHWEiNOeU4Hy5UQD9ndm07ILAjvUVpSCHuMurBefkwvWgispPo2+02dDe+G16V1lZ
	 T2G8j1z+0gFcQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3C27149500; Fri, 31 Jul 2026 16:19:04 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514742;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bn5J/hovEhn+U800/50zUtKBSLs6Tqt5nt6c7nuPpwP3ZkZNXBXIgTF6q36/yCSoI
	 MZ2VpB+KOfPN1ryoE76jJ2LTUC8NcbsRi7ARG20TXJa1Al9+Hy402O/IUjZlEalaW/
	 C5Jpf7DxdPnk554aeEFv4WCB/kyLmGamp1H5r6bdjdLi3Fz+Zixyt3xj8IxLZZbjo9
	 j/kn7Pqf7Z5VpmSxP472pU61YGVLtCtKE+FASDVUQbwa6F5JdauB/Jsn6q8gskejC5
	 W42zYgNy0swQoF8xxNgHox5Ge66zFYdKQ046DrZ4s8a+3S8LnK3XRRpZ3yFIXSoDNF
	 v2dlIDp00+GJA==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 81813494EF;
	Fri, 31 Jul 2026 16:19:02 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:01 +0200
Subject: [PATCH net-next v4 01/12] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-1-2cf1f71b1dd2@birger-koblitz.de>
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

