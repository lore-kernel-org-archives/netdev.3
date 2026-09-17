Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A790B46D559;
	Thu, 17 Sep 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639431; cv=none; b=qGBnlKUGbBsyCv+g75jssVloSgCE7n7DdSfTgvZsLbADQdwpMfG+G+XvR6/fFX6jE3fYxhtkqddF0r4Ji9rY2KCYZMDDy7uMsnpUQcjHhTYz0BKlK57D0Y1tzQQrsslV2N4Kv+q9MNbQn8r8pTqiA8V7KYLxbhs6FScRz828LCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639431; c=relaxed/simple;
	bh=YKVLIQtatBhn5yK/xtLhS4dBm2eOpXamOjk5hO60+Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IA3i9XEkYjeEoTdMuBxS98DQTgqWQYUhSzjb0BjhyKFxJCqC7IVwt8+sbahO5mlkT8N2jQEhvwmc9UCJ5R+OtO1kXTWtJSYMkFKUlKnSBFDxKhw113uiAcfsGQcxiihKFqbvLzZH6ep81DCajM6U3LaHa1P1cIcs7o+AFXBtwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=pa6r9mEW; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="pa6r9mEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1789639398; bh=YKVLIQtatBhn5yK/xtLhS4dBm2eOpXamOjk5hO60+Mw=;
	h=From:To:Cc:Subject:Date:From;
	b=pa6r9mEW5JKwfXLpjjkk6v03ol+QiWEZMNrQyVm+rLT1EZyDQoht4H+xBiPLoSQqS
	 pRXVBUZj0CcN8H4qRdVMP5fk8MPo++ZT9zPOa59a8WL9HjFntSYa+zYeUot8rh9kie
	 ZWT2fESBMRh6u1L5rR4i3UPSJBMV/6sDOLJrIahYpyXuW3NbeQ4lOMbVCF/a3FPyJL
	 vd2lCg0iuIc6ePeRf1NLnoWYtE+H/5Pp1i7NgEOMKDXS0BDTiSsLeLHgm2nRc5I3Ah
	 7cyjGp3UkFfrL6U7LQ5s5PPHG2jtPLxWl2W4DMraPOyqRwGXVW4VQwIPUDxvKGwpme
	 42MVQjIgFh00w==
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6aabbae6-ea3f-7f0000032729-7f000001add2-1
	for <multiple-recipients>; Thu, 17 Sep 2026 12:03:18 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 12:03:18 +0200 (CEST)
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
Subject: [PATCH v5 0/1] macvlan: allow source mode devices along with passthru
Date: Thu, 17 Sep 2026 12:02:57 +0200
Message-ID: <20260917100258.2582568-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1789639398-FDC87720-101C1876/0/0
X-purgate-type: clean
X-purgate-size: 2437
X-Notice: Whitelisted
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-02  mail-id: 38D6AA048F  external: no

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

