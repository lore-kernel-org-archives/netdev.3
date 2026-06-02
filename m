Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E543EA96F;
	Tue,  2 Jun 2026 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414424; cv=none; b=klBNuJrrgy6ulUS0uGMvJnHMpiGshTdAL9hRMamHCA7qPOHZdXL7mVi6BShq6yGeVAAiwuL1ZqT5fQdNlj0x9PPKjXxlnaBUYFXR7YdZkjhrAnEF8N6fli1YKfnzsqxn+ZOTNoikhCTpFoDl9mj4vdEi9mwQGnXgDFapZbJNTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414424; c=relaxed/simple;
	bh=HZYMSfAKaGnJgZlL2RwqCiyvsRIxSRMN5ed083IYi04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tgNFbUcEDCDSQSa8P3EWTiT7oUfnaHzWcJcvG3Nn3IcCYwWEgek0d/p6woK5a/zRmcd6+DrbyfTQfl4RY0pAWBPvIumMTneNYpcenA3vv67Ezfu6sYUIXhHMvBX24VALJFikn7SYvIam2U0zKQU1U4GxMtwEextGFyrwXc0lgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wcPg8T2g; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wcPg8T2g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MR+GPAcdhJpOydy12OaY1N657SWSWN5NcmJoQs4iTmk=; b=wcPg8T2gx9NXmxn9SDVRdC2T5Q
	kRiVtgug881TufGx3HqIYzomT9RTwNzhOKDayUXqpJ/JjMQKtYPg0ds++FvJwP/ehRRRH+k8+p9/D
	Mnl0DDmsAZDahZaHJyzCfpuRGlwomLE5FBIY3mJRKeFLX4F1w9/C0M07iA3z+dA+Olj0gHR6tSSAY
	t21PA2AsmndQlJMibljDTItyiQjHUqr0+xSCTvZSXcXL72yZBl+4ERg0slOLsnokAx9jisUcLl7yW
	GtwqitCtfBy7Ne9y952qiClUYb/NeUIG477PEJvI62zBJaASBzQdG7Zk7XvwOtNTSU8FDLdspVh36
	Q5kSPb6g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUR7Y-0033P5-2i;
	Tue, 02 Jun 2026 15:33:37 +0000
Date: Tue, 2 Jun 2026 08:33:31 -0700
From: Breno Leitao <leitao@debian.org>
To: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	stfomichev@gmail.com, kuba@kernel.org
Cc: kernel-team@meta.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: bnxt_en: suspicious RCU usage in bnxt_fw_reset_task() qdisc path in
 7.1-rc6
Message-ID: <ah726OtFX-Qw3U-R@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: leitao

I am hitting a "suspicious RCU usage" lockdep splat from bnxt_en
during a firmware reset on v7.1-rc6 (e43ffb69e043) with PROVE_RCU
and PROVE_LOCKING enabled.

The firmware reset path re-opens the device from bnxt_fw_reset_task()
holding only the netdev instance lock (&dev->lock).  bnxt_open() ->
__bnxt_open_nic() -> bnxt_set_real_num_queues() ->
netif_set_real_num_tx_queues() then walks the qdisc tree in
dev_qdisc_change_real_num_tx(), which still dereferences dev->qdisc
with rtnl_dereference() and therefore expects rtnl_lock to be held:

  void dev_qdisc_change_real_num_tx(struct net_device *dev,
                                    unsigned int new_real_tx)
  {
        struct Qdisc *qdisc = rtnl_dereference(dev->qdisc);
        ...
  }

Since only the instance lock is held in this path, lockdep complains.

Splat
-----

  =============================
  WARNING: suspicious RCU usage
  7.1.0 #1 Tainted: G            E
  -----------------------------
  net/sched/sch_generic.c:1416 suspicious rcu_dereference_protected() usage!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  3 locks held by kworker/u208:1/13:
   #0: ((wq_completion)bnxt_pf_wq){+.+.}-{0:0}, at: process_scheduled_works+0x8f7/0x13b0
   #1: ((work_completion)(&(&bp->fw_reset_task)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x917/0x13b0
   #2: (&dev->lock){+.+.}-{4:4}, at: bnxt_fw_reset_task+0x7ed/0x1e80
  stack backtrace:
  CPU: 38 UID: 0 PID: 13 Comm: kworker/u208:1 Tainted: G            E
  Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1, BIOS Y3DL405 11/21/2025
  Workqueue: bnxt_pf_wq bnxt_fw_reset_task
   <TASK>
   dump_stack_lvl+0x69/0xa0
   lockdep_rcu_suspicious+0x13f/0x1d0
   dev_qdisc_change_real_num_tx+0x54/0xe0
   netif_set_real_num_tx_queues+0x4ed/0xa80
   __bnxt_open_nic+0x9cb/0x3490
   ? bnxt_hwrm_if_change+0x4fd/0x620
   bnxt_open+0x1cb/0x370
   bnxt_fw_reset_task+0x80d/0x1e80
   process_scheduled_works+0x9c1/0x13b0
   worker_thread+0x90d/0xd20
   kthread+0x320/0x3f0
   ret_from_fork+0x2b6/0xb00
   ret_from_fork_asm+0x11/0x20
   </TASK>

Bisect / analysis
-----------------

This looks like a regression from:

  850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the
                  bnxt_open() path"")

That revert dropped rtnl_lock() from the bnxt_open() paths and left
bnxt_fw_reset_task() holding only the instance lock around bnxt_open().

I can send a patch restoring rtnl_lock() around the bnxt_open() call in
bnxt_fw_reset_task() (re-taking rtnl before the instance lock, matching the
pre-revert code), but I wanted to report it first to make sure I am in the
right direction.

Please let me know how you would like to proceed.

Thanks,
Breno

