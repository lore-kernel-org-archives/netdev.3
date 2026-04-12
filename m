Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68B29C35A
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776031891; cv=none; b=iPsB/LQLGarkI4IebYr9FDPu8DP/n+aGnANktr4m1z4YST1hDv26zRK7vlJLqNQoesdUVp4vA3d5r/SXvjTYiiC1qz03HprxRDPZUkYn9FLv7wOX0jgzpR+7F6f2tqDuqJUIguxtkB2qNXnE6a6Tcxdeg9oz2+fTDIfHs1Q1OO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776031891; c=relaxed/simple;
	bh=2MD4mw9VtT92c+XLvgL57rMrXsAFd3YknTwrxiwVYBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOKmUzQcYNgZLsgHYNiHy3XGQHP51D2PbFrWMsmqknov8OF2PTlxHjmdTbxAtIHXMw3GdwYO4aZAzvVosjam24firBummJpJ5h6PlyeEJgn6smmlI+mZuMslYwxVFAlEGCt5U9ENHdJLsPM5RWxJYL1wS8bvrbD4ctygL79LIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ltq36uiW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ltq36uiW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso40552035e9.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776031888; x=1776636688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8Mfdg4Ypl8F8vizSjaXQ98wwfwZessRlBGANjO9ivQ=;
        b=Ltq36uiWyh3P4vtL2aBwEJrUtcICyCAth5IzxqC9Sm8FHOQ+FYavvFx6JzOzrqmvzd
         BWG7L5VnX5pGNtK9ykuWA50oxF3a8lpZr6gvXPhhdKo/v2xaZW+xbAn9kjrzHp+UEF7P
         074yYmar2O1LKIB/BNx+clGYpjb0FU2Oni4dw4nA2oiwTmXabsGUWFLqBlgk7uk0nK7h
         APiS/5FIzVIyRdU1zK4uFcurnZ+RbOQWj2MAMLupmJVoNHWS9GM0U7z65pJNL/bxTb8k
         z97DDIsMDB9PZnoV77u0SIJKpi1EyUiyRQ9DjfIjIp+L3a/YOC8GNvFIbQdtrZAaB05Z
         EYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776031888; x=1776636688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J8Mfdg4Ypl8F8vizSjaXQ98wwfwZessRlBGANjO9ivQ=;
        b=fpcr/0ypY2QDT3zIVARHJsKsufuDxu9ap+vtdZapEnlYLK9GfbS0v08HlIrvICthrs
         6Ec1InQiEKdCsqOh68jmuLoTy/0Em9kMj4fuyEa7pmacSNaHO4Mllkv5ol3MIfMzku8E
         4uTZn80RaD8EiiVBMZFM4asLXbizsJbF3PKCPDApQlrg0KjwNIe8J/j4ZW8nq+BBtd6Z
         5FzocX98VDT+k7g+ER1UFEqiyEWXlUFs6uRtHTMqPD2HbAyVL+ftM7LqH2SCJhjD7Cx4
         IXwmYomFX9vACJbZaslFci92TRywtSUcRHbBDPNqq1tEHE1ZY/vQds2NTdtIxJeIBqDC
         jLIA==
X-Gm-Message-State: AOJu0YwxnrE6nQEBnUgqX53g8IUKUOLBibC3mdBO7tVSHHvhsN/PhP0n
	dCsXMDQMZI3cnsBZI5lBDxXyNtOvSey+hhcV8bSEwxwYq7jrui0y6Ef3/+BgQKBxB5hQqO6JFBV
	M1MIuwMCShhGqZ324sM3YlxjGEj5bV10/zJqLujBKJe9EGuIVCqyoEk0hoct5jQaH
X-Gm-Gg: AeBDies73huTbGheaZk3iiM8Ot4QI7x8IVx70zTH3qbK3GTLQvK7iXFfT/lIYKc5EvP
	SNuEyUz/1Qkp859KouPiPcYIFH7sRMcVolf8WH73whaQjf/XrCgrJI5riWTh3QYOmNeUwXWh/Vv
	ilpJkvsYEvX0RHT50Or7O7+elAQ6xsfLMDiwgDkeNflpAUF2I3ocRhtcTAKE2F3XP3V6ZDPCIYk
	QeGoXCfEByd1RmxNcZ7g0SsCEyuVfsY8xGBpcNhI+QJx4dVEHgiaRVwxkH9xjoR+6x1641SVxfb
	CovBihK9PfGFslmxvIyDjnHzHoptSdG9MCSZh48qq2XlSMWDTC8/8IuPH94FsFjC9tu22JNelXl
	NkKu+nL5A7zkpz5tQIO/a2N76GeBn9/MaBe+lo0DOSEZy+jzjM3b3DGcWScwYFB0fgLG4UNmYng
	EKgMB+vI0v1791D8nNsYMRgNnoIZPanpFw5cfU
X-Received: by 2002:a05:600c:698d:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488d6ac9ce5mr153130685e9.14.1776031887330;
        Sun, 12 Apr 2026 15:11:27 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:e36b:fb32:ad41:43a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm84910805e9.2.2026.04.12.15.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:11:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 1/5] selftests: ovpn: add nftables config dependencies for test-mark
Date: Mon, 13 Apr 2026 00:11:17 +0200
Message-ID: <20260412221121.410365-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412221121.410365-1-antonio@openvpn.net>
References: <20260412221121.410365-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

test-mark.sh installs nftables rules in an inet/filter output chain and
verifies packet drops via nft counters. In vmksft this can fail when the
nftables core is not enabled by the ovpn selftest config.

Add the missing kernel options required by this test:
- CONFIG_NETFILTER
- CONFIG_NF_TABLES
- CONFIG_NF_TABLES_INET

Fixes: 7b80d8a33500 ("selftests: ovpn: add test for the FW mark feature")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260319124114.42f91f72@kernel.org/
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/ovpn/config b/tools/testing/selftests/net/ovpn/config
index 42699740936d..d6cf033d555e 100644
--- a/tools/testing/selftests/net/ovpn/config
+++ b/tools/testing/selftests/net/ovpn/config
@@ -5,6 +5,9 @@ CONFIG_CRYPTO_GCM=y
 CONFIG_DST_CACHE=y
 CONFIG_INET=y
 CONFIG_NET=y
+CONFIG_NETFILTER=y
 CONFIG_NET_UDP_TUNNEL=y
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_INET=y
 CONFIG_OVPN=m
 CONFIG_STREAM_PARSER=y
-- 
2.52.0

