Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596473B1EF2;
	Fri, 24 Jul 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878623; cv=none; b=LoB6bbt2R/Kg3dZW97BW4JXppHuP3p3YYgoiMnGSHgg5pKkermcgoXjH8vFePXbrllSaQ3GnXmwHnnOEkOusH07pzvgsfv4WMUVZuf2KUdP/h0ZNYbuyH6w6VL8VkK4o7OhkOSKmnZC9uQs5NM0VefLJ3gA2qui70u2KjEeAtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878623; c=relaxed/simple;
	bh=A4PRVdY551Fqg4eiE/V12aNQ1S3c71xr0cmz0PhIFh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wa+MZ5lQumNZUuQUKZ3qmIhRS7P+eQ5CKWnAh36IX0JqKdoW1m9HpUjDuflPzolZepgZtmo78sBo+a9mEiVCxDE33pFJDt48x7sm9r1LhQDuMRxTx2CTH/c74CsAF5S6IJrzVyzyJKD2yWb8TCyoMo1r8lfxrKTTmwwIkzPPKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qzStT0pF; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=rHot+6RZ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qzStT0pF";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="rHot+6RZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878618;
	bh=A4PRVdY551Fqg4eiE/V12aNQ1S3c71xr0cmz0PhIFh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qzStT0pFFzaZGnTmnEyY6VHcMMxdGM4lfMsgC338YR9XVr+N7vU60MHxFFUrNejmt
	 efu1Ndz13MPFHi6x7X+kvZWPs74le2Lvv0AWr3z3mxvYalvMgkD25iV2OZN/JaEHXA
	 SDEMmyuwQXYHSI/QYo/azcz16IV2RsEoytanXJsWr0z1SmGYGO2dTiiW41UZCcPO6q
	 McWY1YJJYC4Y8pKvMP1YI3UCLnIXXI4OZJWJj5K1mZDu9lhgZxF5ldX1PNA0mjdPgb
	 bCG1zQ/K/8PRnGb+719aMlSOlCbSL87DPKZRqeEATOJAXVrRb4Yr/Bu5BzO+G0V/VC
	 FNwN6brulPI7g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B4ABA493BB; Fri, 24 Jul 2026 07:36:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878608;
	bh=A4PRVdY551Fqg4eiE/V12aNQ1S3c71xr0cmz0PhIFh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rHot+6RZpixT82qp8IEvRbFh7QrDS8LPKp+OBwPBnI3t6Zah6u0hxMgLLowPlkXSq
	 8BDOzyiWNr+3BwsSOBByUKMB21r5QoOloZDsdp9uFcrf0PpoecfhCzn+7xH/qGLSoh
	 Lbl8LeFzfLARQtGec/j8XbjeEfq5qnMmrypGSiQKpBktLI2eHwdG81vKXaee4c6doZ
	 M7vO+mZpsssU8GG2YEk1TmU0n/7mpwTNfgW6PzIF91wkruMXV12o1P6hZ3CWK6CDcc
	 y+gl7F7FKDRwEVzVWYzwqcXTvvnbs1i7HgLjWvW9j8xt2eLSdUXcXtRLrF/jJvr+sb
	 2NUQMo8vtcoIw==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8D7EA48F41;
	Fri, 24 Jul 2026 07:36:48 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:50 +0200
Subject: [PATCH net-next v3 07/13] ax88179_178a: Obtain speed and duplex
 from Interrupt URB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-7-bdde4f905883@birger-koblitz.de>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
In-Reply-To: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

For newer AX179A/772D firmwares and the AX88279, the
interrupt URB response also contains information on the Ethernet
speed and duplex status. Read this in order to use it to configure
the link.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 8ea16d1231037832e12f74e2c5304ee4b7a54389..02c015847eea3dfbdfa73f3d59a7d5b0dd1bc339 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -496,6 +496,7 @@ static int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 
 static void ax88179_status(struct usbnet *dev, struct urb *urb)
 {
+	struct ax88179_data *data = dev->driver_priv;
 	struct ax88179_int_data *event;
 	u32 link;
 
@@ -506,6 +507,9 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
 	le32_to_cpus((void *)&event->intdata1);
 
 	link = (((__force u32)event->intdata1) & AX_INT_PPLS_LINK) >> 16;
+	data->speed = (((__force u32)event->intdata1) >> 8) & 0x7;
+	data->full_duplex = (((__force u32)event->intdata1) >> 12) & 0x1;
+	data->link = link;
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);

-- 
2.47.3

