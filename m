Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC54DB54C;
	Thu,  6 Aug 2026 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044980; cv=none; b=mhI5wYAfXFvNgyN5uqTlf5fmob5NECr+qnbeTl63CcJ4BEetwdh7pUHKQ3bYL2wj1OVKtVucwKnIK+N4Kkpx3/0yRhjwKTpRe+QhtwazWtPBhvtpsKP7Zki6mPA2IJuyLTxH6x30E2gR0IxuAO45+XzXFzTCqYFImOakEmHl84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044980; c=relaxed/simple;
	bh=S6hIEjFojee4djzWUf2H10pTeKH2mSL1uqZGyAiuJWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1Mf2B20ZxSjda/9QU5zqEBiQeI41QeD1E27DiqTJz8HPSAJfQUKNXTHv23eix0ZIMIjGJ1a27/QVe5h3uuE+BY7a6pZr22c04znm80e/8OmKchQhO8tpRCCUJe0Bt4BRyb0hZoB/NsdDkHJxwAoHnoAAOlpfvGB9JwDu0WRP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NFHLCKif; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=exGWYOBu; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NFHLCKif";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="exGWYOBu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044977;
	bh=S6hIEjFojee4djzWUf2H10pTeKH2mSL1uqZGyAiuJWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NFHLCKifzew/ECsT6iKA8yKWnvf6NrYViweXleW5OFJV3y4DkqioBE2m96Gmk3Gps
	 m4KmHKkQb49Ii+Y4/WxOi5+F9g5QRvuTBYlj2IWhtlW0Jwsl/SIJVbsOw75ng9j/Im
	 f0kdFVs1QVpuxxF/JhSUSP7kGBqLUcyLVAaaSq6XMiBdob7gJZotdeIDXA7du7i94x
	 1cCbvZP8GDMegK7TK4uaDBeJKDl1sZrOFToRbMzxXl6kLtkE2bMFdeR6ViOmbiqKCE
	 1T6iqXtoGV9a2gWpyNo/tfvzPnRHXNnwT2JS3Yx3Aryab/bQLJCwhcnKHKhMDB/m8W
	 im/s2ZSjWteTw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D48CB496F5; Thu,  6 Aug 2026 19:36:17 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044968;
	bh=S6hIEjFojee4djzWUf2H10pTeKH2mSL1uqZGyAiuJWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=exGWYOBudttgrYm++fA/BcPFC3RqJGVxfhSBnquxWmF7yeUsLyJrJGRYUZz+QJh56
	 LZW2E2riUl8/ZbrrzDUh78TTHxWydeQmqtruESmD90VXHv4bkb09nQXnFKiSTea0t1
	 w4/BCm8mBCMi0uMorxcSbsD66/YIwXJWPioCdVOAzgxAvPXgh/bGYKjkm2DfKv/vni
	 Wm2nrWv9ECyohZkNBq92ZC40ELlQoaukzrmpwfVZ5GfSHfrRdjbnyg1PHinzc7NV2L
	 /X9JM2jGDhSND8Dco/UkTPnKpv/wUerUILPVKlqrbvEJ8P3V1LFOH8uJrTZzdE2mxA
	 xnpYlmHEPNOoA==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D9F6D496F8;
	Thu,  6 Aug 2026 19:36:07 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 06 Aug 2026 21:36:03 +0200
Subject: [PATCH net-next v6 05/13] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ax88179a-v6-5-fde7414619e6@birger-koblitz.de>
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

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for this EEE enable/disable register and replace the EEE.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 3c6c0b1c863852c08416ebe8c8b85fd5cf40ad3a..04aaa9c91bbba2079b7369840b1ecb7b06df00bf 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -392,6 +392,8 @@ static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
 	.mac_config = ax88179a_mac_config,
 	.mac_link_down = ax88179a_mac_link_down,
 	.mac_link_up = ax88179a_mac_link_up,
+	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
 };
 
 static int ax88179a_phylink_setup(struct usbnet *dev)

-- 
2.47.3

