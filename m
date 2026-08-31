Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE93F12D0;
	Mon, 31 Aug 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170891; cv=none; b=ieYZnR8taGtE+1Ogb1RUg1D43xcf/frAg+jt9Zf2YxfFlE3B2ldw3mWjGt0xfU2lmfMe1BXL/hYRSJxy3lb3aiuQZrkybR0yVGaqPWk7YfsqAmzbHHyZoPV9vddUhS/ykKUO3/znG8VN/YsinlmBXs2keQbbe8CqOTkJIxhHu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170891; c=relaxed/simple;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MciMVOBz74/HD0c/IUNvxNIygziqeSxOBUPthc2R8iZLztk7y0gjFeMwWqJcilYPZ6bdpiKtnLWsTJft8Clt0ebHn5Cz3WFCXw/aYmncEFSFa4Rx/MEn5OL1aFgZOll9QajO/DAiepe9GUrv1DEqTWLyRH5wQJ9hjvS1ahJPCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=aECcNOOn; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Hw9WeGEY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="aECcNOOn";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Hw9WeGEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170340;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aECcNOOnP29w0bCN8ziLcdGVSEJB8zgid0TSe8gRSzrUD81eH6JcJgVce1tAC9hXV
	 CDVcn06M8kz+3fT4V/cmepLWQkP2dlhwz6KGfsXhMlEHCk7KQMdHbgByXKxgksp5Fw
	 q11R61ShbcTtPukrpdQcbnFbRdYNwWEXzRSTsF9vGfCjIYJ4Urhpfm0CeZc+q3yjo/
	 iT98eWlknICIuZnhZHeVwmsGhitifFdKECjqeJxZn25DQQ0nkHhVWYys04pSYpGeHw
	 H0gjaDU0MnOigm2JjiCF2ZjexHsZOZ8qYrEzWvBVI9QAaNmdrHsH+tZ05CpcROjssF
	 ftXJoF4WOLmQQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 31B463EC9D; Mon, 31 Aug 2026 09:59:00 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170337;
	bh=Xt+4mBtUkIrJ36ZCTKcJkucyLloqg9n7ap1XhHTfnJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hw9WeGEYp+igaJhO5Qa/c7uSVv5tuAbnKbufQxQofd6VEw3HpnbeU7hNLQz9t5GoU
	 RbafKzRFrOEgidV80YTE5KgeIZcYC7zxinFOUtTvoHNYh6ElkHuD7aGzP6m9uz7f+I
	 7CAx2HWy6LACosG/SAqulsfMl7t2sx7un19WXGEuWytpgR4VKzh0QWrAl3XLXYN/MS
	 AIXwq4EV50rIMS88Y97z2S+Z8lZELfDs5HvqszuMdOTv1R3w9mvOAZfLuhwi9me+vG
	 bjafojGZ6dddO3KalqQ0fGyfZs+8pphLAneyKil5thRsBPk1Ugd4gd5p7WA97uePjI
	 hwpJ2i0MqqLBA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8DCFE3EC56;
	Mon, 31 Aug 2026 09:58:57 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:58:52 +0200
Subject: [PATCH net-next v8 03/15] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-3-de905f2ee426@birger-koblitz.de>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
In-Reply-To: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
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

