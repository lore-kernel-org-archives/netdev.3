Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F633F582
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755842; cv=none; b=fKVnBgr70jqhbGHUhAZQkBwHKMFUx5F2nY+da0CMgf2SBsqYrz+BsI0ZGFALbvP4oF/RYcUg1KhDsiHBPReeJuQhiGGp848fhLaxv06pR7IQcxiSS1RCWedwrepixObthxJ+LgHwlkVUVDjx/q1GBRtIOzeI33AjcsQzd/AYKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755842; c=relaxed/simple;
	bh=nHcUJNNu07MGOKw2mCADQ1Pxc+9S1wVTqPW9hJgfLLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzYmRnqYzz8jg1GTb6LISs+QuuorNQKW2X4TEEUbRYZH3p8KW7Rrd1qX+vkONH01TcfTBb5CIEN+3WdYQFqk7XH+/0GSEJc/JX7THw6IGGjol4Wn8IO7WG+8tEbcha+G/nelgt1jbHSmFLLUbCCATlYunvBe3xoaUma8Sa91cgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suzjOJVo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suzjOJVo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so35573835ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785755840; x=1786360640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k9Qhj+tDgktLaxxq1dFD1/v2+3ao0PR4W1kXJfiLXIE=;
        b=suzjOJVobsYrUcgUOB/IrAxLLmsbuHAe5goNDgNTfHEZjQn2PQerhU1pqd6Fp3deAV
         e4uoSEGmLpjhSK+2A8lY2kSoGqhANxk916V96JnAwowNXR8KuBbFPfuBIZl/08mOCuy+
         V3LRa2mfeVbZEtt7KELHMpjzTZZFt26g7M2WC7KewMJz2rxbzC75QiK+Tjcxive14/hZ
         Fx3BSO67DEH4nv+UO0+rXriMptSUelduGdCQK5PgIiuFD53vsrZp4IPaVwHwjfT7sn8o
         Mqj/4OxT/65F3RSTiGRR96dzP1WbYyHEoERcVvOwLAH71xG8x7gQNjH/hDxgci3WTLtx
         LQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785755840; x=1786360640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k9Qhj+tDgktLaxxq1dFD1/v2+3ao0PR4W1kXJfiLXIE=;
        b=kmR9pfjGBr0fShMJ6Sc1FrRJg/Yq49YkoGkXPS5/PQP0NqVusNKCHIJ5RLCPnZJHu6
         wh33/VtY7tEcpo/3jT3orKCQi1VC72J9v0NP/H46JWfEJ0qmfakfUtv4X8AErMkHGlwT
         o4Z7NNoKvr8CAHmmNiT0ePhf1G3dmceiKhW0ik5TEus/vGzd9cXs3OBkzHmzEC5BvTjk
         wh2z0FBrMF03f5cglFSe45Gr4H8TM2HwlB9Ba5vOBSQZXpysU2gPAJ5Hruyfjt52UmTj
         wyL8MLHXyeqQWhZ+/WallN6OCIHgplvUTtR1QVKCUnCHoeU2fHf7IZ3U2bl/tyewx00Z
         LJjA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8nADwtK80Ra3Y/KB6sR2TaAQfJrzI0QEHZ7UA3on2ad2UU4ls+DqR4bhORumXL5iYmHv2siU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDafRRBGLKfA0XVgNI7rIDMVIDsepqb2ZK3/xCU8kSSSTH+5yG
	5YhI+ShiAUfzNsmVziF74rSEL+5+ZkHOB6fHL8I8qHgujBlvW/p89k55
