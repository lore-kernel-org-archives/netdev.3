Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98620459A;
	Mon, 19 Oct 2026 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372351; cv=none; b=d/f+Nvrayzs/jY1cXibQwjPBqCdkJXePQZ1eTWbkZuK6+41euNwKjee5zaEPhxu1s75BpKlm7zs4b6C4XiWezl4qLV4sEYl2CPCXh0lyIQgS3aXbMXE0vK50giVTk1WulEJSHdJD9+bpM4dSZuRiRfJXQuOPPHbQuOPYV5FUpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372351; c=relaxed/simple;
	bh=AkxCI7+8gtY7tF3Kt4dvT6SjnHlWHftRgOUvzBbXcHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9TTCJIdi6DFUzuyKQ/RlhHWDB1hpvz724a3y5fdSUDJ+uiT99eTi3bUui33fkMg/CU41nwMZkdQZ15GFPHybsOlWbqfX3FC5VaFQS3cK86CKUaDYfVWJyel+K4H6XIbPCbiFbVM8dkncY1d7KKayK67AOMq9iYY1rIxhBpPDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MVe4Fww6; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MVe4Fww6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Rk
	vGh5KK5ECdkR4jc48yjCpDmM2DmjypZWRR0ZrY0Pk=; b=MVe4Fww6H22gR7mzLd
	5jRz9mMaryj4uYmMKybbJ7sAmVvArGap+GAOB0Fi1vVMuPN4+8TLTw64WODIzpSh
	8Brz+FpB7sS3U2H/zKWV6CK0Zej9+IlYmqTbzHEu6RkvRMrogyyqFh/8zkRsEKGE
	Bo+QHBhNURJIHyOc4uEH66z8Y=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnLyQ6btVqNEeSAg--.14900S2;
	Mon, 19 Oct 2026 09:11:24 +0800 (CST)
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
Subject: Re: [PATCH net v1] net/ncsi: fix use-after-free of ncsi_package in ncsi_remove_package()
Date: Mon, 19 Oct 2026 09:11:22 +0800
Message-ID: <20261019011122.432381-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017012431.413648-1-18983559317@163.com>
References: <20261017012431.413648-1-18983559317@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDnLyQ6btVqNEeSAg--.14900S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy7KrWxZFW7CFWkXw4fXwb_yoW5ZrW3pF
	WYqrWYkw4kJrWF9F97ZF4xGFy5Ww1fJ3WUu3s8K34rAan8Gry5XrZ3tan09a98Crykua12
	qwn0q39Yyr95XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbGYLUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4By6nmrVbjyHdgAA3E

Thank you for the review. All four findings are legitimate. This patch is
one of three companion fixes, and none of the Highs is closed by this patch
alone -- v2 will make the dependency explicit in the commit message and fix
the [Low] inaccuracy.

1. [High] "kfree_rcu() only delays the free ... none of the NCSI netlink
   walkers enter an RCU read-side critical section"

   Agreed. The read side enters rcu_read_lock() in the companion series
   "net/ncsi: fix use-after-free of ncsi_channel in ncsi_remove_channel()"
   (msgid 20261017024947.420683-1-18983559317@163.com), which wraps the
   genl handlers around the device resolution and the list walks, keeping
   the genlmsg_new(GFP_KERNEL) of the PKG_INFO doit outside the critical
   section. I split free side and read side this way so each object keeps
   its own Fixes: tag for -stable backporting; the race is closed by the
   union of the series. The vlan fix that was just merged,
   9c7e89fc1b68 ("ncsi: Fix use-after-free in the VLAN id list removal"),
   shows the free-side-only half: there it was sufficient because the
   set_one_vid() reader already held rcu_read_lock(); here no reader does,
   so the read-side series is required alongside, and v2 of this patch
   will stop implying that a grace period is already relied upon.

2. [High] "The child channels of the package this patch keeps alive are
   still freed with no grace period"

   Agreed; covered by the same companion series: ncsi_remove_channel()
   releases nc->mac_filter.addrs, nc->vlan_filter.vids and nc itself from
   an RCU callback, since the readers reach the filter arrays through the
   channel (the KASAN report on the dump reader is a "Read of size 2" on
   the freed u16 vids[] entries).

3. [High] "The netlink readers hold no reference to the parent
   struct ncsi_dev_priv, and the same teardown frees it immediately"

   Agreed; covered by the third companion series, "net/ncsi: fix
   use-after-free of ncsi_dev_priv in ncsi_unregister_dev()" (msgid
   20261017015315.415794-1-18983559317@163.com), whose v2 also quiesces
   the channel monitor timers and the 256 request timers before the
   removal loop, which is your pre-existing High on that series.

4. [Low] commit message describes the reader inaccurately

   Conceded, my mistake: the walker writes the package id with

       nla_put_u32(skb, NCSI_PKG_ATTR_ID, np->id);

   and never reads np->multi_channel; I had dragged in fields from
   ncsi_set_interface_nl()/ncsi_clear_interface_nl(), which are not the
   readers raced here. The KASAN report the patch is built on matches
   your reading: the "Read of size 1 ... 0 bytes inside of freed 64-byte
   region" in ncsi_write_package_info+0xe3c is the u8 np->id load feeding
   that nla_put_u32() (sizeof(struct ncsi_package) is 60 bytes, so it
   lands in kmalloc-64). v2 corrects the message.

5. Pre-existing High: ncsi_unregister_dev() frees every package and
   channel before it stops the work item

   Agreed. The worker race is real and kfree_rcu() does not help against
   it; it is addressed by disable_work_sync() being moved ahead of the
   removal loop in v2 of the ndp companion series, together with the
   monitor and request-timer quiescing.

pw-bot: cr

