Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE813B6366;
	Thu,  9 Jul 2026 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783639796; cv=none; b=REFl66/HGKetKHp84fRT+GeGaHpx3Lu6EklBp3Krh+DVJ+4cqsUY98ll8rGs/CfrqBCOOXVo6uMuaHaVJhC2LDTuA2MyPMjnmYxGSAQATQNWObMY1+AANcB6I3SpUekXw3TFIgjfYih/MeLJiVolQEGZK+S0Yehzs4LLvfKULos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783639796; c=relaxed/simple;
	bh=qEv6b1w5Fzimi/KP/CtghnvQVk8zrf0IbjaGmLCYSpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBlrqvVopdNA/eDYhG6UkK1pDa2PacaKWF7ccnqYVMnUtUZRYS7T7XQM3wNt6a2cLBhouf5YuWefHudr6sTpQkpecb+V+Pax6NUoBvu9cDRvAOTuTKmaTV62PaBt905gDFFq+B7L9gXEWdGihdOO7Z+A2HkaQpu8mIrfHlRyDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=P/k6Qo9E; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="P/k6Qo9E"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id E528060C33;
	Thu,  9 Jul 2026 19:29:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783639792; bh=35Ji9KIcWw+YvksYQ3oYSB0WJ+EEsPstsM4Nee6cPvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P/k6Qo9EDsbC8l28qPLCn3XxjnJmiFADXDWHcItPTLIPRTQ01lbI2lSZtDoco8lkA
	 nbZTfFu9J9Y7hxBWqKJ1tfOapSyDp6ov1NmaVk4tx4jcte04rf2RtnbmOtxH5pq5pE
	 oAAm4zEc7ajQhkKjgdRnFRYEaGhQ47AX9GiuZZMllX5tjjeFTH9GDS8clsx3VTyz1u
	 ikA9m1C5SYKSL6mDqblKx6jUTTqEK0vc2VMrznnS6CppikcMhpS014w1xYIs8mEoio
	 ATorWTqH4lhTqgv+/Qvh5VN6DXUJDo4hejlzNpqdVMbKhmmiNr5cP/7m2r8LP//jyy
	 8bmdkdF7mxRDg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 10 Jul 2026 09:29:33 +1000
Subject: [PATCH net v2 2/2] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mv88e6x41-fixes-v2-2-e23654c65aa0@padl.com>
References: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
In-Reply-To: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783639779; l=2392;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=qEv6b1w5Fzimi/KP/CtghnvQVk8zrf0IbjaGmLCYSpY=;
 b=bDI1QYufFnhl5BX4/LSG5gl6H6vb3dVuWGRheIoHNzK/Okj6rj1gY5N25eI5pF22l/nFSepV8
 x+kP2KwymY8Bw9oSOD1AbrX9emsbQNXpUupG0+70tarqhCBTK+2dfe9
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

Changing the ATU hash algorithm invalidates existing entries: those
loaded under the previous algorithm end up in different bins and read
back corrupted.

Flush the ATU whenever the hash algorithm is changed through devlink
and reload the default broadcast entries. Per-VLAN ATU entries and
any static addresses are not replayed, so the hash must be selected
before the FDB or MDB are configured.

Fixes: 23e8b470c778 ("net: dsa: mv88e6xxx: Add devlink param for ATU hash algorithm.")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 2 +-
 drivers/net/dsa/mv88e6xxx/chip.h    | 2 ++
 drivers/net/dsa/mv88e6xxx/devlink.c | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 7938e50900ca8..6faae74de04a9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2523,7 +2523,7 @@ static int mv88e6xxx_port_add_broadcast(struct mv88e6xxx_chip *chip, int port,
 	return mv88e6xxx_port_db_load_purge(chip, port, broadcast, vid, state);
 }
 
-static int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid)
+int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid)
 {
 	int port;
 	int err;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index aca64fd4cb95c..6fda3f83c8885 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -894,4 +894,6 @@ int mv88e6xxx_vtu_walk(struct mv88e6xxx_chip *chip,
 				 void *priv),
 		       void *priv);
 
+int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid);
+
 #endif /* _MV88E6XXX_CHIP_H */
diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 6f034841883c6..5168335f52289 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -61,6 +61,12 @@ int mv88e6xxx_devlink_param_set(struct dsa_switch *ds, u32 id,
 	switch (id) {
 	case MV88E6XXX_DEVLINK_PARAM_ID_ATU_HASH:
 		err = mv88e6xxx_atu_set_hash(chip, ctx->val.vu8);
+		if (err)
+			break;
+		err = mv88e6xxx_g1_atu_flush(chip, 0, true);
+		if (err)
+			break;
+		err = mv88e6xxx_broadcast_setup(chip, 0);
 		break;
 	default:
 		err = -EOPNOTSUPP;

-- 
2.43.0

