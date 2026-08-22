Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D994390C9F
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439335; cv=none; b=Cng9j1QT+bNZZG+p9R5zneXYtb9uiKvgWQQdrjvtgZHfRg+KxD6QH849jmDNBGHys5SRPm1WeFiHIizohTTYeKanw0dtP1B8l4cyWX0fDv85AIc27cEJfQUvzWF3KH7oCYl9QRUleJbs49m7psFnUvAw/G8k8uF7GovmhkeKyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439335; c=relaxed/simple;
	bh=74mLSrK5UQSx/qcETeRMXK7bmUjPJyJn8k3a/+8vDFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YU9+6AfUIVn7Vmu8/xvG4tvOe5D0413hQjomNdks17kowMnlCp1nNCSYeWlm54nitioNt6Wr3pkgcFeiABojvmt5EmvE9hqBmms/4XXefb51MJkldKMGQya61TOEplY0FW97tl9Yd4bhhJs4fR3M5Gta3bVeaL54Mv4hvHre6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btY6cFxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btY6cFxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39801F00A3F;
	Sat, 22 Aug 2026 22:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439333;
	bh=Cq6K4wGrrHvmKBcdWMvAyfCeKV/UdgrA1F99mB/jjIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=btY6cFxcYoLnIeIqwG5Dx5xgagsBUakVKpoLcOfhbDGQtLaUmbzFEh0f1EPJydpsN
	 UQXFNOEJw2Z+j237SmHQk/IvC1z2c/hmXeRLVWs+F5WDgJI8Wz6lSu9pmU6v6b2M7v
	 tNx3H3vurtktX5B8oridw1xWYZ1J54YyDi9pTdwOeUWVu52eoiBFzxmgmHbaGqhLya
	 VMOX38Gqi+kQbC5FumRQuUaqBhiPtH4QnIyhxugVPue/51rEHXgdztr7eGhZ6XsVS9
	 s0iRf/j0o5pf2F+x0F/B7heOxwFWEl6SvmVer/ySJ4UFB4u1FWAlnVZ9iczb6DxGBM
	 3o/obMi2XwIdw==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com,
	cratiu@nvidia.com,
	borisp@nvidia.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 3/6] selftests: drv-net: psp: move the PSP test plumbing into psp_lib.py
Date: Sat, 22 Aug 2026 15:55:21 -0700
Message-ID: <20260822225524.2328465-4-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822225524.2328465-1-kuba@kernel.org>
References: <20260822225524.2328465-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pure refactor, no behaviour change. A second PSP test is coming and
would otherwise need byte-identical copies of the responder chatter,
connection setup and data helpers.

Only what would be copied verbatim moves; the test cases and everything
specific to them stay in psp.py. main()'s responder spawning becomes a
context manager, which is the one place the shape changes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   4 +
 tools/testing/selftests/drivers/net/psp.py    | 287 +++++-------------
 .../testing/selftests/drivers/net/psp_lib.py  | 179 +++++++++++
 4 files changed, 265 insertions(+), 206 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/psp_lib.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 460cb7268845..536fbc1d244d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21770,6 +21770,7 @@ F:	include/net/psp/
 F:	include/net/psp.h
 F:	include/uapi/linux/psp.h
 F:	net/psp/
+F:	tools/testing/selftests/drivers/net/psp*
 K:	struct\ psp(_assoc|_dev|hdr)\b
 
 PSTORE FILESYSTEM
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index d5bf4cb638a8..de6e4d7f2dda 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -27,6 +27,10 @@ TEST_PROGS := \
 	xdp.py \
 # end of TEST_PROGS
 
+TEST_FILES := \
+	psp_lib.py \
+	#
+
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := psp_responder
 TEST_GEN_FILES += $(YNL_GEN_FILES)
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 315648a770d0..766d263803b1 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -4,11 +4,8 @@
 """Test suite for PSP capable drivers."""
 
 import errno
