Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4D3C1996;
	Sun,  2 Aug 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688365; cv=none; b=fg4V1JWLFchAMw05D6YHrYL1vKzGRWtgyE6Nd2pdngSPnL6fj/9gOtaSkKOIv6wxy8n1Kd6rLHQz/qgQ9L2nEanX54dsNg+ppOfCdy6Ncl19BIoR3sCE9GX6bNN9VHFcQy2FV2EMHSuDQqoaz6dSsbAwuzs82HDlCG6LoL5uaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688365; c=relaxed/simple;
	bh=itokd5pFa1OVLpnstzL/mOuxLye8/+3saVZKgfJxPEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXth9s+dNmlUCIm9EtkXwY7gaSoVOPhZ4wsTFezNoYzoJfQ9igHF6Bh4FLrGAlrr8Ywb3zuImY1NpkQC3NnBFsAGGpSRX1ZKPUDPXPHxFS3IRF7rG/ZZ6oz4aLL6h9vBJvTPUQJ6EHZMDynFNWHfCtjpGmLydorhumD7DAdpcPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=jvQ0Q03T; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vVBqyRqJ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="jvQ0Q03T";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vVBqyRqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688357;
	bh=itokd5pFa1OVLpnstzL/mOuxLye8/+3saVZKgfJxPEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jvQ0Q03Tak0xaTFGr4cuT3jDSsL6NAi9bhx2Ipa0iBuedhwAVHToJjNFMzLoQHL70
	 4zEiqbMzT2W/a9aFdUFzC7N86aFXxm40qgXWZQEZzKxtZNCdjtcYqCtEbX3IK9obgn
	 nRCl1nsecWpiC4XOmtjn8KvmIGN9TSZk+IFw+eq054JalXaPIKXBb01Stl0qrrbcWD
	 HU2B6WWmuBh0hyGPAKgip7SUrgHrWA+8aaQodkcOfe67bel9/YoakwHJTWUeAPqNqZ
	 lXmTPjMxu4v+MzyUdSHDPd1zgaADdmN8y5PENsoSpIKJKAaYISjUysjarTM3WkoO1z
	 ijBfZ+llIjJTA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7F9AA49650; Sun,  2 Aug 2026 16:32:37 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785688353;
	bh=itokd5pFa1OVLpnstzL/mOuxLye8/+3saVZKgfJxPEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vVBqyRqJqPQUoD+H/nbyC9p2AHG6lSjXgC9dC9zzbp1M5w8X+C3qYxA8fDImK/fCO
	 FlvlTVq+EFOQalEH916KSnFanfGsn5cKMjNIC7HjMgQMH0Pg2+puXIe2zsSOFl9qHv
	 qs8uVhReOdQe3R74EU64Rtgmg5ZIJ4Y94boucnz356uqeFNBHEQvEAqt3hvdB4Aq+N
	 0a7qAXsV0OeSUcrvnzvkM+YrpENaKn8VzqqI6z/qaYsrH78uTiJU8CZ2rYH3mvlrSQ
	 8mhebGhDk6C4fQjc2Odee2GgpU9Ffv8810iDOIMRp4Ck3vyiNH90riK8gvYcrbaphu
	 0l9oMbY1JubBA==
Received: from ThinkPadAMD.lan (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8F4BA4964E;
	Sun,  2 Aug 2026 16:32:32 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 02 Aug 2026 18:32:01 +0200
Subject: [PATCH net-next v5 03/13] ax88179_178a: Add netdev2data()
 convenience function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-ax88179a-v5-3-dcb9fea4acd4@birger-koblitz.de>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
In-Reply-To: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add a convenience function for the ethtool ops that use
phylink and need to retrieve the ax88179_data structure from
net_device.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_lib.c | 7 +++++++
 drivers/net/usb/ax88179_lib.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 7b5c17a01df2deac2cc0210bc88193be1abfbe23..34350ba3b96b94bc82072a578802a91ebffd7a6a 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -137,6 +137,13 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index, u16 size
 	return ret;
 }
 
+struct ax88179_data *netdev2data(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	return dev->driver_priv;
+}
+
 void ax88179_status(struct usbnet *dev, struct urb *urb)
 {
 	struct ax88179_int_data *event;
diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
index b2ee1356727cf4b3fa05f0b0d5fd863ac3f9a87d..9ff2a94a6fb2de4ee85f25e913ae2fe263bcea7c 100644
--- a/drivers/net/usb/ax88179_lib.h
+++ b/drivers/net/usb/ax88179_lib.h
@@ -181,6 +181,7 @@ void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 			     u16 size, void *data);
 int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc);
 void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc, int val);
+struct ax88179_data *netdev2data(struct net_device *net);
 void ax88179_status(struct usbnet *dev, struct urb *urb);
 void ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
 int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);

-- 
2.47.3

