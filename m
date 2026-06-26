Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538235A398;
	Fri, 26 Jun 2026 04:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782448206; cv=none; b=HDO3Ajd4YhBeHWaYpnxs/SspO5aTyHt8xIJENqT6uz9+VLAdqKm1fgOvM1KzNmhWf5QH1pzSdCu+aLJJ69D1qgsLRMAQIbsQHoTQVafzspCXkeB5Y9TcvugJQL6DI3CbBg9ZvoxiBCDv8XE6Qvq7NdrET7Ciz1Sqme47uYmojr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782448206; c=relaxed/simple;
	bh=X7WtzjFGjWsAJzn3xlEBeUS1W6k06h0Ut/0rut89SWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+7AhYQ7w4kWeml79yz2KpoMkFBmtoY7wuGH3YUuUCNQR3M4ic53legMbPgZ+htHKhRwLoxPm3yQdd8ZfkoceXewQNTw3PywA1DRSLK/3ekZxqcASHKSj3NOdwjOo2Dk7q7M5/HS1Av/x1FRjpGMTtCQ6+wAOsVaZ3FcT/zxLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=JgdkzGO2; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="JgdkzGO2"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43d953a3a;
	Fri, 26 Jun 2026 12:24:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net-next] caif: annotate phyinfo lookup under config lock
Date: Fri, 26 Jun 2026 12:24:40 +0800
Message-Id: <20260626042440.2013499-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f022c493903a1kunme7711fd48873a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEMfVhlMSEJCTh8fSUJDHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JgdkzGO2m1tXaSY7EoVcDjfYzsC/nvLJCtscAYfMFpsCvQyxgXv93xPQ0wt7moflLozdcDfdLOUFF7ngMM563u/SfBOJHzR5X2EPIf2oePpcWPyilYc1MvtN0O/KgdAeYjOBiqKS4/cpMZk5IwkoH+TZLfSZm9pmt/o8MNWFRKc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=HAHU7ANpHQzghwxPazOxwiWsGVS8V0sDL7Jr2kAIbgM=;
	h=date:mime-version:subject:message-id:from;

cfcnfg_get_phyinfo_rcu() is used by both RCU read-side paths and config
update paths that hold cnfg->lock before adding or deleting entries from
cnfg->phys. The helper walks the list with list_for_each_entry_rcu(),
but does not tell lockdep about the config-lock-protected callers.

Pass lockdep_is_held(&cnfg->lock) to the iterator. RCU-reader callers
remain valid, and CONFIG_PROVE_RCU_LIST can now see the non-RCU
protection used by the add/delete paths.

This was found by our static analysis tool and then manually reviewed
against the current tree. The dynamic triage evidence is a
target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
to documenting the existing protection contract.

This is a lockdep annotation cleanup. It does not change CAIF phyinfo
list lifetime or update ordering.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/caif/cfcnfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/caif/cfcnfg.c b/net/caif/cfcnfg.c
index 52509e185960..6966cc9ab640 100644
--- a/net/caif/cfcnfg.c
+++ b/net/caif/cfcnfg.c
@@ -135,7 +135,8 @@ static struct cfcnfg_phyinfo *cfcnfg_get_phyinfo_rcu(struct cfcnfg *cnfg,
 {
 	struct cfcnfg_phyinfo *phy;
 
-	list_for_each_entry_rcu(phy, &cnfg->phys, node)
+	list_for_each_entry_rcu(phy, &cnfg->phys, node,
+				lockdep_is_held(&cnfg->lock))
 		if (phy->id == phyid)
 			return phy;
 	return NULL;
-- 
2.34.1

