Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DF3DEAFA
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908755; cv=none; b=EdtAE93m3xF6LpHsRuq7IlKBOYsfC0zhYGbzNsyAVcLi1enOJAtp5Rv0t4Ax7T4NS8ZC/4kfMvEBLqdomIbdnppw5FmekSrejzrQWED9TYzg9kkBGOUEFG4kzvSudD3OhRtpDtR2h4WzbmCPIDBbHGdRdZ6GLCuFkeFm/44025c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908755; c=relaxed/simple;
	bh=Q01NYYjB7tIzrEQzmiH+Q27/WCTAb+U9QlejmVmiFkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUjzfYyEDtQ6Bw4QpuP+UiyJu6nF51oA4scFHUJl5uXlSaXmynmrv5hqKadsGcM5j3Z0LhEK3EA8XalUOE53zZFDVVAXHvC0Fws2px54MHGyhp/Tavizyu9XbaXwJGVw+mvm0i7WNkJTu7lvREXmLrMpSG5gp8aZ8eFjZt/GJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf2q2FDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf2q2FDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6E4C2BCF6;
	Mon,  4 May 2026 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908755;
	bh=Q01NYYjB7tIzrEQzmiH+Q27/WCTAb+U9QlejmVmiFkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xf2q2FDyyl42rOW7PIwn11SDtWDtc5E7rupg3SwIn5LOKI+cRHkl5TWj7FeqoEPe9
	 jtWpL12vfSHEGGeqZ2/0jhYn/r8kA6472mmep6DK3MlttMQ+iBrCpRW4Dz7QnPDFKl
	 DBu0kUvy3SZTLOSd7U2qronqMvyNgN4I0PNPxIk6PXG84hYJ+KgUZ4JXpP/TY1rAS6
	 jnpOMwRdxKHRSvvSt7/fO6kAHxFtQrlAqYeSLSK1JJJM4XR8Q4ohcJ/SMt8K/uLgLK
	 5kIc/otfKVeHWNUtsLof1GUsLCXpflf36gkRmeZp3Ly5QQ+AvuGXhmoX9D/v3zMaJR
	 u7bHWymZWRiAg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org,
	Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 1/5] net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
Date: Mon,  4 May 2026 17:32:23 +0200
Message-ID: <20260504153227.1390546-2-kabel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504153227.1390546-1-kabel@kernel.org>
References: <20260504153227.1390546-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 6320 family has 9 global1 interrupt, not 8. Fix it.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c618abc75ebb..338cba0c8364 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6280,7 +6280,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
-		.g1_irqs = 8,
+		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
@@ -6308,7 +6308,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
-		.g1_irqs = 8,
+		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
 		.atu_move_port_mask = 0xf,
-- 
2.53.0

