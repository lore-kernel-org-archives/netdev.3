Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DBB4CA29D;
	Wed,  7 Oct 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393306; cv=none; b=jERFk5lpSd6HPkgrZI5NGP8P7gEOhqlKkey1fGv+KgbzuxzBixGdonSnA5th4N9WrsmOdLaxA9ncQGuNOgp/jfU9L3pyDF5XFiPARBMB7z3XzWsDYGpPDuzKHbDOQww3zWLwjgyj48pL0pUPtiTzjU8RybQ99MpiCBls1n/3GYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393306; c=relaxed/simple;
	bh=HzoohC9CE+rfa7l5/ifQdBRdAjPZ/4ke5XrSiNFX5dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBMiK9m/iq0yHtgmqYamEJhs//f+UHZ2/I5/In/WHvJEg8ru+sgIoqqQJ7C41qXAT9udtFjFsuA7e3xU0KBge6YvLTiZ1jw8NZf07R2t8zhbWOxnAaV3oYBW2zKCLTr1HCbEXpC/+xNSlme2H8CK8yzPDBYDLE+T79dmtBkstqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=JzZwoKwv; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="JzZwoKwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1791392841; bh=HzoohC9CE+rfa7l5/ifQdBRdAjPZ/4ke5XrSiNFX5dA=;
	h=From:To:Cc:Subject:Date:From;
	b=JzZwoKwv7oc4PBRNW99Qq4XoWP9bi0vmLYRG4jIdXrM6d+9cTEJ4X4mhQs2GWpWP7
	 Zw5EVoj91vq0245v07dDWJGdm0pkJLiljY+23Rp5CZZ9fhQw80iT2QNKfEAWOYdUbo
	 A3PtbmBULvxelvzZAWZM+ycM3THWIfcTPYZTxslS8g974iWYVCJwdA6xcXDGqgKEu+
	 1GP8qcrR54yH+h2IDYipYl3qBIR2ec8ZhDLypXv1eR+gBsh2eKmurKEMsPyuvkJ2HF
	 0RM8d4IvwYgocndKKvWd6cny34xEedmrvZfsDo2PlWc2WnLHcFcSga+ETQnP87DtOz
	 e60htQZjzArJw==
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6ac67c49-0462-7f0000032729-7f000001a3ba-1
	for <multiple-recipients>; Wed, 07 Oct 2026 19:07:21 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  7 Oct 2026 19:07:21 +0200 (CEST)
From: Thomas Martitz <t.martitz@fritz.com>
To: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Thomas Martitz <t.martitz@fritz.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 0/1] macvlan: allow source mode devices along with passthru
Date: Wed,  7 Oct 2026 19:06:35 +0200
Message-ID: <20261007170638.2086790-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1791392841-52FAB94E-5FC8081B/0/0
X-purgate-type: clean
X-purgate-size: 2977
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-01  mail-id: 5EB27A0381  external: no

Hello,

we're trying to solve a use case on our devices where two SoC are
connected on the same board, using the only available high-speed interface.

One SoC runs the main Linux system including the full routing stack
(FRITZ!OS) and the other SoC implements most of the GPON ONT side.

The high-speed interface is of course also used for the user traffic.
Therefore we must tell the inter-SoC traffic apart from the user traffic.

We achieve this by matching the well-known MAC address of the ONT SoC.
The user traffic passes through the ONT SoC without modifying MAC headers.
Now we would like to use macvlan (with source mode devices) on the main
SoC side for this but our routing stack requires the rx_handler to be
available. Therefore macvlan is currently not an option.

With this patch macvlan becomes an option because the current limitation
of either "one passthru device" or "any other configuration" is relaxed
for the combination of passthru and any number of source mode devices.

This allows us to configure a source mode device for the other SoC and
register an rx_handler for further processing on the passthru device.

Thanks in advance!

---
Changes in v6
- Prevent passthru and source mac from having the same MAC (if both are UP)
- Fix unbalanced promiscuity
- Really prevent changing anything to passthru
- Fix restoration of lowerdev MAC address

Changes in v5
- Properly respect "macvlan_addr_busy()" again for non-passthru  interfaces (and avoid calling anymore for passthru interfaces)
- Guard NETDEV_CHANGEADDR from messing with the lower device
  address during passthru interface removal
- restore unicast address (dev_add_uc/_del_uc) handling> Changes in v4

Changes in v4
- Prevent macvlan_restore_mac() from changing the MAC address
  of remaining source mode interfaces.
- Set MACVLAN_F_PASSTHRU on the macvlan_port only after adding
  the passthru interface truly succeeds.
- Changing existing interfaces to passthru mode shouldn't become
  allowed.

Changes in v3
- fix passthru port removal caused by passing the wrong 
  device to macvlan_port_release_mac(). This was also
  detected by syzbot.
- macvlan_port_release_mac() is now named macvlan_restore_mac()
  and gets passed a "struct macvlan_port" directly.
- Link to v2: https://lore.kernel.org/netdev/20260709100512.1383421-1-t.martitz@fritz.com/

Changes in v2:
- changed several port-wide checks (macvlan_passthru()) to 
  per-interface checks (vlan->mode == vlan->mode == MACVLAN_MODE_PASSTHRU)
- correctly handle removing the passthru interface when there are still
  source interfaces
- Link to initial posting: https://lore.kernel.org/netdev/20260612092345.2352255-1-t.martitz@fritz.com/
---

Thomas Martitz (1):
  macvlan: allow source mode devices along with passthru

 drivers/net/macvlan.c | 107 ++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 34 deletions(-)

-- 
2.54.0

