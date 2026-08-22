Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B40383338
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439335; cv=none; b=J4ZC0Q+P8WsDRDZLiIITde5XuPWKOML1fuRbmZRwAcnsX/dytZj0iMedAQEHVftGaFf6aVCteLrT5+AFXTsAzuQ/QjcwJU3qURLzPavCJGc6l9SxNNTA/hrtootAxnTXUNh6+jkKzCat6uDlimRyQCxdxMnjSj/GYF+Hx1pOF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439335; c=relaxed/simple;
	bh=ZRRogqZNZbmKclMya8h87pyeVKqAbYZTYbM5gYZ22d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYEQ3yiEQx6z8Keid8CYqWigjQwgIm7WRtsWA2NyDSP2637qF/cqv2y54Q7cHvwNjHbYHUchxo9CnvXo36DMRqtaeB+j1qltptnZpE00x9v3GBreIfPQgm1reArRDqda3i5E6z7Y+qLVwr+LOTobnDH2KhTVwjG1ARUHOJaoMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEfXLzfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEfXLzfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E891F00AC4;
	Sat, 22 Aug 2026 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439333;
	bh=qYCuFOkSwQS6O8fCKZ+t8kuEZ0CR4cBSmsG0WlcUfeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FEfXLzfwWVEEnOwJl7XIZesO5Xl6NnVQLwlwHUxlNhZ2bIstMIREbOGlo1kjbpYfz
	 XEXqV8g1LzuFuNgsfMJu2bQRyCdHEKFgTQfh+IWJAPTGJZCkGioAj/Z4uCIfUJoCDp
	 UVNBZmOEvLZfgNRsDcO9ZmiHABj4T0ZTFnnALTY6MSiWgGcpan7FYSSowaOivrGd/v
	 +hhH5jbEd6V+d/E5IgBmA6vA1N1otSZG5d4VjZA+c6ddSrZyxjdWoM9nriCKR5vjEh
	 aPpy95I6j5D1UqUl77jlSmiRj+SWF63gQdO7pw0S4jChWhwvujBCC0lZEaLVhtlP49
	 OxzfkHmztnVow==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com,
	cratiu@nvidia.com,
	borisp@nvidia.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 4/6] selftests: drv-net: psp_steer: test PSP VC based queue steering
Date: Sat, 22 Aug 2026 15:55:22 -0700
Message-ID: <20260822225524.2328465-5-kuba@kernel.org>
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

Cover the netlink interface for PSP VC steering.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/psp_responder.c     |  42 +++
 .../testing/selftests/drivers/net/psp_lib.py  |   5 +
 .../selftests/drivers/net/psp_steer.py        | 256 ++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/psp_steer.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index de6e4d7f2dda..e8719fc106ba 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS := \
 	netpoll_basic.py \
 	ping.py \
 	psp.py \
+	psp_steer.py \
 	queues.py \
 	ring_reconfig.py \
 	shaper.py \
diff --git a/tools/testing/selftests/drivers/net/psp_responder.c b/tools/testing/selftests/drivers/net/psp_responder.c
index a26e7628bbb1..f8df6b8da9b4 100644
--- a/tools/testing/selftests/drivers/net/psp_responder.c
+++ b/tools/testing/selftests/drivers/net/psp_responder.c
@@ -23,6 +23,7 @@ static bool should_quit;
 struct opts {
 	int port;
 	int ifindex;
+	int devid;
 	bool verbose;
 };
 
@@ -118,6 +119,36 @@ static void send_str(int sock, int value)
 	send(sock, buf, ret + 1, MSG_WAITALL);
 }
 
+static void
+handle_dev_steer(struct ynl_sock *ys, struct opts *opts, char *data,
+		 int comm_sock)
+{
+	struct psp_dev_set_req *req;
+	struct psp_dev_set_rsp *rsp;
+
+	if (opts->devid < 0) {
+		fprintf(stderr, "WARN: dev steer but no PSP device\n");
+		send_err(comm_sock);
+		return;
+	}
+
+	req = psp_dev_set_req_alloc();
+
+	psp_dev_set_req_set_id(req, opts->devid);
+	psp_dev_set_req_set_vc_steer_ena(req, *data);
+
+	rsp = psp_dev_set(ys, req);
+	psp_dev_set_req_free(req);
+	if (!rsp) {
+		perror("ERROR: failed to set device features");
+		send_err(comm_sock);
+		return;
+	}
+	psp_dev_set_rsp_free(rsp);
+
+	send_ack(comm_sock);
+}
+
 static void
 run_session(struct ynl_sock *ys, struct opts *opts,
 	    int server_sock, int comm_sock)
