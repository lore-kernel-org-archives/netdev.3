Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058648989E;
	Fri,  2 Oct 2026 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942337; cv=pass; b=jLUotjEEnJDQFc9WScUw3cQ8LlE+vQghUfRyTO4KE/SiPIwissA3RldAtdBky0kiqCbXwjhTMvFDse1p9rit9KknSnydbrqMxTd6b+2MRD7UWFcrRLSc4nF7zw4Oqzw9aWDOyWIgOF4nOCDjTLPnz88/cT7Cm6ZpJv099/sNGts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942337; c=relaxed/simple;
	bh=IHa+irAt0l7Du5+/UjCkYiuo6a4l2fcDi5D93OYvJ38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFqT0bxcdkuI4Tsk3fqJoILwY3jT41IPmkLD3oddl1vVMmhUz2fE/ZRMwnYK6qd6SYh7sWhWKZMt/YWdOxWHUBf1NnLiFDcn3hZrSaMgmE2VL6cpi7ybp3yfTqpPeOGii1TgeIwvy+p8ACw9P+sIRIY4p+aUdT1qlms3l/Ga2JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=damftuDy; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="damftuDy"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2BF09202303;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igQkPN7qzA9MnAOLO1Ekwv97arHGTBfWOp1Ff7YJQ9s=;
	b=damftuDyDkMff/gLQK5C20x0ikdcAGPFbFUJnoyaFhW5xwCOWz8YiC9DAd0TcpWKfq33KA
	OHL0sj/NUk0xQN7RtsCFhnP8qq5ajhi6LUB6k8fvltGSwMElQRfK+YyiMRZgaIoOYoQvsT
	4qEWhS/fNMziK9mhwpxiTO/skee93U8YjY2HxhVMdATW0PkUJoq7SAV08cshPZx7nSkop4
	8DZCd104Yf2RJsUlGkCA0oA0LgjHWGqAEEN9Vp2146X+i9Fen4WIh0FN60DnTIlN1j2pkQ
	7RgmM8sF0W9kP8BNNfOQF0gk1wDa6IF5lHsYoBjtX+7INMXIboByEY6V/yBx0Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=Mt0Ztxj2pExby1iL8Vrb6QxzjEAkBYOlUAzfMgbx8ECLV19HtacCkf7GSXej/Whq5myMzi
	h5jgK7OCjVCFDsgjx+9IHoIZYIytSZPdB4HvwNq4AwbBcmGN6l3LygoZjZpDNK4Rg9orQ+
	kMzVMt0ScP39T7D01ffao01/VVQ5C9xIGpFZzExa3pAdqhiUO5Sq4quRw+2ziU6j82pn2g
	QGyjQSoIDxvHhRQnnoG+LMS+XYhfehkHxMOGD0hKsc8odPU64vC9/IEiRx6mBZkCLuuUub
	3OMbnFNAJNtGZYj5YDjS3P+f8nteLjA/1ISd2tRHbdP6Y8vKm27N3munoOG47Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igQkPN7qzA9MnAOLO1Ekwv97arHGTBfWOp1Ff7YJQ9s=;
	b=Jqyk1ELjniYbpVoaBTsKbmeQttrvZ5M+dK6XV7S+E5u0379beXnWTuEjRiWEfX8FbyJNSW
	TKe4Uqx5o9p9nD2UiUnSMZlbGnTqWgFLygc4H+3wOD5j6xUxSRVE1OO4ZdZ7FO0sr+ngd/
	OBZMgzr3PbbXGWLDMvIisnjl8YqwvTf/tki00y/0EBZNQjSj/GioByup2tZtGQ217f0mO3
	WkDbWCll93H5j03AjVZf+hednq9JCPp0jA1kEDEDISPL1kS6RKRAQq7ybCXCB496b5ShOQ
	G+qjvi9zA6TjuEK4xuuuSBwaoltZqlZUsb5pzre+MubllIMoOdVuOWKP8UBCag==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 1B4A6381110; Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
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
Subject: [PATCH net-next v1 4/8] net: ieee8021q: add tt_to_pcp()
Date: Fri,  2 Oct 2026 13:58:46 +0200
Message-ID: <20261002115850.962676-5-o.rempel@pengutronix.de>
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

