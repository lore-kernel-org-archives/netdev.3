Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2EE38E8B9;
	Thu, 13 Aug 2026 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644475; cv=none; b=Y3Xaz4TRGP7x8opIeT/x4y+qdFmiviAKXESBQx/QxMRLgwP7d3veR4i85RG1Sl49kPr5ZM+iA0l+L1XkkaPpTQN+cbLtwsQevIMD0EmYjBZpKwKwoOxjW2GOhOn1TSEP2uanI6JL5A86nAW6sf5lKQ1mHl/RM2g9iYL7iHBUY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644475; c=relaxed/simple;
	bh=U0CsGbZVBZQYPICZI9t0QBg90R7yXzsoiFCHaGVlwEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R2ykPm7k8tzPIzKCoN9P4yc8kJXj1jaXsgbGhE/bufasmgNywC7v0eBKw1vNVYCLjz+RdxFz1h0X/xpwclUu2+wCy5GEmqCm4l7i6u3wc5k/xDmOhVAqPch0aCF/jLUE1EkFOXNMw8KZFj3W0/+JwNyzf2jMm9Qi4yNPRYe4Bms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV4+rJV5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV4+rJV5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D807C19425;
	Thu, 13 Aug 2026 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786644474;
	bh=U0CsGbZVBZQYPICZI9t0QBg90R7yXzsoiFCHaGVlwEk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FV4+rJV5gb8Ffpn/UwlmMVhPQJHHDU7DzxsBWFhM4YfiOb3txWVmt73rW12mg8hOS
	 AhRRCOYFyd8LweLXOoN0YoVXk5um62Gcc89fCTPONcujNztQxNe3hJnQXFDo4Um0SG
	 1M6e7qYAOPNUWPby1wad5sHkjPI4Og8dKZ1fgi48SkJIrXp6KHnmeBoD7eiJ+4jXZB
	 o1WsjyBffXswjBcgNO4FBa1zNWDdS3DzsEmpVptgLfuAZCaumBQK04+ehjwKGh3YX/
	 72GjvYJj1Cjzyug2kAW4KR3YQd+/bmYu0p8/qtfwTX7Nd2FzQ7HEpAwCn5/s7oAoG7
	 4oKf+eO2uYuDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F92C5CFDB;
	Thu, 13 Aug 2026 18:07:54 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Thu, 13 Aug 2026 11:05:43 -0700
Subject: [PATCH] net: pcs: rzn1-miic: Fix config array initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com>
X-B4-Tracking: v=1; b=H4sIAHYHfmoC/x2MywqAIBAAfyX23IJaWfQr0UFsqz1ksUL0wH9PO
 g7DzAuRhClCX7wgdHLkPWTQZQF+dWEh5CkzGGWs6nSF8gSNG7PHmS90Iu5Gso7qujFe6RZyeQh
 l+V+HMaUPc70WemUAAAA=
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786644474; l=955;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=BtDQcKBUscYFPfDwz7/zdJWFfzqi9hfRlPaUZT9xiEk=;
 b=A3twDS2mCEsk2z9LmIcqsg6FCVfB4pvoNTgeU/H8vkyZGDqhPHdv3nL8sYUfL3GCp/RNE8qX1
 D0GqCsLOo6zAL1sNOvbmkErvxWZtiIzD7UF/EeFQGWyifNxfmvEvUP4
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
index 2b72fa98ddf1..ad4433971e50 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -683,7 +683,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 	if (!dt_val)
 		return -ENOMEM;
 
-	memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
+	memset(dt_val, MIIC_MODCTRL_CONF_NONE, miic->of_data->conf_conv_count);
 
 	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
 		dt_val[0] = conf;

---
base-commit: 9006c116dd111d457bf5d074990210f70a4ad2c8
change-id: 20260813-rzn1-miic-fix-array-e6ae4452c017

Best regards,
-- 
Kyle Hendry <khendry@reliablecontrols.com>


