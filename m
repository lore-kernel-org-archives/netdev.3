Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE93481652;
	Wed,  2 Sep 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374256; cv=none; b=b9rbd8hq75+EZBrwXU7m7Vu83+1f4Qm2D0Z3w/Jaij+8SH/5GodTV8FY+Ai+yZpxwR6EFg/jicoqIf5p8YRJVC7PBM/OSGjfAynLPRNWexMOVDRx+0+1yiDGNheL83m3cd6Jena1rUFaozjKMj8Mpwkxm7eKLzvwPlahYQyInjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374256; c=relaxed/simple;
	bh=07hkFj5b6ye4oDKbzU/53fCrlqkIpezZOF7IBgkgW+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G10Vn7iAQCluS0X77gjcHHBvvEGAmhXWFlBO4BxEQZDH2Mw/7ZpKc4W4i77ek7/KQiWviBjHGFFM8yuicln9XLGJy4GEPNocRn5yFV92KtOvbM4f/dAegoJMHKqM1b4BjkNHQZyf94etizOaU7sHwThz/DVC0gkiUsvZU9XcauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xfu1VoV/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfu1VoV/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E9C5C2BCF5;
	Wed,  2 Sep 2026 18:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788374256;
	bh=07hkFj5b6ye4oDKbzU/53fCrlqkIpezZOF7IBgkgW+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Xfu1VoV/aYGRrImuca8vms7s2I3Ueb/VB3RnEHCPR8iiWYwRwgIjcxwwp+lk7gd5f
	 U5s0swAvL2ytVh3V62UzXDxicVC5KXEWSFyVEtsva9oEEexMibfQTlkqZEok3i6Q1g
	 KsNp5ki086kpHM1K1trYlIxWXTt05owcJ4+q9eytcTnh+GM1htCme3y3PTSTXqFMlI
	 QnadEkMGDNr2c6+tFvxZRivC1Q/xZVQqzHnYRaHRI6xatxNhQ3PmhH7mMu9Wz7idC8
	 wqMDEXF3o/z3p+xM0TuSoGYFphY3yEoevB94/FHeFiGCzmVe0tZYzbZzYg0ZP9KEMa
	 M+IkjcplRmdhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E153CC624D3;
	Wed,  2 Sep 2026 18:37:35 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Wed, 02 Sep 2026 11:37:35 -0700
Subject: [PATCH v3 1/2] net: pcs: rzn1-miic: Fix config array
 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-rzn1-miic-fix-array-v3-1-3f7dccffaf5a@reliablecontrols.com>
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
In-Reply-To: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788374255; l=1005;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=Vsf+EiFzG6nMe9xQ+3XHfq7t6HfrKg+ZnzFZjQBKGmM=;
 b=dKEbW0vShEYPMIX64OSNP6t+EQMXEFA+TMJB6MHuBlvypdp8lxwsgUtNMFWqzPaiZSQd73gW0
 T0F0OWIcuWKB1vlvBMgQ+lFdkGuoeF/ouzrbhth4nYbf0fDVY/Js6t1
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

Fix memset parameters to initialize the entire DT value array

Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data to SoC-specific struct")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


