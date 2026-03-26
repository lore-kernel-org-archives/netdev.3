Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931263BFE2A
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519066; cv=none; b=NwUH3rKRdJxeRkbRGkeqHt3mvcZe45q+prcah+u3Us2ZuQB4liA7fTv10/atpT9lOPXiVitZpE4/BRe5LprLzufICt4wkFUVh/Kxq3gEE7rtv0Z126PI1bEwuwWcUYxKuZ8pzcH3vlynqHj0A7wQ2FtofPP2lrOpOY4g7EpvqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519066; c=relaxed/simple;
	bh=NGlB444E1/tA7snBo6G6SRwWejIJL1+untrgaCpIqVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gq7xS6Q2vSPvcKim4GY6xE2j08eRNnhNl9EQen3fGbwGMWlaC3+bMhc4Y9ADokShvn+POOD3puE5FCVSUUk1UIMsJhyh8Yvq8A2UKIPJQMFfFeeG5op5GCHOpzQCortTrypw97gfGg9MI8s1J0+pZIC/LeNrqoTZPu2UJqHFgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSnwpab4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSnwpab4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C6EC19423;
	Thu, 26 Mar 2026 09:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774519065;
	bh=NGlB444E1/tA7snBo6G6SRwWejIJL1+untrgaCpIqVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSnwpab46OEoM2BSEbUaLAYDakQPyhY4EGZKhCBTS4ukgCWfNeLmtnZk8pv3kHO6t
	 W+WCf1/R+jZmFXcEbQAGMjPpDX8W0oXfG7agP38eDCqxusQIBomDTiqyuYfGU+XGO8
	 Utytr7179109xT2/oMztPlQYDylK5cP7rDSZ5DVEEYuhBWDemFy7jX9RJ9fJQAKHIY
	 TDIJ1AKUSwHVccp8mWPkMY3HwhURZnnzmfl+tHmdHrLTQ7O/4+fhV5AgP38/0QiiPb
	 Td4awvBdp4M1M1BNpOV2lA072M+l/oxxpL7dtl0nOqZr1TvOOlMaR5Wkqza5NAicI4
	 fxJyMvlvyn+7A==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Mar 2026 10:57:35 +0100
Subject: [PATCH net v4 4/4] net: dsa: ks8995: Add stub bridge join/leave
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-ks8995-fixups-v4-4-989abba8f077@kernel.org>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
In-Reply-To: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Implementing ks8995_port_pre_bridge_flags() and
ks8995_port_bridge_flags() without port_bridge_join()
is a no-op.

This adds stubs for bridge join/leave callbacks following
the pattern of drivers/net/dsa/microchip/ksz_common.c:
as we have STP callbacks and these will be called right
after bridge join/leave these will take care of the
job of setting up the learning which is all we support.

Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/ks8995.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index b7c9de39f68e..1ed81a8f7d21 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -461,6 +461,26 @@ static void ks8995_port_disable(struct dsa_switch *ds, int port)
 	dev_dbg(ks->dev, "disable port %d\n", port);
 }
 
+static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge,
+				   bool *tx_fwd_offload,
+				   struct netlink_ext_ack *extack)
+{
+	/* port_stp_state_set() will be called after to put the port in
+	 * appropriate state so there is no need to do anything.
+	 */
+
+	return 0;
+}
+
+static void ks8995_port_bridge_leave(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge)
+{
+	/* port_stp_state_set() will be called after to put the port in
+	 * forwarding state so there is no need to do anything.
+	 */
+}
+
 static int ks8995_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 					struct switchdev_brport_flags flags,
 					struct netlink_ext_ack *extack)
@@ -635,6 +655,8 @@ static int ks8995_get_max_mtu(struct dsa_switch *ds, int port)
 static const struct dsa_switch_ops ks8995_ds_ops = {
 	.get_tag_protocol = ks8995_get_tag_protocol,
 	.setup = ks8995_setup,
+	.port_bridge_join = ks8995_port_bridge_join,
+	.port_bridge_leave = ks8995_port_bridge_leave,
 	.port_pre_bridge_flags = ks8995_port_pre_bridge_flags,
 	.port_bridge_flags = ks8995_port_bridge_flags,
 	.port_enable = ks8995_port_enable,

-- 
2.53.0

