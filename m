Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AA4CDA24;
	Fri, 11 Sep 2026 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162983; cv=none; b=d/uzl7QCslslMs1jm+8hV0AstCVoWcAFlHK+ix+kNQ8bf6xbQqhBY8B6HoI2wJrOa4lHH021vGQZTPgAEJMhrq0xU/vkMl7hHr8IS0dy2zNKkRcQdI9a9dIKuqBTGnSH1KHq3rHmx5GkxacnvYwipc5HJDSOSUBH2jS5Rg4+LRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162983; c=relaxed/simple;
	bh=FOSOSpQj8nZs59HKG7FWriok3/cEKCba3kDBC5mfny8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp4S1VVoMe61bn4mo9QuhEY9Jngiz6vjnTJJbgBsj/0flyCf8GtWtr/ptNmEFF3o+9qaJHIzuRrtTHugHFhBQqudEPvKLsUpEgrLPVz8PzL9KXnjuYMImea+fAzcfU+Y5xjyKIdJow2ZiUi/dxDTpkYU65d55jUOjnAGwXwr2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=rEDWFj3E; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="rEDWFj3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162978;
	bh=FOSOSpQj8nZs59HKG7FWriok3/cEKCba3kDBC5mfny8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEDWFj3ElGtsvopN3PC85qzfLFNw/EzT9ghVysf073XAGl7Lf+8GSFZh7tuStQaUs
	 D/fN0E7tK8Bw1dy2CSt/8eJ7JJZTY/qfsLEt8zXrX5m4yYS2j+/1tjzHGd3RkGd4EM
	 IePx2w29kKDMXFU8WMXlzHtg6FcyWBjQEuCFecizboOzfnTkMNmPNu1fmMnL3+fZBo
	 w6YYlmyAwArYOG96eQ+haw0dt75DkXk39SCp61XKwz12AjdsyIB1G8A38XR8TTCN3m
	 Gbwgf0900H5Kyh4Por3pXThB539lFgWfo2SDxO5jfYnVLqF3Gb/3k1x8F6zmTdVdFP
	 nOSP5V7Sk5p6Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 757AD6010E;
	Fri, 11 Sep 2026 21:42:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 3DCCF202052; Fri, 11 Sep 2026 21:42:02 +0000 (UTC)
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
	Cosmin Ratiu <cratiu@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Moshe Shemesh <moshe@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/10] netlink: specs: devlink: fix resource-scope type
Date: Fri, 11 Sep 2026 21:41:31 +0000
Message-ID: <20260911214148.1184806-6-ast@fiberby.net>
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

The correct type for resource-scope is flags, not enum:

- DEVLINK_RESOURCE_SCOPE_DEV is _BITUL(0) aka. 1, not 0.
- DEVLINK_RESOURCE_SCOPE_PORT is _BITUL(1) aka. 2, not 1.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
CC: Cosmin Ratiu <cratiu@nvidia.com>
CC: Jiri Pirko <jiri@resnulli.us>
CC: Moshe Shemesh <moshe@nvidia.com>
CC: Or Har-Toov <ohartoov@nvidia.com>
CC: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 38b1190f3d26..0b3160e201da 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -158,7 +158,7 @@ definitions:
       -
         name: entry
   -
-    type: enum
+    type: flags
     name: resource-scope
     entries:
       -
-- 
2.55.0

