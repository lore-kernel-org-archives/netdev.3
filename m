Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29382E92BA
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918000; cv=none; b=FRDhvDgRgy4C5lud0Is2LPB+AFsBmYN+3abrqmsXDKmGyBXIL+CywiAF/Mv+BUIdSk5NC6/MHLVz8InMaAINrV3g06Omo12NfAPCA8YyNHoviwIEbWzu+1IF2ZXML+pijaRNws9nhuHumnDwsiOXE6LBpZ0MFuM3mi1Yr6sQvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918000; c=relaxed/simple;
	bh=/v3aot4tN6dMR++tQRZbQuW8pFdfkH35K8lemMWxNbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL7JPg7n9kfTNlM5gy2tJ4PEYcl3FgtR6WJcv/Mt2+r8NblmKdHzQxvFS/wpCpLWtKF+WcBxSNgVlaBRZBKgDi/FoV8v4iijoBfkk5uoj9a9hgDRHWM0O9WbfTUPfIYfwdq8wIDnJRwhj+gaLGJfUvP5mPGliGuI25qK9Lh+qfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+Ce66Rr; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+Ce66Rr"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2dae660f31bso35637985ad.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 18:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788917997; x=1789522797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uSFtGGGcYJsTpJMCffAGX5T1+grywHvvw/WB/JJ1UOc=;
        b=I+Ce66RrJkF2uvxPG3/I6W6SWWhDv4CF8GUZBFbo5v1qcm3/cGe/Ay3E9od/+3tji5
         imqIy6g9R/lhfVslseQ0BIpk/bgxjJV0D3k7pmTgcPHJZwQSed0d1epom0cJ3vFt3Ob9
         mEayg7thQyJlUqWNHQxXj7zlrFzVsMU6oBB2IisdZ0s5kGnycuwJMPTEgHb/Y2ZCGipj
         SrYDQNm4vedL3lmrBeCn6oRWiiz+o7b0FYbDf4QZgD5zrKrZgWvRmuQQ0+XM8GwG6aSw
         qybPUkYrgFsPDfesRIys620biT7SpLgi1js6pg2JrkLx6iX4OSEAiUYA1dcNXTeHlcUW
         K/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788917997; x=1789522797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uSFtGGGcYJsTpJMCffAGX5T1+grywHvvw/WB/JJ1UOc=;
        b=LCwgKM2pPtkqLxQ0z8uvSR7nxx8Dqtoh600O1I3qYbwU7Qj2PAXivl4lqjhcg2OFRF
         WhiRu80OKFTIQNJEu70/Jn031gYLvoaesbHT1xSFSm3otspopIIqJ9B6u6Hi5oDKkTqn
         Gg12teZU1Vd7hZ8wAT09H1qTWLgTpQs8k9iFBLwUv52uoy8SSaWJ5bDQtWoptakzt9Ky
         QX+PCvL5/MqKdodj6RyGUXOmFn5J85FQNt+UyaA8FmSkQtKS4/dylsMzJZReW+rNcvGE
         aoQvRwf48lAdK8JMl7o4NXJuvfoQ375FiBRe9arlGce4doVoE/hvQi1dXXWpNnbFgUwg
         vd0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxG5Vc8mc2HzUCQ7+Pe9LIV48gSKfTfEfi9jJ1qJ9pyupRfE9Ht6mO4CV/wDWyhS04CXhCxH2w=@vger.kernel.org
X-Gm-Message-State: AFuF++mQfdQbWTBHpmxsxNmBU10g+IdnRvgLtn7h7GSdXoyG4ByKzRmW
	T2t8sEUlLya7nFYu53VbSjfeHIe5I9YyQ0lucazFBE0Lbztm/EPDc2vw
