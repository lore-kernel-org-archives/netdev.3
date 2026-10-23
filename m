Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792719857;
	b=l84pwDDTIZgpojeyd+d2H2w3VnFdEfKU2Za+iiyt/KiA2IVnotb3Qdz7U9YhEnO9I5bm
	 htZm/Mhk2BPHICnytjo5i9KH3rZwqGPaYj0vd7gZAdikKnh36PPjfZZi5hlq/IddrChDe
	 YlZIjLJSSzcbNN+NUZVU1eZzBy6PEYtkny9u8SaZ/NVdBk004xwjuONhFyq0/bVsKXFEd
	 Y3gN3c78OqqnlcaOpb4EuA8Z18eZeVICAq8Nm1Q/N1T0aRwOWBKp/uBbmwm4+f1mHw9Kq
	 E9TTgf0Q/NoPf4W+c0LXSDvXsRoBQ+NN+wsCtZaVO9F+WoTzSgpjR1Hp00BIxboiEMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=bx7dF6tVndjf82AHo9jgmtaUdmu9XT6AkuOhuFiu4s4=;
	b=x3zhlglKugOZHh/8jqevJGboVKNatR63wSumiu5/Owbk2zc7qRqd7Ma23rmGSsEApLzt
	 ALNlm2DfGcZr55qjaVKDzAYAGoWHxa2WRdqglf9ndLksSfd37fl7+gbrTIgyzcTTpR34C
	 MGdgvyEdNS8y11v7huSctoZGxEpqKmDtFi8aDZYRiGvJ+efV0a3IfsbbpT9YngjjKWMyd
	 elf1UlBZ6SQZCnVuh0xTviU7BPAv6wZxhSytRwFFxxo4EgXQUvttZbUS+hfUpuPcGheSK
	 NQJ5lhbT/Boch7rtMyHDsTpy1S2WaEBzHCcUbZAM/PEAYhvkVjpS0B0hRQkq58Abk+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YcP3XglF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E901606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E901606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YcP3XglF
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c434376dbebso63069266b.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792719856; cv=none;
        d=google.com; s=arc-20260327;
        b=F5e7pz/cygHwoLzShvtxX+cgs1NawvFQvASuETomaxcrpY0/zgjC5n+lRb3dJjWvHy
         GVJf0xhSW8UFQUJtn+0l/Xd+USP0bvywdVWlpBGP/2q/ay38CSWEni/GtW0YnR/OOTCJ
         hArW9JSNZrfyfoPUhf5pHc0a0oHM0jHvT5H7QDjqotY/HKUsf9lz8QVFXG6Wib8J+h2g
         3d66+sqDfExPnDA/2y3LbT5m1ojzj9ftPIwN8LGuQnuSi2JV3L8/8CLlIJlHRwPS48gQ
         GP/vasm7RlltFbWGqJ3KPty01WTr66pZbO4ZI1syNhpSkaeeuQEoOhv0taQJdE7ewxmh
         qPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bx7dF6tVndjf82AHo9jgmtaUdmu9XT6AkuOhuFiu4s4=;
        fh=klcpWyuipqWx5KqsOM2czbc41tiBsizdYuGuBppt5as=;
        b=mpSwAA3Ne1jdWVEiqhPDjSvNEwTpE2UmSsH152nhn4IzJOYe2Hslcr4mwm9/MTJdS8
         XaoM1Yq2m64QJHn0KRUEGKHOpXDc0D3KH/dQA+6OINKYWMgJQ79x3v6GnkAqeq5lxZww
         MHueidsaXiL1hFs7NkZoAQO+qCBvQq/unbP/S760ZL23ylS/mGxjJ7N+FVTGi+mqkFa/
         PLWIzrQ+ckeBvg66QuMFf4lWF68nxGEJ0L0ONbA8z0DcDgZwcmpX1aH3PJon7jGUVCBV
         PLCP63OIiAxjiEgxLdWO/ydBhT83lWtGmekwUxemS17mz6QTL6V+nxdJXCVK+roLx6nh
         uXvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792719856; x=1793324656; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bx7dF6tVndjf82AHo9jgmtaUdmu9XT6AkuOhuFiu4s4=;
        b=YcP3XglFmnB+6Oyha5q5B3baw2Eh43povJp5ON2UxWjmC/pLsHVmooQ9R4Bj9CyKcA
         p4YHVvkYfygFNjeYp/uC0nHLS3i61dpXwIPmoI2TF6eHnA5n+duNcrZNvH/kc9e9co3G
         36BGSrLgUwAnPaxzK1LPrmKatDkl/Orxm6V4wNd9Te2QZenQ5iXpadJ15XWZVC4S4TIH
         MFff4E8RCZBWKVMMOOlE1apARj7KS/NwQT/PAjsMUluX6SrS3JTHiTzBKdltLuzOI7P7
         xS+fRvJHAs+1eV3Pcv2830RNpRqT5Wynf+zlvUdcgBCFz/Iu7eXziDz7v6P1GdA0C9/t
         WbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792719856; x=1793324656;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bx7dF6tVndjf82AHo9jgmtaUdmu9XT6AkuOhuFiu4s4=;
        b=F0l7XgYhXEdlttuTejpvSXBtggpMLyEhIiAugB/I+iPCSByVD25tBQT1y+fllQv2OJ
         APveGZ8HIhce4PRLFsSOHUsZjjw1mlPZ0QwhsD6EYV1l1WEdhQH/qSpdFUuMGP5xnSVF
         SmVRYm03GQm4I4fB7FirAQHSxnb66aZ9M0xzGpVOD02lBixfDkg+qea0hOJbolxThXZE
         fIJS2aIP8ASdGN/9xslrznovMBU8MXqZaYMGDw+sn+BmYWYzYIJb0ilzLfhx+StO9Os8
         hxY0y4Z4h+nl9ZjR8jMQyg4kfbfZ0d2AUOiW00nIMzAw7XubiOWigg7hHJ6KNOtiqCgJ
         wX+Q==
