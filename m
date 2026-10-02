Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7235DA55;
	Fri,  2 Oct 2026 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942337; cv=pass; b=BmmAkCbxKNeUmMkRRw4vgqNkqnEzl9jDhqaArSE25yvoId/x1hizV6E71ju9Su+jo4nYLAIpC3bv3m2al+K2C3oa3CgosSgmgCWvrOJwgi58Py3+/rLkMB3FdsCEtpfsCu9c5UIiLQViU3qVOgylLKRYdv0rJaJ5yi0fR+3PK1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942337; c=relaxed/simple;
	bh=isEkkmEhhZWGcISQwMWbkY9GhAyFJ+oMWqIa8B6KPLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbsh/V5dm1vmFC6H2oArAUWWfGLxJJSOArKoi4F4AGSOvI8PrUMD2yqTFyBm/myOspv3OtaCeX0/ffvgVu/T7E8Zc5lU1D/RGP+6TUo3KaWL7JHT/HM9Z7+ZPM0ewd9kOlQKITtEZacmtKdb8f2EFmi1YBxgGZmMYIgG++Q6Tsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=KEadrkj8; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="KEadrkj8"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 11A5D201991;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxMUlhdo6FcVj3iOS57D0hS5pjXPefQJXgYpuNUOJqo=;
	b=KEadrkj81c+D6M6X2shywJMadGjeEcOAkXh4scNid6lqBjIL8orCMHs7q9PQ1moa7xdXvW
	V4P3h0g48opNHjZY147ibT6l7og6dlo9TJKqZRTpAhSSBgoygjG3rqFOjyWwN1vJK9RiTk
	eRsUKCR3OzBqQgKEW4yONJgRYG4Z6SMLnmtoZkUI1LV7vfaCMl80r5P4v4ROp6Y9PmD4s2
	XBymn+F6RiIkNibSKzoqRh8A6bMKpPz62zLeB1y5zYziKdHJzC4JoNMpriEE9OLTLaR1l5
	+ZcFxW1RheKxNgigU8n5oA9yM9B8KLAFz3DpBIcogvQZwtgpEpmRAUwC8W6k+A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=UKKaZ6SxZ2DTj6Eu4MGEO4OwvGg/ABhRdWay3SHZ2E3seGkflCxsQRfTXll6XqLTZbQnVZ
	mY8YUhrk3LNvMq1BOvwrtXUsbD0pRz31VJD5HEhk9uqWOaQFp+Wh1YwWBYRXxoQhTctl6m
	fXW6p4yeWEpIok8kISwphmyZrqxcReSr4gQ4LdPi5rEW5PHecffNwUYC0i8wTrZn2t0Baz
	ButnrHe73UvswkSjU/jMqQCCzMeyJtAxZKUZcb2UqdD6vVx6BFIAZdoYrt3FjM1B2xdVA9
	3GtVD4BDMqPNmx8BAQo5OVPT7T3Di4JpNrxxnIGwC5h+WyqVzPL/j/P6ZJpEAg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxMUlhdo6FcVj3iOS57D0hS5pjXPefQJXgYpuNUOJqo=;
	b=a9hro336T6sp+213yKkhahG/2YGR6S55QvNVeX+haOiGksuES2AM8hnC2PBM9nMmPbcGzQ
	l5Cb3bTot72cyfAKJl119MYPYpyakZW+RCTZLewiUcwpew+mHEbB2rEXTrPM5LyhSX13Ri
	RoysfC9vI0IfHm8qhrTfXK/HM5OWUuMT8oBzF7P/dN2Zp++MK+YzFA1kjTRnU/Uv3FRUKA
	Ymg5yJWvWsgjFrG9Np50XAGKY9wd+yG24JsiSf52zJIt6XADk1kquNrFEUDVchdc2AnXC/
	tVKriAxu5CM08aY7RjWFo/0DxlxXFSPPZyXV0wl6pnbEgQ65gYqqCgyFkMU61A==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id EC2AD380DD7; Fri, 02 Oct 2026 13:58:51 +0200 (CEST)
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
Subject: [PATCH net-next v1 1/8] net: ieee8021q: print traffic type and queue count with %u
Date: Fri,  2 Oct 2026 13:58:43 +0200
Message-ID: <20261002115850.962676-2-o.rempel@pengutronix.de>
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

Switch the out-of-range diagnostic in ieee8021q_tt_to_tc() from %d to
%u. The traffic class count num_queues is an unsigned int and the
traffic type is an enumeration, so printing them as unsigned matches
their types. The print sits on the range-check error path, which still
rejects a negative traffic type; %u only changes how an out-of-range
value is rendered, not which values are rejected.

Preparation for the inverse helper added next, which follows the same
convention.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/core/ieee8021q_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
index 669b357b73b2..bbacdfff9b4c 100644
--- a/net/core/ieee8021q_helpers.c
+++ b/net/core/ieee8021q_helpers.c
@@ -99,7 +99,7 @@ static const u8 ieee8021q_1queue_tt_tc_map[] = {
 int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues)
 {
 	if (tt < 0 || tt >= IEEE8021Q_TT_MAX) {
-		pr_err("Requested Traffic Type (%d) is out of range (%d)\n", tt,
+		pr_err("Requested Traffic Type (%u) is out of range (%u)\n", tt,
 		       IEEE8021Q_TT_MAX);
 		return -EINVAL;
 	}
@@ -131,7 +131,7 @@ int ieee8021q_tt_to_tc(enum ieee8021q_traffic_type tt, unsigned int num_queues)
 		return ieee8021q_1queue_tt_tc_map[tt];
 	}
 
-	pr_err("Invalid number of queues %d\n", num_queues);
+	pr_err("Invalid number of queues %u\n", num_queues);
 
 	return -EINVAL;
 }
-- 
2.47.3

