Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B554A4F01;
	Fri, 11 Sep 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162969; cv=none; b=jG/rl8jwo0CjmyhkMgbiKJS9viW3LUuc7eBdRULon/YY4GVil6a73EOX8Pt1bfeo9+yCKaHqM9//RPXnF/mAySSoxI6gcUghbN1kxJkVq/aYanJUzfLHlT28RJ+SBcVREzhiEoY/ox6nmPDYXFRirkqWL+K3rORjgi94XpzVROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162969; c=relaxed/simple;
	bh=lvhj5Dj77ojjWUbqXceTuFGn/6zsa9Wsk8ZMjg2ljOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7nQybdQKyVBmDBk/grUxhwRhETBlPCzaP7aIHuLgELmwsSzgrbIo7hyTBkQkVGiUL0reFOk8Iffebt0iap5P0QjzAzo31KJgH5CXvGSvgXzsyez9xURXdaeWhaCtA2O9e3FoOclkgZbc/XJqIhoANaVYEjXoThdE0fgmfNM+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KBqNthi9; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KBqNthi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162963;
	bh=lvhj5Dj77ojjWUbqXceTuFGn/6zsa9Wsk8ZMjg2ljOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBqNthi9JK/X+sQj0GHvvtkoIy9BG6t+4RAez6zFDINoS+70fMUbF2SFwvbguBjuY
	 oEzzjEjYupLggMNIOO4GgwVAuY5eMcjE2W6Ys70ecvAsVRjiLQFOMAReCPhTq5j7do
	 e/LUvF1sGYk3WesbgJX9CQU/OOv5r1YsKTr9RdXgjCh2cDt4TDimDCtOlc6GpOdwaz
	 enSJgF+ITr2BI9PHnOFp+PE3GiqWQBk5Ht0zpfTnVUZQRoZSzPTRpPtSvO1s4abSB+
	 tRFt5/o4D+EC6IQ0eEVSv08YLJX+NoGcIoBWUn5tUjeWhKxM7dHe4PBdJ1Kln8H02R
	 JWJJCz7+P9TQQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 55EBC60104;
	Fri, 11 Sep 2026 21:42:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id D0374201E22; Fri, 11 Sep 2026 21:41:59 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/10] netlink: specs: rt-link: fix ifinfo-flags names
Date: Fri, 11 Sep 2026 21:41:29 +0000
Message-ID: <20260911214148.1184806-4-ast@fiberby.net>
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

Correct the names of `enum net_device_flags` constants:

- IFF_POINTOPOINT should be "pointopoint", not "point-to-point".
- IFF_NOTRAILERS should be "notrailers", not "no-trailers".
- IFF_NOARP should be "noarp", not "no-arp".
- IFF_ALLMULTI should be "allmulti", not "all-multi".
- IFF_AUTOMEDIA should be "automedia", not "auto-media".

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/rt-link.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 52cac8bba0c9..ac2084d14f22 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -25,17 +25,17 @@ definitions:
       -
         name: loopback
       -
-        name: point-to-point
+        name: pointopoint
       -
-        name: no-trailers
+        name: notrailers
       -
         name: running
       -
-        name: no-arp
+        name: noarp
       -
         name: promisc
       -
-        name: all-multi
+        name: allmulti
       -
         name: master
       -
@@ -45,7 +45,7 @@ definitions:
       -
         name: portsel
       -
-        name: auto-media
+        name: automedia
       -
         name: dynamic
       -
-- 
2.55.0

