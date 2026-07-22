Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96D2BE033
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752950; cv=none; b=MTI+SU0civ2N6xguMlYIynK3FBFJcUnvltEnpPgZXTMewr7eHJtAmCYpgn8sfhuuvJSWqs5d9GXDMzVe0li+XVeWKhj9bxi3KLll7qhkLIqBOLKb43OMoNjH6mDMYcvxe/QhtVI+ev83uKOh+pQYfOMhQ7+n+Z2JbqlfJnThDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752950; c=relaxed/simple;
	bh=nmQpy4V0JZKM4zeCA7VJGgcP5pfJW8ehy+S6KrylEvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os97lgPgypfss7i4T5m1fE4F6puK5R9S24LLKUDu4q3RHxEHH/ejzbXRqdCjfVwDhYll2JW66MZNpTwmw+RpWROllPOLaNFBUIV2Qvm66QVLh7g7sNqYCGLCfhjltlqYjf8r7JgulKPnCWyZ/WNTwr6DkXBmBGCyW1J6I77OG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HVmVE6eM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgKE1ihM; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HVmVE6eM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgKE1ihM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 952971D000D9;
	Wed, 22 Jul 2026 16:42:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 22 Jul 2026 16:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784752948; x=
	1784839348; bh=rUXQ68jqK+qT2e+BpN0YkWa6DGok6NmF3uSM0/21VJ4=; b=H
	VmVE6eMrLIH08TNwir43eeuoJtaXfQrobygAw358o+RYRRTCMX88VnFM/XDcemIk
	f7jgI7sxeV+IE66iPc4u6TrVdbsmnOScKIg841h1dpmLKRG5u9/NpORh37zgC6jY
	E4ZcbusNj7/EyfwSlx6pQgAFe/bBG3EPW9erQ3kmCT1vsMNYHsEt0f4v3+Tplggd
	O60bdi4NulO6cZSiYvtZLV1Q5kJjGoAUyDwNjyBcVb6QVJENm4TrxXHMiwSxADsy
	gAb4enx/UTa8/9fKBzrBj/EDATLhUQMVmt3vPpV9KK+RA/mmMw1QLve6rOgi20jG
	KsCqLjOD2vSOAN9pfIbvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784752948; x=1784839348; bh=r
	UXQ68jqK+qT2e+BpN0YkWa6DGok6NmF3uSM0/21VJ4=; b=GgKE1ihMhq1sMI5cS
	pTfsbWSQAJSubrFBr/Fas/PFUngpiKMK7d08kM9XIP29FbktLbOLYGcoOuQhEsEG
	xK9nNUZEe/C0ol3ksYJ/ROXVTE4qqIJHJ/VNhQvLfnFIh7ZpMVlX1aR7aVHtBr1I
	sXUJvYrX5vxgV8VdsvMij6ASS/WpzTZLkQu7HrV7W/NV5bjpfjMogD2xOzTN2/Up
	FQ2L6ftcVHE38w/81OBXV9J7I2dg/OF5Cg38qQzf7tw/6d9Qz2+fIUM68lz9MV3H
	E5lRieI/chzOl0J7r3YLGqsgX2Qfxk8ebIcNiIeJZq0rqeWcg7Pifvi8m7MeXRBe
	Ysf2g==
X-ME-Sender: <xms:NCthaqDdpFES902c_Lk495uJf_XFKKsWLnNDqWoaWykRb4ZPKmWScw>
    <xme:NCtharYD_Qx6NJ3aoeNQovfudyt0azjLXQun2vEhXBiUliUcSKaq78isSer9w9oO0
    TC7nGKab_3Y-VBPtAOO14jNUszuZJcjxJXP4P0FJYotCeqg2gH4cv4>
X-ME-Received: <xmr:NCthal6r6rs2ugu7L6wmMrPYCjh0jCt75K9Mi6WdFTOpYPG5apAtxlhoGueXpzYUK5mar4mGkhjEadklxexHnw>
X-ME-Proxy-Cause: dmFkZTElkBiwG5cIhOPJZ8aQ7X5cAdGPqZBNVDJCUNRy0mD9Oc/iqcQxNWQRTcVWxNeXeK
    hb9mo56V6acb1wu6pEODO1csMhIVfAurfOZMPNWy09rHnDjuuGiQDfMPUyhefHkcsZPJe2
    QDzpYB3UxcgUVIhu9WlP4w58PjwxegjsBXRyLZMwxik596AtZDOdsXNAXjPgVLBzhU02GA
    uZBPQ9pQLNio4heUffFko5NMQNOXT+MSEpF2OYZBbYeLH8/tpcCqBd/BzsEVtbeKr4o6bL
    znxDXK3nG8jddPlBMyzWw4jQEkaRCa6dbQkY4Z5XVuLTmS87+B/SQ0HOWCQIkXQJnCZtEI
    ztu8kVBnF++gLuoLjghBDfeD5A03xMYhfRR5Qt6+0O1SsNjQmQKM7ONqHSbrLN52rP1GD7
    gt+a9VF2lpnrW0yoA57Ec3+Jh+IredV097sA4xoj/XV6jpavyaSK59cjF3mh9r86YFn5kS
    6WYfnKbHCgf/rJTZP2zOW3MeRKbUSHhkD/IK3BJ+rLvUs2LYRCQNfGhZpROolqR3GoZtDn
    BDQA2bhZzSzKVVWfnagpT3AQKkkvC5+ekFexAPf9+pj9Bn8zauEyfoNuTALdWjiOOjJHF/
    RgcpOrTyuhxUORc/J5ZJK8HXWksMlCEv3cqBKqAFODwUi3Y1Ga/uNoT+jJeQ
X-ME-Proxy: <xmx:NCthakaVKt1zSNDW0lD1dLoBb2kIeG4oBQAE1enuluxAFNIz2UosOQ>
    <xmx:NCthasgv3PIOp8s4DGfUlSlKGLOyuH1uHmt_yXFMqPi2OhWn4mBXnA>
    <xmx:NCthat9hCrsfQr1K-SGhfE6gZWWkLJLKiq_XnTlNqwrHmUit9fYy3Q>
    <xmx:NCthavpNJ-nG2oirO9m-LgKsG8j_kMFOZpQC6D0bWjjo1549A1oTRw>
    <xmx:NCthaj7yptzKbVAIqDXSFhBYm0NwdV-2cMEopD8TMgGwf0W1v4SqwhV1>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 16:42:27 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v3 6/6] selftests: net: add rss_multiqueue test variant to iou-zcrx
Date: Wed, 22 Jul 2026 15:39:50 -0500
Message-ID: <20260722203950.58550-7-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722203950.58550-1-juanlu@fastmail.com>
References: <20260722203950.58550-1-juanlu@fastmail.com>
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
 .../selftests/drivers/net/hw/iou-zcrx.py      | 48 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index b7a225fe4beae..1f6083d8b05c4 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -30,6 +30,12 @@ def create_rss_ctx(cfg):
     return int(values)
 
 
+def create_rss_ctx_multi(cfg, start, count):
+    output = ethtool(f"-X {cfg.ifname} context new start {start} equal {count}").stdout
+    values = re.search(r'New RSS context is (\d+)', output).group(1)
+    return int(values)
+
+
 def set_flow_rule(cfg):
     output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.target}").stdout
     values = re.search(r'ID (\d+)', output).group(1)
@@ -127,17 +133,55 @@ def _require_ntuple(cfg):
         defer(ethtool, f"-K {cfg.ifname} ntuple-filters off")
 
 
+def rss_multiqueue(cfg):
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

