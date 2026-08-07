Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028833BED2B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068211; cv=none; b=QdntXDLXcABNNPoRhHoc8vK/HXgpCCmhv9KCqykKEV78p4XL9/8NuhkVW3rt5iI0UaoiA0LxyLFPPU593aHwVe5aX32O5rUYYSd7ktxu+c6eqL16vbdF1AMZMEA09RIytO8XaliOpeAUDOIGHJoPEYatXfarSr5iLjwMZlrF69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068211; c=relaxed/simple;
	bh=Gxpu/F/Aylv+Yjo+3SO/ZfAUcQymv7bKH3UM/22CCSY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ucI6vKF1q7MsrWawwn1HeJlLDjAivICSrxZkw9HfWh0RFDLX4FBzPWC9QAJtdGquIdlhr3+IayrPMfJvvdI2fsNhsPSYmlC9zQcyCO77Y6chigEHPzPL9pKLZdTQdaQO4nxAwE+/HvolCRBzzCAxxdy0V5mlWmoGuX885QCgu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdoXy8kC; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdoXy8kC"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so4149591a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786068209; x=1786673009; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kEriZnNC3GBGTL4T9OdKdl6fGe6BL7vIv4+AQ5U7r44=;
        b=pdoXy8kChwjPWmibrgYbfLcP1tZKB40YShNCLXDS7MtEQdE4CcGEnnCw/wWKqUlSX4
         59Nqw6Nt+yPLZd5BM93xOK/Yy86mMJ5w5MV4MRQTPdMGyEpjIXcHUWTRmQCTgj6QaM/b
         PMouGJG/6zuUz/8nOViMlV2z/cUn6MrVk4GbMUKeOLZ7qXRkxw1pIwOfMcSjmRNBNlxg
         U7mbVg0K5uO6fcwWaS3s1x7S0VfBTJoUDocZTOs6Ehv8OXm6iiMOixg89wP11qoBS1SV
         /453dFvBY0URtT1zSs83nN7UbRSrj97LFmED+Eh6N7dzT8nxsJCNEuHlI4VzaYEXIwk7
         jI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786068209; x=1786673009;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kEriZnNC3GBGTL4T9OdKdl6fGe6BL7vIv4+AQ5U7r44=;
        b=JPYLvXq0Em70UJALUS9etBem+fP/7oeheKJYqw94XFFXEO3qAw+X1DiBlVcNdcffUY
         QMFOiDKRaNghEedAnC59gqattEVvKRztPRSOEgqzCxhdGPs5w+Cweqmtu4bBjhfQkbBY
         3tct3lwH/r26jqrza+mTIPxNdnY/6yknO+Co84aY2rQ5eu0DJHXO/pE5UYwHbCWuWtQ6
         0ZOmHKsFvSJsQdO+p+7fOU/XwGQQq2M8mYQMRAd86Q+0GKqvFZhvadiBd7sUpDHa55ms
         zzVnKJgHk2V3cNDDmjrPYFeIWEStBcDbrym1hmkv8MVuPxiZolzJSBJvT7nCOAObnzaA
         nwTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqN5aT7g3xjcWFjNfiJoq7ee8E2WYLfiMzVcbRcUq85bLcNCO33wsdmAa25FsbqS9OPj/amrIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygtWjHplBP1UMddwp3MighOPawEoPWMx6+31G0HthPps5TE/2d
	F+46eMGoxW+jocQVp7kumJl7+xkLZM5+8SC5Dihm6YNuJcPNKFUc4kwLE7woYeJ+6GbdQ+P80rZ
	9z0AakA==
