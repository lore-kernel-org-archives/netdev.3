Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6474CDDCD
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671141; cv=none; b=reO8RBHEpWQ5zouJMrK1Bqh1fgFfb0JjIUlhLuecS0VuM675hGIoqF9sLr5A17sHyYOeSFtrTc+yk9lwIe4W4X0th3GdFfAATn66rTTXi0LluOMVbCe9u8HhILU4JyUwZ0hnwIvIyiePz5p1REl9sF7XWYXfGJ721tq+JKhtPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671141; c=relaxed/simple;
	bh=ib2A9udkzvYv7FD9VshCB8nL6L2/m8X7KTuloEvFaWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPVueG9eS1gJbjH/o9XIX3YSsallhVr/wbX748GbxXQ5IcTmsgkwk3+rN+TIUxcikZuiySclUYhDROCWvsunzydSg//RurqKRChSCoUn9EwSq+WgHyWk4kOw1Eh9iVPOWJzaeA9YFod+jO7DQSmNX7AZcGNHIKUr4ckxZnLT+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sv4+K562; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv4+K562"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2db1ca069c8so11695015ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789671139; x=1790275939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8YqplBJKdZ9jG0Stk9hqmzya10hEbvLDTdw7GUxkAQ=;
        b=sv4+K5626ODmhWj6rA4JXkw1eu3JLEtFyAOoTtDlXozl1K+hRaUd25rpwRfH5Z8Pl3
         puHQSpxL08ExNpdP1zLPI78fCUG2Ar2sE8tTLxiqSlzC4iP9Z6ba1ITjMHxGxTxdV58B
         8RhfCvuWuc2tBm8ge83Mt3BVMvL5YJ0rl/qz/N8TmlJg88+ds8X5Xw4Yw4Od3pFztEpn
         P/uk4pDSosmP45VCkQJtfalvg3sL7Zy6FSzQAx3QM8FMkHD3ByTtHuplPm4UYNFwHbQm
         fOBvafWk6c85CZw9wJY/McTSx5NrmZVjHeWC+Tu7hVFKs6QVVrl7sSVdIzEbKY9rn7KS
         SjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671139; x=1790275939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O8YqplBJKdZ9jG0Stk9hqmzya10hEbvLDTdw7GUxkAQ=;
        b=SZLjX7Wc2LnCAo38j2eTlJ720GGMO4uLvWzFj72zR0oG93I3y0InHVk/Au6l0AX1tO
         FpV6kfJCSyOf75N2BH85pkKTH6Dsa0hyI7b00wuP1cW/ctqjheEsP2vc0DmhvwcIW+RF
         8P7FFhn2zNelYh6vCMuF82+RsgeS9EZxYSoMbFeTy2UfJkoHUbnm8+l3cUOJoDBMPVri
         Wo4rTYm3pEewKo7UAzd9C63BYPJc/hF9/OrNbF1Yy8bjzJVJqY0itA21XZYx0JLDKXz9
         UrUms7b65xUc0zkzklAx25amHyMshPBSQsTN2wQYPcUJD+lO0J/zROQPnTsHOpSI/Pt8
         jXqw==
X-Gm-Message-State: AFuF++kpaDbnZaVvgss686vgP4Fw9NEyOaSXctndjTsYDJsmz68nwA8E
	OMrajkjSOF4LkcSoBjPjSVpxOUt4Jk2889dI5R8enjrN9XrCr0Z8pf6k4+NKnMOA
