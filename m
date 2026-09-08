Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637153446F
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888938; cv=none; b=gdVYdBW3xISx9Uj8M2vFAVl2ql/DOxWQ+uUrGwkUABbYU+NUsYL5SWRLGShcfM2qSfhdm4qhFA4ma67NbmSwcpsNfnajA+IbtNmgBatJdC1AFvHmz5rD8hEHJe30+EjsCMfIImKmbGlskliK0Ly3H5VWQEuwxGbHmXVpyHNO+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888938; c=relaxed/simple;
	bh=8ZGjT6bUs2v4sEn1I/8WEzQo+iG+D1x7BuQM3ebFUDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1OnbahfWGfbl5m0Yab8ShQW82kOoSgNgdD/7dHcry5tr07Afz0BQkoUiXKi2JSeVahAEp/rO8h75+un8DRLLfpIX8qlmoqOwz2QL/sKa2cpJ0wg7dCUNfMywZ8plEBxOyblL/JgA/F7uh7zA0x0lZrSPQWCHnEfxqFRSasHM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfrJ2Xgi; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfrJ2Xgi"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d942de6574so32012775ad.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888934; x=1789493734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/K2aHRPBVmOw7C7+3uT+yvhuJ+NlKzk4lUpbzHkXmw=;
        b=RfrJ2XgibJy1I1Ufzrg04WTqSBZT2jdqqKC3ooxzMQFO1BAGuKt+fOZCeeBV44Hj+x
         0SvIFpsL2UxieNPNZM0wXIAtkGIm563FQ/IqeP82G4+yKkXQfybIz9O90O/aXYeLuR5I
         A3uMHiHQ3h7naveNqrzwJildQgupLbcBwyFB5uIPPZUZzMgOV8EKqtiovDKBtiM3OH/v
         MwZEMwfjNmhelpGdCn+V2iX9LsfY7MWoxJ1Zfptn7KCDT2ux+OswscVMO1svAgBShKfX
         s3NePH5J6zRU4aejcdNAc2Jow92Ubb7IyKok69x+W73WCWROrKd2yIsFoqetY8puThl/
         6qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888934; x=1789493734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g/K2aHRPBVmOw7C7+3uT+yvhuJ+NlKzk4lUpbzHkXmw=;
        b=GSzYL+ez0yjXsCwsW5eWJ9PN/d9ujcVolc0W98Zdlw0nOsAmXBReiaXNUx3abpG2n4
         qhfsZIE99BHo6U1D2JvBR5CViW68sfO/bcPm7PSa2JiV0gMIbWeY3i1eFphJT97KdOIl
         S16cikLZW1I0tCIdhQuuDYHJH1x9IIdNYiOWmszes5cBdrfCUcQIFzMPSLsIGkdp/jUx
         WWzhrj7wMoTw/PxBFSA0tjJ5T2WLn5szDmBanDubbOUfwdPF7fpmQrpk7vFURLsXH9dl
         SWfLZ/YCnqaLZtHIGsIRLR8LEqTmqEHOxLnOM2NtWs/VTLiR1CfbQWD3sFmxLegsYiLR
         rrAg==
X-Gm-Message-State: AFuF++knydwX5/EX+4WFN19MPj1R3ts18aANDmJ6eBC3pleBUf4nyM91
	gO9rpqTnLG9sRS+tsYcoiaKY2KldVnl200tcJVik/Sn5MZ7qY9/xoI+t
X-Gm-Gg: AYBFou1X9wb4im/ZsX935i1DGcU3Q7+/lHsqvXPjFWfvyr+CqF9suyh+GTEZZxV/gPY
	umRMzLtJnqB7eyXL3lnKW8RKNc91lbVFTxnrFrcfJsb/1XoVEFQQpGcLNDVsP9ZLas2YrPaIz2W
	CCyxrzL42LW2HZ3JYOvmO5mBOsYELwTi87SHHHzwp9LXvcZ5J+ZZPAN4JksoqVh9NggjoqxgOeB
	PyPJEGutmLYHKb7Vj7J4PimDPL4vVCrj84hNWAzKtpNhZOzM5XYeGqR268uroKfbmeH6YYGOdq/
	ChLgMtih0/qL0nn8T0JkU9GO6GhvscSO8iMoAtGT+TprSVv2+7OIdh/t5JGdPVs/0sIro+W0Cc7
	HWTlyCPueCI3sXiKyZt5mY6tLMa6dh2mhD3r7g/HSYVjqc1+FymlTqv/fNrvDdkKPuz9SV3YH6f
	pugwKhubiTC/c/g6wfc24v1GqG7Y7wBbDhJe9nVqOzltXVNUgtNPJJ7w==
