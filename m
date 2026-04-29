Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F93AF654
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498205; cv=none; b=dEj+Yd5anaBbwj1rj7bkWtXqKMFEKersFWiDJLz9UQ9RDs1/VdNvdAFtrBrhgSuYR2a7Tch1QTpsxKJS28NDro/5KJWMrv91ZSjSR29FCBDNZCb4rAghrsuR/fblv2xbSHMCrS2O10/FZj02PIV7rsRuk53+0qjQ9gJRdeubqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498205; c=relaxed/simple;
	bh=4Cxb47gcz+vaLUIRcKU20fRqNd9jdvyMRqSuKHHidD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYCcSX+S2g74U4MxJKIgJw+f/kHUy9G6kR1apuz337SC2Rx+9V5fXBQe4QiEFvmY2VOqabjU5NxEW/R3c7lVeazkxRk4BMy5PMOZfoiO/dZ1cHiqV/syJEPUXGVrgguysJwi0gTYAJjFMa7qjq6V3GmHMwbmwfjoetHssrzMDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1uXaWBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1uXaWBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B8C19425;
	Wed, 29 Apr 2026 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777498204;
	bh=4Cxb47gcz+vaLUIRcKU20fRqNd9jdvyMRqSuKHHidD8=;
	h=From:To:Cc:Subject:Date:From;
	b=b1uXaWBkeLA/MSyWPj+WlXOcY8eLXBX/IAmgx0o1v2ejfuMJm1xJCVCrSmWVSox/f
	 R2jU5yZ8YBAMX9ih+J0As3zRKdH6qx2sPqwaIrzj6TsDT3LhlrpqVV0o6zpWQ26RhD
	 Pxis6PUN6oPu/1k2fXiyfjU3vYsQrClitwUHczue7ZahgwjsRMDrmcKijAPq9vbrpu
	 0NV7gTpGNUj+UQtrO8z3rPIQqB9VEO5WUzm17eG92XZVahi1tFYzMkgmWjOx3TvbWq
	 cmnoD2605QS5R3FUUCY/WTjrRUIuJUXRp1JM3Oq/EkbOwRwo9hqraskZenOerww/1e
	 NB27zdaydSPiA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	john.fastabend@gmail.com,
	sd@queasysnail.net
Subject: [PATCH net-next] net: tls: reshuffle the device ops check
Date: Wed, 29 Apr 2026 14:30:01 -0700
Message-ID: <20260429213001.1908235-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We try to validate during registration that the netdev
has ops if it has features. This is currently somewhat sillily
written because we have a dereference before a NULL check
on the ops struct. Straighten this out.

No functional change intended other than saving ourselves
the very theoretical crash with a bad driver.

Note that we check earlier in the function that either ops
or TLS features are set for the device in question.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
---
 net/tls/tls_device.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 99c8eff9783e..741aef09bfd3 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1387,16 +1387,15 @@ static int tls_dev_event(struct notifier_block *this, unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (netif_is_bond_master(dev))
 			return NOTIFY_DONE;
+		if  (!dev->tlsdev_ops ||
+		     !dev->tlsdev_ops->tls_dev_add ||
+		     !dev->tlsdev_ops->tls_dev_del)
+			return NOTIFY_BAD;
 		if ((dev->features & NETIF_F_HW_TLS_RX) &&
 		    !dev->tlsdev_ops->tls_dev_resync)
 			return NOTIFY_BAD;
 
-		if  (dev->tlsdev_ops &&
-		     dev->tlsdev_ops->tls_dev_add &&
-		     dev->tlsdev_ops->tls_dev_del)
-			return NOTIFY_DONE;
-		else
-			return NOTIFY_BAD;
+		return NOTIFY_DONE;
 	case NETDEV_DOWN:
 		return tls_device_down(dev);
 	}
-- 
2.54.0

