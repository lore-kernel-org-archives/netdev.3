Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C2353A62
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 04:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841942; cv=none; b=nU0bHqwR5yHZJmgWbzjKoKbFSPu4PhSQ6cZns02Xyj4yTsRKde3R1LrqCPXz0MrCa7zODDzqD6zYtNhqYfOs6Qt349SpZSjO0Me/suoKNhSeJsOtVDiGVInu+1OGXCd5dNyoccSBWLcSVN1/XlDAhnYsLFS/GTJOfWt94YW3TbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841942; c=relaxed/simple;
	bh=VkgZ2z71mZW+gISvKxoo1p1Ae9kUFIXiQXB2+37B+bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=do1SvpeWEg1L63cp+rkkB2Dzra2yJamnnVB10JNqcJUcyOHao5e+gv0T7M4wSsxo6qjBsuW2QiPWKF/7uGusV5QfXizy8WZpKMZwyzPQygpLD4i7KkfLatV57aIrpcYkkgvaG3r9TWrMsQCWpLbtfVxbf+M/LB/mSWx81mGavpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2XgMff1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2XgMff1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caced6038eso38075465ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 21:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788841940; x=1789446740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Sw3D1y3zjsW1riYaATFZMDrMCFKmp0phBD8508fQP4=;
        b=f2XgMff15/x80i15lJKurMNyOadpVbDF0KYTDdaBY0HsMkkuLoBh78AahGGqpUuITT
         NrKDTVrQW//4ypovuxMobv/dmI2+moNz8zXVFBXR3MRBd2J/fJss3tnBn+ND7Lo26i49
         cXH28b93SgXgQwzkM291gNOs7XldPJ/AIlNG073HdF7SVfex0o+y4j4xG2Wf5PUSK1Lc
         CZz7w2WsxCarPgRGHb98QGJy5F1Pbxtavu2NDZgxQknqKNazMGoQYTl7nzh+dPAWoLYF
         ZZOYpAivK30LT86b/gwjDENthePSzfKiMNcY1wvYIpu+PePfqtBRf+re0yJD/L8FjDpR
         /6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788841940; x=1789446740;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Sw3D1y3zjsW1riYaATFZMDrMCFKmp0phBD8508fQP4=;
        b=jv/kqaVPkjK4quXFHYwlW/w5SCq0vdkKblw00uxvWFyJB4L3R2Dcp5DJiHv7N4HbLl
         GRkkoX6TpIyl4kuEHEm6mDx311sL4jl57+tsfnyRLN8uX7VQ12tb3DuGA+IaW7m8k4IL
         vPLLxShuFQwlU3DEOkAKvfmChKEgAVvAh6qgCXHbq7WAWPEptXnDJjkoWsruPMbniJF0
         OxclVfa6zp+XOfkpomwHH62VaSmkpBW+J4PNWYtVJXspqCjZEp9qFJBg1p8hTwELWh08
         styvfskU298TVldxG6NeOddysObWQaTjLDjFk2l1ffh5LBhXQfAG4kNY3SQPNaD/WPcp
         jV6g==
X-Gm-Message-State: AFuF++n6tbnWC0Y47/CCWdJ2avgjwtRyZmLKATiakAVABduZjnyAEupf
	hSkoF3HdUsAhwNddXvSpdDAt9j5KzrSlWURx/N8ceovcT0Dacrz1jotkEojaas15sYs=
X-Gm-Gg: AYBFou2IYyOzJNTZxUT5JETryvJaoA6mIwnwJLjL+5qowhPUYkKnyTT4LbFamNK0M8o
	9e5GYzCqsVGyHvf5toiNFSn8uoAXFASPrQpX+0FmZZrloxpv0WKlUc4ps6kKRnSex85uuOXOJZW
	U3N/ggvB5qffR8f+nHfjUVEGttLxBp+MUDz8urISj7uitb+kWnLNAT+TwQonQR5+xDC5ur4Cz+K
	ckkI0k3qLhlpWxm+InWa93nQ1I4e7m1ISQ4IqCplORR8eR+1W3D/p0r5GeTzNNVaer7n3ymmguH
	88NsU6UCc/Qg3C9WJ3T9jIXFnKUN4jT7ie86M05gyLVFIvF/iXRwGZ8Iatzjjzk9kGnLU5cMJkJ
	iJV79Jziob2xtOw2QdfKL+mKHnMIS1PanA/XjqwNzi5xUQA5Rzr8WiehaT/VR6EEIs7J93EN3J/
	WTA98uSS6o12ZVs2cXC3A6W2ewU4tSrg4/sIGGjZ8PEFbFu3UclSEdyGpaLutrC1b2CCpGzWrZq
	1upRug=