Add ieee8021q_tt_to_pcp(), the inverse of ieee8021q_pcp_to_tt(): it
encodes an 802.1Q traffic type back to its Priority Code Point, and
completes the pcp/tt helper family.

A driver that reseeds its PCP classifier through ieee8021q_pcp_to_tt()
stores traffic types in the hardware tables, while the dcbnl priority
ops exchange 802.1p priorities across the DSA boundary. Reading such a
table back therefore needs the reverse mapping to restore the 802.1p
value, which no existing helper provides. Because pcp_to_tt only
transposes Best Effort and Background and is the identity elsewhere the
two directions are numerically equal; provide tt_to_pcp as its own named
function so the read path does not decode a traffic type as if it were a
PCP.

The first user is the Realtek rtl8365mb DSA driver, whose dcbnl
get_default_prio and get_dscp_prio paths read back traffic types and
must return 802.1p priorities.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/net/ieee8021q.h      |  6 ++++++
 net/core/ieee8021q_helpers.c | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/net/ieee8021q.h b/include/net/ieee8021q.h
index d24e4036577b..b09572da0289 100644
--- a/include/net/ieee8021q.h
+++ b/include/net/ieee8021q.h
@@ -39,6 +39,7 @@ enum ieee8021q_traffic_type {
 
 int ietf_dscp_to_ieee8021q_tt(u8 dscp);
 int ieee8021q_pcp_to_tt(u8 pcp);
+int ieee8021q_tt_to_pcp(enum ieee8021q_traffic_type tt);
 int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues);
 
 #else
@@ -53,6 +54,11 @@ static inline int ieee8021q_pcp_to_tt(u8 pcp)
 	return -EOPNOTSUPP;
 }
 
+static inline int ieee8021q_tt_to_pcp(enum ieee8021q_traffic_type tt)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt,
 				     unsigned int num_queues)
 {
diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
index 520d86d592eb..205c11793473 100644
--- a/net/core/ieee8021q_helpers.c
+++ b/net/core/ieee8021q_helpers.c
@@ -267,3 +267,43 @@ int ieee8021q_pcp_to_tt(u8 pcp)
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(ieee8021q_pcp_to_tt);
+
+/**
+ * ieee8021q_tt_to_pcp - Map an IEEE 802.1Q traffic type to a PCP
+ * @tt: IEEE 802.1Q traffic type
+ *
+ * Encode @tt back to its IEEE 802.1Q Priority Code Point per Table I-7
+ * ("Priority Code Point decoding") for the 8P0D encoding, the inverse of
+ * ieee8021q_pcp_to_tt(). It is nearly the identity, except traffic types Best
+ * Effort and Background map to swapped PCP values: Best Effort is the default
+ * (PCP 0) despite being higher priority than Background (PCP 1) (Table I-2:
+ * BE = priority 0, BK = priority 1).
+ *
+ * Return: the PCP value, or a negative value on error.
+ */
+int ieee8021q_tt_to_pcp(enum ieee8021q_traffic_type tt)
+{
+	switch (tt) {
+	case IEEE8021Q_TT_BK:
+		return 1;
+	case IEEE8021Q_TT_BE:
+		return 0;
+	case IEEE8021Q_TT_EE:
+		return 2;
+	case IEEE8021Q_TT_CA:
+		return 3;
+	case IEEE8021Q_TT_VI:
+		return 4;
+	case IEEE8021Q_TT_VO:
+		return 5;
+	case IEEE8021Q_TT_IC:
+		return 6;
+	case IEEE8021Q_TT_NC:
+		return 7;
+	case IEEE8021Q_TT_MAX:
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(ieee8021q_tt_to_pcp);
-- 
2.47.3

