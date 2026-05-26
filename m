Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFC371D17
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809762; cv=none; b=LTXSsybyTAjpjTVb0cusb/BTLBJH/GFJ8Lgwu7rIwS1LKz+doHC3hqA0g9Akp+fcw0y7wGDvR/TxZcUUyzBt8mKq2Np/naZPg7IGunB7j4KpNbNPjsaGg2gTVLGCJi2enPlpGK6tZjX6cvsC2iRu2PTwKWMQ1tEBdNy/oEzj46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809762; c=relaxed/simple;
	bh=3EhAbhkgcmk5382ypkBUbZ3XSu+54FLZWyI2yLnldWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjebZBzzGLAEGr2/i26v8gqm3GBcsiuetkFjSdLyvMROp0OeLZwABxImLXDYmMwmxxpYx+fki7xl732AjfKQhNQR7ZwQgJOgkZzyiyjxxycBbSAcS8g+H9BGhWavWGzexI2vdSADNlJenKGgiR4NeWQMvqT+OXfs6DyTZUrk1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdzijFiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdzijFiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DAF1F00A3C;
	Tue, 26 May 2026 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809755;
	bh=18iR4P7xryhRqH+56uCBSVcaDxv3nz6Ko9WwPv276vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fdzijFiGBec2aWAi2RLlyL/ClIJddfi5VllIUe6DhAugLGmUI7OOiAbcm4mexjB7a
	 rWUEmXqNcbEjFn17Mwff0TX9AbbCa+0TKuTzLBM0lQEKcI5Xuyhdp/Zw7K+jGaqCMa
	 RdIKqzZVEkubXsFvcWiu14rLEw32WMsLTh+egw/qqJzPAM0CT984sb8x8i1ZSYiXHQ
	 T9lve4swXB6S3QD7OiN3bl7HZ60NPAHY3sJx3r7idGnRqhHeOTjR5LZOkglMplO4MW
	 m3z7+gJBM/XZeyv4+kvdKqoAUcR+PK4lTXtzUxWiVm0CUZO6FPAWu1Lekdf/I8R4x5
	 lcKCWXBIS7WdQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 09/10] ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
Date: Tue, 26 May 2026 08:35:32 -0700
Message-ID: <20260526153533.2779187-10-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All ethtool driver op calls should be sandwiched between
ethnl_ops_begin() / ethnl_ops_complete(). In Netlink eeprom code,
if the paged access failed we fall back to old API, but we
first call _complete() and the fallback never does its own
ethnl_ops_begin(). Move the fallback into the _begin() / _complete()
section.

Fixes: 96d971e307cc ("ethtool: Add fallback to get_module_eeprom from netlink command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
---
 net/ethtool/eeprom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index a557e3996c85..836316df3092 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -141,12 +141,11 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 	return 0;
 
 err_ops:
+	if (ret == -EOPNOTSUPP)
+		ret = eeprom_fallback(request, reply);
 	ethnl_ops_complete(dev);
 err_free:
 	kfree(page_data.data);
-
-	if (ret == -EOPNOTSUPP)
-		return eeprom_fallback(request, reply);
 	return ret;
 }
 
-- 
2.54.0

