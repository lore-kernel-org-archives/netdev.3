Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69428B4E2;
	Sat, 19 Sep 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847528; cv=none; b=Wh7Z/DVf6NwLCvwYvig/dPGsOmpKNcHqAS5yTf2z0XqJ0IiDwd6ppMVFENIU6ZGkKMeAYwy3jq85iCPrbY/mnTinG3QkvxDWrEv51ufk/or3NUMNAY0229rZczPr2CW9okHh1D8HhGjfx2uQYwM9jQ2FPCHvPNIznxa+l4tqAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847528; c=relaxed/simple;
	bh=UdvNW9CpQT7IK6dnytR92a9xtlB2N2AO8AUh3oGnVO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XNY10/s+UgLie55ok6ibsr4Kk7Eg6kHip0GBvMRw4cVas8alydU7AzcpZv4koqmpLpceWLXNTGFb3lDLFkx3qFg0ch8NjjVVtdxiQFuIi5hp5Oz+r4IDEZSqw9IgitO0RcF5l9KthfbRTdUYQMbb3KmkEtePSMZWXeyFUeDH94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONLPz5xs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONLPz5xs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DCE8C2BCB9;
	Sat, 19 Sep 2026 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789847528;
	bh=UdvNW9CpQT7IK6dnytR92a9xtlB2N2AO8AUh3oGnVO8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ONLPz5xsBFEAJeKb0JylrQwdjXHIQSJiK93LMmQm2MpUMjsZx9S0LmlgSkzdy5PiL
	 AJTZ+gbq80Y6hiC/pIM2vJo3R5mKzBnstNhk9FiYbcaGc/8eLC9wnjMh2cAPCIP8VI
	 X98XMQKdS7ApqskxIc368a+0RD4oN+QNVvc/scPq0a7DxmHunU7JWx5lkedJ+PN2Ht
	 K+AVWxliafn11vz85OgDf5gBwpMc+pHMxKIbecB+GGdrAm2cKZSbq78P0/PMhmsIHr
	 w+FlfmBVhsCVErpX04MBuD0MWOqAIKkfz7z2pq3x4r5SxVaFZo66120Zvao8/M6CA/
	 ZxeiovTq+ofZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29003C982D8;
	Sat, 19 Sep 2026 19:52:08 +0000 (UTC)
From: Nicolo Giuliani via B4 Relay <devnull+nicolo.giuliani6.studio.unibo.it@kernel.org>
Date: Sat, 19 Sep 2026 21:52:07 +0200
Subject: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the TAI
 period is invalid
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-send-net-v1-1-4355c72465ee@studio.unibo.it>
X-B4-Tracking: v=1; b=H4sIAObnrmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0NL3eLUvBTdvNQSXUvzxERTM1PjxGQTCyWg8oKi1LTMCrBR0UpABUq
 xEMHi0qSs1OQSkCFKtbUAyPl0X3EAAAA=
X-Change-ID: 20260919-send-net-97aa5653ac48
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789847526; l=4280;
 i=nicolo.giuliani6@studio.unibo.it; s=20260919; h=from:subject:message-id;
 bh=haUUtbJie+EjEYk90JGwrIsIrQgUGbrvgziB9gbyIW8=;
 b=w2vPGeC+6ZP61hNrUcRrizJlSyJkisrIAWxRnyt4sEGyBEd1yu7TE44TpkQUqvxoO0xNImE6d
 /TqD/ni2PcgDxJKKdVPAppiC4HUJpLUGoSYZRanQwUF5LS9uHunMH1v
X-Developer-Key: i=nicolo.giuliani6@studio.unibo.it; a=ed25519;
 pk=D652ecdT01GkA1eoFWNFNX85xIg5ZnFwUWyjfestgQw=
X-Endpoint-Received: by B4 Relay for
 nicolo.giuliani6@studio.unibo.it/20260919 with auth_id=1040
X-Original-From: Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>
Reply-To: nicolo.giuliani6@studio.unibo.it

From: Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>