X-Received: from pjzd3.prod.google.com ([2002:a17:90a:e283:b0:38f:f04:c1e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f43:b0:37c:6130:7a5b
 with SMTP id 98e67ed59e1d1-3903c54302bmr20117115a91.8.1786068208874; Thu, 06
 Aug 2026 19:03:28 -0700 (PDT)
Date: Fri,  7 Aug 2026 02:03:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807020326.2519445-1-kuniyu@google.com>
Subject: [PATCH v1 net] amt: Don't support cross-netns setup.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a lower device is unregistered, amt_device_event() tries
to unregister its upper AMT device, but it has two problems.

  1. amt_lookup_upper_dev() looks up an upper device in the
      lower device's netns only

  2. amt_device_event() unregisters a single upper device only

If AMT device is created on a lower device in another netns,
removing the lower device triggers the splat below and gets
stuck until all upper devices are removed. [0]

The cross-netns setup seems unintentional considering 1. and
the following points:

  * amt_link_setup() sets dev->netns_immutable to true
  * skb_scrub_packet() is not called in the fast path
  * iproute2 binary fails to find cross-netns lower device via
    link-netns:
      # ip -n ns1 link add amt0 link-netns ns2 type amt dev veth1
      Cannot find device "veth1"

Instead of supporting it properly and preparing for per-netns
netdev unreg, let's forbid cross-netns setup.

Note that the problem 2. needs a separate fix.

[0]:
WARNING: net/core/dev.c:12518 at unregister_netdevice_many_notify+0x1cce/0x2250, CPU#48: ip/2031
Modules linked in:
CPU: 48 UID: 0 PID: 2031 Comm: ip Not tainted 7.2.0-rc5+ #27 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
RIP: 0010:unregister_netdevice_many_notify (net/core/dev.c:12518)
Code: 89 ef e8 d5 52 ae fe e9 d0 f4 ff ff 48 8d 3d f9 3b 9c 02 48 c7 c6 c0 0b 63 84 ba ab 1f 00 00 67 48 0f b9 3a e9 65 ff ff ff 90 <0f> 0b 90 eb 81 48 8d 3d f6 3b 9c 02 48 c7 c6 c0 0b 63 84 ba e2 1f
RSP: 0018:ffffc90004abf160 EFLAGS: 00010212
RAX: ffff888104d38260 RBX: ffff88800b0911b8 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff85b9f880
RBP: ffffc90004abf2d0 R08: ffffffff85b9f887 R09: 1ffffffff0b73f10
R10: dffffc0000000000 R11: fffffbfff0b73f11 R12: ffff88800b091d08
R13: ffff88800b091178 R14: dffffc0000000000 R15: ffff88800b091000
FS:  00007f555b86c600(0000) GS:ffff8881942a0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562107d489c0 CR3: 0000000109a40002 CR4: 0000000000372ef0
Call Trace:
 <TASK>
 rtnl_dellink (net/core/rtnetlink.c:3632 net/core/rtnetlink.c:3674)
 rtnetlink_rcv_msg (net/core/rtnetlink.c:7112)
 netlink_rcv_skb (net/netlink/af_netlink.c:2556)
 netlink_unicast (net/netlink/af_netlink.c:1319)
 netlink_sendmsg (net/netlink/af_netlink.c:1900)
 ____sys_sendmsg (net/socket.c:775)
 __sys_sendmsg (net/socket.c:2738)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
...
unregister_netdevice: waiting for veth0 to become free. Usage count = 7
ref_tracker: netdev@ffff88800d7496d8 has 3/3 users at
     __netdev_adjacent_dev_insert (./include/linux/netdevice.h:4525 ./include/linux/netdevice.h:4554 net/core/dev.c:8791)
     __netdev_upper_dev_link (net/core/dev.c:8879 net/core/dev.c:8963)
     netdev_upper_dev_link (net/core/dev.c:9009)
     amt_newlink (drivers/net/amt.c:3321)

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/amt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 182a41d59a75..7645ce3a29ad 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3221,6 +3221,9 @@ static int amt_newlink(struct net_device *dev,
 	struct nlattr **tb = params->tb;
 	int err = -EINVAL;
 
+	if (!net_eq(link_net, dev_net(dev)))
+		return err;
+
 	amt->net = link_net;
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
 
-- 
2.55.0.679.g6767b8d81c-goog

