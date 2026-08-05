Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B93C76BB
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899399; cv=none; b=fLjHdMPfpz16KPFF/Phc3Dss8wq4X/UfriQLTxvpQQRdNhRJ4UcyHIKlMqjIxRU7xaeWkmS9vusEG446lfFBUc44Rytfj4/ZAb7USq6Vg8geCEJqQokTgZ3fWENPG+EOKFCZ9Tg4AKnHM2Fe4eqvBZDZAWvVr8qi1w85Oush4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899399; c=relaxed/simple;
	bh=3szltxY+VKk6xH+PjO6+PE+6DNN7VLfS1oL4wAwfWNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+o1/A0sI0bBKhT3iLVhot7EsRSiikOUThte9kzNj6IVG5gwXOVepKwTDuvvGsZn0EZkqXqadEO+KC+5weZFUtIUoYSPPdrQx75oVr+G/2GwB+f+OBlg6jWuIY0LLEp8EZZJ2fe8y3noJ1Fd4b2DDmdT6ZYamvfDICKIzjBIOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCqWzAp4; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCqWzAp4"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso234581a34.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899397; x=1786504197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx9eKdgdP27MAi2E7/idObyxLUuxucE1tvirxr3bM3A=;
        b=JCqWzAp47ocZjsiyfR2ehPlwiOt+9ScULRXT+VW8z0hqai+9mU+qSydfAJY+exETKP
         v0BnmTIEM4Puo2WrOBH0ttrWeQDUvK1SKDW3ApYV1/OBb6pqDVDF+7kwjxiEuoit4MPw
         SOuqghk2VseJhr/vYCr5RjeANbj1++1vn2D/5H1yNkSZu3XXICRrbLcqif8VjlDxTNnr
         lR6VZgkSCyiV5qYdbIEyMzBdkzNLBHdfzBg5i6HXFGmLcF26hPHY1dLNtkgVYptHX8yc
         0V2n3cswvQcADzZfvXWRb6rfjMwbXldQxw8NUPnz4aoIly3VqupjjTNdE4MWdMP7f02T
         VlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899397; x=1786504197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yx9eKdgdP27MAi2E7/idObyxLUuxucE1tvirxr3bM3A=;
        b=gKKKPxvZI2X6ZIkBDWj8ZOH8GwQzjkGYE+lqpdAjrUvCXD3WvsKpDv3ryPdzv2sppf
         v1NYm0J0BPMqDjGYsrXe8uTBfMPvXgDp8zqguAoWzpqpIutxAPm06j8w5hLLQRHIHhwv
         2eZz2s4H0i39/bjQHTNuEsmjqHfvL64zh0bdgspaPBwghVQ3K5sPc5bSpG49FI2Rnd95
         aZr8Y2i9dcUdUqV6kyC0YvFR0MlTPlYwwe7u6mqJgc5Jp+Jn86qG1SGjiH+/MPeON/Xd
         q1IOe5/x5n8XdkAOyYHRiZxXjDPgLyBoTXPGpK782Ub3xJnlu1sM6rpbkHgHRB4ysURE
         +meQ==
X-Gm-Message-State: AOJu0YxGvl6ONw7EqpDeYSeVx6Dw+E/buLmGZaoFx2gce7eUL/eoLoJ0
	o4YQGy0+Lm8iJld8mEf8x+bdj5UJj7Y6XDONXVWmYoKdDM377mbPXktlt3bZ/XuE
X-Gm-Gg: AR+sD11x71iHMyiHrqslZG81l4SL+iaSwlBIM2BEQGzorWiUkvH6fO6d8WTl3pXIQeD
	R4OXsSbZ5IBfbh496ouVjJNnvG03a6rSb3OwboIE4KB9JTltA+t5Du2smUp1B+ltPD7ORDJrc7Z
	lLgqI/K1JpvzYKkfFyZlibYCTt/SY8eT1pWd+QYna6li23ZgENk9dJ+yKKIHPTo2I0vdJshQYmK
	x7jUhFlv/Kq7F5dO4jIJ0fRw8xdMPHiKTuB8pj6hFwx4asZDhvig0gpYSsDmqyFx2RY0GNKYMwK
	C/1CYiQhN0qVGKnNOe3ombrk/A8r1Z0j9KkXkfgDwK+b8hFHOuelemEECn6sZX9+p3vUaWa54HJ
	AmVL190+g/8e0jBBGPDxT1XMr0shK5GHgIuIK9ZgCvtBk2QAz7OB+OscEatIKmw5XEw/oPjoTEe
	x579x2azJwjtDbOGlJPOXs1g4hS3rvVgmmrKrFrSN+gd5WPaTLGhpwdfuO5g==
