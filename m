Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EA3EB0EB
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030039; cv=none; b=Hsio3CpdqXlUM2lyN2JCmcbS1iUaXWfBIEnUO8jxV5hJjq8iUStBOa/RFtE115WIzznla4mPjqdhP/X7dbxsp6CyozrJriTUglozIyLpKWh7wSX4QYMkM8IAiSglL5JdFWmf53yu8Mw1CfRURkp9i7OXaHDs1hl52Qde+Rbc0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030039; c=relaxed/simple;
	bh=8RnmLHfVco9U9Si7x4pweZv1HK/VDf2HEArbtoqyirM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mg3Uj9SmKmBy91YhhkTuaEwRZPCKfLgTHIXERjXKpHEmmnHg0X+f5kkke2l67xFQir0oyTrEHYAocBneaxL9E5nCv/0phPVpzvdG1oDvewsibWgrY2DkPeuAk2efVZr6NgGRqCauyg5iGqO3UnbpQnzws6aAcLcErcT52dq8ip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3M8B9WD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3M8B9WD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C7A1F00893;
	Tue,  9 Jun 2026 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030037;
	bh=+khGmuUb5g/v+Sb54h+zvvg7Ve+5PK986qvwUpB5He4=;
	h=From:To:Cc:Subject:Date;
	b=f3M8B9WD7fJAt04+DNrU1JFowMGQb15R0skryBLA3dizgwPejMUqQJnZ+CTG2eCPa
	 ehcRKhEMcuMw+LVKwrn88WfYseFTugwdTT7ljuSlJuC+pKEy71VZxbaTTNdjtNx20n
	 4gTZvXHRsUWGWtMrDrwd7wqn9kiack4asa7ZpA9KhEpU8z8NU4XW2qrx431Mo+PPDR
	 B5RaVjXqtrSGpDL4LemYhyvn1e4uN5+O2dta6L+mLH6dA+r/RGOO942KWLE6JFDL+g
	 +in61eWKvLx+806bAjVII1XHdGYq5dQYvJTVqoRsspHfUSX2e3N21xJH//wSi6tBfZ
	 y8uYNSMkloa6g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Subject: [PATCH net-next] net: sched: avoid printing uninitialized link speed
Date: Tue,  9 Jun 2026 11:33:53 -0700
Message-ID: <20260609183353.1109641-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sch_cbs and sch_taprio print ecmd.base.speed, even if
netif_get_link_ksettings() failed. When netif_get_link_ksettings()
fails the ecmd may not be initialized.

Use the always-initialized speed variable instead.
The semantics change slightly because UNKNOWN will
never be printed, but that doesn't seem important
enough to complicate the code for.

This is a _dbg() print, anyway.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: vinicius.gomes@intel.com
CC: jhs@mojatatu.com
CC: jiri@resnulli.us
---
 net/sched/sch_cbs.c    | 2 +-
 net/sched/sch_taprio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 85b41ffc63ff..1c93469c56e3 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -340,7 +340,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 	atomic64_set(&q->port_rate, port_rate);
 	netdev_dbg(dev, "cbs: set %s's port_rate to: %lld, linkspeed: %d\n",
 		   dev->name, (long long)atomic64_read(&q->port_rate),
-		   ecmd.base.speed);
+		   speed);
 }
 
 static int cbs_dev_notifier(struct notifier_block *nb, unsigned long event,
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index e83cbce62a54..558987d9b977 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1321,7 +1321,7 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
 	atomic64_set(&q->picos_per_byte, picos_per_byte);
 	netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld, linkspeed: %d\n",
 		   dev->name, (long long)atomic64_read(&q->picos_per_byte),
-		   ecmd.base.speed);
+		   speed);
 }
 
 static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
-- 
2.54.0

