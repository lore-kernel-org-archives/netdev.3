Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE33CE0A7
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899408; cv=none; b=bIBAnve8nYyYas4XH5bAY5B/1Ot0ONoVeiXcdx5MOT2I+HI+4yELgDutigrQwXJQc3uA+TCYWI2t9TXNMw27oDeDmstJAAECGXZj95eRqKEzTl81nISsfZ6gv8mYUJvzH1dlFUuLG6XVi2742eGV22RXF8g0Hv6sxsOHYps5uZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899408; c=relaxed/simple;
	bh=Jq8G1a8IW2voSAiSYYJVtT2lfUBUkeHKC/7i6E9dQz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/9SMJYv5G+bZcfDzSai4HmfNyZRELsiidm3msEZexiuALgFz1hW/QR0XwyyZW+aKH9UgqXlf1C8CmluRjUz7wmBMTYIOffn22fNjQuVb4OzAU/Odpbgz7/RlUV4Bp/Z9IJo2aXDSmkA7ar7aTAg3+iu+gGkQeiijavBm54sSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QraSKoix; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QraSKoix"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4a416619cb2so365539b6e.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899405; x=1786504205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/4t3Qh7FD+LIP4Bq9IadDXflLYCCWPdGdCvaAGpR3A=;
        b=QraSKoix/3RHO0vI/Kv4Vt1lYmX9XkWKcvKDuAqUzERfNofgGgLiiHXi8TX9JNRPbb
         G8AXnPMRXzIG3EoftM0sfw9Xh9LLjGOrGMsM6mzT2c5oxn1ZKTREjbPFXps2SrqhqR+/
         FqHfAUPAR9o9oFUpMkljYkskpdP5V+KHPtpwFdGNJPIGG6g5TgGmwGgZ6MALGOgeTDRX
         wNM1HDXGbnanuj6twnC/cZI2/w3k7CAcY6pFnmthGe5owOgg1G709+yDj4FIaPBP9+qQ
         TX67KR4AsTqgVvd2frH6MqnBzK3PQUjC8pQv5MLT9nX3G4rmRodqLUM5MQ9hU3JofFwj
         T46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899405; x=1786504205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/4t3Qh7FD+LIP4Bq9IadDXflLYCCWPdGdCvaAGpR3A=;
        b=IDqwn9A0uFAIj6hEHpl4zpqptXOaybR+7hFgJBc7mVXadVQizPmVMpFS7MetuUALnn
         xNEt6qh9S21A7PTKJNUcnt8VH81oCNHyQ2ax5l3lAHxUloMole0yT3CUy4Qrm7eaQgTs
         1tvLk86Fi1CRaqKZ0+52PQ2HlJPU6jypIir2HU+/sJgNVxyEWYy/hqKmUu5wpC3vZNmj
         ctnK8rfQT8iv1+oZR5CRvNf1ZxH+PM7DtMZXqumwLuKfiOfD/TbEm7yW8ND0ZFJpEMp5
         p512XMAcxM44AvLXsk4T+ZY+RYfFlv2LBLoxoX7cfGaqJRU8043Md5zL+SZawi8OuPJd
         aGeQ==
X-Gm-Message-State: AOJu0YyYLcLREpQdrkS9fK/2EwjwIgZ1OAhDl0YwO+qYHsnu9evKVkeI
	LRDng7gpIrZri560i/3fcASARbt6TIS1si70WPiavl0JR4uN/troLMYhhHJX90nH
X-Gm-Gg: AR+sD105kykAY8uauz3qZTwvO9xInU9nu4B7w/fnFq6egjEIPpFwTGulsWSAx7+3sW+
	+ll+2Acdi6H/FpxtX/x8mTzeTe+srebnNUuM2pshfked2bqd95masfuNQJ7IatU6sLvmCH8dkBI
	J80UPbYm/Hw3XTIs1F1nLD+KTlvAdUJkD6UlhHyttNN3AU7CtL3F7ubXms760gIeBmMQ2kpXdsJ
	xWvocKWqCsIAQXUkcDVa1h3pkAOZ+3GihBa2FE9vMU9+BPUf9Cj6cotgDsqfk3AQdRb+ri+A5Qm
	hhoqQ9/soBNMpBEybOooqx9qPV/QwPPPZnAOX6jPq/5Xbpe+XHAbYSvQ1ixBv9sMiUIJCUMyowj
	A2mWXvU7ANIiqMqO+bNrwbtHkYMaSOy24Z952evQyZXJOswZQkgC+ZzJp3srIVwoQQrM9hEIggD
	jtQsVgpKNd9x+4nEPYkOuySfmtgsr3/Ee7DmRTxqmqAYXsNdfcN0XHvC3n7w==
X-Received: by 2002:a05:6808:1185:b0:4a4:934:b316 with SMTP id 5614622812f47-4afae2607a0mr1829050b6e.21.1785899405603;
        Tue, 04 Aug 2026 20:10:05 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:31::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae75ce1bsm977189b6e.15.2026.08.04.20.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:10:04 -0700 (PDT)
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
Subject: [PATCH net-next 09/14] selftests: net: shaper: Add queue migration between nodes test
Date: Tue,  4 Aug 2026 20:09:31 -0700
Message-ID: <20260805030936.1092907-10-mohsin.bashr@gmail.com>
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