X-Received: by 2002:a17:903:1247:b0:2d8:d4d2:d137 with SMTP id d9443c01a7336-2dafb136bd7mr279546925ad.19.1788841940035;
        Mon, 07 Sep 2026 21:32:20 -0700 (PDT)
Received: from spr1.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b57fsm52098875ad.24.2026.09.07.21.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:32:19 -0700 (PDT)
From: Hengbin Zhang <uqbarz@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: devmem: TX dma-buf binding UAF on netdev-genl socket close
Date: Tue,  8 Sep 2026 04:31:15 +0000
Message-Id: <20260908043115.216613-1-uqbarz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Up front: I'm not a kernel developer, just someone who reads net code on
the side, so please bear with me if I get some terminology or conventions
wrong.  I found this issue while looking at the netmem/devmem code, and
with some help from AI tooling I managed to reproduce it in QEMU and
manually confirm the crash — I do believe it's a real bug.  Still, treat
the analysis below as my best guess rather than a certainty.  Thanks a lot
for taking the time to review this!

One-line summary
================

A TX (DMA_TO_DEVICE) dma-buf binding created with NETDEV_CMD_BIND_TX stores
binding->dev without taking a netdev reference and never registers itself
with any RX queue of the device.  When the bound device is unregistered and
freed while the owning netlink socket is still open, closing the socket
makes netdev_nl_sock_priv_destroy() call netdev_hold()/netdev_lock() on the
already freed net_device -> use-after-free.  Confirmed with KASAN and by a
real page fault / kernel panic on the same code path (log below).

Environment
===========

- Kernel: v7.3.0-rc1-00515-g9f0346dcbea3 (commit 9f0346dcbea3), x86_64,
  with KASAN enabled; relevant config knobs are in the reproducer README
  (link below).
- Test setup: QEMU (TCG) guest, initramfs only.  The kernel image has one
  local, test-only addition: a small stub PCI driver (source in the
  reproducer link below).  No core net code was modified.

Steps to reproduce
==================

I reproduced this in a QEMU guest.  QEMU cannot emulate any of the in-tree
NETMEM_TX_DMA devices (bnxt/mlx5/gve/fbnic are real NICs), so I wrote a
tiny test-only stub PCI driver (source in the reproducer link below) that
provides the same device-side properties: a net_device with
netmem_tx = NETMEM_TX_DMA and a DMA-capable parent.  The bug lives in core
net code, not in the driver, so this scenario should equally apply to real
hardware — e.g. binding TX on a real netmem-TX NIC, then removing/unbinding
that NIC while the netlink socket stays open.

1. Build the stub driver from the gist into the kernel (CONFIG_STUBNET=y)
   or as a module, boot the guest with "-device edu".
2. Boot with the static "init" program from the gist (repro.c, run as
   PID 1 in an initramfs).  It performs, in order:
   a. DMA_HEAP_IOCTL_ALLOC on /dev/dma_heap/system -> dmabuf fd;
   b. NETDEV_CMD_BIND_TX on the stub device (ifindex + dmabuf fd) and keeps
      the netlink socket open; BIND_TX succeeds and returns a dmabuf id;
   c. writes "1" to /sys/bus/pci/devices/<bdf>/remove, i.e. unregisters and
      FREES the stub net_device (refcount drops to 1 in netdev_run_todo);
   d. closes the netlink socket.
3. Expected: closing the socket cleanly tears the binding down.
   Actual: use-after-free, see log below.  On a kernel without KASAN the
   same path takes a page fault and panics (second log excerpt below), so
   this is not a KASAN-only artifact.

