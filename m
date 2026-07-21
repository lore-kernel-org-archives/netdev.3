Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A7368264;
	Tue, 21 Jul 2026 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640657; cv=none; b=lIVLKjiYgeN55cAxSC36rkQR6BUZWQVgSyPDDb/7oC90FxUEDmYi3uFpetycWw0E/Bvk9a7A1P/x6kdEgIvS5EWyhod0W/Yk4j/nbCH6ZkRMs9aJgzcDUVrIP00TUCw19JvXIguC/L67CHdYYlhuEW49JbUxOhcMRYOqEsNZbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640657; c=relaxed/simple;
	bh=PpoJ8mSDeO5J500ag0sun37EeE6AvIqeZEsWDfHGEXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4r2fmZBJZXLR+4MAedboJcXicGk+0wBHqnA4WChp+/tqSeY/6a6cJRbW0as768EVAvsnooxWPPz0oPIpKQEOhjJd2GNVcXJp7Z+bgQ10e7ju1XeYY5d4cMXkDCTCmtwRkk8DfrVVOOITA3B8CdvdUniwRykS+8/rUW6wSRAHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=eYDWfoPQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4bG8ymx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="eYDWfoPQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4bG8ymx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B3641400159;
	Tue, 21 Jul 2026 09:30:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jul 2026 09:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784640655;
	 x=1784727055; bh=sLmOrxWgSzKesbLl24YL8N9oK1UdIQD9gnT9tarZDw8=; b=
	eYDWfoPQh9R3Kibc06J7RGhh/IoxSBUWqh0k8XX5EvTvsJEIXPe6sfqcrr7Par2/
	JuzlX/O0d1p6Uu8eR2Vs0UtTSVuYmMW2j8RaLvTtIDxPiauWV+DL4tNrtj0NEIee
	LManzSnd/0vu0i0nTqLyjhKY8rABBByBidBGYB2/sKZ1raevWuF2ZsEFkyId9LRI
	OMzQ9QdYJB5a84rvC1cdkrzxoQkQheARzj4MBL92asGS2D3MuvAtbyVk3gpm8xr9
	LOhcPlV3Nz7d5Qou4PjMCIM2NDCeHQ1l6xb2Ra3E6Rvtld/BuQ/wiIaMug3w7hmJ
	4ChDP1tsyYrifzyJwvjE1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784640655; x=
	1784727055; bh=sLmOrxWgSzKesbLl24YL8N9oK1UdIQD9gnT9tarZDw8=; b=Y
	4bG8ymxUVuDF3gD/cpLCsBo6gce8jJ0Ch9Y1+kPP9pFdj+y86xRCnjC3WWDhxbnA
	ssqCvs2vGpxJu/azdYNhM/JBzOzPUXjrhp+MGmUoh1zXQcxiUX2A1nS3phBLcKSW
	DAvHPRXHByEDV6vR5KROgUgU8E/YDvQ1cjpwF4xUCeANYu9vXI3mfdOkARUCMK8i
	En5EXfIMYuSoPzk+TA1RfLhjdqLlU61gZJ7IScz3hio/8zJS6Xb65Me2dlekEz+b
	8oK0vpOSgSies6Cg01XzfaCJ51+Orge7FNS7Uhv34FQsXpCi7hPU/ILgP2wKd6My
	bs5WGAsri8D1P6N8zJnnQ==
X-ME-Sender: <xms:j3Rfah7j3P3DNvPorYjKrsAb7fhv-P58_wmS85i-Jsh6zGxJCEGbXQ>
    <xme:j3RfarNxQ5wbTim4iqqG2JdQAPugB4TRnH68zeGny0oePbFwCjugabqhdgsN6cuUd
    fHHOecyNpOovUcByHHw-Wws-Xfw7c6iwGd3ElpeQuU-OHOvKura1lk>
X-ME-Received: <xmr:j3RfaqHd1-UBbKFJbjtbo7P7BxTdZvzI90MYvKO_j4NElD2L9DQNwD_0txMAN9ptM9njeefn45Y51b2DWXU5R5R9PNTZ5mw>
X-ME-Proxy-Cause: dmFkZTErwjElEy8690l1ycSe3BvSXuBXSR0Jg1HpWthT0P2RPmGLUJJni6PIk9RkTYSob6
    G91jjkTE2CSoFyKQK/b6DxQl0FA/SSSzTqZad3ZyC45OwiOumHjl/bWEJCM1isvpNRN/jY
    dovoY0jrlxkD/9i41qhlwKYMplntd2LQWiwi8wfXVm/OuBrBhY7CIUnKIYxPi+ICcEuDS0
    LsH4PxP7uCIBRudSa+aIYl2ComCj/meCak5H/XXeOTop2i9TSM1aGRDpjvPerYIIIAt5L/
    qfqQ6FGW7FhxDVq1M28/hpcY1fdPyWUpeiDu1kuxoiJyffvHKnW9Wf11GZ+nZYOfDh89O3
    ODCbG36c9UxPTzHxbfOqmPQxs6fGt3nWeyAJoPDgyBImRscLHb8OFHPkXh92PzuTDBymTC
    SiCA7xWxX9keKHfh1qkeUtSTTWc9ihIAR/WPh9sMRQPf1kcoxjitABu1ra13fjlvti4TX5
    ALzmZ1FfwC7nrj3YWXGSO6Pr28vjHP/xRUwt6rYp/bgsMZM0vgqvvU3eSH3zzjFix3rzR6
    lDhXI2PjtHSn3P/yEyNFrbI9v+ctbCX7zmM/I2Gr0UmIpPF5DCvsCiIzePikUKL62vVwTd
    YIC0OjeiWhUPpk0TVWoNRTvh/MGXtBuBz4Fc5QBHwYSwRS/JNr3Ga5nrvgPw
X-ME-Proxy: <xmx:j3RfanTCuAUqzQT-yEbNUhtzm94D4XDERL_8eGH10qEPwJjhOrIH4w>
    <xmx:j3RfaqSfMAwZ0KPeejr9zS9JVMHVgudvjM39q02KKOJ9TtsezFek2Q>
    <xmx:j3Rfaqcp92U5wWrKVx4L51OQGFcXsZAmuGdu6DGnzIWi-kY_jsrb8Q>
    <xmx:j3Rfaud4XL66cBQy8i2F17jF7wbZu575WOAuGZVpLHsiGq7zQIVaPg>
    <xmx:j3Rfai4SYzkInyS4oyz2GM6lrlwE-2MWnidbqRI17ypbFJnl_Ry_IaMc>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 09:30:54 -0400 (EDT)
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
Subject: [PATCH net-next v5 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
Date: Tue, 21 Jul 2026 15:29:36 +0200
Message-ID: <20260721132936.1331318-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
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

