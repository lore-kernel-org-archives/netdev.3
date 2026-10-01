Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86F5304CB
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869437; cv=none; b=p02ggp1Zl222+NgpW6K+1/+1BBY0p5FNMIO30L+sGzSSaZW1SO7l+tKf270wi1fl13W9yaAXOdPYIBtDuPCwBexmYY3IbIx3AJ3pKSGsAtU88EHDXsFeXLSjjb6k0vdabCervOJXJXq+9WYWjES7ZPJna7h9v9vzY10yi8RwDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869437; c=relaxed/simple;
	bh=1CsJrL5dv0jqsIRpjcW9K6WQKh7GIcyCFtOvsqLHxU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVxLpwQfaJ5boPogFH3LU6LlOCgnHGCy2GipG8R7GH7cI2E3fvR9ADTsd15+FSs1dkEJ/SEQ+Kd7o0SGFNdVVXR3JEBuuTI55yIMgchO5Vy0mG83pGvQG4Q2OAJ3CIMKVObGnX9Ex2R4VTJnZYj43adV07Jfjk3x0G7Lrj1ok2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtdR7XHP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtdR7XHP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so25919325e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869425; x=1791474225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VoAP5G+rK5YjhZNDe2tKfnhAIi3bqkkWc3AxgLgsr9c=;
        b=qtdR7XHPTV41oF5Bso5O6zlM1uxmq8TSlUvYkmad0WWuzXza04T3aedE27V0O6f+OK
         d7na96qlGbz2fPOnQfIJAiPvLEoJtT5repQ3f0jHD40QK9nHKGLngrb4QmqMNGcBFU4d
         m1aYNsBnctpJsMXst6t40WnO72WuL7QsT+9Hvk1aYErNBoJSM7E+8VUG2lkQK5tW0XNA
         bt25JLQckGBke+U77aweAZV9KUqe18S3H6108NBRRIIL60zcp/oloT7lvxyRoTbB4rcS
         NFEqMnBDoVgmbpyHbqIrU8wgDSutHDHRwNZ/K6Fl0kYZDhb50+xa71iVZSvG/5+O/bW/
         buVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869425; x=1791474225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VoAP5G+rK5YjhZNDe2tKfnhAIi3bqkkWc3AxgLgsr9c=;
        b=fPdEjesIHljXro7FheH4WTnppJ0jvH1cdseoRz8cviTRcSYlMk/SQ1mKNShTXZba3D
         BWhgIcaJPA+sWev9A+spm/fUR2UWVPUS67UJpqCKdVMF8gK4CH8UCOnovXkuOfgWZXgE
         wrxkz/gFbhjMj4mO+gDR7fiRLk+ekVa8rSML+WbVHOvXtD43qt7kZ1Zs1OPozrbaJTM+
         LdJEAilze+tA1NA8WatoEG8EU7CmTKF4Lzyp2IdfBubhS+e2SBiejK7yIOVQRKnt/7UM
         uS2B7nanx5bqo8k5YoZQ8RA79OYDBJXQJVnl6HMEh50e0BbNbomH2poYxnlcdlBv4QFS
         erBQ==
X-Forwarded-Encrypted: i=1; AKwUvByWIz/oIyjmAoqllYEDh5P2Z4dDjtFS0QO+OfFf8Oym4UB/QuqwM1xSwfJMcib4vLt4+qGVBF0=@vger.kernel.org
X-Gm-Message-State: AFuF++mLgpI1kDFbBm41m560KUzMqDf0lao1Dc4wwPqDrFcVNvoRod7+
	yiJhTrVX1/n4uhzQc2TN3jTVf3MjfomrPWevGxO792V+UAa0sWCycH7x
X-Gm-Gg: AYBFou0zGDCtr9NvngyEMxAiiaSQOsMjOX0gNO5Dq9cH7TQeh3eHe6jCspZJkelJYM0
	b1rPZeIYrnwhGUWDYJ3X6J/TWW8YginB5Ld5+Pofq82sJsk4R4LP5LiBRWuyREIGrq2qmxACdmV
	pNjt09Owe+g/k7L+muI/XhbauqlTiFdmvHwTuJX0b3MAmh6ekBmYtrS+y74bLrTXsTrNKNxwACM
	hKs4KbbIZFLSh8JycJewcPb1PXyLFObVdz6baGhyGpAB7fliRnB8h5/K8wr9WElQ5cHMttlEVQh
	nbkVVbc2ie6qynnVVvx/KceG1wEwh4c2pXi+YoYPa8AeKNKIeqBphPSjrHzpx8zrrdVfAeoG1h9
	6kjyYmlQ1TeufF4ARfqiSqJQ89FoV8DRlCgLxfCDhbLBp6TS8LU6m+2b+QuPg4buJ28l8SAPA5q
	VBcipAyxmdeE0gCOnD+GRmr8Sopgd1QoZjm9KU0qiw7vnnlZcpDZFHUbbXTgj1IupNcusCkqj5P
	ATgSPZU/EKudDzWt0Uk/cUTI/mfQ+0Nv4Ur8iPtAn7DQ7SBUGNDExuKLLfxP+BBWx4wdP3FYfKL
	27LHSt4Jj0cvm/raBnw=
X-Received: by 2002:a05:600c:3152:b0:4a0:2500:2cd0 with SMTP id 5b1f17b1804b1-4a0275977eamr262145e9.18.1790869425065;
        Thu, 01 Oct 2026 08:43:45 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:44 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH net-next v2 11/12] net: dsa: rzn1-a5psw: Add support for RZ/T2H Ethernet switch
Date: Thu,  1 Oct 2026 16:43:24 +0100
Message-ID: <20261001154326.754314-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2:
- No change
---
 drivers/net/dsa/rzn1_a5psw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index ce931442d49f..1d5ce18b560c 100644
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

