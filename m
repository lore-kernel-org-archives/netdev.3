Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B124399FF;
	Fri, 31 Jul 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514766; cv=none; b=ple/dgmif9hH8wC4otwP4RV52XFtxsPZfite5F9F74xNzf+OQuITns9yKe6B7gjDAwpmVjWWWlF67pLJcYoE8ySMXQ82yAmtO+yE3MBHaYaBYu78yc6EavIBSWmQCXcByMeU9BFsP6ynUjkKGpyUMRBZ/QdlqoFQDUFkJx74H4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514766; c=relaxed/simple;
	bh=Oi9RhVEd7oh+kuv7wpfpRFTncoQAfHR9lCdelPhXBhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egvDh2T53GZrANxjaRHCFa8cK3iVrOa4irbBYX+dqRNWmOEZLud09gJv3/caymOLyc8zETDRmzYIs6rIq+dubr8Z8RpkydBLvOoqBVfLtKVWx9+Q3/xhR+j7bX512xWgurnh/etMA50n/662eCHtURtUpcix+qen4OI+VqOzfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qKxXpECg; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RYehB5g3; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qKxXpECg";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="RYehB5g3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514753;
	bh=Oi9RhVEd7oh+kuv7wpfpRFTncoQAfHR9lCdelPhXBhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qKxXpECgvckqpqGG854OYvFMlu5SWK1GYpyUXCix+Lyd+OPok0UOF46gCG6z+qeFB
	 guhJFaYmVWQRxDTvinKk/kZ9AgLd1tMSfeNRq7IWotULNovncuxnolZU9hmelio4pq
	 mfPTIEkc05VDttSobZajEtlAf7OROMSMFk0IkSu2Y51Tm8PtnXIEDPAyjElC5VyNWP
	 WvtjDMcBPG163jsc9lCxqxn0tVIedM0kWopYhD8vB3k5TAe5rFEKFitjgr73yQzbfP
	 IxLdk2z2DeMFbSzgRIrjTIZgviYGNcoV1YFQ/D9lV6tzxRVA2rxuohvX82aB/41fge
	 N1JdccyRoipUg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A1B4E494F2; Fri, 31 Jul 2026 16:19:13 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514744;
	bh=Oi9RhVEd7oh+kuv7wpfpRFTncoQAfHR9lCdelPhXBhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RYehB5g3pJa3Sy9nQCkm0ErxDfc07cG2qS2LlbUhXGTW3hML0fcrQwkw2wHJfQJls
	 4KjV32T2DWexV7jr3ZbNIK1VucieK9rsB/RVQidOvWRJWTafsvJI0RTOFflIFPEZGh
	 UxXzO7Z60fYdi/t3RD991f4WTcyydD/jiePrO2/ITNV+96JkGk84Oy+BXF7K0TLDqF
	 Dcdh67Vx0oOquiAYzNzqoqGY57nIC+Tx8j9xEhOy2vPLgxqBrqjmVNzb0V3f4ItwSN
	 jnzdYPAW5R2eoxMeHl6w6lR03tfLRk5Qr+AwBJ3hXGd8EZl5UuUL4kh3pGhbZeA8WV
	 G8Goev9rG90Cw==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C93F0494F6;
	Fri, 31 Jul 2026 16:19:03 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:04 +0200
Subject: [PATCH net-next v4 04/12] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-4-2cf1f71b1dd2@birger-koblitz.de>
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

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for this EEE enable/disable register and replace the EEE.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179a_devices.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 364982e0924b1ddab9c35d49774608f6476349bb..835d1c369b533929e92175f8223c728ffcc8d168 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -420,6 +420,8 @@ static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
 	.mac_config = ax88179a_mac_config,
 	.mac_link_down = ax88179a_mac_link_down,
 	.mac_link_up = ax88179a_mac_link_up,
+	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
 };
 
 static int ax88179a_phylink_setup(struct usbnet *dev)

-- 
2.47.3

