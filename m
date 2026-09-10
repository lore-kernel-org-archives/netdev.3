Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDFC4718C8;
	Thu, 10 Sep 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078793; cv=none; b=gjnIZec57jIhy0VdBzKD07KWv2CBZYmPt5uC/sDRSUpdnAyV4cfQOYvZWpCD2YlLcHrlFj7vevveOnBQObZsVAot14WncIpkEKg7y7/zoRQgA6cLoWPw9MA2m4Hopur/NNQKp/O8EVLcDybl7N/cjP5Cypjw0IM6oW605dFVzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078793; c=relaxed/simple;
	bh=cVC8QHVdM1iUh3+MJEq40ZJsau0S+T8W1sAuPs+QtB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4WzY77DExvkALkyFZcrbgs0SLhNUnfsCXNJa2P5NaWg2TQyE8qGYlbxd8iIwuk9VSieyLf333noc/94EjBFetDM2LWNhCUbcrqlOvI3BTWZmdDxF5JF+ILkfHpUd0hQfI2nzlbeyCCOdmX3wQy8D1rFcenO4wPZMBCPQPIGEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=VJUDXVHg; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="VJUDXVHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789078778;
	bh=cVC8QHVdM1iUh3+MJEq40ZJsau0S+T8W1sAuPs+QtB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJUDXVHgflw2mdqLemKD4fLBcaLmlGQvqpNmizyaBwFYYhswJrTZ3BCLcvoKOlaKn
	 bC+MwDrj/LOG8O9TJsOdtIJVX37RBOibphrYi4V46f5t7pEoCVA7ppXB6pLAVsb6zQ
	 /F0QCVAa3yEOyVQqEQUIj5lEjloMOe3paIZZFKGQJydkX+pRLwpCjnriaMCKFaEUy2
	 bARYEEIb6OnUmakqk4jE5u6Dh1/DLTIIKgY2MEj5+DuSLrh6AOuNSZQleUHCE9EmzT
	 8/QkeqEwp2UQ+N6ShbGhSAvb23Z+DNhdMUmjNFaNF1QEgMOx0UbDJCX1OvTOrZFZ4k
	 jWmacSilrh4lQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EF7BD6010A;
	Thu, 10 Sep 2026 22:19:37 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 19516202556; Thu, 10 Sep 2026 22:17:39 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"Matthieu Baerts (Netdev Foundation)" <matttbe@kernel.org>,
	"Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Heng Guo <heng.guo@windriver.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 7/8] netlink: specs: rt-link: fix ifinfo-flags names
Date: Thu, 10 Sep 2026 22:17:27 +0000
Message-ID: <20260910221733.1021864-8-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910221733.1021864-1-ast@fiberby.net>
References: <20260910221733.1021864-1-ast@fiberby.net>
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
index c84bbd58cfcb..6639b7f5677b 100644
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

