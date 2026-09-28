Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63647126A;
	Mon, 28 Sep 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630371; cv=none; b=H13baOHHFwn8XXHcuh4uLEuMCHK21ysLbEfm2Pl7R4XHDpJhgry1QRYeeQSTt3lXn3FQPoF7En64X1obCc0kXbVC6x6mjICzgWcufYv6PVElW1Miw2FnlQcZaAMpGPDdNQVvSDjQFppUFhUi0uUxuBNReDU6Ws9SjyvRsqY2ldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630371; c=relaxed/simple;
	bh=D/Q6M76DHPHZ99xRu33XW4O+Iq41xWx03qkCpsJ1JR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvFg5amCD2An7pIpB9+j+Lzw4H+WJd3ngC1pzvRFineKJ4D/hNsyrqcxFLNdifsU5INsowsxOywUG0tfaexIPqOzlNEOZpDQfs9dKxU80aK9bSMPJlDxzUQ247KcZi5vHFz7WWpBfpz+Lhc0gNDt7ON6ebwP4bfROnjGjRzlW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifsWJVQN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifsWJVQN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFE96C2BCF6;
	Mon, 28 Sep 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790630370;
	bh=D/Q6M76DHPHZ99xRu33XW4O+Iq41xWx03qkCpsJ1JR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ifsWJVQN9ZCfjiLF49LGp7Rpjiudd7Z9Nnz/Gdi0BeekwhpwZqbjpVk4zNFWTt6zH
	 uB51H6e8pLNFI0+rFoHCWG1hYqWQ20YRJpvhVywR8HWa6gbpdRPhrDlKomECBjS12o
	 8TW5b4uyVB+2wFA/IXi3XF5eRTUBn14YwrpRSfH8Rfs0QilBEcTn+8b2Pl8t+23Ezd
	 KSAEb1oLUI46ny2tpcw1jOYOYmBmzbWNP9rlUDKReGoK/AKdSjpMg2CIYETe6RCJm+
	 mXZKk2ELgecpt7QOmJ/AQO+bx7fgLChwbLUbV+PCn5jCg/tGpy72GI79/0XeS/ri4D
	 Tz66x/rndkSAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4062CA5FAB;
	Mon, 28 Sep 2026 21:19:30 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Mon, 28 Sep 2026 14:19:05 -0700
Subject: [PATCH net-next v2 3/3] net: pcs: rzn1-miic: Validate dtb
 configuration values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-miic-validate-dtb-v2-3-1ee3d33748e9@reliablecontrols.com>
References: <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
In-Reply-To: <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790630370; l=1492;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=clQZX/3JFDNrGYwhzOKSNQpXnXVFJYWjpbM5PuE95UU=;
 b=y8v1uZmr9LuXEgzQYhC8g8vTHmbAKBAwptdnvlbdZNniLR7rF8LdPiIdge+qTMo/cgyJTmm85
 G3gBUpu9tJoAN1TOWBFnJh+p6tAL1cNtRqUor386OhlMjSbBVxamGeg
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

Bad configuration values from the dtb could result in out of bounds array
access. Verify parsed values are within range for the SoC and fail the
probe if invalid.

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 9e830932ce49..9a4c6d3b7d42 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -697,9 +697,25 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;
 
+		if (port < miic->of_data->miic_port_start ||
+		    port > miic->of_data->miic_port_max) {
+			dev_err(miic->dev, "Port number out of range: %d\n", port);
+			of_node_put(conv);
+			ret = -EINVAL;
+			goto err;
+		}
+
 		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
 			continue;
 
+		if (conf >= miic->of_data->conf_to_string_count) {
+			dev_err(miic->dev, "Port %d configuration out of range: %d\n",
+				port, conf);
+			of_node_put(conv);
+			ret = -EINVAL;
+			goto err;
+		}
+
 		/* Adjust for 0 based index */
 		dt_val[port + !miic->of_data->miic_port_start] = conf;
 
@@ -709,6 +725,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 	}
 
 	ret = miic_match_dt_conf(miic, dt_val, mode_cfg);
+err:
 	kfree(dt_val);
 
 	return ret;

-- 
2.43.0


