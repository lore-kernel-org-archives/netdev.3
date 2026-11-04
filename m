Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816486;
	b=fnrBibzMbHUnaO9zi7wtwT65olUftu4kww+5Q2y61aLWGLzBb6rft0wmamrUISXiMkfF
	 L/IVesegPh2xqCyrOkPi3YQPbOdeo5ghIof2oB6KCRFlJx1s+FzvHm0TT1PGMPhfXT0UT
	 AGsiAoOqDrN+7b4t/6qQeaFUvT7NapR1rXZ+P/o8UPx2MtWxVD/KlQim0uGDVgdaGbRZZ
	 5VGCk9WhisZWtcUxCytGk3BQa42WWCvrfe3o0A7SUnZ682va/Qzo1ZL1KOo+snlWYfRrI
	 xM1Tl126TI8ktdj+FdShvkF45Qw3DUjsjyO6GwxyH7O4Jz+xvEApjGZIiI/ss7uScjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cyAGHCPkA2zIGNE1s41zUFh8GTp9SbTWyYT3VeBaM0w=;
	b=ZQNoX2ACpGW9XyITef7OwFE9hdcXm4h45QDqdKrDO+Ai49w2TcwXneJTq8aNI3IMxcYn
	 U/O+lO88Votc3fvz17rlVL4LLyvHSOslcO/dMKFwJHKLgNKnFLNKckwjghyq7W+mDE62t
	 ugubF3mtag6QcVsYQHfE3WIfEQIMLj2QTrGTuXiuaaZ+XTdcLJc6kCn08kv04nhQtPwCe
	 XbrPBMqk8doeqnBxFX/eUHkB/03nbAi0J1/PW3M/2pfp+HxHbVx8+yTvhw+WjGLp/uMWX
	 pgMVTHNMlSUELnxUT3hJBEPRkja3rtVEgipsZJCtJp1XxK7/2Ipp0tZNkAO0Lmilxeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V2cgLMeZ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F260A383F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA2F260A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V2cgLMeZ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so7879405e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816484; x=1794421284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyAGHCPkA2zIGNE1s41zUFh8GTp9SbTWyYT3VeBaM0w=;
        b=V2cgLMeZZt/RrMcjTOPGqIFR5x+T3e9ZJqAFvwV+Kd+/sgH/TECjzHHEh3Wqg8Dtmg
         vUUWzch3y2voBzpfsFrZxLTCJJI8ZLp5kTwvjniMN2FqbHDnytOWQISIevoo+hhVWA+B
         xKM0s6gVt87TUmdYMkgMES0yiA5T0PU8Mz+Wi0JbAbvhSfj7hLtS61j64zaMhJwk7so2
         ILfWWDGRbLoaJBXVqIXwETLwer6IX/mtY6FETllRw9lUcnd5ezevvx/AQIwub/s/G2rk
         OFB6/B6sA+DZCt67zT3bDZTIBu2eexm2vmJ1aVzM5KKGk4BTwBYXF/XYgoUpo3rPcvEl
         hTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816484; x=1794421284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyAGHCPkA2zIGNE1s41zUFh8GTp9SbTWyYT3VeBaM0w=;
        b=KxKxkuYLBCzj3RP31CatB6ChKzfgCVFZd76af81lk9frqrtybyRICKi3esiriUI0ej
         wUto/MvtMkzQW6Ored69B2Yp1GYWgCMuTsu7RMFpUnp3PwiDoFMgIGqKBsV7n2RzRL4+
         egWxTroSH9WkSvx5q6yQ6BSXGau+euSLWqCKmHnz77nnT4ldpbVh5jrVraI6vG7bxmWK
         LDYfHYNyU3OEosSlhpSxEGy63pY1LeaG+gz1v98nw2mRzbaES4wjAXmz99NrsUEEGls9
         ryqOxwHg0VfI1pFI4wFPbnuUvjjCQ861Ve+eHxN7dOXmefZHJajJvgk86VRtKW9TCoFr
         bqaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxul1bMaWi9MrzKDSSkNbmrxJZ1SVJOQNeOoD5zmb/8iAuyVTzp8iK3i2W+MW53ibVcWOWypuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EOji+VrmVz2ZE4ChMzGt3Ee8NFSNadjp3qZtso2uBoB/+H78G
	9Avm2B6IypvGT4SQsRQjAHtgtpy+QCiMPug9dHc/kNV3dQayG0Ic0iMV
X-Gm-Gg: AYBFou3GKTJJzVfWxW7oap36I9fPaXMrF+H/enrHwjHUfMyo/0ttE0MHBvYjSqvNy8J
	Wt7KTJzSp/yG1SEq7CGCCt7sCSV4F9iCBQcjBh4zjJ7VZu+P/NzbhKOeV6QjhrGf51b7zbdpE2D
	s+DULQDm2F9CdCMHoGqb3gZh3byIzy0r/S4xOhtOvcaXyTMiCgIzF+f1r/xGKVGA0nAv3XwSPDK
	lLb5s1osLwpKGAvq5QsY62jOSLZsgy4pXreGZ1qte5LBN6rEk/92z5dva70zaQr/yo75T3QA8Fj
	ur+gRsdYWpjQA9Y842kH2uUgiGzwsghgNpSjXFaybc4U7pJHWu+DQ60A2BwJ6a4f1UP2n15Q4ew
	IIffQCJx/EaRP3x49XRcJ25Gujvm9oGHsAPiOMZE82qgz0da/xDPKXE4epsc4wjDCQX1+llJXkP
	NHWLBQbSWWGW57lgVVV59+S1KteZPp7LEpKItvDcHDun33gmYrbxqKDHQtEeRWcuoiUwPjr5/I3
	xj5wpijWygeISiWPvX6NjrrFR8NmTxB7ThwAEu3VTLgowhpxSuY8YUlnXFZXx4VaQS4eVbu9nHc
	jvbNLpKikCcTOGhUbb1DKhj32L9YctPCQ4RsV9wQjA9yuyNBAJpHEilEdbgUnIQhZmgJw34jjft
	90qKP7BBHQ0LcTN/XCbLFT255o17I8Q156rLzEA==
X-Received: by 2002:a05:600c:a00d:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4ac19705d57mr373949755e9.31.1793816484012;
        Wed, 04 Nov 2026 10:21:24 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:23 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH net-next v4 13/14] net: dsa: rzn1-a5psw: Add support for RZ/T2H Ethernet switch
Date: Wed,  4 Nov 2026 18:21:01 +0000
Message-ID: <20261104182105.1102555-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add device tree match data and configuration for the Renesas RZ/T2H
SoC Ethernet switch. The RZ/T2H uses the same A5PSW switch IP as RZ/N1
but with four ports, the DSA tagging protocol `DSA_TAG_PROTO_RZT2H_ETHSW`,
and an additional 8-byte management port frame length adjustment.

This prepares the driver to handle RZ/T2H and compatible RZ/N2H
Ethernet switch instances.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- No change

v2->v3:
- No change

v1->v2:
- No change
---
 drivers/net/dsa/rzn1_a5psw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index f3eb8646dea5..66b155686474 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1338,6 +1338,14 @@ static void a5psw_shutdown(struct platform_device *pdev)
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
@@ -1346,6 +1354,7 @@ static const struct a5psw_of_data rzn1_of_data = {
 };
 
 static const struct of_device_id a5psw_of_mtable[] = {
+	{ .compatible = "renesas,r9a09g077-ethsw", .data = &rzt2h_of_data },
 	{ .compatible = "renesas,rzn1-a5psw", .data = &rzn1_of_data },
 	{ /* sentinel */ }
 };
-- 
2.56.0

