Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51844B0E56
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577031; cv=none; b=Ovtx+1PP+39iZCcPLgdjqEpZ9kCZcJnM/1P6wpsL0c2s0LtBOx7Ewv8SlgQCK03UK6dzorkv1c2nU2NXOpXofIVaNpRV/9HhSGrmWo/Mue5QGBracn3nsz2NTyQGDuBhyvTrEM3ifPsbKQJBFnuragfr/+m1PD9p8da+7Buduic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577031; c=relaxed/simple;
	bh=t2Rh5HicDYfUhDshXxIV+ToBVIxCOdkpflXNAhRUTLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWNLTHIpCOLVoXReL1zg6VHi48deNpc9bZXZ3hFzaLkNVukmPvs1WvQQ/i6I3553c48/K97f5h4N18BzRC/zbz87Iw7KKBmR+l/qQBUzwK9BSOLpaS5yG+guHJc2wnvf/uSJNDi8xM6odduWQXHSjsZIpgyUTGIjNtCz0atErhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnNC+Fwn; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnNC+Fwn"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a856865so1004674b3a.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577012; x=1790181812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmX2iathH1BothbInV/Ke+WVEC5Ed3SbwmWKrISd/bc=;
        b=cnNC+FwnmKWQBGu3rsYm6gCf2VEbURC9FHJPg/dKZoE327N9gZbHwRK16MaxFr2roz
         uYIYkHlb4n/ocvvhmAkPoqX2U3CIEEdhExk4uBsRsPNA55S2dDp6xoQTEuMWLdB3bTup
         D1RghBbs77ROPmYu1iNL6AqKwsr/Gni+vVSnXTej2Np4LxrULqbP8iJeei0ZS91vcdRU
         NgczjKaeYjJJGsGHuSCYESKZNPORhil6gVMMVRBFEr85z/WXJPbca5S1TebpcrgfBDyn
         zEQZT99qIHJZVsL7qMJitCc8b91EivrMUF2cJE0iLrYveV524CvOY/Ll4uaCjYb8lhse
         LxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577012; x=1790181812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmX2iathH1BothbInV/Ke+WVEC5Ed3SbwmWKrISd/bc=;
        b=Q1BY0LIjhGHWiZ4jKnKCXHR++BPvKffI720RIXJOz1oKtqkZVpdjD1KKB04RSxM3pW
         504kOt0EJqXsFynC7TvLS7KppVf00d5jOVg7lGqNRrAFifg9Bj6StTmp1W3vDI4LPpwL
         F8YXG5syUXPiYQoLDAj9Aw0cEO4M4RD0qfjfq4Hz9Ki206xB1kR6jQ5tbgsaYeE1zIkn
         I25rsAIwMRKXFPSTmUnVqHUoVVVXGjkrPFcJAXw3AKr8cnDVxNHlAO3zPlbWa9FqecJv
         fdc38yq9WkGKj/Aw/8TlwGGY3bOfOcRU8oD23Mc9RGz2jj12Q3ggKrCr0aw9DyRdtDwh
         477Q==
X-Gm-Message-State: AFuF++kASM1aZyNdJcJMn02ECuSpKqB4XBK2zBOCiK8CiJmW1p7NKY5w
	Vw/GpNDwameOvYq6SxZN/Tt3kq7VkF3ZOv88EM12uDTM12/UWMLKCJGv9EELqO/dSPM=
X-Gm-Gg: AYBFou22q3JB/5RN3uoWyTz1XFgUKzYU+hC+8tBME0wmrRdSM88zIRo/5WltFIf1tzO
	YD1UNVACJmMyHmTFFpXosQ8ENYvTlBgn4uaYY4049yvSOKvcMou/t5evI0BDGdg5i3NN5HvcTNG
	ZQXugEtHFwTdo3BNn058/SJu5Go3eDimlF9/4l/TDRgYbVtKgjcTZMTl7WzQD7HHMMgKTDLQFlj
	pJH0Sm5oFxFoSzQjcezJbjp3kIqHEbCPa6taQRfC1W09hJFBm+vJ04FxVcLqnpWKbPkKdh2GRoE
	V5Sx7JglyVJPGrxLW50HIeVS4Dswps/86+dhspC0Qtg3hpfgG6WLvEJUO64ntGdIXuaGT6g2StF
	5ku9RRQvlo9nph6DVd7i05t3/hI1CVLPlxKieOIeXrwc7f1Q8uy8DSUFZlgcHEQwSx9nTJxDEhK
	/QGVMKGpcBSCnr2ice+isipMpW/oHnE0NxKG0KQ6JYD1VhltbcqAhUgv79Iil0QOL27Ks7/GRq5
	L5HEVTJvCumOayxVuKm7Vi8wJE=
X-Received: by 2002:a05:6a20:3d8b:b0:3da:b761:80c0 with SMTP id adf61e73a8af0-3dd5f5c7a4amr10074959637.14.1789577011577;
        Wed, 16 Sep 2026 09:43:31 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm1902278a12.32.2026.09.16.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:43:31 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/8] net: dsa: motorcomm: Remove YT921X_PORT_MASK_* macros
Date: Thu, 17 Sep 2026 00:43:01 +0800
Message-ID: <20260916164310.3168269-2-mmyangfl@gmail.com>
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

Remove YT921X_PORT_MASK_* macros since they are only thin wrappers
around BIT() and GENMASK() and are not used in other places (plain BIT()
and GENMASK() are used there). No functional change.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d663af010f43..5acd7d27ff40 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -108,46 +108,41 @@ struct yt921x_info {
 	u16 external_mask;
 };
 
-#define YT921X_PORT_MASK_INTn(port)	BIT(port)
-#define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
-#define YT921X_PORT_MASK_EXT0		BIT(8)
-#define YT921X_PORT_MASK_EXT1		BIT(9)
-
 static const struct yt921x_info yt921x_infos[] = {
 	{
 		"YT9215SC", YT9215_MAJOR, 1, 0,
-		YT921X_PORT_MASK_INT0_n(5),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		GENMASK(4, 0),
+		BIT(8) | BIT(9),
 	},
 	{
 		"YT9215S", YT9215_MAJOR, 2, 0,
-		YT921X_PORT_MASK_INT0_n(5),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		GENMASK(4, 0),
+		BIT(8) | BIT(9),
 	},
 	{
 		"YT9215RB", YT9215_MAJOR, 3, 0,
-		YT921X_PORT_MASK_INT0_n(5),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		GENMASK(4, 0),
+		BIT(8) | BIT(9),
 	},
 	{
 		"YT9214NB", YT9215_MAJOR, 3, 2,
-		YT921X_PORT_MASK_INTn(1) | YT921X_PORT_MASK_INTn(3),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		BIT(1) | BIT(3),
+		BIT(8) | BIT(9),
 	},
 	{
 		"YT9213NB", YT9215_MAJOR, 3, 3,
-		YT921X_PORT_MASK_INTn(1) | YT921X_PORT_MASK_INTn(3),
-		YT921X_PORT_MASK_EXT1,
+		BIT(1) | BIT(3),
+		BIT(9),
 	},
 	{
 		"YT9218N", YT9218_MAJOR, 0, 0,
-		YT921X_PORT_MASK_INT0_n(8),
+		GENMASK(7, 0),
 		0,
 	},
 	{
 		"YT9218MB", YT9218_MAJOR, 1, 0,
-		YT921X_PORT_MASK_INT0_n(8),
-		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
+		GENMASK(7, 0),
+		BIT(8) | BIT(9),
 	},
 	{}
 };
-- 
2.53.0

