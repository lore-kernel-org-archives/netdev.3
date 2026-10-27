Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065671;
	b=Jdv1jj+dd7o7/UYY0hhg94BNOF2WuMh+7aH3i0UtCSYRBUd6ZA0cBUdmgEtlfbz8Kvm0
	 sRfOkIukz8+xxng5R8bBRyRRhM8mIfKfocfKJ/jswh4FBPQLl7hlgRwN8m6SRgZkNYAWv
	 doJPBRCT3j6/rNhjwtd5Dg0HMCB7BGHUKujHNa7rThjsP2GB8IEuNArzNfTj4wp92Vy22
	 z1LknbHDO1gFl6aInTc201Pc2HOO6A7SxBXrfRSJzRb0F8aNO/eICO7Od7l5dQEhraVJw
	 dbsrjhQwF+7CWGqegHpnhdKQkNMk7zsnz53wFuRUiLE04wKTThzvBkSY002WVVA39oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=uATvahXuhODQd5DDWhOQGeIgpgR0Pf+m8wG01EkXzps=;
	b=yRjgBWivPbKV+MBD1ksvnw9SgaFt6hg+bWV4KyHrFXPN4jMXgrRNuK/nkuuHoOyqeRUF
	 zjV9XCDhWM+YxM7wjwadUG2kU/sHn74UfQ8Iey4fIVZYbdospDelOt+F7ji6T4YtwjprY
	 Xzha9EVv5B1cNd7qy4xerZZEKQUdwDHQHWjD+MwWqxqeYpgAZ/MdPFBe1q4seil3CCkRp
	 0UhKEj7Vfjq1bM2oTLEGo1n9m7y6Fyf5tlEVlSsw4v4cIH7IWyFPwlfgZG3ryPZxTTSEp
	 AcsxSRJQSM0IsspXvmMiPi4be662CGHDaFKaRBA3bBAAltP9KvigHJm2PhB7bNIGC2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nsJ9qv7d;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E5606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C88E5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nsJ9qv7d
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89e6ddd4554so2741749b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793065670; x=1793670470; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uATvahXuhODQd5DDWhOQGeIgpgR0Pf+m8wG01EkXzps=;
        b=nsJ9qv7d84L5r1gJDnff54uqJiqW/gnmh7ufhnA9LpXADMQN/pwCZdSHqpL9/HAkO/
         oenK4IXbpqqSuG5xA4vc/AUFE4VYbB8dMHsA+FP4ZaMVjurs73yGBjbkXrpZiqnwEXIK
         y5ph3qlgCwtpQqx9mZRUGxHYuAZp0d+2lzecfKda2dN3i3eVgPU+41dvXF+mJ5L39eNB
         8YcgqPYYD/WRbCnFOeVk2o+bKXs2v2l0KvjznUKUwJObPIu6BDuoRiT62SjRp2JKL1Um
         TyuQrLjR9C5xcK2XZDGWY4TPMbELyKsFGCu2IzbdH2ndO0+D96RhOyxIkH3wFaYVvGpA
         KRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793065670; x=1793670470;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uATvahXuhODQd5DDWhOQGeIgpgR0Pf+m8wG01EkXzps=;
        b=ajcY6OYVJJJ79nvQUelRAt5rsnsJivRzZzpnt+6vfx5eo3f1OOp96/I/p2pTtSeOzW
         Gr5uWPXp5h6x3Jkug08OZARUCUSeF2aDtoJ6UfaNPgMd4YXB+o94FCnmQC8XAqaGRGuO
         ovXwvdKa6Rj30+doz+0HeOvNAFjEqvY2DWwPURDMuOXgft9J9LmlgkwiTp6C//kFuWCM
         2YrBxJhntMg9GZEUVSIZGlyUONEf9sQ9T5eOojUMkU/nfAV/QYFXQtiN+qDpVLln4Tgd
         Bz0UqfsFTkfj7RMSINvWrz28+ywBQvjvX/1g9QVs/PqWT3rFztVSEJe4a77Jcw4W2EAQ
         a+aw==
X-Forwarded-Encrypted: i=1; AKwUvByjEzbCReuMwPsm8N2UaEIhP+XniusN7f35fr0cyvr48jH45C8+bSTLx3LTZZ+ArZqRn5HiYP4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCdEO76BtYrQbbGg2e/Kyui+V4QmnKT4nZ73A99KZAMEaTpT/X
	MUo0aGHFegVIjzvsnyHyCtML8Wv4Wd4Q0Ly6OZdxI+X+xVwfWdYt3BQcI3JvRad5RXHEDuQTIuS
	f8gH4Vw==
