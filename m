Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD55218BB
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994683; cv=none; b=cftzhcG/7D75aWKXcO8h8Hf4bX7+UaDSVSmnGbrdiflT3vghyenL3MWKDhgl15XQoSlOS5e+NY0Msgdngd/jGQMEQEE0ZMMjKHXJOfMDSdWYEfPWt7fIXFW/Gmi3zdJb+SY5J+B+ZprK/x1h6nh2GrraZu5BsbvzEBhH2L72xS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994683; c=relaxed/simple;
	bh=J2MF0CGvDZI2j5xp2f4Y/WWR7jUQb6b1+xx9/N78hek=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I8ikr9XzB6UQfJtLerHKX4nw1QgxoagABLxe5/50Tt7oPr/QFmj2pdFyqoWdUjLKBnsMvWs+9eYYQmtzODtlra8ozijTTKwD1A2HoRIqdEs7kiYeXhvKICi4GNuF0OVAsW1xVMnOiBlh5c0E8CqarJKqvOOCPNiudnp1w+7bXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shVCgafj; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shVCgafj"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-155a75f91e1so705548c88.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791994676; x=1792599476; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BNYbIRDhdg/bji4iVF4z4GKSYuqq0SGaMYsIsVzbu+Y=;
        b=shVCgafj6S7XxdeceaVQhwMGAdCYXxntKgyPwAzI+goiDOwO+xHN+i3yPCmFLoF/+b
         0j3m4dWQPpJdUToFha/OJUg0wuNYaR0XReNsqaYBiZM412xsImvrfLhYPFIOhHOrbgJk
         918Cgw5aBQbLwCzAoDYFmHVnLGiXOtyT0s/cPl9RohPNc8wh1HfcICC7MkCe60TDWZHI
         SBpwvtWrHmF438drp/gn9qFJ98VyRkSS0rI73eKKMGWm9EnFQzuBnbH/LeKTaZec5HgQ
         E4l+30cQQXwEB0RWNJP1D+nsTwKI5ovLQ8iZUESA1Q/IhuaBVktxst4s6LwWypfYkb3m
         OxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791994676; x=1792599476;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNYbIRDhdg/bji4iVF4z4GKSYuqq0SGaMYsIsVzbu+Y=;
        b=Tk0+YQk/Vumtu4SqEnZYVx7/9pC7spuyyZOtZ0NRPWlmYFRaW6u9911lIF8LFelxrn
         J3hGRsaODG6gv1QEd9iexU0yvb0STVhTpm2g24JeEh26hMcuFrVzZxLW3iE0cORKuBQE
         Cl/cF7MikKmyC38xmV3nnOQWt9j1gavAm+Gbl1Lnk0DUCI9myCN9e1UKY7wQZHGRkzze
         twdsmiVdNAEaBp2EX+XkaHBwJLpVdyPeC8Z+86WvdbVW7P25YuTFO74s4Zad5h1iVDxi
         X4OpXq6OjAsL7fOuxM2XFTTGiLJAREXyZNuoZ9zt6pgKinHTsm7pZJhv0BjuzI+IaMmT
         Y0tQ==
X-Forwarded-Encrypted: i=1; AKwUvBybZGTMYuYwGe7dEOaznZnfaxbPH4XSshnM6KKxWWhiJ8OzyBULznLURoWFxfxQgGS7n84FmqQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFe7k2akkVSa2n5r1uuhlmZLx1UCLbkgauycDx9wRRCsHakZ+d
	J4G04Z6JfM2JIrPJuacLz0+tP2NZMp1yQHnBF1MfsuXrZJW35ggyWx71HEkC3rkYYa+L6mNQnhE
	6FMBTdSmsv0M/XdpUx/NX4ebxYA==
