Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472675;
	b=bdWMdGOzgCtokTu1Q6qf+1ln3fM9gVehB9cn6x29ogQyLfTXV2ROeKe5gAT50xaIQY7S
	 mqOM5wOWqfZr1ajkkjlc5gRMQ/T3W+yYQu9PdVv19Bx5wcmo8JsbcwIeCvztnD7tezjmi
	 miD6mhhfMICnhk7L9B2JFJetsmutQN/LGBzfG9Yeoy6C7p+qzowtX5qxiSBo/axw6h4w2
	 uxjeVYP7RWE1au0dHjoC9ZS0gMCjQpJEhmt/6CTEvOAdTuZsmBq9lpHJPj/1jWhDEtPtz
	 UGKTkBdiVuCFewjzdDDMjuG/jJRcebkqPn5ScVgzVk1bBzC6Ko6tSiEexYSugJJIYXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=n7kPEgcFcju8u/KO+xsn8ju2WkIJSHLe7hU+C6onExQ=;
	b=ayQbW4pxB7I+tUPOV7T0NeZinwPT8po8QZ3rrwGk/BULK3+ZnHQOhxRIo8Z03cPO89pY
	 FXV7TxVyBj65R6i+P5eLKE2MSf8UR0VA/5B8RoIjzxTZx7YuaYMah0VQNjv1Le/p2/mdT
	 dtTzrJGQnnV5EM5xnL5OQLd9cSPAq72CcNQJ45zZADB6wbyelW5k46BaJMQ/EYWzsT6W4
	 zOhMNJ7hGESplQuBkFf8sXh7rW6iTGJKWw5dewoetQWcctWrCQdKJqeko3dKrqhjK7k9n
	 KFBy7D4wcMLzGPKaITWgGQc28pe4kW/9La97Rcl8H1PNOPOtzzkB9kp6YQzKjoqPGtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HYI45PIN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E2606A8AA;
	Thu, 12 Nov 2026 08:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC0E2606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HYI45PIN
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 790512023BD;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7kPEgcFcju8u/KO+xsn8ju2WkIJSHLe7hU+C6onExQ=;
	b=HYI45PINZXyJYwyzTMfQyYLiDqVyQO5UJpHx/kEPpnprGDwke9iq0Me104mR9Qzga7kfXj
	ONE85j0UGKUB4/R+CcgRznZAN5mqY21xXlWi4PLgPRYENPDNvHPYBL6yEpS5e3CnoOgrzo
	gCKSsXQPQdvmiTWVrh2A0sqUoW7iQS806OE4FVEWGo3pP5f58dsRqYyw43QM9KXSMsaJWD
	yDsBzuUWhSZLOV9CVoiAAKH0Aqe9PpueucI0Ieysdzgsfw76QNVzNcW88SWG2SspUKmvbt
	Qf72WY+5e4Osk+cZhmOP0jsDct5ZvgIQQfHLWk5TfM3yVMJEIBSL5gYaiTRHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7kPEgcFcju8u/KO+xsn8ju2WkIJSHLe7hU+C6onExQ=;
	b=E+PobTQ0GVyNEax/0mCGYkpE51932JrYEAJJXh7MgB5mGOZzneOqfYELKvO92RTInXdHAQ
	XJhHvPkym4CdtJCIJMg07eRuD8sVWPK4vaQK/OINEIpY4h8jTdZjFXpVBfgXyubiwbMYH7
	aDZ/1NQmGjXsSSQzH86LMKkI/PDG0l5rzUUhGoieCBjIp/ALu3t3gs8pXSufUMQzv+ZMuX
	Dnok10fd5Pmvv0FW4ycf/S/yRBS/iCtDfyBS5rMnleLMzN82/OB+lVQaDqhnRu3WhZ+43l
	Ri8I3FySPd/1jI0QoSoTpYjXssrzkBO7N+umPAxfscECg/gGlD7f/dU3hDR0QQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=TLmIi6dBQ95qP6nEVYxHKcG7RhVRJhY+al4MGwj8xQp6UQurso8Ilc0VPQaO+LtgqVYUQr
	HNFxnG252p+oFod/308i3HPPrp0/QD4H2OoWQ7nS5YBuQRCW9lat1F55PA86XH4P1lrIrS
	+V2+pUwoRe9/magwwwF0PPOwXxaCFP5wyiJVxt+ZXxVnfcZQQfrSSeHN+YiQMJDkRIpomm
	uyOcx9koOt1PVow9JcIcANLuOEWFR270txkGDmm9qzgMutqARRxsGP1EWaVT6YSEFgtFXZ
	3UxYhJDQGWaXyQUmrCW/fxsewNWB6OCO6p7U2Sc40fti4nkrFIg6QL/XCoAUAg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 55F5A381265; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 12 Nov 2026 09:37:46 +0100
