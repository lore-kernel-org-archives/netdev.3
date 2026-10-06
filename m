Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59823563F6;
	Tue,  6 Oct 2026 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305292; cv=none; b=d9asgd6o7wM19komLjIdQbkg5Vx1AETqqMIo1cFC+Z3nxOXaXl66AvgUSoJ60SPgfsjKExcoxjcLiBctivpxSmO01KJwifGpCd3fER7gQNaI3uPzOHE4nQm+lki4ALPfGldqvyhlovh1a+NqTA2Mbxfm82/cqZD0oZDR3TOGo24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305292; c=relaxed/simple;
	bh=zXSXQbCwcrgf1rnHXh1JMPBFTzcV1b9TDrQgc1cAtkQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HsnnKbFToUshke+Xjk+ZoMvIk5y2OwoOWW6PVwFqlUj953V8c50aQGkR78AWJFqLO981h4amlvkIausVuqhiiCL/n5QyiBESBKO0lrxIbANiHhDHULR3JjPJ7ICT9e2oUIdIDyghH7VH7dit/Npl55N0fh0Y3qLQJgi/We6I6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqCAdBaQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqCAdBaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BEC3C2BCF4;
	Tue,  6 Oct 2026 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791305292;
	bh=zXSXQbCwcrgf1rnHXh1JMPBFTzcV1b9TDrQgc1cAtkQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mqCAdBaQpTJwOVxopFX1srU1QDie+7KetQYBjpIpzE2A+yQA0S3zCN2/9uMtRLBlp
	 lkqy580VPKJvgR77khlJgzScbBRZ1w4AMdKs4EmBZXdG5Iox8XUHDBsXFHdlDprVAp
	 Js5KZ6ZzDTzn+q08DIgFGZ2cMylYVS8l3tseQRMs0hSMXQ/VZdJ54WXWx/UiH6yluW
	 FHcP/E1olL08al5laiMzXe1z5qvcKhEPftR8lcVWEeM3RIMJBWPHGl4IM9g4Fsps1Q
	 ZNbmB1ONqWUpebI9hRCi+tC72PqEQSrb44dM72iemLavIXfgfPYHpBxv4C1JLOj28Y
	 0k87OzayhsJVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F5CA5FFC;
	Tue,  6 Oct 2026 16:48:12 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Subject: [PATCH net-next v3 0/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
Date: Tue, 06 Oct 2026 09:48:10 -0700
Message-Id: <20261006-miic-validate-dtb-v3-v3-0-68617b3dca5c@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEomxWoC/x3MSwqDMBRG4a3IHfdCHihttyIdxORXL7SpJCEI4
 t4NDr/BOQdlJEGmd3dQQpUs/9hgHx351cUFLKGZjDKDVqrnn4jn6r4SXAGHMnG17Gern0b5SeN
 FLd0SZtnv7UgRhSP2Qp/zvACslybCcAAAAA==
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791305291; l=1340;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=zXSXQbCwcrgf1rnHXh1JMPBFTzcV1b9TDrQgc1cAtkQ=;
 b=+gvUdgGmUhXtWwCRIbXud22BVaXjP4blOyp0hcOw5wX7yqK/y3BIbqys32ea3CA7CiOWi9Q9j
 gOySn5oEgfSCeKdjy/BBUM1hP5HrgABZ9r7kzPLgTGaY6a0VhAy/Xmv
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

This series addresses issues found when reviewing another fix:
https://lore.kernel.org/netdev/20260915-rzn1-miic-fix-array-v5-1-b7173fd5b97d@reliablecontrols.com/

Invalid values from the dtb could cause out of bounds array access. Checking
the values as they're parsed should prevent this.

Changes in v3:
- Squash patches changing miic_port_max
- Change name of miic_port_max to miic_port_last
- Remove fixes tags
- Add another check for configuration value of miic-switch-portin
- Link to v2: https://lore.kernel.org/r/20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com/

Changes in v2:
- Simplify fixes by making miic_port_max the last documented port number
- Add fixes tags
- Link to v1: https://lore.kernel.org/r/20260925-miic-validate-dtb-v1-0-3a6db9bb75ec@reliablecontrols.com

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
Kyle Hendry (2):
      net: pcs: rzn1-miic: Update port numbering for RZ/T2H
      net: pcs: rzn1-miic: Validate dtb configuration values

 drivers/net/pcs/pcs-rzn1-miic.c | 45 +++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)
---
base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
change-id: 20261005-miic-validate-dtb-v3-cf31820cb1e9

Best regards,
-- 
Kyle Hendry <khendry@reliablecontrols.com>


