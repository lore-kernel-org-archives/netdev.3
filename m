Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052791;
	b=t71QIV0IB7BuBhxF4OYydze5f/BhKjFj4dIWE+ps48eCRgBcXSjSfIzJMv7zhwbKXlAZ
	 oiZFM04wJYh6xocZzIe4lllZBv9KQigjXmfsGCYUEw9TO9UX5iYoBft/DCSf/2PA+x0i9
	 K2ffXBnaVeus8BXseCzlNMYFqUelx5nrgsZQ+OIBmhDqbYl9nVYKeBUBFmTiOiaxiTHMR
	 5l8cLfrF6UazPGRCSwAfhGG8F2J/K/52OzagEBUg/5L+zxXxLv5omQBeBySDfCPCZ6zNA
	 bzXhj99nZgye7L3sfF+UCfE+nrhrC/zMCu2nT8pa5pvKjr0wo1Jc+2OkBtYZcVLNfHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=amqcoblHVnLhVb7i5K+CjSR7EzPX+kUGwE3sOAk8Cjk=;
	b=zZJZFSwEATLaH6LhicA2zKdUioNgI22HIJwnWy4j7PMRYGQEZjy1MCfIzBQ5eRFYAE8V
	 yi+uPjwmlCTv5fbbAyKSd3/+fpL50vamkrgS9BkVhqAbMO8XxJ7AbCrJMKnX0HGB0rxIh
	 s5cNc+uSaHJkB/naTKJkV6ADmdXA0O650/KtdAVr1YR1fITosskuO9Qn48GHDdfVBNlqV
	 BT1KhWV0z78wxeMHfzZfbj+zqQam7Qh9eDTVTOjwPymBTz/ryUwD8G+SpSrl7gAQleMtD
	 10DA4LlLvNqwYCsPfvkQtIAx0URVmsPKgm+32inaW2eRvohGttQLjSqQWBOQ/4kEzgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TmHFXYXU;
	arc=none smtp.remote-ip=209.85.219.72
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172B606A322
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9172B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TmHFXYXU
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91256a7b7b3so71221146d6.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793052789; x=1793657589; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=amqcoblHVnLhVb7i5K+CjSR7EzPX+kUGwE3sOAk8Cjk=;
        b=TmHFXYXUt4uxebvr/3/ar/BD0zhEL0AS8P/iyDm9oE7lZ+/nbav0iHfqtuh/84QN3u
         AU33icALZl/UphC04FJ9MH6EGqB1zvOObG/6nQ7QXSuFrO2hD4Pdh+9pAjaVppz0zNuP
         qeuyeRwwwao65Ysany6YgfjE+V/hdJTOLYSVDmPcDx9hmG5S3WeEKJuHQsbXcrmO2CLq
         J3ceCyMy1g5XqPUWI6PBnd58CnCQG1rcszP0WU3xYYgyK0wF/4I2Dw3XeqGQn45u5gVr
         7xfoCRYb82iU8E9R+5ECUbieTkPQiJxCiKG28vrl3/nyM8tfp1g+QorTKJfqQrd9dcFP
         XRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052789; x=1793657589;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=amqcoblHVnLhVb7i5K+CjSR7EzPX+kUGwE3sOAk8Cjk=;
        b=w+JYyf/tbEjtx0fjJlj6ILjXQZrRjurBuLLUTnqzN1LOb0bv0dObq/1aBMG4JX5kQR
         +9MOiPYpn0+SYmsPVp2XRoHRHCuP8TtRrD6ntEaymwrp7V2CZUNYuFvtAdeZrAQqqvu4
         ipQwQKZeuAQ8cT+U+u873HTG006HvfNU7Lk9NtJcD+qWrFMLoF6ytc0+ljUGWTxr84Tf
         G+KSiJlVy7XqOZ8npF0fYv8Y2KG+MgOLNlr8gOXiu7OEeHJ/52qREOdS25prOo1vsyE8
         6AaPsWG6dF1vNqcaTVF/5MMBB87YB83/h7kjiFpsG4nNXyWmkE2ZX0Vbx54AMIvl5EEZ
         4T0A==
X-Forwarded-Encrypted: i=1; AKwUvBwp9HzuW+izCybfdSitXH8d0QUsk/gtAxGFitRjeIIw1fEnEBYU/AkwFzCwPvxhblpnTxx6ntk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+NnHwY3W99LmbQps7yTZr/nOmZHXoqxv+yPemBR5CFlgIxtcJ
	vA8kB3WNOplrrot4zILG6q8lvuGZa4IcN837cv/reakK6LE+BvIYabOqPs73tAp97IP2TcZOIIK
	t+0dT1Qc1gllU87beeDiEE6njAQ==
