Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794117497;
	b=BeAgdf3hSgO2OYGEroJ7F/2r4ndrC4LVU83MxBRSwsLl3/c4M6dP2eziHDp3Rh+lHhEb
	 DhBsaeXxKVh4tTxCsERhWWsJ/NoCOn2cog4IUBxdgRZa5EHHf17Jq08qB89BCeR4e+Wk8
	 DHyb+NuBnOd7TxxTnqJYO/MAU7yHkbUDiMJB8HWeoKS1qPy3Z8U+UO7dc8W9fFzqfh9c5
	 jcGAPqQc3jQjL3Na7qn2Axy81Ky10ntGsiZxmZqvX2H5OwNkKwtomY4IJvPRiLrCO4ibQ
	 NrRUnvUWtStCq7ZIhnPyy5yaws/M9b0TBEeDP1huE4Ui4KIBt7TmRMJUAsz7bhkus1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794117497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QYnZ4f08SwRhsosiiEmUJpp+LTvkBM+gRqSOdQT1O/I=;
	b=FNYAMF3KjTPnOblJe+w24Pozr33NnhB/0Rcca8n52k2jbf2wpSvURDtBlYTGRRZ7qObU
	 9IImDOELKRMMcP04ES9DZo1R/uwSV8mq6kNNrzYBtgm23r8lDoBbKFx8cGrMrO5kNJuC8
	 ZoU/oC37nnyW2kZGiUCClpxS+AR9gLf6neuAEWyc+tKeKzMKcO/nX6zhYugfvu223pha+
	 N0mV3aT7mFqc4t1B1Rm1vVxqejqG8gztNkurYr1SrJdupuR4hJJYLkKPqsMxGLEZ8RHiK
	 /JTd7ZFYztSL0mqNKPGwi6j5EtBINc3G85mItFWyMAgVP8gvI38oxJ6WHdigCkSTeMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RqCRetJR;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77675606D818
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 05:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77675606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RqCRetJR
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36f479b9819so523639eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 21:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794117497; x=1794722297; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYnZ4f08SwRhsosiiEmUJpp+LTvkBM+gRqSOdQT1O/I=;
        b=RqCRetJRGUIdj0+KSdQ5zpjcSeqnAgaAW8ty2e/wj4HOsbT/4EsReyuQpZZCbXaFUm
         vablVNJd0rV3PLZHzspMtlFMEeWCxzGuDbh3L4hcBJozfuKoy6BMVigLX4YphLCS5XB9
         VUehnLriTmfl5JpNjAPAUeJRo6WkUT/MvNa0TzGQjTmOrZjsfeGw75T4vUFn/hNX0PIY
         kmp5yh+6V1wolv22kN1x/jWe//x8Cl7LcUGVsG8MGGHqanfwcPc7Qq5IZlfsBviJOvQl
         e2SdaMGeVIA/ZTMRt0BbmKuaPp1f0/9Xq6MJp1oLodSH57vRU6eRpHTHLfKML3Mr5UTk
         WjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794117497; x=1794722297;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYnZ4f08SwRhsosiiEmUJpp+LTvkBM+gRqSOdQT1O/I=;
        b=QwCl+rVIOS2nzea++zPBiMBarLXaFGR6pZFwR4KdrNF9G96Kq/Lfwxpfu9JTbpISKE
         8S7k/FBFVT29lzej8q/KEyV9bg4GxgTdxWZSxOjrdWcPtIz2uVipwfHH7vKiR2lJIl16
         fQyoB7vlRBBXwoZdZmjXVS7aWDYsvHjZ3XZIsUvL7F2WXKuETgt89hV/gvV30HnubH5W
         O9OVB2d5DFGC5V7peVHpuh8xASyHbgZPtvlcaWnTzpyF11IF8lfzlI6ANW4FHkCfDDsP
         zkbIdhChGI/Jis4U57OowkgWlR/oqfHqTBbnjGsVSl1yDUGwouleK5PXqekYSpg7GDno
         Xzlg==
