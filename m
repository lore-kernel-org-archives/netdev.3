Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C853B47FF;
	Fri, 25 Sep 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372411; cv=none; b=o2DIBsFfSt8lsD+aF4zapyMnoaRMVOAfUiDdpa2F7wVO8q3ddi32L6ie5B8HoOeaxZcnDkUALFx5pOLnYhnhO0GGOTXEltC0CDXrybTz5CRI1V/pTLXyWEAFvz+8s/BsVNqx0vmVlNHAdCxjScYhVlqwtMigSzfod91Dvw6qb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372411; c=relaxed/simple;
	bh=JYyJhKmwAAd9Bg4cRvg2oYoWlGhButArg2cRMrantwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twQnEowGcC1Ylio7BTDaH+NMgeN5jPhwo8IZ2SeuL0ZznrSP2OEoUExEf4cJDPncZ6qtPVNChMbR8eHfE9OdmmiVRDF9nRt7nFU3cJr8fdCKxp/JQbNSjJG+BP+fXJcjb7SQvozDr3vNXmNUCGHxF58w9ynGvlqoY19H4SwAx6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ZPNjJgX3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ZPNjJgX3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372389;
	bh=JYyJhKmwAAd9Bg4cRvg2oYoWlGhButArg2cRMrantwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPNjJgX3Sl0DfE6ILIiSu79WitKAI0nr/Vf85dkKLAv13mWzLECb13xpA7x1j8GBS
	 M7id7KBJz0iTdzgeH4cjY8y/ig1bHqscSTn5gQ8/aHWyvHxbTkYcDgHoBIKhmW3g2j
	 Dl5tXv5d5oppRFEzcgtMrw0p4ovSWeGRKrCarApNNv/GQTP7A1uOZV2JqTXncgr4pv
	 SRXeKoCT1mMszD7G1Wz5sDzFUP4iCi6x1yqUBg2Xi61yrjA/deq824ZdEnUX9A3OY/
	 /lVRiIRCB8Czcfb7nfjD73+j5hkdxNUTYKHHuxVHQ/6/ZT6uVOTwrWOBtJkdg+7Ril
	 3sMEoBs+2QamQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8569160115;
	Fri, 25 Sep 2026 21:39:48 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 16FA1201BAA; Fri, 25 Sep 2026 21:39:21 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/9] netlink: specs: rt-link: fix ifinfo-flags names
Date: Fri, 25 Sep 2026 21:39:06 +0000
Message-ID: <20260925213918.204767-4-ast@fiberby.net>
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

Correct the names of `enum net_device_flags` constants:

- IFF_POINTOPOINT should be "pointopoint", not "point-to-point".
- IFF_NOTRAILERS should be "notrailers", not "no-trailers".
- IFF_NOARP should be "noarp", not "no-arp".
- IFF_ALLMULTI should be "allmulti", not "all-multi".
- IFF_AUTOMEDIA should be "automedia", not "auto-media".

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

 Documentation/netlink/specs/rt-link.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 3560053cea7a..e3a4b4e7e5ef 100644
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