X-Received: by 2002:a17:903:388c:b0:2d8:d4cc:be65 with SMTP id d9443c01a7336-2db8dec892cmr7860715ad.18.1788888933833;
        Tue, 08 Sep 2026 10:35:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db2ce7534fsm47449455ad.57.2026.09.08.10.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:35:32 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:34:29 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Hengbin Zhang <uqbarz@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Mina Almasry <almasrymina@google.com>, 
	Taehee Yoo <ap420073@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] net: devmem: TX dma-buf binding UAF on netdev-genl socket
 close
Message-ID: <aqBFxdzPnFmW36_J@devvm7509.cco0.facebook.com>
References: <20260908043115.216613-1-uqbarz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908043115.216613-1-uqbarz@gmail.com>

On 09/08, Hengbin Zhang wrote:
> Hi all,
> 
> Up front: I'm not a kernel developer, just someone who reads net code on
> the side, so please bear with me if I get some terminology or conventions
> wrong.  I found this issue while looking at the netmem/devmem code, and
> with some help from AI tooling I managed to reproduce it in QEMU and
> manually confirm the crash — I do believe it's a real bug.  Still, treat
> the analysis below as my best guess rather than a certainty.  Thanks a lot
> for taking the time to review this!
> 
> One-line summary
> ================
> 
> A TX (DMA_TO_DEVICE) dma-buf binding created with NETDEV_CMD_BIND_TX stores
> binding->dev without taking a netdev reference and never registers itself
> with any RX queue of the device.  When the bound device is unregistered and
> freed while the owning netlink socket is still open, closing the socket
> makes netdev_nl_sock_priv_destroy() call netdev_hold()/netdev_lock() on the
> already freed net_device -> use-after-free.  Confirmed with KASAN and by a
> real page fault / kernel panic on the same code path (log below).
> 
> Environment
> ===========
> 
> - Kernel: v7.3.0-rc1-00515-g9f0346dcbea3 (commit 9f0346dcbea3), x86_64,
>   with KASAN enabled; relevant config knobs are in the reproducer README
>   (link below).
> - Test setup: QEMU (TCG) guest, initramfs only.  The kernel image has one
>   local, test-only addition: a small stub PCI driver (source in the
>   reproducer link below).  No core net code was modified.
> 
> Steps to reproduce
> ==================
> 
> I reproduced this in a QEMU guest.  QEMU cannot emulate any of the in-tree
> NETMEM_TX_DMA devices (bnxt/mlx5/gve/fbnic are real NICs), so I wrote a
> tiny test-only stub PCI driver (source in the reproducer link below) that
> provides the same device-side properties: a net_device with
> netmem_tx = NETMEM_TX_DMA and a DMA-capable parent.  The bug lives in core
> net code, not in the driver, so this scenario should equally apply to real
> hardware — e.g. binding TX on a real netmem-TX NIC, then removing/unbinding
> that NIC while the netlink socket stays open.
> 
> 1. Build the stub driver from the gist into the kernel (CONFIG_STUBNET=y)
>    or as a module, boot the guest with "-device edu".
> 2. Boot with the static "init" program from the gist (repro.c, run as
>    PID 1 in an initramfs).  It performs, in order:
>    a. DMA_HEAP_IOCTL_ALLOC on /dev/dma_heap/system -> dmabuf fd;
>    b. NETDEV_CMD_BIND_TX on the stub device (ifindex + dmabuf fd) and keeps
>       the netlink socket open; BIND_TX succeeds and returns a dmabuf id;
>    c. writes "1" to /sys/bus/pci/devices/<bdf>/remove, i.e. unregisters and
>       FREES the stub net_device (refcount drops to 1 in netdev_run_todo);
>    d. closes the netlink socket.
> 3. Expected: closing the socket cleanly tears the binding down.
>    Actual: use-after-free, see log below.  On a kernel without KASAN the
>    same path takes a page fault and panics (second log excerpt below), so
>    this is not a KASAN-only artifact.
> 
> KASAN log
> =========
> 
>   stub0 ifindex = 2
>   dmabuf fd = 4
>   netdev family id=20 version=1
>   nl got: type=20 ... genl cmd=15 plen=8      <- BIND_TX ok (dmabuf id)
>   writing 1 to /sys/bus/pci/devices/0000:00:04.0/remove
>   stub0 gone (unregistered); net_device should now be freed
>   === CLOSING NETLINK SOCKET (expect UAF in netdev_hold) ===
>   [   43.895794] BUG: KASAN: slab-use-after-free in
>              netdev_nl_sock_priv_destroy+0x196/0x1c0
>   [   43.896434] Read of size 8 at addr ffff888002f06580 by task init/1
>   Call Trace:
>    netdev_nl_sock_priv_destroy+0x196/0x1c0
>    genl_release+0xee/0x190
>    netlink_release+0x715/0x13a0
>    __sock_release+0xa1/0x260
>    sock_close+0x10/0x20
>    __x64_sys_close+0x78/0xd0
>   Allocated by task 1:
>    __kvmalloc_node_noprof+0x202/0x5b0
>    alloc_netdev_mqs+0x7e/0x1270
>    stubnet_probe+0x120/0x3c0
>   Freed by task 1:
>    kfree+0x127/0x3b0
>    device_release+0xc8/0x240
>    kobject_put+0x101/0x1e0
>    netdev_run_todo+0x5a5/0xd70
>    unregister_netdev+0x104/0x180
>    stubnet_remove+0x3f/0x60
>    pci_device_remove+0xa6/0x180
>    remove_store+0xcc/0xe0
>   The buggy address belongs to the object ... which belongs to the cache
>   kmalloc-4k of size 4096; freed 4096-byte region [ffff888002f06000,
>   ffff888002f07000).
> 
> The kernel then continued in the same function and faulted for real:
> 
>   [   43.905270] BUG: unable to handle page fault for address: ffff8880b0ef9000
>   [   43.927189] RIP: 0010:netdev_nl_sock_priv_destroy+0xad/0x1c0
>   ...
>   [   43.938987] Kernel panic - not syncing: Fatal exception
> 
> Analysis
> ========
> 
> The flaw is a four-step chain: BIND_TX stores a raw net_device pointer
> without taking a reference; TX bindings never populate bound_rxqs; the
> unregister cleanup that clears binding->dev only matches RX queues; so when
> the socket is closed after the device was unregistered and freed,
> netdev_nl_sock_priv_destroy() runs netdev_hold()/netdev_lock() on the freed
> net_device.
> 
> 1) Binding creation - raw pointer, no reference (net/core/devmem.c,
>    net_devmem_bind_dmabuf(), DMA_TO_DEVICE = TX path):
> 
>     binding->dev = dev;              // raw store, NO netdev_hold()
>     xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
>     // TX path never calls net_devmem_bind_dmabuf_to_queue()
>     // -> bound_rxqs stays EMPTY; the unregister cleanup (which matches
>     //    queues) cannot see this binding
> 
> 2) Device unregister - the only binding->dev clearing point is RX-only:
> 
>     // net/core/dev.c:12395 dev_memory_provider_uninstall()
>     for (i = 0; i < dev->real_num_rx_queues; i++)
>             __netif_mp_uninstall_rxq(&dev->_rx[i], &dev->_rx[i].mp_params);
>             // scans the device's OWN RX queues only -> TX binding invisible
> 
>     // net/core/devmem.c:537 mp_dmabuf_devmem_uninstall() - the ONLY place
>     // that clears binding->dev:
>     WRITE_ONCE(binding->dev, NULL);  // reached only when a bound queue is
>                                      // uninstalled (RX-only); never fires
>                                      // for TX bindings
> 
> 3) Free - the binding contributes zero references (net/core/dev.c):
> 
>     // netdev_wait_allrefs_any()/netdev_run_todo()
>     if (netdev_refcnt_read(dev) == 1)    // no holder left; the binding holds
>                                          // no reference either
>             free_netdev(dev);            // net_device freed while the socket
>                                          // and its binding are still alive
> 
> 4) Socket close - teardown on freed memory (net/core/netdev-genl.c:1445,
>    netdev_nl_sock_priv_destroy()):
> 
>     dev = binding->dev;              // RX: NULL (cleared in step 2);
>                                      // TX: dangling
>     if (!dev) { unbind; continue; }  // safe branch - never taken for TX
>     netdev_hold(dev, ...);           // UAF #1: refcount/tracker increment on
>                                      // the freed net_device
>     netdev_lock(dev);                // UAF #2: mutex on freed memory
> 
> Full reproducer materials (stub driver source, trigger program, build/run
> README and the complete serial log):
> https://gist.github.com/hharryz/119f067937448ac6e30eb31e7f08dc5a
> 
> I'd be happy to keep testing, digging deeper into the analysis, and trying
> to put together a possible fix if that helps.  Thanks a lot for your time!

Hmm, this looks legit, I don't think we have a proper test for this
condition :-/ I can try to take a stab unless someone else volunteers.
