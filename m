Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FB2F8E9E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840491; cv=none; b=k9MHaoSuLqfuzcGqvMxqAk+LqAN62wGOvvovmMuE20lxJwoN/YPyq2+swuT7Yi/rmFT/6sxj8qt4QE3RVMCbXcwfKyZngmkNmpNrBG0hfipLjNUsL19XMYn3eo/o6mOJzoCavlt5yj5iTjNVM0SQzlTLqBqYPqLuD8oTe9O49NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840491; c=relaxed/simple;
	bh=1ARn5FU6OEs4OGMpAFwaVFY8rvOun5USCgfBGosxIh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSWOa78ANc99hwNAR2pH36V+UkYkX2MLM1xf/ChxvAtEwZJl9dCxAQNgncrD5zt2sn9GbdXMJIMFla1BhKi4EG++eZZBhVmu6guDFdQk0+LWsQYdstWkpMbC0NhHl9kE6hJMQ6fXiqhTLgyoRvo38RH54onS3ifGiMBZeKEzOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phd8hU8N; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phd8hU8N"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso2767212b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 21:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788840490; x=1789445290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ExDYy8ptGsZPqN8wr0vMUynJ6wwhmEgGfmX3mDplxlU=;
        b=Phd8hU8NH2w+ZlId1q0gMFi4S7sWeJFMXK0KiFlZM+RCIrC7okADdZKUjfobPiUs05
         UNoDsau7t4hl56gOD1bNs2pVsc0hAPwBcVxhHZVjMY/TL34ltnuEziR21kN+nyK49HNg
         yrk1NL93R+dnWzhY8o+kryYqEWDH/WEqn2H3THPirBx33Vb5id8GD2LyMV8tsJ0uKFCv
         uJqGFXi2iz4SKSCiWy+KjwKhc9ewHF8ovPlMaZp+P++7O6P/W0x2D8JyYl/vQHXF9o8k
         pEOUdbN4OI/lZ8TZpA8tPK7yNY5j0UeqUz0lZc4AYVeOKLI58kliB7WEmL9nQ6OpLALe
         Ndyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788840490; x=1789445290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ExDYy8ptGsZPqN8wr0vMUynJ6wwhmEgGfmX3mDplxlU=;
        b=ZKbBz+iFf+QH+2CaIcIDPS/nCNe9a7AkBBrPj+selRZ8WWEpsYvpeblDPNli6TyxrR
         FqdkF1VavtfWoctsFuAaIsRXyhFdzmTVbZmGI1175evRads8ctJ80r6FPzltTOsnLQFY
         vLZNxp8umYBZuwdOmhJF731zCuxtKanG+4ikrt+STUzaspjN4pAyA6FCySLv12iPMj5D
         yQQSKc6wpDyge3jyx9ynt/SE4o34alJb1Gkbiu142VtGMXb4KklW3mN3THgeQIZmTIiW
         x08RQ7EyWm2/jNHHB4pxxz3DN5r+bqjf1I6cqMGBziNbEmEV8k4Fjrm/Auz6NHW5Hb4m
         lyfQ==
X-Forwarded-Encrypted: i=1; AKwUvByuRR0Jhln7dmiggqSrZ641WzAFdpC2BXT9YGgIEzMRY5ZGrpuEz3PPIXEGwHkyzG67VPRQks8=@vger.kernel.org
X-Gm-Message-State: AFuF++m0dPDSpBUA+NrKL6OcxbPzTuEMKXIpMCL/M5tA01hpnLR+PYlA
	0QMwAOYZJkPNL79L9bkbdpXG6H3fz2BWrVA/0wcw7l07mrAgqaBw4tB4
