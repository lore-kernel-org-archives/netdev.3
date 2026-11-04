Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815155;
	b=3fBltvSsLNh3EYwtRDH9OggOowUln9HlPqitN/X0NMLN15g2jYYlPVf1v8Ug23qaKtHz
	 lTmlpHORMDq/ehvURINpR5Rsb3E1P5y81gBzgxhm1Aeyv4rlEu4Avkn2QQtTUwONacrRO
	 TpCG/yuHF8dBcgWRJRG86kowxcG3q9evbNto3yZ32huPiqrpEXpaPPFxgFHxFBo9dCI2A
	 r/wy/mxC5G3uR2jSjWJmaJDvoAn/Qt/vNcLNSCbqYK1yosnwSmwwW7QbK/1Il/6Ou5UCN
	 MDnO87qNzhEo2sSpXz0fY84kSPhx4tjK8LFYD/7SYITNZ8l4e7eRB5mq5OHnu5zEmKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dcwYLMgDesTL76X07FrNzXaEgb97ytOIfnSbG8dZCPU=;
	b=kxIWaSh0yznrcWLM30e4HJWy8d+FQhk7FPDPSRjFV4N/uqV5Un7FAZrr1Sf+fC3E1crU
	 ujaXkYrRjVntaNAwLjvgCjePipqrGC28RLYsUrdDe/08m2j4MDjx8t5xPJQHxPRhYbuFK
	 rv1GowLFemplMqlcwlEkZaooBN+wTFoUZek+2d31ObmbDnwNtkUK1zFy45nkzbdfyzPN3
	 sPzE0EB/cUj9LlHHw1ufdQExKBEwBChrWsfbACLTR4rQ0FzH8mbRF/4Qe7IwGxwSWt0Fp
	 JGnFQejGqhQd4pOtDj1h8ZNzak+X9ffqc+bIQW70LGz4SL6yNX+XLWdR9v1rDYeO5rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVblJ6TE;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0C606A339
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA0C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVblJ6TE
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e977109392so6448475ad.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815154; x=1794419954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dcwYLMgDesTL76X07FrNzXaEgb97ytOIfnSbG8dZCPU=;
        b=HVblJ6TEdvsqTJCcwSZ3h829lWn40gziQcLwRsAt0w2GDf4oZg4RG5Al48/vfUNqHL
         JwdcU/VeDNxHND442S7KXzbNsvhVEnjg4ZATTfo68Z89+7sQLwqQuN3S44ScFW6RNL6c
         8zkphR37JhxHBF4aWX43k9Q91nYhPM5GHSPhyP2Aq/83GrcJmiaG+Wjxs8ijHd2GHdxF
         VTA/zYzH5nVWFTr+n1S+wrwuyZo38uep/gcHFl2AheJC+5S1v7xnKQSIXbjRGueRLRjU
         y1I6e9EnD0JKCwqnriZL9nFDGjy0Z+oa/lQQm1dADF0KphqBq4BRqVNvNM6sCULcrAaj
         xuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815154; x=1794419954;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcwYLMgDesTL76X07FrNzXaEgb97ytOIfnSbG8dZCPU=;
        b=YqN2x3C6Mqo+MMVAAF1yVxeupf+cWjVdDJOLg1bmfMNJewNVjooJE+n3e8imm14M6f
         fPkNLTIcIew7Zrv8RqfKNpS61XepSpetnrIU/x7mw4Rfe9d60cgoxsXnX7qoYfZg1A9K
         jb8AkMYz57qbExNn0jLwYYI9i3ZgUkt7ZNdAGZ+BrXlNjfgrtHS7/9YK+nWE+Hq0VH9H
         xt2YRHdySUpVXDAwNWVlPcERU0RVrmQv6aA7UbOBmn/NHct0F3t50BztDIAgOUr2ZAcW
         bPIK9TUMvL8FsjkpDAZY4kihy34qOEV/OuGBK609hkL623fp8T/82fvSx7TQFnOlxBXP
         mx8w==
