Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558C3DA7D4;
	Tue, 15 Sep 2026 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506967; cv=none; b=onTHkbteiVjIRzqBQc0UNuK7t2noXexML598MUqbHeGSj9UTqvUhxT1/KMsTdJn3qCLQoSAYWKbgrbOX0Q+gSbL3HPe0Hu/q82COaIOdoleW38KGWX1dHC1Equ4JsMydQOBZjg7M3TYVJp1edaOFz8bEU8W0lZLkI0HLvbZoEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506967; c=relaxed/simple;
	bh=aGntX6w8kluabbFMMzhP3I9EzAtyYA295B8Ixh1KU2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spSj84ItW+WJMLdhOWmGSD9sWQsoXjuHgrTwO8BI6qQU2C6cdibjjjRtis3vl+d1vqnGgvafzq5nNfZbkqnzFwHwcEC1XTg1N6VxPQe9C3aeaVk476S6uDGi/zAZfXrdUtMl8nttshfEBltbqarRy7iN21Q/zXCxuCHcXTAYI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb1kbmC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb1kbmC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3D11F000FF;
	Tue, 15 Sep 2026 21:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789506965;
	bh=Dt5qo0fyrir/Ya9vzhG5+FUOK66K1vdNIl09fWEfOY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qb1kbmC9lZ2gnrmOyrYEi9NP6V2XzWeOxOwRxRXwwIRJlrjGeL4HgrPN2QeVN13Ey
	 f79nxREhK51NQd717NzgrfBqxIP7NdHtd6Z3+4tTjy874R0IC1DOxPygHThpnu/uzW
	 KBvAkYYAOrogfPvrqhMWacUiynlb9e0si03ruHL4VBEqqxFDuXUvqXvBNDRhjUqJPt
	 1T3vwLDA00tYZ1Nz8j5SorN/34LBomvh+g8OvL4P3dD+mpFb6lZY1q8yuoDMLDe/Tp
	 OinBf014ulgfHnUsHXIUcciOuyAfsejdLjuiBiwEG3ho3/1re+VXpisWyhN69Ki39r
	 bFCfT7WBsQG3A==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [net-next v3] net: remove ndo_do_ioctl handler
Date: Tue, 15 Sep 2026 23:14:04 +0200
Message-ID: <20260915211538.1519815-2-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915211538.1519815-1-arnd@kernel.org>
References: <20260915211538.1519815-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All of the references to the callback pointer are gone, so remove the
pointer itself before we grow new references to it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/networking/netdevices.rst | 7 -------
 include/linux/netdevice.h               | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index aac33497813f..6a87f09e7015 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -222,13 +222,6 @@ ndo_stop:
 	Context: process
 	Note: netif_running() is guaranteed false
 
-ndo_do_ioctl:
-	Synchronization: rtnl_lock() semaphore.
-
-	This is only called by network subsystems internally,
-	not by user space calling ioctl as it was in before
-	linux-5.14.
-
 ndo_siocbond:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
 	lock if the driver implements queue management or shaper API.
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 707b2e51c2b9..da388cfdc1f2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1154,11 +1154,6 @@ struct netdev_net_notifier {
  * int (*ndo_validate_addr)(struct net_device *dev);
  *	Test if Media Access Control address is valid for the device.
  *
- * int (*ndo_do_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
- *	Old-style ioctl entry point. This is used internally by the
- *	ieee802154 subsystem but is no longer called by the device
- *	ioctl handler.
- *
  * int (*ndo_siocbond)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Used by the bonding driver for its device specific ioctls:
  *	SIOCBONDENSLAVE, SIOCBONDRELEASE, SIOCBONDSETHWADDR, SIOCBONDCHANGEACTIVE,
@@ -1480,8 +1475,6 @@ struct net_device_ops {
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
-	int			(*ndo_do_ioctl)(struct net_device *dev,
-					        struct ifreq *ifr, int cmd);
 	int			(*ndo_eth_ioctl)(struct net_device *dev,
 						 struct ifreq *ifr, int cmd);
 	int			(*ndo_siocbond)(struct net_device *dev,
-- 
2.53.0

