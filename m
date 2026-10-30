Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349341;
	b=KsDxVMg/gNB/5u5yZ5qBT8xgMzYAgErNUfkf2OHJzj/FHr2D7WbLz1hDw3s+u+2WY2r/
	 ctPArkcWDq5nAXccrl2KPHLLVh/5blIttA+Hwrj+v7kbm9L5aYv4QQn2XcxVfGS9nI3GB
	 WrnRTnZ6q6+l/vk3Clk8mfs9jHM38vWlERTm4FrprLwk5/+y5D4X3oUzY12Wzgw02qmF6
	 U86n2OSKCIL/BhzUikbWg0bRV2DPIoG9zg3Q4FqnYN6C3ImzONyTQsQl0rXN9CyPR/L1C
	 o8zepEdfC7mdP1/6u3Pz41+XuGhyhgZFXlCpSpuHByKgmLGMt/v4BAXz9VQLfU+ECEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=1JSuP/hmF6Fi8nJPp3ZX98qfwOmuW23quiYMNH551tA=;
	b=DmfAxQSOt6lMlB2kINsNIaeAYuVCGKh+ulbmznPRcKZtu3sd+PI7BDhsGtj97m3GmYuX
	 gRzh/z+R3r5K3FFa62sodbdX8AkDxN2eCxX75/oWfX3bBMSza22l9Hy27AsHMuaM7LK1l
	 /AD83ytFz4Tsn6HsGUsbTJ4syVVTl+diGZgMsyGowT7I4YzMUOFTWLIOafvJe7pLjDwGT
	 6WLEBahx/yAN+fJBIq3VIb+KMzLX388xnSszUE1bBDSQJnYXsGbZ8lnGwxn5XVkNn3aQ3
	 ntrqHlZ/kXRL7Cv8zezDiyHPT0oM5tLEp7Pm2peMpNLtuvvHeq3hiozUc6U5sU26rdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TEQEPlAo;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44F606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E44F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TEQEPlAo
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1104438eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793349340; x=1793954140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JSuP/hmF6Fi8nJPp3ZX98qfwOmuW23quiYMNH551tA=;
        b=TEQEPlAoekXBpR64xw57LwD2ebFmB5ASh9F10Af3Eexq/jhfRBlWp8Xjgjr+8t2hzI
         Hci1wSvBAfJSTu61TvVMVuL0zeJbcikoNGRoLv+x1wJDGc9k4KAEC/n3xjCsfbVbBayk
         OMeydaxNn66VWh4NcdetcFvLgkX4hbP45qror+4ZwqCnAfddETW4j2cH1XKCQQ4ptuJX
         0S24WZHdjqIhcEfEkMlz/xwCzWurZqEZnMAYB0NB1Pn0KvTSASThh+qBWJaZl8D9Y5Mf
         OnU8EugU29v1ictQa+McfRjXGHc33JKso4hRLLHkJ7Bqy9PF5UjpSa3V7luBGcPai4PV
         tCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349340; x=1793954140;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JSuP/hmF6Fi8nJPp3ZX98qfwOmuW23quiYMNH551tA=;
        b=nRQE4fsNL77yfwrur8P811OZnrC29Paz721zYzkAH0wmg11RHs/FBMLBlMaiGtxeXh
         fNODXWFlSJNInnQnKGdRT5t6juooyfxkAm7vOAP3de/wlYUSQh2zlZlxw+ZhteqJWleq
         wr+E5eih35/kRyisqnlxb8iJBDONxsMOQ1uSySyMTXSscrNcM7FB6JdkrlvGHzRF91vx
         wAH387jD6oln/jki7nznKjrf59Ct620SqQVp84yy3h3DlS4tUfDt/bbtnu4f5PCmza8d
         3+2w3B9A5C0BZk6l1Ou+45CDTx1byu2dKo3aUL6tcQem+4vkHRiYTvb6b5hGp+7NxFOS
         0EFA==
X-Gm-Message-State: AFq9FYJ15KPiJRdQRokQCbSoefSk6gCoLsajKRbWNGZLm0mxxSPSwUoe
	JEPXdkflt4A38CY3PsGSEn5MN7/pYZ/KkVHX93DQFoTM/EbQQTgTQWLg+MeTlrPXQYH8Op2398x
	/caOcPq9iAww/eWAxJTDri1Ecc1Ic1SrY7X+N7cCJ9JkPKlex4Ebq+6yrCiX1sm1sjUEBqwr1Ua
	s4D0ke74lFWY/1XX45EvFYseBm/v0wRM3h2FropQiQVZy+v697unmIwIZ2es0UIVI=
