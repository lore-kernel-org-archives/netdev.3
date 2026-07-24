Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D13B4EB3;
	Fri, 24 Jul 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878625; cv=none; b=U/WNasM67xPrjsh6m+itZKMxxdMquQJQK0oSw/TA6SDziTQNbC4Z9a4be3sS3QGKGxQQcGKTp3ARyrhZtWQ60Dcr7GynbVSec8YHcPkN4sl3bfV/+MLhOZwDD1jutaG9THFKwmAf+xjN+OzEQETQMNT5k1SOWXBj4S2xp9F56UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878625; c=relaxed/simple;
	bh=hs6vOWcxq7NhNoT6wlrBwY/rtSOqSM4YClhCh6PJk8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYxlZKIP47tUNcnfftpaD61mVBfsA+KCq2vS4Jx6QLEgavujqKq+E5IvBIw3HUb1spnAGpo2AegAW8zsY+CogglPn3yDMLgUWT6dUMqPCuIbHStn0WoUZlfnd67wqcetEyY0K/sWYTo7Qn/H1tHqy0p6MMWNI71v08C6+1prVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=E2ZBBECc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Xvogqmj1; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="E2ZBBECc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Xvogqmj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878622;
	bh=hs6vOWcxq7NhNoT6wlrBwY/rtSOqSM4YClhCh6PJk8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E2ZBBECc17jpQyXjfW7AJ1jwdw8Z0K9PRIEANMA45QTVa10vZ912oHz44vT998i/2
	 xZPlE9q0zhBbzm2+k5ItJqw8eSJZoVEiFVE6hn6GQDMdj6/Yj05COlSBMnyi2PrafF
	 rTJLbl9E0EdCtCKETk96Zm/Wz2xoIP05l5zC1mE5gkrz2hS4UVde7RHVjGkmNJdb3n
	 Qa++/abipzRhMrC7IyXD964s99z1PQXQ69DAImNWufG7kzXd7/Mn2ACzN3LfqAngH5
	 D56w8PTtlf8GYbap+zhnz1mw1OYo5vzUXmez7PwFWoePBVMW2i9gdjnTufiBGnFC25
	 dzpG6t1b4otRA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1C37749367; Fri, 24 Jul 2026 07:37:02 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878610;
	bh=hs6vOWcxq7NhNoT6wlrBwY/rtSOqSM4YClhCh6PJk8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xvogqmj1L9EdzITzhlG5L1pKVbKCZ6IKmTi0nhwTWFp0F7nG7lKPK577k+GdAk8q1
	 lcgb5tCYfLy5a7vxEcJH++ST+Og642nHd+aavlYNDn8G67FlE6vEQ85h73S6HXIrHC
	 E0s6rRhK/u1a+YYIeBob2Fpoe5HlS3flHV9B9c8R22YpmUmNjK4FxJxhGtc5Ob/FJS
	 FlKxLcT088g1aV36nipBOLsS9+LvS6jzuDDXVMS3udiVJUO1HBKY25TcpUp2/ETtro
	 Q/2q1qHOepgQoqJc6TT4+AZmj/fG4w4dTf5XkQRVScAe2MzJhOYn8pIup9Kf48MViM
	 0cpKyOVmqXXPg==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 04547492F2;
	Fri, 24 Jul 2026 07:36:49 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:55 +0200
Subject: [PATCH net-next v3 12/13] ax88179_178a: Add AX179A/AX279 multicast
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-12-bdde4f905883@birger-koblitz.de>
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

Add support for conditionally setting the ip_alignement flag
AX_RX_CTL_IPE in AX_RX_CTL and make sure that AX_RX_CTL_DROPCRCERR
is also set to be consistent with the initial configuration in
ax88179_reset()

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 2b3393e7a3b2221b85bfb7c7b6b7ea6d92fc1deb..1e63d40de84364559a01d1fc02a652fcb7fa57e9 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1319,10 +1319,14 @@ static int ax179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
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

