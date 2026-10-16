Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A76475356
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143179; cv=none; b=TAnKrMOxfvfRx2muWj3ifXsf/5GY7RrpwoWzBiyjp1XT5fgZ7UQrJsdZjzJ0Gy7h9wyfvmB3yyyoidDy9+OXcsli3F9DHo4V0mzrdA+CRFcy+jyUAsxNzStOS7e+/rdx2aD3hUDr8vXcryPgX+OSE9F85ij9t2qBj0IGGHtCQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143179; c=relaxed/simple;
	bh=WL3wUIMkwwoPY1trwqCqPuiTCJPxhOE48Ga4j+J8YxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZ9GW4j29C3gbGoZlMtGh68YtDFk6vc+LY54qsfDKlRuZ7s2RB4fZOGzQT/RqhNrwHlIq7tJAwdxV2u+9hhOSgXesFqZy0brlNOHaC4B8WgQNYh0SRo61lBiXktLOYMLteFc9OFc6H1EHyNGIxp9BZe/aOwCrgaSzv7tG5ITzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwnG2uY7; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwnG2uY7"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15756f82e8aso553838c88.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143176; x=1792747976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hejOVt37x/utq4gG5Lp53Db9B5jQdRD2zxHIuxDYm5c=;
        b=cwnG2uY7FEsnSsDJH9ph5p2KvAI6Pj6PySZSzu94Yyd+TxRxQZb9F6Sy7fpOZr7+Pe
         WNAAN49JIL2vxoRWyQjBSqxyo+rdJzJqgvDJ/yugpJNwaiumZzSRJcDv0FY0j8UqnEdw
         t/CifHxeHF5CTINTy3liWZAtB3ZMLNhtmkABq+wLStr6HdlCNuOhcdK3+KYWK7nblclE
         yGZ8HGkWYuXAeY8wy6qKiIUyjpe+DvWkW6/4EMNxmboYYZ6O20XdPTc06Q11mB+typGm
         eFncXbrA38FQ+cwzCWky5RiYFs3CjZjXErdKDhrssu2JN/xrAKH8McJczJt8lz+AOdxw
         HsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143176; x=1792747976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hejOVt37x/utq4gG5Lp53Db9B5jQdRD2zxHIuxDYm5c=;
        b=PnMTm3C9bhuI1ygc9n4dLbj3CwadY6/IEE4g6iRRt2rPS1FLZ736VtG92Gid0IPtbz
         QMZjPhJErRKM3nTqGF62mbEQqaQyMf3ncl0V+4PnS75uX2wgSkw+NCcZT/rEpdrIt40l
         JiBBb8HM0/X+KWlLZaEsp6EJBmip7OkObfUSCVg39VYvgONPwgT3KqQk4mRt/b31Zk99
         PprRj55awysvMz4v7mBJAy9lY7kVgt0te8epULdrNwZpw3ZoQoF5LKpwVuUDjw9+8us3
         Byuni4XVK/3lUdpegl3G2QtMyt0N/yQDl9Vi5nAe/taxpW06KhghiJ+mSuNPgOqVYR5Y
         P+XA==
X-Forwarded-Encrypted: i=1; AKwUvByPGlKH2C5htVNLrfD8U1kIPRfKrsMsbcrjAkShz4EaWO8NyWdJsvUe+Fxqxg0T0Jqf4sGY9E0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSyoW7hNm3OPaDQrVy5T7ynR+yfTnSTGdx0GpHEZr3WxxXpIx3
	tFmwPhaI/dnxEe1EW/mqQ/kjdCQ/1mJvrKCj8DreZJ57m2qjVUjIv8rj
