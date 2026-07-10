Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A1350A05;
	Fri, 10 Jul 2026 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672594; cv=none; b=sCDupQmVeimllBMuDiTF7BKNH1/gETeClUplGbjFmhFmBXZHHjsCBMgw9sE1KAJ2Px3q+aBmGqLG6B+zD9Mvre9tUBxMEebaMVy5Rc9GwqrBHP/57XcOrWqljSotVZn+xym5xvG28pkg4F7PZxilJ6bZD+Tw6rCsXSJJJKKIPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672594; c=relaxed/simple;
	bh=pAuTP/ot9+zcg7mZlxEODzCsbXvgpsBD3W7ZJ2SSXrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqhm2z6WJKrZMYEWv0wnnKM+2/xu9DEYTldmw3DrFFzlFiZqvTpnMC/7zQ44b5FFkj9hjSf+mkhc8qPoPVkSc8bGJp77QoQ2kJD4ujYW4nOP5wKI0N+EKjKMGG9TuVMD6Htgv4YBtqCgQcNs7KkGGI8feCyC/W/wIUF1y07GiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6a50af0d-fbf2-7f0000032729-7f000001b32a-1
	for <multiple-recipients>; Fri, 10 Jul 2026 10:36:29 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 10:36:29 +0200 (CEST)
From: Thomas Martitz <t.martitz@fritz.com>
To: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Thomas Martitz <t.martitz@fritz.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/1] macvlan: allow source mode devices along with passthru
Date: Fri, 10 Jul 2026 10:36:02 +0200
Message-ID: <20260710083604.396560-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1783672589-5DD8E6E1-F71563DC/0/0
X-purgate-type: clean
X-purgate-size: 2132
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

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
- Lnk to initial posting: https://lore.kernel.org/netdev/20260612092345.2352255-1-t.martitz@fritz.com/
---

Thomas Martitz (1):
  macvlan: allow source mode devices along with passthru

 drivers/net/macvlan.c | 107 ++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 34 deletions(-)

-- 
2.54.0

