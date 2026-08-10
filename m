Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C043DEFE2;
	Mon, 10 Aug 2026 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365243; cv=none; b=lJg1FV3z/wHvOv89sM3xaonNwQ9YAG0LBjZz5UvCduyg4WGbBik291AcU1Woj8nBYePWdeKteeETKUXfRqwFQgrBBuDmhpc1vusaQOBIA57sEYbTe2iNA9hhC1pXMw1CeMfCStsLS+hvpwJ1IKhPVHz8HZB2WaqoesR11SG4uKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365243; c=relaxed/simple;
	bh=tnGUDgq8nx+A3IPGTIr/8nyJZfxJd9RuYCv2VfVkzj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdqi1xv+merPx9KSpN3eaAdNCPYAOMAIfiBLIsrtDytYNFsliR2lpqMHz2fl6FELrb9OGPu/2fo88nDadytk9BMAOKwNvVBX7AgLnSimwFBfsqLdiyAfJ08FXyTjItww1q/Z9y2gcU7IZxeQhgGsobC8ZUqXqYJDOWsP9NIiZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=z5PtXYyw; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=b6BoaR45; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="z5PtXYyw";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="b6BoaR45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365240;
	bh=tnGUDgq8nx+A3IPGTIr/8nyJZfxJd9RuYCv2VfVkzj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=z5PtXYywIk1lplk0XHYNsn/8Crfax92SnmRIdALOEgBmjCoMm06wM1a1vv3TD2yQl
	 IByqZqEnmE3pjSP71EIieOOlffKSIE694bpnm+I0E5sJ+HZrJjxV+NF9d8uwJUMxdA
	 10NgR+O4RaH8ahZe4aPSy2CRDfzSvBwczM2RG4WM36mLfzdZh0K9M/Gdu+kgJBLBRb
	 MyxnRYd22yNCrRouuYh9IvQbJFZfRWCMbUZyR1Rmr0+dK/cH7TjOApWBlKs7wpGWxX
	 qa+NR4FSoJ1a9wMei3/0xNlXI/2ZFoFDpyhTNaIYC4oNcpN36uVWY11bp7ebVYgqxZ
	 1RI1etyQWZ0SQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A36F349786; Mon, 10 Aug 2026 12:34:00 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365218;
	bh=tnGUDgq8nx+A3IPGTIr/8nyJZfxJd9RuYCv2VfVkzj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b6BoaR45blCJkzDd72elr1/PKVIP8V1rdfASBNKnA9t+hU+tjkK5Nd5rjY91j15eF
	 pv7pYnGJ1RZ5YGb//ccKm2divuW+49GfSzmsL1/PNTch8cd5ccCJQPdTlNLdvKdE/0
	 1ScqutbGURGQO30efDbAUBYR2v1SduDj1W9XFZztlnnM8zqXnwi8+ipwolm7euOxsJ
	 thWT+DqZj84016btJ5pu+HIxyZYQCvEVqMdAhK6StuJi6o/HSbGnzgcKmvj0/Kvt5V
	 ao44SekRXpNxtU4qIkHaFW5ZylQ05Jk91dsNvLmoBZIApN0Ztn8IwAdTKpv2+tEd2S
	 LXTPY9Wy/JinA==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B620D49773;
	Mon, 10 Aug 2026 12:33:37 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 10 Aug 2026 14:33:31 +0200
Subject: [PATCH net-next v7 06/14] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ax88179a-v7-6-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
In-Reply-To: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
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
index 2971e883e384535725bf0a09971befebdacf9ca3..cf2dc989f230ee47f4bf0b4f42ab02a511abc19d 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -413,6 +413,8 @@ static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
 	.mac_config = ax88179a_mac_config,
 	.mac_link_down = ax88179a_mac_link_down,
 	.mac_link_up = ax88179a_mac_link_up,
+	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
 };
 
 static int ax88179a_phylink_setup(struct usbnet *dev)

-- 
2.47.3

