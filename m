Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208F31AA92
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961491; cv=none; b=FUBUYam6bIICEicMInxLOFR3jPqu8yIao+L81gt6uM7mvUC44KQklmNJy3VZqT3mKgog/b+NhQi52/EF/9o83B3SKsZNHcVz5JfIbHwpgArGW+Q7O+59DTr8vtPOLTvDBnXs0F5/D6WPmnrnnV34Q0bqib2Fw152VZvZ0Zx2yMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961491; c=relaxed/simple;
	bh=6FlkA2TtXuQNhwzdTOs1jVfajOngKNv8oSFtdVSNIag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeNZLM8C8ABbpRVELL04yYlmXbbVhsg2JSxzHLhzmc9MdoXFPH7dUrkzhUt6xiF8tKGaYm+RmH1y6pI5sD9Q9FzhgYCnmUY5dAQ7su6cwfT1qgz3Y5/rKzmtl+yTL99NOCz6akUHtbp1VHVf/9VLdtl6KzHX7M7sp35HaJGjdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moz7/E2g; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moz7/E2g"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7ef9c8a8244so2611017b3.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961487; x=1781566287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TKhtckuUUtunWLdv/vPJxvQt1UComQeywAMjBPDnJc=;
        b=moz7/E2g6SVSsUzarfr4899dwCj1OAC4+RUQCxkRFh9iPvBF8w4Yooo9BXK57QO35b
         4cY3CCQOLUf1q0olfYBb4e0h8mlRw4CQwkzBOmwHef8555zr9igN2wz9Z862YM6dxghn
         UfdHeGegRsgV1LAmbNaOBk0Mcnfq5FRyWpIMurTjCylwy7NngxGdRCgNZ+o3mEAZlhkR
         YjISOArCBR3As0gtFXPHaXrTSQoDmUCxNsaCVB03hSLGJBQe9iRkYln+PGTi+RiyMHxE
         flN1Gq0NMLYs8BrxSZ5TQbRwU9gYUYr+j+NW+3fhJvA6wbr5b1oxsGjNl7Q7p4DGcKNw
         2hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961487; x=1781566287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2TKhtckuUUtunWLdv/vPJxvQt1UComQeywAMjBPDnJc=;
        b=gTp6rMKU9WEVqax6FbGgzI3G6aCUbt9XAv72/t/qqQfPJeDYnmAKBv0KGi82j9St0i
         BNxran5xvSYahk3tdSo37Sf3n0Kia+nea2mMnY5d4gJgA2v8CIe5oX3Z4AXCWEgVXfuL
         OWOykROJGjRylTyJCG31FhHF2THxvimFrgwsKUqGvENNn3FtWPT2JlapF4DZKNelwe8Z
         ehLSvIgfCe2D3wLWEN+wolmh9DZ+FQoY+TTWvbuAGwqJRlWdwKMUZJLVdVOD5mcaNok/
         UXIbyscQ/e01OFZtigN55utHkZmkWmbV2A5M4GikW8MAtSA4x4vQcynQgvTwyko4I67c
         AQ5A==
X-Gm-Message-State: AOJu0YxZ+IpN3jgYDNj2mooQOh1HHQUplkjHff1iNh9tfo1HeWKW/cUs
	athAHcyyHmoA+2p9EZXX4qbiUD/rwA0qyJpvSAPA16p8meuYYDKRnqcPm52k/A==
X-Gm-Gg: Acq92OGe7iiLlfgjTXrogIls7NxrXKyqbidf3edVjfUFwIXYDwauLSCRlxHHSXB/HOH
	c7aZ0yncrUiFhJ3bIhobkFtlxKLCxO7FzKl2byoDjpR7ybsJ1ibPrEPGftYjXlfgqDPtlgt7UsS
	hc11lqfdbTJY7YkaXeJZZRRdrsAJ8RDkwpFsxM1ue6HqT23cUZskCiTD8MWeS6e/SInqZvs3FcW
	rWCOfBPGODRuQSwmG2xDAqQ2UQqiuCa6MhaNSd91L7e4ryKG8cQjJa4FfojNzjwCo77Dz0uZ2kq
	4rbhnwRG1mefqv3wzkgGC31HkrtdvRrU3sUBoeCGEAbI6sjcw6ph+OiIIayDlT8USDoqFRKnGgN
	DYu0sRCa51B0S9Ou75c6Hr3jP2un7NIQGpi0GGEo7cRcTksqnSm071XpUt0PgTGhNdEH0RfX/T/
	1rAvsILRrdgJIDYlBypOD/K2VceMETvoHIRw==
