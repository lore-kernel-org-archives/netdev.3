Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188092;
	b=gS9K2OeE6DunnpBB7bAtOYmJ+mf6qjhy8QjV2TSzy9uEVPXEsQL68kMYn7zVT0i/5AKf
	 /ETSfFMJE86WwlYRhh0OYeFRGsze4q4j17bT8I+axS5HJAsneSSQ/0jopJ1f9tczNlTtb
	 RY0VkXaP2/5XplFQ/wnkMBk68Sn5TDWkkwODVmZ3RI7rs/i7jc5H3DQUbSlg6omOR/3Xq
	 8BsbSGehHLpj+jLW5+msa97l3FYfG4JfiM/HayKTkxQA6wcVeJrTLDC27/D9pbmJ6b1y7
	 98rySEIVvMZG0QzFZDEhDFxM3b6ytUMbFJ9ji5jq/VuxLFl0187iPmWdG0dsnrwjfHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188092;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=uat8pe08mkQcc9xp6GiqZoeJlBhecCIrIQkqGR0KJo4=;
	b=PE3PNbe3CwXMyl2NMPMiApImpWJVl72xQgNjJ+TkvmODBS+nrEO+BRMWgnB2insxm6F8
	 XXw7a+AjueqrzFDNO6ds0F8iBB9ztLK0aDLoOaXY7vgbizBAdsKGGQ1W9E2H5/VFUnYmV
	 Is22BXY/9wdKhUGS2jOxVsflaNjlNuwmEfzx92J9iapmPllDU6Gg4fTrJdEAwkrUnCGMQ
	 LYCKSMv9VMdkVIB69K6szMuFk+X6zyCYH2R7v7SI8T4NihhNachXWkkYWP8PpDxLqsjR8
	 qT61Cda2/FOHv4EcYOdsH3Lg+CbWcd3JBKfMVqFH0QUx5U6NmoQc9YYNyJvjfhN7LtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBtoulQJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEFE606A326;
	Wed, 28 Oct 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBtoulQJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793188092;
	b=0p3xMFlbmmkCs7LcFTBc0kt+V5XaaPmb7+Hix+lZaBMJmDAeloVNu0AKnflAOgRtkMGa
	 am0lMk12AkgP2qOYyHSNAjq1dYHHxZebg4yPoEx78CHbT+q2EVZYmdFPTVnnMMTPXkqm6
	 6r3oO3AhcGCpw4mg+nATxfmAKty2NVih0dxZXZKEHQ7f65sb2rYlOkAcT/Cq/9bkexyqb
	 3+vAVa3dnzXMAP4KAa81mT9itKwz7RZGJeGJ7zoquXPWtiGrk/F2BEznYS4GOfzcJ9KVo
	 8aDDGyDXlomVf2+MViWBYSdXGUbttXvCyLzmUsWjPQB4ayOnqAqeoDwOVypuX8RRhPQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793188092;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uat8pe08mkQcc9xp6GiqZoeJlBhecCIrIQkqGR0KJo4=;
	b=yhg/ZGzfC5wc71QtTUuSeBLkTS/OHClj7uHO/wOw62r0QnKwt9loRB7U8zNJ7erlvjQm
	 2iyTxSqyuUUCE9JmgPG/TRyHMYOYZQiS24SgP46RV7GVTagBp8zlsDqTxs5G78wg9ReDa
	 oCpX2/l/975zSAZQFXXnK3X7mZeth92OSrdxJii0+6sVxs7LRVj5EVv5NQylMvgqDxCvS
	 qI2drWPDHvyKQNMoQ3RGM+oX4qY5hLLyIbaBh5lDTaaTBznXbfX48DM2O8YbMusQDiNsG
	 HMqeyjk4NY3vH2ZbrCCeYMXKi0m/Y1Q/FS5QxIvr8AhuvcblZx1F+4ssVqdsTKkWE2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E090E1F031E7;
	Wed, 28 Oct 2026 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188092;
	bh=uat8pe08mkQcc9xp6GiqZoeJlBhecCIrIQkqGR0KJo4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=JBtoulQJgr9VNnQW6lqXiu6RYd9Z+XUR7cZYcTGib5fJj5nSoEIjmG6PLRJCWLjgh
	 3XIkc199lImRPmj/JfoVjzD686SHkKFgsWDAmwAitvkA/3PCuhjomwu3DLdw1UKEMD
	 d6bmIlAK/XBolmRJPulYjcfQMgnZATsDgjk6SzbnFF+6CWTYhUBO/x+waQ1T1W9vLV
	 oAjoJuStzKDIvn+jLjHjVtH1frjKvAcxSwu0GJNLWiWMzk9RwulOARy996yr71jgck
	 z/AsLescOFf67F8toAKzq3UUiFWpwBiaUPelACjdQTiUf0YmyPha6K5A40pUrqvqRF
	 Fd0cT2RxU85fg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C9654544A;
	Wed, 28 Oct 2026 11:48:10 +0000 (UTC)
