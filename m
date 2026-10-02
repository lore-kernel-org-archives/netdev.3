Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D448662F;
	Fri,  2 Oct 2026 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942337; cv=pass; b=jBkRBw1NlF2074wwSOngaoWWSMfcnpT2vd8RBIheAi613HSE1IJ4Mgyp315NzC0Mmwzh95gx5bmTRyeGO5LMNNpL+i0noyHSMIIusaiK8CSNFKuX2F1thHc4bqEHrjhELkNCm88Av1PEUJn4qDGcehsUFk6GUNpyOarMQzC25NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942337; c=relaxed/simple;
	bh=9U+wrwk+Dte8F2b9fv/EksqoVLjWvsCjyN6j2GmwbAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDcBSiUKw4MDNS9txUix/XVLTYB0H12Xmrzux0oMHvzOqAp1RYYP4oadzH5mPpWWsr5iaP+uA9w/mFyw94pBsV9guoC/rZWjqYdYnm+Xs51X3d9dC8DXnXV6AzynV30+x0LMfi/60Sq3memqaCat8E/tbJ6+6Cf+TWVGPJ/HE3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=e4TDUbDO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="e4TDUbDO"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1C3152022EA;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiE6Cg+mC+qb3yoPiVm25Wx7Ku/lPE18ktccKqXTVTM=;
	b=e4TDUbDOcYyNG022lSunTQgo+zwfseBpvEPidBwEoP7eWR/dLoyOJVGHLs5rm4r8nE0IXY
	vrdncMgYrlTn04ODSxcarFd56BEkeRgeyLsf5o7NRpx/U/iDnyXPQ8bN3FvbVJYyoLmuCe
	7e7KrF4IZ9I41HicnZodXOyQ5/H+n6tV8KPRVGRy8LtS/gc9zDpzCEDs4QdWkIXrJtaW+l
	a+FGCRFI5P8WLXhjHuGg1oK0Pw8I2ipmfmflSxQb35C+hk7/+t8fGfjGZbC4CsC+uD03KA
	Z+ceBTeL3juKK5tMag1sCA6R1cfrTdqnik33AbXycN+H0LHwSo0TUVhcGNwJgA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=VjvTA2KqHA7LsUR2kMuiD38Xt1XNqz4A0dyK4DW7yT4+//z1228Ixk2A+/2d6Z6bgZ1UHE
	BbTusSQSfwPFOmPgJ/3PQKgwPrsgYuuhdWyQQqJvYMzMs/JLVZYjpbSaXoDvqG1ctEyyIW
	Go+1vEBgB4EZkee/Ug9NxSGm1Tc0/ANHXpkTpIxSRFW1iuBbsPqqCYHLRx5QRr8DGp2ZsA
	Itb0OjU3gK/z+I4bHav0xqws5No8DkKBDQaVkeN7qSbAMDawVw0AkwGK+G475SWhglCVfp
	6YoMMsLKGRVZQi2Yw3XQMpD+jsrQWXgFUUFZZHi8bCkm3iOwPpdNqMeU1ipoVQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiE6Cg+mC+qb3yoPiVm25Wx7Ku/lPE18ktccKqXTVTM=;
	b=dHQnMNecN2zHGu1BqDtdZycnitz5exubgU1vlGAYmWpdWCOiPyyDXqW9fT3YVsJaVPGkUb
	w6e6bk3er7S/oPNTE7vQAJfaNAram/Oy5qP+Ggd1DF7ScCDz2UZzwJPvNsaLu1/6xWKLMv
	RWl3IF8h2itqb56yrzGu3MZ5wt4uoL3GGP9PMRe1DSsSyX7OTalOdvmKrTSaZ2Iq/nkmL7
	EdIEU5t2rmUaf2p7ErV82Sf7gQBH0dEIWuDpx7OO62aK67POOQ+z8gB/RGgBHHmS5xV5CL
	yniC8pbGSCTJA93YXWWIKInFdeUjCC0pyCv+el1igRT6fQpgeyJxTA2uSAgHfg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 03AA1380FA9; Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
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
Subject: [PATCH net-next v1 2/8] net: ieee8021q: add pcp_to_tt()
Date: Fri,  2 Oct 2026 13:58:44 +0200
Message-ID: <20261002115850.962676-3-o.rempel@pengutronix.de>
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

Add a helper that maps an IEEE 802.1Q Priority Code Point (PCP) to the
corresponding 802.1Q traffic type, complementing the existing
ietf_dscp_to_ieee8021q_tt().

