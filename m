Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A488513559;
	Fri,  4 Sep 2026 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542932; cv=none; b=V0PZIwQi8EcDHMCM9Mmzgt03xxjxgDyNh2WqpFKFp/QsZPsBuM6mXzXPBUWXK5KmCb3fixfPlL/3UcdveF7EMkynm2kqWkHFz1i7DFYka2z5IOdbaswSF22z5+Jtc1KFxHNx5CBHDg6jV7hlYQe5dxcduxs6NHysbT6Y9zHrFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542932; c=relaxed/simple;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lib76B26A9+AE0SnxSpQb/nAUqDjPrih8MAeqOMtImHrnOWe0XqiXi5sR82aSgyW22OLMYZ7XhXCw6PfpnGSMQZDqUKWVINhEvgxZ6WWmNS0g7jHz82TEzPneeAr6tS0eDOfGPm6lTlGzsSraZqvGuhzLvefkg4mJsU3SHLf2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=wOwyCmLi; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2UX5CCUH; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="wOwyCmLi";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2UX5CCUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542916;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=wOwyCmLi8Qbuwj5GWycloRQod1mjtHZRq4xYoX2RWgg+ZBkEOKASbCUtTh6QV74YN
	 s7s8XZl0TZwim1HmCPH7xFXPgYldCltxV+SHFLSkDqiTGZtCZNNdoANeQqR8rY7jSc
	 bDBLNgFRCyUD9ZuJMVUA5lkbEkHOT0HAc9/VnnCKTTfSE1dmfHZM+Hh5iHtU9ADfDT
	 2t51ccAXyeqBbnxRcDJ0br4g3L4pEcAz3F8dDw3jU2HjB36QP+NywJP3V5leUCarMg
	 4hGuMf4eEuRRMgIlyXp+JrqXDQZf4AJfWanXCNan0AgPlF9iXs1zejxSMcUOdS90gg
	 h0pU8IuDCZ2jw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 486AC3F105; Fri,  4 Sep 2026 17:28:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542914;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=2UX5CCUHD70pODEv3UMV8fNTf87DlSJA7UUo5B2qtKudoqIGJWTZ8IJ2bw7YO+MRM
	 x8pyHZmYvFS7TkUhutn8kKd9S684ODE2mvJ0XiRI56ti4Lx1OEPhMJojsue6y6O2Fe
	 8L6Xo9M6rYqC4lH9aK9+aU9DkH+blerlN0LXaq/DGrAtp4Palz20m4VLLDxAsGiKUv
	 pLQm2KtRDcFnIx2JLGW7eD5oj/8iJRzvhiOQZAYHrkQAsMDYGgcOeVw8JRI5Oq0fgx
	 1VeBPr1Q4z73I6DurshRm64tSShuqoOK7U0DkrUg3T0nh+WZ1pp0Q0WqFfAk+GkMpS
	 0L9oeTe2EcBBA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id DA0B53F0DD;
	Fri,  4 Sep 2026 17:28:33 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:28 +0200
Subject: [PATCH net-next v10 03/15] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-3-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
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

