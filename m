Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC1372B5E;
	Mon,  3 Aug 2026 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750777; cv=none; b=hfYsHq0u6VZ1K9ogULBa5PpP7RrOaOYMu/wZzEhIwGsDZ5fhriOx+JRZXSwb6q6oLbm09+knABlTsFPZy8AmZU17TPxBHbe5EmoI2DB1BF0jSnLsMkydJhzc0y+VwYLnEmgbOLDJNYuHbO6Ez42m03Px/b2WK4OwPL3q2+/7o/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750777; c=relaxed/simple;
	bh=PpoJ8mSDeO5J500ag0sun37EeE6AvIqeZEsWDfHGEXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxK0Yiu42EAdLzURC6yUl1Pw2OIpkmqbZdxGgYDe2y241kNTmRRlfZAU6C9XCHDC0lDmi/hxhajl4t4WQNVnIPWsucw8DtnlAT3W10arg/9WvbumHBZglngm0vF/H8RwBfdot6WW/YOGARGHgcCurRWfDJ8kzJnRJqL2pyzhIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=Obns7FDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TkKRScf4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Obns7FDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TkKRScf4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id ECBAFEC010E;
	Mon,  3 Aug 2026 05:52:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Aug 2026 05:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785750774;
	 x=1785837174; bh=sLmOrxWgSzKesbLl24YL8N9oK1UdIQD9gnT9tarZDw8=; b=
	Obns7FDwMh3/0IkS1sdALZiAVY6yIOgARv4ntkPVHWg/cl/Poiah6uvHVMnFIzD/
	YRUIWlWKncd7R+Ey1xAsFQBNzMBl63+PzFcWhuM2SA66u+SnsBvUfGG9aXSHK3cx
	3tr3nxcWM2rcCdE4UtZVFjD//nVC28kWsSxXQ4mh1Pd9jahWjo5ImoECKTC8Lv8i
	4RR86uan4peBzwlc4Q3LQNI6LMcqgQD+B9SL+ojLfiKX1l/1+hWxCZMkFxss9HE4
	LJYw9rCedtrfIVUzIqqZwvPSwt/WDaM++qAZVIeHvycW0y0i1d8RRyMQZjffwe8t
	6qA3imeAGuyNT/jjghxP+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785750774; x=
	1785837174; bh=sLmOrxWgSzKesbLl24YL8N9oK1UdIQD9gnT9tarZDw8=; b=T
	kKRScf4zHv4weOG59WM4syRTdzb4v+Lv/mxDMtVgmggwIhxkZ3xqKv+34gPiCkfy
	sV4/rvsEj74Rw6Ra9a2/7va3vc9yXKhfnSYoBul+v0Vz4EqYYmHPuz5/iuuLLzW9
	Dcm9XZBxxWXkAHbb79gdM/vFeQFuWYe9qK3AnCwo0wIGzelMnx6GYWKLV8Cag2bZ
	oe6wxdNQmZi4jFNw+QC/oa4IIPUOLIh/om27bpywlBLBn8wPvcrtPcMCOhXnMdci
	Off7DBS4VXIeb0Bw7H060NZwTcIJGhQedgC/sI3kbULcLy3UrRoWrncWM0vQsJRp
	qK1d0vf8+YODc4JKJGw4Q==
X-ME-Sender: <xms:9mRwalmx_jDMR5CimbNSL-sOWjrngjOzUa1A9xQBGiifGI2sJ2lNLQ>
    <xme:9mRwatJCVQkP_f0x46A8eIqDHKqqEgMI0UCwkcDv5B6OZpjsAKxvlUtF1JucdqH2b
    O2gBZjVmv_AjyOwyqGg9gsZN7V5SqL8TVch34C3JTbVkMxPmy_hU04>
X-ME-Received: <xmr:9mRwatTB4wJ6TZ4bkwFgPOcS2zVeGDeAtxHcbsqEXmotV_mkEJ57YRF9065OCizxlkSt9BCwbGS_0S3Xa34CXB_mZMRYig4>
X-ME-Proxy-Cause: dmFkZTEMQcaLM4G7F8T469MzRDySTwXwtTZysuNZjG7d4SEShkbR55q6QEQYGLZAOfR0W3
    qX+c43CkoJp43hQ6+MsVG2ar/Ag2yll4kAu+tgP92WQPNQ+ICX5OXWzmzry25XoTaeiSSi
    CRjCq71qJmyfPzHorRZG1zDyJX1MflxVa1L17BL0wT55CnSW9YxMJVsOR2/ZWIUl1F1IYB
    8IMFcEhITOkAmbFKlMiGhr5SqBJjG4WwvcHbtmNVPr/LrVQLolB9g6Zjr6kj/s/NP+Hk9P
    niawvdbMWrOfV9MASYvkC7mreMxSiwzbYiAz99WaGHhhnNasGaXyhRz74r6qR2jaCKmlf1
    XkaGQ19jXyCwOuEdQoFGoVM0FFrRwl6lbhITtRyqfdCuBiBwmQZGzSW3eu6t2eXqKoXeck
    QKB2jjmMR90gsZFejg7AItDdb5rfsYtgiz04mcLEWghxpKXVNOXxNl0YQOTcbO+U22BBUU
    Xu/TegfRUV15xJaFHQ4tHvLmNRmp2OBKlTr2qBlUyiBcENsG1ZpM5H+vxI65VwUafR2gUE
    TwpgkJoB3xDdIqdZEYN7XZbhJvHk6yYiaNQ12XDNwgZSiEmdYGB+I3Xe1sL8oqZ7WWQXYM
    fNBt3gsR3nzrDBPuF5WQ9XE9s1aLoI3vBt2xc7SyUS0k9Xuk1pcCEdshk2fQ
X-ME-Proxy: <xmx:9mRwaiu-0qvUODy_IuM3_Tg0IZ5iMcSnsc-9m6VddpcDVdeR6Uz2rQ>
    <xmx:9mRwao82G9w97DhRn2MoMcm73cW7IxI103Stv2ofucffveECauhc0g>
    <xmx:9mRwaraNFJsdi1926bMAR7I3-hQJ1HykLxl06H6op_uyw95Qxuvldw>
    <xmx:9mRwakqNmQOkWKTr4arIhR3F9MyG6HWQNaA3DgGIvRTFwkRJFCFppg>
    <xmx:9mRwao0yJJSbuSkQ3jrNpfO7FYKM5ao36tbhidDx8Is-6Og2K8DMZqzV>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:52:54 -0400 (EDT)
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
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v6 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
Date: Mon,  3 Aug 2026 11:52:32 +0200
Message-ID: <20260803095232.3527111-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se>
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

