Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33CA4CF468;
	Mon, 19 Oct 2026 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372729; cv=none; b=aCcQr0EwrTZkZvaYFTfHRbjNYNdD1XLr6t8/ibDlfHpZQdO2eV4C49lpeWd3FYxwZHqMuJ0P/Yl4IDZx1jEGf9BtbFX36Er09V3kFt6lzEqAa69leELZCM97GbxSgGhkHOyEoyZl8ixq9vtJQDhLGz+vCd4nieqxuEmj3cR4pSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372729; c=relaxed/simple;
	bh=JRVLMfAEDKuYjgqa28pXUMOlpuly+na2sdKmy4FUPRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/BR9OEEgSyAUBYksGwhzkHK3kDxVvSvuo1wKpAS92+jTXjwHCKUKHjcniQ8XAd1BcxCVMrOj1J9J7DiU0sjs8G689w1SWY45SqKmrJPWrPrbqtDJOg1r0N7T5g6oCRax7rcFZJTI1tGi7bfYCBm+mb/rXLNNMgrVuK3TlQHPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KX+F8Gl7; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KX+F8Gl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IX
	tiTclCiw4vcSUxWgahWVmxPjU90rZOsolN+JRIrC0=; b=KX+F8Gl7gzRtLusSqC
	2JYY3fcEekKirPEeLWJIQ6EXK4EofZFjN0JTFmvzONVLy57FIslJRGwY+5hbq4zh
	4MD+NXziTd78LEYWpw2fY36Al2vsVYcAl8K2tTk1/MiJRCy17ge2y/ZQ14mjxwSZ
	LEYcdWUg1bxJpTx/jcQLK9ja4=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD33z3Eb9VqCWdBAw--.40166S2;
	Mon, 19 Oct 2026 09:17:57 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: netdev@vger.kernel.org
Cc: sam@mendozajonas.com,
	fercerpav@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gwshan@linux.vnet.ibm.com,
	joel@jms.id.au,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/ncsi: fix use-after-free of ncsi_channel in ncsi_remove_channel()
Date: Mon, 19 Oct 2026 09:17:56 +0800
Message-ID: <20261019011756.432710-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017024947.420683-1-18983559317@163.com>
References: <20261017024947.420683-1-18983559317@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33z3Eb9VqCWdBAw--.40166S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWDXr47tF1rXF1rCry5CFg_yoWrXF4xpF
	Z3tr45C3ykGrWF9F95Za1UXry3GwsaqrWUC342gw13Aw45Gry8Xryaga1j9F45Cr92ga1Y
	vrs0g39avas5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j15lbUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+wYdAWrVb8ZFOAAA3K

Thank you for the review. The High is conceded with a companion-series
answer, the two Mediums on code scope are conceded for v3, and on the
get_net() question: yes, plain sock_net() is enough. Details:

1. [High] the comment claims teardown "only unlinks these objects and frees
   them after a grace period", but np and ndp are still freed right after
   their list_del_rcu()

   Conceded, the comment overclaims. Only the channel and its filter
   arrays get a grace period from this series; np and ndp are deferred by
   the two companion series:

     - "net/ncsi: fix use-after-free of ncsi_package in
        ncsi_remove_package()" (msgid
        20261017012431.413648-1-18983559317@163.com)
     - "net/ncsi: fix use-after-free of ncsi_dev_priv in
        ncsi_unregister_dev()" (msgid
        20261017015315.415794-1-18983559317@163.com)

   v3 rewords the comment to the channel scope and names the companions,
   so the reader-side statement stays true independent of their
   application state.

2. [Medium] the RCU reader protocol is only added to the PKG_INFO handlers

   Conceded, v3 wraps all seven handlers (ncsi_set_interface_nl(),
   ncsi_clear_interface_nl(), ncsi_send_cmd_nl(),
   ncsi_set_package_mask_nl(), ncsi_set_channel_mask_nl(), and the two
   PKG_INFO ones) around the ndp_from_ifindex() resolution and the walks.
   Two sleeping constraints are handled:

     - The PKG_INFO doit reply skb keeps its genlmsg_new(GFP_KERNEL)
       outside the critical section: allocated before the lock, unicast
       after the unlock, so the walk itself never sleeps.
     - NCSI_CMD_SEND_CMD's error path (ncsi_send_netlink_err() ->
       nlmsg_unicast(), which may sleep) is deferred to after the unlock,
       using the net_device captured inside the critical section.
       ncsi_xmit_cmd() itself is atomic -- GFP_ATOMIC command skbs,
       spinlocks and dev_queue_xmit() -- and runs under the lock.

   You are right that the SET_*/SEND_CMD handlers can turn the race into
   use-after-free writes; they are GENL_ADMIN_PERM, but that only limits
   who can trigger it, not whether it exists. The CONFIG_PROVE_RCU_LIST
   angle is another reason the lock belongs around every walk, not just
   the info ones.

3. [Medium] the ncsi_remove_channel() comment says the grace period covers
   the "channel configuration worker"

   Conceded as written; v3 drops the worker from the comment. The worker
   is safe, but not because of call_rcu() -- it is quiesced by v2 of the
   ndp companion series, which runs disable_work_sync(&ndp->work) before
   any package or channel is released and stops every channel monitor
   before the removal loop, so nothing can re-arm nc->monitor.timer
   through ncsi_start_channel_monitor() afterwards. Given that, the stale
   pointers you list are not walked after the quiesce point:

     - nc->link sits on ndp->channel_queue, which only the worker walks
       (ncsi_process_next_channel()); no netlink handler traverses it.
     - ndp->active_channel and ndp->hot_channel are worker-only state.
     - The info walkers' only use of np->preferred_channel is a pointer
       comparison,

           net/ncsi/ncsi-netlink.c:71:
               if (nc == nc->package->preferred_channel)

       which loads through np (kept alive by the package companion
       series) and never dereferences the stale channel pointer.

   The pre-teardown worker race itself (concurrent with the old immediate
   kfree) predates this patch, as you note; the disable_work_sync()
   ordering in the ndp companion is what closes it.

4. [Medium] pre-existing: get_net(sock_net(skb->sk)) leaks a netns
   reference in six handlers

   Yes. Nothing in net/ncsi/ stores the struct net beyond the handler,
   and the netlink socket pins the netns for the duration of the call, so
   plain sock_net() is enough. v3 switches all six occurrences
   (ncsi_pkg_info_all_nl(), ncsi_set_interface_nl(),
   ncsi_clear_interface_nl(), ncsi_send_cmd_nl(),
   ncsi_set_package_mask_nl(), ncsi_set_channel_mask_nl()).

pw-bot: cr

