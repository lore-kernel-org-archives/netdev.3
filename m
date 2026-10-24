Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792862116;
	b=RVDFvZBb2GOXCSKTZqenzhpKHdHeMWv6ED4GqXoWqE5pt3W0SLfOBl3ihYRPdW4JWZIr
	 rR6FMLCsNYQmlki0fRpBL4eimqTYRxNY8JAq8Y6k8GucQYQkZXcc2UZ/mJ+b9o0APjH/Z
	 PzkI2WD4x7zw/4aKyzIseQO6jwVoUxiPaNk5m5CMUFGCJFIXmQ6W7TYyqMGnEVcxFfD8V
	 tb0CIwhHIFaNk3MgOuAFsmb5OkwtKLOJKHKYc4ndZK7tzmLYRuGRhDd4YmR5KIzR+0b/C
	 crcFFCWfd5Y96opySbG2z98ERy7Uk7cIb8xrY4hzmnyc+I9yz48OUDEiKw/NOYb9yBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862116;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1KqSa6aGjzQht+7aFFinvBHJH0XqPDZCmVDcbROTz3A=;
	b=aYtqlIYTSS1Lu33UGYBAs4elVxqFGI3jooLOHIUirCahuVO0/HclfvsWr55mtJtlGIns
	 976aiL1xkGPJb2/mftAfKWwRb3/F3Z8LrqVKTQ7jer6sHnnvvhl1Q803Y0d/OELXXMV4l
	 Tkwz4UUqcGLbErFVTJfZk3wzv8GL9StRnn7v2uxW77KTJHjMNvNwcsYx03ciYhegslEzk
	 wBZ751zkl9D2hEQeyQt4MMZ58+NHqM0GxxPcdmSlZ3KZxt0rvLqjEdFqBIEd1dm7Dj5i9
	 2qgSQOoqHZVurJhPKre5GxLueCpUMjbvOvKqRe/DqUpCDU+Hq1Z0fsP0mp5Z3+I97UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bArDxfwz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BD606A31F
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bArDxfwz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792862115;
	b=Q63forncUQyW6AWBruKd4lLGUZWhJ+pPzLSWWH9ShSSA/T5SnH21xTiGfBvfSF9B8Kye
	 2HSe6IOsEmSxPrArNxCb7rvvyoO5MNRbwHpuRTk474gU+IMPp4msNTv/GMVRr4Mzj+qLC
	 u7JmavMWYfyC6UcwEufemCZtfifawAXE+T+agjbvP0GXYyIlQQ4KOeMsoVbZEmMMaF88G
	 SZ1lX9GhDe+PIKNaqKs8nRdSdxj57ukzrPBao70W7rTtw6Woz4VgyU/uCQILZf8KPi7+k
	 a7yd4ArftWSlynctzeeeUMqvXAiHFnUTKZkRyDAh5vU5fTgHHBwbFX7T4zLIEZIhEYQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792862115;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1KqSa6aGjzQht+7aFFinvBHJH0XqPDZCmVDcbROTz3A=;
	b=0mF7DJyxynuG/GMWxFI8MajqdSMyNgefOcCD+rXJZ0lcKTeCEuJ3bF9ikcHPaIJihE1e
	 YEYcGc7bvA5HIUSh7fnYh9IYJFfQBya2aDwzmuU7QTUVCiKsQxBCWtQmyz9POA1vbUrfu
	 Fj135sAEJb4MjYpQT4rniM+vvyayRod0LQv4LIGXyfpcco4pnyyYjFOpJH7s8cvqjKkZd
	 aqTerQN4jvorKWqJpUwx2Bhn76jfnxqdOCEVNR19un3ioNFx45jh0yo6AEU7G2and/tKM
	 IGnpwROy80wlyceXUuD6M32DHICmu6mHSAn7HvOni9P4x1SBTFxe9UF0d54VVyGC2Mw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CE0681F01829;
	Sat, 24 Oct 2026 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792862115;
	bh=1KqSa6aGjzQht+7aFFinvBHJH0XqPDZCmVDcbROTz3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bArDxfwzcFHY9zFZ5ZhVDsok508TXNQU6u0zmj0O7SLsdd011TzQJnRa2ZCaikqI3
	 1Yk+1yJQg9rHKLHuP7kc/H3LTx0BYVpStEPwV4EAPeYM4ZF3ZckiwoFE8Gfdiore08
	 aq2nVk246RQ/eIq69gG2qn40VsqF6awmhK8qR4sZpz07PxarWi2DDRTDa4mzBCHyYs
	 Qgs7daR+JVHFC0E+oqjXXMoSWHFOnNu1PE8ICt7ndD5qHzz+YSCCg8Sd/Vj5YNYMul
	 9KBqn+R2Znb8+u6p4P0WcVd/L9xXvZeEDn8h01GrlqRB1muaRI4+Ocs7IeXFJHEKPZ
	 y2oSrldQcWkEQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C7074484E;
	Sat, 24 Oct 2026 17:15:14 +0000 (UTC)