X-Gm-Message-State: AFq9FYI4/j5GPa7BtQ4zxhw/AaYHhC1H/xdGCxmUUny7Ltu/3dXArD0K
	vK6fWoPcsGPhHSZCTjCXDQ36pv4ARFbp1dXEa5ERvpxigGVNeY95owr6KS1JMGElHEfhINI+8/5
	2QAfjqcBkjNU/kQQ/mwo5BwD65bIRfTRjaQ53
X-Gm-Gg: AYBFou0QMSmUhPuBKTGHjId5IQW7NfmXcCk+0mBG8LmTpFhRu8YCgOGz6L+hMuYS1hV
	mTgPtPkEftYxNAIOf61s5dRfmrpnpC3w2sGgE55UiIgVwkW0XRaliXHoi+e0B23rLfU7DP/YPf7
	NY/v/tCrb2Xxcx4ps3AZueZy/HrSUhGRnaNkblNRZGmUEJrJo2M0rHwJXzr4dHoedEI5vYrm0us
	ev3sATrnYwp7d80kXyLVb/Xt2phVfvM07yKtfLJNsGJ1BwV2onZGI4TUpAe6r8t2AehxbkcXn7B
	dT/zjFlhLrJoGlRDb7u4pvCVfzrXN9vO0zDaAl2JdGMw/4n0gKAKl4vtBSaUWhGoUCncLtQrjY9
	Tf7RAio2OpnzMnH60nJfZGKaIAQJQVPlWdFE1cQ+fPyNuZ1Mk2qY5eHuaD+roKefggwe4TaNe/+
	yvPw==
X-Received: by 2002:a17:907:8995:b0:c42:bc58:f21 with SMTP id
 a640c23a62f3a-c46a924effdmr123828966b.15.1792719855641; Thu, 22 Oct 2026
 18:44:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?6aKY55uu6Ieq5ouf6Zev5aSp5rav?= <timuzini@gmail.com>
Date: Fri, 23 Oct 2026 09:44:04 +0800
X-Gm-Features: AclHuK_DN2NHJ13ffzan4W9MlsvmH6hpvERhg-dQF4WFCGEvYWhAYFZQeuIt-pM
Message-ID: <CAO6HOJyx5P4FyreE8rFpxroDwCOWLOpu1id4vvk_00x7YWEAGg@mail.gmail.com>
Subject: [BUG] net: stmmac: napi_disable() spins forever on enp2s0 close,
 deadlocking the whole rtnetlink layer
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com
Content-Type: text/plain; charset="UTF-8"

Hi Maxime, netdev,

I am hitting a hard machine hang on a Motorcomm YT8531S PHY behind the
dwmac-motorcomm/stmmac glue. The hang is inside napi_disable_locked(),
reached from stmmac_release() while NetworkManager tears the interface
down for a system hibernate. Because napi_disable() runs under
netdev_lock() and the entire call chain is inside rtnetlink context, the
rtnl_mutex is never released, and every netlink operation in the system
ends up blocked in D state. The box can only be recovered with a hard
power cycle.

It is 100% reproducible here as long as enp2s0 is administratively UP at
the moment a hibernate is requested.


Environment
-----------
  Distro : Ubuntu 24.04.4 LTS
  Kernel : 7.0.0-38-generic (Ubuntu 7.0.0-38.38~24.04.4-generic)
  NIC    : Motorcomm, PCI 0000:02:00.0
           dwmac-motorcomm 0000:02:00.0: User ID: 0x10, Synopsys ID: 0x52
           dwmac-motorcomm 0000:02:00.0: DWMAC4/5
           YT8531S Gigabit Ethernet stmmac-200:00
  Driver : st_gmac (stmmac + dwmac_motorcomm)
  Link   : no cable attached, interface still administratively UP
  WoL    : enabled at the time of the bug (ethtool: Wake-on: g)


Reproduction
------------
  ip link set enp2s0 up        # no cable needed
  systemctl hibernate          # NetworkManager stops the device

Result: NetworkManager hangs in stmmac_release -> napi_disable; every
ip/netlink user blocks; hard power-off required.


