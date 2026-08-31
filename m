Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A7368D40
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194523; cv=none; b=Vde+BVXjNNYkcfq/cab6n60Tg1zEOGxIvNd8WI4dBv4p/p8pl2HKGDas0q6aBY/i0YtaALord+iThsS7oUjHa2cgFbJYvnp4t1acYhxLdNXUzBrmjGm249bG6P5bST2dnvIiJxNT3P8Wz5tc42FpthecApWqEhVLcszM7vkz3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194523; c=relaxed/simple;
	bh=Rz9Ix5DpE6T3GFXhGgDOApwx5iGdYxGx6Tu5/o5quEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBp+oWIL4UCGTCvvqx2U5E2s9gZEwEN+qYoftED5FS3mx4rz7SWamVAHn2mw/F0GSwmSreTLXIrcMAhTV1gl61YOsIJWMjqA3UNuZwPI0KV6aYAzucDk5/m3qv2JScDXAqT6mu/r/fKrKYGmAUYL/YRZBhRlfoGOobS2FPXPGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+SxF07E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+SxF07E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAC71F00A3F;
	Mon, 31 Aug 2026 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194522;
	bh=t0cXo5gxzRbDKwF+WzZs9RXd0w8YCIz+RyHvDMzrLmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+SxF07EBgt1hcUmuHRvKO5V22YHoTZEwhF1X3iCFjOfAixn9UtVoyAbdRlRMDACe
	 dif1IyCf2o6KGaQ4Q3E3gJvrQUd2YkPHgFhunxzWnNcSSlVCyTFs0nAMFsE45n59fB
	 TYA/4ClhNLsExFrvBhK6kdGHMuy5+V06D59m5VzZXdHqmdS/uhxptwciReGgEhNdHl
	 jqecfCrXHwPNzWMtmayIL/U3/7hfjpAljvfIa/zlIaQWhYX6jgiQTqmXQ8EdP3dSg9
	 6y4YDEK5RoqZPsUsoKPs8atuc8kXWHsluhQ/xIxogqjhMOeJj9yy5zaroO/zphUJi5
	 HV4Sgh6V8FCYw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	razor@blackwall.org,
	bobbyeshleman@meta.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v2 1/3] netdev: correct error code in netdev_nl_queue_fill_lease()
Date: Mon, 31 Aug 2026 09:41:56 -0700
Message-ID: <20260831164159.1124679-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831164159.1124679-1-kuba@kernel.org>
References: <20260831164159.1124679-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_nl_queue_fill_lease() returns ENOMEM on nla_put failures.
This is wrong, the error code should be EMSGSIZE. But it doesn't
matter, caller of netdev_nl_queue_fill_lease() just checks if
the retcode is zero or not, and uses EMSGSIZE.

Reviewed-by: Joe Damato <joe@dama.to>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index cb18db681640..04dcd7fc614e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -434,7 +434,7 @@ netdev_nl_queue_fill_lease(struct sk_buff *rsp, struct net_device *netdev,
 nla_put_failure_unlock:
 	rcu_read_unlock();
 nla_put_failure:
-	return -ENOMEM;
+	return -EMSGSIZE;
 }
 
 static int
-- 
2.55.0