Since commit 7e3c18097a70 ("net: dsa: mv88e6xxx: read cycle counter
period from hardware"), mv88e6xxx_ptp_setup() reads the TAI clock period
register and fails with -ENODEV if the value is not one of the supported
periods. mv88e6xxx_setup() propagates the error, so the switch does not
probe at all, although it is fully usable without PTP. Before that commit
the register was not read and the probe did not depend on its value.

The 88E6193X on the Sophos XGS 107w reads 0 in that register, so its
probe fails with:

  mv88e6xxx ...: unexpected cycle counter period of 0 ps

Treat -ENODEV from mv88e6xxx_ptp_setup() as the absence of a usable PTP
clock: warn, skip the hardware timestamping setup and carry on without
registering a PHC. -ENODEV can only come from mv88e6xxx_cc_coeff_get(),
which runs before ptp_setup changes any state, so there is nothing to
undo, and all other errors still fail the probe.

Without a PHC chip->ptp_clock stays NULL, and the timestamping entry
points dereference it (ptp_clock_index() in get_ts_info,
ptp_schedule_worker() in the rx and tx paths). Make get_ts_info,
port_hwtstamp_set/get and mv88e6xxx_should_tstamp() treat a missing
clock like a chip without ptp_support. Switches that register a PHC are
unaffected.

Fixes: 7e3c18097a70 ("net: dsa: mv88e6xxx: read cycle counter period from hardware")
Assisted-by: LLM
Signed-off-by: Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>
---
 drivers/net/dsa/mv88e6xxx/chip.c     | 19 ++++++++++++++-----
 drivers/net/dsa/mv88e6xxx/hwtstamp.c |  8 ++++----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 7f68a0c55..2d6de43f2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4106,12 +4106,21 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	/* Setup PTP Hardware Clock and timestamping */
 	if (chip->info->ptp_support) {
 		err = mv88e6xxx_ptp_setup(chip);
-		if (err)
-			goto unlock;
-
-		err = mv88e6xxx_hwtstamp_setup(chip);
-		if (err)
+		if (err == -ENODEV) {
+			/* The TAI clock period is not one that the driver
+			 * supports: run the switch without PTP rather than
+			 * failing the whole probe.
+			 */
+			dev_warn(chip->dev,
+				 "PTP clock unavailable, hardware timestamping disabled\n");
+			err = 0;
+		} else if (err) {
 			goto unlock;
+		} else {
+			err = mv88e6xxx_hwtstamp_setup(chip);
+			if (err)
+				goto unlock;
+		}
 	}
 
 	err = mv88e6xxx_stats_setup(chip);
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 6e6472a3b..847f9dd44 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -72,7 +72,7 @@ int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 	chip = ds->priv;
 	ptp_ops = chip->info->ops->ptp_ops;
 
-	if (!chip->info->ptp_support)
+	if (!chip->info->ptp_support || !chip->ptp_clock)
 		return -EOPNOTSUPP;
 
 	info->so_timestamping =
@@ -176,7 +176,7 @@ int mv88e6xxx_port_hwtstamp_set(struct dsa_switch *ds, int port,
 	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
 	int err;
 
-	if (!chip->info->ptp_support)
+	if (!chip->info->ptp_support || !chip->ptp_clock)
 		return -EOPNOTSUPP;
 
 	err = mv88e6xxx_set_hwtstamp_config(chip, port, config);
@@ -195,7 +195,7 @@ int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
 	struct mv88e6xxx_chip *chip = ds->priv;
 	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
 
-	if (!chip->info->ptp_support)
+	if (!chip->info->ptp_support || !chip->ptp_clock)
 		return -EOPNOTSUPP;
 
 	*config = ps->tstamp_config;
@@ -213,7 +213,7 @@ static struct ptp_header *mv88e6xxx_should_tstamp(struct mv88e6xxx_chip *chip,
 	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
 	struct ptp_header *hdr;
 
-	if (!chip->info->ptp_support)
+	if (!chip->info->ptp_support || !chip->ptp_clock)
 		return NULL;
 
 	hdr = ptp_parse_header(skb, type);

---
base-commit: 6c096bb08de97cdca051fecddad22cac6a1fd275
change-id: 20260919-send-net-97aa5653ac48

Best regards,
--  
Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>


