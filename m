Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472674;
	b=kOYfNDlqZLbjVjQY+86Q7LIwgKNV1P3/YYsYZKbYF4PdsCtHOo1CpOtwzLTKy4F2HnQy
	 fD4NqwkPEcj9esBvuJfGsIK0zqOEsp1FGrRAeO5Z9t4p2vhd2zGCyVk+jZMTPTiQEwIaQ
	 UYHOgkHwSIk+FbLBTFzK8ujWCgsTjus1l7cXcJOqUVu24ETLx9u3yF2kWtog8wYRXwFMt
	 YaC2t+pTRAodFnpTOhCO6kARPfgqMJbhTS/TO8DZuxgfFTtSn/h4x+FiAT2/JRuUPuWJ+
	 HZ6DCd70NmBTsEp/cq/YPN6JBioJT0/QfKTaqjyCxqTJUkdm2gXLkEITA3SuMxFtFlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=8SN7IRVkM2+LBSniAg5zc+BHkq0jx4sS+0EoVz9w3Nw=;
	b=CCAThexmFAfVfECX0QAqo8cSlSQzaubAPhv6w3kkdzUacnEspmLSv8zIpYQ0Nhi1ue3l
	 VA/6qqOL+4d73VbbBF1Ddcb9fJN9HpsBmGxKF5ohePTi28kegv3ZCoTRyrMKj352olo9Q
	 Zcw7vm9icMSkznLFcTb6x0U+82UR/zI5uyY1AabpQp7Tx23G6hCdgxvcmigx/B8+gBKYz
	 OUs7BZlsMjrXSBWHg6vQ0jeXpdqSUrUSHlqOhBhsod5AFnYBbnYPJ6Horra8hHUkkfVx6
	 BIYg2Ae3X3HDmsBvFhJ4XTPD+WBag2ytB+6OGmIyS4kVqHRMznm+AcZJWTsKfpeO2aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Eb6j472P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBC606A8A9;
	Thu, 12 Nov 2026 08:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABFBC606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Eb6j472P
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7F573202C94;
	Thu, 12 Nov 2026 09:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SN7IRVkM2+LBSniAg5zc+BHkq0jx4sS+0EoVz9w3Nw=;
	b=Eb6j472PlQ+PzTWNbrNrzqDPa79YHs1KiqLN6Xn9oR3YWX7rF2yprmz+3tLrDZmZ6HpTuk
	bCajGNiROiVIarNqcf1N1yDjUX6GsTjzR8P2EPq6m0SAJlYYiptEy477W4cH2F3Frrfe0G
	VsQnQ+PFbUk6y9xZiPkin3ksmfq3pN2fluau/knrtujHbsHSKOqv0fyAROs0Zd5ikknwYy
	6oxWCmxODpt7D0oiPp0pU/6SkkZVwjOGrl353fU+Quc3htLO3bQiH1hNcPNa3s2nFN9iaV
	v/gVlApdof5K0iDXO8ySxIitJrt+XEaoHVGGrUO2OGFp4y3/kKsL/pmd2VvWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794472671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SN7IRVkM2+LBSniAg5zc+BHkq0jx4sS+0EoVz9w3Nw=;
	b=ZOGZ71x4707AmGS03mr/x7FGuN+OdwRvhKfEu0OxHsNHqfRuAYWrPFbVYoDOiKQK/NCUkB
	qicIGMyDylTX2fcwHmx57oy5Z6y75P//KZhHazChC+Giz+bfIl1RSYmyNdh6rk5ypuDz2X
	Ah1Rd1jGqaCb/7Rlj2rqMUCkpoVjo4Xe3rWEV4LRBdvm7VeCW+0llWb3vhGFV3mMEsuF1i
	w30jt9fCMHBuJ6dGRifh1J9wqIrbV4of5BbhCiCy+pdqfxmCtnwEl0dQAx40uX/tw6uKB8
	72bn79O1SCqrhSUa2ib5HyjiOkfpAHvHV7fQjxDgdmjdrzwdmc2pJJCRFIBzBw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794472671; a=rsa-sha256;
	cv=none;
	b=DvSnfCmIMvrQVYT6NM9Ojl+QU2gXN3Re4IUiM5+DvysnNKZvAKNhz1Cv/EBXL+gJws71Um
	aY2wF5wK+N9i1FGvZ5L5CVHE3rSveXHdnnkNCuFY6alzd0x1wZIMOzq8YPlGfOueFS5tgO
	fWLMZBgc/aWGHalufT6s8mN/iYe8UJz+FEGyh/dbawGxQRZ3Sbwl9T0fqGdVJVZWdvQwMT
	LSwCHGyrXW4zosekujYg+HQKc4PsEvwW++GmBPv80eAGJigs1PubwGcfskhpn91rqoC9fX
	acA8ac8PITYMspoB6UFMB5Rzw2lsPypDsJKzabAtHDsq4IYwhW1f0Vn7vOnPnQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 588DC38128C; Thu, 12 Nov 2026 09:37:51 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 12 Nov 2026 09:37:47 +0100