X-Received: by 2002:a05:690c:f16:b0:7ef:899c:68ef with SMTP id 00721157ae682-7f2b128da6emr2552877b3.4.1780961486691;
        Mon, 08 Jun 2026 16:31:26 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8d0dsm89916617b3.6.2026.06.08.16.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:31:26 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v16 net-next 07/10] selftests/net: psp: support PSP in NetDrvContEnv infrastructure
Date: Mon,  8 Jun 2026 16:31:15 -0700
Message-ID: <20260608233118.2694144-8-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
References: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Wang <weibunny@fb.com>

Add infrastructure to support PSP tests across network namespaces
using NetDrvContEnv with netkit pairs. This enables testing PSP device
association, where a non-PSP-capable device (e.g. netkit) in a guest
namespace is associated with a real PSP device in the host namespace,
allowing the guest to perform PSP encryption/decryption through the
host's PSP hardware.

The topology is:
  Host NS:  psp_dev_local <---> nk_host
                |                  |
                |                  | (netkit pair)
                |                  |
  Remote NS: psp_dev_peer      Guest NS: nk_guest
             (responder)             (PSP tests)

env.py:
- nk_guest_ifindex is queried after moving the device into the guest
  namespace, so tests can use it directly for dev-assoc

psp.py:
- PSP device lookup supports container environments where the PSP
  device is on the physical interface, not the test interface
- Association helpers handle dev-assoc/dev-disassoc with defer-based
  cleanup to prevent state leaks on test assertion failures
- main() tries NetDrvContEnv with primary_rx_redirect and falls back
  to NetDrvEpEnv, so existing tests continue to work without the
  container environment

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 tools/testing/selftests/drivers/net/config    |   1 +
 .../selftests/drivers/net/lib/py/env.py       |   3 +
 tools/testing/selftests/drivers/net/psp.py    | 102 +++++++++++++++++-
 3 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 617de8aaf551..91d4fd410914 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -8,6 +8,7 @@ CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_NETDEVSIM=m
+CONFIG_NETKIT=y
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_PPP=y
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 59b0f2533ab4..b188ee55c76b 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -470,6 +470,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._init_ns_attached = True
         ip("netns set init 0", ns=self.netns)
         ip(f"link set dev {self.nk_guest_ifname} netns {self.netns.name}")
+        nk_guest_dev = ip(f"link show dev {self.nk_guest_ifname}",
+                          json=True, ns=self.netns)[0]
+        self.nk_guest_ifindex = nk_guest_dev['ifindex']
         ip(f"link set dev {self.nk_host_ifname} up")
         ip(f"-6 addr add fe80::1/64 dev {self.nk_host_ifname} nodad")
         ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self.nk_host_ifname}")
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 6d5114be4c88..015af92c8d7b 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -5,6 +5,7 @@
 
 import errno
 import fcntl
+import os
 import socket
 import struct
 import termios
@@ -16,8 +17,10 @@ from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
 from lib.py import ksft_not_none
 from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import KsftSkipEx
-from lib.py import NetDrvEpEnv, PSPFamily, NlError
+from lib.py import NetDrvEpEnv, NetDrvContEnv
+from lib.py import NlError, PSPFamily
 from lib.py import bkg, rand_port, wait_port_listen
+from lib.py import ip
 
 
 def _get_outq(s):
@@ -118,11 +121,13 @@ def _get_stat(cfg, key):
 # Test case boiler plate
 #
 
-def _init_psp_dev(cfg):
+def _init_psp_dev(cfg, use_psp_ifindex=False):
     if not hasattr(cfg, 'psp_dev_id'):
         # Figure out which local device we are testing against
+        # For NetDrvContEnv: use psp_ifindex instead of ifindex
+        target_ifindex = cfg.psp_ifindex if use_psp_ifindex else cfg.ifindex
         for dev in cfg.pspnl.dev_get({}, dump=True):
-            if dev['ifindex'] == cfg.ifindex:
+            if dev['ifindex'] == target_ifindex:
                 cfg.psp_info = dev
                 cfg.psp_dev_id = cfg.psp_info['id']
                 break
