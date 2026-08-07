Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757EB3C456F;
	Fri,  7 Aug 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096509; cv=none; b=W2PjTKY0ul9c1Dlk9X0YK/ZTEyQ0w6cGx2KfJfMpTCZ7TffuKBIsysAuMlWHL41HWzsLUlCeZk9K7ZQpEuP2kCbdJ6sy+qC+uQ++w8il5+lPWebih7yhdbHcNAdcLBkE0gvPhZdAXO4RII6DYG0I0cUFpVea0kZaF/p9PFKxh1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096509; c=relaxed/simple;
	bh=2oaTNtC+yzrZw4M7OzF1U6Thlmm+TpScgS8N8xyEniE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jh3PRRpB6mcz46rdy4DEzg/mFaaMAW4wFiyHpaIbbnbzZHeBKu1SrQb7vAo4QJVXY/LD3tTiH9FnGxr64ou/y4csPxDUt773l7RQKy1Tv2LAbi5AWrVwfK3lvaKqsNfZrkoI/wepNiR6UR4KW4t9wGF3mbA5cALvN2jfL9CW+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=37k6bhZT; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="37k6bhZT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7vp+NRB3EBSondAr4dhickImP5aK5Ze0Cjct3FNzZIY=;
	b=37k6bhZT5cSto3sao5X5p+U40u93BRR+bFD/Sl8GkVAiDEpPTNW1RLcOFcrHbovIqJBjpwTFB
	2W63mPVhY23Iws90EtfBsZYtklt8gNmzTs9pwh9YHBm0wUpcFVtQ23T0S3FIdI99BOHo94DmV0u
	7902dpoGFJxEmyWrXk/Q5nE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hGfPT2VZyzRhR0;
	Fri,  7 Aug 2026 17:44:29 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FA0820333;
	Fri,  7 Aug 2026 17:55:01 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 17:55:00 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 0/3] net: hns3: some cleanups for hns3 driver
Date: Fri, 7 Aug 2026 17:54:32 +0800
Message-ID: <20260807095435.2959246-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

Patch 1 sets msg->desc to NULL after kfree to avoid leaving a
dangling pointer in a struct that is reused across loop iterations.

Patch 2 adds the missing const qualifier to the reg parameter of
hclge_log_error(), which is never modified within the function.

Patch 3 uses the txqueue parameter passed by the ndo_tx_timeout
callback directly, instead of iterating all tx queues to find the
timed out one.

---
Changes in v2:
patch3:
    - Use h->kinfo.num_tqps for bounds check instead of
      ndev->num_tx_queues
    - Restore the netif_xmit_timeout_ms() check by making
      hns3_dump_timeout_queue() return bool and gating on
      its return value, so a cleared stall does not trigger
      a reset
    - Fold the bounds fix into this patch rather than tracking
      it as a separate bugfix, as the OOB has not been
      encountered in practice

v1: https://lore.kernel.org/all/20260804130933.880552-1-shaojijie@huawei.com/
---

Jian Shen (2):
  net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
  net: hns3: use txqueue parameter directly in ndo_tx_timeout

Jijie Shao (1):
  net: hns3: add missing const qualifier to hclge_log_error() reg
    parameter

 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 48 +++++++++----------
 .../hisilicon/hns3/hns3pf/hclge_err.c         |  3 +-
 2 files changed, 24 insertions(+), 27 deletions(-)


base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6
-- 
2.33.0