X-Gm-Message-State: APuU4Z++gX0rM5mVQIzkIjbeNfj3dnNCCCK+rKoSo48d49yECfhtBFZT
	33DOjToF1Td4JZcAKknzXMqIadUz96ZS5QuzyGXt5Qx2qAJNnBS2RPbFj0PUNw==
X-Gm-Gg: AYBFou1+shjkc8AEEe58KVUnu9fPNNweBre1ISUEKKhTCSTWnjT+H/EjJ8mIy9bTLzH
	54bySYmcgkOV2Tcj0YM4aCEagQOiwGPEqYJ4cdbHd9WfAxAMDx3txRDDFMXieGFBHDmZgiq6tcg
	LWyiyhs4+FlQyXmXnI2ndeVCBzcDqx9hWOHbQ754QoVGiiE3mU2AN9KrzA/dofhJueDdIenOfLo
	er2oyLU1Z/IbWiWXsFOuWbhd3ibZEHTSiuqSB4/fLfiwidMuKGBnXCLfoQynbVCr899XS2lT/6v
	4Z80TFK2TlHJ94hD7JeMJYnQErkawQROBqiJB9gFiBc/jnOOUMkWZczv+Ta5P9Fr/tqi7wH0MSS
	OmPgEB8Zbzgp10n9Y+nhfs+2PIbdoknCayBmgo2+RYjI6ZWNV9CCOmX76J71djGm3o689nXDyFm
	yqaElgI/NQf5pnm/FHE2rN593Qm9JQIsxGBbYu6JXnfr5Y6+vaVaYEnMCzeBoSMi8Diu+AOg0lW
	n3ceXCT+267t98l7nxpC3Kb4L1xV6eoR8U4r2HLym84+gkT2PyTff1l29L3TyYxtfAMW6XACWTb
	OPaANZ9ybqEq/eHkshzuAs0VwhjydOuRJCBv/U7Bpm+lvZcX1veSqpXgCJoa2GfLN66BnjhKnh4
	6i0d2tQrEvzNx7uFpniJwAeOWw+VNyFcr5dxXr6dMnOMOvg==
X-Received: by 2002:a17:902:dacf:b0:2e2:dfe4:adab with SMTP id d9443c01a7336-2eb36426d08mr161005035ad.10.1793815154375;
        Wed, 04 Nov 2026 09:59:14 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed09127d9fsm10604555ad.51.2026.11.04.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:59:13 -0800 (PST)
Subject: [net PATCH 2/5] fbnic: Fix service task races with ndo_stop and PM
 suspend
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 04 Nov 2026 09:59:12 -0800
Message-ID: 
 <179381515284.9644.1846335740085170889.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The service task can run after the datapath has been torn down
underneath it. ndo_stop stops the task with the cancel_delayed_work
function, which does not wait for a pass already executing. It cannot
use the cancel_delayed_work_sync function, as ndo_stop holds RTNL and
the task takes RTNL itself, so a pass blocked on RTNL while ndo_stop
runs carries on once ndo_stop returns.

By then the fbnic_down function has demoted the host MACDA and action
entries to UPDATE and disabled the host queues, and ndo_stop has handed
ownership back to firmware, which clears fw_heartbeat_enabled. The late
pass's health check reports a firmware crash that did not happen, and
the fbnic_fw_config_after_crash function reclaims ownership and writes
the host rules back to hardware. If the BMC raised
FBNIC_FW_CAP_F_BMC_TCAM_REINIT in that window, the fbnic_bmc_rpc_check
function does the same through the __fbnic_set_rx_mode function. Either
way host traffic is steered at queues that are no longer running until
the next open and close.

The fbnic_pm_suspend function, which also serves shutdown and PCIe
error recovery, has the same problem and a worse one. It calls ndo_stop
directly with the device detached but __LINK_STATE_START still set, so
a late pass there sees the interface running, restores the host state,
and keeps re-arming itself every second after the mailbox, IRQs and
MMIO are gone.

