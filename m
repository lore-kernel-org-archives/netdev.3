Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392205;
	b=hlUBOwIn4p8A7rHy8X9u2yjPYg+tcbmi9Bx1IaX/EMSmv1UstGbdGz78Ise9ZRYO+b1G
	 fsxNVwCjHIOD5nYAP7wZJdn0IRKh3IZFYLUh2SQjFhPq4xX7/Vpv+KNmEUp6Bt3daHgDz
	 MLZx2roxK1xJq+cqSNbNfGMHcMPbNYmvUuqwLtZZGxKBvg/3QoZySXWhBdFaME29A3ozS
	 z1dxn1nBWOMdliBv9+GQhosUTF6FpKDIt8ha1bndX2jVQrjyvjrdKocqwsuHax5GsropN
	 wfg6UlcaJOLKIvZojCJzKcORtU2fnTHipb/HOYYQr6Jg7WjOHPNgJam1DgjPFwfKZ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Om/5IiGJG0h0TeeUfUUaZ5sQOSMXoNLOpVEVG+OHfZw=;
	b=szd4P4OLCWB2TdHh4VcaBKwExsFhSp9FCik3z90QZ+fISzE0HexByiUK2/4yU0D35z1w
	 UVJlkY9Pvx3mD9vAA5g0xlX/gJJ0yf4ZxO8PbWMwgGxO1Heod90ZSanQvaDX2N0geH5bM
	 0GBHZpymtgBfRDz6f7yMDyHz1+zEU/NJfUgzG28X8C1Z1REKgmpH0Je7Oivw403kcA8Ws
	 +w7wihw/5/rfPNyP8X+SDI3g9NRkX4dLKvSh9iU42NGkj6u4qwHlJhEh+UvF8yZ6RbsmH
	 6/3rpXb21BOaaron4YdRavok7DQhr/n1ea8DcBGdtWiA5/0IS9cQyNC6hmjWVzU6HQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9WcYw9H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA4606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9WcYw9H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EEF1F00A05;
	Wed, 11 Nov 2026 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392205;
	bh=Om/5IiGJG0h0TeeUfUUaZ5sQOSMXoNLOpVEVG+OHfZw=;
	h=From:To:Cc:Subject:Date;
	b=j9WcYw9HGXPYd05RWNU+GOjTK3QqG5Mt3m1fbC5IxuihWF3yiyN9fxZEq30Kcm9o6
	 +sbo2jqQD8V0e8zroU1CBPnIOerdyT3EpXNuuUyc5I4maOR4I0VkMnjn58Dc7+ha1R
	 fv7hnnJaB0bfWjggIAC5A6ONkwyPTFRhJjjnY6l+rHwlPBhhpzGC4Ym7MH0v1aVXj7
	 jr6hWU5KuF/iLNVEifHsJ/USOH57Fvpv9HtsnllmMPjf9hUaL4ouAv+yYpJOYstWl7
	 uddlAJGmFvcnO1kEnokC3lclFlPcAcoy4X4JIHI29et0227TD8F5vz2nYw0UvLpl+N
	 E7KRPlTlZIj2w==
From: Imre Kaloz <kaloz@kernel.org>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Elad Nachman <enachman@marvell.com>,
	Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Subject: [PATCH net] net: marvell: prestera: disable port before changing its MAC mode
Date: Wed, 11 Nov 2026 11:15:21 +0100
Message-ID: <20261111101521.9878-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prestera_pcs_config() writes a new mode or inband setting to a port
that is already enabled, as when phylink switches an SFP port to
inband SGMII. The firmware can then report link down and no link up
until the port is disabled and enabled again.

Disable the port before such a write. Exercising this needs a link
partner, so no in-tree test covers it.

Fixes: 52323ef75414 ("net: marvell: prestera: add phylink support")
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 .../net/ethernet/marvell/prestera/prestera_main.c  | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index a82e7a8029851..39ebd1944be55 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -307,13 +307,14 @@ static int prestera_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 			       bool permit_pause_to_mac)
 {
 	struct prestera_port *port = prestera_pcs_to_port(pcs);
-	struct prestera_port_mac_config cfg_mac;
+	struct prestera_port_mac_config cfg_mac, old;
 	int err;
 
 	err = prestera_port_cfg_mac_read(port, &cfg_mac);
 	if (err)
 		return err;
 
+	old = cfg_mac;
 	cfg_mac.admin = true;
 	cfg_mac.fec = PRESTERA_PORT_FEC_OFF;
 	cfg_mac.inband = neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
@@ -339,6 +340,17 @@ static int prestera_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		break;
 	}
 
+	/* Firmware may not report link up after the mode or inband setting of
+	 * an enabled port changes until the port is disabled and re-enabled.
+	 */
+	if (old.admin && (old.mode != cfg_mac.mode ||
+			  old.inband != cfg_mac.inband)) {
+		old.admin = false;
+		err = prestera_port_cfg_mac_write(port, &old);
+		if (err)
+			return err;
+	}
+
 	err = prestera_port_cfg_mac_write(port, &cfg_mac);
 	if (err)
 		return err;
-- 
2.47.3