X-Received: from dybnj7.prod.google.com ([2002:a05:7300:d087:b0:369:fc78:c914])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4543:b0:353:5d0a:dba4 with SMTP id 5a478bee46e88-36a4248a4bcmr2685687eec.36.1793349339731;
 Fri, 30 Oct 2026 01:35:39 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:35:34 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030083539.777877-1-almasrymina@google.com>
Subject: [PATCH net v5 0/4] net: devmem: fix RX and TX binding teardown on
 device unregistration
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Taehee Yoo <ap420073@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Fix two device-unregistration lifecycle bugs in devmem TCP bindings and
add netdevsim support plus selftests covering both RX and TX device
unregistration. These issues were found via LLM-assisted code review
(Sashiko) and reproduced and verified with the new nl_netdev.py
selftests on netdevsim (not tested on real hardware):

1. net: devmem: unmap dma_buf synchronously on queue uninstall
   Synchronously unmap and detach binding->attachment under binding->lock
   when the last RX queue is uninstalled in mp_dmabuf_devmem_uninstall()
   or closed in net_devmem_unbind_dmabuf(), and unmap remaining unbound RX
   bindings on NETDEV_UNREGISTER, preventing slab-use-after-free in
   dma_unmap_sg_attrs() when the binding is freed after dma_dev. Factor
   out net_devmem_lock_dev() and net_devmem_unlock_dev() to synchronize
   netdev_nl_sock_priv_destroy() and __net_devmem_dmabuf_binding_free()
   against NETDEV_UNREGISTER.

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
Cc: Stanislav Fomichev <sdf@fomichev.me>

---
v5:
- Rebase onto net after the net-next merge and state how the issues were
  discovered and tested (Jakub).
- 1/4: Inline net_devmem_dev_unregister_rx() into
  net_devmem_dev_unregister() (Stanislav). Factor out
  net_devmem_lock_dev() and net_devmem_unlock_dev() and clear binding->dev
  after unmapping and re-acquiring the xarray lock so
  __net_devmem_dmabuf_binding_free() cannot free the binding while
  net_devmem_dev_unregister() is still accessing it, and reject RX devmem
  net_iovs in validate_xmit_unreadable_skb() (Sashiko).
- 2/4: Inline the TX unregistration check into net_devmem_dev_unregister()
  (Stanislav), clear binding->vdev under the xarray lock, and lock
  binding->dev in __net_devmem_dmabuf_binding_free() for TX bindings as
  well (Sashiko).
- 3/4: Configure the DMA mask and dma_parms in nsim_bus_probe() gated on
  dma_pci_p2pdma_supported(), require PP_DMA_INDEX_BITS before setting
  PP_FLAG_DMA_MAP, check for NULL ns->rq in nsim_pp_hold_write(), and drop
  unreadable or net_iov skbs at the start of nsim_start_xmit() (Sashiko).
- 4/4: Tolerate non-UTF-8 dma-buf names in debugfs bufinfo (Sashiko).
- Link to v4: https://lore.kernel.org/netdev/20261015163915.1166043-1-almasrymina@google.com/

v4:
- 1/4: Unmap RX bindings in net_devmem_unbind_dmabuf() once their queues
  are closed, and make netif_mp_close_rxq() report queue restart
  failures, so the NETDEV_UNREGISTER walk only handles bindings whose
  queue failed to restart. Drop net_devmem_lock: walk the bindings under
  the xarray lock and take the instance lock of binding->dev in the
  final free. (Stanislav) Record a queue in bound_rxqs before opening
  it. (Sashiko)
- 2/4: Detach and unmap TX bindings directly from the walk, without a
  grace period or a second pass. (Stanislav)
- Link to v3: https://lore.kernel.org/netdev/20261014161754.3782346-1-almasrymina@google.com/

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

 drivers/net/netdevsim/bus.c              |   9 ++
 drivers/net/netdevsim/netdev.c           |  33 ++++-
 drivers/net/netdevsim/netdevsim.h        |   1 +
 include/net/page_pool/memory_provider.h  |   4 +-
 net/core/dev.c                           |   4 +-
 net/core/devmem.c                        | 181 +++++++++++++++++++----
 net/core/devmem.h                        |  37 ++++-
 net/core/netdev-genl.c                   |  16 +-
 net/core/netdev_rx_queue.c               |  26 ++--
 tools/testing/selftests/net/config       |   4 +
 tools/testing/selftests/net/nl_netdev.py | 125 +++++++++++++++-
 11 files changed, 373 insertions(+), 67 deletions(-)


base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9
-- 
2.56.0.385.gac671c819a-goog

