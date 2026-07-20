Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9E3E1687
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542159; cv=none; b=ExVEZmwGwLhJGNIAtHEdvoP6SVzUwPHrHTHhXPPxSMF9PHFa7lHdD0UDE9r0ueTHI7nCsjvHmv+YYSmaPogmZiepSMhASYjWiFe1BD2BKPBhLp6q5IHC9y5ff0hiKo66YcFADbMZyt15j+i/QPFUkUmyQF524KFirFuhMK/xvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542159; c=relaxed/simple;
	bh=is9pRKH68sgWldBTQb5hY+k8EycmAvAXFj8N7PH80Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jl+lTSBhe6JqFe93Dgcf4Dc7Wo8nh+fbbwfVmuXRBd0iX6n8abjA2w+FSlSD67IqPSxXWIKkE4pZo+L+zz4TFGiPakXDPCJFnjdI7RZ9NYBmPAF7rVy+BhMp6lDEO24QPLL97g23lcBWnSmqnfw8IEaDiSzZ/lyHtv4sRLxV+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KT6N9D+E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KT6N9D+E"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954aff6088so17556905e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784542152; x=1785146952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=POoWktMdOXvQialSyT5Wj6jwaYCnpEUeXXbNynanq18=;
        b=KT6N9D+ET72HP7+TFwiUqxXJfu0+9IYVPxudUBWO7LaXKT4LvMQZ81T/ImrO1Ka7OO
         yeDY3/WhYDN4WsUC7WhrpVYzZiCA1S6Mr9VPO7oD9Sfvdg001CwfXNWSJxKVqp7UOLfE
         /f0KCmRmTTaQE7fublwrx420lP0RKludDmd/6zKAMs98GAJxoiSG64q8fbeHZHRPZhYH
         NsnKLMJEBy2weW2KuA33Uh2dWjx7ryVhteEkHE6WU7pssAoHBCQ7p7WxCwtcvEj7LyQT
         ZqwoTyJL1QNvPJQXvkFOOWBamK/tBkhTSbNsExzJG5sw/nCTtA/TRMk+bDCnjI1sdSkL
         c0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542152; x=1785146952;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=POoWktMdOXvQialSyT5Wj6jwaYCnpEUeXXbNynanq18=;
        b=K+ShwPhwQv+Irjks1NXT/YXqAgt13472lX4n3tcJLeiIG6pL4rM+oWXq0CKFuCBJvY
         dU6vIn1wNUIwmqdVoQiF9n1sXiuALLYekva/qHzK67uf5RFMmyGqhRRT9Aqe2upMcKg/
         Zv7K92LbJEBCoTKGOQ0pNyJ0TUBC2YhBeXbERFF5lZ/FnCLgjoQ6yhHnqEWTVCmR1G0N
         hsIxnjWd6A8fvbzjf/h0k7LToFvbDmvNnFF3jpHowWtKSd0a3AI+zlQ4tQwEL1b4RHh7
         D5NXKmKGTaRTyueI8oIghSYcBxkBTU0F2hXtbRQ0FdrJVfyqcyCDoT4FC0y9Ay5fKhdM
         eSOw==
X-Forwarded-Encrypted: i=1; AHgh+RpAhIzUPctFPOx24CFHgz1gGiz7QLi8BsRWiHADhQwQrpnPqp8wlWZSODbUjY+5BBciiW745WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPrAq/xL8yRPcnUfECpsEnGSw1+6+iodRoyeUkcnfyv67lzmtF
	wwaIqxHY+puj6DTi9m5s59yifuS73FfY7k06apOOZmVIgn5X9bWqZavmX7bhU+kt5Gz9MaSnkLp
	drocgzXw=
X-Gm-Gg: AfdE7cnpl9pPWMkK4ttWTqu1nfWI1+T+7sNXsnPHrcTZ9c7M8Bg8DoFQ6uG0zjih+52
	KzdxdvqDuSDYPh7gICGDYDsi5iCRjUMSdp47Mqw+wvj6f+MSCyiTZ4YjnH1Iaf+r9Om4hkLgBG0
	BPOJoV5LuGL9M4FyFfcZtJNVzqjkIIBctvc8nmjgccY6qiXm6vpDUYPLTSafwZA/sYeT2ehSjal
	46z103MLDuQCwOhrX4CnDIVFP7UBDVNO8Kg2KK+3jq47ZiHlgYABw1zQ0B8Uu94z5BofeGYpTj4
	AEX80pi5aG0XCN6bX1/0QzaFstojEOI7MhlFgnG/NnP/khvXgqLUrWXTD45hTODhzvQmlrzAHl1
	Kn8I30EHj4vKJX+9nQGAr7X8hh0++xqkcFd3isVfJo9W2NuSQKtqQHU1T3SCggqr9TG6/9qG8zY
	ZxwK07Sy+vC+6aMz2hl2VP8+rYzQ==
X-Received: by 2002:a05:600c:3143:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4954a3d0925mr148347665e9.4.1784542152138;
        Mon, 20 Jul 2026 03:09:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2504sm294792995e9.2.2026.07.20.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:09:11 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 net-next 1/6] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Mon, 20 Jul 2026 12:08:51 +0200
Message-ID: <20260720100902.155605-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720100902.155605-1-marco.crivellari@suse.com>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Haren Myneni <haren@linux.ibm.com>
Cc: Rick Lindsley <ricklind@linux.ibm.com>
Cc: Nick Child <nnac123@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..d4c284c8ef43 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3229,7 +3229,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	if (adapter->state == VNIC_PROBING &&
 	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
 		dev_err(dev, "Reset thread timed out on probe");
-		queue_delayed_work(system_long_wq,
+		queue_delayed_work(system_dfl_long_wq,
 				   &adapter->ibmvnic_delayed_reset,
 				   IBMVNIC_RESET_DELAY);
 		return;
@@ -3267,7 +3267,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	spin_lock(&adapter->rwi_lock);
 	if (!list_empty(&adapter->rwi_list)) {
 		if (test_and_set_bit_lock(0, &adapter->resetting)) {
-			queue_delayed_work(system_long_wq,
+			queue_delayed_work(system_dfl_long_wq,
 					   &adapter->ibmvnic_delayed_reset,
 					   IBMVNIC_RESET_DELAY);
 		} else {
@@ -3454,7 +3454,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 	list_add_tail(&rwi->list, &adapter->rwi_list);
 	netdev_dbg(adapter->netdev, "Scheduling reset (reason %s)\n",
 		   reset_reason_to_string(reason));
-	queue_work(system_long_wq, &adapter->ibmvnic_reset);
+	queue_work(system_dfl_long_wq, &adapter->ibmvnic_reset);
 
 	ret = 0;
 err:
-- 
2.54.0