X-Gm-Gg: AYBFou21XTpEcNnxI/B0KIME5Lwl65iNu58rj3WYf3i3hzCrLNDn4rpWIHZJLn9Od2x
	RCftg8CnbAJwI0e8XYWBAI9B4EDNnHMLiiGDF0IAhr86jkmkvDzk0t+j0WoEsIIqk1WW/dsSTUf
	zKQwWle73Yftl2g7EhXEQCudNn6/Ko3czVglRmQeWV7aIPQJPbykbmGP4LZE/y2cbWpwZdglzPQ
	hcVx0JsSO1OqU8v8IfjqkTndgDu5JwM+Nbm8iM3t/N/6ekyDwgxRzVDlRWl/Q2tM1/IvfVK5pXy
	1KWAwaXmvzU2HERshxZG+J6I/uz9clt2zd8h4+dJvVJvwlEut/sO/K1Y33EnAHGco3aIjPuGo0I
	uzJT3uQEVpRwcMiOBvLgim1Womqt4VgMNut+0hgEPD3aU7Ynfhr75B7VWJ4NUklC7ETH3yu2tgU
	lgcUJGP+oIPCmY+ngCErYNnIz10MdDOZBKCdAQjwg7btRcF8OJ1U+/WCYekTH6x7p2
X-Received: by 2002:a05:6a20:72a0:b0:3c3:8d86:9855 with SMTP id adf61e73a8af0-3dabb068e5amr3640982637.7.1788917996941;
        Tue, 08 Sep 2026 18:39:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc464393760sm4991145a12.3.2026.09.08.18.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 18:39:56 -0700 (PDT)
Date: Tue, 8 Sep 2026 18:39:50 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Hengbin Zhang <uqbarz@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Taehee Yoo <ap420073@gmail.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] net: devmem: TX dma-buf binding UAF on netdev-genl socket
 close
Message-ID: <aqC4XSt7JrrTv4sG@devvm7509.cco0.facebook.com>
References: <20260908043115.216613-1-uqbarz@gmail.com>
 <aqBFxdzPnFmW36_J@devvm7509.cco0.facebook.com>
 <CAHS8izPN6P4=CKFZkowo+t2tx=nu5Q8JjVdZ=_c3eMrMG=9LxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPN6P4=CKFZkowo+t2tx=nu5Q8JjVdZ=_c3eMrMG=9LxA@mail.gmail.com>

