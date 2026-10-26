Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053732;
	b=ICzh4XR3p+MsKKJDhK7A5pzgM/zoLD5pZ9ljchXReVqJjtU0znCuwlnQ5O3YACqI8+4+
	 +GZPi5+XAtGBBFlhrvMK9iy0BMiOlmF2r8Z364+MY7wgaiWPlREaaQ94UP/tMsuzzBLOU
	 8hFTUvAAxmyiyEAPo1kZYCYPOkI07hWhzNMRx6GVBQzaBUVdw1mz5SeXiZJe6C1MOH8x+
	 lZ3HYlxrjKqzNm2IIxwZfjdyk0SvVrmtsXBWT4mShgIh0/XQzlsIuebXeSa0bESnkYDQf
	 i7eqoXvbnrzeu7O1bf+QaWjd40jZ7gqMDl8+qgZuJQ/Qnv0H8RzCb3/dBLti6vj4FxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mDlib8TkkEdH4nZD+BJ6Y0j+WeU+RPNDkE1f8QklKCs=;
	b=HKMhAAkYNtVWa/kVjcHvkyj07msqeUzeLZPZmrZKaCwNSpNkoa3bx+8Lpoq+SYUHKqZV
	 aBFlHHnTBGJhLiDbi0WkgJEbVARdFsFACLKsvY2ZDbYipiiP/rRjd3KfRFpaierj3cm0U
	 XRgby1Ge2rIUeLZ0C6rGQB3WnGZzIBqeVYIofYkoHeGpDF8PXSjBvJbs9KqIqt0Pd+L4m
	 oWPKcB0aCwrMneUpCXjMsN6B3Pc3bDXDesYjifKh0KafsNZ6gAhiR5so9Al79N6p7u/I2
	 iLRCIfiUV2llW0DoMN7npG6JkELwokLOEr050CNtPVadI3+cXAl8rPGEW9AdHevWzSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OmhpwGwy;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C46606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C46606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OmhpwGwy
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so2392155eec.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793053730; x=1793658530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mDlib8TkkEdH4nZD+BJ6Y0j+WeU+RPNDkE1f8QklKCs=;
        b=OmhpwGwyvy0UAl1RLg7Y+/pjq2vbab6E6/Un7qfPvuFx83tRW51ZtzYFVHrtZGgt4+
         OVxPMAj5IRXzY/t7VDmhmwFIykEGXppC64FnpKB02gUcHypAAsabCyaYtF5AsOdxOdr0
         kmjwD2grj9HOhRcvCB4q3JMCgBWDTq2URBREOGHVanomqrw57niUk91iouUcpxEl8o1E
         U8Rp/qTQwx94akq31+OzrVpdk3tXzCl09ARIvvCChGkf2EMFaRmO07GxVD0V7lYXcua4
         Ohc0YPAeVjID70dwj2iCYs+p0lmlb801dArX4N2Dd+HUvjG1HJhK3MJvDvYQYMqUfLnH
         W2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793053730; x=1793658530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDlib8TkkEdH4nZD+BJ6Y0j+WeU+RPNDkE1f8QklKCs=;
        b=h2TAjmEMQxmG0zActqyI5DhJZCDDHew2FNdaRYyjSu3BmRcwZmiRQwmh16Fe6rHhO4
         jaDF3JR6QTUkwYxud0Bbo5gte5eHAf+t6+GGXA1ktXEi+Td+BOWViT2zdoCoMs7/r0WW
         aIGMJFURIn27HxOyExgHTIrnzOPjAzfZpYRM3kubuHGtcyPXIWwCe2wplH254KlltCMB
         5fD3yrL3pSYQIogFInozdQ9TuQMgWqsJ/EQqD1Gox3bPxvy4UmEcWG/lr1Hqn3922psf
         2P0IO/CDh2248D/Gz65xqxCk0SMGeysMmrsfo3qbBi8R86Q75xcFFToh67vYyY+ZGmup
         gJJw==
X-Forwarded-Encrypted: i=1; AKwUvByLzRGjVHzBcwhiEyKTRDz9QAb73Ou1kGxizjdBhQ0PesR6leEvYwlKsdp9hZ7Ir3MBhNIfS28=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQ9nlGKcOv2VyOVlFhlbL4WOp6mP4qh7Mk1t1b74MhhjAE1pHY
	bmx1WdOfJB661PyR+vWsgLQLqKDQMDIhv+ie6JSCcF3etLpgk98+ypda
X-Gm-Gg: AYBFou2jXpmhbP7ptwSKHb5IaWzaVYil5RaJlR9hgCosCwLoIaCmDV0/BTWMqwa4Lx7
	rCEcgDbYn5ZSG2lxdCKCTt8Tm3Mk/yyC2Y10iz897xrf4ebaVaxhKktmogmcywdD4O8TAWHhyew
	GZHN/LaXwryod+GVPjKFs5EqdB20ndeO/Tbt3K/mbibd50BKZePqzsBH1Z3cLo21SZ4Lsq9LDXh
	VFHAIC9PP1xXjsfMj+J5uh4WTw5TFULcc+RpxNgC14LbDZzVC6t2+TX48dY2IUt9uOHUTvg3Cj0
	UpannGRWiawbcTjzOYnX4YYh/YS0MBwu8frLl7wMt7zUwy/PAmozlGa7LIm/2yf/MB3kguqtDl2
	n26q04j9VSfxVkRjFNoQKFxMz+SZ2Wyw4o7Obd8sjRgP16d+U7dxLK+2VbpjAe0AmD584sKxbnU
	mg7YgVZLxcOuUOHlbuypxTsZ7znNPKrwHI1wENQml6WvkS2inWjZy3+hSnW++3ipJtlNp75118d
	V9X36M8/uNx6Rmcr/NfJ2MmhyYmCuqc8AKPxI2zrNsQGekxbw==
