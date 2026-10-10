Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F95330B01
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629886; cv=none; b=RUovFjTbpckzH99t1JZJAL0ZQF8ZWL9U5GsKkaQXDtZ+cVJ83wnUm2l2/Usmb+vbjRBusLohm87iupJY+xa+FLE7v5w7grZjMd1KehQant6mdQNQ1sfHpkp2Br6AHqzqGFTRuuXJGumBTS42sM8nkqWzNZBBOMxMLfqoIN5041s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629886; c=relaxed/simple;
	bh=0VLDXaFHr0IbDdka+wBKumsr/c9CvUS+aFFpZwePFuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mu1As+YBccZu3ipfnWmH8eMmwtq2P1dOZ+IEdwu0P7xL85ZzPH28nRenfaLdDXOz8zjPgYfIeNjR+q2LQmhC5Dt/kSVPJw4nf1vuKaHtICAAAlEEIODcJfGyxy4UhruCc2+SVtEQeFciU0Zb0zBBLKLzjHsgeIJ+ecs0G+8Mjbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CChnVZj+; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CChnVZj+"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so766337eec.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791629884; x=1792234684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7BZ2GeODM1QONdpbiAMlb/1FxHW9t8+hYqjKNDUeizs=;
        b=CChnVZj+DtqujRj6dTVCeJrBA+9DO8dVR3ZI7socB08ukM0kCaYovcE4AB1ogmc6jh
         p5tjPRFm1HOIaa5x4b4kw2tYmOJ3i78Khg/om3m53hc/Ae7qQMe7zSfqVbnwoFqqGQAb
         Rq4h8AflmC1s5eK+MVvXnrFnKaCVMD3Fws8VRNvn8MeemIHy3yw/iVR8U0vqmhaH5fmF
         V9WHrn90thq6CM4pAxwUdEwMj/bsRssrV9bRubEPKRHtY7K8GGDdVv4+Y2Q9mXn2kHzs
         ytdkp/Xc+G1fZ5w0DQQZiO7P+thAEV5cRJQoK63qYOjFJjqcFjK5YvqXdeMsWIHeQIZs
         VnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629884; x=1792234684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7BZ2GeODM1QONdpbiAMlb/1FxHW9t8+hYqjKNDUeizs=;
        b=MATcUUnfss7T/YLup2M/J9+YEhqTbA5pddRiqgTfEPC2zJyOfJwgv5DZLrjeWjGPz/
         Tihi4yUvPDghwLGqgADMizBOUuN77u4660NxJJKfGcuSb2trPEH2gkq26aM8fUNYu7mK
         aeqC958Q7SS6cexssTVNUq5nymkCYNj26WOTNytEWCSiH9vSV3KR37W2F1uuYLHQrGUJ
         1Wbst1aPmWoXXxY9Zf3uy9kooEYaLc0bAmVHPYDf+eAeZsHmpNZIQBt2c2koAuQZjoho
         7hSEy1Su1QzM24JN9ikXFbLxN/QoON/tKvG3s/dzmbbYo5Ve2zf98FzzmTawiV3FgEKV
         3Zbw==
X-Forwarded-Encrypted: i=1; AKwUvBxBMT7RWNdq4xisqIGj0Y9wQ8eM2Z1Xh9/7x077EHxkf0tYSMgkRc3rBNFQIM8G31q2cXb0aUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKthLU0HNR9wPM2tyU6bc+rpPv/YuYhstWHkm6bl5/ukOsz78Tp
	eIj0Yl70O6r5JoLSMIHW7LUrcrFmrP15PYO0b8Eo+HwlzFPVa7Ft5ntS
X-Gm-Gg: AYBFou0Z/5zjA8CtG3NxlTif7N1FRkQdN87dWcLmvmZ7IFsjKhUuLH9QB/plBZfsk44
	ndm7MbrcYMXT4XX8SYVBM4Kwc9DYOVi33K01MCDQhQ7RhwM7IgjdU6u56hNFXlB4gKDsl/CSdzT
	Dh4XrmEaWSSAxtS5B0q7uk3u+RWEPRgVl5cEBoLTxY/Zkxgo3g36Zn7YgZsbweDV0+XnMdRrGnM
	nNufL4rSAM1cA3Z74zoTeNYws+4cJ2yYd49ELTBJp+ltLiefES48KU6QIQVNDnc/WIsmwzv6QkS
	4+AP7cEFSFWqG/blLLlu8tNPgt/YQCI1JExaEqk4WWX61TIrKNY/UttNNHceLz7chN1deIclVop
	WWKcgNjVweWQNHLYWUsarBIwZf7MHY9ISJZmpt3KovTGX5ZIaYGKQAW4CDY5U2y3sV9XDhi3oeL
	2jkVADh1/Z8j1z+Bivj+qD184MPO1N8qJMmAWuGIm/fZDWCvliX4Q1IpVBZQRitxbSQ9YBWBrFn
	MrvO2T2Le2l1uJ4lnLZf5+DFpMIsdMTM/FvDlWlExQNgiiqUOwQJHx2mjCCSDLbgvqLrLZ26gvK
	jrmxg6Gj+KyGlM/avhDn8NvCJh0+QzrS7pYJe0SY3KM=
