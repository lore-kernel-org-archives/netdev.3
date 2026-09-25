Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1D3B95F6;
	Fri, 25 Sep 2026 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372959; cv=none; b=Vp3l9h5w31jNLeuENYdluUlbGxP5gKbtj7eco+dDaNOJrgFbDS8DK35nlZA1a23nHl/x2yqiyFN67GG/hbsRGDwimLvDfoVwWs3f992x4VWlMOuQK7Wvsdek8M7rsszwD2LDCbVMy0nPLRdwF1hM7IMeyoleE6IBqdTwi+dsguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372959; c=relaxed/simple;
	bh=7NC5G3csMv5p+22Cf/72rTlSEpkcmumG5UDRewjXmbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNQqagYECKac1e5HbGDF6xm0HeZGBfAs8mL+N7/jAnC4u97cE4Lhin80BZmVf9RNPEzd1ydFkUJVvOTS12wm2LwZUyyuypvSbUsd56Gnrp9YIHmitaiA0jY+lEQtgvvRHYaIRSu6nYZgemgcGDIqLVOVOa1zVutZK2Sr1fL5/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=QK28C7Hl; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="QK28C7Hl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372389;
	bh=7NC5G3csMv5p+22Cf/72rTlSEpkcmumG5UDRewjXmbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QK28C7HlgjRVFSerpjq7tyQT/6r/E+VJNmwNGZaU9m1mjgIT/TsxrkLQsZtUZqN9y
	 SwfzJsMJgcFPuRQWuyWqOn1lp/AYZ4SAzHJpZvRB2kgjaDLtnvUA3hi74JF4bbnNDY
	 /whqOcOmpvut70+BpRWPedEy6SsZPWVP+/y0SPOYbqAyQWDFiYin6PSWK5o1S8Y+8z
	 cxWaQQAy0iTSeqUWadaLdsvwpBv+15RpX2mjmSr7ZCzEvVdwOaGwYEqP/FUNsGz3BY
	 b5c2okOL9XL41qx/1+C3g6KLmmtZutDzIOxvVUtnEWO7xdIG90JvrfkDgS2DWoZ/Ik
	 YxZ2P7B0N0r/g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 332886010A;
	Fri, 25 Sep 2026 21:39:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 21D96201C0D; Fri, 25 Sep 2026 21:39:21 +0000 (UTC)
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
	Jiri Pirko <jiri@resnulli.us>,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next v2 4/9] netlink: specs: devlink: fix resource-scope type
Date: Fri, 25 Sep 2026 21:39:07 +0000
Message-ID: <20260925213918.204767-5-ast@fiberby.net>
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

The correct type for resource-scope is flags, not enum:

- DEVLINK_RESOURCE_SCOPE_DEV is _BITUL(0) aka. 1, not 0.
- DEVLINK_RESOURCE_SCOPE_PORT is _BITUL(1) aka. 2, not 1.

This patch also removes "enum-as-flags", as it is now redundant,
these changes does not change the generated policy.

Before this patch, this generated devlink-user.c function call:
devlink_resource_scope_str(DEVLINK_RESOURCE_SCOPE_DEV) returned "port",
not "dev", as it didn't use ffs() to convert the value.

CC: Jiri Pirko <jiri@resnulli.us>
CC: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.

 Documentation/netlink/specs/devlink.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1de0daa0f921..4706de628392 100644
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
@@ -903,7 +903,6 @@ attribute-sets:
         name: resource-scope-mask
         type: u32
         enum: resource-scope
-        enum-as-flags: true
         doc: |
           Bitmask selecting which resource classes to include in a
           resource-dump response. Bit 0 (dev) selects device-level
-- 
2.55.0

