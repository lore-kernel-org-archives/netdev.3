Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21962472AA
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619382; cv=none; b=VxCDd8GO4Q9zMsKOuTNVZO8XA34Hf3YwZhuYUlDbfXPNZWLewTcojnUd5DvzuSpFhmLgwCq24418o/YeEXbP74Et9TbSh+pRgsGGyaS0T8Rum/GynV7XqBn/GxKURrbHgfGuRlSOBYxseFtQdcjX1vEw+GXlUzirM8M5PDCj944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619382; c=relaxed/simple;
	bh=UtvTEVsfr9OkLZBLGFDXv2XojfMAMJ/vV5HoCkCfEHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn/waGFItjItgXWZiaO2W9v+QJlFfsrzVpwCGSlAEL2f7AqAr2dtgco5eSVhOjzo5TXm2u+l7HZOhpsI/prwU1rz6SMMcXo/DGRMe3NM+PZP0DQPdfRpKB/Olrekf1YiQIhWGWnaFtXYC/2h1ZCAl9XU5qSnT+vWvn1g4ypoPj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1B1s11l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1B1s11l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C923D1F0089B;
	Fri,  5 Jun 2026 00:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619381;
	bh=H2bxx/LxHkk/q8DJa0K5dR90mP/E2WaPjjgFxfSCXuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1B1s11lPdQIVdhxtz1U1J3WkI4bOuHA5LXOr1GozTAI+ce0Ow3WuYWjsIhqZIsTV
	 0uA4pfOBFByfHES+CKJ4ghxlhRa9gQRhik0BCz6ne0gYGyv8YjZHP9hRzlD9lOSIrU
	 HC78SR2w8kW8VIlM0a4v0zpR9o56HTvdamS4QN5/1/sHaPV2K+7hwSWkG7mb8OFX5h
	 D0rsYZ3MJJIn05mAp6pzgYmaEjMlXdBOvecpZ+JqVpSMdPxz2IzTeN5QLkXXH0Sax9
	 jzjbsWYUFLI9yLnTrXRx1FdgO8qdaFvMeOawWSFWFRxUg5GBjd2tfQtTcS2fTJg32W
	 fxSBDkOkJ3niQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 06/12] net: ethtool: optionally skip rtnl_lock in cable test handlers
Date: Thu,  4 Jun 2026 17:29:06 -0700
Message-ID: <20260605002912.3456868-7-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip rtnl_lock in cable test handlers. This is really a noop since
no ops locked device supports these.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/cabletest.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 8d375dac2a40..9c22d4c767c6 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -73,8 +73,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 
 	dev = req_info.dev;
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 	phydev = ethnl_req_get_phydev(&req_info, tb,
 				      ETHTOOL_A_CABLE_TEST_HEADER,
 				      info->extack);
@@ -101,8 +100,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
 
 out_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
 }
@@ -342,8 +340,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto out_dev_put;
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 	phydev = ethnl_req_get_phydev(&req_info, tb,
 				      ETHTOOL_A_CABLE_TEST_TDR_HEADER,
 				      info->extack);
@@ -371,8 +368,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
 
 out_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 out_dev_put:
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
-- 
2.54.0

