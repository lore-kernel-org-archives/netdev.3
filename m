Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904D2701B8;
	Mon, 19 Oct 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372711; cv=none; b=Pq8N9Dq7P4i4RDq3Kq6I3xjMGchFNlu1SvPMoPcJdx+fsmBf+I9HCw6xpF5JwFfosGeHE+kHYRGPjFxBuC+UZ6xjEtvSswFRunY7v0y06xbI24+LiDKpdrOjk/iFGkfnmZWKzMf6HxKnYSt4k2lsafAlR1tztdkZGr55fpx5HV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372711; c=relaxed/simple;
	bh=QOLXutMGhg/dsjCWuURQEaaUGGiFKTyeKyDmSz97Gw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLFmmfQA34LVu/Gth4Wn8I1FXicXp+rDJnYVIOpN5c3ehchPRXZi5THYn552Tu16NOwIJFWV1ELtOfqMb5NxJK5iC/t8oMNnHEx27eagd3Rv6fg0vxmz0+o5FHjpFlMt4tq2F/4QANPP39f7dCh9bRnSvHA+Zod9hNAHbHc6VfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V47D3As3; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V47D3As3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3Q
	P+wIe4QmUY+tlCZQ6eAhcTPkQre7gSIKJlJZj1oM8=; b=V47D3As3MCXylmv7zy
	txM2J4Hv11qbk/UYg6UwwVVj7qGxzB2i033doLb+/Q9OL0urvK96yHXbeb3O3QLc
	h3dQbp6lM2ACrowrfu53ojxaQ9zn98djvl4/PGbroEfF/b39cvl/vgnV8bc+pvWU
	CCxZKgEjTTWEn+Kb8/KhZreos=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD333iWb9Vqfw8vAw--.37579S2;
	Mon, 19 Oct 2026 09:17:13 +0800 (CST)
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
Subject: Re: [PATCH net v1] net/ncsi: fix use-after-free of ncsi_dev_priv in ncsi_unregister_dev()
Date: Mon, 19 Oct 2026 09:17:09 +0800
Message-ID: <20261019011709.432664-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017015315.415794-1-18983559317@163.com>
References: <20261017015315.415794-1-18983559317@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333iWb9Vqfw8vAw--.37579S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr45Jw15GF1fWr4fCr43trb_yoWrCw43pF
	W5WFWYy3ykZrWUXFWkJF4fXFyruw47Jw45Z398KrW7Cay5uryIvryfKa1UZFy5CFs7uw40
	vw4jvw4rXa1kAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbGYLUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4BkS9WrVb5mnqAAA3Y

Thank you for the review. All four Highs are legitimate and will be
addressed in v2. One note first: of the two remedies you suggest for the
ftgmac100 teardown, the reorder regresses a BUG_ON; the clearing variant is
the one to take (item 4).

1. [High] monitors still running during the removal loop; request timers
   never cancelled

   Agreed, this is the real hole in v1: dev_remove_pack() has already cut
   off responses, so every in-flight request's one-second timer is certain
   to fire, and a monitor GLS armed between dev_remove_pack() and the
   removal loop is queued behind kfree_rcu(ndp). v2 quiesces everything
   before the first package is released, in this order:

       dev_remove_pack(&ndp->ptype);
       disable_work_sync(&ndp->work);
       NCSI_FOR_EACH_PACKAGE(ndp, np)
               NCSI_FOR_EACH_CHANNEL(np, nc)
                       ncsi_stop_channel_monitor(nc);
       for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
               nr = &ndp->requests[i];
               spin_lock_irqsave(&ndp->lock, flags);
               used = nr->used;
               spin_unlock_irqrestore(&ndp->lock, flags);
               if (used)
                       ncsi_free_request(nr);
       }
       list_for_each_entry_safe(np, tmp, &ndp->packages, node)
               ncsi_remove_package(np);

   disable_work_sync() runs first so ncsi_configure_channel() cannot
   re-arm a monitor afterwards; stopping all monitors before any free
   closes the GLS window; ncsi_free_request() then takes each outstanding
   request down, deleting nr->timer synchronously and releasing the cmd
   and rsp skbs (nr->used is read under ndp->lock).

2. [High] only the outermost ncsi_dev_priv gets an RCU-deferred free

   Agreed; the channels and their filter arrays are deferred in the
   companion series "net/ncsi: fix use-after-free of ncsi_channel in
   ncsi_remove_channel()" (msgid
   20261017024947.420683-1-18983559317@163.com) and the packages in
   "net/ncsi: fix use-after-free of ncsi_package in ncsi_remove_package()"
   (msgid 20261017012431.413648-1-18983559317@163.com).

3. [High] kfree_rcu() does not protect the netlink reader, which resolves
   ndp through ndp_from_ifindex() without RCU

   Agreed. The readers enter rcu_read_lock() in the channel companion
   series, which also keeps the genlmsg_new(GFP_KERNEL) allocation of the
   PKG_INFO doit outside the critical section -- that sleep window between
   ndp_from_ifindex() and ncsi_write_package_info() is exactly the
   "ndp->package_num at offset 160" access of the first KASAN trace. The
   residual you sketch at the end (a CAP_NET_ADMIN NCSI_CMD_SEND_CMD
   slipping a request in between the request sweep here and the deferred
   free) cannot be closed by RCU lifetime alone; it needs serialization
   between the genl handlers and unregistration, and I would like to leave
   that for follow-up work rather than widen this series.

4. [High] the ftgmac100 teardown UAF is only made less likely

   Agreed that the fix must not depend on grace period length, but the
   first suggested remedy is not viable: registering the NCSI Rx handler
   sets ndp->ptype.dev = dev, so it sits on the netdev's
   dev->ptype_specific, and netdev unregistration runs
   BUG_ON(!list_empty(&dev->ptype_specific)) -- unregistering the netdev
   before ncsi_unregister_dev() hits that BUG_ON. This is exactly the
   crash that 3d5179458d22 ("net: ftgmac100: Fix crash when removing
   driver", 2020) fixed by putting ncsi_unregister_dev() first. I will
   take your second option instead: v2 adds a second patch to the series
   that clears priv->ndev and priv->use_ncsi in ftgmac100_remove() right
   after ncsi_unregister_dev(), so the unregister_netdev() ->
   __dev_close_many() -> ftgmac100_stop() -> ncsi_stop_dev() path no
   longer walks the released objects (it becomes a no-op), with its own
   Fixes: 3d5179458d22.

5. Pre-existing issues

   - The ncsi_vlan_rx_kill_vid() use-after-free against set_one_vid() is
     fixed by 9c7e89fc1b68 ("ncsi: Fix use-after-free in the VLAN id
     list removal"), which is in net-next already.

   - The ndp->vlan_vids leak on unregister is real: after ncsi_unregister_
     dev() has removed ndp from ncsi_dev_list, the later
     ncsi_vlan_rx_kill_vid() from the 8021q NETDEV_UNREGISTER path finds
     no device and the entries leak. Freeing them from
     ncsi_unregister_dev() with kfree_rcu() (same release discipline as
     9c7e89fc1b68) is a natural separate follow-up patch.

pw-bot: cr

