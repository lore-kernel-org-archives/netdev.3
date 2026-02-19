Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937933F38A
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511071; cv=none; b=l5AiAc8/cNmaFODhlieok3x5ldeVwv2DbHsuWffUE3314HLanDec1b0dwQ/P21GkOw1DjzOQvY0YpIoRFRjHJ6Wu87UAQGbvYuEAXLSIEI8cwlh7RXeOzcNDEWnuJDBU3tvbkyJi1CncOSGZWa+OmZa3fRa6eahCGqBb+W4Tf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511071; c=relaxed/simple;
	bh=NGlB444E1/tA7snBo6G6SRwWejIJL1+untrgaCpIqVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NjqG6AyDW+sSBmvL1w7NLeiGI+FDn23UOgqSLxHmucu4J1v3i9OcNcV+60e5haXHhF7cJCl4q6HP7vfXar7IbUNF2pMqs8MMQ5IAvzlZrfoVy8xyMYcyZl6Gd8OheG+edjmH+yj3iPuI7WYea8Pl8aBInuvRuW6z+hoaZjRFEf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYxVU3Zq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYxVU3Zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B678C2BC86;
	Thu, 19 Feb 2026 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771511071;
	bh=NGlB444E1/tA7snBo6G6SRwWejIJL1+untrgaCpIqVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KYxVU3Zqfe0pUgIrKtrv+7XGOcjkZnXGXco4EyrHZOVx5iJ71tlzKLV+JPGcpKitQ
	 SxMMf8WDe78P444KTGgSsz6rEBD5DYlJ+memUnwFXbch4BYxhK0ZUtyfcOKQOFub8q
	 axo7SU3N+KXEbL24QiNhqApEP4iv/KAXnA3mi/7/NTAkfoHcyVpU9NP8veXEj8tSt9
	 cr8WLNtWH3f8abkr7NmTkyfNpUO6B6CzGl/lrU22Dll8k9EWzdn0roKQcMXPrOeivO
	 k5yOois63KuwL+KTjWXmCkakXlBOcqyrlfnJCOKVqM2UYmLQ/iiTlCYBheYijqZZhe
	 sSvFWGizht5TQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 15:24:20 +0100
Subject: [PATCH net v3 4/5] net: dsa: ks8995: Add stub bridge join/leave
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-ks8995-fixups-v3-4-a7fc63fe1916@kernel.org>
References: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
In-Reply-To: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
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

