Received: from mail-pj2-f26.google.com (mail-pj2-f26.google.com [74.125.227.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841FD4B826E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642349; cv=none; b=o4+ixO1Fd/DXph4eU6JWhMovs6FFD7PZTGO5DiFaHJNPYiLzHSox6UWOK3pOITLZvork64d0PlAGImYKrm/9i2lijH7lOmoemQKlFJ+sH/LrQq3EUN+yc+1Z4/Jj+BP8JGiLUxmyYS/qTz6fSFqSM0DAV8VsikEEM+RX+G+oF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642349; c=relaxed/simple;
	bh=jnlMS060wqhxZJ7cpUrVQDrI82clt1wMbT+Jiwai1E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4cTxXkvqDR6hYEo9HW/yMz105tFvmdVyUCPvqWRB0Wkm0TNg23Lunlfo3oKTVERXQOREOpzPGC90NgJHcQKyxqE+J/xG3D2CtEzpG5JSM1vXSx3C+TOcw3+xARPAxlIcUNHHXGkqaMGUSGjP0JsbP/UMcCT6PquD4hZ9sD1hVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARZ4ELn8; arc=none smtp.client-ip=74.125.227.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARZ4ELn8"
Received: by mail-pj2-f26.google.com with SMTP id d9443c01a7336-2d8fb334e72so6579905ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789642337; x=1790247137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JeUTZ5Xfmu3CX5ZC/fWVdot1MmSWPUPNS4TQoJ0nO2A=;
        b=ARZ4ELn8esES6m+jJWJpRfUeTM+9adKFQV0cdEUaSYsBYS9fuToLXZtO+IK3AIH3la
         Vy+h24WrzRKy3L2adTljpDUCPB/ZXaDyaT36f2F/cFlxmR1D1MXmNlb95SIoLfi/6w5t
         9703O6l43RET/RJcR/8+i5bvYlfXGU4RcGHpsbhxWG60pR52uZvPjA5Tp2a1y5meOMfX
         Go8EHWWPMjVt9FQ8jkMP9dqiZTJZez3VuGTvhxi/eiOsJNk+WPUyB2yJr23WaNTv5/jS
         fLcd8XKGHYlwBEmsLeg7Xe2Z8+9vHjkzRa5aKocls9/3FKrryO1YY7V4nP07j9eqlOoH
         yrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642337; x=1790247137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JeUTZ5Xfmu3CX5ZC/fWVdot1MmSWPUPNS4TQoJ0nO2A=;
        b=0XNI3AGem8n76sfzc6gZlYC3ERgLq+IHma3doS+IRdHoQynO5AmNVWWv1twxWyNbVm
         NlDUmr8jvDL9gYaVbmZhySUIurRjmVGRnyaSRpWlut/jnBGyLzoY05WI4oQe4cD9CP5U
         7NnxGT+OTro8DobKqK01LPZlAosnYTw/13q0kFvV8jLdpDJ53HOBnkt9jwizakbkR4Cn
         tcI5USgHtvi1lDb+HM/qzOn+AlJA6F/jhtIEGMi8X5SUn0WrFviI1RwTGElXVaDxm7fC
         o4YzVyqbtKuCLB+ahnmkPLXz8ZvO7/9D4w+ml4cBxdpxPuL2ATnBPABz3CrTkJILw2dA
         5fXA==
X-Gm-Message-State: AFuF++nJ+aSLAsxVkB/H/BjQz7XYsj6LA/+hE+kwqDD/PCZXYH9/Pu4g
	6+Rt2UxIXJk06Kw5E8s6KNYCk3Oma5IG0486dovq5cxEpk2Aq5/TuROa
X-Gm-Gg: AYBFou0PZAB6vvRDmkU/+8U8X1Cgrs9YaGaJSi7jM5vU2axkMpR1Ii2pXy6btcRDq1k
	YY2FDjOokMaD5yAxEQloYFF9Yl4A7XprliPvEbA7aTRao2sGKkeEt9jW4NdFRkd/8HKWF+Bvheo
	yUvvePfb/N9GnLuwD9BNr1G0d1XhVOEtpzcRchgdDjoT2gn8UleinnLPxY8vmLtZ/FzQQ5FuM4F
	dvTzJlNq7/syoVdrvoH8shC40KFYtZjVK0PYpuCH3aRZ+c4jYzS4miFEyzkDDi2W5j9IsFRjDH9
	00sakZoysWl+tqB/SR7Y6QNlkh0eI9j3XanyPGYBQ8u1D32EplrHbJXQ/QJERSmoz/+U/cXUmNT
	IQI0+8YubPNsdoQWsSAWCcfg4mGcumyGRDeMP1r75CxCGkE7YgJ6KxT1RBmQ6KmjWi9IdSqpgGV
	bEr3KUGXw6IIU4mH9PI5f7LnEkcK8xWHWt7EtqeAMMWhADh2u7U8Ei4QVDRKzaKG/n5mkrnJMIk
	pXnTgpmZKI2MEZjsEiFthGMz29uTTODWHUH2AmNCHi5s57wMPmnphRPzX8EdZdlNKzzsE0clKGs
	NPI=
X-Received: by 2002:a17:90b:3c41:b0:39d:fe64:5733 with SMTP id 98e67ed59e1d1-39e1e5612demr22035813a91.24.1789642337227;
        Thu, 17 Sep 2026 03:52:17 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b8e1asm4486019a91.12.2026.09.17.03.52.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 03:52:15 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	emil.s.tantilov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Thu, 17 Sep 2026 18:52:04 +0800
Message-ID: <20260917105205.37561-2-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917105205.37561-1-luckilystar08@gmail.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tian Xun Ng <tianxun.ng@bytedance.com>

Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
before idpf_deinit_task() tears the vports down, so every message sent
during that teardown (disable vport, disable queues, destroy vport)
fails at once. The device is never told to stop its queues and keeps
them enabled, with the ring addresses of the kernel that is going away.

After a warm reboot, the first queue reconfiguration of a port that has
not been opened yet (udev setting the MTU) sends VIRTCHNL2_OP_DEL_QUEUES.
The device then drains the queues it still considers live and writes
SW_MARKER TX completions (qid_comptype_gen 0x2800 / 0xa800) to the
previous kernel's completion rings. With the IOMMU translating, those
writes fault on every such boot:

  arm-smmu-v3 arm-smmu-v3.17.auto: event: F_TRANSLATION client: 0016:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0xffb70000 ipa: 0x0
  arm-smmu-v3 arm-smmu-v3.17.auto: unpriv data write s1 "Input address caused fault" stag: 0x0

In IOMMU pass-through mode they land on pages the new kernel has already
reused. With page_poison=1 that shows as "pagealloc: memory corruption"
on most boots. Without it, nodes crash in unrelated code, e.g.:

  Unable to handle kernel NULL pointer dereference at virtual address 000000000000a830
  pc : __tlb_remove_table_free+0x48/0x118
  Call trace:
   __tlb_remove_table_free
   tlb_remove_table_rcu
   rcu_do_batch

or with a slab free pointer that decodes from a slot holding 0x2800:

  Unable to handle kernel paging request at virtual address 002613b73e862c6e
  pc : kmem_cache_alloc_noprof+0xc0/0x3d0

The early shutdown exists to avoid waiting for transaction timeouts when
the mailbox is already gone. That is the hard reset case, where
idpf_vc_event_task() shuts the transaction manager down and sets
IDPF_HR_RESET_IN_PROG before idpf_init_hard_reset() calls
idpf_vc_core_deinit(). Key the early shutdown on a hard reset being in
progress or detected instead of on remove, so that both remove and
shutdown keep the mailbox up until the vports are gone.

Hard reset behaviour is unchanged. Remove is unchanged unless a hardware
reset has been detected, in which case it no longer waits for message
timeouts. Shutdown now delivers the teardown messages; if the device
stops responding without a detectable reset, shutdown can wait for the
transaction timeouts, as remove already does.

Tested on arm64 (64K pages) servers with two idpf functions, with this
change and the next patch backported to a 6.17 kernel: no stray device
writes in 151 warm reboots across IOMMU translated and pass-through
modes, against stray writes after 20 of 20 warm reboots without them.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c    | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..646b6e074 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3197,14 +3197,22 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
-	bool remove_in_prog;
+	bool reset_in_prog;
 
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
-	/* Avoid transaction timeouts when called during reset */
-	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
+	/* Shut the transaction manager down early only when the mailbox is
+	 * already gone, i.e. a hard reset is in progress or has been detected,
+	 * to avoid waiting for transaction timeouts. On remove and on shutdown
+	 * the mailbox still works and must stay up until the vports are torn
+	 * down. Otherwise the disable and destroy messages never reach the
+	 * device, which keeps its queues enabled with ring addresses from this
+	 * kernel after a warm reboot.
+	 */
+	reset_in_prog = test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags) ||
+			idpf_is_reset_detected(adapter);
+	if (reset_in_prog)
 		libie_ctlq_xn_shutdown(adapter->xnm);
 
 	idpf_ptp_release(adapter);
@@ -3213,7 +3221,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
 
-	if (remove_in_prog)
+	if (!reset_in_prog)
 		libie_ctlq_xn_shutdown(adapter->xnm);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
-- 
2.50.1 (Apple Git-155)