Subject: [PATCH net-next v2 04/10] net: ieee8021q: add tt_to_pcp()
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
Message-Id: <20261112-rtl8365mb-dcb-ingress-v2-4-f8e6fbdf8c99@pengutronix.de>
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
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- look the PCP up in the pcp_to_tt() table instead of a switch, so the
  two helpers cannot disagree (Luiz)
- check at build time that the table has one entry per traffic type
- kernel-doc: cite the encoding table, Table 6-2 (6.9.3), not the
  decoding Table I-7, and name the IEEE 802.1Q-2022 edition
- kernel-doc: refer to the enum doc for the Best Effort/Background
  order, and document each return value, including the stub's
- keep Linus's Reviewed-by: the mapping is unchanged
---
 include/net/ieee8021q.h      |  6 ++++++
 net/core/ieee8021q_helpers.c | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/net/ieee8021q.h b/include/net/ieee8021q.h
index c6c8c94ec7fb39603f631d50928f2354bfcd8f81..c0cb6a8004da451fe2be835b9ec1f6fbef1779d5 100644
--- a/include/net/ieee8021q.h
+++ b/include/net/ieee8021q.h
@@ -42,6 +42,7 @@ enum ieee8021q_traffic_type {
 
 int ietf_dscp_to_ieee8021q_tt(u8 dscp);
 int ieee8021q_pcp_to_tt(u8 pcp);
+int ieee8021q_tt_to_pcp(enum ieee8021q_traffic_type tt);
 int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues);
 
 #else
@@ -56,6 +57,11 @@ static inline int ieee8021q_pcp_to_tt(u8 pcp)
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
index 8fd3ea87c7bcb6d7f34a4cf5969530633edd6abb..d9033398b0ec6320c4e0e2fa3f0913d96937d72e 100644
--- a/net/core/ieee8021q_helpers.c
+++ b/net/core/ieee8021q_helpers.c
@@ -245,6 +245,8 @@ static const u8 ieee8021q_pcp_to_tt_map[] = {
 
 static_assert(ARRAY_SIZE(ieee8021q_pcp_to_tt_map) ==
 	      (VLAN_PRIO_MASK >> VLAN_PRIO_SHIFT) + 1);
+/* ieee8021q_tt_to_pcp() needs one entry per traffic type. */
+static_assert(ARRAY_SIZE(ieee8021q_pcp_to_tt_map) == IEEE8021Q_TT_MAX);
 
 /**
  * ieee8021q_pcp_to_tt - Map an IEEE 802.1Q PCP to a traffic type
@@ -269,3 +271,27 @@ int ieee8021q_pcp_to_tt(u8 pcp)
 	return ieee8021q_pcp_to_tt_map[pcp];
 }
 EXPORT_SYMBOL_GPL(ieee8021q_pcp_to_tt);
+
+/**
+ * ieee8021q_tt_to_pcp - Map an IEEE 802.1Q traffic type to a PCP
+ * @tt: IEEE 802.1Q traffic type
+ *
+ * Encode @tt to its priority per Table I-2 (IEEE 802.1Q-2022, I.4). Then
+ * encode the priority to its PCP per the 8P0D row of Table 6-2 (6.9.3). This
+ * is the inverse of ieee8021q_pcp_to_tt(). The enum values of Best Effort and
+ * Background are not their priorities, see &enum ieee8021q_traffic_type.
+ *
+ * Return: the PCP (0..7), or -EINVAL if @tt is not a traffic type. Without
+ * CONFIG_NET_IEEE8021Q_HELPERS, the stub returns -EOPNOTSUPP.
+ */
+int ieee8021q_tt_to_pcp(enum ieee8021q_traffic_type tt)
+{
+	int pcp;
+
+	for (pcp = 0; pcp < ARRAY_SIZE(ieee8021q_pcp_to_tt_map); pcp++)
+		if (ieee8021q_pcp_to_tt_map[pcp] == tt)
+			return pcp;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(ieee8021q_tt_to_pcp);

-- 
2.47.3

