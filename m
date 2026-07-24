Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C03A6B6A;
	Fri, 24 Jul 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878611; cv=none; b=HIMPn1W+t9ABhWXcNKM4JP9wid/MzNeE5DfOCIO3fPr+ADG++tak3clWTd95wcO1svaSqt+xtWyZJLuKl2RvIShQdyb/1+IK8LA3hOSKagWArZ9jqvMQZgAjTYyzOvzUOCfeUYU3GUYir2nEjnBLv/lGpr7EV366KP2P0/NeGmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878611; c=relaxed/simple;
	bh=jPEvzusVPEfUiuA40O/vV9QA3GcIbRMF7toahqxAlc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhWVJieJHbPMke6FTej/Ap1v2k7d6SWOIIlt0mQ19FjWgF5k667cIiUE8SgG0Bn3QzY5ELmyfiGiXFk2lk8pEWL9zJyoN11KFt01tfTljkpUR7gG3I6lg2eYLfviLKiEulX9G6DF8GoJyU7bSsOcoWqd5pYsuPaZDXMrESZozi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Nrp1LE3p; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qwSb/1He; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Nrp1LE3p";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qwSb/1He"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878608;
	bh=jPEvzusVPEfUiuA40O/vV9QA3GcIbRMF7toahqxAlc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nrp1LE3pN75MyMxxOtLKCj2Pp3unN9g39dFzq3c5ex9sSIOwXVeMqgTpCmEQMUC8j
	 GdvfB/BMUVnYoG7k7cUIr3kRQPfBEakfTDWywCwvQT3yVTEcHY3XH3cWCz3TNzuTlD
	 3kTPncgjSUQX2INNPkL29i5xE09Wf1cm5gpZltwEFYxqeICM7pQr81+O5ahrpVp7ZI
	 p7z/EhYdZEroFNkYKvE/phqcfNhS728BLW5iJAX/0De1tr1OPOQc5fGdsG3Uz+aZEE
	 rHG7yWyFjf1g7Csdmbwerx+5fKWgu+nFOYglRExH9Ou1kFwy/jVOK9iAgUy50u2K9x
	 uSgbJrl2Czh+Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7D6CE493BB; Fri, 24 Jul 2026 07:36:48 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878607;
	bh=jPEvzusVPEfUiuA40O/vV9QA3GcIbRMF7toahqxAlc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qwSb/1Heu8g1J4XFsvsBuZdZHkdYtNMu4FIb7bCabpRmh+SRNx5O2eZ0fjxnouBI9
	 rAOjfmNJnIk+eG06/He/IPADA5krVSN8Rp8qUSDAQGiW2UANWICXd0btEhz/fgVNFw
	 DfZ8EP0JvLV3P7NOSuOihf2j2Rmwm3D24fry79PjtkY9og0sYczyIanYVX5Gu8CIUT
	 61ETcTEH18mBXc8QyK8FkYeH9tJUTobGKoRXXNoBj37gdVh3IUOpdphYuyPoKILrZe
	 FBr8MR2NmSv5M10gqZrS9aQ8S9s5oHPJZhT0NmE6KknQhvulD94rm4iCtgNOKL2Qy0
	 BPmFLz7OrYE/Q==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C6E4C48F41;
	Fri, 24 Jul 2026 07:36:46 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:44 +0200
Subject: [PATCH net-next v3 01/13] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-1-bdde4f905883@birger-koblitz.de>
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

The 16-bit pause watermark register is little endian as
described in the ASIX 4.1.0 out-of-tree driver. Correct the
register byte sequence but also swap the configuration values
used in the code in order to keep the current behaviour.

The endianness is relevant for 16-bit writes to the register.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
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