@@ -210,6 +241,9 @@ run_session(struct ynl_sock *ys, struct opts *opts,
 			match;						\
 		})
 
+#define cmd_w_msg(_name, _type)						\
+		(off >= sizeof(_name) + sizeof(_type) && cmd(_name))
+
 			do {
 				consumed = false;
 
@@ -224,6 +258,11 @@ run_session(struct ynl_sock *ys, struct opts *opts,
 						fprintf(stderr, "WARN: echo but no data sock\n");
 					send_ack(comm_sock);
 				}
+				if (cmd_w_msg("dev steer", __u8)) {
+					handle_dev_steer(ys, opts, buf,
+							 comm_sock);
+					__consume(sizeof(__u8));
+				}
 				if (cmd("data close")) {
 					if (data_sock >= 0) {
 						close(data_sock);
@@ -254,6 +293,7 @@ run_session(struct ynl_sock *ys, struct opts *opts,
 				}
 				if (cmd("exit"))
 					should_quit = true;
+#undef cmd_w_msg
 #undef cmd
 
 				if (!consumed) {
@@ -461,6 +501,8 @@ int main(int argc, char **argv)
 			goto err_close;
 	}
 
+	opts.devid = devid;
+
 	ret = run_responder(ys, &opts);
 
 	if (devid >= 0 && ver_ena != ver_cap &&
diff --git a/tools/testing/selftests/drivers/net/psp_lib.py b/tools/testing/selftests/drivers/net/psp_lib.py
index 1fc4bff84fb1..b2bf205ed327 100644
--- a/tools/testing/selftests/drivers/net/psp_lib.py
+++ b/tools/testing/selftests/drivers/net/psp_lib.py
@@ -58,6 +58,11 @@ from lib.py import bkg, rand_port, wait_port_listen
     s.close()
 
 
+def remote_dev_steer(cfg, mode):
+    """Set vc-steer-ena on the remote PSP device"""
+    send_with_ack(cfg, b'dev steer\0' + struct.pack('B', mode))
+
+
 def spi_xchg(s, rx):
     s.send(struct.pack('I', rx['spi']) + rx['key'])
     tx = s.recv(4 + len(rx['key']))
diff --git a/tools/testing/selftests/drivers/net/psp_steer.py b/tools/testing/selftests/drivers/net/psp_steer.py
new file mode 100644
index 000000000000..0401a7c359e7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/psp_steer.py
@@ -0,0 +1,256 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test suite for PSP virtualization cookie based Rx queue steering."""
+
+import errno
+import os
+import socket
+
+from lib.py import defer
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, ksft_ge, ksft_in, ksft_ne, ksft_raises
+from lib.py import KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import NetdevFamily, NlError, PSPFamily
+
+from psp_lib import close_conn, init_psp_dev, make_psp_conn, psp_txrx, \
+    remote_conn_steer, remote_dev_steer, spi_xchg
+from psp_lib import responder as psp_responder
+
+# Not exposed by the socket module
+_SO_INCOMING_NAPI_ID = 56
+
+_VC_TX = 1 << 0
+_VC_RX = 1 << 1
+_VC_BOTH = _VC_TX | _VC_RX
+_VC_SIZE = 8
+
+
+def _require_steer(cfg):
+    """Skip unless the device can do VC steering"""
+    init_psp_dev(cfg)
+
+    if 'vc-steer-cap' not in cfg.psp_info:
+        raise KsftSkipEx("Device does not support PSP VC steering")
+
+
+def _require_queues(cfg, cnt):
+    if cfg.rx_queue_cnt < cnt or cfg.tx_queue_cnt < cnt:
+        raise KsftSkipEx(f"Test needs at least {cnt} Rx and Tx queues")
+
+
+def _set_steer(cfg, mode):
+    """Set vc-steer-ena locally for the duration of the test case"""
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    prev = dev['vc-steer-ena']
+
+    cfg.pspnl.dev_set({'id': cfg.psp_dev_id, 'vc-steer-ena': mode})
+    defer(cfg.pspnl.dev_set, {'id': cfg.psp_dev_id, 'vc-steer-ena': prev})
+
+
+def _set_remote_steer(cfg, mode):
+    remote_dev_steer(cfg, mode)
+    defer(remote_dev_steer, cfg, 0)
+
+
+def _enable_steer(cfg, local=_VC_BOTH, remote=_VC_BOTH):
+    """Turn steering on at both ends for the duration of the test case"""
+    _set_steer(cfg, local)
+    if remote is not None:
+        _set_remote_steer(cfg, remote)
+
+
+def _mss(s):
+    return s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+
+
+def _force_tx_queue(cfg, qid):
+    """Point XPS at a single Tx queue, so we know the flow's Tx queue
+
+    The queue we ask the peer to steer us to is taken from the Tx queue
+    the stack picks for the flow, so pinning XPS is what makes the
+    outcome predictable.
+    """
+    all_cpus = f'{(1 << os.cpu_count()) - 1:x}'
+    for i in range(cfg.tx_queue_cnt):
+        mask = all_cpus if i == qid else '0'
+        with open(f'/sys/class/net/{cfg.ifname}/queues/tx-{i}/xps_cpus',
+                  'w', encoding='ascii') as fp:
+            fp.write(mask)
+
+
+def _psp_conn(cfg):
+    """Open a PSP connection, whatever the device is configured for"""
+    s = make_psp_conn(cfg)
+
+    rx = cfg.pspnl.rx_assoc({'version': 0, 'dev-id': cfg.psp_dev_id,
+                             'sock-fd': s.fileno()})
+    tx = spi_xchg(s, rx['rx-key'])
+    cfg.pspnl.tx_assoc({'dev-id': cfg.psp_dev_id, 'version': 0,
+                        'tx-key': tx, 'sock-fd': s.fileno()})
+    return s
+
+
+def _settled_rx_queue(cfg, s, sent):
+    """Run traffic until the peer picked our request up, report the queue
+
+    The first exchange carries our request to the peer, the second comes
+    back already steered.
+    """
+    sent = psp_txrx(cfg, s, 1, sent)
+    sent = psp_txrx(cfg, s, 1, sent)
+
+    napi_id = s.getsockopt(socket.SOL_SOCKET, _SO_INCOMING_NAPI_ID)
+    ksft_ne(napi_id, 0, comment="socket saw no traffic?")
+    ksft_in(napi_id, cfg.napi2queue, comment="unknown NAPI id")
+    return cfg.napi2queue[napi_id], sent
+
+
+#
+# Test cases
+#
+
+def dev_feature_toggle(cfg):
+    """ Set each direction in turn, check it is reported back """
+    _require_steer(cfg)
+
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    defer(cfg.pspnl.dev_set, {'id': cfg.psp_dev_id,
+                              'vc-steer-ena': dev['vc-steer-ena']})
+
+    for mode in ({'tx'}, {'rx'}, {'tx', 'rx'}, set()):
+        cfg.pspnl.dev_set({'id': cfg.psp_dev_id, 'vc-steer-ena': mode})
+        dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+        ksft_eq(dev['vc-steer-ena'], mode)
+
+
+def dev_feature_tx_needs_no_cap(cfg):
+    """ Granting a peer's request must not depend on the device """
+    init_psp_dev(cfg)
+
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    defer(cfg.pspnl.dev_set, {'id': cfg.psp_dev_id,
+                              'vc-steer-ena': dev['vc-steer-ena']})
+
+    cfg.pspnl.dev_set({'id': cfg.psp_dev_id, 'vc-steer-ena': {'tx'}})
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_eq(dev['vc-steer-ena'], {'tx'})
+
+
+def dev_feature_rx_needs_cap(cfg):
+    """ Steering our own Rx does need the device to play along """
+    init_psp_dev(cfg)
+
+    if 'vc-steer-cap' in cfg.psp_info:
+        raise KsftSkipEx("Device can steer, nothing to reject")
+
+    with ksft_raises(NlError) as cm:
+        cfg.pspnl.dev_set({'id': cfg.psp_dev_id, 'vc-steer-ena': {'rx'}})
+    ksft_eq(cm.exception.nl_msg.error, -errno.EOPNOTSUPP)
+
+
+def dev_feature_bad_value(cfg):
+    """ Only the two direction bits are valid """
+    _require_steer(cfg)
+
+    with ksft_raises(NlError) as cm:
+        cfg.pspnl.dev_set({'id': cfg.psp_dev_id, 'vc-steer-ena': 0xdeadbeef})
+    ksft_eq(cm.exception.nl_msg.error, -errno.EINVAL)
+
+
+def data_mss_adjust(cfg):
+    """ The cookie is 8B of extra header, the MSS has to account for it """
+    _require_steer(cfg)
+
+    _set_steer(cfg, 0)
+    with _psp_conn(cfg) as s:
+        plain = _mss(s)
+        close_conn(cfg, s)
+
+    # Either direction puts a cookie in every header we send
+    for mode in (_VC_TX, _VC_RX, _VC_BOTH):
+        _set_steer(cfg, mode)
+        with _psp_conn(cfg) as s:
+            ksft_eq(plain - _mss(s), _VC_SIZE, comment=f"mode {mode}")
+            close_conn(cfg, s)
+
+
+def data_mss_sampled_at_assoc(cfg):
+    """ Turning steering on must not resize a live connection's header """
+    _require_steer(cfg)
+
+    _set_steer(cfg, 0)
+    with _psp_conn(cfg) as s:
+        before = _mss(s)
+        _set_steer(cfg, _VC_BOTH)
+        ksft_eq(_mss(s), before)
+        close_conn(cfg, s)
+
+
+def data_steer_follows_tx_queue(cfg):
+    """ Traffic must land on the Rx queue paired with our Tx queue """
+    _require_steer(cfg)
+    _require_queues(cfg, 3)
+    _enable_steer(cfg)
+
+    defer(_force_tx_queue, cfg, -1)
+
+    with _psp_conn(cfg) as s:
+        sent = 0
+        for qid in (1, 2):
+            _force_tx_queue(cfg, qid)
+            qid_seen, sent = _settled_rx_queue(cfg, s, sent)
+            ksft_eq(qid_seen, qid)
+
+        close_conn(cfg, s)
+
+
+def data_steer_one_sided(cfg):
+    """ We ask, the peer only grants: our Rx still gets steered """
+    _require_steer(cfg)
+    _require_queues(cfg, 2)
+    _enable_steer(cfg, local=_VC_RX, remote=_VC_TX)
+
+    defer(_force_tx_queue, cfg, -1)
+    _force_tx_queue(cfg, 1)
+
+    with _psp_conn(cfg) as s:
+        qid, _ = _settled_rx_queue(cfg, s, 0)
+        ksft_eq(qid, 1)
+        close_conn(cfg, s)
+
+
+def _queue_info(cfg):
+    """Map NAPI ids to Rx queue ids, and count the queues"""
+    netnl = NetdevFamily()
+    queues = netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+
+    cfg.napi2queue = {}
+    cfg.rx_queue_cnt = 0
+    cfg.tx_queue_cnt = 0
+    for q in queues:
+        if q['type'] == 'rx':
+            cfg.rx_queue_cnt += 1
+            if 'napi-id' in q:
+                cfg.napi2queue[q['napi-id']] = q['id']
+        elif q['type'] == 'tx':
+            cfg.tx_queue_cnt += 1
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEpEnv(__file__, queue_count=4) as cfg:
+        cfg.pspnl = PSPFamily()
+        _queue_info(cfg)
+
+        with psp_responder(cfg):
+            ksft_run(globs=globals(),
+                     case_pfx={"dev_", "assoc_", "data_"},
+                     args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.55.0

