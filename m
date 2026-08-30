Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DA25B093;
	Sun, 30 Aug 2026 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128596; cv=none; b=fmpZ7+OhZvN43+BKxbkkCnqUD8i0iyJPssndNN4ESASvaIA8Eo1UMhLgqAS83SE7hIHOExxf8KqlwVvaW5ezneo3uwhSnyGNYvRnbsjrl+ybXKUgnm7J+BG+Hf4q6y1qMRK8H15m/aKVVnPaWZUGUPQqFmpOepBNmNgEJXuoDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128596; c=relaxed/simple;
	bh=7rIiizblbVFHiyR0jxZgN0FAobkyySuK5gU+CYTmzBU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xom/F4A0XjprkCdSEgQp3Umr9UAitlK3KdNe3nwtFOITSkD6+Mpl6nU+I1G9/dtSy0yyzRXGUwh5eQndE50EfzZS7NO/OxqrT/zwxy/y9nM0xwixoEtdt27KyQn32pCcSrLDMmOrtskJJVzBHBBfmQCSyGO1fIaiCqOONmaWvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=gD5HnXT0; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="gD5HnXT0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2382; q=dns/txt;
  s=iport01; t=1788128595; x=1789338195;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=6X+IpLazpvXcyuPdb4LtUEW8N6m1eSKinYYWAlktVl4=;
  b=gD5HnXT0dERNby/lj9zuNCwTggaAAgAZmwRQwuAdi5eozK7mLVS2lYEd
   G6m/+iebvmACFLAob3mxp9mfSxi8KWoptcELCSqCM7dlvGex7uNF9MQz9
   JwNO4nlNcD4n+u0sMMRjQYF5pEhgBC2Z6D48xYwxcQLdHIBZiTlP6lHAK
   uS3bh/QRsbayfpHcRccnP7zR7mgCxoZsZWmhip31buBJ2s9AsmKSy3Iol
   PKw+PiaCPPqLPo6U0i+q8M+Y+5YVaV9kr+jCGAiz3B1jUTrG8pE0o7mBi
   fyzT3EZ9a6wCm85rB0krsfbNt439VPQF/HN5ROy/Y+oOj/Q2+ygrvpXiB
   A==;
X-CSE-ConnectionGUID: +FxpzlDhSwKQH1Tz+hcdWQ==
X-CSE-MsgGUID: gRGOSx/BQVil0C5nIZK9HQ==
X-IPAS-Result: =?us-ascii?q?A0C4AAB0rJRq/5IQJK1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wQBAQsBhChDSYRXj1KCIZFNjGWBag8BAQEPUQQBAYUFjXUCJjcGDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZdJ0QSNQImAkgWARKDAoJ1A?=
 =?us-ascii?q?8IleoEygQGEfdlKgXIVgQouAYVwgm0BgXCECDuEQScbgUlEgRWCem+EHwuDd?=
 =?us-ascii?q?IJqBIEOgRSBDIJhix+FeQk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIUH?=
 =?us-ascii?q?BMPBBYyHXAMJxIsFzVYGwYFgR19FAQThA8jGTZ6gQlegSspYAESF4EJgggCg?=
 =?us-ascii?q?lqCBQIBSUMOB0dTCQQLGA1IESw3Bg8ZBD0BbgeOeh+BWnABgQ97BCcHAwxEL?=
 =?us-ascii?q?QmTYINtjV9roQ+EKIFmoBAzl2eRboEXmQgjo14JUIRpgX4mgVkzGggbFYMiU?=
 =?us-ascii?q?xkP3lwnMj0CBwIHDgMLhkaLJA8XB4FPAQE?=
IronPort-Data: A9a23:RyrIcqIEh6pYTQEKFE+REJQlxSXFcZb7ZxGr2PjKsXjdYENS0j1Vy
 jAZW2nUPPyCazb2f99/YY+09UlXu8XTx4VhSlEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnQ0
 T/Oi5eHYgH9i2Usajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN0tIlEuL4k0+t1oIlhur
 MAKazAGYi+60rfeLLKTEoGAh+wqKM3teYdasXZ6wHSBXLAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzMnwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQhiuW3bouFJ4fiqcN9kXy3g
 VnWuE7APBAebPfCzxu30SOMv7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWsDYzIUCAgI+d/upKktgR/VCNVuCqi4ipvyAz6Y6
 zaHsCQzmZ0NgsMRkaa251bKh3SrvJehc+IuzgzTWmTg6kZyY5SoItT5r1Pa9v1Hao2eSzFto
 UQ5piRX18hWZbnlqcBHaL9l8G2BjxpdDADhvA==
