Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C9383305
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022278; cv=none; b=itccXh496MLEic7jQwHxaZlDqPPBgrWDDguYmZDGnIsS8HhMWafTKiTORBrJKkpIdnQBflDUn5qii9kfORI6W7CTBzddMPA8/xooQOvvaqkOCBgzBLNo8sin7GeOyRAMi0vh5sdNAS9vvuToK8ELLS5G3xADh/WSEV+c2iJRXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022278; c=relaxed/simple;
	bh=5lywbXSlMAomh1ByTgr47An3DNmTF5ljOwkY+LU+gO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TlhMF/af78uGfsUwmopr5DyyoXrHS4IEbwwSZlMTEFE/rYbXXYdHWkWKi/o/Dzr6E95f1DTdT7LLgdIb+DoDmONcHR5rcnEi2+760T4T2IO2ZfwLWBkkaOtYg4XRUXI/6u4VbRUG9uaQ71b6YzzKBo82dhOpCSNla/lbh6p1KGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=GirLzWmQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="GirLzWmQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cace91f112so58073145ad.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea.ac.kr; s=google; t=1789022275; x=1789627075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DlDEc0Wysg4XmstSxwWtu/wJqLCN0sS8gv/9woOxKFk=;
        b=GirLzWmQkHYi1g2jNC52SpiJz59Kn3NuSHzJQ7iLRhJsv4oOdoXJAZ1Ojg4hM5s/8u
         6zggbjEt4h7wzDeWsL1B36cVeQGOzPTOpK8hGGP3+eO1PKi5xf8j19gvmswpBLPaupsc
         KbypOKgj8aVbbqe0qyZDLD0x0jjeAG4fc32yt87mEJ4/w/fzmHWhx4NbyPlOyU56VSGC
         IaVhXZT//z6YyIyVrwI6m6RTjsg447oShmA9BZBYMRaxxy3jwz+tdhJIegWlWa/55vNc
         KP/myiWkbO/IwB6x0vUIDAJbyixq2kzY+wguZi8ZiF5UdrdSQqYcgUpAKLh/BrG2BR1R
         mPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022275; x=1789627075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DlDEc0Wysg4XmstSxwWtu/wJqLCN0sS8gv/9woOxKFk=;
        b=k+Y6CEiJIXxOuLzAZFWFLYpGJe+Pgy+wr16dLW04YQ2mDj3O3ydrebk/ScyAmpqiF2
         PTn1Ktnt3Ds3AtVyJd+oCx7iIG/O+ZOcJzzaMw/h/GISfBqOenPf8SeBzBE9GWKtimRN
         eUQR9aALyfVf0pBo/Q20bDC6uJJxTyCQ/UcbeANu4e/oLtUrXfv3bvIfhlsF6so+DlT9
         /Xsgw4n5zPozwzdOceEx+2DgfhMx1KMInJoqjAWFKrWugGXTMmpG6zWtPZSB3/FtdJrk
         uluN0tayf8fZE97o6HCybXz39J2/8wWSpVGCbSKxicrwTLU2FTe8OsljwCKCT9B+GvPD
         /+QQ==
X-Gm-Message-State: AFuF++l2QLh6vJ9a32NaXZiLlazNbS0zFg5oOXKPDMl+pseBGMAIfc6u
	e6pKKgXw0ChaAh28s2Bh9Ms6WaDNO7KEa7ETDgys7ybl7Xl1mYaRgmXePH4CRolYcdg=
X-Gm-Gg: AYBFou0SFGYxDnpwC6rdgTVAtvzeuag2KxDT1k7HGJumtzhtoi0CHejzobGEs94JjCe
	l7ahcRmCwhHJg0+z55z2BSE7+ThpSf5pNF4Y3sBrolFylMhSiwLb8seFTA6MzMnOIRN2QZimuJF
	HrRVQh05sFAjmGkhLKUoI+FSl9mWzHkrdIErTquC9u6vV6JYcja+MIhVVVkdttygueqnyr0vc8s
	6PM6n0U4gKHVD0/s7KRVGC6HUTnAm3NNpHDUGyJqhLfjzwovFDTlpUN+Tjmh7BYjrQXXTPRt2rP
	NVHB5UYxZFjD0hJz4fKLihkGGwbJRcbdY27E1mMT8ya9kRkQhKlm4COkJwYIxh/g+BGoDlmcb/B
	thFqkiZa6ZtWSHbI3pC2+J/DRgUg6/L6vEASndpV2YYBHanAsn8UbZDJhRgI3/kv80x++Rxjl9m
	1PBi3CWOetpv+NuORA7eTiuXy2SQHs04kQDcBG+lUoNHpKOWIppRS1/0F/n66eyxMLr2oGyFyqu
	DPxaEieXLnnb2Mn
X-Received: by 2002:a17:903:1670:b0:2d9:438e:b70d with SMTP id d9443c01a7336-2db1232c88emr606673835ad.1.1789022274350;
        Wed, 09 Sep 2026 23:37:54 -0700 (PDT)
