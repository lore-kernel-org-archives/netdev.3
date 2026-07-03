Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D103783BB;
	Fri,  3 Jul 2026 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064859; cv=none; b=L6r9u8agreZYGLin83LRcQ7DFZabZt3ln6HHbouJeSMFRsItpFb5rbeFy/eu0FIMdP8XFIvLnzhFkpLZpKHoFLQEA8DhC5l3yxGAyk4FY0gi6uKFeC+UmgamOQ3OHq1LklkcWoPVBKBL/T+LfrReCbBo6dJvl1GPcrebh5yujoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064859; c=relaxed/simple;
	bh=OvJ6mkHVZ2Y0lC6oQi/2+VatTc0XZ4aZDpsQOd6ukgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i10ARbfUKp3L9dPmOqZg0dZpRgk0baW1z6z6q32VcpiSDA5a/ETOyJEKA2pnyije9meGCfR/fJqNE2xGveGBQrpbK4vb9GV0F9u8HfHg2RGrMLe9wGD5n82WWMTcOGHkjm+Qc5ZN6S8x1p5dIUAdwg6I7lYszbDXXoBuQqd8Ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=gsDfYplO; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="gsDfYplO"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 86B2860C0B;
	Fri,  3 Jul 2026 03:47:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064857; bh=ZeV8KEoenaiheXdS8zzoGXvb8etT78DBRonqZexR/ww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gsDfYplOucmLtqylEQt6C9Y3dsoIVNzluSljLAZmH4o5Qp3E2ZJA8VTJou+5jYCwG
	 r+dbx0AYNQstGpUUQfIelvS6p6M93myi651sRVFl0LStPLb3VnWeDxaZkrYvPCuDmT
	 lHmZcL9bl69OKy06jkY18T3qVYpmh3KPt74P4Km0b+CJTSb88DVLA41JES/d+32iYa
	 dYN22JjuTe5Cp6yHFrChFWIwjLMMUP6Jc2KQTzJZJs8hj6YqQnA3PuyYDzdHQjAnjk
	 garVh2uJo9k3ZMxPhQNBaj8zPXQGN/E21kWTaivO40hgaPdSH35/N+S7NMQBQjQNPS
	 9quwWqpm3pe6Q==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:46 +1000
Subject: [PATCH net-next 12/17] net: dsa: mv88e6xxx: Centralise common
 statistics check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-12-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=2000;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=FgexVSaJDh389qKknCAK5pag0luN4hHCE2J/OumPSLw=;
 b=bbIsFaZV6FbU5mZKBA2+lDTyRpwvw/Qu8gjFtl2KjjyuKr0sqHyPfBIAgGF82j7BP/hz1Lib3
 pKsw4YlJ9EZCnkQUb6BwvMYrUXgFjXWl+xGarOgvsZR4KOeghpgd46l
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

From: Andrew Lunn <andrew@lunn.ch>

With moving information about available statistics into the info
structure, the test becomes identical. Consolidate them into a single
test.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5c0a1e2b0507d..6431d25f3cfa2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1303,9 +1303,6 @@ static size_t mv88e6095_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & chip->info->stats_type))
-		return 0;
-
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
@@ -1315,9 +1312,6 @@ static size_t mv88e6250_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & chip->info->stats_type))
-		return 0;
-
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
@@ -1327,9 +1321,6 @@ static size_t mv88e6320_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & chip->info->stats_type))
-		return 0;
-
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
 					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_9,
 					    MV88E6XXX_G1_STATS_OP_HIST_RX);
@@ -1340,9 +1331,6 @@ static size_t mv88e6390_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 				       const struct mv88e6xxx_hw_stat *stat,
 				       uint64_t *data)
 {
-	if (!(stat->type & chip->info->stats_type))
-		return 0;
-
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
 					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_10,
 					    0);

-- 
2.43.0