From: Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
Subject: [PATCH net v4 0/2] bonding: fix the initial last_rx seed for the
 ARP monitor
Date: Wed, 28 Oct 2026 12:48:06 +0100
Message-Id: <20261028-bonding-last-rx-v4-0-4d8e4cd47467@well-founded.dev>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOwQ6CMAwG4FcxOzuzdSjDk+9hPABrYYYMs8HEG
 N7diYnxgMc2f7+/TxbQWwzsuHkyj9EG27s0ZNsNq9vSNcitSTMDAQehZc6r3hnrGt6VYeB+4kI
 JRaXINBWGpaubR7LTIp6Zw4FdPsswVlesh7f1jrU2DL1/LL1RLuG/FVFyyQtTHignQ1rC6Y5dx
 6kfnUGzMxiXkgg/DKwwkJi8VlopDVCD+sOoLyPFGqMSs88KkZOkSmRr38zz/AJmn4Z3WgEAAA=
 =
X-Change-ID: 20260817-bonding-last-rx-0303fa048f9d
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Hangbin Liu <hangbin.liu@linux.dev>, 
 Ramses de Norre <ramses@well-founded.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793188089; l=2944;
 i=ramses@well-founded.dev; s=20260817; h=from:subject:message-id;
 bh=xLrmUFjRPWtdn4U5H1DplHJw2hv8F/w6hsEGx/wnJJM=;
 b=maMuKqZ2KVJYu9NHY79eSLYdrP1uPboyHXpYrRa8EZ9CsrJCfNbx9lvi6hBvD6aDlGRZW100f
 aM2RK/fwgSPAjJ7si5phVJWUHKh+w017k8QUM+Utkm0hQHR6XwCc361
X-Developer-Key: i=ramses@well-founded.dev; a=ed25519;
 pk=1vBXHBVeJBMaC+2Zuonl0QQhEgGIQHERyF5RZNnrCmw=
X-Endpoint-Received: by B4 Relay for ramses@well-founded.dev/20260817 with
 auth_id=957
X-Original-From: Ramses de Norre <ramses@well-founded.dev>
Reply-To: ramses@well-founded.dev

bond_enslave() seeds a new slave's last_rx before it has received
anything. The ARP monitor checks that seed with an up test for a slave
that starts DOWN, and with a down test for a slave that starts UP. The
seed is wrong for both.

Patch 1 fixes a slave that starts DOWN. Since the up test gained
arp_interval/2 of slack, the seed falls inside the up window, so the
slave is reported UP for half an interval without having received
anything.

Patch 2 fixes a slave that starts UP. The seed brings its down deadline
forward by one interval compared to what arp_missed_max implies. In
load-balance mode, which has no grace period after enslavement, a
healthy slave can flap DOWN with arp_missed_max=1.

Jay, on your v3 question: the up test always uses a single interval, so
the fix for a slave that starts DOWN holds for any arp_missed_max. But
v3 also changed the seed of a slave that starts UP, which made the
load-balance flap happen with the default arp_missed_max=2 too. v4 only
uses the older seed for a slave that starts DOWN, and patch 2 gives a
slave that starts UP a full arp_missed_max window.

Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
---
Changes in v4:
- Patch 1: only use the older seed for a slave that starts DOWN. v3
  also applied it to a slave that starts UP, which brought its down
  deadline forward by one interval (Jay).
- New patch 2: seed a slave that starts UP with last_link_up, giving it
  a full arp_missed_max window. Fixes an existing flap in load-balance
  mode with arp_missed_max=1.
- Drop Hangbin's Reviewed-by, patch 1 changed.
- Link to v3: https://patch.msgid.link/20261027-bonding-last-rx-v3-1-54907f1fb042@well-founded.dev

Changes in v3:
- No code changes. Rebase on current net.
- Reword the commit message along the lines of the v2 discussion: lead
  with what the last_rx seed is for, state that the false UP happens
  independent of primary_reselect, and that the initial link state is
  unchanged.
- Pick up Reviewed-by from Hangbin.
- Cc Nikolay. Hangbin asked for a second review, Jay or Nikolay, would
  you have a look?
- Link to v2: https://patch.msgid.link/20260827-bonding-last-rx-v2-1-7c3833822c23@well-founded.dev

Changes in v2:
- No code changes. Resend with my personal name in the From and
  Signed-off-by lines instead of my handle, as requested for the DCO.
- Link to v1: https://patch.msgid.link/20260817-bonding-last-rx-v1-1-9da6f7fdf812@well-founded.dev

---
Ramses de Norre (2):
      bonding: fix initial last_rx vs ARP-monitor slack window
      bonding: give a slave that starts UP a full arp_missed_max window

 drivers/net/bonding/bond_main.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)
---
base-commit: f75062536e2d45ee182828f0e47e0124be2fdc8d
change-id: 20260817-bonding-last-rx-0303fa048f9d

Best regards,
--  
Ramses de Norre <ramses@well-founded.dev>