Subject: [PATCH net-next v2 03/10] net: ieee8021q: clarify the tt_to_tc()
 traffic-class mapping
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-3-f8e6fbdf8c99@pengutronix.de>
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
X-Mailer: b4 0.14.2

Document that the tt_to_tc() traffic-class numbers are the pre-computed
composition of Table I-2 (traffic type -> priority) with Table 8-5
(priority -> traffic class). Note that Table 8-5 is the mapping for
implementations without the credit-based shaper, so the helper's scope
is clear; credit-based-shaper implementations use Table 34-1/34-2
instead.

The existing kdoc cited Annex I Table I-1 as the mapping basis, but
Table I-1 only partitions traffic types into classes; it does not assign
the class numbers.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Q: Luiz: does make htmldocs build cleanly and render the diagram?
A: No .rst under Documentation/ includes net/core/ieee8021q_helpers.c
today, so make htmldocs does not render it. scripts/kernel-doc -rst
-Wall on the file is clean, and an htmldocs build with the file added
to Documentation/networking/kapi.rst produced no new warning. Adding it
to kapi.rst will follow as a separate patch.

Changes in v2:
- make the mapping diagram an RST literal block (Luiz)
- call Tables 8-5 and 34-1/34-2 the recommended mappings, as 802.1Q does
- keep the Reviewed-by tags: only the kdoc wording and the diagram
  format changed
---
 net/core/ieee8021q_helpers.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
index b052120e67c525ac5a45b26de4cb879a0d758d17..8fd3ea87c7bcb6d7f34a4cf5969530633edd6abb 100644
--- a/net/core/ieee8021q_helpers.c
+++ b/net/core/ieee8021q_helpers.c
@@ -13,10 +13,10 @@
 	compiletime_assert(ARRAY_SIZE(tbl) == IEEE8021Q_TT_MAX, \
 			   #tbl " size mismatch")
 
-/* The following arrays map Traffic Types (TT) to traffic classes (TC) for
- * different number of queues as shown in the example provided by
- * IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic class mapping" and
- * Table I-1 "Traffic type to traffic class mapping".
+/* The following arrays map a traffic type (TT) to a traffic class (TC) for
+ * each supported number of queues. The mapping is the traffic-type -> priority
+ * -> traffic-class composition documented in the ieee8021q_tt_to_tc() kdoc
+ * below, reduced for the given number of queues.
  */
 static const u8 ieee8021q_8queue_tt_tc_map[] = {
 	[IEEE8021Q_TT_BK] = 0,
@@ -85,17 +85,22 @@ static const u8 ieee8021q_1queue_tt_tc_map[] = {
 };
 
 /**
- * ieee8021q_tt_to_tc - Map IEEE 802.1Q Traffic Type to Traffic Class
- * @tt: IEEE 802.1Q Traffic Type
- * @num_queues: Number of queues
+ * ieee8021q_tt_to_tc - Map an IEEE 802.1Q traffic type to a traffic class
+ * @tt: IEEE 802.1Q traffic type
+ * @num_queues: number of traffic classes (queues) available, 1..8
  *
- * This function maps an IEEE 802.1Q Traffic Type to a Traffic Class (TC) based
- * on the number of queues configured on the NIC. The mapping is based on the
- * example provided by IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic
- * class mapping" and Table I-1 "Traffic type to traffic class mapping".
+ * Return the traffic-class number for @tt. It is the pre-computed composition
+ * of two IEEE 802.1Q-2022 mappings::
  *
- * Return: Traffic Class corresponding to the given Traffic Type or negative
- * value in case of error.
+ *   traffic type --[Table I-2]--> priority --[Table 8-5]--> traffic class
+ *
+ * Table 8-5 is the recommended priority-to-traffic-class mapping for
+ * implementations that do NOT support the credit-based shaper (8.6.8.2).
+ * Credit-based-shaper implementations have a different recommended mapping
+ * (Table 34-1 for SR classes A and B, or Table 34-2 for SR class B only),
+ * which this helper does not implement.
+ *
+ * Return: the traffic class, or a negative value on error.
  */
 int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues)
 {

-- 
2.47.3