Received: from icps5-ESC8000-E11.. ([163.152.219.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497fbf8sm84835435ad.43.2026.09.09.23.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:37:53 -0700 (PDT)
From: Hohyun Sim <tlaghgus0425@korea.ac.kr>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hohyun Sim <tlaghgus0425@korea.ac.kr>
Subject: [PATCH net] net: fddi: skfp: fix NULL deref when setting the MAC address while down
Date: Thu, 10 Sep 2026 15:37:43 +0900
Message-Id: <20260910063743.110747-1-tlaghgus0425@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skfp_ctl_set_mac_address() calls ResetAdapter() unconditionally, without
checking netif_running(). ResetAdapter() first calls card_stop(), which
sets smc->hw.hw_state to STOPPED, and then mac_drv_clear_tx_queue(),
which walks the two transmit queues:

	for (i = QUEUE_S; i <= QUEUE_A0; i++) {
		queue = smc->hw.fp.tx[i] ;
		...
		t = queue->tx_curr_get ;

smc->hw.fp.tx[] is only populated by init_tx(), which is reached from
skfp_open() through init_smt() -> init_fddi_driver() -> init_fplus() ->
init_mac() -> init_tx(). The private area is allocated and zeroed by
alloc_fddidev(), so on an interface that has never been brought up both
queue pointers are still NULL. The hw_state test at the top of
mac_drv_clear_tx_queue() does not catch this, because card_stop() has
just set STOPPED; the function proceeds into the loop and dereferences
NULL. ResetAdapter() does call init_smt() itself, but only after the
queues have been cleared.

Setting the MAC address on a down interface therefore oopses:

  ip link set dev fddi0 address 02:00:00:00:00:01

  BUG: KASAN: null-ptr-deref in mac_drv_clear_tx_queue+0x68/0x2c0 [skfp]
  Read of size 8 at addr 0000000000000010 by task ip/302
  Call Trace:
   <TASK>
   mac_drv_clear_tx_queue+0x68/0x2c0 [skfp 6c01d4bab63c36978bd0a7d7e90837adb44cc37b]
   ResetAdapter+0x29/0x100 [skfp 6c01d4bab63c36978bd0a7d7e90837adb44cc37b]
   skfp_ctl_set_mac_address+0x57/0x80 [skfp 6c01d4bab63c36978bd0a7d7e90837adb44cc37b]
   netif_set_mac_address+0x1e4/0x2c0
   do_setlink+0x684/0x2680
   </TASK>

Address 0x10 is the offset of tx_curr_get, the third pointer in
struct s_smt_tx_queue, on 64-bit. mac_drv_clear_rx_queue(), which
ResetAdapter() calls immediately afterwards, dereferences
smc->hw.fp.rx[QUEUE_R1] in the same way behind the same ineffective
hw_state test; the transmit queue merely crashes first. Both are
covered by the guard below.

Skip the adapter reset when the interface is down. dev_addr_set() is
left unconditional, so the new address is still recorded in
dev->dev_addr. Nothing is lost by not resetting the adapter here:
skfp_open() deliberately re-reads the factory address on every open,

	read_address(smc, NULL);
	eth_hw_addr_set(dev, smc->hw.fddi_canon_addr.a);

and the comment above it states this is done to discard exactly such an
address override across a close/open cycle. An address set while the
interface is down could not have survived the following open even
before this change, so the guard removes no working behaviour. Guarding
the hardware side of ndo_set_mac_address() with netif_running() is
established practice; skge_set_mac_address() has done so since commit
2eb3e621c4e0 ("skge: set mac address bonding fix").

Guarding the reset as a whole, rather than NULL-checking the queues, is
also what the rest of the driver expects. After a previous open/close
the queue pointers are stale but non-NULL, so there is no crash, yet
ResetAdapter() goes on to call smt_online() and STI_FBI() ("Enable
Board Interrupts") while skfp_close() has already called free_irq() -
the adapter would be brought back online with no handler installed. The
only other ResetAdapter() caller is skfp_interrupt(), which by
construction runs only while the device is open.

Found by automated driver testing against an emulated SysKonnect FDDI
adapter under a KASAN-enabled 7.0.0 kernel. Triggering it requires
CAP_NET_ADMIN.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM KASAN
Signed-off-by: Hohyun Sim <tlaghgus0425@korea.ac.kr>
---
 drivers/net/fddi/skfp/skfddi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fddi/skfp/skfddi.c b/drivers/net/fddi/skfp/skfddi.c
index a273362c9e70..feea7baa4816 100644
--- a/drivers/net/fddi/skfp/skfddi.c
+++ b/drivers/net/fddi/skfp/skfddi.c
@@ -928,7 +928,8 @@ static int skfp_ctl_set_mac_address(struct net_device *dev, void *addr)
 
 	dev_addr_set(dev, p_sockaddr->sa_data);
 	spin_lock_irqsave(&bp->DriverLock, Flags);
-	ResetAdapter(smc);
+	if (netif_running(dev))
+		ResetAdapter(smc);
 	spin_unlock_irqrestore(&bp->DriverLock, Flags);
 
 	return 0;		/* always return zero */
