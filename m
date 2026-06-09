Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0113EFD0F;
	Tue,  9 Jun 2026 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042263; cv=none; b=IjnSn6VLtLRD4BdcpJ3VqH6UyP2LxdW2feXPtMziqBPvyn1E2+RcXQxoXg2XU4X6n++L7IyiRnzxRdLUP4IqbQTsvd+ORZP7DdqJE0cd4u3UJMeRdVNuJ2tuUTxOtljGi7ycAZrKWWfBXSIVuR2hjcgCNoVO8wmcNzxl8V/2vPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042263; c=relaxed/simple;
	bh=bOY5j0lsdbSSw/GjkHe2DT2zC9dncvZOzWsKht0fgHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMPrOd8J8eNiEfZPk8s/qDrH22co0kOGb8IMRNPyK648sV1b6GmbHogXzVO/KGeJdu39+xfq7FU1TxGvIG1FBV58U3oB/aV3g+Zl1o6/u3n1XH+Ka0ELB+knQGFj5IJYYrirSq2PZUg/EDV924FbQuGx7NFYiQ5Et4pGoDd6PQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=m1/hU6vt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BCfJjB0Q; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="m1/hU6vt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BCfJjB0Q"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EC0E1400154;
	Tue,  9 Jun 2026 17:57:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 09 Jun 2026 17:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781042256;
	 x=1781128656; bh=KobzeavsFurxRDmS0bXJLW+Z7dYcPJXD7KLN71UxJG4=; b=
	m1/hU6vtjLLm22h0sKvQvGoVbaxB3LssfggoAMLHeDvfvs3SkU0rlgigmGcl+qKP
	fhVNR6JsOBLVM2xLlqrgFJ6bGMeBwyq5MPTYxBHOS4FvX152o/7h1+o/ThcJBFxa
	B80aS6/aD+f24cU2c28Rpf6/WT2GQjUPUNA8Z2/tKyB6a5sWqy+uXfSNpJYZh4xS
	K636DBUylgNUCfeR0QeT9Fa4MnyJutcH4ZA2umUhhJo01Z+AWKqQXHQeiFcHYrQn
	S/5r+Orwmlvsap08n/4SZPC09MOWxJ0PHL1DSHZXxfe9OAMtLyHxW27xfstTdnp7
	UsTYMzl70iwS57LQY77fIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781042256; x=
	1781128656; bh=KobzeavsFurxRDmS0bXJLW+Z7dYcPJXD7KLN71UxJG4=; b=B
	CfJjB0Qv5RwE2TVNK6UjVSgIOASEAXx3MRsDGMU3jPp3D5SCdmK0ULC8ElEPdd44
	tGI0GKamTGDuWxGBalIQ4ZGBkoq7WcZslnTS3uf1nqMzxpGFLYlz7wU1SRltRsWu
	rUNotx4X8nwNQrSlDT4sDTNKRw1f7GzihfiOg5WopOxydKcjjJZmH0UgJqC1Umf6
	apDTac73fX2BekBLZyzZgvMyW81ZzpNyCCLjMicY+XvPpHmKIbb4Nq27PGn9VkdT
	0dd9+hLwzulxv1Cjl656hHgldimQd/j7GrNzJJYuenCINI5ZwNrWIEkBJYOTV1X9
	S+LkZx7pne8aWmvHfrjVg==
X-ME-Sender: <xms:UIwoahLz5qzngGlBiY9OvZrE9z9pCzoRzII_l4H5Tw4gO9S_SWXQIg>
    <xme:UIwoarro1awATmbSW0u7O8EhudbIe4tQ5rGe5beLQDxVnolD5NUVqWrQZpHvWxvsa
    Tz_gxMibM76NNDg17iArWbNAAXV-zE-yJLcG1FPaupMqIvLY2Ib>
X-ME-Received: <xmr:UIwoaghPnxMAWyrtD8zUky6KIN6oWqKJD3374VuGM6a2ZIObXvhsQjxqbCSKP1dapJeT0NRDIYUh2p2ex5AqS2UTN5IpYUbetPSf>
X-ME-Proxy-Cause: dmFkZTEZnLlG/zm6YP9pu3O+052H5Qov2LG/vKRxGlwYKmDtobM65hzmOwbcE8wjk1Ke7m
    CoRPTz6s8xZHNz6r7EYxSYaY21nQ+WxuJ6l8pnYqUwz87RVhHrcx+o9pJK0PetFza14MpY
    bjFOrr/AOWjqckZ8ZmPSwi+eufSM6Du4onr8KkjVhXfIB0vMWuEypvWURdgBawYR+SdDC5
    /iFtdvrB6ZAI82abtDhhgk1Lzn6n0rqAjWcCiPfUc4kpTV3GqCDn1H5tuToXBmOBPlSyHS
    mX52nU63LRJyGPOZDqxy5h1sNQfc/TNd/6sumTSLKrdnQPNT+/el9tfMKOgqQMXFcuUojm
    VBl89RpFLPfYDkgUMIoE8/4RMqNeS20pMMohukNvrE2Te98wgcY7jMhN1UGGyeEi9CUEiU
    GlpKIk4e8KvdX/22ZJ/GhTd4s249fvZn49pLyMwlfxQyZsHbKB+W7sQBH1DuiZ3Jzm3a9l
    9KJHQH3Wrxm+IGJvTrwkH1P8TufwQTvxyoZM9OY6ffv1WqgjKHqYQZX4H2AlxSGW0Vo0qV
    0DZOw3TeVKkVQUEFTYnjm19IROrlIAub5wK4EsaaxeMQkgFNe7Okem6CF0oPbd8lqvy1UG
    RylBT+sdyUvXsSmGo6GaJC7S1ndSEa+Y2GFCLV9OiRS9Hw4CAUob1djxCXpA
X-ME-Proxy: <xmx:UIwoaiYinBhw7SAtW0MOHZt8P9o-5SgThPT2TOMvJg0Ncp9ksrjvgQ>
    <xmx:UIwoagnsLwBL5iz2J5Uco3uVYEDlPLsvidHEX2V_SQR7gSd3_Jfg6A>
    <xmx:UIwoagwU_MSX3XJLBHm4QiCaVj96Pkmt9Z5K28mRUXIkSsQ5WF87PQ>
    <xmx:UIwoau9WFBtmPuxZJzT-G9QO2FcRBfUf0DNISyDcqRUsrCPmwb8T-g>
    <xmx:UIwoarkuM12tB6wp03YZWCuaAKcqtaWJWwmLLhd-xzZLhB6Xb6HgRfUK>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 17:57:35 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
Date: Tue,  9 Jun 2026 23:57:11 +0200
Message-ID: <20260609215711.2960150-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609215711.2960150-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260609215711.2960150-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The gPTP module is shared between the RAVB and RTSN Ethernet devices on
the SoC.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 82a7278836e5..758c4ca0ae5f 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -603,6 +603,15 @@ tsn0: ethernet@e6460000 {
 			status = "disabled";
 		};
 
+		gptp: gptp@e6449000 {
+			compatible = "renesas,r8a779g0-gptp", "renesas,rcar-gen4-gptp";
+			reg = <0 0xe6449000 0 0x500>;
+			clocks = <&cpg CPG_MOD 2723>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 2723>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@e6500000 {
 			compatible = "renesas,i2c-r8a779g0",
 				     "renesas,rcar-gen4-i2c";
-- 
2.54.0