On 09/08, Mina Almasry wrote:
> On Tue, Sep 8, 2026 at 10:35 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 09/08, Hengbin Zhang wrote:
> > > Hi all,
> > >
> > > Up front: I'm not a kernel developer, just someone who reads net code on
> > > the side, so please bear with me if I get some terminology or conventions
> > > wrong.  I found this issue while looking at the netmem/devmem code, and
> > > with some help from AI tooling I managed to reproduce it in QEMU and
> > > manually confirm the crash — I do believe it's a real bug.  Still, treat
> > > the analysis below as my best guess rather than a certainty.  Thanks a lot
> > > for taking the time to review this!
> > >
> > > One-line summary
> > > ================
> > >
> > > A TX (DMA_TO_DEVICE) dma-buf binding created with NETDEV_CMD_BIND_TX stores
> > > binding->dev without taking a netdev reference and never registers itself
> > > with any RX queue of the device.  When the bound device is unregistered and
> > > freed while the owning netlink socket is still open, closing the socket
> > > makes netdev_nl_sock_priv_destroy() call netdev_hold()/netdev_lock() on the
> > > already freed net_device -> use-after-free.  Confirmed with KASAN and by a
> > > real page fault / kernel panic on the same code path (log below).
> > >
> > > Environment
> > > ===========
> > >
> > > - Kernel: v7.3.0-rc1-00515-g9f0346dcbea3 (commit 9f0346dcbea3), x86_64,
> > >   with KASAN enabled; relevant config knobs are in the reproducer README
> > >   (link below).
> > > - Test setup: QEMU (TCG) guest, initramfs only.  The kernel image has one
> > >   local, test-only addition: a small stub PCI driver (source in the
> > >   reproducer link below).  No core net code was modified.
> > >
> > > Steps to reproduce
> > > ==================
> > >
> > > I reproduced this in a QEMU guest.  QEMU cannot emulate any of the in-tree
> > > NETMEM_TX_DMA devices (bnxt/mlx5/gve/fbnic are real NICs), so I wrote a
> > > tiny test-only stub PCI driver (source in the reproducer link below) that
> > > provides the same device-side properties: a net_device with
> > > netmem_tx = NETMEM_TX_DMA and a DMA-capable parent.  The bug lives in core
> > > net code, not in the driver, so this scenario should equally apply to real
> > > hardware — e.g. binding TX on a real netmem-TX NIC, then removing/unbinding
> > > that NIC while the netlink socket stays open.
> > >
> > > 1. Build the stub driver from the gist into the kernel (CONFIG_STUBNET=y)
> > >    or as a module, boot the guest with "-device edu".
> > > 2. Boot with the static "init" program from the gist (repro.c, run as
> > >    PID 1 in an initramfs).  It performs, in order:
> > >    a. DMA_HEAP_IOCTL_ALLOC on /dev/dma_heap/system -> dmabuf fd;
> > >    b. NETDEV_CMD_BIND_TX on the stub device (ifindex + dmabuf fd) and keeps
> > >       the netlink socket open; BIND_TX succeeds and returns a dmabuf id;
> > >    c. writes "1" to /sys/bus/pci/devices/<bdf>/remove, i.e. unregisters and
> > >       FREES the stub net_device (refcount drops to 1 in netdev_run_todo);
> > >    d. closes the netlink socket.
> > > 3. Expected: closing the socket cleanly tears the binding down.
> > >    Actual: use-after-free, see log below.  On a kernel without KASAN the
> > >    same path takes a page fault and panics (second log excerpt below), so
> > >    this is not a KASAN-only artifact.
> > >
> > > KASAN log
> > > =========
> > >
> > >   stub0 ifindex = 2
> > >   dmabuf fd = 4
> > >   netdev family id=20 version=1
> > >   nl got: type=20 ... genl cmd=15 plen=8      <- BIND_TX ok (dmabuf id)
> > >   writing 1 to /sys/bus/pci/devices/0000:00:04.0/remove
> > >   stub0 gone (unregistered); net_device should now be freed
> > >   === CLOSING NETLINK SOCKET (expect UAF in netdev_hold) ===
> > >   [   43.895794] BUG: KASAN: slab-use-after-free in
> > >              netdev_nl_sock_priv_destroy+0x196/0x1c0
> > >   [   43.896434] Read of size 8 at addr ffff888002f06580 by task init/1
> > >   Call Trace:
> > >    netdev_nl_sock_priv_destroy+0x196/0x1c0
> > >    genl_release+0xee/0x190
> > >    netlink_release+0x715/0x13a0
> > >    __sock_release+0xa1/0x260
> > >    sock_close+0x10/0x20
> > >    __x64_sys_close+0x78/0xd0
> > >   Allocated by task 1:
> > >    __kvmalloc_node_noprof+0x202/0x5b0
> > >    alloc_netdev_mqs+0x7e/0x1270
> > >    stubnet_probe+0x120/0x3c0
> > >   Freed by task 1:
> > >    kfree+0x127/0x3b0
> > >    device_release+0xc8/0x240
> > >    kobject_put+0x101/0x1e0
> > >    netdev_run_todo+0x5a5/0xd70
> > >    unregister_netdev+0x104/0x180
> > >    stubnet_remove+0x3f/0x60
> > >    pci_device_remove+0xa6/0x180
> > >    remove_store+0xcc/0xe0
> > >   The buggy address belongs to the object ... which belongs to the cache
> > >   kmalloc-4k of size 4096; freed 4096-byte region [ffff888002f06000,
> > >   ffff888002f07000).
> > >
> > > The kernel then continued in the same function and faulted for real:
> > >
> > >   [   43.905270] BUG: unable to handle page fault for address: ffff8880b0ef9000
> > >   [   43.927189] RIP: 0010:netdev_nl_sock_priv_destroy+0xad/0x1c0
> > >   ...
> > >   [   43.938987] Kernel panic - not syncing: Fatal exception
> > >
> > > Analysis
> > > ========
> > >
> > > The flaw is a four-step chain: BIND_TX stores a raw net_device pointer
> > > without taking a reference; TX bindings never populate bound_rxqs; the
> > > unregister cleanup that clears binding->dev only matches RX queues; so when
> > > the socket is closed after the device was unregistered and freed,
> > > netdev_nl_sock_priv_destroy() runs netdev_hold()/netdev_lock() on the freed
> > > net_device.
> > >
> > > 1) Binding creation - raw pointer, no reference (net/core/devmem.c,
> > >    net_devmem_bind_dmabuf(), DMA_TO_DEVICE = TX path):
> > >
> > >     binding->dev = dev;              // raw store, NO netdev_hold()
> > >     xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
> > >     // TX path never calls net_devmem_bind_dmabuf_to_queue()
> > >     // -> bound_rxqs stays EMPTY; the unregister cleanup (which matches
> > >     //    queues) cannot see this binding
> > >
> > > 2) Device unregister - the only binding->dev clearing point is RX-only:
> > >
> > >     // net/core/dev.c:12395 dev_memory_provider_uninstall()
> > >     for (i = 0; i < dev->real_num_rx_queues; i++)
> > >             __netif_mp_uninstall_rxq(&dev->_rx[i], &dev->_rx[i].mp_params);
> > >             // scans the device's OWN RX queues only -> TX binding invisible
> > >
> > >     // net/core/devmem.c:537 mp_dmabuf_devmem_uninstall() - the ONLY place
> > >     // that clears binding->dev:
> > >     WRITE_ONCE(binding->dev, NULL);  // reached only when a bound queue is
> > >                                      // uninstalled (RX-only); never fires
> > >                                      // for TX bindings
> > >
> > > 3) Free - the binding contributes zero references (net/core/dev.c):
> > >
> > >     // netdev_wait_allrefs_any()/netdev_run_todo()
> > >     if (netdev_refcnt_read(dev) == 1)    // no holder left; the binding holds
> > >                                          // no reference either
> > >             free_netdev(dev);            // net_device freed while the socket
> > >                                          // and its binding are still alive
> > >
> > > 4) Socket close - teardown on freed memory (net/core/netdev-genl.c:1445,
> > >    netdev_nl_sock_priv_destroy()):
> > >
> > >     dev = binding->dev;              // RX: NULL (cleared in step 2);
> > >                                      // TX: dangling
> > >     if (!dev) { unbind; continue; }  // safe branch - never taken for TX
> > >     netdev_hold(dev, ...);           // UAF #1: refcount/tracker increment on
> > >                                      // the freed net_device
> > >     netdev_lock(dev);                // UAF #2: mutex on freed memory
> > >
> > > Full reproducer materials (stub driver source, trigger program, build/run
> > > README and the complete serial log):
> > > https://gist.github.com/hharryz/119f067937448ac6e30eb31e7f08dc5a
> > >
> > > I'd be happy to keep testing, digging deeper into the analysis, and trying
> > > to put together a possible fix if that helps.  Thanks a lot for your time!
> >
> > Hmm, this looks legit, I don't think we have a proper test for this
> > condition :-/ I can try to take a stab unless someone else volunteers.
> 
> Yes I'll volunteer to clean up my mess :P
> 
> My pet LLM suggested this not-yet-tested change:
> https://termbin.com/e4d2. It's trying to detect if there is a tx
> binding attached to the netdev at unregister time and clears it.
> 
> Let me try to understand the bug report and try to repro + verify it
> etc, but Hengbin, thank you for the report and if it's easy for you to
> test this fix please try to. Thanks!

