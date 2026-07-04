Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B034EEF7
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167078; cv=none; b=OzA9qNfWxEYV73FTe8FxMffW1YHgys0tEQvNoWhn1dqjpS3pfhkWtumX+aDSTqBpS49dCk3ngYDh5kJBwTbaUHcSxB9FcWDVw7mN1GK2eK6Ioo/o57LB4ylbKSxGZyLezV/fsV2PP4Ky4rgfj/43GxQPJoddLSPuFiPXGo7wfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167078; c=relaxed/simple;
	bh=I0ArMeGYCV7eBZ+H0eMzetwYIqVs237Hckjn6vEC4gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhjp3O6oL8RBMdTFKsDZVhLA2FKw/QJRRXCOnSLDmBt/wOCfigUmVsQ8bZVRs+jdt3f3SAPRPH9EOIsmYV6eS+kr8zgIj5xUpmX4fD4gtyU7u0lBuHvq9zY7eIIChTAxMKfhGYwK3dpYkfCZBlmj9mXO3FV1VaTlyk902gyeXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5qkeUAU; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b5qkeUAU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783167070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=59W4E6bQ83pCRNjQa4BY31cifN2ilfN3ElfL7uzJsQw=;
	b=b5qkeUAU+x4/o24mimYPXtMOxzeX9vnC2QI84dYe5i0EKBzi1BwLAbftjjdrlUpR2vKFq9
	ng2sImo3PgaZr/JKXOKP/lC18XtR+docEGvoHk5UabsLh+OKCRHuctEj/ALt9vW8+4BAFi
	hnHnT0nhh9plwbn2UQ/83r+EfwbO6yw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: chelsio: cxgb4: Use str_plural() in mem_intr_handler()
Date: Sat,  4 Jul 2026 14:10:11 +0200
Message-ID: <20260704121010.201016-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=thorsten.blum@linux.dev; h=from:subject; bh=I0ArMeGYCV7eBZ+H0eMzetwYIqVs237Hckjn6vEC4gw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkeP5TiF036YuX8RzEgpT4p1jPOS+PJKzbui/NvdlTnT TpwN/BjRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzk1w6G//nSGu+urGa4vihq xnWDO9l7rzrrKPmsaejao2WeYbXhiy0jw0o9mcz6GzkJvLWGwVmVR40VL53Sun64QPPLnIWVb9T PMQMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the manual ternary "s" pluralization with str_plural() to
simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 6871127427fa..29d7b786e51e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -33,6 +33,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/string_choices.h>
 #include "cxgb4.h"
 #include "t4_regs.h"
 #include "t4_values.h"
@@ -4867,7 +4868,7 @@ static void mem_intr_handler(struct adapter *adapter, int idx)
 		if (printk_ratelimit())
 			dev_warn(adapter->pdev_dev,
 				 "%u %s correctable ECC data error%s\n",
-				 cnt, name[idx], cnt > 1 ? "s" : "");
+				 cnt, name[idx], str_plural(cnt));
 	}
 	if (v & ECC_UE_INT_CAUSE_F)
 		dev_alert(adapter->pdev_dev,
