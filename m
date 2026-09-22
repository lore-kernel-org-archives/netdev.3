Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEC568FDC
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094902; cv=none; b=iAUGEGKU9qIFS0q5PSuSweGrKJWYrEmeVjrE17nyTtBlE6pgBslKYT2xEOzBMbHXqABSoXr1XwEPLAkNPTANMi8QBbG1hmyrZMEP0fdoNtCdNgXiayOqFkiscgk/WSKVqH9p0UYhT1i0k2jYSeeBqsDasM0y+PG09TvjJOH/MbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094902; c=relaxed/simple;
	bh=JDD1QTbldrDNibtCP4dfqZzSOLmaFp6aHkCbz6mJG3o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=awUmpKmCiFMRHD8rvOexJQVmWPE+0tV2HxLEcgp5nR8A9UPJTDaIhWwjO812LZHIjWXM+S8lWnVM031B/K+/EvQpE1mki4lMeXlaT+CbhO0DmtSvQzJdYdPTFgY6xVPxm7dhR4vhDExR6tAZIcMxzMR0PbroXTfWNDXNoEtcG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzFoI7HS; arc=none smtp.client-ip=209.85.219.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzFoI7HS"
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e7f98bcb9so1042226d6.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790094900; x=1790699700; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlPfX79/IDik1ickmsTEr2XenaPfTIA3uIqqF8+ssq0=;
        b=nzFoI7HSksJBrRfRBFyMRHZIfiw1DIQB+Rz5dKCv49oo6/EkXhTrBdyf3bVt1rq1BZ
         CK1aJjaSWK0iX5Jx0/G3027DJOs0MY+hmjYyrSaMLTU4el4WPLi2Vm56Cq/1J5uiVoJb
         /lfC6hJFpPIIsHF+J27p458URH67i6zkCTBK0G3FLSgu0P0u9TVypXp8Hj1Ysz3eyxVQ
         nB8/tSbVv0FHGDvqLbCC881NyD6j0AYqjhPq+BaDaQu9Vw7TBpvy5GKqobeyky2VQdDS
         nJSYyWlVFbntbzlpSZhB0gnDdmFc64CDn6/jVuH/p5DgyLrnBNb7YE5GnlN9CwVnHwP3
         jVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094900; x=1790699700;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tlPfX79/IDik1ickmsTEr2XenaPfTIA3uIqqF8+ssq0=;
        b=mpCRu+JA+WEhyq/EJ9cnjD4aYKkwaH5jD3C8TlPo2R7QBpn2bsbntLFxIqB0Jj+VJK
         BcRp6px3hMWeklS6tZrmmpV6c05NyGlSTJCI5sBInKaNUiXc00gTzfsx4C6Z5dHxR/TL
         B2usykMhixn5hhrB23ky0JjQA4Ve0GUsVQWRvyL0tJz9b+fj4JnPArf3N/YAofqJcDWL
         gzCBlwtAht6Npio/dDLWoE4vZFN4BYc215ubr/x9Qqak1lxqvjaQoMmcCAJDt17F0sSx
         VRzx/49zUrZ4DK9v7YGHEuYFH/P8mNxHCVhAgIOBoMNxodgH6krg7vtha+4gHFUy5z4s
         BrPg==
X-Forwarded-Encrypted: i=1; AKwUvBwsROwb9fYPo3JTJHqLQICl93lwt1oGrFWBlCqyzhy+mj7kheqze+0sNyq+6umpg//Ivz3MBsI=@vger.kernel.org
X-Gm-Message-State: AFuF++mgTGeDEG9BLrIgZVcEequHWr/gSUDgINvd5NbNUGJ/exHMk0pP
	XyOs7UzWkvVrOqkEQwMQfy0d+7KrgTVQcKzHEjScS6oUAxxYZnC63+JVgChx5d3GbI8bX0NtW4Z
	iojnrg3mVZq8/TA==
X-Received: from qvvm5.prod.google.com ([2002:a05:6214:2a5:b0:912:5a0e:86f5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3287:b0:912:455a:ba77 with SMTP id 6a1803df08f44-9140c2bb9c3mr2416226d6.9.1790094899551;
 Tue, 22 Sep 2026 09:34:59 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:34:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922163458.3900996-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] net: ethtool: make netdev_rss_key_fill()
 spread flows over all queues
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_rss_key_fill() hands drivers a uniformly random key. Because the
Toeplitz hash is linear over GF(2), a random key is singular for a given
header field and queue count with probability 1/2: flows differing only
in the low order bits of that field (such as a burst of consecutive
ephemeral ports) then cannot reach all RX queues. On one affected 16-queue
host, only 4 queues received traffic until the key was replaced.

Patch 1 synchronizes proc_do_rss_key() with netdev_rss_key_fill() using an
smp_wmb()/smp_rmb() pair and a boolean flag so readers of
/proc/sys/net/core/netdev_rss_key print zero bytes until the key is fully
populated.

Patch 2 keeps the key random but constrains 1008 of its 2048 bits so that,
at every 16-bit aligned position and for every power-of-two queue count up
to 256, consecutive values of a field ending there visit every queue once.
Applying the fixup on the 16-bit grid covers standard 2-tuple/4-tuple
hashes as well as encapsulated or bitmap-selected layouts (such as PSP
inner TCP ports at byte 78) without enumerating them in the core. The
fixup is a bijection onto the set of valid keys, and redraws in the ~1 in
5 case where two 32-bit windows a multiple of 8 bits apart alias.

Patch 3 adds RSS key, indirection table, and flow-hash reporting to
netdevsim so the selftest can exercise both the host key and ethtool
netlink RSS reporting in a virtual machine without hardware.

Patch 4 adds a selftest under tools/testing/selftests/drivers/net/rss_key.py
checking /proc/sys/net/core/netdev_rss_key and the live RSS key,
indirection table, and flow-hash layouts reported by a device via ethtool
netlink.

v2:
 - Fix reverse xmas tree in proc_do_rss_key() (Jakub)
 - Move netdev_rss_key and netdev_rss_key_fill() to net/ethtool/common.c (Jakub)
 - Drop the KUnit test patch (Jakub)
 - Add RSS reporting to netdevsim and fold the selftests into a single
   self-contained tools/testing/selftests/drivers/net/rss_key.py using
   ethtool netlink flow-hash reporting (Jakub)

Assisted-by: LLM

Eric Dumazet (4):
  net: synchronize proc_do_rss_key() with netdev_rss_key_fill()
  net: ethtool: generate RSS keys that spread flows over all queues
  netdevsim: support reporting RSS key, indirection table, and flow hash
    fields
  selftests: drivers: net: check the host and device RSS keys

 Documentation/networking/scaling.rst          |   9 +
 drivers/net/netdevsim/ethtool.c               |  53 +++
 drivers/net/netdevsim/netdevsim.h             |   3 +
 include/linux/netdevice.h                     |   1 -
 net/core/dev.h                                |   2 +
 net/core/sysctl_net_core.c                    |   7 +-
 net/ethtool/common.c                          | 174 +++++++++
 net/ethtool/ioctl.c                           |   9 -
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../testing/selftests/drivers/net/rss_key.py  | 343 ++++++++++++++++++
 10 files changed, 591 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/rss_key.py

-- 
2.55.0.1082.g2b9226bbc0-goog

