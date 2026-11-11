Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367897;
	b=gEM5+Rb3RzOAKZ8f+WPRjky7w613xN2ggBBtazNdbi5di49NKHPcsfdiYtQnUzSpcuHs
	 cg4i5owZoyV+BcKSNgBHNQlqVzX5HoMmC1us9GLkivGeXiOnapOAjvF91UomRl0AP2GU3
	 zrX990j3u2bHR2PrOJhWtR715xPhXR3IdNOZE/Ssks/YagrlSAalq/rYsQCGUt6B1qKD/
	 PUUSaqFvNN65D6lfL9U2IOpHRDmk0N36EOAROuYECR7Oy7jNIvLwcWy9W0gxuumRfjOmW
	 TqM/bMNKxonnbDDwauVNDSbHJN3r3b2EOuLdrcbqhVpIHPNQSSkIDz84GR6Wn98q9ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367897;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VXGeJs/cCQO0aCYsOzSzvYGgs1xDorb4m6bYnjZh0dw=;
	b=x5CmjGPhykRxPtgvRn30zsbDHMZVTKndW9CUCCSAG4r2fbBywAf2JLe9JytYInjezL67
	 ssqGMRZqGSqoKkG11dlriabhI9UAdRr/XGuwEKIoEjKSnHACyuRsRTyIJ9cSml0xPcnNm
	 0EBMrkqifjq7yZYjaoUBsZ5CaeBcgEVEX6bfKlHkP08CF70195xl6B7fha6Xu1cdMPod8
	 iGLOpZn918KAJCqNPnCBc/J8b0QuICXuS22MsVMSM+Gug/CJUOiS3s5VvVI7ehYyyfSBq
	 6qb0H0+6N78kk8An11AJUsHq39B3i5jZkXlioonTmgrCIqUhEO5w2UgZB9bxngmh1Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xDfexIY+;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5C0606A324;
	Wed, 11 Nov 2026 03:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D5C0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=xDfexIY+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=xDfexIY+AegydL0styz938D2k0WKy6PzbqScekAkINIgJcX1J1o6ot9wb28z/Fh2A/XSA6RLz3nPP
	 VFZTXqEh0+s0JmkqKRDnXqoiJSUUPAtbZBuUV1ZSKm0K7qrm9Kmn2quAIS/qCmqZOPLQGfsC+sx8CX
	 IYUyJJ7PCCzHAEzk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af3e192ff8-d48e9;
	Wed, 11 Nov 2026 11:31:33 +0800 (CST)
X-RM-TRANSID:2ee76af3e192ff8-d48e9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af3e193df5-cceb3;
	Wed, 11 Nov 2026 11:31:33 +0800 (CST)
X-RM-TRANSID:2ee26af3e193df5-cceb3
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
Subject: [PATCH net] net: dcb: flush rewrite table on device unregister
Date: Wed, 11 Nov 2026 11:31:14 +0800
Message-Id: <20261111033114.133296-1-sunwenbo@cmss.chinamobile.com>
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
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
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



