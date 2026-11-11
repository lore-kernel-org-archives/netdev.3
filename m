Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407488;
	b=dLT1n/i36OX/Hvsx+zK7EMzb9MwVDg48exc/SjFoL4fISY28LoY7YvZVWYpOdie0pQDr
	 FDq0WD6ay+dhlBYF06MOOz8XH0tUuCLbG00fk547kLyW+0XPwSrm/8vIc+jqOcosOJDzO
	 HCJdGxfd6aejPRjgng0E9av6kUNTjlCCIVVcsB9tvhCN6jqbn+uhOmMvV9VOXV3hTOnne
	 21/4uCuqP9lMQHFCNvXArDzy7D3KAhuxxD/FzmofnrhyL977NKGwIBNw6/zORliddlnuM
	 m0xIM+O1FAYGNpn8+4H27m4Aq+Ud1z3YgCZFmf8ke01Vb3SIhsi0zRmMuK0ymM3ipAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407488;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=Ffya1PyP3rVgK3FKUJMeUTOknHVDLAS7rmXQhoJQICA=;
	b=mM5iWsmBK2DHfe5/0D4dVOf3kivo++3p/CLWJk86uOLIO8I5U1+sDvrqMnFtfYnHGDmw
	 4W0RScXuO+gRc5h5JDxeD/TnNZ12G24NE48ofZtJEXVoEKDE3lkVd2h5DklTQAPECGN2o
	 47lwAudBUfpHgbO3HJdGJAqaV4Qc489LzmpbQ8Nli4mYs9b3ZOWxtonkwPauO024VbX0D
	 lfg8d+jW+++LtfBiPWWy6oug3PbY3td7EfRMadzVrecVRTEQ9qniUI4ONSSkksIvhGUZF
	 2gI6iCSnvcQAezCKO62IW6asvPzDbjXNlpEKXk/0tdYaCei6jo8fHmAEJM7gWkCAHnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="CI/3Rm9B";
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6821606A321;
	Wed, 11 Nov 2026 14:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6821606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=CI/3Rm9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794407488; x=1825943488;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ARf6Qy9+lKPIUIodkBHNGoX/Amz6H0JQ2oSXq5Hzxl8=;
  b=CI/3Rm9BxO2wWI+lonsgPsKzZzOEC7f+dOCB8auwCbrR8wmTABu5J/1T
   XezkbDzyl1bNk6WCz/yQ9rZUhuUydgFkln7kmXDI3oNikP0n5aofEb8ET
   FsFsWWauIcek89lVQSm1AEr8BQJ3mAGoUfeHqq4v36xSzT19nUyboo9FJ
   e79b9nnQz26B4e8+8INu5Xk0lGtbKUbNe6vdgPqU7ZYXxapQalA/trGgG
   cB6E9HC/UhD8j7RasGCLY1ezAigx9dsKLV33N8P1+IjCLAwSjTV7foclb
   5L+0S8n7D3YaobGy+dRHJ4f1XBKLGU/4EYWw2LrWEe94B8pdFzUFjQb24
   w==;
X-CSE-ConnectionGUID: xPdy8HDdQ8WgP3ZgxhmbiA==
X-CSE-MsgGUID: txKp6d8FTIWKTSByyUbJig==
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="66598085"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 07:31:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 07:31:26 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 07:31:23 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v2 0/9] net: sparx5/lan969x: add support for
 changing the MTU
Date: Wed, 11 Nov 2026 15:31:10 +0100
Message-ID: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC589GoC/22NwQ6CMBBEf4Xs2TVtEVBO/ofh0JZF9kBL2kowh
 H+3Eo8eJ2/mzQaRAlOEttgg0MKRvctBnQqwo3ZPQu5zBiVULW6lwDjrsFY4pRf+Cn1DxkjdDFZ
 ryLs50MDr4XyAo4SO1gRdJiPH5MP7OFvkwb9eKUX1x7tIFDioxmhTXcWlLu8T2+DtyPPZ+gm6f
 d8/e3qRBcAAAAA=
