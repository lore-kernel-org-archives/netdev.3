Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13FD48A2B9;
	Wed,  1 Jul 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910549; cv=none; b=UG9p6EEHgv4Kn0c+iPxB62DGzjM65M47IIDiUF7Qk4LdTc1OkYR4A9M5cZ5trkImyClXDEYipdsV1qKB7o3EA7QsgnfEqOozasozcKgzlnzCUQu0QArPijXpNuUXRJzSta1HKao9oiA287/HiwgboICMQS1s27w+vbX5Uh7XK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910549; c=relaxed/simple;
	bh=rqbGOV+zFwjsCWTfkTsylFl9kSxt68LqyNgLXCtmgXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YAd+mDQbj+XWwPCHbZ7gDmSwdRM4ucrh6IwDSnz3SRHaPHh9RYJasUWF8pF7sewNjWy45XN8H6JbTCUOy8I6lDJplDVN+MNZakeCaUGlkDB7sA7xb88h+vGHWK+0Tu/ualDAIcM8xgABR6L0+NNW9nZ09AQCwb+eEbe6pz4PbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kSZiLWFB; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="kSZiLWFB"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 448185df9;
	Wed, 1 Jul 2026 20:40:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net-next] net: rmnet: annotate endpoint lookup under RTNL
Date: Wed,  1 Jul 2026 20:40:17 +0800
Message-Id: <20260701124017.3205729-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f1db1dfe203a1kunmbdba2e9d19cadd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTxpCVktOSkpLHUxCQklIQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=kSZiLWFBo9vdcwmrR4pFwF32iqTJQQuyu1ftuT+IgrVQbgfJmW1gOT5HCQyRNfk73wnTH/XVGSji0IGv2fmhYDGC4bYaV04W6sMigGSKpaP9SosF2Cp60aT0QfGdUkVaRGvTI4XD20BnmMgONx34cJ3G5SPTUCF6JXHJ1y/laQ8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ut43vNK8UwYJ8GztmCx9g9JySLt93tJWdcReSElT5Wk=;
	h=date:mime-version:subject:message-id:from;

rmnet_get_endpoint() is shared by packet receive paths and
RTNL-protected control paths. The receive paths already run under RCU/BH
context through the RX handler, while the control paths reach
rmnet_get_endpoint() after obtaining the rmnet port with
rmnet_get_port_rtnl().

The helper walks port->muxed_ep[] with hlist_for_each_entry_rcu(). Pass
lockdep_rtnl_is_held() as the non-RCU protection condition so
CONFIG_PROVE_RCU_LIST can see the RTNL-protected control-path calls
while preserving the existing RCU-reader behavior for data paths.

This was found by our static analysis tool and then manually reviewed
against the current tree. The dynamic triage evidence is a
target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
to documenting the existing protection contract.

This is a lockdep annotation cleanup. It does not change endpoint
lifetime or hash updates.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index ba8763cac9d9..977fb80d8bf8 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -423,7 +423,8 @@ struct rmnet_endpoint *rmnet_get_endpoint(struct rmnet_port *port, u8 mux_id)
 {
 	struct rmnet_endpoint *ep;
 
-	hlist_for_each_entry_rcu(ep, &port->muxed_ep[mux_id], hlnode) {
+	hlist_for_each_entry_rcu(ep, &port->muxed_ep[mux_id], hlnode,
+				 lockdep_rtnl_is_held()) {
 		if (ep->mux_id == mux_id)
 			return ep;
 	}
-- 
2.34.1

