Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7F4E1C82
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399599; cv=none; b=jfuPBkYU1R/OXQBs7ZNwu9VdD0mtDjq4+ARhKmjTE9qxjLQf8GP39qfnfTj9+Dxe50JRwZnSC3iQhBDTRRIVQWSyiazC1Bi3NsmNj5YiDalr5XY7IZaqyQShnDCDsc4PmDrq+m0V/+JSBO3h45wpZPtvHe3h8QE2BKHd8YKM6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399599; c=relaxed/simple;
	bh=H//4ghOVvWRuaFQONEl2NVv9UGxnxNBHPkEebTE6LtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8ndl+r20QUzt4K7B0Mgvo6QdnKo/5WJ/EgkUtqUFkrW+ejjvCPq8SE49o4YDSbrvrrorCswUOcTrgOJLX6Gf893VGRQaoSCdA3t62DxBPnUKwXXUQkyttUqqAJMWs1iKQMrO9EbCFq5I3nEfyM4sEGVS8Unsp/hF3tcUC9Ugaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=bl7fsMdc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LwvjnNKr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="bl7fsMdc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LwvjnNKr"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EBF4140017A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:59:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 07 Oct 2026 14:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791399595;
	 x=1791485995; bh=jtRLzqX08zEUE4wMPaL6bQaLrHqTrfd8p+aue4HQy9M=; b=
	bl7fsMdcKCmcUGkZIuvm7B4WxgE0+18MD/UmxEfx2hpyHJYmmowIQwzaBEvyNu3m
	ydtVd+r3zS5eRrHPPijOWBtmJeuyYNZ+7YhmjtZezAEUMqEM1ysuxl94Xhet4hjp
	UqarRkBr+0V0r3pwsFj5LJZ5TUQkpuhSU/O0hClwUNa+y+YfeZ2JA38B8gcBL8yR
	vVxs89X2WHrW6MqjBTSwCRADOKRY/DiOnKLaib8ri6rNphF/I9eUil+efLezLHef
	NELtxcfqqwqMKL8+0pZJ+Id1eiy2dVeGhHAMXAUQzm3EDg0dsn1vY5CAq1SbohMo
	lcecNoy2sZEcwaV8mk5MpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791399595; x=
	1791485995; bh=jtRLzqX08zEUE4wMPaL6bQaLrHqTrfd8p+aue4HQy9M=; b=L
	wvjnNKr3MbvR+2nx3oS4zWtK9vJDdUDkmlHq4bGeiCzq8jkD6V3g9zHNQP+UdpUp
	F5zAmKmFp5K+yfNLYUknsGKewDPWIYMtt53/ghTAMNI0heNmf/k3+GQdlw3jQIrX
	EbWLYcWepvflpOMVhjjp7Hh5gpjLimMUx84E+fvJfaTBbN/UTezO6WkjbnyK03Je
	wnStxtAvj7rXRRexNCGiC/1MyDv09LQe17TIF6U+ZQlvb1N/si7XZiwIl2NVJh/t
	ycMm0KILtZ7aYuDFDG6/Hm4fn47QWbimjzvzTjVOWPDJiDsGGwCyZe83WaplqryV
	zVhJuWmHELSmF/wxBFjcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791399595; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ngT/SeQOiokfI5lLyg6EQ7hbXHXbKgeVxoqOqKKqxjW5Xaj
	c6R+t3K/nozNBtVKsO/4rS/kTTpuazkb99eO++IlEEm0xEokIYiu9COkJ3mtf5bG
	0yfNDqXDne4QK/w35iY4c/kTK/cxI9HeNqoSRnTKY9Qp7CRFI6L3GMNxyPlNkstO
	x+20DBO12dO2T/S2lWIWHfR0OjVIzYU0Cb/u81qWdoyrQZUUTPzw3ioo6wl5Pqej
	UYbJHH8WS3r+0ayG4NcjH2M2p1cTRYQ75ebSu29Uaolqq6E2mUi5uzqWfJrTEJXh
	J7L2zySj6pv67v/VM9hkEVmB8YQS0cVbx8/AQtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3VVhQxyG4RKazyma3s4/5oO+lhv1MhQ44/+6qRY35ps=:H//4ghOVvWRuaFQONEl2NVv9UGxnxNBHPkEebTE6LtQ=;