X-Received: from dli6-n1.prod.google.com ([2002:a05:7022:286:10b0:15e:bc16:429a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:c84:b0:146:5f73:d45b with SMTP id a92af1059eb24-16a54fab691mr20502668c88.3.1791994675581;
 Wed, 14 Oct 2026 09:17:55 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:17:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261014161754.3782346-1-almasrymina@google.com>
Subject: [PATCH net v3 0/4] net: devmem: fix RX and TX binding teardown on
 device unregistration
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
add netdevsim support plus selftests covering both RX and TX device
unregistration:

1. net: devmem: unmap dma_buf synchronously on queue uninstall
   Synchronously unmap and detach binding->attachment under binding->lock
   when the last RX queue is uninstalled in mp_dmabuf_devmem_uninstall(),
   and unmap RX bindings that were already unbound on NETDEV_UNREGISTER,
   preventing slab-use-after-free in dma_unmap_sg_attrs() when the binding
   is freed after dma_dev.

2. net: devmem: detach TX bindings on NETDEV_UNREGISTER
   Extend net_devmem_dev_unregister() to fully detach and unmap TX
   bindings when binding->dev unregisters, or clear binding->vdev alone
   when only a virtual device unregisters while binding->dev lives.

3. netdevsim: support devmem RX and TX bindings
   Enable PP_FLAG_DMA_MAP | PP_FLAG_ALLOW_UNREADABLE_NETMEM, 64-bit DMA mask
   on nsim_bus_dev, and NETMEM_TX_DMA on netdevsim so devmem RX/TX bindings
   can be exercised in software selftests.

4. selftests: net: add devmem RX and TX netdev unregister tests
   Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
   to tools/testing/selftests/net/nl_netdev.py.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>

---
v3:
- 1/4: Run the NETDEV_UNREGISTER walk under the netdev instance lock,
  and skip it when the device only moves to another netns. (Sashiko)
- 2/4: Detach all matching TX bindings, then synchronize_net() once
  before unmapping them. (Sashiko)
- 3/4: Only request page pool DMA mapping with CONFIG_HAS_DMA, refuse
  pp_hold on memory provider pools, and drop unreadable skbs in the
  software PSP checksum path. (Sashiko)
- 4/4: Check only the test's dma-buf in debugfs, skip instead of passing
  silently, clean up on errors, compute UDMABUF_CREATE per arch, and
  add the needed config options. (Sashiko, Dragos)
- Link to v2: https://lore.kernel.org/netdev/20261012174300.2338784-1-almasrymina@google.com/

v2:
- 1/4: Don't unmap when a leased queue is unleased. Keep bindings in
  net_devmem_dmabuf_bindings until freed, hidden from TX lookups by an
  xarray mark, and unmap unbound RX bindings on NETDEV_UNREGISTER. Update
  the binding->lock and binding->ref comments. (Sashiko)
- 2/4: Detach TX bindings from the same net_devmem_lock-protected walk,
  which now also covers unbound TX bindings, and clear the LIVE mark
  instead of erasing the ID. The walk no longer uses RCU or takes
  binding references (Stanislav).
- Link to v1: https://lore.kernel.org/netdev/20261010025532.839559-1-almasrymina@google.com/

Mina Almasry (4):
  net: devmem: unmap dma_buf synchronously on queue uninstall
  net: devmem: detach TX bindings on NETDEV_UNREGISTER
  netdevsim: support devmem RX and TX bindings
  selftests: net: add devmem RX and TX netdev unregister tests

 drivers/net/netdevsim/bus.c              |   1 +
 drivers/net/netdevsim/netdev.c           |  27 ++++-
 drivers/net/netdevsim/psp.c              |   5 +
 net/core/devmem.c                        | 143 ++++++++++++++++++++---
 net/core/devmem.h                        |  10 +-
 net/core/netdev-genl.c                   |   1 +
 tools/testing/selftests/net/config       |   4 +
 tools/testing/selftests/net/nl_netdev.py | 125 +++++++++++++++++++-
 8 files changed, 290 insertions(+), 26 deletions(-)


base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
-- 
2.56.0.176.g3575e65682-goog