X-Received: from qknoq22.prod.google.com ([2002:a05:620a:6116:b0:93f:d748:291d])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2b4b:b0:93f:26e7:844 with SMTP id af79cd13be357-940ef96bb85mr1233859085a.55.1793052789253;
 Mon, 26 Oct 2026 15:13:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 22:13:06 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026221306.3151025-1-namangulati@google.com>
Subject: [PATCH net] netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts
From: Naman Gulati <namangulati@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_wait_allrefs_any() re-sends NETDEV_UNREGISTER every second while
it waits for the last references on a device to be dropped. By then
netdev_run_todo() has already marked the device NETREG_UNREGISTERED and
RTNL has been dropped at least once since the initial notification sent
by unregister_netdevice_many_notify().

netdev_genl_netdevice_event() does not tell these rebroadcasts apart
from the initial notification and sends a NETDEV_CMD_DEV_DEL_NTF
multicast for each of them. At best this spams NETDEV_NLGRP_MGMT
listeners with duplicate notifications; at worst the pernet state of
the netns the device belongs to is already gone and the handler
dereferences a NULL pointer.

default_device_exit_batch() only unregisters the devices still listed
in the exiting netns; it does not wait for in-flight unregistrations of
devices that were already unlisted (the barrier doing that was removed
by commit 8a4fc54b07d7 ("net: get rid of rtnl_lock_unregistering()")).
So when a device is unregistered by something other than the
cleanup_net() of its own netns while references on it are still held,
e.g. a veth whose peer in another netns gets deleted, and that netns
exits while the device is stuck in netdev_wait_allrefs_any(), the
remaining pernet exit handlers run and genl_pernet_exit() sets
net->genl_sock to NULL. The next rebroadcast then crashes in
genl_has_listeners():

  BUG: KASAN: null-ptr-deref in netlink_has_listeners+0x3d/0x3f0 net/netlink/af_netlink.c:1388
  Read of size 8 at addr 0000000000000578 by task syz.0.0/5325
  Call Trace:
   <TASK>
   netlink_has_listeners+0x3d/0x3f0 net/netlink/af_netlink.c:1388
   genl_has_listeners include/net/genetlink.h:644 [inline]
   netdev_genl_dev_notify+0x161/0x450 net/core/netdev-genl.c:93
   netdev_genl_netdevice_event+0x98/0x3c0 net/core/netdev-genl.c:1491
   notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
   netdev_wait_allrefs_any net/core/dev.c:11690 [inline]
   netdev_run_todo+0x731/0x1060 net/core/dev.c:11808
   rtnl_unlock net/core/rtnetlink.c:157 [inline]
   rtnl_dellink+0x68f/0x810 net/core/rtnetlink.c:3707

syzbot hit this by moving one end of a veth pair into a short-lived
netns while netdevsim's deferred FIB event processing still held a
reference on it, and then deleting the other end (repro [1]). While the
source of this bug is netdevsim deferring FIB processing for and holding
onto the device reference for O(seconds) which is being fixed
separately [2], any driver may introduce such a delay and trigger the
null-ptr-deref.

Skip the rebroadcasts, which are the only NETDEV_UNREGISTER events
delivered with reg_state == NETREG_UNREGISTERED. The notifications sent
by unregister_netdevice_many_notify() and, for a device leaving a netns,
by __dev_change_net_namespace() are issued under RTNL in the same
critical section that unlists the device, before its netns can be torn
down, and keep being handled. This mirrors what ip6_route_dev_notify()
already does to cope with the rebroadcasts.

This change should not break the UAPI spec as it defines dev-del-ntf as
a "Notification about device disappearing." which is a single event. The
rebroadcast in netdev_wait_allrefs_any() exists to re-kick in-kernel
subsystems holding references; netdev-genl happens to be on the notifier
chain and forwards it.

[1] https://gist.github.com/NamanGulati/2d1b49b8757f9a88b0bd6e55018c02ae
[2] https://lore.kernel.org/r/20261023191517.607834-1-kuniyu@google.com

Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev stuff")
Reported-by: syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6adf9f64.6200f071.51519.0ed1.GAE@google.com/
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Naman Gulati <namangulati@google.com>
---
Note that the reproducer attached to the syzbot bug targets a different
bug (via devlink_port_notify() on netns teardown) that happens to share
the same crash title, not the one in the original reported crash report.
---
 net/core/netdev-genl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 33b9f4eb9565a..2032ab9a864c2 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1487,6 +1487,12 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
 		netdev_unlock_full_to_ops(netdev);
 		break;
 	case NETDEV_UNREGISTER:
+		/* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
+		 * while waiting for the last references to be dropped; the
+		 * netns may already be torn down by then. Notify only once.
+		 */
+		if (READ_ONCE(netdev->reg_state) == NETREG_UNREGISTERED)
+			break;
 		netdev_lock(netdev);
 		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
 		netdev_unlock(netdev);
-- 
2.56.0.307.g5fe7bd680c-goog

