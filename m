Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE73F44C1;
	Wed,  1 Jul 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896802; cv=none; b=OODrttOA+O4KhPTfF7MNgAhDbHvua+0UkM4p9JX9KjeqW2+bOJjqXcO+tLc5iVS0xAqZSuK29ydQNaYItmYrk0UCPCXXBUN8liwBlK2uYtZTRgF+cHgnQ1HE4lqrWHAF7I/Nv6SMUyuuqvO0h80PIPbl7ctQ5whHAlJOZijJzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896802; c=relaxed/simple;
	bh=PpoJ8mSDeO5J500ag0sun37EeE6AvIqeZEsWDfHGEXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CA00f4OnK75zfEKruEHVrbLQvWFM58doxwtYiJugbwR65utLYeeGNG75tM3QoQVK4HlVvaONCcHE0DmMUJ44044gHytDvhZihSMRSFrAMv5A1MQXR8JRzb7Qh01U4w28ITUfzar89Q81JpDC22eppcmPv9YzP+D8UnvlE0512fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=QDP1ByMd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fpkDxINm; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="QDP1ByMd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fpkDxINm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45AD97A0082;
	Wed,  1 Jul 2026 05:06:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 05:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782896798;
	 x=1782983198; bh=sLmOrxWgSzKesbLl24YL8N9oK1UdIQD9gnT9tarZDw8=; b=
	QDP1ByMdIb5LNNLtI2fXmym/82zGQHpJBAI/+Z1vobMjnHN0kFmVK7hWOj7wFuqt
	j7nsYgRP+3zMujpdUCS2m9GOGvmFWA9re/ZiXiuAlSRSoifkQ2pf+tEabDMowtCm
	PAnuwPJYFklLrPn7D8JbNxvm+uuZopCJ4Q3HcdO844j4EYahGVFE3M55QtjO9mOQ
	m4NneQiZw3QibxLNJzn5atUBIbm9JwiCwA+mcgSVdoHDC0pVwacR/ZMF1YWkjX/K
	ZHhyRFCLppWTgK5BXxc4DDNaRF/m3+HkxaDq4h6vvx2ShZkQvALroflHiGj4zdFE
	BnQ9RP3Im3T/K+MVAnQuww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782896798; x=
	1782983198; bh=sLmOrxWgSzKesbLl24YL8N9oK1UdIQD9gnT9tarZDw8=; b=f
	pkDxINmhHi5jvfinybWRpTYhvQdl0/hY0hT1zCeg1e/ATQi6ksag0Zg23FRzyvfu
	eXKijM37rFSzWRPEFcIzD6rnyZlwW140zkImlry1GjsKKPVgwkdxHn25LM85G0n5
	2jYb/GfFzdEebWhrK43CJ1pcX9rTsuGI5N67F8hOaZk+v7xminO/zt6+cQ6kgW7P
	1dZn1zLYMNWfQthb+yaOj4AmaBCUYGwtF9ShJHDqtNw6snrSqx8APfZwT4AQdbwm
	27z2h6Y2E6Alfv53zM5ielfSD1ky8BFDo3Q1yNtQlfEWng4ah9LFN0BMGZNZS6w5
	h3eKTjs5oGdBcCFGhi8iw==
X-ME-Sender: <xms:ndhEav8kbmMOeRP3dMEwUl6DpCiepzrTNtIUxeklOlkTi7Q_-kZtbw>
    <xme:ndhEaqMYvWegUpxV9voh084YSk_ZvVnADMHz0nVX2rihqb80Wsa8jLM4xjrDQTKnW
    17C1GuhBPbF42y70L4hmKKHTgTiyQuz6KKBjOFYH-0t0ngC5x4c4UE>
X-ME-Received: <xmr:ndhEaj0L5pVHwr_-kXKuP6qzLp8_6WJhyy57AoS_DO5MuUFZ-uIpwK1bguYdeLqLg46LAA9H0H9eUiU8QFfH1m6sPCqmojw>
X-ME-Proxy-Cause: dmFkZTE3rKKFIjc4Iepj+RaZEOhnLwC8E6H+Yt72l5YB2RYF8Pr6ijJB7aPe5owdrAqOX/
    qNL90qN9LAM7d6Nhlg7Ldx3deWklWD8cVGuXYlhWC0+2rSgHyy+T/zUpqYdZrK2h6yo8rv
    zCLTAXioZy4J+zRvqZ5u+W8Q05hLHPm0phB7T6a+HbETUjmRdsyvGqMiUsxrNUJdybsduY
    4DWX9Xlth8r4N8PpvWvMevx4aJHyQ3LfMk8wH/womvO2nV65Zoc3jyD6AGQcNSlF5hDDiV
    FREQYyG+pPqI6ZcQMMI8zX7ZVWqgSVzBWwFDVIK+fyQrcP1cXSVxdCRnJ3yaWVAKcW3zR/
    6D1+I4xSQ8F/77KvOs0YJWdZUYATN/2pnRZVQIXlgtflN1g6oYgTulL48mvbpCX7Z6nTyQ
    pcwcVxYB+Jx5Mi1OXAecP/bOgMQHDLzlkuxmSKVv8hhg73rzcj60JcyPngbzxV9ONIod2q
    xlIXN6kloZHzCeteBfpWDuRGTqlIqQ7BY5EN/dnT5S4I7Byfz+RNmdMzRM75H2t5ypM3wo
    00EylqTjtchR6YOJMnE16k/SJK6nzAvfqvNSy3HHYuwNwjN8DdMCzKIUJOKaQS01rgSGZY
    PTeMHJWpyskQF/fel3El5SnPuU5wXdzclylhcFOkwt4CrWnrMJukzec0S1pw
X-ME-Proxy: <xmx:ndhEarfirZRfAOAgaUcBM3ngMfg6yx2Z5XTuk_kuPYH5RX1nf23zUw>
    <xmx:ndhEasYvbQoH0xDwlp3qSYc9ixkqWSKF1g2ixxPhDStmFasAuL2yIg>
    <xmx:ndhEaoW5KYRhqOeYTpzEsu6zlhYLbBKOsm1bvDR0B9yYAb87VU11uQ>
    <xmx:ndhEanSBuv3HbxpZMlSPFsG3rj__RtyWmTBIRg6tYGi8cg4RP2MH9Q>
    <xmx:nthEavYeTZlQ03gzsclzGf-dV6wzaWLHd9QM2g4f9xQSIE36EMUuDq7c>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 05:06:37 -0400 (EDT)
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
Subject: [PATCH net-next v3 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
Date: Wed,  1 Jul 2026 11:06:07 +0200
Message-ID: <20260701090607.1108208-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701090607.1108208-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260701090607.1108208-1-niklas.soderlund+renesas@ragnatech.se>
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
* Changes since v2
- Preserve sort order by unit-address.

* Changes since v1
- Rename node ptp.
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 82a7278836e5..b9b860ef7035 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -589,6 +589,15 @@ tmu4: timer@ffc00000 {
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
 		tsn0: ethernet@e6460000 {
 			compatible = "renesas,r8a779g0-ethertsn", "renesas,rcar-gen4-ethertsn";
 			reg = <0 0xe6460000 0 0x7000>,
-- 
2.55.0