From: Demos Ra via B4 Relay <devnull+demosthenes.ra.gmail.com@kernel.org>
Date: Sun, 25 Oct 2026 00:13:56 +0700
Subject: [PATCH net 2/2] tools: ynl: generate code for rt-nexthop bucket
 notifications
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
Message-Id: <20261025-ynl-ntf-bucket-v1-2-65aef308d62c@gmail.com>
References: <20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.com>
In-Reply-To: <20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Demos Ra <demosthenes.ra@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792862112; l=2406;
 i=demosthenes.ra@gmail.com; s=20261019; h=from:subject:message-id;
 bh=f9ZeZy+zDvDO+mRHxxqISmOxmWt4JRL0xxqUpwYYolE=;
 b=l1WcbvkG7HReRqUj4ESOIOZ0uD7zLVaEkRfCWkaD+a+ClbLZwSMqP3eNuiKF+BP4N1IiOPKxa
 U62kgpzh9vjBBeSNQx1vzvjHNxyUQc7t4vF6SXh8Njtgtn3aAV5otOV
X-Developer-Key: i=demosthenes.ra@gmail.com; a=ed25519;
 pk=sDKS9AI9zxhWgOqkhc9EOIo6cky+anqccB3VGtDvzCc=
X-Endpoint-Received: by B4 Relay for demosthenes.ra@gmail.com/20261019 with
 auth_id=1235
X-Original-From: Demos Ra <demosthenes.ra@gmail.com>
Reply-To: demosthenes.ra@gmail.com
Content-Transfer-Encoding: 7bit

From: Demos Ra <demosthenes.ra@gmail.com>

The kernel sends RTM_NEWNEXTHOPBUCKET to RTNLGRP_NEXTHOP when the
upkeep of a resilient nexthop group migrates a bucket. With
newnexthopbucket-ntf excluded from the code generation, the
notification table of the generated rt-nexthop code ends at
RTM_DELNEXTHOP. On a socket subscribed to the group, ynl_ntf_parse()
rejects the bucket notification without setting an error message, so
ynl_ntf_check() fails, and so does a request in flight when the
notification arrives, as ynl_check_alien() passes it to
ynl_ntf_parse() too.

ynl-gen can now generate the notification, so drop the exclusion.

Reproduced in a network namespace, with traffic through a resilient
group so that a weight change defers the bucket migrations to the
upkeep work:

  ip link add dummy0 type dummy && ip link set dummy0 up
  ip addr add 192.0.2.1/24 dev dummy0
  ip nexthop add id 1 via 192.0.2.2 dev dummy0
  ip nexthop add id 2 via 192.0.2.3 dev dummy0
  ip nexthop add id 10 group 1/2 type resilient buckets 8 idle_timer 1
  ip route add 198.51.100.0/24 nhid 10
  for i in $(seq 64); do echo > /dev/udp/198.51.100.$i/9; done
  ip nexthop replace id 10 group 1,3/2 type resilient

A C program that joins RTNLGRP_NEXTHOP by hand and then calls
ynl_ntf_check() or rt_nexthop_getnexthop() fails with an empty error
message before this patch, and parses the two bucket notifications
after it. The program is available on request. Reproducing it needed
no kernel changes. Tested on 7.0 with the reproducer and the YNL
selftests, which all pass.

Fixes: 457dc9fefe9a ("netlink: specs: Add a spec for nexthops in rtnetlink")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-rt-nexthop-spec-v1-1-9c586edf86ab%40gmail.com
Signed-off-by: Demos Ra <demosthenes.ra@gmail.com>
---
 tools/net/ynl/generated/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index d76d4ca94629..5a186349b5a8 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -18,7 +18,6 @@ include ../Makefile.deps
 
 YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 	--exclude-op stats-get
-YNL_GEN_ARG_rt-nexthop:=--exclude-op newnexthopbucket-ntf
 
 TOOL:=../pyynl/ynl_gen_c.py
 TOOL_RST:=../pyynl/ynl_gen_rst.py

-- 
2.53.0