It's a netdev removal before closing a socket with a bound tx. The
following down below consistently triggers it with fbnic qemu. Thinking
maybe we should add it to the selftests?


diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 82c11ffc4add..643f891b468d 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -1,11 +1,136 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import fcntl
+import json
+import os
+import socket
+import struct
+import time
 from os import path
+
 from devmem_lib import (setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds,
                         run_rx_large_niov)
 from lib.py import ksft_run, ksft_exit, ksft_disruptive
-from lib.py import NetDrvEpEnv
+from lib.py import cmd, defer, wait_file
+from lib.py import ksft_eq, KsftFailEx, KsftSkipEx
+from lib.py import NetdevFamily, NetDrvEpEnv, NlError
+
+
+UDMABUF_DEV = "/dev/udmabuf"
+# UDMABUF_CREATE, _IOW('u', 0x42, struct udmabuf_create)
+UDMABUF_CREATE = (1 << 30) | (24 << 16) | (ord('u') << 8) | 0x42
+UDMABUF_SIZE = 1 << 20
+
+KEEP_ADDR_ON_DOWN = "/proc/sys/net/ipv6/conf/{}/keep_addr_on_down"
+
+
+def _udmabuf_alloc(size):
+    if not path.exists(UDMABUF_DEV):
+        raise KsftSkipEx("Test requires udmabuf")
+
+    memfd = os.memfd_create("devmem-tx", os.MFD_ALLOW_SEALING)
+    try:
+        os.ftruncate(memfd, size)
+        fcntl.fcntl(memfd, fcntl.F_ADD_SEALS, fcntl.F_SEAL_SHRINK)
+        with open(UDMABUF_DEV, "rb") as dev:
+            create = bytearray(struct.pack("IIQQ", memfd, 0, 0, size))
+            dmabuf_fd = fcntl.ioctl(dev.fileno(), UDMABUF_CREATE, create)
+    except OSError as exc:
+        os.close(memfd)
+        raise KsftSkipEx(f"Test requires udmabuf: {exc}") from exc
+
+    return dmabuf_fd, memfd
+
+
+def _pci_dev(cfg):
+    dev_link = f"/sys/class/net/{cfg.ifname}/device"
+    if not path.exists(dev_link):
+        raise KsftSkipEx("Test requires a device which can be unregistered")
+
+    bdf = path.basename(path.realpath(dev_link))
+    if not path.exists(f"/sys/bus/pci/devices/{bdf}"):
+        raise KsftSkipEx("Test requires a PCI device")
+
+    driver = path.basename(path.realpath(f"{dev_link}/driver"))
+    if not path.exists(f"/sys/bus/pci/drivers/{driver}"):
+        raise KsftSkipEx("Test requires a PCI driver which can be unbound")
+
+    return bdf, driver
+
+
+def _pci_unbind(bdf, driver):
+    with open(f"/sys/bus/pci/drivers/{driver}/unbind", "w",
+              encoding="utf-8") as fp:
+        fp.write(bdf)
+
+
+def _pci_bind(bdf, driver):
+    if path.exists(f"/sys/bus/pci/devices/{bdf}/driver"):
+        return
+    with open(f"/sys/bus/pci/drivers/{driver}/bind", "w",
+              encoding="utf-8") as fp:
+        fp.write(bdf)
+
+
+def _netdev_by_pci(bdf):
+    for name in os.listdir("/sys/class/net"):
+        dev_link = f"/sys/class/net/{name}/device"
+        if not path.exists(dev_link):
+            continue
+        if path.basename(path.realpath(dev_link)) == bdf:
+            return name
+    return None
+
+
+def _netdev_config_get(cfg):
+    link = json.loads(cmd(f"ip -j addr show dev {cfg.ifname}").stdout)[0]
+    addrs = [addr for addr in link.get("addr_info", [])
+             if addr.get("scope") == "global" and not addr.get("dynamic")]
+
+    try:
+        with open(KEEP_ADDR_ON_DOWN.format(cfg.ifname), encoding="utf-8") as fp:
+            keep_addr = fp.read().strip()
+    except OSError:
+        keep_addr = None
+
+    return {"addrs": addrs, "keep_addr_on_down": keep_addr}
+
+
+def _netdev_wait(cfg, bdf, deadline=30):
+    end = time.monotonic() + deadline
+    while True:
+        ifname = _netdev_by_pci(bdf)
+        if ifname:
+            cfg.ifname = ifname
+            cfg.ifindex = socket.if_nametoindex(ifname)
+            return
+        if time.monotonic() > end:
+            raise KsftFailEx(f"{bdf} did not come back after driver rebind")
+        time.sleep(0.1)
+
+
+def _netdev_config_restore(cfg, config, bdf):
+    _netdev_wait(cfg, bdf)
+
+    cmd(f"ip link set dev {cfg.ifname} up", fail=False)
+
+    link = json.loads(cmd(f"ip -j addr show dev {cfg.ifname}").stdout)[0]
+    present = {addr["local"] for addr in link.get("addr_info", [])}
+    for addr in config["addrs"]:
+        if addr["local"] in present:
+            continue
+        nodad = " nodad" if addr["family"] == "inet6" else ""
+        cmd(f"ip addr add {addr['local']}/{addr['prefixlen']} "
+            f"dev {cfg.ifname}{nodad}", fail=False)
+
+    if config["keep_addr_on_down"] is not None:
+        with open(KEEP_ADDR_ON_DOWN.format(cfg.ifname), "w",
+                  encoding="utf-8") as fp:
+            fp.write(config["keep_addr_on_down"])
+
+    wait_file(f"/sys/class/net/{cfg.ifname}/carrier",
+              lambda x: x.strip() == "1", deadline=15)
 
 
 @ksft_disruptive
