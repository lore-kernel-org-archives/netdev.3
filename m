Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A74C7543;
	Fri, 11 Sep 2026 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162974; cv=none; b=KqkUxGGx+PVUUKkhlXrg/0+qV6yQ+/ZJt51BWlv0PpEv7JiWqp4VqyAKno7Is/uTlskISht5kuO2ogwGueyY77KZwsDucSwAs/hVVeHXsJ0e4Uh0TI/emdGwyN/pR/iL5bwrgsyr0l3Jfb4Ja01g5LlHxvxtXt8aCyyEI8Pb96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162974; c=relaxed/simple;
	bh=bQN9vxLmWFfXaYeWwATK8g+XS4ejO8m3xqfPCHGSNPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3lrWeT1MXtWBasKvorDvfvS5odTmzyV1D577nmI8Z2az6nHt668QFKCeUXT8uUUbgLooEs8SQNMRexPFgTZxPWCcdUr77gPleqXEHRjkUtWEACA3zLOUVQkfY9E0PlioimVSp6uDJ5I0TPzbeyzLxEh+BQtY9FHn4uD0ocYOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=s/u0uzzQ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="s/u0uzzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162969;
	bh=bQN9vxLmWFfXaYeWwATK8g+XS4ejO8m3xqfPCHGSNPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/u0uzzQJK5Cehh6/SiYVsN44M6lIbCJPF1EoY2C6xCs2ka/0d6p56j9XwfrZj0oC
	 vHSitWf8CdlIl9AiW6D7YvM6tZF8MbGB9c4eoX5iA2qZAF8W2zkgb/WcASI2zssRLS
	 4sYXoW4iXIz+o8refVQkdnZZBuifpbQr0YNkc6KD7EAzVwjmz6XljgToCNqfyyuBQg
	 jzD4m4awV/IJ7rp6Qf5EXjVkgStztlrgzhSsQMrSBmvS+RH1+cIEZAD16ZyrKAv4ls
	 i1GgrcIZ9Nig6+IjhYvpfxEzva+vDEKWgGQZybL4nf6H5+GMe6M6pzbF3OM92wXXt8
	 80TwtPA4X/kyA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8D85160113;
	Fri, 11 Sep 2026 21:42:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 3765D2025B6; Fri, 11 Sep 2026 21:42:22 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 10/10] netlink: specs: fix incorrect name-prefixes
Date: Fri, 11 Sep 2026 21:41:36 +0000
Message-ID: <20260911214148.1184806-11-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911214148.1184806-1-ast@fiberby.net>
References: <20260911214148.1184806-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix two invalid name-prefixes in the specs:

- It's PHY_UPSTREAM_MAC, not PHY_UPSTREAMMAC.
- It's PHY_UPSTREAM_PHY, not PHY_UPSTREAMPHY.
- It's OVPN_MODE_P2P, not OVPN_MODEP2P.
- It's OVPN_MODE_MP, not OVPN_MODEMP.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
CC: Andrew Lunn <andrew@lunn.ch>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/netlink/specs/ethtool.yaml | 2 +-
 Documentation/netlink/specs/rt-link.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6868eb473478..a66594ad9e73 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -99,7 +99,7 @@ definitions:
     enum-name: phy-upstream
     header: linux/ethtool.h
     type: enum
-    name-prefix: phy-upstream
+    name-prefix: phy-upstream-
     entries: [mac, phy]
   -
     name: tcp-data-split
diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index e8af962c8064..9743989ded2b 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -842,7 +842,7 @@ definitions:
   -
     name: ovpn-mode
     enum-name: ovpn-mode
-    name-prefix: ovpn-mode
+    name-prefix: ovpn-mode-
     type: enum
     entries:
       - p2p
-- 
2.55.0