Only run the health and BMC checks, and only re-arm, while the
interface is running and the device is present. The __dev_close_many
function clears __LINK_STATE_START under RTNL before it calls ndo_stop,
and the suspend path detaches the device under RTNL, so a late pass now
leaves the host state alone and stops. The BMC flags stay raised, and
the __fbnic_open function reclaims ownership, restarts the heartbeat
and rebuilds the BMC rules on the next open. The fbnic_pm_suspend
function also cancels the task synchronously once it has dropped RTNL,
so a pass already running cannot overlap the mailbox and IRQ teardown.

On resume the __fbnic_pm_attach function called the fbnic_up function,
which schedules the next pass, before attaching the device, all without
RTNL. A pass that ran in between would now see the device detached and
stop for good. Check for an init failure first, then hold RTNL and the
instance lock across the stats reset, the fbnic_up call and the attach,
as the suspend path does, so the pass blocks until the device is
present. This also gives the fbnic_up function the instance lock it
expects for the napi_enable_locked calls and the rx mode rewrite.

A device that detaches itself on a failed register read likewise stops
re-arming the task until recovery attaches it.

The issue was found by code review. The change was tested on fbnic
hardware with firmware 26.09.14-017_h7ab84d2ef68f by cycling the
interface through DPC/AER recoveries for a day.

Fixes: 04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC enables channel")
Fixes: 6ae7da8e9e06 ("eth: fbnic: reprogram TCAMs after FW crash")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |   38 +++++++++++++++++++++------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 09eeb4b4ded8..09ae797b1f0d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -234,18 +234,25 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_fw_check_heartbeat(fbd);
 
-	fbnic_health_check(fbd);
-
-	fbnic_bmc_rpc_check(fbd);
-
 	if (netif_carrier_ok(fbd->netdev)) {
 		netdev_lock(fbd->netdev);
 		fbnic_napi_depletion_check(fbd->netdev);
 		netdev_unlock(fbd->netdev);
 	}
 
-	if (netif_running(netdev))
+	/* fbnic_service_task_stop() does not wait for a pass that is already
+	 * blocked on RTNL, so one can run after ndo_stop. Leave host state
+	 * alone in that case, and do not re-arm; __fbnic_open() reclaims and
+	 * rebuilds it. The PM path calls ndo_stop with the device detached but
+	 * still running; fbnic_up() starts the task again on resume.
+	 */
+	if (netif_running(netdev) && netif_device_present(netdev)) {
+		fbnic_health_check(fbd);
+
+		fbnic_bmc_rpc_check(fbd);
+
 		schedule_delayed_work(&fbd->service_task, HZ);
+	}
 
 	rtnl_unlock();
 }
@@ -458,6 +465,12 @@ static int fbnic_pm_suspend(struct device *dev)
 	netdev_unlock(netdev);
 	rtnl_unlock();
 
+	/* ndo_stop could not wait for a pass already blocked on RTNL. That
+	 * pass no longer re-arms, but wait for it to finish before the
+	 * mailbox, IRQs and MMIO go away.
+	 */
+	cancel_delayed_work_sync(&fbd->service_task);
+
 null_uc_addr:
 	fbnic_fw_log_disable(fbd);
 
@@ -558,19 +571,26 @@ static void __fbnic_pm_attach(struct device *dev)
 	struct net_device *netdev = fbd->netdev;
 	struct fbnic_net *fbn;
 
-	rtnl_lock();
-	fbnic_reset_hw_stats(fbd);
-	rtnl_unlock();
-
 	if (fbnic_init_failure(fbd))
 		return;
 
 	fbn = netdev_priv(netdev);
 
+	/* Hold RTNL until the device is attached, so the service task pass
+	 * fbnic_up() schedules cannot run until it will see it present.
+	 */
+	rtnl_lock();
+	netdev_lock(netdev);
+
+	fbnic_reset_hw_stats(fbd);
+
 	if (netif_running(netdev))
 		fbnic_up(fbn);
 
 	netif_device_attach(netdev);
+
+	netdev_unlock(netdev);
+	rtnl_unlock();
 }
 
 static int __maybe_unused fbnic_pm_resume(struct device *dev)


