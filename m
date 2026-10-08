Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E623C0603
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483088; cv=none; b=PTV2JJHeWAN6VhXABb4i5dJlUuU4wf8W3qf5hWe3JgtndIO1pjCWwYOJTtvdf634O+c/z7SWGeaCTLxNiWBTyRM11iVwkwYDMYvtQbA+Hyaw/aWSzYDtMCUzlXuLu8vHxLvIPK1GcqwicHWcRfWVlwkvFxojCO8wiGD8LK/FHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483088; c=relaxed/simple;
	bh=b4bJJKMYnnSOZWTAtIMwW+0Ztt7/kwnxaA42k+pn6iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4mi+uG4DFfhjXRXNb5sbBk3zqewhvvveIEwgbtLGGvANaRDzthCbl6eBPM89nhUcuePywO9QopzxQ+1aSU8ZgAa1l903nAJ/NAZs759qxhtnJq+kx6zddlB3qkm2fc6K6XZOpQARbbXsJFudvZNT1pjP/78Nh2ZRw1btxLxkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cisoz62c; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cisoz62c"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-351775aa1c0so1734557eec.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483086; x=1792087886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oyDOMjXTDjzVI9PeVZYX8DHF8ljnr1gWYCLzLBAx5do=;
        b=Cisoz62c9+vWlaEC/QDZLaeAVFbUr+4POVYvhGBhHafTc19qf5/FE1Wme8censWLth
         6J1k/OkuQkMz/uoJFE7wTik06oom6zm4XwA15gRqh+ivGZnMsfJkag7ScgPOsHAj7sBg
         n+NT9beczedcaeh2/cFwdfpXlqh+7nHWoBTn304tJkJAARmtahdNuU2eWLp/dm8juZqM
         ChEMYiWKmYYVHhx13trAreCQagpC226B4RmM9ORcJj9nYS7TaweZrVDWurvcdPH3hKzr
         ttpItLF0TcsAhTCi0AsDN2qohsf0sC0s0TLnEPUdAOJ1yRUyr/fj5wvG5kEdnpAfejdO
         W58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483086; x=1792087886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oyDOMjXTDjzVI9PeVZYX8DHF8ljnr1gWYCLzLBAx5do=;
        b=D6RS9iv51QHtPijcnx3/H499uVBRD3QxLbJ0w+YPZW2vK7j6Wcx/xKFrRrvz2OcUTy
         3UIWhGe+AO9HMgnxh5cdQlWOmNEaG6Qw9HvNMSqJs9AYzeRiCRY/Qj+G90r+XyK7rqiy
         IYcTcL1SFYL4dGnkwk0g87eHWdD7wLG6Y9Z+lfVE3yu5EjgCe1RcCUPlhoPCYjTnIRCs
         jnvxNtNXChuAxOEOLOSfbS5BxHoX8A995kNRdyc00iHLRUBHP6dabWHnGH0acM/ZBuw5
         EvspMLXkJC9vKYT0ciUpkwImC7FnB7O+QI9W0nkIMuP5LOqzwaRKLmJJJXQqjC4cgOdZ
         S9cQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCgKpjT1WNFVl8Ol2NA53tK7saTPKvMWp7KyGTj/9oS+Q64D2kVCwaUu3+O5+/mCykjrMrmKA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIU0GsJAnILBjoqwLxudcacWc9pBiXUOjI7mQZO1URktxz11iYt
	ggv1ZK6gHGaLuJ+6W6WlyCv2jH/W0fYx3iogXH5oj/wOkb8fUSM2L3NG
X-Gm-Gg: AYBFou0PIMdihRjUGAWo9L7T+f6hytAzlrvaUYxGiimvH9MK0jd8W6PDyT6fbHzNhOE
	mZI2owPP7ikvOFcJ8drURq22j1QfRv+UYLQodgjrGEIjLpl9G19DEJwiKCOHUpP7T29sX0Wi4c+
	1aYoRFYjGHZWlxtF16xpwI+XWnG4YmkOcFCp8zC/uOArSjlhGPRy1DtuNjgfWYuH9y0ODY+7jYx
	7R4x9nI8Bz5e0xw9q5oYAkxnO43YEgYYr/Yspu42GVCJPSPy3BF1kQFoyb2AQspRTphrKTzWhak
	vv5If9ErmwaMIPTVGSq+xt6IpNuyIV2HkoCVI8vrlGoSzqUN760/mCp3ZAzKYntmYrehw5e8/69
	MT1LUmD+syne2RF4RHSvDhxIzMU6MnREVZ1K+rIlxQzQlA5nF5G34V8j4zw6bp916/t+3657tSV
	I9vg0RkVbH30EzG/uFl6mUTVO38UbPhZgn6pvOKgoHaUmnbq0kcriFU6EnwzCHdtv6D9l/VeHlp
	ulwSAj2bec9Qv9hiAGTR6PVvbDlxv7DCAmtIX2u+A9DeZLeYYHpXWStsvnNWKWyErBhAPLIdxtq
	1bymu0n0NMYFsm7rD7jl9x8S4kCIXphIwu00sFB2VYE=
X-Received: by 2002:a05:693c:41d3:10b0:351:68e8:4646 with SMTP id 5a478bee46e88-35168e84af3mr5366804eec.37.1791483085641;
        Thu, 08 Oct 2026 11:11:25 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b479e76sm162161eec.26.2026.10.08.11.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:11:25 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v2 3/3] selftests: net: add a test for the gtp netlink family
