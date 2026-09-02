Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64923D3D09;
	Wed,  2 Sep 2026 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338842; cv=none; b=dEXqviUKlxEnkkFsZJnY4Mbm/LlmLwkBdQ7N+rimPJKHIoBNQfyo1LbQwxwlZQn+NU9XTYVnFoeLe3PjWdhTgASwq+pUpF0i5FE25T3DeBuZh+v0fVv5C6y0edvRJ/v8uWJhfxQCp3dV8UQBl4DN5FnZmaxb4gIKPHagQdXtSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338842; c=relaxed/simple;
	bh=hSAdOWtlVWhEw5isQol0W5FJllngNHJ4Hq5nmctpjro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8CHWSWiHxr/BK/XZkCOfhPzAWHtIORsB9l8Z12+G4kouZuMzzVeVAvi2vqZ34W4fVe8CHaX2OXOShiCH9g0WyhtruD/44ASYK6yVpoODyXa94Cp4ArgoPsPqRqxQzOd4rcmuEpKFS6Xv+OOroto7zf4RuIn9R9WsZ8FCMOJRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=EET658Wb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L72O/Ky5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="EET658Wb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L72O/Ky5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBD9014000E1;
	Wed,  2 Sep 2026 04:47:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 04:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338839;
	 x=1788425239; bh=T8k+avs8lR3xZvvDuzR3e4makBnhsvUEK4t2dzJBoIE=; b=
	EET658WbgBjBO8sU+JJfilvY9mI7V3RzQUxSvsjuGknc6tt3p39ZJsnqMsC4Cg+L
	qsgxhay4mMiD75TGXOYOhZn3GG7Qo2USnRw3J1xT12WkqpwuEPjgwF8uW5BY22hO
	F2JolEz/zC9JDhQme7yz0BBDNUIBbmPFXfg2lfMjpH4oHbLZAXvOqYWYJeu53bPc
	hJmsgYkKbHr+3hxpXkBTs6mM0svAt/Adth/89Vxj+Pc9rJJIcAaSg7uk+pdRjA4Q
	5Ld2b6IvETFd9eSG7MyEcivP3STZ2HOUIePPCxbOEcXdIFDmkW91NjHWOtkEnd4a
	6OX0fUR3kcnCFSPVc77u9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338839; x=
	1788425239; bh=T8k+avs8lR3xZvvDuzR3e4makBnhsvUEK4t2dzJBoIE=; b=L
	72O/Ky5Imu4KHBYT3fBDE1C4hbfeW2sRoE/XC/JFRYCb+tOTAeGquWb8XTYv/ybo
	FnE04rCn4L1/mfQ48/IACCtzkHCTIjY9cNa8b+Zau5N2EtbpY+GVZvPBXbJFt5UV
	noFH73YdZrQZ1IzVNN1lS0vEbizssKJwlNfw+r+dFrHdwYtg92yTn2KdPIO4mbh0
	bN4V8TGC9LdQ8Wn70xH5OzYE+MyEsFo0XYxkAlO6DH52zmvYSaMZD1c+ud7VQVu+
	fOkrhjnNae6GAchet54ySxJf8bpnBbl+b1cQvkHMSlAOBnDdSKbGfrWgBUl3fVSX
	SqecHo+DC4Ts+bA+DvV8w==
X-ME-Sender: <xms:l-KXaqt9Syo2xci-Pq4jZAWOtC4sKg4ESPNUpOwJkXaulKpFZDpP5Q>
    <xme:l-KXaoO_2JWXF2WJxc5am3nukXtKVxMQstjT2e7_MQ6qtU4H1RzuNb6uvLe46Iadg
    ieabTgAooqWBNyOeRmjQuzHWELa4g6Ta04tPNziJ5HpKGVcN31YVHg>
X-ME-Received: <xmr:l-KXakdcvPoRgGgICXkYOSuh0Wc0OGpJbrvZQGq1xysMyGUG9pzwjjpp3AApaCwubp5-2MqE16ZKg4IebV3n7SuO3c8s6Wg>
X-ME-Proxy-Cause: dmFkZTErXYyCsZzfm92YrYcrxv1EBH+3gGzXCytSVYtChsjw1I8nxza/1mVbG06NescpYI
    ijrlhm4QUzIjE1Ta52G1XvMSZ4UmT02/e9XVdS0BTzqvoykuwFxy/egHwAHuIK5TsZWqyr
    6u3rd2F6xKDzPh6I7UI5M2Oxx4x87Ag2ZZpCVRRu8f911TqF5Cy2xNLpzpgkOb8q9nX6ps
    mmiA5czZc27unSRsWpixJ3qrm7f3jL54dMR58K8niQduWDuh5XpAPG0F+2ZvDE1zMXgnik
    DNhL5F/TPATp8CRF168TAMl5+ifcCsryg5QvKT3wCd71cG9Vzl3KCg/O1spMcDB+VjotQU
    s4acaZ5ZhZBab/O6ldTB6L1hfQwSGHeiuP/N05wIu+sjyI1L1XpirQdRM2VShdeBYvD49z
    zNyuCfq3dn/zqf1nUQ3lJNYDyc+FwYWRCtNLGVRGkue/h/bhcMfVKSKRodDKnkc4Burn84
    1xbJ+wqp6JIMRWY2YJnud8COtDLfn8F6w9eh4by/ZXOpRJoGk8jQC7EJx/UKbmFHmSA3ta
    lBf2jNXaqFrDUzgPeYNBejsEnt9svFr+V0NsepfCGdB6n8ySQLAq+DNVHDk1epBF+tx50a
    pOhNBwED60yiLSWls+LGGqidUUr2IHfLCNC0pnt87t3kZPsk2EDGUPrSwDCA
X-ME-Proxy: <xmx:l-KXanmrqQLc-YEUFmcDHqtavybfUqGHOUo9A5Is_JQ4EjADJaN3xg>
    <xmx:l-KXaux3jy-fq0R48f8gzsJHrshaEk4rmK3Xm6z8NdY1KyDQXR5RvA>
    <xmx:l-KXaiPOWl-hN2gnLQLC18YAHxbmrtCCPzDzKEMOk6ObbDx_UPjj9A>
    <xmx:l-KXanhAx6YKiwU-ZL86sj4e6Ra3d_aT27to2BrKbhvP1ac_zOqyJw>
    <xmx:l-KXanmDzuhuyll-BfUXQuhfA7d5xUvQief4ziYILLAIrFcPlriEZru8>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:18 -0400 (EDT)
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
Subject: [PATCH net-next v3 01/10] net: ethernet: ravb: Remove gPTP control from WoL setup and restore
Date: Wed,  2 Sep 2026 10:46:54 +0200
Message-ID: <20260902084703.3228504-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit a6a85ba36fd0 ("net: ravb: Move PTP initialization in the
driver's ndo_open API for ccc_gac platorms") the gPTP clock (if
supported) is stopped and started by opening and closing the ndev.

This makes the special case to stop and start it when resuming from WoL
redundant. As the ndev will always be closed and re-opened when
suspending and resuming the system.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ea1c7e536791..36173a09e2fd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3182,9 +3182,6 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -3204,9 +3201,6 @@ static int ravb_wol_restore(struct net_device *ndev)
 	if (error)
 		return error;
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
-
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 	napi_enable(&priv->napi[RAVB_BE]);
-- 
2.55.0

