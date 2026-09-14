Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAC46DFE3;
	Mon, 14 Sep 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390009; cv=none; b=n1afDsAzVbXfhSfh8VbKOVAp3sv4sXoNDQNazsD0BvzQ6euGv8xFc0rk6ZlQNY9ZV9X0RtUPHVUEu+SQuNYCviGuB7K02IowuNs61vDPIIL8TMtqTO3AaSILIWARcmIECebjIcE9EVuwJ/kCp/mBrGzgjcqFblQSSGJ1JDdSme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390009; c=relaxed/simple;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzZAac47hQd58Bk8dEaYHYf0pFywqK0mgZckIpSdG4amFQecpFnI6jPVMZo2y/+GYKKrw2VNahUPautoFmt2AOwuihp11f/AGBJqTDtAp4bDxxV/N8C28cVngTsuacQMLXkcyidzWwfSjjhsWmQYLnTpHLlA0NOWlqAdIx0o2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=g3o/anhp; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=g3o/anhp; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="g3o/anhp";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="g3o/anhp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390005;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g3o/anhpVW7P5kjYyG6GXE0ki4ET+KyOl2YwfsPpvqWRFoHBmUEvUM9afxazgc/EJ
	 l6+ONali+tsVa/0Xid0kTt+FDwFx1r712mOZRLKq25lhLFDJEQh4IEhGa1CvAoEnR+
	 /pOqfXTMTjphHDMEaxAAsMS1hm6GcgC7A1/8+/MrNDN8hdhtKqXWXRgpOQhZxLo4nv
	 UpNrGC18dxOD86xJISD7Kek/3Y20quI6IliDmGRvTw+HBtVXpFlEp+rTJVUHItcZ1E
	 DUR9az6VXWYKoKFvJKvzmivOYIoV1a90THufH9NlaCd85JOmflZp3ISGGGriRhvNsv
	 DdEhSgaDMZiZQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E836A3F6E4; Mon, 14 Sep 2026 12:46:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390005;
	bh=UcT1TW4Sdw6h/EHK92PDO/srxgGudwpIfaE1pzE+OMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g3o/anhpVW7P5kjYyG6GXE0ki4ET+KyOl2YwfsPpvqWRFoHBmUEvUM9afxazgc/EJ
	 l6+ONali+tsVa/0Xid0kTt+FDwFx1r712mOZRLKq25lhLFDJEQh4IEhGa1CvAoEnR+
	 /pOqfXTMTjphHDMEaxAAsMS1hm6GcgC7A1/8+/MrNDN8hdhtKqXWXRgpOQhZxLo4nv
	 UpNrGC18dxOD86xJISD7Kek/3Y20quI6IliDmGRvTw+HBtVXpFlEp+rTJVUHItcZ1E
	 DUR9az6VXWYKoKFvJKvzmivOYIoV1a90THufH9NlaCd85JOmflZp3ISGGGriRhvNsv
	 DdEhSgaDMZiZQ==
Received: from DELLLaptop.net (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id BF6D93F6C2;
	Mon, 14 Sep 2026 12:46:40 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 14 Sep 2026 14:46:12 +0200
Subject: [PATCH net-next v11 03/15] ax88179_178a: Fix endianness of pause
 watermark register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ax88179a-v11-3-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
In-Reply-To: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
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

