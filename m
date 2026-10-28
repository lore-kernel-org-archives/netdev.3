Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188092;
	b=UCh7K/mGbg4OzLeg628Z9Mri4gkVc5HqEbdIcKM3WOoR8ko/9aaWPP03gDgqnDvX44OR
	 5uT8aPJvmudfBteQ4AN10O6wvpOETY2lti6O+EWNB7dnkoxB/YMzueMqtb4wdWlrUZcPW
	 JBC9H6TiohUwUkxiUTMy/GBLUv3tYAeMwPhUu2k2a9lRi4YhIo+l/vTAwBQZ5JsfTgtAt
	 O0aX0aXxu1FGKtu2BBTJZfEpRKHFiWKqwNg3RxNjvdhpgPd9tdeD/dTSi6WKb5HGF0hXq
	 ByOjqA8HgWZmD7zCN76nBnFzEEwjDkcHGjftANnmZOVrQ7AzjM9j2ACrkjB+DRiJ98A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188092;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XhC2imG05+2RFrqn7oAIJ8gmety7mulQdSdn3ejKh9I=;
	b=1GsCA3l2z22JNVTtUjEVwM55+DDcjtaFgR3kt6dBBC0VM/Rh2cYxupb54Tm+TVciPcEW
	 +LrGMKF13Ibk8hy9Smf+Lidwk0xu9n0JLQZMMn2sfc/7e4UA9UAppjC49jtDarsbjgh9K
	 xr1WSw9OHEdwDQ8EqFKIWfEwnm3fPAtQpjDEMk3x6fIrRlIKx4kvnK14VmGFGaJFfQJFL
	 /CyASXS/GSfzLi8W25RSPcZdCuz4ckr06mmNYrdYBwOSC2LIturqPhPoCKL205THMrplf
	 whG89TsjaMrX3XQjPobGgT1BRN6a2USTix0reM08H/X+Z99V3VNU91TGDQagCWT1CZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKwyW3Y8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B92606A321;
	Wed, 28 Oct 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKwyW3Y8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793188091;
	b=SRYxB0vOjFmzgz39kk2T5pw99sRt9jg58YR88Tw8BT2+dEebx+YJhuciYvIUcUCkaj86
	 bADHdqOXGYe1eGBMlMnCAq4+ii4a4UNuPIpzafHqg8S5zaVaY4g4rbk4lNygsRk/JHkt8
	 MyU7GCWqMrAcaWDYytYtaxtZ6y8xjU3i5323X+GSBBdlUk2eQXgQK8/AUf3DJQm0afMP3
	 N/cR1jo4V91nWPZYah1EmZJQTiWtEGNZcgcR3g5txlH8ur1Wq3GX9W6uJhwNHU0/7acvo
	 bRc+j4Q4WvbgMuUGX/y5gvNMQD64Wrz683gQLYPN74mTWEbL+jkOsPl4/tudoymd9mw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793188091;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XhC2imG05+2RFrqn7oAIJ8gmety7mulQdSdn3ejKh9I=;
	b=cn11PiEc9KcaCG55RvXnhdJm1g3W8TYELDw+GZciTxV3JiEMlwrAijcv/opymHboK1S7
	 Y370ig/ZUO68gvjgn3d6i5VxP8urQK+mQPGJ+iKZQ8S3Zr6B9ns/qqO+URHp8cqMtp8QP
	 RbT6mdx2J9WXnzhP6XHdNTJ5mG4rpvLCC50TGqlimuK0cwu8tC2TDXG9ZE1CsZhJ3ewL5
	 JzGgoUmY01GELrvXSI7B+Ib6Xb3PjYT6zOXUxKOgfEQajO/BJiOGc4b+7CJAu50Pph0WO
	 /KtqjBVjXD2B66/6NSBObDRoFgeeEeos/ilrYZmBfMcveaGSsagt80+TV1w6/NdDvKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E049F1F031E4;
	Wed, 28 Oct 2026 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188091;
	bh=XhC2imG05+2RFrqn7oAIJ8gmety7mulQdSdn3ejKh9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TKwyW3Y8w8pCwTlBKKR9kWwjSQXsUjFBjeyKGEi7i+flP9peILQE+ugqGDaXzUj0H
	 MShANFhLjeYm8Ymn0vALrA/M3p8dq7UPrhqJdXNUoXr5oHcY6QunFTps7IcVGAiQyu
	 lV4a/4eMrHUfwA0JvRjGEOhdWP2S0Id+Vmsp/Zrz+u+4uWAIHtffS9tc8XIxthA7G7
	 rAxXtKbqCikOAcGD+LSgg9bgcBz82l4QIPTaq75j7pT6NNiOjaAJYZDOOpJ+oM7Fs5
	 QKOKB9gsf15U2AN47VcU4nVXSl8n/zb+so/+SSzgWpzBn76oMyM/Q3G+fsPdeIiiBu
	 cGsERz/oXodbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4A0D745437;
	Wed, 28 Oct 2026 11:48:10 +0000 (UTC)