X-Gm-Gg: AYBFou0CKybovsiVRBVN5AxXrnKrv93RgWaSLGj2uOy8BQzqFoRrbsSO4tGjjH7KHse
	mRFIyU3puBAUZZWUVBgBB0UUp00Wo2pwFzzHl+fehoYqZ8kApGbuiXertMGGJui8gwZFqQMIdvo
	r9+tUbQDRZ/v0VqZnWzJC5+POivK0SK/FKe2weQXr8ugeZ6b6EW35jSAM0+VosqgQhCBgtjxmaB
	588vKk+qeD/iC+DuK/5jxKwf94Jiu6Wh25j9hfwo1EBeDwvyb/6eb3GsnjiRxTAp20jPyo5p2Dv
	B5TvTHLjWA1FCxH6/l9aNdP1ct7sPm70oPUXGcFAcUuIHPHI158kGYFvY+wmVx7v2gYDcK08LyL
	RKO5ah7jKJVJxcKMItmKgiEV/c5/otB8MSbL1KBCaUpiPbLlZfOAW/x8xMSUXkfu0aE+JXrIb5m
	El8NrPb6K4VV1abKOKQZ1MosPt43jBRLKq4ip6BxmsqQGwlqgflIYLHE5QIUjr+SIztw8hSzJwY
	1l5MaijHPfz+1jg4+vjNGmEqw==
X-Received: by 2002:a17:902:f645:b0:2d8:d4d0:792b with SMTP id d9443c01a7336-2ddb1b79d84mr2382095ad.15.1789671134278;
        Thu, 17 Sep 2026 11:52:14 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm31032655ad.82.2026.09.17.11.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:52:13 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/8] net: dsa: motorcomm: Fix register bit field names
Date: Fri, 18 Sep 2026 02:49:51 +0800
Message-ID: <20260917185010.3189199-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917185010.3189199-1-mmyangfl@gmail.com>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Review and fix the incorrectness in the bit field names. No functional
change.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 3 ++-
 drivers/net/dsa/motorcomm/chip.h | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index bcc9542370c2..5049f4be8aa6 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3742,7 +3742,8 @@ static int yt921x_port_down(struct yt921x_priv *priv, int port)
 	u32 mask;
 	int res;
 
-	mask = YT921X_PORT_LINK | YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
+	mask = YT921X_PORT_CTRL_LINK_AN | YT921X_PORT_RX_MAC_EN |
+	       YT921X_PORT_TX_MAC_EN;
 	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_CTRL(port), mask);
 	if (res)
 		return res;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index fd552f7dced4..3fb0c6a69dd8 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -42,7 +42,7 @@
 #define YT921X_PVID_SEL			0x80014
 #define  YT921X_PVID_SEL_SVID_PORTn(port)	BIT(port)
 #define YT921X_SERDES_CTRL		0x80028
-#define  YT921X_SERDES_CTRL_PORTn_TEST(port)	BIT((port) - 3)
+#define  YT921X_SERDES_CTRL_TEST		BIT(6)
 #define  YT921X_SERDES_CTRL_PORTn(port)		BIT((port) - 8)
 #define YT921X_IO_LEVEL			0x80030
 #define  YT9215_IO_LEVEL_NORMAL_M		GENMASK(5, 4)
@@ -94,11 +94,12 @@
 #define   YT921X_SERDES_SPEED_1000			YT921X_SERDES_SPEED(2)
 #define   YT921X_SERDES_SPEED_10000			YT921X_SERDES_SPEED(3)
 #define   YT921X_SERDES_SPEED_2500			YT921X_SERDES_SPEED(4)
-#define YT921X_PORTn_CTRL(port)		(0x80100 + 4 * (port))
+#define YT921X_PORTn_CTRL(port)		(0x80100 + 4 * (port))  /* Bit 7-0 shared with PORT_STATUS */
 #define  YT921X_PORT_CTRL_PAUSE_AN		BIT(10)
+#define  YT921X_PORT_CTRL_LINK_AN		BIT(9)
+#define  YT921X_PORT_CTRL_HALF_PAUSE		BIT(8)  /* Half-duplex back pressure mode */
 #define YT921X_PORTn_STATUS(port)	(0x80200 + 4 * (port))
-#define  YT921X_PORT_LINK			BIT(9)  /* CTRL: auto negotiation */
-#define  YT921X_PORT_HALF_PAUSE			BIT(8)  /* Half-duplex back pressure mode */
+#define  YT921X_PORT_LINK			BIT(8)
 #define  YT921X_PORT_DUPLEX_FULL		BIT(7)
 #define  YT921X_PORT_RX_PAUSE			BIT(6)
 #define  YT921X_PORT_TX_PAUSE			BIT(5)
-- 
2.53.0

