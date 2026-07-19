Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E313AEF3E;
	Sun, 19 Jul 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784483670; cv=none; b=JlPofhn2riXFWlnQGAZ8ClQamZ6NYcSxNQUv9h76xTwRShnmP7fAWmKbfdEUSV2Af5Mg5rI5yAk0RsJsMAE9yjFScq4kpD5CugtoXwarKBUOwjSrJHd2EZo+4GQcHhuk9jX+/Kw8COkdWLXry4c24AN99/qmG6B8E9jnYQEw/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784483670; c=relaxed/simple;
	bh=+UiFt1nZyadFtCPYm3cVyc5yA0922AQ+V4VAn7sLSrE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf981Dkb/iIfIoWWOG8LlvTJeSSK1cY0JHlZc3OBeVs2fSI0jE2/I/SFt78oIw7CqoZzcgmIXZanBlJnqI8nkB1mxXvD76kP0MoTlTrjfgOHGeTL0CxRoTPYr8EdGyXas44Kn+XThnw6lieZYCj6gNf8BIxcrTadqqntODubyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wlViZ-000000004s5-3kv4;
	Sun, 19 Jul 2026 17:54:23 +0000
Date: Sun, 19 Jul 2026 18:54:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v4 8/8] net: dsa: mt7530: implement
 port_change_conduit op
Message-ID: <14cd517349c7aa84138150bb496e079ec2291c28.1784481922.git.daniel@makrotopia.org>
References: <cover.1784481922.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784481922.git.daniel@makrotopia.org>

Allow changing the CPU port affinity of user ports at runtime via the
IFLA_DSA_CONDUIT netlink attribute. This updates the port matrix to
forward to the new CPU port instead of the old one.

Limit the operation to MT7531. There, trapped link-local frames follow
the per-port affinity, as the MT7531_CPU_PMAP destination mask is
further restricted by the port matrix. A conduit change is hence fully
honoured by the hardware, for regular traffic as well as for trapped
frames.

The MT7530 switch, including the variant embedded in the MT7621 SoC,
instead traps frames to the single CPU port set in the CPU_PORT field
of the MFC register, regardless of the affinity of the inbound user
port. With user ports affine to different CPU ports there is no
correct value for that field, so per-port CPU affinity cannot be fully
implemented for trapped frames. Routing a WAN port via the second SoC
GMAC is conventionally covered by the PHY muxing feature on these
switches, which bypasses the switch fabric and does not involve a CPU
port at all.

The switches on the MT7988, EN7581 and AN7583 SoCs only have a
single CPU port, leaving no other conduit to change to.

As the op lives in the shared mt7530_switch_ops, populate the extack
when rejecting the unsupported variants instead of returning a bare
-EOPNOTSUPP. Also reject a conduit that belongs to a different switch
in the tree, whose port index has no meaning in the local port matrix.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
---
v3:
 * populate the netlink extack on rejection
 * refuse a conduit that lives on a different switch

 drivers/net/dsa/mt7530.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 52b549d7ee22..6fe6783dfe3f 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3213,6 +3213,43 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt753x_port_change_conduit(struct dsa_switch *ds, int port,
+			   struct net_device *conduit,
+			   struct netlink_ext_ack *extack)
+{
+	struct dsa_port *new_cpu_dp = conduit->dsa_ptr;
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct mt7530_priv *priv = ds->priv;
+
+	if (priv->id != ID_MT7531) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Changing DSA conduit is only supported on MT7531");
+		return -EOPNOTSUPP;
+	}
+
+	if (new_cpu_dp->ds != ds) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot assign a conduit on a different switch");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* dp->cpu_dp still points to the old CPU port */
+	priv->ports[port].pm &= ~PCR_MATRIX(BIT(dp->cpu_dp->index));
+	priv->ports[port].pm |= PCR_MATRIX(BIT(new_cpu_dp->index));
+	if (priv->ports[port].enable)
+		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+				   PCR_MATRIX_MASK, priv->ports[port].pm);
+
+	mutex_unlock(&priv->reg_mutex);
+
+	mt7530_port_fast_age(ds, port);
+
+	return 0;
+}
+
 static void
 mt753x_conduit_state_change(struct dsa_switch *ds,
 			    const struct net_device *conduit,
@@ -3324,6 +3361,7 @@ static const struct dsa_switch_ops mt7530_switch_ops = {
 	.setup			= mt753x_setup,
 	.teardown		= mt753x_teardown,
 	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
+	.port_change_conduit	= mt753x_port_change_conduit,
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
-- 
2.55.0