X-Received: from pfnx11.prod.google.com ([2002:aa7:84cb:0:b0:8a1:6f:7af2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a20d:b0:89e:261c:448b
 with SMTP id d2e1a72fcca58-8a366d7a756mr6449404b3a.34.1793065669835; Mon, 26
 Oct 2026 18:47:49 -0700 (PDT)
Date: Tue, 27 Oct 2026 01:47:49 +0000
In-Reply-To: <at_TlVBS-5KVZAkg@devvm16445.scu0.facebook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026221306.3151025-1-namangulati@google.com> <at_TlVBS-5KVZAkg@devvm16445.scu0.facebook.com>
Message-ID: <auABpyzeuUl2S3_W@google.com>
Subject: Re: [PATCH net] netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Naman Gulati <namangulati@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Mon, 26 Oct 2026 15:28:44 -0700, Stanislav Fomichev wrote:
> On 10/26, Naman Gulati wrote:
> > netdev_wait_allrefs_any() re-sends NETDEV_UNREGISTER every second while
> > it waits for the last references on a device to be dropped. By then
> > netdev_run_todo() has already marked the device NETREG_UNREGISTERED and
> > RTNL has been dropped at least once since the initial notification sent
> > by unregister_netdevice_many_notify().
> > 
> > netdev_genl_netdevice_event() does not tell these rebroadcasts apart
> > from the initial notification and sends a NETDEV_CMD_DEV_DEL_NTF
> > multicast for each of them. At best this spams NETDEV_NLGRP_MGMT
> > listeners with duplicate notifications; at worst the pernet state of
> > the netns the device belongs to is already gone and the handler
> > dereferences a NULL pointer.
> > 
> > default_device_exit_batch() only unregisters the devices still listed
> > in the exiting netns; it does not wait for in-flight unregistrations of
> > devices that were already unlisted (the barrier doing that was removed
> > by commit 8a4fc54b07d7 ("net: get rid of rtnl_lock_unregistering()")).
> > So when a device is unregistered by something other than the
> > cleanup_net() of its own netns while references on it are still held,
> > e.g. a veth whose peer in another netns gets deleted, and that netns
> > exits while the device is stuck in netdev_wait_allrefs_any(), the
> > remaining pernet exit handlers run and genl_pernet_exit() sets
> > net->genl_sock to NULL. The next rebroadcast then crashes in
> > genl_has_listeners():
> > 
> >   BUG: KASAN: null-ptr-deref in netlink_has_listeners+0x3d/0x3f0 net/netlink/af_netlink.c:1388
> >   Read of size 8 at addr 0000000000000578 by task syz.0.0/5325
> >   Call Trace:
> >    <TASK>
> >    netlink_has_listeners+0x3d/0x3f0 net/netlink/af_netlink.c:1388
> >    genl_has_listeners include/net/genetlink.h:644 [inline]
> >    netdev_genl_dev_notify+0x161/0x450 net/core/netdev-genl.c:93
> >    netdev_genl_netdevice_event+0x98/0x3c0 net/core/netdev-genl.c:1491
> >    notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
> >    netdev_wait_allrefs_any net/core/dev.c:11690 [inline]
> >    netdev_run_todo+0x731/0x1060 net/core/dev.c:11808
> >    rtnl_unlock net/core/rtnetlink.c:157 [inline]
> >    rtnl_dellink+0x68f/0x810 net/core/rtnetlink.c:3707
> > 
> > syzbot hit this by moving one end of a veth pair into a short-lived
> > netns while netdevsim's deferred FIB event processing still held a
> > reference on it, and then deleting the other end (repro [1]). While the
> > source of this bug is netdevsim deferring FIB processing for and holding
> > onto the device reference for O(seconds) which is being fixed
> > separately [2], any driver may introduce such a delay and trigger the
> > null-ptr-deref.
> > 
> > Skip the rebroadcasts, which are the only NETDEV_UNREGISTER events
> > delivered with reg_state == NETREG_UNREGISTERED. The notifications sent
> > by unregister_netdevice_many_notify() and, for a device leaving a netns,
> > by __dev_change_net_namespace() are issued under RTNL in the same
> > critical section that unlists the device, before its netns can be torn
> > down, and keep being handled. This mirrors what ip6_route_dev_notify()
> > already does to cope with the rebroadcasts.
> > 
> > This change should not break the UAPI spec as it defines dev-del-ntf as
> > a "Notification about device disappearing." which is a single event. The
> > rebroadcast in netdev_wait_allrefs_any() exists to re-kick in-kernel
> > subsystems holding references; netdev-genl happens to be on the notifier
> > chain and forwards it.
> > 
> > [1] https://gist.github.com/NamanGulati/2d1b49b8757f9a88b0bd6e55018c02ae
> > [2] https://lore.kernel.org/r/20261023191517.607834-1-kuniyu@google.com
> > 
> > Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev stuff")
> > Reported-by: syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6adf9f64.6200f071.51519.0ed1.GAE@google.com/
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Signed-off-by: Naman Gulati <namangulati@google.com>
> > ---
> > Note that the reproducer attached to the syzbot bug targets a different
> > bug (via devlink_port_notify() on netns teardown) that happens to share
> > the same crash title, not the one in the original reported crash report.
> > ---
> >  net/core/netdev-genl.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 33b9f4eb9565a..2032ab9a864c2 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -1487,6 +1487,12 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
> >  		netdev_unlock_full_to_ops(netdev);
> >  		break;
> >  	case NETDEV_UNREGISTER:
> > +		/* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
> > +		 * while waiting for the last references to be dropped; the
> > +		 * netns may already be torn down by then. Notify only once.
> > +		 */
> 
> [..]
> 
> > +		if (READ_ONCE(netdev->reg_state) == NETREG_UNREGISTERED)
> > +			break;
> 
> Same as
> https://lore.kernel.org/netdev/20261026063743.1797-1-lege.wang@jaguarmicro.com/
> ?
> 
> reg_state is protected by netdev, why not do this under netdev_lock?
> Also seems like we are fixing a symptom, not the problem?

fwiw, I suggested not to take the lock since we are only interested
in NETREG_UNREGISTERED here and there is a clear ordering in the case.

The root cause is netdevsim this time, and I have a fix,

https://syzkaller.appspot.com/text?tag=Patch&x=15923c21580000

but rebroadcast itself is not-ideal-but-valid behaviour, so each
NETDEV_UNREGISTER must be idempotent unless we can completley remove
the rebroadcast mechanism itself in the future.



> 
> >  		netdev_lock(netdev);
> >  		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
> >  		netdev_unlock(netdev);
