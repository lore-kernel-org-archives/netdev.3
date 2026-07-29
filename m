Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2843F0B9
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363541; cv=none; b=G71sOSoP3j7Pn+3dYdo4dvKL3lPr5bpT5qUqp6RETrLYW57USeDHLXbc13euUdY6YcAPGJLB9T41vWZtaajXJRhi+tXXd1wLDt7HXVK3j1TUBr5qdRqU/3e2f95MdRRq2E5NC+TXAUa5SX/R41p52R8vuwgD0ZcYVKsPCkH36yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363541; c=relaxed/simple;
	bh=e7LYKBFbEvthm11PSs/C6zIgbmJth/AwSzGHUbofwiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyvFL0EYvqhBrnest7RGvTmAMCIN+t6UtMUsJIbWBwuM4za34BVHIAuHCEvInbsCEH+CvA8VeGC/D6IXYH9/plCAuKGf05DK27C3EKhZYlgb1qoM6NCzPegyP5C5Y5foiNv4a7osrlpYDhIQ1t2u2+pudpku+gHy70lxvYG28v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jTFt35HR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PlhxLeHh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jTFt35HR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PlhxLeHh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 398BB1D002C8;
	Wed, 29 Jul 2026 18:18:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jul 2026 18:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785363539; x=
	1785449939; bh=z7+hOQG2YGb/JFBuAeH6YH/vIHUf6ESYw2NhiMLrbag=; b=j
	TFt35HRdAiDON+uDD2/ZHldDVXeWmoozTHgEsHWRJIdBG+cmSXoTGZj3zm4q6+D3
	K06DNq4RvokYPaK/Z+m5yxlne50RXvQaAwfwuhAu+yXBqMaaF9scCxPhAM4aWa2f
	lhItWauYLwbwZSJ/IsvINwBieM0MN0X4jRRDtjSEqIKwnhilOewm0NJPdxkhnAZ6
	Gv7zhHUcL8C44N48B/R+toKl2K+Gv17Ihb+T9/h36qhcjLD/9xOLWkkU1281Au2w
	rZ+zH6ksoRWZ7T6i4Z/N2ym3ZNukI0rWWiHuqURyYZ5RKIjLDS62hNwhsXV8BE1l
	6BxO+v8tk2jwaWFB3Y9Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785363539; x=1785449939; bh=z
	7+hOQG2YGb/JFBuAeH6YH/vIHUf6ESYw2NhiMLrbag=; b=PlhxLeHh/nr/SmzMW
	vEhhNqLZTKWgLjmsMxGB67eKagdE66e6wCVsjANK74hlae6/Q7Lfk2+c4x1eFHzS
	LSWMl+A2NJSGGVZOqFE0i8d7WuKChGOHBgw4D93zpEqT83BuqGFEPGlc7HZJQmvW
	R7+vJNuizEVpP27CsgO/H0trGP2i+4dftYTmS5shF6RRJJXGHL18gTUih6v/Cmzz
	4iMyqtLzwqLyP1l0xqD2iYjCzKOdefLCvu4+nSd3Ue0BPsXNf5L6HlEzYPwZHk6R
	KqauUHSeFgauJo0nh15qVAgkoy/Qwwe4NWABWhyMVdu3gjnh/Dpenx2sYgs/ln+D
	1lVZQ==
X-ME-Sender: <xms:U3xqai6J3300GjRIybbaQsLiqgUlPR4KH7pPZQnqtz1wU5T0oDsqDA>
    <xme:U3xqaiyjAeOFXTsqvUnwPBWHoPb-vSqefPTLrZo3BrSKjnQW1gLNMtyHDQ7S1k1_Y
    y7L-MyJ-ZQQOUzcAalGgsccuZFnmwXc9-nz9sT-AW1ay8aGqXDR4hM>
X-ME-Received: <xmr:U3xqapyU7lfSXC1UAbTY7ZGrSskcswwVbI3ObuFJlNL5Xu0Hy2DTjC_CKdbw-Qk_wTTj__1S3L8_W2eZ5lyZ>
X-ME-Proxy-Cause: dmFkZTGYxrxOA2kX45FjE7uWqEUywGWHyDyBWaser44hAwDMI7rJ+0mpvuMoO5poBkjbAN
    aH3CsQ3LZCMu7NFu/0dJnJTDGw38j08D0bDmRjODkSV35yDvnTovlndu+6M21iwHBKZ8f2
    dlxokyeyx9aW+sx2aGuIgjtEskeNuIJ0u+C3A5epNRiNkvqpOySB16Nw7o8RUBTmtlf9S4
    C4vZovergqyIt9UTPPajW6CQsSxoPffB4/UAyQFOeDfXtOLCXWCBpBqN4hPTP7DXcOc9iN
    XpDV+g2WODVskwBYgMy96aTglqISzcxU2Hsj+qBq6+hkVmXvdwnpOX91vEGx1Ayp+aqmER
    g5TiKcnBGX8ajRtxBfDvOyeesQz3clZQunTPmH0El1OqO3BG/OeO7+Q2O9BkceUq4j4kt8
    A/7xxw64IUpjnkAW/R/HliWWnKuUyQPw255RQjSrApncPzOheqO37XzwUIlmIsZPSr8Wnx
    m22MmE1B2wgj3dzWXSKLyC6uacfdw9MEWsNLIhFSwnBfdXbj/u1uoTgtcXf8cNYA2XtdaV
    Mjk1DCKxOR/EJ0OyZb3Qv+z5u9bPN8c/DNEpOGB2nnjwXtSccO44ahTde0J/EJYrxRko75
    x3N7G5orK89ZY9R411SvEp9Ru+BkOV3uWODG1ruwow2FzGHtqio2oq8Oclfg
