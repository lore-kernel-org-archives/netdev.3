Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD24AD7C9;
	Tue, 15 Sep 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493978; cv=none; b=IUIpQkjchlujr53eaXjzFNsDqc/WcEoGQLMhv1p5j3zO8GsO8rpfRVQGgKO3ksu9GXSJsORS1bXph2f91YDh7yNmO2aR4W2INvp48bC9D42we/CL5hIGI3uBWnvhww/FxlCWONZXcdu7xvY/O/wQtaMyozSa5Dx4H2oThzjHGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493978; c=relaxed/simple;
	bh=k3o0pUm1vkitaQ04BRZu8jhi1odWhw+CYvPHVqLuKjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QCiW5j+malIppDtcg+m5npwFj1XInwfrQ8o3kV7gJkFGsATjPUVrPphfwg947lCdICZfY6qWDCQUkrWwLo63Pa1CuPiUNNYMD8s234cgx65mBd8gyPyhuV6HHBZA5xHnQRXJZE0yQ4MBVkVaSd6Ste0vcqkWIW22uovg/PqkC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C34B+qHk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C34B+qHk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A902EC2BCF5;
	Tue, 15 Sep 2026 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789493977;
	bh=k3o0pUm1vkitaQ04BRZu8jhi1odWhw+CYvPHVqLuKjI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=C34B+qHkBckr9RDyRlUkM5aZF3orDZh/FgknGHbpCNfjlE0Yxti4ph/D6aHCj37Jc
	 XQs6sWp7ZMZwfXhQOkLrc7FpiHzApcf1ytnbrNbMnQtvywZZLtS0WO4FOYOPu2kXSO
	 akC+JrWh5jnig5W4fvrSIXxPQzBx3RlcKp51YBSQQPgXh8dGZWwKt2Lb0vg9+r4uXt
	 Wjz+QVEk7VJapvTMon8HvXEvy1LlPjr1rHLGPgKRh9gjQ5YFMFVhYP8RyP9kUs2cIj
	 V/KS0vSlr7sruQfAFfwntYbNb7Dij23iN8xKlyYJ3+Y2m8e4s1Fg4YvEC31wdB6U/c
	 C+xS0arwP5ViQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80609C88E7D;
	Tue, 15 Sep 2026 17:39:37 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Tue, 15 Sep 2026 10:39:20 -0700
Subject: [PATCH net v5] net: pcs: rzn1-miic: Fix config array
 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-rzn1-miic-fix-array-v5-1-b7173fd5b97d@reliablecontrols.com>
X-B4-Tracking: v=1; b=H4sIAMeCqWoC/33NQW7CMBAF0KsgrzvI4zhx3FXvUbEww7hYCnZlR
 xEU5e412cAiZPnn67+5i8I5cBGfu7vIPIUSUqyh/dgJOrv4wxBONQslVSd7bCD/RYRLCAQ+XMH
 l7G7AnWOtW0USjajL38y1XNRvEXkUh3o8hzKmfFs+TbhUm+iEgHBse3KeyKLhr8xDcMeBKcUxp
 6HsKV0WelJPzkpc5xRIaNhKI7VlY+QG17xyap1rHpw3JyLvnW/dBqdfONTrnK6c7Cyi8szUd2+
 4eZ7/AVtCHJuzAQAA
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789493977; l=2005;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=I5i1St31oPo6d7N+HMb7ky+0UtXFiiyAOVC61bDQiwI=;
 b=zw5AD/zG7P/DBb2uXZ1IYVXEZMobeYcifInldvzVGBL52emRFgSyi7IJ1pn44x6B0axvooYqo
 dEOoW+Taqm+B5/AuG/p3mZow7Mk4GGOPHFaQnSF97FCcD+aX+0UGj2r
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
Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
Fix issues when populating dt_val array from device tree values

Changes in v5:
 * Target memset patch for net 
 * Drop port number validation patch for later submission to net-next 

Changes in v4: https://lore.kernel.org/r/20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com
 * Fix lines longer than 80 char
 * Add of_node_put() before returning

Changes in v3: https://lore.kernel.org/r/20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com
 * Make invalid port number return error
 * Update commit tags

Changes in v2: https://lore.kernel.org/r/20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com
 * Use a more correct array size in memset
 * Ensure that write to dt_val is in range

Link to v1: https://lore.kernel.org/r/20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com
---
 drivers/net/pcs/pcs-rzn1-miic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 2b72fa98ddf1..cb74861e823c 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -683,7 +683,8 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 	if (!dt_val)
 		return -ENOMEM;
 
-	memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
+	memset(dt_val, MIIC_MODCTRL_CONF_NONE,
+	       sizeof(*dt_val) * miic->of_data->conf_conv_count);
 
 	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
 		dt_val[0] = conf;

---
base-commit: 83a945a529d6e002dd7339c532288a931f463dba
change-id: 20260813-rzn1-miic-fix-array-e6ae4452c017

Best regards,
-- 
Kyle Hendry <khendry@reliablecontrols.com>