-import fcntl
 import os
 import socket
-import struct
-import termios
 import time
 
 from lib.py import defer
@@ -20,136 +17,38 @@ from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import NetDrvEpEnv, NetDrvContEnv
 from lib.py import Netlink, NlError, PSPFamily, RtnlFamily
 from lib.py import NetNSEnter
-from lib.py import bkg, rand_port, wait_port_listen
 from lib.py import ip
 
-
-def _get_outq(s):
-    one = b'\0' * 4
-    outq = fcntl.ioctl(s.fileno(), termios.TIOCOUTQ, one)
-    return struct.unpack("I", outq)[0]
-
-
-def _send_with_ack(cfg, msg):
-    cfg.comm_sock.send(msg)
-    response = cfg.comm_sock.recv(4)
-    if response != b'ack\0':
-        raise RuntimeError("Unexpected server response", response)
-
-
-def _remote_read_len(cfg):
-    cfg.comm_sock.send(b'read len\0')
-    return int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
-
-
-def _make_clr_conn(cfg, ipver=None):
-    _send_with_ack(cfg, b'conn clr\0')
-    remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
-    s = socket.create_connection((remote_addr, cfg.comm_port), )
-    return s
-
-
-def _make_psp_conn(cfg, version=0, ipver=None):
-    _send_with_ack(cfg, b'conn psp\0' + struct.pack('BB', version, version))
-    remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
-    s = socket.create_connection((remote_addr, cfg.comm_port), )
-    return s
-
-
-def _close_conn(cfg, s):
-    _send_with_ack(cfg, b'data close\0')
-    s.close()
+from psp_lib import check_data_rx, close_conn, get_outq, get_stat, \
+    init_psp_dev, make_clr_conn, make_psp_conn, send_careful, spi_xchg
+from psp_lib import responder as psp_responder
 
 
 def _close_psp_conn(cfg, s):
-    _close_conn(cfg, s)
-
-
-def _spi_xchg(s, rx):
-    s.send(struct.pack('I', rx['spi']) + rx['key'])
-    tx = s.recv(4 + len(rx['key']))
-    return {
-        'spi': struct.unpack('I', tx[:4])[0],
-        'key': tx[4:]
-    }
-
-
-def _send_careful(cfg, s, rounds):
-    data = b'0123456789' * 200
-    for i in range(rounds):
-        n = 0
-        for _ in range(10): # allow 10 retries
-            try:
-                n += s.send(data[n:], socket.MSG_DONTWAIT)
-                if n == len(data):
-                    break
-            except BlockingIOError:
-                time.sleep(0.05)
-        else:
-            rlen = _remote_read_len(cfg)
-            outq = _get_outq(s)
-            report = f'sent: {i * len(data) + n} remote len: {rlen} outq: {outq}'
-            raise RuntimeError(report)
-
-    return len(data) * rounds
-
-
-def _check_data_rx(cfg, exp_len):
-    read_len = -1
-    for _ in range(30):
-        cfg.comm_sock.send(b'read len\0')
-        read_len = int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
-        if read_len == exp_len:
-            break
-        time.sleep(0.01)
-    ksft_eq(read_len, exp_len)
+    close_conn(cfg, s)
 
 
 def _check_data_outq(s, exp_len, force_wait=False):
     outq = 0
     for _ in range(10):
-        outq = _get_outq(s)
+        outq = get_outq(s)
         if not force_wait and outq == exp_len:
             break
         time.sleep(0.01)
     ksft_eq(outq, exp_len)
 
 
-def _get_stat(cfg, key):
-    return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
-
 #
 # Test case boiler plate
 #
 
