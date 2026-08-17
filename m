Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EF3C10AD;
	Mon, 17 Aug 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963659; cv=none; b=Ib2gS1ZOoveM3RrfXUkA/SIzWAPQKTf2oGBt8ZusGuSw+OAft+Nl//QVqp3BengO1z5aec6PwbG4m2VNxY1O2v9Wf6QYufwfVXxW46BF+q5z4jOL7/5KikNKR0snelr+Or9/JBdfEbYkQf1sY46u2XPA+C9afZ6yVp59tEpKt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963659; c=relaxed/simple;
	bh=ssL4bncxVbB9avtB5LrguL4+Pc3joQ9VEwpBIEAvM0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=edWD6ZcqpdPwbxeqDN1ZsuCNAShQsgXMTpIFJtKtDl9gU89eLVUrGSfkZyZ9/m8pUVa3bEbggBblCKsX/oScHS8hlN3n1nLMK3NEtzsd74lG8X7RiKSQUJZIRuSsZoWq1jakTxJZSzjaTPoqzGzCLZbGKYrXlLGNfTuObNGjq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZWxjRTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZWxjRTo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65F2AC2BCB3;
	Mon, 17 Aug 2026 10:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786963658;
	bh=ssL4bncxVbB9avtB5LrguL4+Pc3joQ9VEwpBIEAvM0M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZZWxjRToM22toZ3r9sy7Ok/3AJyvZx6DqOI2OslIn6XFbkhbQo4rX3H2sOFSbc7eC
	 +16p6NBxHGanZpvbQpxy7tIxuq3C/8pBDcBPAtnqobprpZRpQKHFWSAmqNFFXeVgjj
	 D+3mRJ0Z8RNKWbao4heRMKM5MDz7BnpteLvOO8cN43CXONBeS72hAP6zQKDQoR0fh4
	 q5J0NkxSxdd2QU+AyFl7ZqjWCcgIyLaTTR3wrcT/4JBvJFUpfpgrNCO+BPEgKTU2vF
	 cPdMgdBufAFWIF17CXJrgzawRh7pVhvcSsQv8gVEzWkx15Hzsws87MNOjwUCzLndLY
	 ZqY5MiXzos/ig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A8C5B572;
	Mon, 17 Aug 2026 10:47:38 +0000 (UTC)
From: r-vdp via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
Date: Mon, 17 Aug 2026 12:47:27 +0200
Subject: [PATCH net] bonding: fix initial last_rx vs ARP-monitor slack
 window
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-bonding-last-rx-v1-1-9da6f7fdf812@well-founded.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywqDQAwAf0VybiA+UNtfKT2sblYjJZbNtgjiv
 3dtjzMws4NxFDa4FTtE/ojJqhnKSwHj7HRiFJ8ZKqpa6ssOh1W96IRPZwnjhlRTHRw1fbh6yNU
 rcpDtd7yDcoLHX9p7WHhM5wuO4wuJB1H8eAAAAA==
X-Change-ID: 20260817-bonding-last-rx-0303fa048f9d
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Bohac <jbohac@suse.cz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 r-vdp <ramses@well-founded.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786963656; l=3004;
 i=ramses@well-founded.dev; s=20260817; h=from:subject:message-id;
 bh=YYy+ypt63v5I7wHvlfNPK/qM1ynNfjL53cV7Ib4dBmw=;
 b=cBGB/R1NCtGI6k5mJpJUEfBKPZoardmv+NkK578YfYTPVjl7QOogfNRwIkQZBnJQpg7MRNtUU
 c/hBbir+GCwA0VTeVTO2xneY1kv6PnSgox+V6RZV5Vt+yyPZh4kTvn9
X-Developer-Key: i=ramses@well-founded.dev; a=ed25519;
 pk=1vBXHBVeJBMaC+2Zuonl0QQhEgGIQHERyF5RZNnrCmw=
X-Endpoint-Received: by B4 Relay for ramses@well-founded.dev/20260817 with
 auth_id=957
X-Original-From: r-vdp <ramses@well-founded.dev>
Reply-To: ramses@well-founded.dev

From: r-vdp <ramses@well-founded.dev>

Commit f31c7937c254 ("bonding: start slaves with link down for ARP
monitor") initialises a freshly enslaved port's last_rx to
jiffies - (arp_interval + 1) so that it does not "immediately cause
fake detection of 'up' state". At the time, the comparison was a plain
<= arp_interval and the value was just stale enough.

Commit da210f559019 ("bonding: add some slack to arp monitoring time
limits"), four months later, added a +arp_interval/2 slack term to
every comparison (now bond_time_in_interval()) but did not widen the
init to match. Since then, bond_time_in_interval(bond, last_rx, 1) is
true for the first ~arp_interval/2 after enslavement even though no
packet has been received: the upper bound is last_rx + 1.5*delta and
last_rx was set to jiffies - delta - 1.

If the ARP monitor tick lands in that window, bond_ab_arp_inspect()
proposes the slave UP. If the slave is the configured primary,
bond_ab_arp_commit() sets do_failover and the still-armed
force_primary in bond_choose_primary_or_current() makes it the active
slave regardless of primary_reselect. ARP validation as the active
slave then fails (the link has not actually received anything; on
SFP+ ports the PHY is often still negotiating) and the bond falls back
to the backup. With primary_reselect=failure, force_primary has now
been spent and the bond stays on the backup until something else
triggers a reselect.

Reproducer:

  ip link add bond0 type bond mode active-backup arp_interval 1000 \
      arp_validate all arp_ip_target 192.0.2.1 \
      primary eth0 primary_reselect failure
  # eth0: SFP+ (slow link-up), eth1: RJ45 (fast link-up)
  ip link set eth0 master bond0
  ip link set eth1 master bond0
  ip link set bond0 up
  # bond0 lands on eth0 via force_primary, ARP-fails it before the
  # SFP+ has carrier, falls to eth1, and stays there.

Initialise last_rx (and the per-target array, and last_tx) to two full
intervals in the past so it is outside the slack window from the
start.

Fixes: da210f559019 ("bonding: add some slack to arp monitoring time limits")
Signed-off-by: r-vdp <ramses@well-founded.dev>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 522eab060f9ed..23e1544faf39f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2123,7 +2123,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		new_slave->link = BOND_LINK_DOWN;
 
 	new_slave->last_rx = jiffies -
-		(msecs_to_jiffies(bond->params.arp_interval) + 1);
+		(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
 		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
 

---
base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
change-id: 20260817-bonding-last-rx-0303fa048f9d

Best regards,
--  
r-vdp <ramses@well-founded.dev>