From: Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
Date: Wed, 28 Oct 2026 12:48:07 +0100
Subject: [PATCH net v4 1/2] bonding: fix initial last_rx vs ARP-monitor
 slack window
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
Message-Id: <20261028-bonding-last-rx-v4-1-4d8e4cd47467@well-founded.dev>
References: <20261028-bonding-last-rx-v4-0-4d8e4cd47467@well-founded.dev>
In-Reply-To: <20261028-bonding-last-rx-v4-0-4d8e4cd47467@well-founded.dev>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Hangbin Liu <hangbin.liu@linux.dev>, 
 Ramses de Norre <ramses@well-founded.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793188089; l=3973;
 i=ramses@well-founded.dev; s=20260817; h=from:subject:message-id;
 bh=0sZ4MeprU+UjQ+ei1h7UCE9FsfSS+q+//+ci1EBUfME=;
 b=8F2HTzxYqJFk3Ptbk2N9b9sC/FBn7L4AXqh8iCDVeoENvkJ+dgtW8pOMShlqvSMzszFjUYJXl
 8do8yaV4Nn5ABEkgAFPwR37QtSApv9pqhSvV4H2mPClexXSuZFyM6pH
X-Developer-Key: i=ramses@well-founded.dev; a=ed25519;
 pk=1vBXHBVeJBMaC+2Zuonl0QQhEgGIQHERyF5RZNnrCmw=
X-Endpoint-Received: by B4 Relay for ramses@well-founded.dev/20260817 with
 auth_id=957
X-Original-From: Ramses de Norre <ramses@well-founded.dev>
Reply-To: ramses@well-founded.dev
Content-Transfer-Encoding: 7bit

From: Ramses de Norre <ramses@well-founded.dev>

bond_enslave() seeds a new slave's last_rx so that the ARP monitor does
not report it UP before a real ARP reply arrives, see commit
f31c7937c254 ("bonding: start slaves with link down for ARP monitor").

The seed is one arp_interval (plus a tick) in the past. That was old
enough when the up test was "jiffies <= last_rx + arp_interval". Commit
da210f559019 ("bonding: add some slack to arp monitoring time limits")
added arp_interval/2 of slack to that test without moving the seed, so
the seed now falls inside the up window. For the first half interval
after enslavement, bond_ab_arp_inspect() proposes a slave that starts
DOWN as UP although it has received nothing. The up test always uses a
single interval, so this does not depend on primary_reselect or
arp_missed_max.

If that slave is the configured primary, force_primary makes it the
active slave. ARP validation fails it shortly after (on SFP+ ports the
PHY is often still negotiating) and the bond falls back to the backup.
With primary_reselect=always the bond recovers once the port really
comes up, but drops traffic until then. With primary_reselect=failure,
force_primary is spent and the bond stays on the backup.

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

Move the seed below the initial link state and seed a slave that starts
DOWN two intervals in the past, outside the up window. A slave that
starts UP keeps its current seed: the up test does not apply to it, and
an older seed would only bring its down deadline forward by one
interval. The initial link state is unchanged.

Fixes: da210f559019 ("bonding: add some slack to arp monitoring time limits")
Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
---
 drivers/net/bonding/bond_main.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7019e5d8fdc8e..bfa4cb97e647c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2122,13 +2122,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	if (res && bond_needs_speed_duplex(bond))
 		new_slave->link = BOND_LINK_DOWN;
 
-	new_slave->last_rx = jiffies -
-		(msecs_to_jiffies(bond->params.arp_interval) + 1);
-	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
-		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
-
-	new_slave->last_tx = new_slave->last_rx;
-
 	/* check for initial state */
 	new_slave->link = BOND_LINK_NOCHANGE;
 	if (bond->params.miimon) {
@@ -2159,6 +2152,22 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 
 	if (new_slave->link != BOND_LINK_DOWN)
 		new_slave->last_link_up = jiffies;
+
+	/* The ARP monitor's up test includes arp_interval/2 of slack, see
+	 * bond_time_in_interval(). Seed a slave that starts DOWN outside
+	 * that window, so it stays DOWN until a real reply arrives.
+	 */
+	if (new_slave->link == BOND_LINK_DOWN)
+		new_slave->last_rx = jiffies -
+			(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
+	else
+		new_slave->last_rx = jiffies -
+			(msecs_to_jiffies(bond->params.arp_interval) + 1);
+	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
+		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
+
+	new_slave->last_tx = new_slave->last_rx;
+
 	slave_dbg(bond_dev, slave_dev, "Initial state of slave is BOND_LINK_%s\n",
 		  new_slave->link == BOND_LINK_DOWN ? "DOWN" :
 		  (new_slave->link == BOND_LINK_UP ? "UP" : "BACK"));

-- 
2.56.0


