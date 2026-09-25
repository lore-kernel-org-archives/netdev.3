Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D420381E9C;
	Fri, 25 Sep 2026 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349151; cv=none; b=XrL7bfXPHigJwzPhLlbsoe96NfqWQpBT0Dy6XU7Swpvk9EDaqBL6lf5OTH+DWkRkJYJo+Hfsxp6iXrSVhiAcsbpJ29wnOeehs3SruGqWMmgDP5YYSUQC/yRwM+mWmVcfttJTuMmKIAk0rw7JmfGveimRG7g/hMRDZelo0d78aQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349151; c=relaxed/simple;
	bh=6u+SdU6gYC7j92I41yb2lEJxGvWpe30XjxLv2pcj9Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFFIvw0jZMxnE2LYTUXf1Iwp3+4kb0d9OtgOrzrV3PCEIZoim2YIhJtCfD45fk8dlX2MZt1GM2OyIbX+/vrut4OE3JG4RYp4tlAYrtee+fcuhYNYuIt0zFlRWiyOteZZxgrO/fy6z+u9xODBjyp5GkxGgJISpHQoSNzk3XUEqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr75qzoi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr75qzoi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9571C2BCB8;
	Fri, 25 Sep 2026 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790349149;
	bh=6u+SdU6gYC7j92I41yb2lEJxGvWpe30XjxLv2pcj9Q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zr75qzoiXyp3LLc93azk+kt4TkCGPwMPsyP74Y3pRT+NM0mPwHVnwrIrCnc20D8fy
	 qwfnoMsPibJWghw/oGEDloEttXfcfQSDkXbN+AGiZLM5me9CNtexQxlPdkyW7j9dWh
	 51s992Fmp8cGv6Y51jFnGfxILLkj4WsdLxvSLTfdJiYEOj6WiMQ1me+gOzwLLwUyfq
	 ei9DAC+ByaPP4m5mPEJ97zRwNyXPEwJIw/FNyUHYySMbsI+33nVBzlEi3qSIATZxAh
	 y/gBx16r1vqHE5P1eBtMOjf6cCk69vgPLgY8fhqc3xYtPksEqW0w/InWOB1bQmEqES
	 fa5ii0xk4iEOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E7AC98321;
	Fri, 25 Sep 2026 15:12:29 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Fri, 25 Sep 2026 08:12:06 -0700
Subject: [PATCH net-next 1/2] net: pcs: rzn1-miic: Make usage of
 miic_port_max consistent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-miic-validate-dtb-v1-1-3a6db9bb75ec@reliablecontrols.com>
References: <20260925-miic-validate-dtb-v1-0-3a6db9bb75ec@reliablecontrols.com>
In-Reply-To: <20260925-miic-validate-dtb-v1-0-3a6db9bb75ec@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790349149; l=2489;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=kvL1f5GVpqLzRlzo0o6CBQ0Ou83R1bL1u9WQLESMN3w=;
 b=HkxCxzdNNWrW5svA3g4awk78ysGQVdbr4fpTAY6DusU5Vn1JG3V+IasCG0PU9Kb8OuOgO/uU+
 2cURayirJKdDDpSKLpf6D5R1qm1sliJeLIpdwW6YNN6N4xd8dtJW//T
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

miic_port_max is used both as the last port number and the port count
which can be different depending on SoC numbering. Use compile time
information to always set this as count and fix logic that was expecting
the last port number.

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index cb74861e823c..62daaf76e052 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -59,6 +59,8 @@
 
 #define MIIC_MAX_NUM_RSTS		2
 
+#define MIIC_PORT_END(x) ((x)->miic_port_start + (x)->miic_port_max - 1)
+
 /**
  * struct modctrl_match - Matching table entry for  convctrl configuration
  *			  See section 8.2.1 of manual.
@@ -222,7 +224,7 @@ enum miic_type {
  * @index_to_string: String representations of the index values
  * @index_to_string_count: Number of entries in the index_to_string array
  * @miic_port_start: MIIC port start number
- * @miic_port_max: Maximum MIIC supported
+ * @miic_port_max: Count of total MIIC ports supported
  * @sw_mode_mask: Switch mode mask
  * @reset_ids: Reset names array
  * @reset_count: Number of entries in the reset_ids array
@@ -482,7 +484,7 @@ struct phylink_pcs *miic_create(struct device *dev, struct device_node *np)
 
 	miic = platform_get_drvdata(pdev);
 	of_data = miic->of_data;
-	if (port > of_data->miic_port_max || port < of_data->miic_port_start) {
+	if (port > MIIC_PORT_END(of_data) || port < of_data->miic_port_start) {
 		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
@@ -822,7 +824,7 @@ static struct miic_of_data rzn1_miic_of_data = {
 	.index_to_string = index_to_string,
 	.index_to_string_count = ARRAY_SIZE(index_to_string),
 	.miic_port_start = 1,
-	.miic_port_max = 5,
+	.miic_port_max = ARRAY_SIZE(index_to_string) - 1,
 	.sw_mode_mask = GENMASK(4, 0),
 	.init_unlock_lock_regs = true,
 	.miic_write = miic_reg_writel_unlocked,
@@ -838,7 +840,7 @@ static struct miic_of_data rzt2h_miic_of_data = {
 	.index_to_string = rzt2h_index_to_string,
 	.index_to_string_count = ARRAY_SIZE(rzt2h_index_to_string),
 	.miic_port_start = 0,
-	.miic_port_max = 4,
+	.miic_port_max = ARRAY_SIZE(rzt2h_index_to_string) - 1,
 	.sw_mode_mask = GENMASK(2, 0),
 	.reset_ids = rzt2h_reset_ids,
 	.reset_count = ARRAY_SIZE(rzt2h_reset_ids),

-- 
2.43.0