X-Change-ID: 20260930-sparx5-mtu-change-d7ebb1a7fcaa
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.14.3

This series adds support for changing the MTU on Sparx5 and lan969x.

Currently, there is no ndo_change_mtu callback, and the MAC maximum
frame length, the FDMA buffers, the queue watermarks and the TAS guard
band are all fixed for a 1518 byte frame. This series makes them follow
the MTU, and sets the maximum MTU from the 14000 byte frame limit of the
MACs. As the FDMA is shared by all ports, new buffers are allocated
while the FDMA keeps running, and the FDMA is only stopped briefly to
replace them. Details are in the commits.

Patches 1-2 are fixes: patch 1 makes the FDMA stop sequence actually
stop the channels, and patch 2 frees the FDMA buffers on init errors
and deinit. They are routed to net-next rather than net, as they
fix issues that are not regressions, and the stop sequence is only used
on deinit until this series uses it to resize the buffers.

Patches 3-4 prepare for the MTU change, by adding a helper for setting
the MAC maximum frame length, and by making the FDMA init and alloc
functions operate on the rings passed to them.

Patches 5-6 size the FDMA buffers from the port MTUs, and add support
for resizing them.

Patches 7-8 scale the queue watermarks and the TAS guard band with the
MTU.

Patch 9 adds the ndo_change_mtu callback and sets the maximum MTU.

Tested on Sparx5 (PCB135) and lan969x (EV23X71A), by forwarding frames
up to the MTU and checking that frames one byte over the MTU are
dropped, by sending jumbo frames to and from the CPU while stepping the
MTU up and down between 1500 and 9216, and by changing the MTU
repeatedly while flooding the CPU with frames in both directions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Patch 1: add a Fixes tag.
- Patch 2: also release the lan969x TX buffers that are still in flight
  on deinit, store the length of the mapped TX buffers so that two-step
  PTP skbs are not touched when unmapping, and add Fixes tags.
- Patch 6: reuse the lan969x TX buffer release from patch 2, and mention
  in the commit message that frames still in flight are dropped.
- Rebase on net-next, which now has commit 873363ac591a1 ("net:
  sparx5/lan969x: release the in-flight slot of a stale TX skb"), so
  that a two-step PTP frame dropped by a resize no longer leaks its
  timestamp slot.
- Link to v1: https://lore.kernel.org/r/20261105-sparx5-mtu-change-v1-0-f27bab580463@microchip.com

---
Daniel Machon (9):
      net: sparx5/lan969x: stop the FDMA channels properly
      net: sparx5/lan969x: free the FDMA buffers on init errors and deinit
      net: sparx5/lan969x: add a helper for setting the MAC max frame length
      net: sparx5/lan969x: pass the FDMA rings to the init and alloc functions
      net: sparx5/lan969x: size the FDMA buffers from the port MTUs
      net: sparx5/lan969x: add support for resizing the FDMA buffers
      net: sparx5/lan969x: scale the queue watermarks with the MTU
      net: sparx5/lan969x: scale the TAS guard band with the MTU
      net: sparx5/lan969x: add support for changing the MTU

 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |  10 +
 .../ethernet/microchip/sparx5/lan969x/lan969x.h    |   2 +
 .../microchip/sparx5/lan969x/lan969x_fdma.c        | 193 +++++++++++--
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    | 321 ++++++++++++++++++---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   2 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  14 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |  34 +++
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |  48 ++-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 123 +++++---
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   5 +
 drivers/net/ethernet/microchip/sparx5/sparx5_tas.c |  43 ++-
 11 files changed, 693 insertions(+), 102 deletions(-)
---
base-commit: 368fbf5d82da9ebce309449c74fc0b128f7d0219
change-id: 20260930-sparx5-mtu-change-d7ebb1a7fcaa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

