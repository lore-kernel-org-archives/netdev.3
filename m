Received: from e240-5.smtp-out.eu-north-1.amazonses.com (e240-5.smtp-out.eu-north-1.amazonses.com [23.251.240.5])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EA2FE58F;
	Sat, 14 Feb 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771071328; cv=none; b=duTfQiVZRLphsJOMLqP/bB4JVdzHlCfPXpsTnXQmxQcvBM/sRqElYXfIBsx3r3ux4JQVN/5FmEM4jX+znrbS+Q8nqW+iAjW0o8+4uh/4rcsRKTZGYVw6vpbgDMQE+Hbs6b13ldCP2wuw6QZVRKOZwKqdD5q/u/byxESetDkJCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771071328; c=relaxed/simple;
	bh=rFlgiUhbRa59lDQuTF6+GPlvrsi3zx3UKYbAFtUx9IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:Cc; b=ia8FAcHJz62a4WPjCeFo35IDCl+ZtG3EXz4fmC2PtzhfAN13uDxtTCqFqlJH8nSj6RowsnQjfY/cYE0cnxok7ez2CIUC6+H78FUkomu5TNz3kEJk2S01wrpVcgwFmaodxvO5hmoZWs6aH4bdLDN7Txj9mCNm6Q5Z5hBJdAsuX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=IMWwiVTC; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=N13hJtPN; dkim=fail (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=BBxj/c4r reason="key not found in DNS"; arc=none smtp.client-ip=23.251.240.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="IMWwiVTC";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="N13hJtPN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="BBxj/c4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=n6aiayff3zq3manwyovyvpolm4pou2ef; d=poleshift.se; t=1771071321;
	h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc;
	bh=rFlgiUhbRa59lDQuTF6+GPlvrsi3zx3UKYbAFtUx9IQ=;
	b=IMWwiVTCmdar/Uhb/2jpXwqmhFrJWZVYEM0AbyHoBjUpQm9J6kEZI6dPhVdz8CBf
	BRRGyTldQUZbdn8ZB7J5h3COVhXS4UPUKtG3nt+n780lQYKlaKgoS74adCpPzzOD4zg
	GmcmaUDlfMHtQy6pabRUEvZg+ZtMMCDQtGPtWB/kLcrenghz011cx7HMNgM7UnEsuGj
	h3sXKHWkBjkC8Mr2+y6KvZ4AAjqDER5h8w2bD7OeKrGUOAd2KIM4z0YQjU2FXKk44Ua
	47u1LeTn7QvH/VDh0x59BtJLLoul9lwo3J8dNlfBSCqWen0ImMm+9AJFuv+Bb1kkNhy
	wtYV8leIFw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=icdr7g7fbtu2nwxgaimytihkt42k3kiy; d=amazonses.com; t=1771071321;
	h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc:Feedback-ID;
	bh=rFlgiUhbRa59lDQuTF6+GPlvrsi3zx3UKYbAFtUx9IQ=;
	b=N13hJtPNUVjB1iv7w7AHY/h9FiQ6dsjzcfpion0zhoiEzvmz7hqhGwcgtf4B9kpt
	w1LPyYGymytJRH5XbEOjWm1LfikC1/FMuULfCaTtsPTllFL6FC4qM5nECnl5JB05loN
	1kX8oSWwdhKfGTmNV2R0hv+NoGa5spjVBxoZNXq4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poleshift.se;
	s=20230429; t=1771071319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yq1Yi+g/1PPOy4yvt0Qjkyz18T5vp1xuhQ51csxeR08=;
	b=BBxj/c4rHbZ7jB1/a4dfP5ENbflvy1BBh1h02ZzBFCpumejhpzx4tgVcPZ3Tu/38S0gWAQ
	+jR6u2vGHyVXMx4AfNvYtJMa0VxpfNL/3P0p30IaAoL6nMkPE+h7f7O8b4plFqvmvKvY8n
	a9QOZ/C/pcDt1XUF2aPAsSq50PHqQpo=
From: =?utf-8?q?Martin_P=C3=A5lsson?= <martin@poleshift.se>
Date: Sat, 14 Feb 2026 12:15:21 +0000
Subject: [PATCH] net: usb: lan78xx: scan all MDIO addresses on LAN7801
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <0110019c5c13b668-dd1f5db3-309a-442a-b483-262c4edbb360-000000@eu-north-1.amazonses.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqAMAwFryJZG7ClfvAq4iJo1KBWaUEq4t0NL
 ucNbx6IHIQjtNkDgS+JcngFk2cwLORnRhmVwRa2KqxxuJGvm5TwXG7cKa44SUJyakc2JbkB9Ho
 G1vnPdv37fnqamtVmAAAA
X-Change-ID: 20260214-lan78xx-phy-mask-fix-a4260de15a4c
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, martin@poleshift.se
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
Feedback-ID: ::1.eu-north-1.nVsitYrO9p3qnPLcZXP017jV0c/PN62ZbS4lYSSQpnA=:AmazonSES
X-SES-Outgoing: 2026.02.14-23.251.240.5

The LAN7801 is designed exclusively for external PHYs (unlike the
LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
~(0xFF). This prevents discovery of external PHYs wired to addresses
outside that range.

One such case is the DP83TC814 100BASE-T1 PHY, which is typically
configured at MDIO address 10 via PHYAD bootstrap pins and goes
undetected with the current mask.

Set phy_mask to 0 for the LAN7801 so that all 32 MDIO addresses are
scanned during bus registration, allowing any external PHY to be
discovered regardless of its address.

Signed-off-by: Martin Pålsson <martin@poleshift.se>
---
 drivers/net/usb/lan78xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 00397a807393..9d8f1ff7028d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2094,8 +2094,8 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 		dev->mdiobus->phy_mask = ~(1 << 1);
 		break;
 	case ID_REV_CHIP_ID_7801_:
-		/* scan thru PHYAD[2..0] */
-		dev->mdiobus->phy_mask = ~(0xFF);
+		/* scan all 32 MDIO addresses for external PHYs */
+		dev->mdiobus->phy_mask = 0;
 		break;
 	}
 

---
base-commit: ee5492fd88cfc079c19fbeac78e9e53b7f6c04f3
change-id: 20260214-lan78xx-phy-mask-fix-a4260de15a4c

Best regards,
-- 
Martin Pålsson <martin@poleshift.se>