X-Received: by 2002:a05:6820:1c89:b0:6a1:963d:a040 with SMTP id 006d021491bc7-6ae96c1b2famr2191220eaf.2.1785899397197;
        Tue, 04 Aug 2026 20:09:57 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:47::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae940782desm1636211eaf.14.2026.08.04.20.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:09:56 -0700 (PDT)
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
Subject: [PATCH net-next 06/14] selftests: net: shaper: Add .group rate update test
Date: Tue,  4 Aug 2026 20:09:28 -0700
Message-ID: <20260805030936.1092907-7-mohsin.bashr@gmail.com>
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

Add group_update_rate to test updating an existing node's rate
via the .group callback. Creates a node with bw_max=10000,
re-groups with bw_max=50000, and verifies the rate changed while
leaves remain under the same node.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 tools/testing/selftests/drivers/net/shaper.py | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index 62ac83b7701c..5eccbe437ba3 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -380,6 +380,72 @@ def set_node_shaper(cfg, nl_shaper) -> None:
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(len(shapers), 0)
 
+def group_update_rate(cfg, nl_shaper) -> None:
+    """ Verify re-grouping a node updates its rate while leaving the leaves untouched. """
+    _require_queues(cfg, 3)
+    _require_caps(cfg, nl_shaper, 'node', ['support-bw-max', 'support-metric-bps'],
+                  "device does not support node scope shapers with bw_max and metric bps")
+    _require_caps(cfg, nl_shaper, 'queue', ['support-nesting', 'support-weight'],
+                  "device does not support nested queue scope shapers with weight")
+
+    # Create node with Q1, Q2 at bw_max=10000
+    node_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 1},
+                             {'handle': {'scope': 'queue', 'id': 2},
+                              'weight': 1}],
+                   'handle': {'scope':'node'},
+                   'metric': 'bps',
+                   'bw-max': 10000})
+    node_id = node_handle['handle']['id']
+    for i in range(1, 3):
+        defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': i})
+
+    # Update rate via .group on the same node
+    nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 1},
+                             {'handle': {'scope': 'queue', 'id': 2},
+                              'weight': 1}],
+                   'handle': {'scope':'node', 'id': node_id},
+                   'metric': 'bps',
+                   'bw-max': 50000})
+
+    # Verify rate updated
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'node', 'id': node_id}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'handle': {'scope': 'node', 'id': node_id},
+                     'parent': {'scope': 'netdev'},
+                     'metric': 'bps',
+                     'bw-max': 50000})
+
+    # Verify leaves unchanged
+    shaper_q1 = nl_shaper.get({'ifindex': cfg.ifindex,
+                               'handle': {'scope': 'queue', 'id': 1}})
+    ksft_eq(shaper_q1, {'ifindex': cfg.ifindex,
+                        'parent': {'scope': 'node', 'id': node_id},
+                        'handle': {'scope': 'queue', 'id': 1},
+                        'weight': 1})
+    shaper_q2 = nl_shaper.get({'ifindex': cfg.ifindex,
+                               'handle': {'scope': 'queue', 'id': 2}})
+    ksft_eq(shaper_q2, {'ifindex': cfg.ifindex,
+                        'parent': {'scope': 'node', 'id': node_id},
+                        'handle': {'scope': 'queue', 'id': 2},
+                        'weight': 1})
+
+    # Make sure we only have 3 shapers including 2 queues and the node
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 3)
+
+    # Cleanup
+    for i in range(1, 3):
+        _delete_shaper(cfg, nl_shaper, {'scope': 'queue', 'id': i})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
 def delegation(cfg, nl_shaper) -> None:
     _require_queues(cfg, 4)
     _require_caps(cfg, nl_shaper, 'node',
@@ -580,6 +646,7 @@ def main() -> None:
                   basic_groups_with_rate,
                   qgroups,
                   set_node_shaper,
+                  group_update_rate,
                   delegation,
                   dup_leaves,
                   queue_update],
-- 
2.53.0-Meta

