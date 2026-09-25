Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0543BDC0;
	Fri, 25 Sep 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344393; cv=none; b=RctEiYwBjX0c0ejZHhrwhhucUkBN2R5FNejaX24ZH5pEiq7AN/gOGFqjV3fttnjvnNOOFIZGmPGqir2PK3p/R7Qj0A4TuipSURyQ3/R287CMG4MD9bdlquO94guv3K2rETQHwLuvv1FC8/iRM5xP1kIK14ykcp2NCXqR3uJJofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344393; c=relaxed/simple;
	bh=Y58bPz2z4AP1Sg8SS87CnMm0rK2+L7evrleySoooekg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MurfACxZ1Y/kr73Ul5N42OG9gmo/oihuR11j8soSBtVeo+J8+ZmqXK4JFnPpSxmJKXgJ/65ASxVLC/BT8VjWD+hsaT0l4ztn4wfG4m3rx2CTcImFbhbmSo7pRwlSPDj773FSTO+kP+IEIhYj6QAhGSQQl4lF3N0Do692k3rDBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=BWkFKHcj; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="BWkFKHcj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 280DCA02D8;
	Fri, 25 Sep 2026 15:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790344389; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=G3jYPwXqqQKzyrTkuEGWPfBU+1NwmFN2RF8hcaQa2o4=;
	b=BWkFKHcjB98uUTfig+d1dYpiSHUalbhy0K9Q1A34hFCCkjn8V+H24tikWf4QrY8ygr/Rms
	aO6ol+sasSWzCNs/TIRGCesiN2ehcA/NB6W2UHuSQQvjWS8JR6tMQ+v3uY4re0LZS4DRme
	2CC49L/AQLqn30zSRM9YtcxDxweUSQz0GmTLU8ah38e9o5PMaIZHw19CL7B1NoXrYNP4GF
	b+KQyd0b58ywIb1jk55T6wddVc47C1fm9FyEX4aI3yOxg+6sJtc7UVXpNnr1ge6c3R0Cuq
	EwlS/u1/Y1tqiOtlOjzwxhKus92AnRYhnEoEk6wbMfGFrbanoq0zPQOrCH0mtA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] net: ethtool: reject an out of range hwtstamp provider index
Date: Fri, 25 Sep 2026 15:52:35 +0200
Message-ID: <20260925135237.3432266-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925135237.3432266-1-nb@tipi-net.de>
References: <20260925135237.3432266-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

A provider index of 0xFFFFFFFF picks a provider on hardware that has
none. phc_index is an int where -1 means no PHC, and the u32 from user
space ends up as -1, so the two match.

TSINFO_GET uses -1 for "no provider requested" and answers with the
default provider instead of an error.

Reject the value in the netlink policy, which covers every comparison
site.

Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
NLA_POLICY_MAX does not fit here, .max in struct nla_policy is s16.

 net/ethtool/ts.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/ts.h b/net/ethtool/ts.h
index d901a879a671..ab9805308353 100644
--- a/net/ethtool/ts.h
+++ b/net/ethtool/ts.h
@@ -5,9 +5,15 @@
 
 #include "netlink.h"
 
+/* phc_index is an int and -1 means no PHC, so keep the request non-negative */
+static const struct netlink_range_validation ethnl_ts_prov_index_range = {
+	.max = INT_MAX,
+};
+
 static const struct nla_policy
 ethnl_ts_hwtst_prov_policy[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_MAX + 1] = {
-	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] = { .type = NLA_U32 },
+	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] =
+		NLA_POLICY_FULL_RANGE(NLA_U32, &ethnl_ts_prov_index_range),
 	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_QUALIFIER] =
 		NLA_POLICY_MAX(NLA_U32, HWTSTAMP_PROVIDER_QUALIFIER_CNT - 1)
 };

base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
-- 
2.53.0