-def _init_psp_dev(cfg, use_psp_ifindex=False):
-    if not hasattr(cfg, 'psp_dev_id'):
-        # Figure out which local device we are testing against
-        # For NetDrvContEnv: use psp_ifindex instead of ifindex
-        target_ifindex = cfg.psp_ifindex if use_psp_ifindex else cfg.ifindex
-        for dev in cfg.pspnl.dev_get({}, dump=True):
-            if dev['ifindex'] == target_ifindex:
-                cfg.psp_info = dev
-                cfg.psp_dev_id = cfg.psp_info['id']
-                break
-        else:
-            raise KsftSkipEx("No PSP devices found")
-
-    # Enable PSP if necessary
-    cap = cfg.psp_info['psp-versions-cap']
-    ena = cfg.psp_info['psp-versions-ena']
-    if cap != ena:
-        cfg.pspnl.dev_set({'id': cfg.psp_dev_id, 'psp-versions-ena': cap})
-        defer(cfg.pspnl.dev_set, {'id': cfg.psp_dev_id,
-                                  'psp-versions-ena': ena })
-
 #
 # Test cases
 #
 
 def dev_list_devices(cfg):
     """ Dump all devices """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     devices = cfg.pspnl.dev_get({}, dump=True)
 
@@ -161,7 +60,7 @@ from lib.py import ip
 
 def dev_get_device(cfg):
     """ Get the device we intend to use """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
     ksft_eq(dev['id'], cfg.psp_dev_id)
@@ -180,22 +79,22 @@ from lib.py import ip
 
 def dev_rotate(cfg):
     """ Test key rotation """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
-    prev_rotations = _get_stat(cfg, 'key-rotations')
+    prev_rotations = get_stat(cfg, 'key-rotations')
 
     rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
     ksft_eq(rot['id'], cfg.psp_dev_id)
     rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
     ksft_eq(rot['id'], cfg.psp_dev_id)
 
-    cur_rotations = _get_stat(cfg, 'key-rotations')
+    cur_rotations = get_stat(cfg, 'key-rotations')
     ksft_eq(cur_rotations, prev_rotations + 2)
 
 
 def dev_rotate_spi(cfg):
     """ Test key rotation and SPI check """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     top_a = top_b = 0
     with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
