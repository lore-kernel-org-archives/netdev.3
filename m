Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8A483BE3;
	Mon, 14 Sep 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404063; cv=none; b=NK7PP0v210jlgBDNF72GIsfI862qfjyb+gq2MDqs0UyWDZre5NQ26blSU+ITXLaBfXBSdtsHG1J2qb93I/G6nVT1FzIo93bvAZyiYGUeULVjKIWUnFrxyiGy3oGcXvl6ikblDYEBJZnww7ppksAZ7aBD7iqmREsRtQ27V2WI+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404063; c=relaxed/simple;
	bh=WzFq7tDnhuj3+nwgTUf0BH1j1qWtl7fyXUznYV/tF/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giIgPZlSjY639REIj7e3KeRp/AwGsL6hayRdCIxxAUoFKqQ2YhO6JC+4uFSfM41PZOJLd6OQFEVcFhqab1bHZEhxz8aO4euTle8aegFlLXIR8wdGvjo3osRnLL/Ba7uTpEozThwGdzokd4bojxwtYFa2+NU3FbhkIDqgIj8w2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ith/kLp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ith/kLp5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EED9EC2BCF6;
	Mon, 14 Sep 2026 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789404062;
	bh=WzFq7tDnhuj3+nwgTUf0BH1j1qWtl7fyXUznYV/tF/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ith/kLp5KkltBzmzJ3DiDYaUd0IB8Pz4JgHGOmZ+CaevZavAofseDs7zzV6m2sFzH
	 iDk2WhNrftK1mCBGCR2TJwP2wQxm1iGM25vEYUzdH0MDmyAEN4F9O56HkEsLaL6PzW
	 0CQN9AuQ2ERKt0Srh52bzdYcP97/M6dht6K1l4clMlQUZ5Fd+jvgg5DRQL3AHdt49t
	 Q7vBNpRVDLbGZqQFfn07G/Qt7lxIed/KyTiA6T/dxEf6S5WZeWSMLzo2+uEfYe5DzI
	 HIvTzn0+8Ku0FYu0Qq+iveeulMSL41+3u39Io6hJP9l0K/zh/iMChHIZmbeeW3NffJ
	 0fUg80U5V+UOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD25C88E72;
	Mon, 14 Sep 2026 16:41:01 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Mon, 14 Sep 2026 09:41:00 -0700
Subject: [PATCH v4 1/2] net: pcs: rzn1-miic: Fix config array
 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>
References: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
In-Reply-To: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789404061; l=915;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=/Epa5QMitVH+voe5NxGQBiH54YdvuFC5bbBJ8Ra4Sac=;
 b=yxNDAv9ZgvlM3M7JjNQCh82QCHuRCQsmsTd9/FKCQmu1iAFRDwTvvOpYJyiB85KjgwcJQ5d4l
 fRmiLr89QkIDtnv4+4vNYv78DPB72UenYj4FFcQyirApL+eB/mtN9Cl
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

Fix memset parameters to initialize the entire DT value array

Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data to SoC-specific struct")
Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
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

-- 
2.43.0


