Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14A551998;
	Wed, 14 Oct 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992022; cv=none; b=Fly+rCVwn4KpLEaNkUZ/ZqQ8QSpFPceTKSnXPI/sqt2mDtnD+Y5Bif52w7KrvXhcCmcOjyfzXWDaQ+EqBiScp8Xa0h9E/7qUC38VzAO8jhPGYxe6ywUPvoiUU7FbneBtyfwLOqTLUM0xUsezkEvrYaPS8URNUl1YoH+jPtzL/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992022; c=relaxed/simple;
	bh=mK7HAM4nMy4eEc0HHmNewb99Ljc1vlTbcL9mEAk0cf8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yy8cvZxWBVZTF3AGmKEUQNET+eiHqtvkF+ZSl2p9FlXTkuvZWqF3nOhj/F1PkazcJjDFE3+iW75nO59AhztZS2J7yBTTN0R/hw2PJbwnTKzFG35q8rgcBg+CIxkStWmU9GXzEMwAUrM4tLg4WM2tY5wKlWK4wAyaoTIAP5Wqa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/KqMZTE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/KqMZTE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E906C2BCF7;
	Wed, 14 Oct 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791992021;
	bh=mK7HAM4nMy4eEc0HHmNewb99Ljc1vlTbcL9mEAk0cf8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=X/KqMZTE8v6giUeHvOPGuTfBy0B8Dmnx0UiAzPpAbkQNO5e5zyZGt0ZvRt6+OAy9H
	 zidE8Kh/VWeoFjbgVk1PYIj++QWm2HJQW/O4E1ysGGGC03Oc9RGvFQAxTN2nhESqYh
	 /Y0X7XqmI/iBj5LKtVzF39wp5NJdMMMIvtHUbAVlABk1XYfwQQeL9f5LtrX3TozvIz
	 1059mfX7QDdQRe/lXj5I235bNDPmwcsMEkK2TTtECaBwtet3n7/oiMeY4s937YhxIE
	 kWT0aXIcFDtYHqZoN1ycQl9nU08regIYzF7Js184P38buKOut70OdStlBjt9d0+w8e
	 OApv3dzXHR+1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AFDCC6B1A;
	Wed, 14 Oct 2026 15:33:41 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Subject: [PATCH net-next v4 0/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
Date: Wed, 14 Oct 2026 08:32:36 -0700
Message-Id: <20261014-miic-validate-dtb-v3-v4-0-b7da71b3a106@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSgz2oC/22NywrCMBREf6XctZG0sbG68j+kizxu7YU0kSSES
 um/G4pLYTaHYc5skDASJrg3G0QslCj4CpdTA2ZW/oWMbGXoeCdbznu2EBlWlCOrMjKbNSuCmUm
 0Q8eNbvEGdfqOONF6aJ/gMTOPa4axNjOlHOLn+Cvi6H9q+V9dw5kcZHvVwhrVm0dER0o7NMHnG
 Fw6m7DAuO/7F8fWy9XNAAAA
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791992021; l=1495;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=mK7HAM4nMy4eEc0HHmNewb99Ljc1vlTbcL9mEAk0cf8=;
 b=iQkkI44ZNIWO2ba6mqSz9/slYIXSk9aYbVZBhy9HGZyz/1OfIshgOsbZG7CieLxdkoQN2coYy
 IgVCN2TP9zUCtQh6vccqZ25NReIH+WqzHB9rCh5473buUPLgBj2H+5r
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

Changes in v4:
- Remove unnecessary else
- Link to v3: https://lore.kernel.org/r/20261006-miic-validate-dtb-v3-v3-0-68617b3dca5c@reliablecontrols.com

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

 drivers/net/pcs/pcs-rzn1-miic.c | 42 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)
---
base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
change-id: 20261005-miic-validate-dtb-v3-cf31820cb1e9

Best regards,
-- 
Kyle Hendry <khendry@reliablecontrols.com>


