Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAF3955EA;
	Fri, 25 Sep 2026 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372958; cv=none; b=BCkiWp4fStfk9OBtG7NOE026fGYrx/nBsh8Fmy9xuxv9xlt2tF9mfRnlxy8E+4aVW3cpKq6ZTfJVMFCNrLzG+AIzRJoQ6G/+6nmlvGY6k03shXYNS0Nc/cstZeoqRaNJHp9veyIVF4PnEXCRTWuvtbXQribaPLxRIzPMaSZunGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372958; c=relaxed/simple;
	bh=mF4wNvs3y+lhNqax38W7HEN8Fi6qRZaQQqK3pBP4NCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWm7jxL5RwTnrBFnAC1cZuWE6IxLXwAeBqqrxEhv4yP/mNyJfZgabG6JBT5Fdi1L58xq9Dku4jJ5UUcnlYZ8XobEeCj0A0JyLHij1Rsasd3dLVlYjdbPmCkwvtoc2cEfBSMdm0Iw8DgPeyKPbkjIljqNWMUZ9gLYIeQ6WLGhuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=CNFvS2Ag; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="CNFvS2Ag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372389;
	bh=mF4wNvs3y+lhNqax38W7HEN8Fi6qRZaQQqK3pBP4NCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNFvS2AgXVka6TAcJWkuGW/pLEMqVMcpgFJk8n/KLScHvzuLpvyukpY4z7h6QoDwU
	 muwdkgMmanVNtcSjIkgkj/U5dE7qw72aIyQhYXQrYtn0iLFkQ5Aj6GYN+FsruBRXLk
	 HodLJryjyaCqlceSS+W4Tfhqc/gPCwSP+qfkalyn4hPJky/ouWdpdZyo6BImzpIBQZ
	 uZlFiVrMV22nV8yt0rYRMo0rw2Fhykc+1jj3VsGMv+/1AMsTlkqS7jTDBPhlYCV5kB
	 ATCZj98Rq3p4D1OstpoAe5J7ieTSKgGjzx1J1I9Okfkkw6HkDoQNAjt0Zoaqv+Kf2c
	 x4gS0kpFTafvg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 917C160125;
	Fri, 25 Sep 2026 21:39:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 54AE2201C67; Fri, 25 Sep 2026 21:39:21 +0000 (UTC)
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
Subject: [PATCH net-next v2 9/9] netlink: specs: fix incorrect name-prefixes
Date: Fri, 25 Sep 2026 21:39:12 +0000
Message-ID: <20260925213918.204767-10-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925213918.204767-1-ast@fiberby.net>
References: <20260925213918.204767-1-ast@fiberby.net>
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

CC: Andrew Lunn <andrew@lunn.ch>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

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
index e3a4b4e7e5ef..81b58633911d 100644
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