Hung task dump (live capture)
-----------------------------
  INFO: task Qt bearer threa:4035 blocked for more than 30 seconds.
  task:Qt bearer threa state:D stack:0 pid:4035 tgid:3927
  Call Trace:
   __mutex_lock
   rtnl_dumpit
   netlink_dump
   __netlink_dump_start
   rtnetlink_rcv_msg
   netlink_rcv_skb
   netlink_unicast
   netlink_sendmsg

  INFO: task Qt bearer threa:4035 is blocked on a mutex likely owned by
        task NetworkManager:1414.

  task:NetworkManager state:D stack:0 pid:1414 tgid:1414
  Call Trace:
   __schedule
   schedule
   schedule_hrtimeout_range_clock
   usleep_range_state
   napi_disable_locked+0xe9/0x100
   napi_disable+0x25/0x50
   __stmmac_disable_all_queues+0x96/0x100 [stmmac]
   __stmmac_release+0x83/0x2e0 [stmmac]
   stmmac_release+0x46/0x80 [stmmac]
   __dev_close_many
   __dev_change_flags
   netif_change_flags
   do_setlink
   __rtnl_newlink
   rtnl_newlink
   rtnetlink_rcv_msg
   netlink_rcv_skb
   netlink_unicast
   netlink_sendmsg
   __sys_sendmsg
   __x64_sys_sendmsg
   do_syscall_64


Analysis
--------
napi_disable_locked() has no timeout:

  void napi_disable_locked(struct napi_struct *n)
  {
          set_bit(NAPI_STATE_DISABLE, &n->state);
          val = READ_ONCE(n->state);
          do {
                  while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
                          usleep_range(20, 200);
                          val = READ_ONCE(n->state);
                  }
                  new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
                  ...
          } while (!try_cmpxchg(&n->state, &val, new));
  }

and napi_complete_done() bails out early without clearing SCHED when
NPSVC is set:

  bool napi_complete_done(struct napi_struct *n, int work_done)
  {
          if (unlikely(n->state & (NAPIF_STATE_NPSVC |
                                   NAPIF_STATE_IN_BUSY_POLL)))
                  return false;
          ...
  }

The call site orders PHY teardown before NAPI teardown:

  static void __stmmac_release(struct net_device *dev)
  {
          /* Stop and disconnect the PHY */
          phylink_stop(priv->phylink);          /* MAC goes down here */

          stmmac_disable_all_queues(priv);      /* -> napi_disable() */

          for (chan = 0; ...) hrtimer_cancel(...);

          netif_tx_disable(dev);

          /* Free the IRQ lines */
          stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
          ...
  }

Between phylink_stop() (which reaches stmmac_mac_link_down() and takes
the MAC down, so no further RX completion interrupts are generated) and
stmmac_free_irq(), there is a window where a NAPI instance can already be
scheduled with nothing left to advance it. napi_disable_locked() then
waits on a bit that nobody will clear.

The same helper is reached from stmmac_suspend():

  int stmmac_suspend(struct device *dev)
  {
          if (!ndev || !netif_running(ndev))
                  goto suspend_bsp;       /* DOWN -> safe */
          ...
          stmmac_disable_all_queues(priv);

so once the interface has been UP at any point, both
`ip link set enp2s0 down` and hibernate can hit this. Keeping the
interface DOWN avoids it entirely, which is consistent with a previous
hibernate on this same machine (with the NIC down) having succeeded.

The escalation to a system-wide deadlock comes from the new locking:

  void napi_disable(struct napi_struct *n)
  {
          netdev_lock(n->dev);
          napi_disable_locked(n);
          netdev_unlock(n->dev);
  }

The caller already holds rtnl_mutex
(rtnl_newlink -> do_setlink -> __dev_close_many -> ndo_stop), so a stuck
napi_disable() pins both locks and takes the whole netlink layer with it.


Workaround currently deployed
-----------------------------
  /etc/NetworkManager/conf.d/99-unmanaged-enp2s0.conf:
    [keyfile]
    unmanaged-devices=interface-name:enp2s0

plus WoL disabled and the interface kept DOWN. With that, hibernate
completes and the deadlock is not reachable.


Suggestion
----------
1) Please consider draining NAPI before tearing down the PHY, e.g.

        netif_tx_disable(dev);
        stmmac_disable_all_queues(priv);
        for (chan = 0; ...) hrtimer_cancel(...);
        phylink_stop(priv->phylink);
        stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
        stmmac_stop_all_dma(priv);

   (I have not tested this; you know the phylink ordering constraints
   far better than I do.)

2) Independently of the driver, an unbounded wait inside
   napi_disable_locked() with no diagnostic turns a single stuck
   interface into a whole-machine deadlock. Even a WARN + stack dump
   after N seconds would make this class of bug debuggable instead of
   requiring a power cycle.

The full hung task dump (2486 lines, all blocked tasks with complete
call traces) is available on request.


This machine is a disposable test box for this issue and I can reproduce
on demand, run ftrace/kprobe, or test patches.


Thanks,
Lidi Tian
