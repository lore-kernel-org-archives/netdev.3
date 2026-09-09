Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786933B0599
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980772; cv=none; b=IoA0Q9p0VmZsicDCjEC5mKZ5aCI46Fu4f21rNqsgMHmivUwEStUkbCB1/vhhzcPKOBQAdSFtCAZ+6S12uHK8VshfYUoJkNTuYLAtKrewTBAAIx3SOhksPe/De75bOsQzEy8WQuD6e7J6GUdX/u00luV3ZxgMuVWxD7aNIdN6wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980772; c=relaxed/simple;
	bh=iKTRUk516cNiw4XS2T81e0aBKFwxKzBoa/VpC0CxbDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMPdDT3i+VyQQERrmrRQJd3JZErPTzf+xHziv6d6a2wxPW6pLOdMWN8SaavT+fLPLxBQndF230tOOr1DxHLP+fhuH4gRj7hENtCSgydeIKrdMUr4SV+w6DfoinCZjsiPcFi/V9hmtYnKHaAHiA0zw0dkgOk3fSeave/FkQo+GtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtVFCx7u; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtVFCx7u"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fe517774so18225945ad.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788980769; x=1789585569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGCEQvvD0jHywo7chPYIDdNvmbbeQoFnsakggHQgXhE=;
        b=WtVFCx7uP1Mb0qVAdxtM+3JW2Swfg16wjrXy0DRAL5uTPzv6PcMkg64CNLWTMgmnYK
         EAfmHiXIA565z9cgD+RXxji9D30dNMv/L0+K+3u0G3e+GsKowWv+5psT30Yz29ixflmh
         ATdZK9L2Pj4dBfOhZAHnpcm9PR08f6Zg4ztVY/IrrSXYmjoOruN+yYgiXdLir8QyaZsP
         42wQuL/mE2rzYtIBQqG3ob+l4Zc023tvuK/Xd15gBl72ns9wyczAF7OWPsfAiTkVoJt5
         9eqqxN0bIZTbYv4cZGbjBbWe/C8J252ZUSf89lsaxX0MKuVqi8A3D9d221AityO6/hec
         DuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980769; x=1789585569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HGCEQvvD0jHywo7chPYIDdNvmbbeQoFnsakggHQgXhE=;
        b=o/IL2fYmudX8B9e2TBOGtYC5muSLBQeMiBWpK/5aRrGbdorwDA/WEKRaGPFWB1WonX
         WsdSRZwmKxpxhYDLt2veajJfX3d0i4K8YTK0Yd5g8LiUSKYHvnApTfsE/O+xxX6opWox
         PA3EReMqd82Q01WNO2eOq2j9Z8NRjNhw9XVeTA1v6Ez/svTiGbzKGtVu1eYlF3s60Yiz
         KTmagHPhBn65vj9w3yWkZdBsIcuXqFgs+VVMlaGsATgm93AEGUAbS97dFe9r9SH/fpf/
         otCRlKM87tLrnem9JuJFa08b0tIQDJAeJsi3/+qAHnRfi3m//zjgagCnB2fHFzDFi8/C
         A35w==
X-Gm-Message-State: AFuF++nwcGdga/uofEyQ8nyym27h0tuv1Ugxr9dahUdoIKcmlsUJ8mWp
	3IKv1CveBxk2lxitaz1vb3LDyLu2riCOG6Ote8OKxtKa5DvgXIZgU8mRiX59GAIVeyg=
X-Gm-Gg: AYBFou05z1ZNyUZ5cUtz6S3Ig93MVO7WTyA1tg6soDlh1ByYV3qB/WZZECnKBfWI0ZB
	xXcv4537LBskaf9T1mlACDWgzEiPwNND2euRWnMW6084It8nUmWp3YmkBShaJAiiTxNKeFZkfhW
	souekZk0domGm/gSxDjQAk37oMRl4YRV6M9q4PKodYr6d/bAveqLYp/3EJrzjuejWLkHoHbSAR0
	FI7FDVqtoUepZs3zFeQavU4KuIswV3DsjGN8V8ZoZPgTQYs1mJ0bZXiFGjyJGSCktHM0rZMSmdi
	PmE7UTLoNC5oNrgj+xI25aE1HgA5wzROh5Y6jcgQDXfQndG/QjN0tEO5s0z9DZBYjS6v0dpxRHg
	/bEDuMZ6CECCwGIy1+y53oS5H29mgngONtkpxnBxAfbo1Twepnht52JKNld4TtItqreW2vMV5qg
	Sw5OIKXEK83B/S4LGJvMcbVwEbpwOrMLuUaLAjwV0BGZermenQtLLHwlk9NE9eUqjcGMz/dfUm4
	9XNsIoCzxknV08hbErwy/O3
X-Received: by 2002:a17:902:ebcd:b0:2db:3729:22de with SMTP id d9443c01a7336-2db8d3cd0bbmr104342425ad.0.1788980768818;
        Wed, 09 Sep 2026 12:06:08 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dcffa9827dsm13988515ad.66.2026.09.09.12.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:06:08 -0700 (PDT)
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
Subject: [PATCH net-next 3/7] net: dsa: motorcomm: Fix port control/status register bit field names
Date: Thu, 10 Sep 2026 03:05:31 +0800
Message-ID: <20260909190541.466476-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190541.466476-1-mmyangfl@gmail.com>
References: <20260909190541.466476-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Review and fix the incorrectness in the bit field names. No behavior
changed.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 3 ++-
 drivers/net/dsa/motorcomm/chip.h | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 946949a3aba8..53d0a85e9310 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3747,7 +3747,8 @@ static int yt921x_port_down(struct yt921x_priv *priv, int port)
 	u32 mask;
 	int res;
 
-	mask = YT921X_PORT_LINK | YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
+	mask = YT921X_PORT_CTRL_LINK_AN | YT921X_PORT_RX_MAC_EN |
+	       YT921X_PORT_TX_MAC_EN;
 	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_CTRL(port), mask);
 	if (res)
 		return res;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 6f0123d219e0..e87daf8c650b 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
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

