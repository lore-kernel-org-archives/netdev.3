Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D7424D58
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774516; cv=none; b=IZNzNyxQNOuL4BcJ9Uqc/vmpDc5Rkg88HCNHsPMwJbDtWbtW28iBzvif+BRPVQ8sqyagwbAFL5iOEWO9w2nNevH1Q/qHOPK6hD95jZuJpeBv77wmEa0mblMcwP6/yRuYaBEteSdv+5ygo0jk2HIbxZTdUzX7AvqGO0pWp0cVtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774516; c=relaxed/simple;
	bh=Znhy9yn5b81v+QAcdiMnxOmRxxBxG6BRBXmGN4tWj6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=exge6wOeZV1rRVWTHE3yuYrUzTyr/aq0xsFmO8WSk65khrmDX7cxkCDlWh5DS5GHcKFFFnbld6vYq234DEoEMB58tddWIrmDrtMKaet4CyZKrN5r3jW9koJxoLmXxgv3og1HPxDpaBeMeniNbhl/J1AlstH13ZvIVLkG8qpuVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ALSwTc8E; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ALSwTc8E"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843e9c5960so3342288f8f.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788774512; x=1789379312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rozep1Nd9gPmq9At2RT1kz9pDynd1CZ982/t935zvDA=;
        b=ALSwTc8E9uU6l3XDxrKufs4RX6f932myz+3sF5FE9VTdd3u9aBtMyNG55yM0zbXSEN
         7mtuDyYywyaLvH9XsrHF8bV4M/M9awMxqY/ZdT3BF0jYxKjSzwTr4W/QHzeFmEzTJRKK
         wi/gE+7kiC/V79oCk875HqdSt7EqPnCzJ3X8fG4sahOqacgeOoFCjPOfI0N4QR1Jh38P
         fmam7XDGdCgL2XHLN53u/FBFACGxTE7GGV/0KDAS1b1mHPrKrtHVsBO1g8+J4VUXYvab
         KOlIVtYq/q0hDgQGsnfxSbsmi3kkvZn0X11bjGS/sjmx/DVsbJL8+jdQLkjf/PtFNPf2
         NnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774512; x=1789379312;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rozep1Nd9gPmq9At2RT1kz9pDynd1CZ982/t935zvDA=;
        b=ZgFqP/F3O+0ZM7yI4o4huiE/Q2Ik/lcLejXE3ViVRe+X9zv2r11u1lXOMQzyN8w7QA
         A1qs4YE1zJzfb2PYWRSUoW7KkGCNd1XqtbHen77ax1IZwY72y7eb5ja0SR/dCQcpSEoG
         1qhQ5/HazPjeBVZxagEiDfg3ra2jM4FLrM7P1sHu49OQzKwVk+JtJOLra5o9LtYOe9kn
         CBZyG7YWBfTorAFNHItjLztuKGxkHu0hrfH68WgpQh9vDpoGvQmx8BMQoFMXX+2RspZQ
         Apo+Qom9sTcSSwmzUdA+dycdGYfpi3yFmKEJVj9MhZiEAYLW20mKQUZUirH89wSDe3+E
         yyMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEIt7p9pacEA7E5V8TAAanrFn9IbF5wR9e5VZaYUojfzlHnmthhlljIK4y/96npFKUEBLs5mM=@vger.kernel.org
X-Gm-Message-State: AFuF++mwESFhaBkukEIKGYMPm8AvCeX2LlGGAmlD93ru67B+FjPMPlfF
	BLv+X+qvASSgNvafeLx0L6Lyd68oa0oMQSx8IoC9AY2eXSL1LYkCXPJ1JizSTNpAPY4=
X-Gm-Gg: AYBFou1Dbs3nHbCxNQq5inj7uyOdHYQvgjlKjMv10qxYjoIF9cP0F1ir9J8nm1Hzwxr
	4ko5SswUx1NNSh/NKoU9xIOuZHEBkTauDbVvq2j69UsHllcuaneeoLofiBTbqrbeG9NbwPTuW0I
	pzbkFy1V3+0lreovFBmKvl+85OwfO1tUdA0W8h54JagEP2ylZPrpLLr8+EjuaSlQIQ4/fwuh7oO
	lpVyDKNn8d8ij9ceHljP4eibYgc/uvRyWwsxLqXXDC1nQEJFVx9HA5g0sxTlhvsTMyfFax+1pqq
	GT13zlgta7Oj8qnftIffZ2iCZzolrq6+M13vcFEstjRMzzEyXVMQPJyF76xrGTtfo5bZ249bM/t
	LxxYwUK0NaM4+SzxNgrbqNgi/uibX1n2I91d8/dVpI8AZ0+OrHyUi0T/pZ7+lTIQCtsVebG7X1W
	5i4OkjqDwxy98T2/GhXpzjXpmHYecZvKurE/FKaXc9qckBQSorFyUzByPOJiYspS6xWaV1ewCDo
	k7AUUrPg2iMflJbYjyrfw==
X-Received: by 2002:a05:6000:41db:b0:485:82f9:44b4 with SMTP id ffacd0b85a97d-4858709c044mr25136906f8f.7.1788774512475;
        Mon, 07 Sep 2026 02:48:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858dd90e1fsm25976318f8f.28.2026.09.07.02.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:48:31 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] Octeontx2-af: Add WQ_PERCPU to alloc_workqueue users
Date: Mon,  7 Sep 2026 11:48:22 +0200
Message-ID: <20260907094822.121457-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

This is also enforced by:

    commit 21c05ca88a548 ("workqueue: Add warnings and ensure one among WQ_PERCPU or WQ_UNBOUND is present")

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 937b085582b5..b8f81e068f53 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3371,7 +3371,7 @@ static int rvu_flr_init(struct rvu *rvu)
 	}
 
 	rvu->flr_wq = alloc_workqueue("rvu_afpf_flr",
-				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!rvu->flr_wq)
 		return -ENOMEM;
 
-- 
2.55.0

