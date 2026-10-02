Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D144CAE4;
	Fri,  2 Oct 2026 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942336; cv=pass; b=k/mV1kTQp8xlJw61nNUdgTqsNu5s3/hBzzdjJ6bf7Rqb8dDuAWnVWjxxNNGemC8qNKvuQXAbjS85fUPArmm9172SIj9fVZnWFEorEzaUsRqkX4+zx1ZMw8q77TzWS7oKiaHNi6rb82hiYv1eW144fbaIh3/X6KBZCCqIwSFmcv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942336; c=relaxed/simple;
	bh=B3SZlVTFxmoErjpNyYI6oqAVyvGEpMhz3N/p7wwGP2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALnQDFk9htrECgu1WnkhNx4JiOJEGjPRZJ5+aBwew9tVFWx+7Gkw5opjUMaXlG+cUPd1w8pVkSg+O418DTyxs8+Y7DaRuDBceTDxris5JlF6KN+DHe7sVOnZwRkUO6DaX7/5XRlejZvplr8kXnGk7a8z3NdVN3pJbbodxN5vEKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Kp0TD8v8; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Kp0TD8v8"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 197CF201F18;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8BIHcVER538tBsnMkf7y0rmlbCJrajLGrcGTw3ShYc=;
	b=Kp0TD8v8R+TUIMVBaMcNpb0UkeQe3mBhTCXfxcS+JnoZvdV3/RmebQGq262Bj5AoVZKc8l
	FqBz2FEWt7uMiRSgrParSXTM397zQFhVQag0Kx1YqhLJNauWApJ92YLTefim3Wn3tlp+0R
	olEDMOGgmlQh3DnbpIkkoZjRZKvIhf7FPdb9SLNcUA1ysfLx1ED9OMlxrd2/H98NQ3w8ct
	sfNcjKHACYRcCd0aHUed4paMp3lUaWPkkCbsazZyGzaoGREqfMS9iQUJdAxSfkS4BdJTGc
	kyzpWNUaXwGPhFg0Y0pikOuVDXEIeoeqMKlLwHpoDr1tKyxHQzW2pUeRsn0RdQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=YIw6NsQZcRZSFrKPVqVjNvteKroJ9bMe8bLo1cSzaJTMQ0e8InsH5gwmNCJp29wR5we9RE
	dDgnrtqEvFYjTnO5pWsoMli8M8n+wOowWLZLR8ATpsHVWLvDR0Zt6owiDZVsTvx5IdJEWs
	TrYNiBQi2ewSlamW8z74jxcZMqAgbyB0eBlC07o1D/MaO2d9mp6pTmd4Yy2sy9ulwTkNUG
	bvY7mpppsOtlOH+5UfXfwDqKXU9X/iEUJ1NxYXMXmUFRchv8gFxN5narPrYW5uxcEeX5op
	p7vQaqBLax+S+N9uTedqCNj2WqnwykHgCHryTE8vePePsC60bbLOY2dPj5lr/w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8BIHcVER538tBsnMkf7y0rmlbCJrajLGrcGTw3ShYc=;
	b=Ge7F9ykIPfvJWJrmHy0JPysyEsuNx9RFKepa6mUEjNgeWwZYxATnOHBwdyjOvWYRABUQNy
	vlV4e6OqQ9hOdW2Wo6j2+GJ/6Eu2CGH8WTQvRLevPwLQOPj3Ax2pgBeR7yFKgFouRvuApi
	ypbg0bPrnGcIRfeoq4OW3xy7o5UgFzCKx5NDn/bb6AhKOeA8wsBcH2y1+qSbpDZo/TukYr
	VGueH4rzU2ebZDsZ3urr8xaTRwBhc+aNR9B6ryMSUHWbJDPonIEUcNidbjTV2Dw6u7tm8Q
	J3axAkRTrvQr8RkFJ90S1NWEc2k2yu6D4HEFSxMKlQ6TBcsWQ/yDGUB9DEicbw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 0F850380BA7; Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v1 3/8] net: ieee8021q: clarify the tt_to_tc() traffic-class mapping
Date: Fri,  2 Oct 2026 13:58:45 +0200
Message-ID: <20261002115850.962676-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002115850.962676-1-o.rempel@pengutronix.de>
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/core/ieee8021q_helpers.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
index a5bd5e039b47..520d86d592eb 100644
--- a/net/core/ieee8021q_helpers.c
+++ b/net/core/ieee8021q_helpers.c
@@ -12,10 +12,10 @@
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
@@ -84,17 +84,21 @@ static const u8 ieee8021q_1queue_tt_tc_map[] = {
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
+ * of two IEEE 802.1Q-2022 mappings:
  *
- * Return: Traffic Class corresponding to the given Traffic Type or negative
- * value in case of error.
+ *   traffic type --[Table I-2]--> priority --[Table 8-5]--> traffic class
+ *
+ * Table 8-5 is the priority-to-traffic-class mapping for implementations that
+ * do NOT support the credit-based shaper (8.6.8.2). Credit-based-shaper
+ * implementations use a different mapping (Table 34-1 for SR classes A and B,
+ * or Table 34-2 for SR class B only), which this helper does not implement.
+ *
+ * Return: the traffic class, or a negative value on error.
  */
 int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues)
 {
-- 
2.47.3

