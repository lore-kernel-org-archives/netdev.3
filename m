Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9833392820;
	Wed,  1 Jul 2026 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885125; cv=none; b=SAITTmLRyDHMbasOIivfmXuGOhlCrzjrHaX4nYfN+mk4zVl3+UGWLXeGeP40boJ82Yqc9prDACoTp57kAAywlm/l7sx+vr1bMNjxmt+MFrz4TY+6lU/2HOcennHG6/NcIRRPMj8rwMivCsSMcj52RWhavzLQkfSMJLnDM30aiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885125; c=relaxed/simple;
	bh=jPEvzusVPEfUiuA40O/vV9QA3GcIbRMF7toahqxAlc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmKIiuctyaMWILTd0p44tUru2PKHCkqjb3huVqir7VgdFtRc3NfI64K0iV645uGnCSGVe6Sa8Xb52DVpS6Ho1ApeJjM1GT73J+bk9ZtcTEHI+HTZDoCpFC5MPUtOirBujwbM/QwgzzW0AORDI2VkPZ4m+c/NIP/CdocNlwU0mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DxE5YOM7; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2ArNgFJF; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DxE5YOM7";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2ArNgFJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884571;
	bh=jPEvzusVPEfUiuA40O/vV9QA3GcIbRMF7toahqxAlc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DxE5YOM7fIZ5LFmjk8mWCDnKtXKWvHAhKu/c9PyMMoCb2nGf4u3KfNCIH4KZ76GH2
	 IhfnwcPaxxR2p6cSs5M/f3SMKnCmb+9X/MWt654zeGprYG88GmSOGP74RokVnGO7iQ
	 /SQYubS5iQ07vkeF0+C0hqIE+qFYgWATZphQQ/CoL3WpVcPQudgYaL5SlaLb5U4sMJ
	 tdSxFiEma8vxd6E35WWEdG6ksMjxseXN6+DIytoJ2r5hMSPWQ0LKYvA1XgclWUH1g0
	 VTib5MO+2hCQugZ+QhDKccsHGnFtjND3maUpDnOTkvM7optGUgrbckO0ZesmHexJd5
	 ciKjjU/dKrArQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id B49B34935C; Wed,  1 Jul 2026 05:42:51 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884570;
	bh=jPEvzusVPEfUiuA40O/vV9QA3GcIbRMF7toahqxAlc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=2ArNgFJFUapwC78rdF8SZJEd3268YX58x1Dc1AU7wkCl9vtvHE61t5LF11kt3jAZN
	 8XdUPgLOwO2TG+Kik/qhtDuI5bGGZjl4FsxDwAFZ2FHNFKpvvrQezsxOJwozux7fgM
	 2yM+FnqLA4Nke74aQRj0E671cl1Qy1XHlUSOMOlkxhmD6OiUYQNx5YiEPa+hLMkxU1
	 wPv0FNlSoys7kY4pV3+jJMIBIp5JsTaFGwSfbF7Dw1R2octrCG15Oze3hPjFG/MNyg
	 Y/700YBO8s+L6iWHsEaDb61qx1qv0cov/2TLh0hUKP591X0dlgIFCWzQuXiQ0oUb4A
	 h36D5V8wNk8sg==
Received: from DebianDesktop.lan (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9701349337;
	Wed,  1 Jul 2026 05:42:50 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 01 Jul 2026 07:42:47 +0200
Subject: [PATCH 1/9] ax88179_178a: Fix endianness of pause watermark
 register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ax88179a-v1-1-13685df67515@birger-koblitz.de>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
In-Reply-To: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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