X-Received: by 2002:a05:7301:5501:b0:367:68c:860d with SMTP id 5a478bee46e88-369e84a5128mr12827168eec.29.1793053729619;
        Mon, 26 Oct 2026 15:28:49 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:43::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm27343359eec.21.2026.10.26.15.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:28:49 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:28:44 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Naman Gulati <namangulati@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com
Subject: Re: [PATCH net] netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts
Message-ID: <at_TlVBS-5KVZAkg@devvm16445.scu0.facebook.com>
References: <20261026221306.3151025-1-namangulati@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026221306.3151025-1-namangulati@google.com>

On 10/26, Naman Gulati wrote:
> netdev_wait_allrefs_any() re-sends NETDEV_UNREGISTER every second while
> it waits for the last references on a device to be dropped. By then
> netdev_run_todo() has already marked the device NETREG_UNREGISTERED and
> RTNL has been dropped at least once since the initial notification sent
> by unregister_netdevice_many_notify().
> 
> netdev_genl_netdevice_event() does not tell these rebroadcasts apart
> from the initial notification and sends a NETDEV_CMD_DEV_DEL_NTF
> multicast for each of them. At best this spams NETDEV_NLGRP_MGMT
> listeners with duplicate notifications; at worst the pernet state of
> the netns the device belongs to is already gone and the handler
> dereferences a NULL pointer.
> 
> default_device_exit_batch() only unregisters the devices still listed
> in the exiting netns; it does not wait for in-flight unregistrations of
> devices that were already unlisted (the barrier doing that was removed
> by commit 8a4fc54b07d7 ("net: get rid of rtnl_lock_unregistering()")).
> So when a device is unregistered by something other than the
> cleanup_net() of its own netns while references on it are still held,
> e.g. a veth whose peer in another netns gets deleted, and that netns
> exits while the device is stuck in netdev_wait_allrefs_any(), the
> remaining pernet exit handlers run and genl_pernet_exit() sets
> net->genl_sock to NULL. The next rebroadcast then crashes in
> genl_has_listeners():
> 
>   BUG: KASAN: null-ptr-deref in netlink_has_listeners+0x3d/0x3f0 net/netlink/af_netlink.c:1388
>   Read of size 8 at addr 0000000000000578 by task syz.0.0/5325
>   Call Trace:
>    <TASK>
>    netlink_has_listeners+0x3d/0x3f0 net/netlink/af_netlink.c:1388
>    genl_has_listeners include/net/genetlink.h:644 [inline]
>    netdev_genl_dev_notify+0x161/0x450 net/core/netdev-genl.c:93
>    netdev_genl_netdevice_event+0x98/0x3c0 net/core/netdev-genl.c:1491
>    notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
>    netdev_wait_allrefs_any net/core/dev.c:11690 [inline]
>    netdev_run_todo+0x731/0x1060 net/core/dev.c:11808
>    rtnl_unlock net/core/rtnetlink.c:157 [inline]
>    rtnl_dellink+0x68f/0x810 net/core/rtnetlink.c:3707
> 
> syzbot hit this by moving one end of a veth pair into a short-lived
> netns while netdevsim's deferred FIB event processing still held a
> reference on it, and then deleting the other end (repro [1]). While the
> source of this bug is netdevsim deferring FIB processing for and holding
> onto the device reference for O(seconds) which is being fixed
> separately [2], any driver may introduce such a delay and trigger the
> null-ptr-deref.
> 
> Skip the rebroadcasts, which are the only NETDEV_UNREGISTER events
> delivered with reg_state == NETREG_UNREGISTERED. The notifications sent
> by unregister_netdevice_many_notify() and, for a device leaving a netns,
> by __dev_change_net_namespace() are issued under RTNL in the same
> critical section that unlists the device, before its netns can be torn
> down, and keep being handled. This mirrors what ip6_route_dev_notify()
> already does to cope with the rebroadcasts.
> 
> This change should not break the UAPI spec as it defines dev-del-ntf as
> a "Notification about device disappearing." which is a single event. The
> rebroadcast in netdev_wait_allrefs_any() exists to re-kick in-kernel
> subsystems holding references; netdev-genl happens to be on the notifier
> chain and forwards it.
> 
> [1] https://gist.github.com/NamanGulati/2d1b49b8757f9a88b0bd6e55018c02ae
> [2] https://lore.kernel.org/r/20261023191517.607834-1-kuniyu@google.com
> 
> Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev stuff")
> Reported-by: syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6adf9f64.6200f071.51519.0ed1.GAE@google.com/
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Naman Gulati <namangulati@google.com>
> ---
> Note that the reproducer attached to the syzbot bug targets a different
> bug (via devlink_port_notify() on netns teardown) that happens to share
> the same crash title, not the one in the original reported crash report.
> ---
>  net/core/netdev-genl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 33b9f4eb9565a..2032ab9a864c2 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1487,6 +1487,12 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
>  		netdev_unlock_full_to_ops(netdev);
>  		break;
>  	case NETDEV_UNREGISTER:
> +		/* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
> +		 * while waiting for the last references to be dropped; the
> +		 * netns may already be torn down by then. Notify only once.
> +		 */

[..]

> +		if (READ_ONCE(netdev->reg_state) == NETREG_UNREGISTERED)
> +			break;

Same as
https://lore.kernel.org/netdev/20261026063743.1797-1-lege.wang@jaguarmicro.com/
?

reg_state is protected by netdev, why not do this under netdev_lock?
Also seems like we are fixing a symptom, not the problem?

>  		netdev_lock(netdev);
>  		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
>  		netdev_unlock(netdev);
