Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73E493622
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529751; cv=none; b=ajtgAUrdlAjhnZpOiltGcJc9WoioaKJo5rhPoXsbgWzxV9gBKSGH5xKq55+tgO4ZOohmsyAcnojk9ru93gASklruQkQY/YBqkUYQgmuJaguuCfjCflag2kMl0KIKX2ooR27hn7PQEOxzCI7HSfAuBmDuSf+6X7Lti5lS9/FoOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529751; c=relaxed/simple;
	bh=9Ns4ghOs8PLCySKAYGuPPTtS6qsiHfgzhNih4mkhjLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtPaN6ZErSXAajYo+vLYEOiKmfKZqv9OiOyPOiZxBws5ECC8mesaebEeLqOq+iyq89kxoFW6ilBAsOCo9ruxCnZ0iTDl2Ih7T5JaM/TgGCSpmPDnyCPt7eJJx8AKkzUZEnQg0yA3lodppq1A4qCBTh181zVeNLUViwXoGcYsc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYOI4PTa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYOI4PTa"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d944747d41so11238775ad.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788529749; x=1789134549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DIW572LpZg88/9zoCd0pfmQgexIR84aCpztA1cYPl3M=;
        b=ZYOI4PTa11mmNYFoVudoEk5ccAMAKEG3tr5ZIVt3UD2YrxdxUrmwDGQfkQBh7WlMcO
         /R1A0cwdr3d1v3gVzlaA01K7PTyUJxz+6fa9kpbc06YHn5eIlUq9w7931abteLm3e1P7
         +WeQINSvyQ0GnOkfSQJhKioehrGm8oQ/GXsJLCE8a4S1j86H1CienfCo1pL0r+b6rKyi
         AThF2x/lln/HB4kcvGME7vr9fE5NA2XNiPTZm85cf4H2amkHp0b+KADvi5p8pxMfvF68
         tc4PxMdRs551yzrD4aM9/7HDy63JXaH77DBe320+gOzwQCo/QA8qEpuzwGFJIW2g2C9A
         7row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529749; x=1789134549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DIW572LpZg88/9zoCd0pfmQgexIR84aCpztA1cYPl3M=;
        b=LpBywpim8d5tBoZNaUwvGekrd5iJLb6Ey6RCeZJ4nVMM6P2L1N8HFHL2gZUnFDNl+O
         /CDTgNgp1yiGEXsHyPB1FAn2eL+wHyGxhkCHh9nW4GFiwLSncAt/TzC+UbNgXDayH347
         K5GdD9sT5erz72KbaNAJuHzMkEFKthnYl+IHC1L5C/Mu9A75GRuyC9gz6I8KLLVpSIPP
         v+CmQnTTYhgbSZ1H/yiU2wKnz6DJnp0Kvgnkjji/cYCW1Sc+IAVlnirlufnKlk9ZLTYO
         kCLlo74OFlFvR9jNNZjHPRuedGJHZERT8Oa9G071tIUBnulNd8pw3o8YVWUVAroJTpbp
         L8lg==
X-Gm-Message-State: AFuF++lgwo9IP3JKYRhVz/PcLNOrOih1B0BnGX8jyWrSWBkC3LeEOQ2p
	rPorIFIjqTWJn4mLiaDtuJrL81wUJgRhJc73rWese1YoCJb5hRbzzWuTkhKxVJ4L
X-Gm-Gg: AYBFou34ihhmDmHQRXEZKDrilInK0gqvlVPEcqIfBEHHv6lwQC4JUJSGuxgU3lpFF+u
	HzIPxQDgv1rfG7I+m+GQwYsNuvSj6tP4txG8R1+rTxXF/RCHiXKIJo9dbU90DxvknjBkiJAK24/
	rmUYa5vfTVtCXYFgOnoRQEhr2lwBu+VEUu5v2mlu/n9HuQblQH7gpf4QHvNrrYKkjG78hhtYBbh
	W2hxxcNju+VAwnl7Sn3F9O/Me9jjuTaVGZ7ZOraX+YP2C6D3BNIzyJ6e2+047mLDDDQzF8BkHgS
	Qq72+vleQFRQFcDvsIqhuq6XvvYuFQ15jwaKvE8Gc3eG9+Pnkq7et35OCXyPS0oNaOLdYWUuNcm
	Rsea4iZj2fmT2Q0LzdDiEnqtcSe2lu9nDqMAXMQCyGIfOgHaZPkdxroKOg05nprJCfut9DXnxWa
	M4Ly6a5jKbZYtiDk9QMDgGrkxzODmIxHQ9vwvqmqvhgoEKrX7aCFBnPbwcaF1gKWbTYlMagu8iS
	F+owr0sQTDu45Y=
X-Received: by 2002:a17:90b:5287:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-39b26202ea4mr9184929a91.12.1788529749056;
        Fri, 04 Sep 2026 06:49:09 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3050::4d0:46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc060sm12561892a91.3.2026.09.04.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:49:08 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: motorcomm: Handle degenerated blink delays
Date: Fri,  4 Sep 2026 21:47:46 +0800
Message-ID: <20260904134752.635133-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED core defines delay_on == 0 as steady off and delay_off == 0 as
steady on, which was treated as a blink in our LED driver. Fix it.

Fixes: 9af9a8168213 ("net: dsa: motorcomm: Add LED support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/leds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
index 7d3c0f68d8ff..87a6b9cf6068 100644
--- a/drivers/net/dsa/motorcomm/leds.c
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -107,6 +107,8 @@ yt921x_led_blink_set(struct yt921x_priv *priv, int port, int group,
 		       YT921X_LED_DUTY(1, 2);
 
 		use_cycle = false;
+	} else if (!*onp || !*offp) {
+		return yt921x_led_force_set(priv, port, group, *onp);
 	} else {
 		res = yt921x_led_blink_select(priv, *onp, *offp, &cycle, &duty);
 		if (res)
-- 
2.53.0