X-Received: by 2002:a05:7301:6e9a:b0:358:dfed:d0fe with SMTP id 5a478bee46e88-358dfedd5fbmr498719eec.5.1791629883943;
        Sat, 10 Oct 2026 03:58:03 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm13577784eec.2.2026.10.10.03.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:58:03 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v4 3/3] selftests: net: add a test for the gtp netlink family
Date: Sat, 10 Oct 2026 10:57:40 +0000
Message-Id: <20261010105740.223992-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261010105740.223992-1-anilkaushikwireless@gmail.com>
References: <20261010105740.223992-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the gtp generic netlink family through its ynl spec: create a
gtp device, add a PDP context with newpdp, check getpdp dumps it on that
device with the expected TEIDs and addresses, and that delpdp by TEI
removes it. Two more cases check that two contexts are dumped and one
can be deleted by its MS address, and that deleting an unknown context
fails with ENOENT, both by TEI and by MS address.

ynl resolves the family ids once per process, with a CTRL_CMD_GETFAMILY
dump which does not autoload modules, so the gtp device is created
before the family handle: that loads gtp.ko through its rtnl link alias.
The test is skipped when the kernel or iproute2 lack GTP support.

Add a GtpFamily ynl wrapper and register the test.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/gtp.py            | 115 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   8 +-
 6 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/gtp.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a6e43995ea58..8ac817a78bb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11423,6 +11423,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp.git
 F:	Documentation/netlink/specs/gtp.yaml
 F:	drivers/net/gtp.c
+F:	tools/testing/selftests/net/gtp.py
 
 GUID PARTITION TABLE (GPT)
 M:	Davidlohr Bueso <dave@stgolabs.net>
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index d4ca82fec0b4..6b54e04a6430 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -46,6 +46,7 @@ TEST_PROGS := \
 	fq_band_pktlimit.sh \
 	gre_gso.sh \
 	gre_ipv6_lladdr.sh \
+	gtp.py \
 	icmp.sh \
 	icmp_redirect.sh \
 	io_uring_zerocopy_tx.sh \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 737e7e6327b3..c4534e15fb7a 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -15,6 +15,7 @@ CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_DUMMY=y
 CONFIG_GENEVE=m
+CONFIG_GTP=m
 CONFIG_IFB=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_ESP=y