@@ -217,7 +116,7 @@ from lib.py import ip
 
 def assoc_basic(cfg):
     """ Test creating associations """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
         assoc = cfg.pspnl.rx_assoc({"version": 0,
@@ -237,7 +136,7 @@ from lib.py import ip
 
 def assoc_bad_dev(cfg):
     """ Test creating associations with bad device ID """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
         with ksft_raises(NlError) as cm:
@@ -249,23 +148,23 @@ from lib.py import ip
 
 def assoc_sk_only_conn(cfg):
     """ Test creating associations based on socket """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
-    with _make_clr_conn(cfg) as s:
+    with make_clr_conn(cfg) as s:
         assoc = cfg.pspnl.rx_assoc({"version": 0,
                                   "sock-fd": s.fileno()})
         ksft_eq(assoc['dev-id'], cfg.psp_dev_id)
         cfg.pspnl.tx_assoc({"version": 0,
                           "tx-key": assoc['rx-key'],
                           "sock-fd": s.fileno()})
-        _close_conn(cfg, s)
+        close_conn(cfg, s)
 
 
 def assoc_sk_only_mismatch(cfg):
     """ Test creating associations based on socket (dev mismatch) """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
-    with _make_clr_conn(cfg) as s:
+    with make_clr_conn(cfg) as s:
         with ksft_raises(NlError) as cm:
             cfg.pspnl.rx_assoc({"version": 0,
                               "dev-id": cfg.psp_dev_id + 1234567,
@@ -273,14 +172,14 @@ from lib.py import ip
         the_exception = cm.exception
         ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
         ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
-        _close_conn(cfg, s)
+        close_conn(cfg, s)
 
 
 def assoc_sk_only_mismatch_tx(cfg):
     """ Test creating associations based on socket (dev mismatch) """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
-    with _make_clr_conn(cfg) as s:
+    with make_clr_conn(cfg) as s:
         with ksft_raises(NlError) as cm:
             assoc = cfg.pspnl.rx_assoc({"version": 0,
                                       "sock-fd": s.fileno()})
@@ -291,12 +190,12 @@ from lib.py import ip
         the_exception = cm.exception
         ksft_eq(the_exception.nl_msg.extack['bad-attr'], ".dev-id")
         ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
-        _close_conn(cfg, s)
+        close_conn(cfg, s)
 
 
 def assoc_sk_only_unconn(cfg):
     """ Test creating associations based on socket (unconnected, should fail) """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
         with ksft_raises(NlError) as cm:
@@ -309,7 +208,7 @@ from lib.py import ip
 
 def assoc_version_mismatch(cfg):
     """ Test creating associations where Rx and Tx PSP versions do not match """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     versions = list(cfg.psp_info['psp-versions-cap'])
     if len(versions) < 2:
@@ -335,7 +234,7 @@ from lib.py import ip
 
 def assoc_twice(cfg):
     """ Test reusing Tx assoc for two sockets """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     def rx_assoc_check(s):
         assoc = cfg.pspnl.rx_assoc({"version": 0,
@@ -369,7 +268,7 @@ from lib.py import ip
 
 def _data_basic_send(cfg, version, ipver):
     """ Test basic data send """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     # Version 0 is required by spec, don't let it skip
     if version:
@@ -383,21 +282,21 @@ from lib.py import ip
                 ksft_eq(cm.exception.nl_msg.error, -errno.EOPNOTSUPP)
             raise KsftSkipEx("PSP version not supported", name)
 
-    s = _make_psp_conn(cfg, version, ipver)
+    s = make_psp_conn(cfg, version, ipver)
 
     rx_assoc = cfg.pspnl.rx_assoc({"version": version,
                                    "dev-id": cfg.psp_dev_id,
                                    "sock-fd": s.fileno()})
     rx = rx_assoc['rx-key']
-    tx = _spi_xchg(s, rx)
+    tx = spi_xchg(s, rx)
 
     cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
                         "version": version,
                         "tx-key": tx,
                         "sock-fd": s.fileno()})
 
-    data_len = _send_careful(cfg, s, 100)
-    _check_data_rx(cfg, data_len)
+    data_len = send_careful(cfg, s, 100)
+    check_data_rx(cfg, data_len)
     _close_psp_conn(cfg, s)
 
 
@@ -410,63 +309,63 @@ from lib.py import ip
                         "tx-key": tx,
                         "sock-fd": s.fileno()})
 
-    data_len = _send_careful(cfg, s, 20)
+    data_len = send_careful(cfg, s, 20)
     _check_data_outq(s, data_len, force_wait=True)
-    _check_data_rx(cfg, 0)
+    check_data_rx(cfg, 0)
     _close_psp_conn(cfg, s)
 
 
 def data_send_bad_key(cfg):
     """ Test send data with bad key """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
-    s = _make_psp_conn(cfg)
+    s = make_psp_conn(cfg)
 
     rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
                                    "dev-id": cfg.psp_dev_id,
                                    "sock-fd": s.fileno()})
     rx = rx_assoc['rx-key']
-    tx = _spi_xchg(s, rx)
+    tx = spi_xchg(s, rx)
     tx['key'] = (tx['key'][0] ^ 0xff).to_bytes(1, 'little') + tx['key'][1:]
     __bad_xfer_do(cfg, s, tx)
 
 
 def data_send_disconnect(cfg):
     """ Test socket close after sending data """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
-    with _make_psp_conn(cfg) as s:
+    with make_psp_conn(cfg) as s:
         assoc = cfg.pspnl.rx_assoc({"version": 0,
                                   "sock-fd": s.fileno()})
-        tx = _spi_xchg(s, assoc['rx-key'])
+        tx = spi_xchg(s, assoc['rx-key'])
         cfg.pspnl.tx_assoc({"version": 0,
                           "tx-key": tx,
                           "sock-fd": s.fileno()})
 
