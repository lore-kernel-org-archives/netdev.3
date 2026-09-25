Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DD4B0E41;
	Fri, 25 Sep 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349151; cv=none; b=aFACsR43T1x5cZqgrHIxujV4codEOTpQjkgpyKvyE6kr/Fxxcd4+Fh72gtFctZjAX/n4O3AZnac8E0vDvANPQpbzIxrI4qz99JHcqfTow2Ci+gaQTGlpd0cbzTOo7cLHe8wx7zocli5B27pFU/SCwI7eqZ0cQhmvxxQRgSsUBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349151; c=relaxed/simple;
	bh=AScw+8h/R038C569XXjAtp3P43f6Zx2tfn3f77W1jos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhqfkM0x0OlG0HUVAPjPhccBkdAHbkZ1QyuUPsmvnwd9PiI0jNa+qciTsTnCJH1YXMM/+ce45YL+Kw8kpWNmYYrQ1uuUfAq82sQsXj2iHmoMdFJcEFFQMrfsBhXsbAycywwmW9yrfnbJPcbDVh6JvfxiRyMzDtHWuc0ItNwFW+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUcjSig8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUcjSig8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDA46C2BCFB;
	Fri, 25 Sep 2026 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790349149;
	bh=AScw+8h/R038C569XXjAtp3P43f6Zx2tfn3f77W1jos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TUcjSig8TvLBZ6EhBIEDFB2fYHZoEbb7MSzcKUN6+VqaWgNudOXZpPO2XupvkpD8m
	 khYLfH0+ZMtVv7/QZ3zEQcsSXrkM0EsOe9VoCqJu3PP4L/oxbGj0mFn0/dflkA7yJy
	 kRU+DLxSeeUV2bXuTBckv9NsneC2jOSXibLC3iOoOlRopFEMJFZWj6Skij63Dpfx6Z
	 7JNlnUtDyeePu5u7zCeY6Kg7aVFLm+4BK0Q8BmjQ9ueKyvZiGUIl0uLLd1AlsFZBSm
	 ehgwzgnKZ8svVwM1R63s/4qxR6TrhEbAOqS4gDKdsPQ0zyk1SOYggHttHEOF+Zv2WM
	 M2TGtrc2d9tWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4BBC98328;
	Fri, 25 Sep 2026 15:12:29 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Fri, 25 Sep 2026 08:12:07 -0700
Subject: [PATCH net-next 2/2] net: pcs: rzn1-miic: Validate dtb
 configuration values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-miic-validate-dtb-v1-2-3a6db9bb75ec@reliablecontrols.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790349149; l=1491;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=roPhZwydaFDUeHZvGOS4KnGtlVh4c4JmiPDOvguDH8M=;
 b=gWbzQTZ6lLElV7ND2eSJh+7hDwl751c0+N4kJBheMX1CFrEJPgimgpaS8ca9bkhkrm8n8xbEg
 NLM3smLzYxkAZdqEXO4Q7Ltr1IbOvJZ1cj7X5UQWmq9x8j+gjmAg4p3
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

Bad configuration values from the dtb could result in out of bounds array
access. Verify that parsed values are within range for the SoC and fail the
probe if they are invalid.

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 62daaf76e052..30ac2d407005 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -695,9 +695,24 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;
 
+		if (port < miic->of_data->miic_port_start ||
+		    port > MIIC_PORT_END(miic->of_data)) {
+			dev_err(miic->dev, "Port number out of range: %d\n", port);
+			of_node_put(conv);
+			ret = -EINVAL;
+			goto err;
+		}
+
 		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
 			continue;
 
+		if (conf >= miic->of_data->conf_to_string_count) {
+			dev_err(miic->dev, "Port configuration out of range: %d\n", conf);
+			of_node_put(conv);
+			ret = -EINVAL;
+			goto err;
+			}
+
 		/* Adjust for 0 based index */
 		dt_val[port + !miic->of_data->miic_port_start] = conf;
 
@@ -707,6 +722,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 	}
 
 	ret = miic_match_dt_conf(miic, dt_val, mode_cfg);
+err:
 	kfree(dt_val);
 
 	return ret;

-- 
2.43.0