X-ME-Proxy: <xmx:U3xqaqyYipdbDeD3VOgKNsH2d6PepKkMNUdUEbHONCdQbjKy4dh3Xg>
    <xmx:U3xqajZG0yaWkaCUwftMFiMrPrTpyLALyFQ09_OOTaFHVi-JzJxmjg>
    <xmx:U3xqarXCzerMgcRR8_QZWwpydOlJ_BJjFikQcWYN8CAxaezX_ifBHA>
    <xmx:U3xqahjNn6E092RXNOgY7GL08sN3eAHW-InlddTGA3xuEyHyFLEQ5Q>
    <xmx:U3xqapTAxLOUfSsCXi5UOiDVai0pSiyMlaKdg2UEsDAf9RZJx9TnJEwM>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 18:18:58 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v4 6/6] selftests: net: add rss_multiqueue test variant to iou-zcrx
Date: Wed, 29 Jul 2026 17:18:25 -0500
Message-ID: <20260729221825.42773-7-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729221825.42773-1-juanlu@fastmail.com>
References: <20260729221825.42773-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a rss_multiqueue Python test variant that exercises multi-queue
zero-copy receive on a single listening socket.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 50 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index b7a225fe4beae..c833535d8a03c 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -30,6 +30,13 @@ def create_rss_ctx(cfg):
     return int(values)
 
 
+def create_rss_ctx_multi(cfg, start, count):
+    """Create an RSS context spanning count queues from start, return its ID."""
+    output = ethtool(f"-X {cfg.ifname} context new start {start} equal {count}").stdout
+    values = re.search(r'New RSS context is (\d+)', output).group(1)
+    return int(values)
+
+
 def set_flow_rule(cfg):
     output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.target}").stdout
     values = re.search(r'ID (\d+)', output).group(1)
@@ -127,17 +134,56 @@ def _require_ntuple(cfg):
         defer(ethtool, f"-K {cfg.ifname} ntuple-filters off")
 
 
+def rss_multiqueue(cfg):
+    """Steer the test flow to a multi-queue RSS context for multi-thread zcrx."""
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    channels = channels['combined-count']
+    if channels < 3:
+        raise KsftSkipEx('Test requires NETIF with at least 3 combined channels')
+
+    rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    rx_rings = rings['rx']
+    hds_thresh = rings.get('hds-thresh', 0)
+
+    cfg.ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'enabled',
+                         'hds-thresh': 0,
+                         'rx': 64})
+    defer(cfg.ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                                'tcp-data-split': 'unknown',
+                                'hds-thresh': hds_thresh,
+                                'rx': rx_rings})
+    defer(mp_clear_wait, cfg)
+
+    cfg.num_threads = 2
+    cfg.target = channels - cfg.num_threads
+    ethtool(f"-X {cfg.ifname} equal {cfg.target}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    rss_ctx_id = create_rss_ctx_multi(cfg, cfg.target, cfg.num_threads)
+    defer(ethtool, f"-X {cfg.ifname} delete context {rss_ctx_id}")
+
+    flow_rule_id = set_flow_rule_rss(cfg, rss_ctx_id)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+
 @ksft_variants([
     KsftNamedVariant("single", single),
     KsftNamedVariant("rss", rss),
+    KsftNamedVariant("rss_multiqueue", rss_multiqueue),
 ])
 def test_zcrx(cfg, setup) -> None:
     cfg.require_ipver('6')
     _require_ntuple(cfg)
 
+    cfg.num_threads = 1
+
     setup(cfg)
-    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target}"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
+
+    rx_cmd = (f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} "
+              f"-q {cfg.target} -t {cfg.num_threads}")
+    tx_cmd = (f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} "
+              f"-l 12840 -t {cfg.num_threads}")
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(cfg.port, proto="tcp")
         cmd(tx_cmd, host=cfg.remote)
-- 
2.53.0-Meta