-        data_len = _send_careful(cfg, s, 100)
-        _check_data_rx(cfg, data_len)
+        data_len = send_careful(cfg, s, 100)
+        check_data_rx(cfg, data_len)
 
         s.shutdown(socket.SHUT_RDWR)
         s.close()
 
 
 def _data_mss_adjust(cfg, ipver):
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
     # First figure out what the MSS would be without any adjustments
-    s = _make_clr_conn(cfg, ipver)
+    s = make_clr_conn(cfg, ipver)
     s.send(b"0123456789abcdef" * 1024)
-    _check_data_rx(cfg, 16 * 1024)
+    check_data_rx(cfg, 16 * 1024)
     mss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
-    _close_conn(cfg, s)
+    close_conn(cfg, s)
 
-    s = _make_psp_conn(cfg, 0, ipver)
+    s = make_psp_conn(cfg, 0, ipver)
     try:
         rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
                                      "dev-id": cfg.psp_dev_id,
                                      "sock-fd": s.fileno()})
         rx = rx_assoc['rx-key']
-        tx = _spi_xchg(s, rx)
+        tx = spi_xchg(s, rx)
 
         rxmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
         ksft_eq(mss, rxmss)
@@ -479,8 +378,8 @@ from lib.py import ip
         txmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
         ksft_eq(mss, txmss + 40)
 
-        data_len = _send_careful(cfg, s, 100)
-        _check_data_rx(cfg, data_len)
+        data_len = send_careful(cfg, s, 100)
+        check_data_rx(cfg, data_len)
         _check_data_outq(s, 0)
 
         txmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
@@ -491,30 +390,30 @@ from lib.py import ip
 
 def data_stale_key(cfg):
     """ Test send on a double-rotated key """
-    _init_psp_dev(cfg)
+    init_psp_dev(cfg)
 
-    prev_stale = _get_stat(cfg, 'stale-events')
-    s = _make_psp_conn(cfg)
+    prev_stale = get_stat(cfg, 'stale-events')
+    s = make_psp_conn(cfg)
     try:
         rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
                                      "dev-id": cfg.psp_dev_id,
                                      "sock-fd": s.fileno()})
         rx = rx_assoc['rx-key']
-        tx = _spi_xchg(s, rx)
+        tx = spi_xchg(s, rx)
 
         cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
                           "version": 0,
                           "tx-key": tx,
                           "sock-fd": s.fileno()})
 
-        data_len = _send_careful(cfg, s, 100)
-        _check_data_rx(cfg, data_len)
+        data_len = send_careful(cfg, s, 100)
+        check_data_rx(cfg, data_len)
         _check_data_outq(s, 0)
 
         cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
         cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
 
-        cur_stale = _get_stat(cfg, 'stale-events')
+        cur_stale = get_stat(cfg, 'stale-events')
         ksft_gt(cur_stale, prev_stale)
 
         s.send(b'0123456789' * 200)
@@ -544,7 +443,7 @@ from lib.py import ip
     # netdevsim only for now
     cfg.require_nsim()
 
-    s = _make_clr_conn(cfg)
+    s = make_clr_conn(cfg)
     try:
         rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
                                        "dev-id": cfg.psp_dev_id,
@@ -553,7 +452,7 @@ from lib.py import ip
 
         __nsim_psp_rereg(cfg)
     finally:
-        _close_conn(cfg, s)
+        close_conn(cfg, s)
 
 
 def removal_device_bi(cfg):
@@ -564,7 +463,7 @@ from lib.py import ip
     # netdevsim only for now
     cfg.require_nsim()
 
-    s = _make_clr_conn(cfg)
+    s = make_clr_conn(cfg)
     try:
         rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
                                        "dev-id": cfg.psp_dev_id,
@@ -575,7 +474,7 @@ from lib.py import ip
                             "sock-fd": s.fileno()})
         __nsim_psp_rereg(cfg)
     finally:
-        _close_conn(cfg, s)
+        close_conn(cfg, s)
 
 
 def _get_psp_ver_ip_variants():
@@ -631,21 +530,21 @@ from lib.py import ip
     with NetNSEnter(cfg.netns.name):
         cfg.pspnl = PSPFamily()
 
-        sock = _make_psp_conn(cfg, version, ipver)
+        sock = make_psp_conn(cfg, version, ipver)
 
         rx_assoc = cfg.pspnl.rx_assoc({"version": version,
                                        "dev-id": cfg.psp_dev_id,
                                        "sock-fd": sock.fileno()})
         rx_key = rx_assoc['rx-key']
-        tx_key = _spi_xchg(sock, rx_key)
+        tx_key = spi_xchg(sock, rx_key)
 
         cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
                             "version": version,
                             "tx-key": tx_key,
                             "sock-fd": sock.fileno()})
 
-        data_len = _send_careful(cfg, sock, 100)
-        _check_data_rx(cfg, data_len)
+        data_len = send_careful(cfg, sock, 100)
+        check_data_rx(cfg, data_len)
         _close_psp_conn(cfg, sock)
 
 
@@ -766,7 +665,7 @@ from lib.py import ip
 
 def _dev_assoc_no_nsid(cfg):
     """ Test dev-assoc and dev-disassoc without nsid attribute """