@@ -597,13 +602,102 @@ def data_mss_adjust(cfg, ipver):
     _data_mss_adjust(cfg, ipver)
 
 
+def _try_disassoc(cfg, psp_dev_id, ifindex, nsid=None):
+    """Best-effort disassociate, ignoring errors if already removed."""
+    try:
+        params = {'id': psp_dev_id, 'ifindex': ifindex}
+        if nsid is not None:
+            params['nsid'] = nsid
+        cfg.pspnl.dev_disassoc(params)
+    except NlError:
+        pass
+
+
+def _assoc_nk_guest(cfg):
+    """Associate nk_guest with PSP device and register cleanup via defer()."""
+    _init_psp_dev(cfg, True)
+
+    cfg.pspnl.dev_assoc({'id': cfg.psp_dev_id,
+                         'ifindex': cfg.nk_guest_ifindex,
+                         'nsid': cfg.psp_dev_peer_nsid})
+    defer(_disassoc_nk_guest, cfg,
+          cfg.psp_dev_id, cfg.nk_guest_ifindex)
+
+
+def _disassoc_nk_guest(cfg, psp_dev_id, nk_guest_ifindex):
+    """Disassociate nk_guest and reset cfg PSP state."""
+    pspnl = PSPFamily()
+    pspnl.dev_disassoc({'id': psp_dev_id, 'ifindex': nk_guest_ifindex,
+                        'nsid': cfg.psp_dev_peer_nsid})
+    cfg.pspnl = pspnl
+    del cfg.psp_dev_id
+    del cfg.psp_info
+
+
+def _get_nsid(ns_name):
+    """Get the nsid for a namespace."""
+    for entry in ip("netns list-id", json=True):
+        if entry.get("name") == str(ns_name):
+            return entry["nsid"]
+    raise KsftSkipEx(f"nsid not found for namespace {ns_name}")
+
+
+def _setup_psp_attributes(cfg):
+    # pylint: disable=protected-access
+    """
+    Set up PSP-specific attributes on the environment.
+
+    This sets attributes needed for PSP tests based on whether we're using
+    netdevsim or a real NIC.
+    """
+    if cfg._ns is not None:
+        # netdevsim case: PSP device is the local dev (in host namespace)
+        cfg.psp_dev = cfg._ns.nsims[0].dev
+        cfg.psp_ifname = cfg.psp_dev['ifname']
+        cfg.psp_ifindex = cfg.psp_dev['ifindex']
+
+        # PSP peer device is the remote dev (in _netns, where psp_responder runs)
+        cfg.psp_dev_peer = cfg._ns_peer.nsims[0].dev
+        cfg.psp_dev_peer_ifname = cfg.psp_dev_peer['ifname']
+        cfg.psp_dev_peer_ifindex = cfg.psp_dev_peer['ifindex']
+    else:
+        # Real NIC case: PSP device is the local interface
+        cfg.psp_dev = cfg.dev
+        cfg.psp_ifname = cfg.ifname
+        cfg.psp_ifindex = cfg.ifindex
+
+        # PSP peer device is the remote interface
+        cfg.psp_dev_peer = cfg.remote_dev
+        cfg.psp_dev_peer_ifname = cfg.remote_ifname
+        cfg.psp_dev_peer_ifindex = cfg.remote_ifindex
+
+    # Get nsid for the guest namespace (netns) where nk_guest is
+    cfg.psp_dev_peer_nsid = _get_nsid(cfg.netns.name)
+
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
-    with NetDrvEpEnv(__file__) as cfg:
+    # Make sure LOCAL_PREFIX_V6 is set
+    if "LOCAL_PREFIX_V6" not in os.environ:
+        os.environ["LOCAL_PREFIX_V6"] = "2001:db8:2::"
+
+    try:
+        env = NetDrvContEnv(__file__, primary_rx_redirect=True)
+        has_cont = True
+    except KsftSkipEx:
+        env = NetDrvEpEnv(__file__)
+        has_cont = False
+
+    with env as cfg:
         cfg.pspnl = PSPFamily()
 
+        if has_cont:
+            _setup_psp_attributes(cfg)
+
         # Set up responder and communication sock
+        # psp_responder runs in _netns (remote namespace with psp_dev_peer)
         responder = cfg.remote.deploy("psp_responder")
 
         cfg.comm_port = rand_port()
-- 
2.52.0