IronPort-HdrOrdr: A9a23:Vkk/VqmWV46aT8+rVLTwVau5Q5TpDfKy3DAbv31ZSRFFG/FwWf
 re+MjzsiWVtN9xYhAdcL+7VJVoLUm3yXcX2+cs1MmZMzUO0VHAROpfBODZrgEIdReOk9J15O
 NKLuxCE9X7D1h8g6/BkWqFOudl6tiO966lwcfypk0dLz1CWuVM4xh0DwCDHlYzZgVXbKBJba
 a0145rqyWtfHIPYt/+PHkKWODfu8bG/aiWByLufyRXjzWmvHeP9KPwFQSe01M1VjNCxqpnzE
 3++jaJnplKd5qAu2XhP6i51eUspOfc
X-Talos-CUID: 9a23:EDZfnWGtPcAenjR2qmIk2l4MCMQJckbC707wenOqSmZiRIKsHAo=
X-Talos-MUID: 9a23:a8VsaAkAt22yGjEV8ThDdnptDuhP2LTpInkzkJFekJSCFB5Tahek2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,252,1779148800"; 
   d="scan'208";a="825269853"
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Aug 2026 22:23:04 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-09.cisco.com (Postfix) with ESMTPS id D63CE1800044C;
	Sun, 30 Aug 2026 22:23:02 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net 0/2] enic: fix V2 VF mailbox reply matching and carrier
 reopen
Date: Sun, 30 Aug 2026 15:22:51 -0700
Message-Id: <20260830-b4-enic-v2-mbox-fixes-net-v1-0-23adf9bfd426@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADutlGoC/yWMwQ6CQAxEf4X0bBNY0VR/xXBwl0Fr4mK2SEgI/
 27V45uZNysZisLoXK1UMKvpmB2aXUXpfs03sPbOFOpwrCWcOLaMrInnwM84LjzoAuOMiQc5iER
 p9mh7cv9V8Ctdv5APqPuH9o4PpOn7Stv2AYVhKZOCAAAA
X-Change-ID: 20260829-b4-enic-v2-mbox-fixes-net-f8588b813e4d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Sesidhar Baddela <sebaddel@cisco.com>, 
 linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788128581; l=2407;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=7rIiizblbVFHiyR0jxZgN0FAobkyySuK5gU+CYTmzBU=;
 b=3X1saCdNTBrMAS8YPW0hV8PgGvD/2mEjZHovt25CNYTdm23OlDpDE0kJ8qRN4owZ64Hux6Fsh
 2IjawKjwn03A8bY33LoY5ABO8Kr59pBctkvsF4fikT1nFlgsOQcL/18
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-09.cisco.com

Preserve ENIC V2 VF carrier state across netdev reopen and match mailbox
replies to their originating requests.

A V2 VF receives carrier state from PF MBOX notifications. enic_stop()
forces carrier off, but enic_open() does not request another notification
or restore the previous state. An ordinary netdev close/open can therefore
leave the VF without carrier until the PF sends another link-state
notification.

The first patch preserves the last PF-reported link state across an
ordinary netdev close/open. Internal reset paths invalidate the saved state
before reopening the datapath, so carrier remains off until the PF provides
a new notification.

Mailbox messages carry a message number that replies and acknowledgments
echo. ENIC currently assigns a new number to outgoing replies and accepts
VF replies by message type alone. After a request times out, a delayed
reply can therefore satisfy a later request of the same type.

The second patch makes PF replies and the VF link-state acknowledgment echo
the initiating message number. The VF accepts a reply only when both its
type and message number match the pending request. Reply handling and
timeout cleanup are protected by the same lock, and message numbering
remains monotonic across admin-channel reopen.

Validation:

- The VF module with this series applied passed multiple netdev close/open
  and ENIC module unload/reload cycles, as well as guest reboot testing,
  with carrier restored as expected after each operation.
- With this series folded into the full SR-IOV development stack, VFIO
  guests passed bidirectional cross-DUT PF-to-VF, VF-to-PF, and VF-to-VF
  traffic using standard-sized and 8972-byte jumbo ICMP packets.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Satish Kharat (2):
      enic: preserve V2 VF carrier across netdev reopen
      enic: match mailbox replies to request numbers

 drivers/net/ethernet/cisco/enic/enic.h      |  26 ++-
 drivers/net/ethernet/cisco/enic/enic_main.c |  25 ++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 309 +++++++++++++++++-----------
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   2 +
 4 files changed, 233 insertions(+), 129 deletions(-)
---
base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
change-id: 20260829-b4-enic-v2-mbox-fixes-net-f8588b813e4d

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