It is very nearly an identity map, except that PCP 0 (Best Effort) and
PCP 1 (Background) are swapped: per 802.1Q-2022 (Annex I, Table I-2)
Background is a lower priority than Best Effort even though it carries
the higher PCP value. PCP 2..7 map straight through to the matching
traffic type, and values above 7 are rejected with -EINVAL. This decodes
the 8P0D encoding (Table I-7), where every PCP value is a priority and
none carries drop eligibility.

Drivers that classify ingress traffic by PCP need this to map into a
priority-ordered internal space without misordering Best Effort and
Background. The first consumer, the realtek rtl8365mb DSA driver, lands
later in this series.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/net/ieee8021q.h      | 10 +++++++--
 net/core/ieee8021q_helpers.c | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/include/net/ieee8021q.h b/include/net/ieee8021q.h
index 8bfe903dd3d0..d24e4036577b 100644
--- a/include/net/ieee8021q.h
+++ b/include/net/ieee8021q.h
@@ -10,8 +10,8 @@
  * enum ieee8021q_traffic_type - 802.1Q traffic type priority values (802.1Q-2022)
  *
  * @IEEE8021Q_TT_BK: Background
- * @IEEE8021Q_TT_BE: Best Effort (default). According to 802.1Q-2022, BE is 0
- * but has higher priority than BK which is 1.
+ * @IEEE8021Q_TT_BE: Best Effort (default). According to 802.1Q-2022 (Annex I,
+ * Table I-2), BE is 0 but has higher priority than BK which is 1.
  * @IEEE8021Q_TT_EE: Excellent Effort
  * @IEEE8021Q_TT_CA: Critical Applications
  * @IEEE8021Q_TT_VI: Video, < 100 ms latency and jitter
@@ -38,6 +38,7 @@ enum ieee8021q_traffic_type {
 #if IS_ENABLED(CONFIG_NET_IEEE8021Q_HELPERS)
 
 int ietf_dscp_to_ieee8021q_tt(u8 dscp);
+int ieee8021q_pcp_to_tt(u8 pcp);
 int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues);
 
 #else
@@ -47,6 +48,11 @@ static inline int ietf_dscp_to_ieee8021q_tt(u8 dscp)
 	return -EOPNOTSUPP;
 }
 
+static inline int ieee8021q_pcp_to_tt(u8 pcp)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt,
 				     unsigned int num_queues)
 {
diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
index bbacdfff9b4c..a5bd5e039b47 100644
--- a/net/core/ieee8021q_helpers.c
+++ b/net/core/ieee8021q_helpers.c
@@ -222,3 +222,44 @@ int ietf_dscp_to_ieee8021q_tt(u8 dscp)
 	return SIMPLE_IETF_DSCP_TO_IEEE8021Q_TT(dscp);
 }
 EXPORT_SYMBOL_GPL(ietf_dscp_to_ieee8021q_tt);
+
+/**
+ * ieee8021q_pcp_to_tt - Map an IEEE 802.1Q PCP to a traffic type
+ * @pcp: IEEE 802.1Q Priority Code Point value
+ *
+ * Decode @pcp to its IEEE 802.1Q traffic type per Table I-7 ("Priority Code
+ * Point decoding") for the 8P0D encoding, where all eight PCP values are
+ * priorities and none carries drop eligibility. It is nearly the identity,
+ * except PCP 0 (Best Effort) and PCP 1 (Background) map to swapped traffic
+ * types: Background is lower priority than Best Effort despite the higher PCP
+ * value (Table I-2: BE = priority 0, BK = priority 1).
+ *
+ * The 7P1D/6P2D/5P3D encodings, whose lower PCP values carry drop eligibility,
+ * are the other rows of Table I-7 and are not decoded here.
+ *
+ * Return: the traffic type, or a negative value on error.
+ */
+int ieee8021q_pcp_to_tt(u8 pcp)
+{
+	switch (pcp) {
+	case 0:
+		return IEEE8021Q_TT_BE;
+	case 1:
+		return IEEE8021Q_TT_BK;
+	case 2:
+		return IEEE8021Q_TT_EE;
+	case 3:
+		return IEEE8021Q_TT_CA;
+	case 4:
+		return IEEE8021Q_TT_VI;
+	case 5:
+		return IEEE8021Q_TT_VO;
+	case 6:
+		return IEEE8021Q_TT_IC;
+	case 7:
+		return IEEE8021Q_TT_NC;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(ieee8021q_pcp_to_tt);
-- 
2.47.3