diff --git a/tools/testing/selftests/net/gtp.py b/tools/testing/selftests/net/gtp.py
new file mode 100755
index 000000000000..b307699b3c1e
--- /dev/null
+++ b/tools/testing/selftests/net/gtp.py
@@ -0,0 +1,115 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Tests for the gtp netlink family."""
+
+import errno
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, ksft_in, ksft_not_in, ksft_raises
+from lib.py import KsftSkipEx
+from lib.py import NetNS, NetNSEnter
+from lib.py import GtpFamily, NlError
+from lib.py import CmdExitFailure
+from lib.py import ip, defer
+
+
+def _setup(ns):
+    """Return a gtp family handle, and the ifindex of a new gtp device.
+
+    Create the device first: that loads gtp.ko through its rtnl link
+    alias. ynl resolves the family ids once per process, with a
+    CTRL_CMD_GETFAMILY dump which does not autoload modules, so the
+    family must be registered before the first family handle is created.
+    """
+    try:
+        ip("link add gtp0 type gtp role ggsn", ns=str(ns))
+    except CmdExitFailure as e:
+        raise KsftSkipEx("no gtp support (CONFIG_GTP, iproute2)") from e
+    defer(ip, "link del gtp0", ns=str(ns))
+    ip("link set gtp0 up", ns=str(ns))
+    link = ip("-d link show gtp0", ns=str(ns), json=True)[0]["ifindex"]
+
+    with NetNSEnter(str(ns)):
+        gtp = GtpFamily()
+
+    return gtp, link
+
+
+def _contexts(gtp, link):
+    return [c for c in gtp.getpdp({}, dump=True) if c.get("link") == link]
+
+
+def _iteis(contexts):
+    return [c.get("i-tei") for c in contexts]
+
+
+def add_del_pdp(ns) -> None:
+    """Add a PDP context, query it, then delete it by TEI.
+
+    The dump must return the context with the link, TEIDs and addresses
+    it was created with, and it must be gone after the delete. The delete
+    only identifies the context by its TEI, to use the GTPv1 TEI lookup.
+    """
+    gtp, link = _setup(ns)
+
+    gtp.newpdp({"link": link, "version": 1,
+                "i-tei": 0x100, "o-tei": 0x200,
+                "ms-address": "10.0.0.1", "peer-address": "192.0.2.1"})
+
+    pdp = [c for c in _contexts(gtp, link) if c.get("i-tei") == 0x100]
+    ksft_eq(len(pdp), 1)
+    ksft_eq(pdp[0]["o-tei"], 0x200)
+    ksft_eq(pdp[0]["ms-address"], "10.0.0.1")
+    ksft_eq(pdp[0]["peer-address"], "192.0.2.1")
+
+    gtp.delpdp({"link": link, "version": 1, "i-tei": 0x100})
+    ksft_not_in(0x100, _iteis(_contexts(gtp, link)))
+
+
+def add_two_pdp(ns) -> None:
+    """Add two PDP contexts, check both are dumped, delete one by address.
+
+    The delete identifies the context by its MS address, and must leave
+    the other context in place.
+    """
+    gtp, link = _setup(ns)
+
+    for i_tei, o_tei, ms in ((0x111, 0x211, "10.0.1.1"),
+                             (0x112, 0x212, "10.0.1.2")):
+        gtp.newpdp({"link": link, "version": 1,
+                    "i-tei": i_tei, "o-tei": o_tei,
+                    "ms-address": ms, "peer-address": "192.0.2.5"})
+
+    iteis = _iteis(_contexts(gtp, link))
+    ksft_in(0x111, iteis)
+    ksft_in(0x112, iteis)
+
+    gtp.delpdp({"link": link, "version": 1, "ms-address": "10.0.1.1"})
+    iteis = _iteis(_contexts(gtp, link))
+    ksft_not_in(0x111, iteis)
+    ksft_in(0x112, iteis)
+
+
+def del_unknown_pdp(ns) -> None:
+    """Deleting a context that was never added must fail with ENOENT.
+
+    Both lookups are checked: by TEI, and by MS address.
+    """
+    gtp, link = _setup(ns)
+
+    for attrs in ({"i-tei": 0x999}, {"ms-address": "10.9.9.9"}):
+        with ksft_raises(NlError) as cm:
+            gtp.delpdp({"link": link, "version": 1, **attrs})
+        ksft_eq(cm.exception.error, errno.ENOENT)
+
+
+def main() -> None:
+    """Run the PDP context tests in a temporary netns."""
+    with NetNS() as ns:
+        ksft_run([add_del_pdp, add_two_pdp, del_unknown_pdp], args=(ns,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 71df5880b356..e269a260d58e 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -18,7 +18,7 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily, RtnlRouteFamily
-from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
+from .ynl import NetshaperFamily, DevlinkFamily, GtpFamily, PSPFamily, Netlink
 
 __all__ = ["KSRC",
            "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
@@ -32,6 +32,7 @@ __all__ = ["KSRC",
            "wait_port_listen", "ctl_file_write", "wait_file", "tool", "tc",
            "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
            "NetdevSim", "NetdevSimDev",
-           "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
+           "NetshaperFamily", "DevlinkFamily", "GtpFamily", "PSPFamily",
+           "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
            "NlctrlFamily", "RtnlAddrFamily", "RtnlRouteFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 08deff756f29..7edb74971023 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -31,7 +31,7 @@ __all__ = [
     "NlError", "NlPolicy", "Netlink", "YnlFamily", "SPEC_PATH",
     "EthtoolFamily", "RtnlFamily", "RtnlAddrFamily", "RtnlRouteFamily",
     "NetdevFamily", "NetshaperFamily", "NlctrlFamily", "DevlinkFamily",
-    "PSPFamily",
+    "GtpFamily", "PSPFamily",
 ]
 
 #
@@ -85,3 +85,9 @@ class PSPFamily(YnlFamily):
     def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('psp.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
+
+
+class GtpFamily(YnlFamily):
+    def __init__(self, recv_size=0):
+        super().__init__((SPEC_PATH / Path('gtp.yaml')).as_posix(),
+                         schema='', recv_size=recv_size)
-- 
2.25.1

