Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150029;
	b=mlTxL1u2T/64rpOOsZ0sMGv6KON7A8tlyXi2GKu4NTtfUV/hnHwMd9+ngEoKetLOrOYl
	 BU2PEVwRDPMkoEpKKcY3Gm8EmOeL2QJhI3MN2B0XsizueuFPZGB1JIpY4vD5RfB3DrcAW
	 +qxwLtN3Nt6R0moGsG3lYBTzcZS0ykD5ybJpmj/uanVa8JWct/ypogpCJxeuHtXxaC8qm
	 +RWs9dDiPdAlujGlJ4YfREdgTNqy0Yab96Fi6eEkpOnRArvzYEQfnuzvxZaGBXtvv5IrH
	 mdk9l3cwxCe5ilpx4s/AT+OQ6hYhZeYnkDdfG8rayM9tZMfHDaZdrtnV+YYeA6Rp4bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150029;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=J6aXW99GWTcAFmCDZ2wgLoJAYDS3rHe4uZHX6AbQbjs=;
	b=ZPukNPGubcwFJlwxTfNNERZ+LMV7AGQHLoeaTDyZqPA5bu53R1kD8Cs9F3p12O5/yxng
	 qkks81PfiFdBG86/uvCFMX/gQvrbv2sVxpd/O2OVDNsvla49nQeETbbqDAzkBGnUicauo
	 6XcQVRGhUcP5WZoKqzvhktr8hhnwIjioqGuBQtHmaTpd1iDk+w54Xs91KKkkevkwBo4Dd
	 JebCDrvzHs/u4olkkTHCVXf+mkAi9tAAQ0nQm7+uXmM4J8XUmxJ1EdF5boFwy/RNYZeto
	 cAo+HnEGlsgLE8z+oJEqBL+XeU5cdx2WHf7OEOlUFEsUKQQnUojXJuAzvubx5u/28lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=tKAUV4BE;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1D606A31F;
	Wed, 28 Oct 2026 01:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EF1D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=tKAUV4BE
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8ECD61479F0;
	Wed, 28 Oct 2026 02:13:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793150026; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=J6aXW99GWTcAFmCDZ2wgLoJAYDS3rHe4uZHX6AbQbjs=;
	b=tKAUV4BE1GyUCse+EdtqNrBOc8Ja1XIyk5fQl+YYsW+/8zVbrkVWeR8IFsVEQAxEXdKwcy
	J5jhXqGk3rPkA5c9G7i3cevpxd4FMMb4eLSIXIcoqs004os5omMGVdMu5cC2hsFVVnAfkd
	NIZ6TPvg1YA9mUzjLVLzO8PPx3eIICSOviGW5n5gOo8sn2ka7Xo+UiCb9N8SKUbsoY40mw
	zt4q+Ghn/C6Cf9sy4Rl9WQDbUiWg2ow+++RzTTOGhBnIKsJTxdClTcE0oSreFGESPtO5XE
	ieNlTL0/wYnC4JjjJWUSbyPTOEBCTXvOfmFxIfq1fzo8+SvhdC57CncHO1+fWg==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	linux@armlinux.org.uk,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v3 2/7] dt-bindings: net: dsa: mediatek,mt7530: add passthrough mode
Date: Wed, 28 Oct 2026 01:13:12 +0000
Message-Id: <20261028011317.1557238-3-cjd@cjdns.fr>
In-Reply-To: <20261028011317.1557238-1-cjd@cjdns.fr>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
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
X-Last-TLS-Session-Version: TLSv1.3

MT7530 switches can be configured to blindly pass packets between their
CPU/upstream port and a downstream DSA port, in particular, without
altering the MediaTek DSA Tag on the packets. This mode is used in some
integrations where an SoC integrated switch exists, but a more capable
MCM switch is added to effectively replace it.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 90b3582b7619..e29fb8693498 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -73,6 +73,13 @@ description: |
 
       Check out example 7.
 
+  The MT7530 and MT7531 switches are capable of being operated in "passthrough"
+  mode. In this mode, traffic is unconditionally passed between the CPU port
+  and the DSA port which links to a second switch. To use passthrough mode, the
+  upstream switch is configured with a DSA link to the downstream switch. In
+  passthrough mode the upstream switch is restricted, with no other ports or
+  switch configuration allowed.
+
 properties:
   compatible:
     oneOf:
-- 
2.39.5

