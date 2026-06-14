Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DC3CCFA9;
	Sun, 14 Jun 2026 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456466; cv=none; b=ImPzhBmG0aT2VktRPCL93chYio2YX5ujSgG73J3NIMe7Izb1hHT40oxTZTYrv3kDewptCgyw7xNZBPBtgqaN+SAiuNTmED7apef101QWUwwRstHang8hRPrUiRAzj0RiV4BLhe0iHvZTDuCT/w/xQfDrCphR5Ce5P2mN/Vf51B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456466; c=relaxed/simple;
	bh=aGLg+Uj7BAOMT2XWjoy9sksD5n0NDcZdENT9GHCaPw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKVROIbjrzaXNUPW64t3uvbXDH4dbxGmAsQRiYRCaWguIw1Q015hH6b4QzO/g2G8FdfsyukVbFSo3886omBVbv40jUgUwdast5i6J7kFZM04qofU3lZmSUKxhLHgCZ9tLT5QrykO+bB/6pD736lGcJG4lRwgwY+hWFNuHniwXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EapB3N3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EapB3N3H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E08D0C4AF15;
	Sun, 14 Jun 2026 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781456465;
	bh=aGLg+Uj7BAOMT2XWjoy9sksD5n0NDcZdENT9GHCaPw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EapB3N3HGOUpVZgEvyB0iUHOZE4FaATgU+VWcJbQXP4lvxJGtj129c+ofmD/SOSZP
	 yvkV6ZiL6ZpVoX4N3leEq5UPWQhnQopKSq9zhdKd4HXW0+sWXgGuTCbgF02umMuzbE
	 Gu6KNz/ZheDlxLJ8rsw+/Bw3v3JbRUmmoc8rT/idO9wnV3qWAsNyIp6Ycznmijnb1s
	 jjLSSrV/IUzGmCdmRz6pGCla8+q+0nxWqYLmbIW0ReFZD59NlVmMWjtEBcIG2XiylK
	 aqzguj9ay3+siMvhiN79cDxDthRYyYdI/0chIsh2NJqOXsCBVVyKt5ANG8jy79Cn8G
	 C8utkQO790m8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77DACD98DE;
	Sun, 14 Jun 2026 17:01:05 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 14 Jun 2026 10:00:27 -0700
Subject: [PATCH net-next v5 11/15] net: phy: ncn26000: Support for loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-s2500-mac-phy-support-v5-11-89874b72f725@onsemi.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
In-Reply-To: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781456463; l=1347;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=0gfki+nV90XNnL6mx10oRc1MOUlSPYZSVmCnULxXy1g=;
 b=7K5nsLL3qSxRttYLLi+XTdxwrfeoc5CHyWbtkMV/zGk5NfqTvVwPgGhPVDNU9dBGhH0urKF6i
 CHzc6p6f2dxCDVtKODmaMUGb8LNBQRmtfn2YhB20Y8EV3RTDV4J6POT
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adding loopback support for S2500 internal PHY to help running
loopback test through ethtool.

This instance requires only manipulating the loopback bit in
the PHY. nothing else. The existing genphy interface
implementation for loopback, does more than flipping the
loopback bit. This is the reason to add a new API.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v5
  - No change
changes in v4
  - Moved the onsemi implementation to a new, genphy API to
    make it vendor agnostic.
changes in v3
  - Addd loopback functionality for onsemi's PHY driver
  - First patch
---
 drivers/net/phy/ncn26000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index c3a34b2c524d..afafa81dc22b 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -178,6 +178,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.config_aneg           = ncn26000_config_aneg,
 		.read_status           = ncn26000_read_status,
 		.handle_interrupt      = ncn26000_handle_interrupt,
+		.set_loopback          = genphy_loopback_fixed_speed,
 		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
 		.get_plca_cfg          = genphy_c45_plca_get_cfg,
 		.get_plca_status       = genphy_c45_plca_get_status,

-- 
2.43.0


