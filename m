Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454605;
	b=gILEAss6GTjZuZCqgJmhdRMcO3YFcHY1KLY69IcdaFLVcX4NDd8xWw81P88om19u+oxe
	 unV5J3vOLKtEfRuyNVAjlUhpHP02kEI2jjA5ToKNm0rSguyK2oYl5zXfmtwGnjqyBBVXK
	 WGPKhIaixXSFEvw6NyfRD+14bS3fmWtZarN3RvfmsjbtsWAMfLRh30yIdbpsSust0VFwT
	 CbERq2nr628M8u4GtAkXkYE5urW8f0DBEqpJtp0AmZF2VsKmtsXFTfqqEGg5Vb1QdyIvy
	 7lUiTafZ6Y5A5QlSoUuxAdzChZV2UiWEFsXL1HTq7u8K1da/jNGm1tPL2etLwy+qgSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454605;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gN9Tyx2FqNCHFZUeFzXAvqkF5h5jT66EcfPlDZkPMDo=;
	b=4u1OUGZu4b0N8v3+qzJqk5n0MVtsosQU8tKhJhwnn+2sPee4he12RveD275HXbrmkepR
	 yjHAdax6vMbND68Mz5GsTy1nuwh//9WGF64e6318Ayr1kpcBGLzS1dSWAfIB+S0Qxmt9O
	 xQE0M41STlMaQMcxEk2Iaay1r9q2Reg1YbO8K+Oq1lWtMqQRb/h7D7QdH4i882REaKjNl
	 hDrG5YH5pcbvsF+kaa2Yed7uHUKqm70vUUPGmsN12Fg2K5ZoDlakPZR33JT/01GsruzL+
	 4P1JaIur61eCzYiRrYN+5OWfCCRSz4L/yWrn7DSkarf+W1CJyy6auC8Br06ywMZftYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RiVU9U+I;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE44606A31C;
	Thu, 12 Nov 2026 03:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE44606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RiVU9U+I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=RiVU9U+I/YcePVre89W+4mKr2PW4M+vRlCft7YfevsOEeNbZRccAJ0iIILRgDkoWU9Ed6qVvXzgb1
	 uiwzLB1pJAoLtPMDf/TuKI5iRkH3TaCuCC5NwGpohUZeLe09NAgIFr0FewhwgkmzaekQEnixwmipTg
	 P3uMtrHsMWUnyiaU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af53445443-aa185;
	Thu, 12 Nov 2026 11:36:41 +0800 (CST)
X-RM-TRANSID:2ee66af53445443-aa185
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af53448136-f157a;
	Thu, 12 Nov 2026 11:36:41 +0800 (CST)
X-RM-TRANSID:2ee26af53448136-f157a
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Daniel Machon <daniel.machon@microchip.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Alexei Lazar <alazar@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net-next v2] net: dcb: flush rewrite table on device unregister
Date: Thu, 12 Nov 2026 11:36:22 +0800
Message-Id: <20261112033622.40333-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dcbnl_flush_dev(), which is called upon NETDEV_UNREGISTER for net
devices with dcbnl_ops, only entries in dcb_app_list matching
dev->ifindex are freed. The entries in dcb_rewr_list added via
dcb_setrewr() are not flushed.

This causes a memory leak of struct dcb_app_type nodes in dcb_rewr_list
when a DCB-capable net device is unregistered, and leaves stale entries
in the global rewrite table that could inappropriately match if another
net device later reuses the same ifindex.

Iterate over dcb_rewr_list in dcbnl_flush_dev() and remove and free all
entries matching dev->ifindex, mirroring the cleanup performed for
dcb_app_list.

This issue was found via LLM-assisted code review, confirmed by
reproducing the leaked rewrite table entry upon netdevice unregistration
in a User-Mode Linux (ARCH=um) environment, and verified in UML by
confirming that all rewrite table entries for the unregistered netdevice
are flushed.

Fixes: 622f1b2fae2e ("net: dcb: add new rewrite table")
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Tested-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
v2:
  - Target net-next instead of net, as this has never worked and is not
    a regression (Petr Machata).
  - Add Reviewed-by and Tested-by tags from Daniel Machon (verified on
    lan969x) and Reviewed-by tag from Petr Machata.
v1: https://lore.kernel.org/netdev/20261111033114.133296-1-sunwenbo@cmss.chinamobile.com/

 net/dcb/dcbnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index ad0aebe0ad3d..95250658ecc1 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -2393,6 +2393,13 @@ static void dcbnl_flush_dev(struct net_device *dev)
 		}
 	}
 
+	list_for_each_entry_safe(itr, tmp, &dcb_rewr_list, list) {
+		if (itr->ifindex == dev->ifindex) {
+			list_del(&itr->list);
+			kfree(itr);
+		}
+	}
+
 	spin_unlock_bh(&dcb_lock);
 }
 
-- 
2.33.0



