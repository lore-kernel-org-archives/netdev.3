Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634E3A9DB5;
	Fri, 12 Jun 2026 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256558; cv=none; b=oqTEn2Z3b1AfLKSlfHrfdqZSMct3pnMvlQm5769OBZsgzHhPXgWGMRkOxIKcZcnDqlonqHwdP9M2n8bdT6cfub09TqzDrBI2pATmH6Su0iKJWr15SlOFrZSP4QDdMQAfUgdALwY3QHdjdpR0xi2yliKoQyuHFN/1QPNNUiHMQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256558; c=relaxed/simple;
	bh=fpZ4OinGIZZZvUJLCZCX3meTtkRwdeRRZRjLkyAublk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOk/QCVCBgf2soohN9VjEFuqXu9ljPsCsasiHyZUrq2GBeqMav1sLrogol+zvblBJeDtRhpaTNU51EPOHHVzVQfCUE9NvrwvBE7FMDisBOF89EAt9GfSEUvrMtaYri53VIMP3H1HmgjwMqkKJcTHocIbm7Ef8zm6oAV5ctUJOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=bxiF8TKk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V4DMu97G; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="bxiF8TKk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4DMu97G"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01D1514000EA;
	Fri, 12 Jun 2026 05:29:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 12 Jun 2026 05:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781256555;
	 x=1781342955; bh=dje3g255iJ2YIYLr5JTYOt8f7gAfSFaktktOPJc9Qi4=; b=
	bxiF8TKkZS8cSrVS1FGo75XKEUKf7z9Hd8F3VLRdPq+msSZAyrwNZsGH7VQ3fj2S
	IUGVJ3DkYnuMY3c8nwm7hnsdfzxZ7R3JICAMXi3ztUpzYasMIcad/yrFbVVdZ0l2
	A7NX8kqnKhBF6nCErugBJEB1mvf9YTQPfTLGUz3s9J6HBbJ6xY7kj4ARHkFvH0QO
	r01BMhI6UhyEwo0hNGGvIlwpVziz10jAQVO7d07in29y0h1da675HZLYvFdAUtUp
	M+kbx/HrP5r6UusN4j5TV7439im6qNinnvX5KF6TmUcJRyuEaXfcL6F/jbOiR3BT
	f3BoDETYFZZvrJFO0SRu5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781256555; x=
	1781342955; bh=dje3g255iJ2YIYLr5JTYOt8f7gAfSFaktktOPJc9Qi4=; b=V
	4DMu97GQeXlYum9Di8UZoPbtfUnPZIVSRHTfG3dfUOhNQO/QHegZHRbrPg2dRYOt
	Rcj8wzukIbZlpx9fl2vqniH0tekurhp2be/JTZSn/zSAGL1+FvnO8KQkLEyai6Wz
	TeW0hMRwe49UsS3nkN6NS+U+/i5VIMc5ZRnKGquA/TFwCj89LqC8VYmJQRWxGg30
	Zl2Kzjb2aWtGE9ShvMFUi0PbIOqIv/zxYKH3agS7Jv0fO6FcQqBpQUrJSsFpgjZf
	YI9BPRTuddvzFxL3XSv+kIyUdTtUa0jHvIJO7cOPnaRGx9SxXBnsfQGwEXbMZdSJ
	BfErAoH6CWZzGGn5SK5Zg==
X-ME-Sender: <xms:a9ErapgGQh8css2lyHFAGs9TEyTIcI1Fcpr0rtvfE9ePhRyhz4ZbXg>
    <xme:a9Erasicr2QFsZCfzSoDUaLz9M8Yetr_Q1y4VRJLmvh78mgVstrXF9wCUdJU4P_79
    tbiDBvQmMdO9gQfbigaN3CL1L9azUGKZKt4QpytBB51OwzLdDAXArAh>
X-ME-Received: <xmr:a9Erav6M_RPEJc7P2HAp-TTbxKE5KnxyvW1Ef6M4IfsS3Vnw6nCO_uGwopDZ5B7n3lPt2oqT6-dMzo7Sk5SjmUGx9Cca>
X-ME-Proxy-Cause: dmFkZTGqq3w3fgy22TMK8AuQy4vfSMiqXTIe6CnMJK+9N20iXzrifrwIPyrCI6pkJeVOUL
    RMieCT7gIASYIlvGeLr4kz3qSVjpglhscATzY+5U9oBvv/yVBODnbSfZAT5ZYYKDTqoUpa
    ZIi4CSjy1ajMIoqdPi4lfxyvDlds9bTZDlQLjPow3ki/MMn27DmsS9Zju9FqOG9bRYhtan
    bErgmr9tua403HP+V4mxZAXOrbW81PDPgpS8ugXE1buWm7FvY1Ap7evtZVD4K6mNsHg4Qm
    9Fj8kMSTV78iL5LTao3NbPKnKgYnggBSClMV9F1AX4gS/9lw+tmla5lJcj0JF20rOfhpD7
    +Rujctpfc2GWTjLbpk6vSLqIi3WE7GgLOT7q2/7tTN4WjnMhZGAoiVRh4EEFzRHt8wQCr2
    C1cUl3nLAFeCR9GRMe6ic/7COhTjmLC/RWVEwpRFDng7qOgfa/1lQdwMhqQ1xg8IhrpBqV
    bVJLb8qn7tXXxzZa/A8DuvmyQOFJ+tR7kpUY02GIDt8jAzalzPxhk0o0p73cVeiPW2f+9Y
    biTYJtwFdlQE1TfzMcy77YNf2wlLcecPNczYV9G0hopso67zU47aVoPEu7zJaewl7VAkny
    w5yITM8AQ61E72Tbd0ja2IHVu7T/eazI/pojBf/sCBt64YZopFtjc7lCv/1Q
X-ME-Proxy: <xmx:a9ErauSHL18CC5zWQ8nNQPSQ2MdWWxBzkFNd9hAAEXftVQCkYGSxFw>
    <xmx:a9Erau_xggnjhjYzbaoyHV8D7fWloMpCcB0qQOSqy5RUDKmNjfITnA>
    <xmx:a9Eravo6qjhnkcMzF_eCHYcIE19sMX-rIp4lUqovsYXey8Zdiosl8g>
    <xmx:a9ErakW-nBpn-LaZnMreQbh7A8k4EY2rij7RF9WVnlwGU1m8CIqB-g>
    <xmx:a9Erap_LtwGFVSlWRxtH6Na7kdoRRW1tgwHKEGkGWyrq4VUHlMAOVCoV>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 05:29:15 -0400 (EDT)
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
Subject: [PATCH net-next v2 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
Date: Fri, 12 Jun 2026 11:28:51 +0200
Message-ID: <20260612092851.2141782-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612092851.2141782-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260612092851.2141782-1-niklas.soderlund+renesas@ragnatech.se>
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
* Changes since v1
- Rename node ptp.
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 82a7278836e5..4f2844995c44 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -603,6 +603,15 @@ tsn0: ethernet@e6460000 {
 			status = "disabled";
 		};
 
+		gptp: ptp@e6449000 {
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