@@ -36,12 +161,45 @@ from lib.py import NetDrvEpEnv
     run_rx_large_niov(cfg)
 
 
+@ksft_disruptive
+def check_tx_bind_dev_unreg(cfg) -> None:
+    """Close a TX dmabuf binding after its device was unregistered."""
+    dmabuf_fd, memfd = _udmabuf_alloc(UDMABUF_SIZE)
+    defer(os.close, memfd)
+    defer(os.close, dmabuf_fd)
+
+    netdevnl = NetdevFamily()
+    defer(netdevnl.close)
+    try:
+        netdevnl.bind_tx({"ifindex": cfg.ifindex, "fd": dmabuf_fd})
+    except NlError as exc:
+        raise KsftSkipEx(f"Test requires netmem TX support: {exc}") from exc
+
+    bdf, driver = _pci_dev(cfg)
+
+    defer(_netdev_config_restore, cfg, _netdev_config_get(cfg), bdf)
+    defer(_pci_bind, bdf, driver)
+
+    _pci_unbind(bdf, driver)
+    netdevnl.close()
+
+    _pci_bind(bdf, driver)
+    _netdev_wait(cfg, bdf)
+
+    probe = NetdevFamily()
+    defer(probe.close)
+    ksft_eq(probe.dev_get({"ifindex": cfg.ifindex})["ifindex"], cfg.ifindex,
+            "netdev-genl broken after unbinding from a freed netdev")
+
+
 def main() -> None:
     """Run the devmem test cases."""
     with NetDrvEpEnv(__file__) as cfg:
         setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem"))
         ksft_run([check_rx, check_tx, check_tx_chunks, check_rx_hds,
-                  check_rx_large_niov],
+                  check_rx_large_niov,
+                  # check_tx_bind_dev_unreg re-creates the netdev, keep it last
+                  check_tx_bind_dev_unreg],
                  args=(cfg,))
     ksft_exit()
 
