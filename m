Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9443955D7;
	Wed,  1 Jul 2026 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884584; cv=none; b=SFs3s7IDogGb6Yi3yt6uE3j12khcD2HLcK1gy520J0EWqfwrC3hO0slSxL6AsVxVyXv/PaAy3AS+GrslM9jdQWP0CBdKiubIJulzhA8FvYEZxnNhLB9ZAM7Q8JFTc2cdhQEZ9mJeL4AxNR9GZJ4lyQISopGJy922zyYNeVqBlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884584; c=relaxed/simple;
	bh=yY6IzHpDshTg+lJWDYvbJkxSb5igAgu/Fl2zjoGiqb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zfb10Bg8oTdlKeUFPH5y0x3LeevOD52VsrSxQ14zDJ9VUYTWydJrQ9pzr3iN56Z1z+/7kzUu4/Jo8rWW9ttX5ApIIxZyqgAL63rVErhz9iZwnDeAmRVHv0yBhs+rGNdCuw1oUAGWK7TEzWdOicMpbcl4JWSADR4ogqXPvkYlWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=26XXchp8; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Mltd+pm0; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="26XXchp8";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Mltd+pm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884578;
	bh=yY6IzHpDshTg+lJWDYvbJkxSb5igAgu/Fl2zjoGiqb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=26XXchp8GuAOrMQ6O9k74cXe1XgoHjD2oFaWUbQShRtLHNL4dE9x1AAvztVzpr9w4
	 omqz1Anre38QeUMhm9vMlEPEfZ/NUozjTbymqWdeNxGvxSHqWaYSHIF8153ZKIkx7L
	 2KCn6NaBTYXW5CzI+FyYyiEZeTdZc0JfBmce3HQWiNBBsG73uvNdxYWOaWYMMx4TOA
	 xhBu681QFwWrwnUIgI44LLj003NCcx2g7r3SD6RHL0Xf1uSOhCSa5oeCbt2BrOksOK
	 ZSOgzPywQZ3K+Ae3IBaNRopXSJ2Tg0IUpjt4PtUXnyQvBpv/niRIlfDaIKQfs9lfd1
	 6BJlszW8mlbCA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 0CC0349343; Wed,  1 Jul 2026 05:42:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884572;
	bh=yY6IzHpDshTg+lJWDYvbJkxSb5igAgu/Fl2zjoGiqb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mltd+pm0WKXxsh+TwaCUO7jImZp2gzDdkxlPNcLO8vVgir0dWCvoo4oG28DXiY1Tm
	 1CWdvg0nmh5uYkY0cSMkQ/hiu8aaEm1G5xV0JGTjmlOGdD8ouciLvipAIxUo0uCW6w
	 VvoyhzwxQwqwE1isR/D2zOQ5QL5ko75KnGA0x3X3MyZyX4uAXWsv6Rz51AHNFRcOXq
	 uIsNjOP07AEZj9C9EqMmLONYr7gA3/PjoUNJ68+XPKRgV2bWSQHe/t3KkSfzc5Nc5o
	 3r56YL9UA6Kl8TfNgIwEU/P4hUL+dd1Gu+K4fZrwb0LPqhjJunQZwUa1olqesCqEPA
	 9eBqls00qaCew==
Received: from DebianDesktop.lan (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 67E2949354;
	Wed,  1 Jul 2026 05:42:52 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 01 Jul 2026 07:42:55 +0200
Subject: [PATCH 9/9] ax88179_178a: Add AX179A/AX279 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ax88179a-v1-9-13685df67515@birger-koblitz.de>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
In-Reply-To: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

Add support for conditionally setting the ip_alignement flag
AX_RX_CTL_IPE in AX_RX_CTL and make sure that AX_RX_CTL_DROPCRCERR
is also set to be consistent with the initial configuration in
ax88179_reset()

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 001faa66efb29df1e09fa3fdc7aa582ab254baca..12fc20e5f76e6906c5d61f5b0d15b9fcb5b60210 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1329,10 +1329,14 @@ static int ax179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
 static void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = dev->driver_priv;
 	u8 *m_filter = ((u8 *)dev->data);
+	struct ax88179_data *data;
+
+	data = dev->driver_priv;
 
-	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
+	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
+	if (data->ip_align)
+		data->rxctl |= AX_RX_CTL_IPE;
 
 	if (net->flags & IFF_PROMISC) {
 		data->rxctl |= AX_RX_CTL_PRO;

-- 
2.47.3

