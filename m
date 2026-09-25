Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167B23EA8B;
	Fri, 25 Sep 2026 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372959; cv=none; b=u0SKDfj+LNr3atNVR8qFmU4WPL/bMnTKQoBZY1HBD1Ewq+Tgn16lnUhmk+2IyTxsJagm1oxduU3YiO6I7IQtbf6E5FhTYMifm+ComQJeYTXUdM3U1u+630JCDI0n6FKVvZIUbvIFD91vSDCZYxkNLShMn1OrAa3TiD/oKJ+dNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372959; c=relaxed/simple;
	bh=hhlZW+W++wgzRjYmodjImsJDLmiKfpaNnmOaq4Wn2zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWvy+eJhWdiHGNvslYaHwroOK2OpdFi17zeGN3UGB2ef8dLvZD/u7juQCXTHKkmiVG4ee2a6bdR0qkyLXkkDwPhRerqCsVO7kyUv1VmiVHCZHfI9r6MH7dU6Q4B15mYdek0ZFxoF/QpjlC5FdbTJAaCy6OdKvhksFt9zFQXSxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=uD6eiqSc; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="uD6eiqSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372389;
	bh=hhlZW+W++wgzRjYmodjImsJDLmiKfpaNnmOaq4Wn2zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uD6eiqSc+7X30jyY/aMbVa7qf3N8Co2sYrtiAJYNDoDMmkveem7UxQIFuQrcEkDXC
	 XetmpALiVV813ZjbjBATpJrxRB6n/S0IslRoZGXCSWBYJ7JUuilTOYXKOQ2DytFkjI
	 6B2j+lKFljuHdKU/d4pEEp9RkMUsUvJjmdL9wJg6xu986gN9KgAE4vp0S1aeNK9Jmb
	 7HfMUvvkNaDh934MeedKfgzfJxa6D5yhGycsvsoRUMtr6bbBWMzA2YUQuYyGQFOf7e
	 j79VhfE2chUo99208NiS0yq1bsgX+/YUlMzXQlyavAXqv2xWSFDVvhg6VyztUOzhpN
	 Be75LVFHLG9jw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A6CF560075;
	Fri, 25 Sep 2026 21:39:48 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 40623201C29; Fri, 25 Sep 2026 21:39:21 +0000 (UTC)
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
	Joe Damato <joe@dama.to>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Subject: [PATCH net-next v2 7/9] netlink: specs: nl80211: fix naming of enum members
Date: Fri, 25 Sep 2026 21:39:10 +0000
Message-ID: <20260925213918.204767-8-ast@fiberby.net>
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

Use the correct naming for enum members:

- In feature-flags, it's NL80211_FEATURE_ND_RANDOM_MAC_ADDR,
  so "nd-random-mac-addr", not "no-random-mac-addr".

- In commands, it's NL80211_CMD_UNEXPECTED_4ADDR_FRAME,
  so "unexpected-4addr-frame", not "unexpected-4-addr-frame".

CC: Joe Damato <joe@dama.to>
CC: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

 Documentation/netlink/specs/nl80211.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index d9fdd66b497e..efc783fb8fdf 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -97,7 +97,7 @@ definitions:
       - unexpected-frame
       - probe-client
       - register-beacons
-      - unexpected-4-addr-frame
+      - unexpected-4addr-frame
       - set-noack-map
       - ch-switch-notify
       - start-p2p-device
@@ -202,7 +202,7 @@ definitions:
       - tdls-channel-switch
       - scan-random-mac-addr
       - sched-scan-random-mac-addr
-      - no-random-mac-addr
+      - nd-random-mac-addr
   -
     name: channel-type
     type: enum
-- 
2.55.0