-    _init_psp_dev(cfg, True)
+    init_psp_dev(cfg, True)
 
     # Associate without nsid - should look up ifindex in caller's netns
     cfg.pspnl.dev_assoc({'id': cfg.psp_dev_id,
@@ -800,7 +699,7 @@ from lib.py import ip
     Creates a disposable netkit pair for this test to avoid destroying
     the shared environment.
     """
-    _init_psp_dev(cfg, True)
+    init_psp_dev(cfg, True)
     defer(delattr, cfg, 'psp_dev_id')
     defer(delattr, cfg, 'psp_info')
 
@@ -877,7 +776,7 @@ from lib.py import ip
 
 def _assoc_nk_guest(cfg):
     """Associate nk_guest with PSP device and register cleanup via defer()."""
-    _init_psp_dev(cfg, True)
+    init_psp_dev(cfg, True)
 
     cfg.pspnl.dev_assoc({'id': cfg.psp_dev_id,
                          'ifindex': cfg.nk_guest_ifindex,
@@ -937,7 +836,6 @@ from lib.py import ip
     cfg.psp_dev_peer_nsid = _get_nsid(cfg.netns.name)
 
 
-
 def main() -> None:
     """ Ksft boiler plate main """
 
@@ -960,46 +858,23 @@ from lib.py import ip
 
         # Set up responder and communication sock
         # psp_responder runs in _netns (remote namespace with psp_dev_peer)
-        responder = cfg.remote.deploy("psp_responder")
+        with psp_responder(cfg):
+            cases = [data_basic_send, data_mss_adjust]
 
-        cfg.comm_port = rand_port()
-        srv = None
-        try:
-            with bkg(responder + f" -p {cfg.comm_port} -i {cfg.remote_ifindex}",
-                     host=cfg.remote, exit_wait=True) as srv:
-                wait_port_listen(cfg.comm_port, host=cfg.remote)
+            if has_cont:
+                cases += [
+                    _assoc_check_list,
+                    data_basic_send_netkit_psp_assoc,
+                    _key_rotation_notify_multi_ns_netkit,
+                    _dev_change_notify_multi_ns_netkit,
+                    _psp_dev_get_check_netkit_psp_assoc,
+                    _dev_assoc_no_nsid,
+                    _psp_dev_assoc_cleanup_on_netkit_del,
+                ]
 
-                cfg.comm_sock = socket.create_connection((cfg.remote_addr,
-                                                          cfg.comm_port),
-                                                         timeout=1)
-
-                cases = [data_basic_send, data_mss_adjust]
-
-                if has_cont:
-                    cases += [
-                        _assoc_check_list,
-                        data_basic_send_netkit_psp_assoc,
-                        _key_rotation_notify_multi_ns_netkit,
-                        _dev_change_notify_multi_ns_netkit,
-                        _psp_dev_get_check_netkit_psp_assoc,
-                        _dev_assoc_no_nsid,
-                        _psp_dev_assoc_cleanup_on_netkit_del,
-                    ]
-
-                ksft_run(cases=cases, globs=globals(),
-                         case_pfx={"dev_", "data_", "assoc_", "removal_"},
-                         args=(cfg, ))
-
-                cfg.comm_sock.send(b"exit\0")
-                cfg.comm_sock.close()
-        finally:
-            if srv and (srv.stdout or srv.stderr):
-                ksft_pr("")
-                ksft_pr(f"Responder logs ({srv.ret}):")
-            if srv and srv.stdout:
-                ksft_pr("STDOUT:\n#  " + srv.stdout.strip().replace("\n", "\n#  "))
-            if srv and srv.stderr:
-                ksft_pr("STDERR:\n#  " + srv.stderr.strip().replace("\n", "\n#  "))
+            ksft_run(cases=cases, globs=globals(),
+                     case_pfx={"dev_", "data_", "assoc_"},
+                     args=(cfg, ))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/drivers/net/psp_lib.py b/tools/testing/selftests/drivers/net/psp_lib.py
new file mode 100644
index 000000000000..1fc4bff84fb1
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/psp_lib.py
@@ -0,0 +1,179 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Helpers shared by the PSP tests.
+
+Only code which the tests would otherwise have to copy verbatim belongs
+here, mostly talking to psp_responder on the other end of the link.
+"""
+
+import fcntl
+import socket
+import struct
+import termios
+import time
+from contextlib import contextmanager
+
+from lib.py import defer
+from lib.py import ksft_eq, ksft_pr
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import bkg, rand_port, wait_port_listen
+
+
+def get_outq(s):
+    one = b'\0' * 4
+    outq = fcntl.ioctl(s.fileno(), termios.TIOCOUTQ, one)
+    return struct.unpack("I", outq)[0]
+
+
+def send_with_ack(cfg, msg):
+    cfg.comm_sock.send(msg)
+    response = cfg.comm_sock.recv(4)
+    if response != b'ack\0':
+        raise RuntimeError("Unexpected server response", response)
+
+
+def remote_read_len(cfg):
+    cfg.comm_sock.send(b'read len\0')
+    return int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
+
+
+def make_clr_conn(cfg, ipver=None):
+    send_with_ack(cfg, b'conn clr\0')
+    remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
+    s = socket.create_connection((remote_addr, cfg.comm_port), )
+    return s
+
+
+def make_psp_conn(cfg, version=0, ipver=None):
+    send_with_ack(cfg, b'conn psp\0' + struct.pack('BB', version, version))
+    remote_addr = cfg.remote_addr_v[ipver] if ipver else cfg.remote_addr
+    s = socket.create_connection((remote_addr, cfg.comm_port), )
+    return s
+
+
+def close_conn(cfg, s):
+    send_with_ack(cfg, b'data close\0')
+    s.close()
+
+
+def spi_xchg(s, rx):
+    s.send(struct.pack('I', rx['spi']) + rx['key'])
+    tx = s.recv(4 + len(rx['key']))
+    return {
+        'spi': struct.unpack('I', tx[:4])[0],
+        'key': tx[4:]
+    }
+
+
+def send_careful(cfg, s, rounds):
+    data = b'0123456789' * 200
+    for i in range(rounds):
+        n = 0
+        for _ in range(10): # allow 10 retries
+            try:
+                n += s.send(data[n:], socket.MSG_DONTWAIT)
+                if n == len(data):
+                    break
+            except BlockingIOError:
+                time.sleep(0.05)
+        else:
+            rlen = remote_read_len(cfg)
+            outq = get_outq(s)
+            report = f'sent: {i * len(data) + n} remote len: {rlen} outq: {outq}'
+            raise RuntimeError(report)
+
+    return len(data) * rounds
+
+
+def check_data_rx(cfg, exp_len):
+    read_len = -1
+    for _ in range(30):
+        cfg.comm_sock.send(b'read len\0')
+        read_len = int(cfg.comm_sock.recv(1024)[:-1].decode('utf-8'))
+        if read_len == exp_len:
+            break
+        time.sleep(0.01)
+    ksft_eq(read_len, exp_len)
+
+
+def get_stat(cfg, key):
+    return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
+
+def init_psp_dev(cfg, use_psp_ifindex=False):
+    if not hasattr(cfg, 'psp_dev_id'):
+        # Figure out which local device we are testing against
+        # For NetDrvContEnv: use psp_ifindex instead of ifindex
+        target_ifindex = cfg.psp_ifindex if use_psp_ifindex else cfg.ifindex
+        for dev in cfg.pspnl.dev_get({}, dump=True):
+            if dev['ifindex'] == target_ifindex:
+                cfg.psp_info = dev
+                cfg.psp_dev_id = cfg.psp_info['id']
+                break
+        else:
+            raise KsftSkipEx("No PSP devices found")
+
+    # Enable PSP if necessary
+    cap = cfg.psp_info['psp-versions-cap']
+    ena = cfg.psp_info['psp-versions-ena']
+    if cap != ena:
+        cfg.pspnl.dev_set({'id': cfg.psp_dev_id, 'psp-versions-ena': cap})
+        defer(cfg.pspnl.dev_set, {'id': cfg.psp_dev_id,
+                                  'psp-versions-ena': ena })
+
+
+def recv_careful(s, target, rounds=100):
+    """Read exactly target bytes, tolerating short reads"""
+    data = b''
+    for _ in range(rounds):
+        try:
+            data += s.recv(target - len(data), socket.MSG_DONTWAIT)
+            if len(data) == target:
+                return data
+        except BlockingIOError:
+            time.sleep(0.001)
+    raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")
+
+
+def req_echo(cfg, s):
+    """Ask the peer to echo, and check the reply arrives intact"""
+    send_with_ack(cfg, b'data echo\0')
+    ksft_eq(recv_careful(s, 5), b'echo\0')
+
+
+def psp_txrx(cfg, s, rounds, sent=0):
+    """Send data both ways, and return the total bytes sent to the peer"""
+    sent += send_careful(cfg, s, rounds)
+    check_data_rx(cfg, sent)
+    req_echo(cfg, s)
+    return sent
+
+
+@contextmanager
+def responder(cfg):
+    """Run psp_responder on the remote end and open the comm socket to it"""
+    binary = cfg.remote.deploy("psp_responder")
+
+    cfg.comm_port = rand_port()
+    srv = None
+    try:
+        with bkg(binary + f" -p {cfg.comm_port} -i {cfg.remote_ifindex}",
+                 host=cfg.remote, exit_wait=True) as srv:
+            wait_port_listen(cfg.comm_port, host=cfg.remote)
+
+            cfg.comm_sock = socket.create_connection((cfg.remote_addr,
+                                                      cfg.comm_port),
+                                                     timeout=1)
+            yield cfg
+
+            cfg.comm_sock.send(b"exit\0")
+            cfg.comm_sock.close()
+    finally:
+        if srv and (srv.stdout or srv.stderr):
+            ksft_pr("")
+            ksft_pr(f"Responder logs ({srv.ret}):")
+        if srv and srv.stdout:
+            ksft_pr("STDOUT:\n#  " + srv.stdout.strip().replace("\n", "\n#  "))
+        if srv and srv.stderr:
+            ksft_pr("STDERR:\n#  " + srv.stderr.strip().replace("\n", "\n#  "))
-- 
2.55.0

