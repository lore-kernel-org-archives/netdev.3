Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714487;
	b=wZPaHz11FxXBrd0zxytyGfugzeOMd3K1U/YOBak8MLZmjNUoWaLzaWtQ6ZADzQeKMPf9
	 cP8cx4dPfeipr4w++2fICQ4yV0Ki6yl+nWY26UtynWg6Q9SnpIXbbf8UvF1brCJespcE5
	 RrBujBg4B/bGJBbHKVSzncxlOgfUCMYuWnrY6tWJhl2mbElSlx3QK9eErzmp0+KKOiEcd
	 /DIoBW79QEIffsYDDcwxeMT87Rix/gn0BGQcIxEhxrrGEly/9SnJC8fqOJSS7zJQhBUWa
	 9g9md6WpLDSM/itQiYBSyeiWeXprD8fZZeTbhbINY1SIR5MTcmRIr67ddC5aOcOJ5wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FOJElCsJejkEPEZ90UqbExNeYAKPE4lqsiLwiXZew8Q=;
	b=rgmZ5E9bWHiJicNM/i+oagOSw1Cbup8qqsOkqG/zqgeRRHFW8cmE5xqeEMSUGrUlMB/g
	 CozajuS6UB/+mzf0d+8bQcDhCntDqWN8RYWWUjP7zjEzywXdIhmQEkeZ4UZ9PtZnuj0Ud
	 z2XqOjKBCrVccs5g/Jn90N1dXhccEOmt0m88RbKhTizvr4yPhw/4Q0AjYe13ClSjTCTDi
	 JQ7y4bXX2kx7YrN/IbxjZ7NNGTwO9urFT582OUxLqMyKhS84VvqfRz/20mxesNmssp3ad
	 nA7FKiWTRg0O6UzDSTulhZPDkAZWiGkxwwzKgoj4GXuEmGEJ49dS/SAjRaV2222uEyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0r46OshC;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C696606EE95
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C696606EE95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0r46OshC
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so2196904a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714485; x=1794319285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOJElCsJejkEPEZ90UqbExNeYAKPE4lqsiLwiXZew8Q=;
        b=0r46OshC9ZV5MWkCyNtQ7yWQaGZ4Rd+LNElvKtplF8X6C9dmmM2a9+NdTcha7Y9QK5
         3/cnsN+NThTqOHT0jcstI3gbyuX2XaqmlfytQuSmrfkjQl9RjUAEs2kge5LeBLy7JcUU
         UIlsgTCjd4QKtSnGZDoTX1cRagqjtuW/UgxcMIIESxeWa2Xw1HpLaMgixTWO2GEqbMs9
         Uoqo46zupn3coz3a8/XPS6phn4+zSKiYuuxwg8twEJXl8L2FRTYQcqjxzzp+W6ClOaEw
         zhsnmFEspIfMMBPpf3GjCNNR/oL+mOJCnxQS0mh0ikyG6Ei4DcYqz/lCuQCffrUvMhkr
         kxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714485; x=1794319285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FOJElCsJejkEPEZ90UqbExNeYAKPE4lqsiLwiXZew8Q=;
        b=JnNT0cGW8jA5v41LaCUKxKYt2uRNgkmK5ONNpO0GyEYqZ4vsmv8kQon1Y/bbkbiF3V
         SeA8GArv2xnDuUZOte66wCbSedWqBMyptd15N18kPg3oZ0vB2L/hkGsvewiN4oclRGnZ
         B1QCFLYb1Wg4CBuUXtHmIeWLUMpQo1hHIPPQ9Oxj531ih6kgpdNhNKK3RLGW7EHlSSzc
         Xfjw8diZROqL2HLXHbHBqHE3Br5gi4CAD1DrQw5p4krzAR7mVrOtr86F4F9jptJfdcZu
         6gHGhxTR9cCjn8si60PAzU4dkTlWoxURyQRe85qcRcnWqyeITq5+x6NxE74BelgiSzxD
         Xk+A==
X-Gm-Message-State: APuU4Z+9gFeobWMjQbUOxpwXogEVWXHt8tOqWMy25R19IPHo0muPrDZJ
	Y3/pAh0cwbcBd4vEt58nDfhEaPIMey8EPrmJvOYnE8l0RU7Kkn0pU/jrwqcHFQ==
X-Gm-Gg: AYBFou1ws3L68G5zazRvwRvxTfrTsjGcEwso84M74Kz2MEiLEa4vkB4BmUePdaOq5Hz
	3ocP3bRzmmCVFNWNONqyD/CD29IlQcAwwOjDwJQKr1gaLJZMl1WS9M45QxOPcWhvfyVFHae0vfR
	3T09l6ymjifG8Tp/g6u2gKeokfujtxZfZk3MVHrdTlGXWeaND1MixAS+1BunWPGfugxLOV0sB1y
	mPiifJmfHTo9E1CWlaY5Kwgwqs0EVccxArdbk20+SEToJVSsmsWACKeRKiMjlqy274M4DtcBcQv
	UoLMp2aAZt9sjhnOdT7IQFIxLv6mXl5W2sqIy6Ojdd9/FDsTM3bvwaEwTC4Tonxg5cUgMRAwI+7
	cjuv2ECTjfvk+djNv8UaNDiFEXOpm63T20JIUeMMiKZBW+nW5wKjO+TZ8GK2h0ESAYe3IIwxya5
	JTWmuRB320oo/aZ1aIy6tx3Dp6pdRb/aXQ2+jlXO8f+i7TyZ3dM4G7EXbNDfKxm73WSXFIwvwtO
	8gDh1vUW+H+yJM5Z7+qU0qdtKk8Qol1eWKgyo57W2ZwbIHZl3rT1O5Co3EgkkBYc3CHPLuQ9+qU
	y6zXyEpUm95udRlBsPqtZSh9yfj4+R5mzoA+Zb1acBz9qG+9YmfS
X-Received: by 2002:a17:90a:5d17:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3ae898ea1b4mr8029410a91.14.1793714484068;
        Tue, 03 Nov 2026 06:01:24 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8460acsm4722104a91.7.2026.11.03.06.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:23 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/3] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Tue,  3 Nov 2026 22:01:05 +0800
Message-ID: <20261103140109.874443-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103140109.874443-1-mmyangfl@gmail.com>
References: <20261103140109.874443-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chip setup only blocks unknown unicast and unknown multicast frames,
leaving known multicast and broadcast open, though known multicast
cannot appear while the FDB is still empty.

Isolate every port right after the hardware reset, in preparation for
the isolation refactoring. Note that this only minimizes the window: a
reset always brings the hardware back to a dumb switch, so traffic can
leak before and during it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..e1fa82c6db95 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2221,6 +2221,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	u16 eth_p_tag;
+	u32 ctrl;
 	u32 val;
 	int res;
 
@@ -2258,6 +2259,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 		return -EINVAL;
 	}
 
+	/* Block all traffic as soon as we reset the hardware since it now acts
+	 * as a dumb switch.
+	 */
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

