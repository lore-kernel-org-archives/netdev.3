Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AD4B826D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577037; cv=none; b=CFII9MYoJyGpVzzFpF66L6v311ew2Mp87gdr01NWHXDfhr+UiQNgYA70nT89n3ZNrYCkwBytKYZkRktGNInd8DNwp8z83Jv7n2GXHuAQZDXx35EdQjVaNQnNeQG6sQUNYk49/b01UlbAsQHE9zDfKKSFq8/v6nINlqFujPrWSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577037; c=relaxed/simple;
	bh=5Mk+lnirw4Bjs33nbqDwv1cmjLuAW+fXe7zM5oJKLh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdoKMK4IlkKT6E/8FRrV8NMjzssxH1cnm/QcZKQY7oeLbbYipz61T4hsH/YdNdO7WMhqhyT0o5Xn2on2SRgLbtT+L+Q7aZWdh6/flP/0yC74422FTXevXKqg87nFVT23pZv4EERsp7BY5US1Mkp/VUA4u2eS8yTEmgXu9Npw904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gydTWYCE; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gydTWYCE"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so1022606b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577022; x=1790181822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+mpDMSv68K/PAHcJ/BXtEa2Gbm5+igpNMLOW8SgDp0=;
        b=gydTWYCEbbztBVQirfI49wWyNmmj8Vt7Iva/nOuc31KAIUVltsAUN4Q84thnjbXGkW
         IaT/wsYDvjM6HKchjd1z3xeEr7DegLX4EqOgIUCzEliWfF/I6mytjUdPkpEhJRojI7az
         R7ijQjcZrBQKzQP/YkrjCVrbYWfZxeXFTUjSPyGdHfFzwDNhDJrFbTlkGaTDCBbcmr5T
         FsIztsvnqtiWH+9533Sj7kSTMTVdq1t0nucnpFO/tc7QWgwuTLM1o2vXC4+ok94mn6fg
         ua5IRRJXPd4M7BAMnmXob4tAsQxbn6Zsfq6zx9Nl4HEUD680UoybtPa/S1jr0jxrB4O4
         y/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577022; x=1790181822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+mpDMSv68K/PAHcJ/BXtEa2Gbm5+igpNMLOW8SgDp0=;
        b=fYyJA0uIjpjJ5UFZbib5FOOXh/vpAGHSWWKDBZZ/QYTiVaQlJuXbjXq7H1+s11IFpU
         QYiFnguIZ/eyOYmaj0U8KK+fXbDa5i1sJIilO1ODYTzE6+unyGVVvN7V+YokG7iMHOtJ
         u7IEbnwaVQtLfbA/VD1xBbsrGggX/XDGxE1IoyQD1FpCccslk7qVwsqbcY1RDJLBkEX3
         w9aOnVtQdT3kIFkKO/z04kmkenX5MLbEuhbeFpw7mcvRdei285/+tmsqXpsFCcVLetZq
         FISZh5CaHokrT5MUXuo+DzLvFw6IPcSoKoT0lVegneUrcSaAzJ+2j1N0YVciFSzjkkyH
         TlWA==
X-Gm-Message-State: AFuF++m9RcENCYfpAJ0bpWPCgfKP5DvVymj6hOaCp0aiXOABjyRS3Wjv
	lPBb6mTALpTvUpQilFa/fN4C08mDh2/dheykPvq4wvjeGVd8MBEgGJ8WVj1C56xHsIo=
X-Gm-Gg: AYBFou0/S5m7K/DhhWcrfqx5kiynUwSMNkMX0tEJEl9elvdPbQ48syr4rrAn0fX+yVj
	PpG5eE30WONLuVuwVRR1oGNo9Lx7xDiNBkbgoWRybX21Tp8L37Pt4U9is2SrDCePUQmHG0Lw93Z
	plD1/4UTaHBfcf/3XMvscoVMyJvFlRvxMKDJm9Fk2ebosnmNiWj48gj1CEZo5e/X94lDGwkXdwi
	FDht5jw9lodsuKeO73ntDKO8os1Q3DV5GoIVAImF0dXcGaddW23RenjM2PohEkrxz6RxZeFoWs6
	bnhaTDlle1JLutHfF3Yw8yeKzli7fQqi/C99enYU3hvND2vW6VKCI8azTUgM4ehLaXSbMMgaHPw
	wxFvY5A05XzoTI+avwO5ci3Iw0dKUFHU/Yv3jUys4KtTTiHoL45X8QR0OnI2goQt82dlUjqj7yh
	6kUxaW+d/QoUXc4+MBhshKB4qllbrn2eyWMFuPi2irPYRb/yCfGQvxBXG7XVev3/x63/eBq2KBq
	BLQUvk0VUu6LO5PMP6d0IusDQ==
X-Received: by 2002:a05:6a21:3986:b0:3c3:8d86:9855 with SMTP id adf61e73a8af0-3dd5f454cc0mr8300273637.7.1789577021541;
        Wed, 16 Sep 2026 09:43:41 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm1902278a12.32.2026.09.16.09.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:43:41 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/8] net: dsa: motorcomm: Fix register bit field names
Date: Thu, 17 Sep 2026 00:43:04 +0800
Message-ID: <20260916164310.3168269-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164310.3168269-1-mmyangfl@gmail.com>
References: <20260916164310.3168269-1-mmyangfl@gmail.com>
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
index 45c19d962458..3a8efffb3f97 100644
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