X-ME-Sender: <xms:q5bGam-0EyI09T_T6l3Ugp3Stf2CJj3FWUdLleTBXb5jEeNLfP4lng>
    <xme:q5bGavco_GvnUqIJuNOS5PjX1_u47Uhv7Zhjy47HwEyKBjKVHzsw344nW2W_BbUGT
    rOHOiQKYVtG43kzGko7WKGf6dopqPXe4BkklYhgkLiPZ01ZB9kqOAw>
X-ME-Received: <xmr:q5bGaqt6fseyY-4Zf9Pl52ftYuk3v9R8QMre9WCi2Gv_wRTRi5qaeUj6MkkWikQLBG5QhNP8G40TGyiXW2Iy7JuREY_g3Uw>
X-ME-Proxy-Cause: dmFkZTEe+GPPaJWDpjZdDjLEgpdDJkAW/50mgXfyDowXnz+WQjNhIXQPA8/eGnzKtDVHnp
    FZCGmTxeDXeAYZSt12mf4cq5v6bJNhiPGdkAJ8g3AJZLcGY5QXOPaIQ2SqHn5zgA7gMdT2
    ev9i7BAaA89HOzbgOfWF1BrwgmefNxGQS00mcKolPqCi1m+MNGRpBwlVt1w6jIOWQ5AXcv
    l74rnH1dJGoBH7e5eTWjd2Z/nBr2zJ3ZmDoK31ioWS1tQfY/itjevej1Dxj7SMLw0v59zF
    P6XWEEsqF221rz8IKoL6/rWvTTD4QK0MzJ015qABoASVdaTp564+GffCBc6vHOXb0MPWSS
    CFEr08smGpj24UI7vplS55KsCjstbLO4Xnv4OcIjAauAOVRbHP+MThH7yZl3jEZHs6r1XS
    39uRwveEj4flmAwjDvJMX/UlbUK03C4jQUGF9njR8vd18KTGrBcMK+l5h17wouD2bbiunT
    MOqC+zEccaa8AC81aoS/oTB/32aPJ3yUkWissiO6B/gcRb8s/mpo+iN+MeGPeuki8Z76d3
    OvxfiGIMfRx6fEkMKucIWlfQ7x7NUnjSG7vJgXg2AB7SZo2ighhUQtZ0kXcssY+Tc/y3kK
    5usFIxksq5t2Y5mwfiLnzYXLa0b/35HnHz11PuQt0k4Axl3mfYdaCG6bUoqw
X-ME-Proxy: <xmx:q5bGag10zlRI7vI44TjT-08zs6hUijYEQT-Rq8bYVsKyKjWvEL26Yg>
    <xmx:q5bGavDW3XXPwetWXDBqzb0UDdjmoqd6FQ5LxHCoNnSyl6HYY9VQWQ>
    <xmx:q5bGatfaxsfVo6t7jDwvagEdvf_069TjsXJTqUrSeqzhZINh63ypYQ>
    <xmx:q5bGahxhIv5HT9ypXviOaI9iN0lxoutC47NzCYg3dEuO6N2lT50EZQ>
    <xmx:q5bGapWbN_xYBXRyNUmCV2d1xFsst27xZvtqfqMISdGRZTnPmh1rOgUz>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 14:59:54 -0400 (EDT)
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v7 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
Date: Wed,  7 Oct 2026 20:59:20 +0200
Message-ID: <20261007185920.4042783-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007185920.4042783-1-niklas.soderlund+renesas@ragnatech.se>
References: <20261007185920.4042783-1-niklas.soderlund+renesas@ragnatech.se>
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
index 8a291447b904..7430b663cf92 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -606,6 +606,15 @@ mfis: system-controller@e6260000 {
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

