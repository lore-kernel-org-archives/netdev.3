Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E247DFBD;
	Wed,  9 Sep 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963084; cv=none; b=cgR4jHgsj9l3fEs+MO359+B5StpYInB+Osr73fBTZT5ym9NHDMytjnM1reC5olMfOFMfLRv6E7LqB2yCJsS+gFrSerSXgJP0rNWXPoFfoJn2bkEc2yo8JUgASVtFUK6dL6dOw8/ejNK1OCcHyFUuSOMfVOoCIX36rsOguVcGzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963084; c=relaxed/simple;
	bh=8UZcZJFE0ZJjSbxEMH1gzEs2SO3POEXxd6LWfafuw6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQTk2POKF0sqWyxUucFAuSNXWf7ZdVYBb85H/Jo3oAohVvGbMrmIDjDVRK+BQ55BbELGY5kTTOFDZAJaXeByv3SebJC18vvdaK+vFS8BwyQUR5q9ren+x0o0o/NCnyLHfr4sQAWx0VeHku60Xv27o1m3xIYCL52mmIjx196Wi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=nrBrNkWs; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="nrBrNkWs"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 816FD3F6541;
	Wed,  9 Sep 2026 16:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1788962652; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9+LSfF6WeN65ydsS+fKszA1mpUfPTI0QyNbajR7Gplk=;
	b=nrBrNkWsqrh66nD0BCrdcjtORe4Wb5aAWoTZoPzY+cBWn+xeFxQESe7ab13tKoNH9CdG2a
	8u+cwOAFL9ZdWY3p5dEGBLi7T6Iqi7RAChpkYiNtra/0K2NJ/BArzNBsH9zKj3yvcApDVE
	WUY0r0E6TcHvnNbQ+2WdpE9/N+Ek8WoPVqTERguR119evKRSmdlBcR7QWAPaMWmfmDRxC+
	kzyLRMe6Lq9BOBv0rBEnGd3mSxZxJ82EyAWKAZcTe8hJb/FMOjKjLW+VAIMNJYxrmeoaxf
	X4EGdMdpNnxe3Hq8EUMv1/L3eg5uUiPLzU7R8eX+ixC5p14qVsZ1lSPuIsYzBw==
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
Subject: [PATCH net-next 2/7] dt-bindings: net: dsa: mediatek,mt7530: add passthrough mode
Date: Wed,  9 Sep 2026 14:03:41 +0000
Message-Id: <20260909140346.2861572-3-cjd@cjdns.fr>
In-Reply-To: <20260909140346.2861572-1-cjd@cjdns.fr>
References: <20260909140346.2861572-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MT7530 switches can be configured to blindly pass packets between their
CPU/upstream port and a downstream DSA port, in particular, without
altering the MediaTek DSA Tag on the packets. This mode is used in some
integrations where an SoC integrated switch exists, but a more capable
MCM switch is added to effectively replace it.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
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

