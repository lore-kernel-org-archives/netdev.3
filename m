Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71D37F338
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130016; cv=none; b=uLQ1RejyYoek0QwQkO8AJHxCtOn8d6SgQ8ZtIJnRll7Pr3nmMu30obt1Suww21CDjHsQ+WZHBB1iVc6EDX1E4utS4w076MuFKnZbMRaj07i9h70RacIOhC5Wv5+vg4Cw6eDNDXbET5rGoUd4lGA15D2GoIfyxe/5BRAQgAj8DWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130016; c=relaxed/simple;
	bh=+2bw9YYH/ysY8b+Uxn2uSh36zJURPPMfdZQVHtkzt+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh3TgjSPe+x1AjA2q0gSiRL6AOi3+cxl+fjDCETpkfw7QdIDij526NLCBGDWr8tWhSaGtSY+NxbL6lnTMC9pReRQqAQje2hWd9OdbfANrrp8jUvnwN4jkU3Q5t7dnsI8fUOmv18H0bCrnL8MEpRaxEmDle191FmIs/VSihYLiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRItkmve; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRItkmve"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc74520b20bso157320a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130014; x=1790734814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxrKOcoxhEURAlkIAb3tuWb2mfFnLgLdoNfRqIX5q8E=;
        b=gRItkmveDRXqa7Ylht+NB7CZuKHvmARiCKvEh9CQW5qHsLH3hUn1jJYzzUEEKjdvDa
         OOPoUVGRb+zGdOvpHOZ2ft4wq+Ag4oynRxstoBDqeyQgnL6u8ufj8m7NVo42gOPWgY8z
         yHwhl/weYh6CJoxEdGQHMhjHDij3/LS3N3bSSNAFj/ZAkeE10dmipue/2Q6qrRsVOdL5
         iGYGJj1jF8exP6pjxELy05zD35z6JN53VZwAHtmupbBRUeBSOVv5yCmVwy3zuwI5soTS
         XuLHKPmZ6kMoespxmzyqLeOnadtEgJES0pqhqvNm078SntCHScsbPr47fmDUc1NBsNeK
         fcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130014; x=1790734814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uxrKOcoxhEURAlkIAb3tuWb2mfFnLgLdoNfRqIX5q8E=;
        b=hDKJTDMucm0PQHZwMPV9LcttztaEbf/3sHcHTac4kzPOvTTH7VNK8U8F2VQVG1ZE97
         Mb3EsW+Jq/86BzgKk0vdsf9UMSRjHzvkyvyl5IZunObDRrFsfqCtSRUbMjtJNeZTQUTo
         uk3ngRzefc0LSq4PyoJ8kJiJwbHw05LnVEKaZi9eqHbkCTQ1/i0iF6QtZMOYfdaNhBDt
         BnHRqFeqPG876/mgelA4OfJKgLOe1Ga0WkMjR+z9HaROVdnRbCCbZwZC6albCYJpaPjR
         DKn5h8qusr6EYU5r5UHl1u1sN/8FQEWqmMvlbGHudPPrZsUWetsZzY0k5gzFztBLwqp7
         4Y5w==
X-Gm-Message-State: AFuF++lcSS6aJKTyFYcV6m7x4wxsybXWIQ/OoWG2Kh71wAlVuKItw88N
	usNKWLb1mVLm1SRNLAnc51kJLA1uPZMp4mUxiBz9SdBR8I7+4XhN4LXTmKXmmQ==
X-Gm-Gg: AYBFou29vkRmlsjZa0y9K4bBOJbmlPLfhstViOVmqKJdlnVaFOlQCmBVpppiXMawAZQ
	roU+FEKY2ZIXN01ROOL+on2xRrmlnvfODpZxAW1Gaa/EIbUqfS9ZrFwUOYWVfqarbW5hCA4M9L/
	EW4cFYNUgnFLvuLNzo8BON7nKAwTIT4k/KOC1jOwvXCcS0VrZj/4qR8URP/adIPyLKxHR8a/wjm
	c0EhkF8OQIvpH92ocITp06fDeIFLELIAAqGuF4gTH8g+ZtGeWg2/pf30xM9O8FMoganxZH9VmBS
	FTQuBSrOSQsqh++8pEzUfYbRnk0Pf3e2OCfbhavPyzZ3jgV1vP59admbe2I7CrLbEznx6fvPc0C
	8QE10hXIY+n6R7klLJjdTNsf6w8IdmuzHZy5QPzV9K6jf0EP0VOCE39jn+8TFlhwkA278d4lNb+
	IEts46qTLiFJ/O8Ra8h4zfc5iTHep2Sg8jA9SN7cudgfnPX1aOUaC/S6FtzzonSScNfC8onOCtO
	s5VMaA9F+cjGL1mEcHI3kly
X-Received: by 2002:a05:6a21:ed0d:b0:3dd:a008:575d with SMTP id adf61e73a8af0-3ddf82fdb3fmr826347637.27.1790130013883;
        Tue, 22 Sep 2026 19:20:13 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fe8sm502924b3a.51.2026.09.22.19.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:20:13 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/8] net: dsa: motorcomm: Fix register bit field names
Date: Wed, 23 Sep 2026 10:19:36 +0800
Message-ID: <20260923021945.2203368-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923021945.2203368-1-mmyangfl@gmail.com>
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 3 ++-
 drivers/net/dsa/motorcomm/chip.h | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index ea4b29882b5c..f22c37e0b5bc 100644
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