Add move_queue_between_nodes to verify that a queue can be moved
from one node to another via re-grouping. Creates N1 with Q1,Q2
and N2 with Q3, then re-groups N2 with Q1,Q3 to steal Q1 from
N1. Verifies Q1 moved to N2 and Q2 remains under N1.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 tools/testing/selftests/drivers/net/shaper.py | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index 1b88e183f1b9..62c74a0c0563 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -724,6 +724,107 @@ def delete_child_reparent(cfg, nl_shaper) -> None:
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(len(shapers), 0)
 
+def move_queue_between_nodes(cfg, nl_shaper) -> None:
+    r"""Move a queue between nodes by re-grouping the destination node.
+
+        netdev                  netdev
+        /    \    .group N2      /    \
+       N1     N2  {Q1,Q3}       N1     N2
+      /  \    |   ------->       |    /  \
+     Q1  Q2  Q3                 Q2  Q1   Q3
+    """
+    n1_bw_max = 10000
+    n2_bw_max = 20000
+
+    _require_caps(cfg, nl_shaper, 'node',
+                  ['support-bw-max', 'support-metric-bps', 'support-nesting'],
+                  "device does not support node scope shapers with bw_max, metric bps and nesting")
+    _require_caps(cfg, nl_shaper, 'queue', ['support-nesting', 'support-weight'],
+                  "device does not support nested queue scope shapers with weight")
+
+    _require_queues(cfg, 4)
+
+    # Create N1 with Q1, Q2
+    n1_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 1},
+                             {'handle': {'scope': 'queue', 'id': 2},
+                              'weight': 1}],
+                   'handle': {'scope':'node'},
+                   'metric': 'bps',
+                   'bw-max': n1_bw_max})
+    n1_id = n1_handle['handle']['id']
+    for i in range(1, 3):
+        defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': i})
+
+    # Create N2 with Q3
+    n2_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 3},
+                              'weight': 1}],
+                   'handle': {'scope':'node'},
+                   'metric': 'bps',
+                   'bw-max': n2_bw_max})
+    n2_id = n2_handle['handle']['id']
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': 3})
+
+    # Move Q1 from N1 to N2 by re-grouping N2 with Q1, Q3
+    nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 2},
+                             {'handle': {'scope': 'queue', 'id': 3},
+                              'weight': 1}],
+                   'handle': {'scope':'node', 'id': n2_id},
+                   'metric': 'bps',
+                   'bw-max': n2_bw_max})
+
+    shaper_n1 = nl_shaper.get({'ifindex': cfg.ifindex,
+                               'handle': {'scope': 'node', 'id': n1_id}})
+    ksft_eq(shaper_n1, {'ifindex': cfg.ifindex,
+                        'handle': {'scope': 'node', 'id': n1_id},
+                        'parent': {'scope': 'netdev'},
+                        'metric': 'bps',
+                        'bw-max': n1_bw_max})
+    shaper_n2 = nl_shaper.get({'ifindex': cfg.ifindex,
+                               'handle': {'scope': 'node', 'id': n2_id}})
+    ksft_eq(shaper_n2, {'ifindex': cfg.ifindex,
+                        'handle': {'scope': 'node', 'id': n2_id},
+                        'parent': {'scope': 'netdev'},
+                        'metric': 'bps',
+                        'bw-max': n2_bw_max})
+
+    # Verify Q1 moved to N2
+    shaper_q1 = nl_shaper.get({'ifindex': cfg.ifindex,
+                               'handle': {'scope': 'queue', 'id': 1}})
+    ksft_eq(shaper_q1, {'ifindex': cfg.ifindex,
+                        'parent': {'scope': 'node', 'id': n2_id},
+                        'handle': {'scope': 'queue', 'id': 1},
+                        'weight': 2})
+
+    # Verify Q2 still under N1
+    shaper_q2 = nl_shaper.get({'ifindex': cfg.ifindex,
+                               'handle': {'scope': 'queue', 'id': 2}})
+    ksft_eq(shaper_q2, {'ifindex': cfg.ifindex,
+                        'parent': {'scope': 'node', 'id': n1_id},
+                        'handle': {'scope': 'queue', 'id': 2},
+                        'weight': 1})
+
+    # Verify Q3 remained under N2
+    shaper_q3 = nl_shaper.get({'ifindex': cfg.ifindex,
+                               'handle': {'scope': 'queue', 'id': 3}})
+    ksft_eq(shaper_q3, {'ifindex': cfg.ifindex,
+                        'parent': {'scope': 'node', 'id': n2_id},
+                        'handle': {'scope': 'queue', 'id': 3},
+                        'weight': 1})
+
+    # Cleanup
+    for i in range(1, 4):
+        _delete_shaper(cfg, nl_shaper, {'scope': 'queue', 'id': i})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
 def queue_update(cfg, nl_shaper) -> None:
     nq = _require_queues(cfg, 4)
     if not cfg.queues:
@@ -842,6 +943,7 @@ def main() -> None:
                   delegation,
                   nested_depth_limit,
                   delete_child_reparent,
+                  move_queue_between_nodes,
                   dup_leaves,
                   queue_update],
                  args=(cfg, NetshaperFamily()))
-- 
2.53.0-Meta