KASAN log
=========

  stub0 ifindex = 2
  dmabuf fd = 4
  netdev family id=20 version=1
  nl got: type=20 ... genl cmd=15 plen=8      <- BIND_TX ok (dmabuf id)
  writing 1 to /sys/bus/pci/devices/0000:00:04.0/remove
  stub0 gone (unregistered); net_device should now be freed
  === CLOSING NETLINK SOCKET (expect UAF in netdev_hold) ===
  [   43.895794] BUG: KASAN: slab-use-after-free in
             netdev_nl_sock_priv_destroy+0x196/0x1c0
  [   43.896434] Read of size 8 at addr ffff888002f06580 by task init/1
  Call Trace:
   netdev_nl_sock_priv_destroy+0x196/0x1c0
   genl_release+0xee/0x190
   netlink_release+0x715/0x13a0
   __sock_release+0xa1/0x260
   sock_close+0x10/0x20
   __x64_sys_close+0x78/0xd0
  Allocated by task 1:
   __kvmalloc_node_noprof+0x202/0x5b0
   alloc_netdev_mqs+0x7e/0x1270
   stubnet_probe+0x120/0x3c0
  Freed by task 1:
   kfree+0x127/0x3b0
   device_release+0xc8/0x240
   kobject_put+0x101/0x1e0
   netdev_run_todo+0x5a5/0xd70
   unregister_netdev+0x104/0x180
   stubnet_remove+0x3f/0x60
   pci_device_remove+0xa6/0x180
   remove_store+0xcc/0xe0
  The buggy address belongs to the object ... which belongs to the cache
  kmalloc-4k of size 4096; freed 4096-byte region [ffff888002f06000,
  ffff888002f07000).

The kernel then continued in the same function and faulted for real:

  [   43.905270] BUG: unable to handle page fault for address: ffff8880b0ef9000
  [   43.927189] RIP: 0010:netdev_nl_sock_priv_destroy+0xad/0x1c0
  ...
  [   43.938987] Kernel panic - not syncing: Fatal exception

Analysis
========

The flaw is a four-step chain: BIND_TX stores a raw net_device pointer
without taking a reference; TX bindings never populate bound_rxqs; the
unregister cleanup that clears binding->dev only matches RX queues; so when
the socket is closed after the device was unregistered and freed,
netdev_nl_sock_priv_destroy() runs netdev_hold()/netdev_lock() on the freed
net_device.

1) Binding creation - raw pointer, no reference (net/core/devmem.c,
   net_devmem_bind_dmabuf(), DMA_TO_DEVICE = TX path):

    binding->dev = dev;              // raw store, NO netdev_hold()
    xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
    // TX path never calls net_devmem_bind_dmabuf_to_queue()
    // -> bound_rxqs stays EMPTY; the unregister cleanup (which matches
    //    queues) cannot see this binding

2) Device unregister - the only binding->dev clearing point is RX-only:

    // net/core/dev.c:12395 dev_memory_provider_uninstall()
    for (i = 0; i < dev->real_num_rx_queues; i++)
            __netif_mp_uninstall_rxq(&dev->_rx[i], &dev->_rx[i].mp_params);
            // scans the device's OWN RX queues only -> TX binding invisible

    // net/core/devmem.c:537 mp_dmabuf_devmem_uninstall() - the ONLY place
    // that clears binding->dev:
    WRITE_ONCE(binding->dev, NULL);  // reached only when a bound queue is
                                     // uninstalled (RX-only); never fires
                                     // for TX bindings

3) Free - the binding contributes zero references (net/core/dev.c):

    // netdev_wait_allrefs_any()/netdev_run_todo()
    if (netdev_refcnt_read(dev) == 1)    // no holder left; the binding holds
                                         // no reference either
            free_netdev(dev);            // net_device freed while the socket
                                         // and its binding are still alive

4) Socket close - teardown on freed memory (net/core/netdev-genl.c:1445,
   netdev_nl_sock_priv_destroy()):

    dev = binding->dev;              // RX: NULL (cleared in step 2);
                                     // TX: dangling
    if (!dev) { unbind; continue; }  // safe branch - never taken for TX
    netdev_hold(dev, ...);           // UAF #1: refcount/tracker increment on
                                     // the freed net_device
    netdev_lock(dev);                // UAF #2: mutex on freed memory

Full reproducer materials (stub driver source, trigger program, build/run
README and the complete serial log):
https://gist.github.com/hharryz/119f067937448ac6e30eb31e7f08dc5a

I'd be happy to keep testing, digging deeper into the analysis, and trying
to put together a possible fix if that helps.  Thanks a lot for your time!

Hengbin Zhang