X-Gm-Gg: AR+sD11Tv6iey1Cp26lEwyvl568h/VtUR85IK3Z288YWycp5e+wfTmfAaz/ChcVn6HE
	SjlIkI7rTwrxgnUZku0JsXFBBkE44ET+wXKGdNHtH/6fIty6GkSSfUjs6hS/132OxuvM1z6G5aK
	g6pS+4L7WTbs3cHHsAbwgEg32wNqq7z4W5856D4AWSnbgIVs1HUFI6VUrsvRHlnuupiZNk74MDR
	uk0kCyD9Q2Lh39IN2R3ESzrLLxTZY3CRWxshXSNla/NTq8zskJ6AKTbE/lTZAhMbpnj+16i6WPL
	G+OQc4sXD1o5oZo3cSFBzVkq3ToY6b8FpILzfnCibvdt5K+NiHhIt/QuvRJ3XIkp2pVZK/DOjj7
	ZCuAsyxhBp8xHK1P0yFwBL8ULA+EOCD/FXXLWPV2Vy0K3gShiQJxtVI6BoHziQr36k6FRCFXvdx
	HxJh9ug0991d9mPTwIdEgYxGfNUwLxr21kJlcWA7tcTGG7lbOHBzCUfJo=
X-Received: by 2002:a17:902:e88f:b0:2cc:b480:28ba with SMTP id d9443c01a7336-2d0523fc45bmr95010295ad.44.1785755840099;
        Mon, 03 Aug 2026 04:17:20 -0700 (PDT)
Received: from omen-arch ([147.46.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5ac3dsm36655715ad.23.2026.08.03.04.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:17:19 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [WARN] net: lockdep reports false ABBA between netdev instance locks during batch unregister
Date: Mon,  3 Aug 2026 20:17:14 +0900
Message-ID: <20260803111714.98235-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We found a CONFIG_LOCKDEP warning in the netdev unregister path while
network namespaces are being cleaned up in batch.

The warning is:

WARNING: possible circular locking dependency detected
7.2.0-rc1-dirty #93 Not tainted

kworker/u8:2/38 is trying to acquire lock:
ffff888022d54d88 (&dev_instance_lock_key#15){+.+.}-{4:4}, at:
netdev_lock linux/include/linux/netdevice.h:2847 [inline]
unregister_netdevice_many_notify+0x541/0x2180 linux/net/core/dev.c:12400

but task is already holding lock:
ffff888116e10d88 (&dev_instance_lock_key#3){+.+.}-{4:4}, at:
netdev_lock linux/include/linux/netdevice.h:2847 [inline]
unregister_netdevice_many_notify+0x541/0x2180 linux/net/core/dev.c:12400

5 locks held by kworker/u8:2/38:
 #3: ffffffff986ea2e0 (rtnl_mutex){+.+.}-{4:4}, at:
 default_device_exit_batch+0xe1/0xa10 linux/net/core/dev.c:13079

Call Trace:
 unregister_netdevice_many_notify
 unregister_netdevice_many
 default_device_exit_batch
 cleanup_net
 worker_thread

The warning is triggered by the ops-locked close phase in
unregister_netdevice_many_notify():

list_for_each_entry(dev, head, unreg_list) {
	if (!(dev->flags & IFF_UP))
		continue;
	if (netdev_need_ops_lock(dev)) {
		list_add_tail(&dev->close_list, &close_head);
		netdev_lock(dev);
	}
	netif_close_many_and_unlock_cond(&close_head);
}
netif_close_many_and_unlock(&close_head);

This loop can accumulate multiple devices in close_head while their
per-device dev->lock mutexes are held. In this report, lockdep had already
recorded:

  dev_instance_lock_key#15 -> dev_instance_lock_key#3

and the current execution was trying to add the reverse dependency:

  dev_instance_lock_key#3 -> dev_instance_lock_key#15

The current stack is running under rtnl_mutex, and netdev_lock_cmp_fn()
also appears to intend to allow nested netdev locks under RTNL. However,
the two locks in this report are in distinct lockdep classes, so the
RTNL-based ordering exception does not prevent the cross-class ABBA report.

A possible way to avoid the warning is to make
netif_close_many_and_unlock_cond() always flush the accumulated close list
under CONFIG_LOCKDEP, instead of doing so only when lockdep depth exceeds
the limit:

static void netif_close_many_and_unlock_cond(struct list_head *close_head)
{
#ifdef CONFIG_LOCKDEP
	netif_close_many_and_unlock(close_head);
#endif
}

This keeps the non-CONFIG_LOCKDEP behavior unchanged, but makes
CONFIG_LOCKDEP skip batching in this close phase by flushing the close list
earlier.

This was found by our custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

Thanks,
Junseo Lim