Date: Thu,  8 Oct 2026 18:10:31 +0000
Message-Id: <20261008181031.4129029-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008181031.4129029-1-anilkaushikwireless@gmail.com>
References: <20261008181031.4129029-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the gtp generic netlink family through its ynl spec: create a
gtp device, add a PDP context with newpdp, check getpdp lists it and
delpdp removes it. Two more cases check that two contexts are dumped and
that deleting an unknown context fails.

Add a GtpFamily ynl wrapper and register the test.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/net/Makefile          |  1 +
 tools/testing/selftests/net/gtp.py            | 77 +++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |  5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  8 +-
 5 files changed, 89 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/gtp.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a6e43995e..8ac817a78 100644
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
index d4ca82fec..5366de878 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -44,6 +44,7 @@ TEST_PROGS := \
 	fin_ack_lat.sh \
 	fou_mcast_encap.sh \
 	fq_band_pktlimit.sh \
+	gtp.py \
 	gre_gso.sh \
 	gre_ipv6_lladdr.sh \
 	icmp.sh \
diff --git a/tools/testing/selftests/net/gtp.py b/tools/testing/selftests/net/gtp.py
new file mode 100644
index 000000000..984c626b7
--- /dev/null
+++ b/tools/testing/selftests/net/gtp.py
@@ -0,0 +1,77 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Tests for the gtp netlink family."""
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
+def _add_gtp_dev(ns):
+    try:
+        ip("link add gtp0 type gtp role ggsn", ns=str(ns))
+    except CmdExitFailure:
+        raise KsftSkipEx("no gtp support (CONFIG_GTP, iproute2)")
+    defer(ip, "link del gtp0", ns=str(ns))
+    ip("link set gtp0 up", ns=str(ns))
+    return ip("-d link show gtp0", ns=str(ns), json=True)[0]["ifindex"]
+
+
+def _iteis(contexts):
+    return [c.get("i-tei") for c in contexts]
+
+
+def add_del_pdp(gtp, ns) -> None:
+    link = _add_gtp_dev(ns)
+
+    gtp.newpdp({"link": link, "version": 1,
+                "i-tei": 0x100, "o-tei": 0x200,
+                "ms-address": "10.0.0.1", "peer-address": "192.0.2.1"})
+
+    pdp = [c for c in gtp.getpdp({}, dump=True) if c.get("i-tei") == 0x100]
+    ksft_eq(len(pdp), 1)
+    ksft_eq(pdp[0]["o-tei"], 0x200)
+    ksft_eq(pdp[0]["ms-address"], "10.0.0.1")
+    ksft_eq(pdp[0]["peer-address"], "192.0.2.1")
+
+    gtp.delpdp({"link": link, "version": 1,
+                "i-tei": 0x100, "ms-address": "10.0.0.1"})
+    ksft_not_in(0x100, _iteis(gtp.getpdp({}, dump=True)))
+
+
+def add_two_pdp(gtp, ns) -> None:
+    link = _add_gtp_dev(ns)
+
+    for i_tei, o_tei, ms in ((0x111, 0x211, "10.0.1.1"),
+                             (0x112, 0x212, "10.0.1.2")):
+        gtp.newpdp({"link": link, "version": 1,
+                    "i-tei": i_tei, "o-tei": o_tei,
+                    "ms-address": ms, "peer-address": "192.0.2.5"})
+
+    iteis = _iteis(gtp.getpdp({}, dump=True))
+    ksft_in(0x111, iteis)
+    ksft_in(0x112, iteis)
+
+
+def del_unknown_pdp(gtp, ns) -> None:
+    link = _add_gtp_dev(ns)
+    with ksft_raises(NlError):
+        gtp.delpdp({"link": link, "version": 1,
+                    "i-tei": 0x999, "ms-address": "10.9.9.9"})
+
+
+def main() -> None:
+    with NetNS() as ns:
+        with NetNSEnter(str(ns)):
+            gtp = GtpFamily()
+        ksft_run([add_del_pdp, add_two_pdp, del_unknown_pdp], args=(gtp, ns))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 71df5880b..8d34f2659 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -18,7 +18,7 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily, RtnlRouteFamily
-from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
+from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, GtpFamily, Netlink
 
 __all__ = ["KSRC",
            "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
@@ -32,6 +32,7 @@ __all__ = ["KSRC",
            "wait_port_listen", "ctl_file_write", "wait_file", "tool", "tc",
            "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
            "NetdevSim", "NetdevSimDev",
-           "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
+           "NetshaperFamily", "DevlinkFamily", "PSPFamily", "GtpFamily",
+           "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
            "NlctrlFamily", "RtnlAddrFamily", "RtnlRouteFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 08deff756..492994812 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -31,7 +31,7 @@ __all__ = [
     "NlError", "NlPolicy", "Netlink", "YnlFamily", "SPEC_PATH",
     "EthtoolFamily", "RtnlFamily", "RtnlAddrFamily", "RtnlRouteFamily",
     "NetdevFamily", "NetshaperFamily", "NlctrlFamily", "DevlinkFamily",
-    "PSPFamily",
+    "PSPFamily", "GtpFamily",
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

