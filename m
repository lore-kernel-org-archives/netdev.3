Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943B42E8CB;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276362; cv=none; b=ljJP5l3uudb0DbVsoL22gN0FAj8KQ4YMQ/Q58hg24iIdr7cgir+czHaOlYXBQo8UmEIwxWw0NDBn2kLiNdsVsUDJ7ey1RRiEY+W13l1FoZ6uJ0+Ste6/IeaF2mht52JCI2rqh1iWaSpvD2sWu4wyCsHH7dCGkRinux8nTBwB+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276362; c=relaxed/simple;
	bh=YFtc6qnunSvLayiRE/H06UqjHlbmYy0yPe/ASICWZBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCelJEcRbsT9cTXkcMVJUZpEoFnl+Rtfll/xWtdKFT+4NsuWlr2g/nD4ufFugCEGoJkU1BbSkDf1tHSLLQi9Bw2iJNeCNGA1C3H22swxYoCNfxPgw2E1Z507mQDioihVeF7hHT2cWocTNdJ0aElhzvlXM/26nVh0q8nSVFlLe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8rPK6jj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8rPK6jj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D366C2BCFA;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788276362;
	bh=YFtc6qnunSvLayiRE/H06UqjHlbmYy0yPe/ASICWZBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i8rPK6jj9KoXENVtDmSmRMEvsjJkhF/SnjQVzB4NUkyuCOvhTuq363mpF6kIml2Q/
	 Rz5QrasnvU4EK12eOZwL9c9WIbkJKGZTal6VJjGALvFrI67wqFocraoETMi55t6rTD
	 WKMUfrymCbdWf0z5OM7gl8EuqaGJlMe06aeXebKpmdq7gr8ieh6rOTYXq66+wl0dPe
	 UI6ZC0wsv+7r3jDxzxY2X6YCjFh8lxqlVcdwLf6pMA6P0iWKZOSbO6LtIzLdEN7y0X
	 qEy9RYJ6wwo4eK+9yGGQyy+f70zmugNuZKCEgVMihh6L2/dKRjjwMZ6AWTf8NR1hCK
	 gXcOKzylGbyEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E3C61DD3;
	Tue,  1 Sep 2026 15:26:02 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Tue, 01 Sep 2026 08:25:13 -0700
Subject: [PATCH v2 1/2] net: pcs: rzn1-miic: Fix config array
 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rzn1-miic-fix-array-v2-1-3e907049e770@reliablecontrols.com>
References: <20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com>
In-Reply-To: <20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788276361; l=806;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=Qt2Tb1vw9q52czTJX9eOuPBnMJodLGCeGktpWfV6F7g=;
 b=NyKfqidrQx2GHvbp00VKxJBXXrmFBTjg12Aiqg5tP2WGZooFN10TOieMG8uTIqWWAvG4O6xpW
 1rD7tH/RhyKDmgNYk9sB2VugB4eOQxtpzEw9vZOUpvYQGf2SwaNexSM
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

Fix memset parameters to initialize the entire DT value array

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 2b72fa98ddf1..c50b65d064fa 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -683,7 +683,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 	if (!dt_val)
 		return -ENOMEM;
 
-	memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
+	memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val) * miic->of_data->conf_conv_count);
 
 	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
 		dt_val[0] = conf;

-- 
2.43.0


