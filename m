Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86151CF5A
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983971; cv=none; b=uwzaBpNV79A6yPjgSDusNM7b7sq88nuBfB4tP4lu49gLDFn0T/x2noSodztJB8wJ6gV9KKeBDXBBUGoloDJ9KixQ8rURm+9+EjGGP+j7eBXMzAaVvteQOB43htWbata6cPAxBa7SqxB9lpLeyPHd+z9/aMHPCNlYH+yaLwntp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983971; c=relaxed/simple;
	bh=/pTsHh3m7ThFgrPAd2TN0CeqomWKk3eyHd/DzPW0FuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOGf70IwroCkPBs2m3h/M0sCFiQE3c36LA8cCgXFYp8S+GsED8nsNTQ0RLBo+y06ikGaXwZj0vN8MfWGRvTtZol6pL8z8gCSco4HYMFRUDZr6Z+3mPwMedQhaooITSkejTTK++64f28MBX0sj1hbCn7F94yjdRS3WkLMocwVCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToCt6dQ9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToCt6dQ9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso53915275e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791983965; x=1792588765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f3gciRTz95+N2hv4BkqSp9pRvU8mdE8196aJfMQO27k=;
        b=ToCt6dQ9WH/vOUncZfpAWaziAd2uALlf07W2DuBHBMbW8KrfIerxeVurYRMam4XWNM
         +ZAZpGyPWBP8S1OrNX6dFr9QiTxhXATI+2XxkitAwr52gcIIBxiIdV05LA7Md61dEHm9
         W0M7gndcHY7IOLOiEWWNEGVLN0LdJAsFZAsEFUkbYcNpWlshOVAx8M2ulO3LqObq9Hsw
         CP9sXwNuNOn9yKMR4ebizHQsoBt61EY83Kd2azFbEuFq8gBA6ebrAMPAmhxn7/N+Acjg
         5Joq69OFjiDUTZMuTmJ3MgjowOPGRWv37b+7hor/09U2sV+/O0zsMt51FWX5VoY9CEZh
         sJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983965; x=1792588765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f3gciRTz95+N2hv4BkqSp9pRvU8mdE8196aJfMQO27k=;
        b=kj4vpSMqSAeM/5ILEyTrGbgVFKkMWaR1GKAhXLKDB//nTCNuD8p9JyQ8mYQrqR7UaR
         6zKn8mHvD4+BhzCdwDSYEOwBTwgYYn99fSYGijsxglWI6tWF5KxpoYWfi3Cafza2oe7k
         Exw1vHvEd9hKvmSaviI7iRqawNulr6N5LNWAFPX8c4jpcrkwp2DsZAeD9n0ndusDrxKB
         UvXKxR2DCyOmsJH/1/MMlONaYkaPRNjKhM/KJu2Kz6WvFh2NAEiTfPboes05QyVZ5moo
         v2IdKCmkWvq+xH6W7c2J6h04mY0nI4v7p4pnfW5kceWnB94UzEStj+hjBuviwXK6mBBA
         xWUg==
X-Forwarded-Encrypted: i=1; AKwUvBwGmZS8ja2Xj66LWGlGWC27fOLBPRMDgbj/MPG6GgYVgQdL6gquy0eCj0R7qQ/chsAdG4R4/5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5xTlWHnEcqVpCNOjT9ocquBs43MgD1Yfh03ZVjKVIrkpKuc2P
	jSY1TPlkW4PBUwGtthRB7nz5AKPx9I6DDbMercuqoJ2gIUwo5X8a9w+L
X-Gm-Gg: AYBFou2QfLIZFysj/JQH7wuQKz4g7/dNtOyx4s/JuLnUxZ83AiFJ32uIYnbKvSTxLit
	dZZKu1mTQyObgS7B/btDhAZsLaqSgY2PckaazJXZO47vMXxYGu81LyukU0PD/eEITyZlWhInjj4
	13J/+8eMYYM2jEvaByMi/gv7cArx7IYBaHfBEF5ARbnMYhHwbY4Otrp+f7rAn1DsL2Z7aZq7rcU
	FOD2HKEGx0vtlruhkldo1AXWBAniE9rjOsUXD+mtGreZTKWxvQq87F2OMuky0P+T9OHx2IHHwUi
	SRPOhv1AqmBpOsOjJrqthfSiqyzkgWplPSGgAj+keE4TJSnVFDKGAQEExMNIS1CUTrycwM5uUPK
	T29yrf+G5ry/J68hAf25XYbDQARNl8jeOZUyW6IGeNTI9S1oSuVUJfH7G66QKQ2CPxXPtxI+G5z
	vjzSFlxI04VsQ77FWKPRmbeIRfCFO/styd9Bi5kf7OvAfX9taqdPJjg7G9DIPr79Q2Pp3ORfkLO
	0DqAKf6Kue4YIZJaeIwokb/RIYu1yWrNBJ1Jpa6+Qhx7i02XgVhB0We0Sp+i2z/OLTw1JborK1j
	dz4U/XTeKKDKhHNZlQ==
X-Received: by 2002:a05:600c:c10e:b0:4a1:93fd:913 with SMTP id 5b1f17b1804b1-4a193fd0ad6mr201613335e9.10.1791983964718;
        Wed, 14 Oct 2026 06:19:24 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:ea0c:b1b4:c6cc:a0af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcecbd0dsm1413825e9.8.2026.10.14.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:19:24 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 12/13] net: dsa: rzn1-a5psw: Add support for RZ/T2H Ethernet switch
Date: Wed, 14 Oct 2026 14:19:00 +0100
Message-ID: <20261014131906.990077-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014131906.990077-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261014131906.990077-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add device tree match data and configuration for the Renesas RZ/T2H
SoC Ethernet switch. The RZ/T2H uses the same A5PSW switch IP as RZ/N1
but with four ports, the DSA tagging protocol `DSA_TAG_PROTO_RZT2H_ETHSW`,
and an additional 8-byte management port frame length adjustment.

This prepares the driver to handle RZ/T2H and compatible RZ/N2H
Ethernet switch instances.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- No change

v1->v2:
- No change
---
 drivers/net/dsa/rzn1_a5psw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 30eca64fb218..933589084eea 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1334,6 +1334,14 @@ static void a5psw_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static const struct a5psw_of_data rzt2h_of_data = {
+	.nports = 4,
+	.npcs = 3,
+	.cpu_port = 3,
+	.tag_proto = DSA_TAG_PROTO_RZT2H_ETHSW,
+	.management_port_fixed_frame_len = 0x3fff,
+};
+
 static const struct a5psw_of_data rzn1_of_data = {
 	.nports = 5,
 	.npcs = 4,
@@ -1342,6 +1350,7 @@ static const struct a5psw_of_data rzn1_of_data = {
 };
 
 static const struct of_device_id a5psw_of_mtable[] = {
+	{ .compatible = "renesas,r9a09g077-ethsw", .data = &rzt2h_of_data },
 	{ .compatible = "renesas,rzn1-a5psw", .data = &rzn1_of_data },
 	{ /* sentinel */ }
 };
-- 
2.55.0