X-Gm-Message-State: APuU4Z/7+pv/B5UL2bGLmNnx99JY/zwwlx2DHFFv8voCqH70D14mFzvQ
	83UNWrUXkWqF510n3jtBQ3arDzVudqOMbWnWTDn+oyCEAfflSCF0KBME6CCgv/IM1N528tJrEI7
	2CS2UkyQOj4eKZrnn1WEQFkh+ONz+PH7rjMM/ufpFsrhTWLHdLiIK0sRfUYKnRbZhKCg4tXKyij
	4OtNseauB2EX9t7q+4kAZKk92VIPAJrRlVH5Pp/yoJ/7/Y/hnL59gxrlu1u0OAEoQ=
X-Received: from dybpg4.prod.google.com ([2002:a05:7301:4144:b0:36c:a067:eca4])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:648e:b0:36c:a390:8907 with SMTP id 5a478bee46e88-37255a4e72amr2132546eec.21.1794117496193;
 Sat, 07 Nov 2026 21:58:16 -0800 (PST)
Date: Sun,  8 Nov 2026 05:58:09 +0000
In-Reply-To: <20261108055809.2122934-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108055809.2122934-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108055809.2122934-7-almasrymina@google.com>
Subject: [PATCH net-next v2 6/6] selftests: net: add leased devmem RX and TX
 netdev unregister tests
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Extend nl_netdev.py to cover netdev unregistration while devmem RX and
TX bindings are active on a virtual netkit device leasing an RX queue
from netdevsim:

1. devmem_lease_bind_rx_unregister_check: binds an RX dmabuf to a netkit
   device backed by a leased netdevsim queue and verifies clean teardown
   both when the virtual netkit device is deleted first (unleasing the
   queue while netdevsim remains up) and when the underlying netdevsim
   device is unregistered directly (which uninstalls the physical queue
   memory provider and cascades unregistration to the leasing netkit).
2. devmem_lease_bind_tx_unregister_check: binds a TX dmabuf to a netkit
   device backed by a leased netdevsim queue and verifies clean teardown
   both when the virtual netkit device is deleted first and when the
   underlying netdevsim device is unregistered directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 tools/testing/selftests/net/nl_netdev.py | 132 ++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index dd0321c0b463a..fa4b5be093257 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -12,8 +12,9 @@ import os
 import struct
 from os import system
 from lib.py import ksft_run, ksft_exit, KsftFailEx, KsftSkipEx
-from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_raises, ksft_busy_wait
-from lib.py import EthtoolFamily, NetdevFamily, NetdevSimDev, NlError, defer, ip
+from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_not_in, ksft_raises, ksft_busy_wait
+from lib.py import EthtoolFamily, NetdevFamily, NetdevSimDev, Netlink
+from lib.py import NlError, RtnlFamily, cmd, defer, ip
 
 
 def empty_check(nf) -> None:
@@ -483,6 +484,129 @@ def devmem_bind_tx_unregister_check(_nf) -> None:
     nf_priv.close()
 
 
