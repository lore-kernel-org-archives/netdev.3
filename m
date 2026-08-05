Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080A3CF207
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899412; cv=none; b=AZgsC5v645RqeZh6gOce6UEMHvJ/hQoo4/XcrCcUv24Zt/NxNqV2ZoBrtfgiLoc9ASWw45jC5dUdtEATxmiEAw+Uabm/OziHuZBh1p/h4dkZYZPTYiTM+VFOPu51RlZWQcuYjB/N8EPPJqJU1nxsFTVuqjMpZQKvyCR/XzOT6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899412; c=relaxed/simple;
	bh=1L2Nivd25hshl3NsGCDcCU3jpDluDLUxskmCeHoJaV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdYsRx9IlJfzMAi5xHZDwUDHy6QuHiEwDjPNJeGrnxy6A0ra0QSlUfKC7jqPT5J9OHEy/YufTfEKQD/baP3EOp8vY+rTIh2t5lejX7icaEihmD+bH+YXn0rsjQSHMKAAX5EVAAtJyyLxCGQIUIJRkOFZKAW+A9rucVELjM09IdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp8ckLya; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp8ckLya"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4864ebb6268so280912b6e.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899408; x=1786504208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUH6SmhjRHh0unfECppocgsvf6286r8htqNG+/1YYkk=;
        b=Xp8ckLyaefWarBSci09jXWsg+4fTy8cEdd6+byndqDqa6J+8Z+3A/cJfnVSU5f/oeE
         S8c3KUf1QZPt+eWugbugEDeAyhbQcV3XvZ56bB/jR5MlD45xqByO/K2aOKqz3N6Pnlrf
         AUkmK/d7Akld4KAOkvzyhOaEcbXdNyfIkYDmG1njKPRZY7W0Bha56bLUeb0/S5ltn10n
         C8/sfgigwmQM/QOnW5yVp+MIuTA74hYO6JzEM4oTn0D8OgWjfpnijqlJozJQSKUqMcAa
         vULYdNlNPq5nYVCTzaDPINJHRZbXIWQJ55Ik6iUmKCFIq1bP/qzi4+7cV1GrmkG+WA0/
         NQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899408; x=1786504208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUH6SmhjRHh0unfECppocgsvf6286r8htqNG+/1YYkk=;
        b=E1xuvcx7GoaN3JZNnBIuBpytbiDr7eGqsiB/x7c6gRjnLGrY2MHeniu0c7h6eTBZ2f
         FovbQy0lTXQk8VBId4er5tmFFkpmV9O9C+4JpBCqwO3I9KvvZtUXKf0FWWXT1Lp+z1Aj
         dVlNVMOjOdfsb0kUHGVo+Lk2JJ91gaHQ6aZ5+E0LQQR1gJVsZSugCueHODsusnizt75z
         kn/dqykA2YSyKOW2T3FLMAxxXjW36Y2fqqZ66/1p8Aw9vksCmkCxyarGQse1KaGQgNpE
         8ih0Lp0hQH4BtvzyzJAKCMU3/y8F8t57mNQAiQcFoRWGi5b2pDHCUvO0k+bhdGMnW2i2
         2urw==
X-Gm-Message-State: AOJu0YztpGEEGTTzsS1Yf2eOIO0Fdxnpprqkj3GSNgXECz6EPHinF9dw
	bo5+JTUeqo86yPO9caTeGFX9FL4B1K2E76k7ofMGMHC9b99V2NCvC9e2bhRGdCFb
X-Gm-Gg: AR+sD1309cDJnqZRTkUOT9EIZ+p0X8wjjPDgbL/+dvG5Mxg5O90mDTJR1K+IfxTmZ+f
	u5DD7WgDNcYKmTcCIQPZtuRvC2WQLyOYfE4afecCbo4+X7qdidhTmqBenv6r5lhO7d9ZP414yPw
	gkQSjMfunASePcKq/CsAjZEwfLzBNK0pEQE+EEFNAhLA0hfPn3Vy1QkTMxDgDalSFBnuy+1CqEL
	VokFOIJhOaUehfPkO4Q+PvMeBpAlJwSA3fcLy8eDtCPRogfAYY8k/sdr+T2kuOmfucKIQkqTQP4
	LBPYlAi6IAPn+AqLLCHhx7WujbnfZo21zESNGGwnlWzbiGQh9v14WL7Kn7DRnvrvaqLAs3KIHIU
	7NvH1ufvb0YuSVx5FKSfajT42J6CsGs3uqxDySUvoCJy/KJktjEbGSbMaEiIZ+olPSuOZgd3xd/
	bbVs24Sp6+11Ez210Z7Zx27oNJ9Hmg5kQA/pugK2Cj//HF4Hb+nBp9PmbVTba+XEpozCktEw==
X-Received: by 2002:a05:6808:1797:b0:4a3:3108:866a with SMTP id 5614622812f47-4afae12fc4fmr2175455b6e.17.1785899408467;
        Tue, 04 Aug 2026 20:10:08 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:47::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae1777d2sm1118570b6e.0.2026.08.04.20.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:10:07 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	alexander.duyck@gmail.com
Subject: [PATCH net-next 10/14] selftests: net: shaper: Add reparenting rejection test
Date: Tue,  4 Aug 2026 20:09:32 -0700
Message-ID: <20260805030936.1092907-11-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805030936.1092907-1-mohsin.bashr@gmail.com>
References: <20260805030936.1092907-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <hmohsin@meta.com>