X-Gm-Gg: AYBFou2uffdYpctCMJGJYxsj1paxS+a62kasz8W/2Dw1GTVwAFBihXgo66c+4znXNh0
	YILQdUAnQ7EN6mNaZ+zbLL/Qzyd8ktkLqcDUZQYvTtvUeKTi1CnFUnemp9fA9/1fEJnB9RBa19k
	pjQLX4SRo1vB55NYqlc9ZNXu2BGI314dN3uDA17nC3LG7ojPwWb9z+P2fceq8QMl/9pK4TV5kCi
	6Dn4jFYEgLKZZdpU1W54pvR2icpYiWM7eEP+6yu5rviubBpUeQ1l4ChtuE8b+fByfCU0lpmHhNT
	KfCKDetDKLVC/0zii2pKFdJsehe8j1TCBwhQi77XKfWIdni7/ZfILYgcy4ZCW4PDR95z6e2Ptnw
	ExGvkrtMBx0Xgz1/mUf+D6oyhKi15zd/WA8PvREl45751M6ywY1SxrAiYsIDH1l2Qbjxs5Ydp8v
	BHfazIvNL2w0YhYsVD4p83ZjUXWvzBRMQeTCWQXsoR9v9qg+5IhlGkLE7ZmJ+aumwQJVE=
X-Received: by 2002:a05:6a21:6442:b0:3da:5b4d:a89f with SMTP id adf61e73a8af0-3da5b4dab37mr23740538637.27.1788840489820;
        Mon, 07 Sep 2026 21:08:09 -0700 (PDT)
Received: from dev-ubuntu ([128.14.159.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm32042606eec.9.2026.09.07.21.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:08:09 -0700 (PDT)
From: faicker.mo@gmail.com
To: faicker.mo@gmail.com
Cc: stable@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: net_failover: Fix the deadlock in net_failover_slave_name_change()
Date: Tue,  8 Sep 2026 12:06:29 +0800
Message-ID: <20260908040708.3972058-1-faicker.mo@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faicker Mo <faicker.mo@gmail.com>

This is a sibling fix of commit
b84c5632c7b3 ("net: net_failover: Fix the deadlock in slave register").
There is netdev_lock_ops() in the upper callers, so using netif_open()
instead of dev_open().

Call Trace:
 __schedule+0x2bb/0x650
 schedule+0x27/0xb0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x550/0xaf0
 __mutex_lock_slowpath+0x13/0x20
 mutex_lock+0x3b/0x50
 dev_open+0x3b/0xe0
 net_failover_slave_name_change+0x22/0x40
 failover_event+0xd4/0x1e0
 notifier_call_chain+0x62/0xf0
 raw_notifier_call_chain+0x16/0x30
 call_netdevice_notifiers_info+0x50/0x80
 netif_change_name+0x200/0x330
 do_setlink.isra.0+0xb12/0xdf0
 ? security_capable+0x9a/0x1e0
 ? ns_capable+0x31/0x60
 rtnl_setlink+0x302/0x670
 ? netlink_recvmsg+0x296/0x340
 ? security_capable+0x9a/0x1e0
 ? __pfx_rtnl_setlink+0x10/0x10
 rtnetlink_rcv_msg+0x384/0x460
 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x61/0x120
 rtnetlink_rcv+0x15/0x30
 netlink_unicast+0x28f/0x3c0
 netlink_sendmsg+0x216/0x450
 __sys_sendto+0x222/0x230
 __x64_sys_sendto+0x24/0x40
 x64_sys_call+0x1d5d/0x2390
 do_syscall_64+0x105/0x5a0
 ? do_syscall_64+0x140/0x5a0
 ? exc_page_fault+0x94/0x1e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Signed-off-by: Faicker Mo <faicker.mo@gmail.com>
---
 drivers/net/net_failover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 3f7d31033bae..1b5213e87070 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -675,7 +675,7 @@ static int net_failover_slave_name_change(struct net_device *slave_dev,
 	/* We need to bring up the slave after the rename by udev in case
 	 * open failed with EBUSY when it was registered.
 	 */
-	dev_open(slave_dev, NULL);
+	netif_open(slave_dev, NULL);
 
 	return 0;
 }
-- 
2.53.0