X-Gm-Gg: AYBFou2Rv6qllhHCp7e38e4Sy1PYd+OvGl6AUY45fb2Un3k8M7/0qKrM9kvCALKeKp3
	VPZ/bN4ZAVOJOMymotHeBreMOVgnNMF9Orlh/dPquiDHkxL/uyFzT8IxVLYX07142ChBczdLRc/
	fA8QRvfugbxM2U8rsEAkl675/URD8O7y3942WhSEzkLD0FVqTSX0y5IoA2g7IkSAo2h+MeE2feq
	H/GhXwZvVhRTgge/GQ8FNQNrbg+lLmphoqYplSd1Hx2AV6NdID36rfE2r85Cm5YYMrv3OR63nSP
	G+M4JRqDDhdBKsVxJIlXtIY1HosUU+ysarwXMt9uKyWYZmGofLd3ezXcT0T2/umEuc4IsKJzEbi
	n3QNWi4/8EtwAupflbSJZKoMbhDJgRbPp+mm8bXFrEZgKkNnrf5Hcc4N4MVy3Y7FAGKNt+u+OT8
	1hEg4tWMsHHOCklD2WTtc6jBBjYuOCKsAPJV9bbfiyowTLYDpg0YgqYX6ovx/O1jKv5llzC6Htb
	gIy9DtRprrJkpNssNLPT2yAei+EHmtPCwYvKqGcyyAZXcj92yEIufAuHA+GOkjTG8kE8WEoP+of
	QpY2hNVRVUtPo5Z4WZ8sILuRYs4vpLKFqYPzZZmASyg=
X-Received: by 2002:a05:701b:2405:b0:155:734:9cc9 with SMTP id a92af1059eb24-1825a19724dmr3014474c88.16.1792143175843;
        Fri, 16 Oct 2026 02:32:55 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm5157172eec.18.2026.10.16.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:32:55 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v7 4/4] selftests: net: add a test for the gtp netlink family
Date: Fri, 16 Oct 2026 09:32:25 +0000
Message-Id: <20261016093225.1036375-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016093225.1036375-1-anilkaushikwireless@gmail.com>
References: <20261016093225.1036375-1-anilkaushikwireless@gmail.com>
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
The test is skipped when the kernel or iproute2 lack GTP support; any
other failure to create the device fails it.

Add a GtpFamily ynl wrapper and register the test.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/gtp.py            | 123 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   9 +-
 6 files changed, 137 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/gtp.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 42df33aea837..8489c37f06fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11424,6 +11424,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp.git
 F:	Documentation/netlink/specs/gtp.yaml
 F:	drivers/net/gtp.c
+F:	tools/testing/selftests/net/gtp.py
 
 GUID PARTITION TABLE (GPT)
 M:	Davidlohr Bueso <dave@stgolabs.net>
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 54beea2e348c..df5bcc55ea8e 100644
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
index d355cf980597..cb8cb4696df7 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -16,6 +16,7 @@ CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_DUMMY=y
 CONFIG_GENEVE=m
+CONFIG_GTP=m
 CONFIG_IFB=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_ESP=y
diff --git a/tools/testing/selftests/net/gtp.py b/tools/testing/selftests/net/gtp.py
new file mode 100755
index 000000000000..d793ca7b70d2
--- /dev/null
+++ b/tools/testing/selftests/net/gtp.py
@@ -0,0 +1,123 @@
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
+_NO_GTP_ERRORS = ("Unknown device type", "Operation not supported",
+                  "Garbage instead of arguments")
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
+        # gtp.ko not available, or iproute2 without gtp support: any other
+        # failure to create the device is a real error.
+        if not any(msg in e.cmd.stderr for msg in _NO_GTP_ERRORS):
+            raise
+        raise KsftSkipEx("no gtp support (CONFIG_GTP, iproute2)") from e
+    defer(ip, "link del gtp0", ns=str(ns))
+    ip("link set gtp0 up", ns=str(ns))
+    link = ip("-d link show gtp0", ns=str(ns), json=True)[0]["ifindex"]
+
+    with NetNSEnter(str(ns)):
+        gtp = GtpFamily()
+    defer(gtp.close)
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
index 08deff756f29..69a6e9d9b390 100644
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
@@ -85,3 +85,10 @@ class PSPFamily(YnlFamily):
     def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('psp.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
+
+
+class GtpFamily(YnlFamily):
+    """YNL family for gtp, see Documentation/netlink/specs/gtp.yaml."""
+    def __init__(self, recv_size=0):
+        super().__init__((SPEC_PATH / Path('gtp.yaml')).as_posix(),
+                         schema='', recv_size=recv_size)
-- 
2.25.1