Add reject_reparenting to verify that the group operation rejects attempts
to change an existing node's parent. The test creates two node shapers
under netdev and verifies that re-grouping the first node under the second
fails with EOPNOTSUPP. It also verifies that updating the node with the
same parent succeeds, and that updating the node without specifying a
parent keeps the queue leaves under the original node while updating their
weights.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 tools/testing/selftests/drivers/net/shaper.py | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index 62c74a0c0563..e7af94264409 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
+# pylint: disable=too-many-lines
 
 import errno
 import glob
@@ -825,6 +826,154 @@ def move_queue_between_nodes(cfg, nl_shaper) -> None:
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(len(shapers), 0)
 
+def reject_reparenting(cfg, nl_shaper) -> None:
+    r"""Reject reparenting an existing node; the hierarchy stays intact.
+
+        netdev
+        /    \      rejected:  N3 -> netdev
+       N1     N2    rejected:  N1 -> N2
+      /  \    |     (both EOPNOTSUPP)
+     Q1  N3  Q2
+         |
+         Q3
+    """
+    node1_bw_max = 10000
+    node2_bw_max = 5000
+    node3_bw_max = 20000
+
+    _require_caps(cfg, nl_shaper, 'node',
+                  ['support-bw-max', 'support-metric-bps', 'support-nesting'],
+                  "device does not support node scope shapers with bw_max, metric bps and nesting")
+    _require_caps(cfg, nl_shaper, 'queue', ['support-nesting', 'support-weight'],
+                  "device does not support nested queue scope shapers with weight")
+
+    _require_queues(cfg, 4)
+
+    # Create Node1 under netdev with Q1.
+    node1_id = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 1}],
+                   'handle': {'scope':'node'},
+                   'metric': 'bps',
+                   'bw-max': node1_bw_max})['handle']['id']
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': 1})
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'node', 'id': node1_id})
+
+    # Create Node2 under netdev with Q2.
+    node2_id = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 2},
+                              'weight': 1}],
+                   'handle': {'scope':'node'},
+                   'metric': 'bps',
+                   'bw-max': node2_bw_max})['handle']['id']
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': 2})
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'node', 'id': node2_id})
+
+    # Create Node3 nested under Node1 with Q3.
+    node3_id = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 3},
+                              'weight': 1}],
+                   'handle': {'scope':'node'},
+                   'metric': 'bps',
+                   'bw-max': node3_bw_max,
+                   'parent': {'scope': 'node', 'id': node1_id}})['handle']['id']
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': 3})
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'node', 'id': node3_id})
+
+    # Reparenting a nested node up to netdev must fail.
+    with ksft_raises(NlError) as cm:
+        nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 3},
+                              'weight': 1}],
+                   'handle': {'scope':'node', 'id': node3_id},
+                   'parent': {'scope': 'netdev'}})
+    if cm.exception:
+        ksft_eq(cm.exception.error, errno.EOPNOTSUPP)
+
+    # Reparenting a node under another node must fail as well.
+    with ksft_raises(NlError) as cm:
+        nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 1}],
+                   'handle': {'scope':'node', 'id': node1_id},
+                   'parent': {'scope': 'node', 'id': node2_id}})
+    if cm.exception:
+        ksft_eq(cm.exception.error, errno.EOPNOTSUPP)
+
+    # Updating a node with the same parent must succeed.
+    nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 5}],
+                   'handle': {'scope':'node', 'id': node1_id},
+                   'parent': {'scope': 'netdev'}})
+
+    # Updating a node without specifying the parent must succeed.
+    nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 2},
+                              'weight': 7}],
+                   'handle': {'scope':'node', 'id': node2_id}})
+
+    # The rejected reparents must have left the hierarchy intact.
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'node', 'id': node1_id}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'handle': {'scope': 'node', 'id': node1_id},
+                     'parent': {'scope': 'netdev'},
+                     'metric': 'bps',
+                     'bw-max': node1_bw_max})
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'node', 'id': node2_id}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'handle': {'scope': 'node', 'id': node2_id},
+                     'parent': {'scope': 'netdev'},
+                     'metric': 'bps',
+                     'bw-max': node2_bw_max})
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'node', 'id': node3_id}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'handle': {'scope': 'node', 'id': node3_id},
+                     'parent': {'scope': 'node', 'id': node1_id},
+                     'metric': 'bps',
+                     'bw-max': node3_bw_max})
+
+    # Verify the leaf weights were updated and parents unchanged.
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 1}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'parent': {'scope': 'node', 'id': node1_id},
+                     'handle': {'scope': 'queue', 'id': 1},
+                     'weight': 5})
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 2}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'parent': {'scope': 'node', 'id': node2_id},
+                     'handle': {'scope': 'queue', 'id': 2},
+                     'weight': 7})
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 3}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'parent': {'scope': 'node', 'id': node3_id},
+                     'handle': {'scope': 'queue', 'id': 3},
+                     'weight': 1})
+
+    # Cleanup. Delete the nodes explicitly instead of relying on the
+    # empty-node auto-delete: a kernel that wrongly accepts a reparent may
+    # mishandle the leaf accounting and leave a node behind. Removing them
+    # by handle keeps a failing run from leaking state into later tests.
+    for i in range(1, 4):
+        _delete_shaper(cfg, nl_shaper, {'scope': 'queue', 'id': i})
+    for nid in (node1_id, node2_id, node3_id):
+        _delete_shaper(cfg, nl_shaper, {'scope': 'node', 'id': nid})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
 def queue_update(cfg, nl_shaper) -> None:
     nq = _require_queues(cfg, 4)
     if not cfg.queues:
@@ -944,6 +1093,7 @@ def main() -> None:
                   nested_depth_limit,
                   delete_child_reparent,
                   move_queue_between_nodes,
+                  reject_reparenting,
                   dup_leaves,
                   queue_update],
                  args=(cfg, NetshaperFamily()))
-- 
2.53.0-Meta

