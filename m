Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B23F9A1A;
	Tue, 15 Sep 2026 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494432; cv=none; b=fL5caH/qjFu0znZ2tEBiO62WZoECK0NgtDA8qE6zpfAyz06jw02LaoqxKJ85XSuj405K5G0t6MFVdE8BfAUPKW7PevGYyj/XNh7pXygTuu/VM9F1sjCon2P4dKmnr6/vO6AMHKEcAxwUqkuwzl/EIhgyroA35mMp/StMgHWSVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494432; c=relaxed/simple;
	bh=8UZcZJFE0ZJjSbxEMH1gzEs2SO3POEXxd6LWfafuw6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X36b6yp+1x+pSu4b0sIesFeKidhPOPRpOldTEG/eGADyfPLz7bd+J53/jbpvh57HFbq4jl51BY9Qq+RJ0TkOsQU/JinS5PSmVyJON/XYitmZcrsYAqQJXsUtqnRZm6zaCCXs47pXPflzSe0nwU12OlE2HGC8sDzZM3PB0up1deo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=DcBGrstM; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="DcBGrstM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B36948F1D7;
	Tue, 15 Sep 2026 19:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789494425; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9+LSfF6WeN65ydsS+fKszA1mpUfPTI0QyNbajR7Gplk=;
	b=DcBGrstMfLx9yoDYxrN/8CrGgrPZ5Q4XJs14cpcSavxOgzq21UuhKFhZrDP0ev6EsahPyX
	0iPQDXTfrmRoa+W3cvkWSyozvmH9luEptcqX3rxK6L84MvCzddcYauD/fT1k9YrNFDJFDr
	kDpa7fYzFjVC9Q89yzqxMqFYJROZfW0r+UG7Jr8HnOVwdaV+bD5tYe2+XeXZsEuktp/1Qz
	O2Q34pdpzVS8UPiCpIkcIGEuYhIs8LC3eNrpk6zgla+tszhz2upnMN5wmUEzg2sn0ZcqRX
	8BJ8kX6K5XnsmTyrB53IaYTJxVfHt0ZzN43iULfcOLTQnGSf9wJH6e3V+qldZA==
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
Subject: [PATCH v2 net-next 2/7] dt-bindings: net: dsa: mediatek,mt7530: add passthrough mode
Date: Tue, 15 Sep 2026 17:46:38 +0000
Message-Id: <20260915174643.253660-3-cjd@cjdns.fr>
In-Reply-To: <20260915174643.253660-1-cjd@cjdns.fr>
References: <20260915174643.253660-1-cjd@cjdns.fr>
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

