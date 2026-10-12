Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3F44C51C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798912; cv=none; b=lG9b9msElaaJJI9VXl3J7/Nh+/uUpLXCELXD2rmcGygTab6+NHj5o6vrpmv1lVTajl5ZBNMx4ZPEUZ6/KLvgWOzk02zmcWnFIJfchw/Bhg4MzyObHs01b5kbWTbl+JZG77pJt/hiD6k0TzvHnjp7u45LWqzGtgWdRMFJzYHkrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798912; c=relaxed/simple;
	bh=5o+gkaEDGsokOpCnIO/4/WtZKXU3lspYVk5COSvG6RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3pkFqF88B6+FsJScnWchD6zTAMg3g1UmQSKpacMl4PtW7wgHfZjki7R2FPQKoL7xIu7s0wES2Gx75pqqcdMDEE0x03Kut2xlTuj6fr/FBju9bYzH8ELRkPiuCOAlWC54DZc21p7y9FsIP6YbZzn9GCswWl/H+h8oHfmOW9CeMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=anWbNV36; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="anWbNV36"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso2378617f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791798906; x=1792403706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0DTUEu+tQMr+K01BzO77MDPNxFso/NrhJ3ycIpr+NMA=;
        b=anWbNV36XsmfOr160Q6aS9nvZRrJBM66f34jGksax9E6zj4v2/+gQZrbMzFKVAv2RJ
         7RgCX1KguTYYzR1O+6rCk0Z/vdcxMXchhW8yo1vAfzXQsecEtNLB/+VgM02JUkgpouG1
         zNKYnFlabj6XxM391ct3WdviA6X7VYIYe4f4RQbG05vMd9azb/io8kN50KtC87+x4W1M
         IexluvgUvCBYYoi2W4kQaFSx7PLP9VVL0zI6a3ErDlhcGikVTUCmO+gP5elGfea0abbu
         tkprkpxKBmBPCEjJimK2ZFgygGQOIwQumYo2NHfkpQ3HUnzHlkmppJ8QfoDOYe5b+9ck
         U+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798906; x=1792403706;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DTUEu+tQMr+K01BzO77MDPNxFso/NrhJ3ycIpr+NMA=;
        b=BXWW7N9hVB1bG/9oWRgfzSozyE0LJCTV9MtsptsfqosPy8aBUW/d53qOb7LkGBpBxU
         N85vuD0CkVSrqSGklVol54CVNpnt+UtFZigBXbMG4OvtvvqCB6yFqptChF0tIEaSVdVu
         oj6ex/BZrkJVzJTAuHcYnJwpozXj1rpHatHN641zcD4qVKXyW5dy4MS3KHcI75DzUrYa
         OGXl2o0HKFW2a0Md1GedAh2f1VXqgBhmmRWUoUnn6nYeLP2qNY4DktrIuZNRhEq1CUkz
         +CLgt70Qc6Ui8dMs2R4asejFYCvQB8bTUzvNyr2JhC6a6seffZDXBf01GooS6nzJG1Lr
         xjGg==
X-Forwarded-Encrypted: i=1; AKwUvBx2gOetZrNx5VCw6gqIvB1mo5PV8D0+qpVxWjPL1HFeP9txFlTTftjsaaTRmEPs3/gFNkWhZqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwOstDKMfLCKFBYPQ3upqputw9LUaNz6egttj+8UCxCSBI4hkU
	py25xYOL8etxNdZp5/q4J51qSw/Uhi0uFxYAsagVKDpB7/A3Lnl+NqytN6DQILDcX58=
X-Gm-Gg: AYBFou2SYbIYo8cDII3cV03+eXLqqdA8sQGRtff+GVVt/gn13R+hTl6SNT3oRczK0YK
	u6zB/D+kKRxKFwRLU8ekcvq8uqWw2TrpFJMGTRalbA1S/ZR0uVF6TkQe7NviM+yX8qhPASBDo6n
	Vcc5oy4mWQQAAXecH8FhcSe0AjI2Js5B9eOSNhtSNxEvfftLSpjh6s7XsSyk0G9J/rmQNIVVmQP
	oGufyvo1ia7Fxrr2hI4XytIIwXztu9uXyp/WSRnSP2BWIbyYx/rAO0DwnsXiqxPELGMVuKF8fgg
	6BuIJl9XqDN6CRCugo0ccQyqZZNDASsV968EpQA794H/CegNMlSGj3nM5rl9HEtoLp8xRgM6X/d
	BYIqc6IQRQG5noJLSEVBkzu7bV8MWyiNeQBAU8PNVSFGEq71pGi+V/vCBUdCigyVn56czrl3Ow+
	E9brclEXb0LpEnEU31pke+dNFQf+dMME/nUkJ59cVHHzz3NvYklMI4u7SWgMMNDA9CQoZK3BAW1
	xjzuyUcVpN/B6BYN80KSw==
X-Received: by 2002:a05:6000:298d:20b0:48b:469:b562 with SMTP id ffacd0b85a97d-48dba7b3284mr12398568f8f.2.1791798906038;
        Mon, 12 Oct 2026 02:55:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c2800sm18539103f8f.26.2026.10.12.02.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:55:05 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/6] ibmvnic: Move long delayed work on system_dfl_long_wq
Date: Mon, 12 Oct 2026 11:54:40 +0200
Message-ID: <20261012095452.135828-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012095452.135828-1-marco.crivellari@suse.com>
References: <20261012095452.135828-1-marco.crivellari@suse.com>
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
2.55.0