+def _create_netkit_single(rxqueues=2):
+    """Create a single-device netkit interface for queue lease tests."""
+    ifname = f"nk{os.getpid()}"
+    try:
+        with RtnlFamily() as rtnl:
+            rtnl.newlink(
+                {
+                    "ifname": ifname,
+                    "linkinfo": {
+                        "kind": "netkit",
+                        "data": {
+                            "mode": "l2",
+                            "pairing": "single",
+                        },
+                    },
+                    "num-rx-queues": rxqueues,
+                },
+                flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
+            )
+    except NlError as e:
+        if e.error in (errno.EOPNOTSUPP, errno.ENOENT):
+            raise KsftSkipEx(f"netkit single mode not supported: {e}") from e
+        raise
+    defer(cmd, f"ip link del dev {ifname}", fail=False)
+
+    link = ip(f"-d link show dev {ifname}", json=True)[0]
+    return ifname, link["ifindex"]
+
+
+def devmem_lease_bind_rx_unregister_check(nf) -> None:
+    """Verify leased RX devmem bindings detach cleanly on virt/phys unregister."""
+    for remove_virt_first in (False, True):
+        dmabuf_fd = _create_udmabuf()
+        defer(os.close, dmabuf_fd)
+        nf_priv = NetdevFamily()
+        defer(nf_priv.close)
+        nsimdev = NetdevSimDev(queue_count=2)
+        defer(nsimdev.remove)
+        nsim = nsimdev.nsims[0]
+
+        ip(f"link set dev {nsim.ifname} up")
+        with EthtoolFamily() as ef:
+            ef.rings_set({"header": {"dev-index": nsim.ifindex},
+                          "tcp-data-split": "enabled"})
+
+        nk_ifname, nk_ifindex = _create_netkit_single(rxqueues=2)
+        ip(f"link set dev {nk_ifname} up")
+
+        res = nf.queue_create({
+            "ifindex": nk_ifindex,
+            "type": "rx",
+            "lease": {
+                "ifindex": nsim.ifindex,
+                "queue": {"id": 1, "type": "rx"},
+            },
+        })
+
+        _devmem_bind(nf_priv.bind_rx, {
+            "ifindex": nk_ifindex,
+            "fd": dmabuf_fd,
+            "queues": [{"id": res["id"], "type": "rx"}],
+        })
+        ksft_ge(_dmabuf_attach_count(dmabuf_fd), 1)
+
+        if remove_virt_first:
+            ip(f"link del dev {nk_ifname}")
+            phys_q = nf.queue_get({"ifindex": nsim.ifindex, "id": 1,
+                                   "type": "rx"})
+            ksft_not_in("dmabuf", phys_q)
+            ksft_not_in("lease", phys_q)
+            ksft_ge(_dmabuf_attach_count(dmabuf_fd), 1)
+            nsimdev.remove()
+        else:
+            nsimdev.remove()
+            ksft_ne(cmd(f"ip link show dev {nk_ifname}", fail=False).ret, 0)
+        ksft_eq(_dmabuf_attach_count(dmabuf_fd), 0)
+
+        nf_priv.close()
+
+
+def devmem_lease_bind_tx_unregister_check(nf) -> None:
+    """Verify leased TX devmem bindings detach cleanly on virt/phys unregister."""
+    for remove_virt_first in (False, True):
+        dmabuf_fd = _create_udmabuf()
+        defer(os.close, dmabuf_fd)
+        nf_priv = NetdevFamily()
+        defer(nf_priv.close)
+        nsimdev = NetdevSimDev(queue_count=2)
+        defer(nsimdev.remove)
+        nsim = nsimdev.nsims[0]
+
+        ip(f"link set dev {nsim.ifname} up")
+
+        nk_ifname, nk_ifindex = _create_netkit_single(rxqueues=2)
+        ip(f"link set dev {nk_ifname} up")
+
+        nf.queue_create({
+            "ifindex": nk_ifindex,
+            "type": "rx",
+            "lease": {
+                "ifindex": nsim.ifindex,
+                "queue": {"id": 1, "type": "rx"},
+            },
+        })
+
+        _devmem_bind(nf_priv.bind_tx, {
+            "ifindex": nk_ifindex,
+            "fd": dmabuf_fd,
+        })
+        ksft_ge(_dmabuf_attach_count(dmabuf_fd), 1)
+
+        if remove_virt_first:
+            ip(f"link del dev {nk_ifname}")
+            ksft_ge(_dmabuf_attach_count(dmabuf_fd), 1)
+            nsimdev.remove()
+        else:
+            nsimdev.remove()
+            ksft_ne(cmd(f"ip link show dev {nk_ifname}", fail=False).ret, 0)
+        ksft_eq(_dmabuf_attach_count(dmabuf_fd), 0)
+
+        nf_priv.close()
+
+
 def main() -> None:
     """ Ksft boiler plate main """
     nf = NetdevFamily()
@@ -498,7 +622,9 @@ def main() -> None:
               page_pool_ifindex_leak_check,
               page_pool_stats_ifindex_check,
               devmem_bind_rx_unregister_check,
-              devmem_bind_tx_unregister_check
+              devmem_bind_tx_unregister_check,
+              devmem_lease_bind_rx_unregister_check,
+              devmem_lease_bind_tx_unregister_check
               ],
              args=(nf, ))
     ksft_exit()
-- 
2.56.0.455.g6c5a503b38-goog

