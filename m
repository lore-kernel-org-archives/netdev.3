Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09463349AE0;
	Fri,  3 Jul 2026 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063617; cv=none; b=q/eb3FHd6XS85XiBpFzphuBcguGnqJTEoSJSSQvmq8bOTG+QiT57HL4n/mv2Mu1i16fv7jiF2cbCBfdoGusmcwnuJoYhvik8tvDyNZPkoiy39qEVXt+/Wi0GeGfXcJdgh+Kg04UgKehNGZSkTMCoGkyYOJf+ZozzwK2B77XbWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063617; c=relaxed/simple;
	bh=JYoPO7ChmXYe3qF5MzDL1kag86vwPT7ZEI+o+JZ/sw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cMyzbl5fGwfkyzDsoCRoXh630zj80ubNj7EOItT/f/Y9OZP+TKzMtQMzihw/hH8hk7ZNaJakFjeLSpDccaM6b+DjjYCn4/UqGvaHGMaYXHd2HuVnfNX+TTaovNJa1mTdlOJexlSmUQHcYJH1yeEDCIiJf0wFxAlZHMDnGyruC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=1XCUPWpV; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="1XCUPWpV"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 30EAF60C04;
	Fri,  3 Jul 2026 03:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063614; bh=lWE8CYW4KX/1B+EEE6sYZhC+xxA4cyLphddW4iM4wB0=;
	h=From:Date:Subject:To:Cc:From;
	b=1XCUPWpVahTWoi0VNqnPCy40g1HstAA9v2wZZm1PrCsB9h1gjDKcllJ3O8SCA+gm+
	 eKz/gDEuPamvXfxqvChQ3kRoLZ9OP26IBdGp7vYYygpUCEECwGqwqQUC/AUHtTaTKz
	 h2IqjL6JW0kuTplkKFjyC/X7GGux3oBgFSvESmmqebsJag+P4df7wdwFror+082kT4
	 i6j+KdBHyhA6tyExfXdR0kkiBSSqu+efQz23twRWpnUCA/RFG9PPUn9qxbHdEyEYkj
	 KK5aZ8RVBSNZ7OQRqbyFVsPHirCRH+13dUOnV4V4ClM6nbO4vc9P21ohsRg33YvW/i
	 sv4QPUY5HyPSg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:26:43 +1000
Subject: [PATCH RFC net-next] net: dsa: mv88e6xxx: honor resolved flow
 control in mac_link_up
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mv88e6xxx-flow-control-v1-1-5e7e2f577b93@padl.com>
X-B4-Tracking: v=1; b=H4sIADJkR2oC/yWMQQrCMBBFr1Jm7UCSYlvcCh7ArXRR40QjdSJJb
 AdK726qy/f57y2QKHpKcKgWiDT55AMX0LsK7GPgO6G/FQajTKNapfE1dR01IoJuDDPawDmGEe3
 gqDb13rTaQJHfkZyXX/gC59Nx25gyMkmG/n9In+uTbN7ysK5ffuhp/osAAAA=
X-Change-ID: 20260701-mv88e6xxx-flow-control-cafe32352712
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063610; l=3874;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=JYoPO7ChmXYe3qF5MzDL1kag86vwPT7ZEI+o+JZ/sw0=;
 b=p4x9cRF5M6q6m3Lqh0lIcrPpseCIDdm28y3EPFu+9MATNgkjxn5Oe9hc2FgXZX5Wa/hzzRYxx
 H7LBZXP40LmAmIV3xnPvirYELNwcZj7mCiLoGMNh35ZQACCswnRv7dy
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Program the pause status resolved by phylink into the Port MAC
Control register when forcing the link up, and return flow control
to hardware resolution when forcing the link down, mirroring the
existing treatment of speed and duplex.

Flow control is programmed before port_sync_link() so that the
port's MAC control is not modified while the link is forced up.
The MAC has a single flow control enable covering both directions;
as the driver only advertises MAC_SYM_PAUSE, rx_pause and tx_pause
are always equal here.

A fixed-link port whose device tree node lacks the "pause" property
now has flow control explicitly disabled while the link is forced
up, rather than being left at the chip's default.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  9 +++++++++
 drivers/net/dsa/mv88e6xxx/port.c | 20 ++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..73c28bf2bf3cb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -974,6 +974,10 @@ static void mv88e6xxx_mac_link_down(struct phylink_config *config,
 	     mode == MLO_AN_FIXED) && ops->port_sync_link)
 		err = ops->port_sync_link(chip, port, mode, false);
 
+	if (!err)
+		err = mv88e6xxx_port_set_force_flow_ctl(chip, port, false,
+							false);
+
 	if (!err && ops->port_set_speed_duplex)
 		err = ops->port_set_speed_duplex(chip, port, SPEED_UNFORCED,
 						 DUPLEX_UNFORCED);
@@ -1012,6 +1016,11 @@ static void mv88e6xxx_mac_link_up(struct phylink_config *config,
 				goto error;
 		}
 
+		err = mv88e6xxx_port_set_force_flow_ctl(chip, port, true,
+							rx_pause);
+		if (err)
+			goto error;
+
 		if (ops->port_sync_link)
 			err = ops->port_sync_link(chip, port, mode, true);
 	}
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index ea1fab71968a0..7ee802cf3412c 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -182,6 +182,26 @@ int mv88e6xxx_port_set_link(struct mv88e6xxx_chip *chip, int port, int link)
 	return 0;
 }
 
+int mv88e6xxx_port_set_force_flow_ctl(struct mv88e6xxx_chip *chip, int port,
+				      bool force, bool value)
+{
+	u16 reg;
+	int err;
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_MAC_CTL, &reg);
+	if (err)
+		return err;
+
+	reg &= ~(MV88E6XXX_PORT_MAC_CTL_FORCE_FC | MV88E6XXX_PORT_MAC_CTL_FC);
+	if (force) {
+		reg |= MV88E6XXX_PORT_MAC_CTL_FORCE_FC;
+		if (value)
+			reg |= MV88E6XXX_PORT_MAC_CTL_FC;
+	}
+
+	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_MAC_CTL, reg);
+}
+
 int mv88e6xxx_port_sync_link(struct mv88e6xxx_chip *chip, int port, unsigned int mode, bool isup)
 {
 	const struct mv88e6xxx_ops *ops = chip->info->ops;
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 5b6cde9f7406f..f98df6351f5b7 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -485,6 +485,8 @@ int mv88e6390_port_set_rgmii_delay(struct mv88e6xxx_chip *chip, int port,
 				   phy_interface_t mode);
 
 int mv88e6xxx_port_set_link(struct mv88e6xxx_chip *chip, int port, int link);
+int mv88e6xxx_port_set_force_flow_ctl(struct mv88e6xxx_chip *chip, int port,
+				      bool force, bool value);
 
 int mv88e6xxx_port_sync_link(struct mv88e6xxx_chip *chip, int port, unsigned int mode, bool isup);
 int mv88e6185_port_sync_link(struct mv88e6xxx_chip *chip, int port, unsigned int mode, bool isup);

---
base-commit: 2bb62a85aff6d4c14a62a476dfabaada3c1cc014
change-id: 20260701-mv88e6xxx-flow-control-cafe32352712

Best regards,
--  
Luke Howard <lukeh@padl.com>

