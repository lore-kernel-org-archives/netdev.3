Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A53CFF6B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899422; cv=none; b=hCs6P6oFtLKVIYtY/tiwIMHuER+0LkVqcbcwJbbxh/uDJSoEP9KH/66qjPoti2nKvt62CzjdfsALNp8EV/deLDfCeOpc+q4FDEVoO/ThBra2EkuuD/gxRSzkeMB2tiwfxVF6kj7W+F1Iv6nOwVhw/vYtCmFO9K/p2Pmk3gb+wmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899422; c=relaxed/simple;
	bh=Ew9kqnx7gNLh63gLTyVSPNRcNPey74+hcBLknh/TAH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIAa0JsHyoyb0c4rd/xk9IFLdSfR7m62DTY9Xje2Lrtg77auBLKfoXNab8ZtjSDhXnakj2kDMV3CwXjEihn8N0w66uXoT58E7vVYKmbYGG+v86ju3hFBGn2164wLyq37fom6KbZqWKU0lxgmKqpeB3c0xRpGern/7/mD3hIAr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fffVNSwF; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fffVNSwF"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6b554044fso563711a34.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899419; x=1786504219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lcsQyfByd70EchMKWRKdanf3VR0eB6+yq95Jw1CGYPw=;
        b=fffVNSwF35pnScmiJy0Gp4fzCbMgu5G1uZpHPxqqfBMgi6BoUoCLdsXE6xAPkCf2XG
         EP/RIs1SOuKK/HoGfZkTK03EAtzHBcIncvj3uamJoLrAGOKJF9Sq2qrCJz98CpZw9uj2
         0p5Xaw1yjrdKMG68bG7IYHKySFHtPIZlO5oNpsFT15xMXA6Ces2p1e90+Dx78CLjua9m
         KfiQijfAR+6jzxTbxYaZFBsM94xVyQs80yWStyg+32wpjzWYhN4tZEngokyoBFnTraRX
         x3mUQkIa20ex0jSqsrc8ZXZ4zgkBP16dAxqybfRjuRZVMIPynxxePap1O+Ze3vLg5nLw
         bCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899419; x=1786504219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lcsQyfByd70EchMKWRKdanf3VR0eB6+yq95Jw1CGYPw=;
        b=PFPqxf9i3cF/LgkHJgIbxCEqTamy6zrlkm9ESYg57MsgAB+HyD86T3nJyeM5HKTGCO
         lMOGl6GehklgU8kwOGsjcKZLUXOVk4cYYcYkVVjSmtKat8PVngQV13jspz+z/4evMOEk
         pg14lxoZ9w1++uVLQKLSYgNiypnWkyH6am5D2vZVE41ZvtUxQ/DuMxwvkxHvQBAf0oJt
         IIQtfoQDEv+9+GawgwRm9hXbPmMBgC4YOnl68aB0Dg5+iSX2SGcuHNF0evv3DyPgY+wQ
         onD0CYXl8AATBBY9OeCbzNYOlhOItwGbYlSA8dAuQWS+UfmXBhpk7NioEwzQcQneqF8P
         mxUQ==
X-Gm-Message-State: AOJu0Yy7wkVvaymuFINvAcJITIToF28nhC4THXPkOP3j/y3IraBbjayX
	W52FpuxBXdnr3da9nUG+evNnbPXEej/7rLCeBOiAI0P1o/emNfxt06SFqPrfsydz
X-Gm-Gg: AR+sD10F3Kc2cCvYkVKtpTvcBx9ABvgZdTbbfNRmIznA+6u6V7LGr2uQyINf7L8OeB8
	5iarAXlYD3JdjtLam60l7Lw8wtW9wsHy5qg/BB+/HLbywRnCtSyTLaj289ELD+WgquAR30LyEcN
	wt4H2Uib6cDJz8f64PeUcyv6hChlrTHhcPvL7mDtGQzJAlQS0NaI9pBC/YZ/nawka3mBf8MwEQR
	ewFP99DOxWc02bew0wbWRUbwaz8C2ds5ba3lUAZLEX0Ej2HLMYgw/mNOY1OiZOuymMBWAxwHD14
	gx+pp0lWA6gXoMC1bnU/voiip7awWV5RlxzdXo8iKo5JOyl11BFg36OWKYbfDgDkcoUURja7+90
	Tha4fMlk6tRIgwIcULzCY31d/+F9QuLu7a8F8zLsSH1m2ZSMjQlNKyu7uPs4nQoJvirVCOhT+l1
	H6LvbxIg9F97N5ZVIgTeHN1EATqSpxZ8apL0tyuTQjvgiZSltvweSbBZfsZQU=
X-Received: by 2002:a05:6820:1990:b0:69d:e4c8:86f6 with SMTP id 006d021491bc7-6ae96e3b5afmr1985507eaf.15.1785899419557;
        Tue, 04 Aug 2026 20:10:19 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93cbf7a9sm1632805eaf.2.2026.08.04.20.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:10:18 -0700 (PDT)
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
Subject: [PATCH net-next 14/14] selftests: net: shaper: Cover recursive node cleanup
Date: Tue,  4 Aug 2026 20:09:36 -0700
Message-ID: <20260805030936.1092907-15-mohsin.bashr@gmail.com>
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

Exercise cleanup of nested nodes after deleting their last queue leaf. The
test builds a two-level node hierarchy and checks that removing the queue
also removes both now-empty node shapers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 tools/testing/selftests/drivers/net/shaper.py | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index 9264aeb74a7a..a53316726f69 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -374,6 +374,64 @@ def mixed_parent_group_requires_parent(cfg, nl_shaper) -> None:
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(len(shapers), 0)
 
+def recursive_empty_node_cleanup(cfg, nl_shaper) -> None:
+    r"""Deleting the last leaf recursively removes the emptied ancestors.
+
+        netdev             netdev
+          |       del Q0
+         N1       ------>   (N1 and N2 removed too)
+          |
+         N2
+          |
+         Q0
+    """
+    _require_queues(cfg, 1)
+    _require_caps(cfg, nl_shaper, 'node',
+                  ['support-bw-max', 'support-metric-bps', 'support-nesting'],
+                  "device does not support nested node scope shapers")
+    _require_caps(cfg, nl_shaper, 'queue',
+                  ['support-nesting', 'support-weight'],
+                  "device does not support nested queue scope shapers with weight")
+
+    n1_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 0},
+                              'weight': 1}],
+                   'handle': {'scope':'node'},
+                   'metric': 'bps',
+                   'bw-max': 10000})
+    n1_id = n1_handle['handle']['id']
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': 0})
+
+    n2_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 0},
+                              'weight': 1}],
+                   'handle': {'scope':'node'},
+                   'parent': {'scope': 'node', 'id': n1_id},
+                   'metric': 'bps',
+                   'bw-max': 5000})
+    n2_id = n2_handle['handle']['id']
+
+    shaper_q0 = nl_shaper.get({'ifindex': cfg.ifindex,
+                               'handle': {'scope': 'queue', 'id': 0}})
+    ksft_eq(shaper_q0, {'ifindex': cfg.ifindex,
+                        'parent': {'scope': 'node', 'id': n2_id},
+                        'handle': {'scope': 'queue', 'id': 0},
+                        'weight': 1})
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 0}})
+
+    for handle in ({'scope': 'queue', 'id': 0},
+                   {'scope': 'node', 'id': n2_id},
+                   {'scope': 'node', 'id': n1_id}):
+        with ksft_raises(NlError):
+            nl_shaper.get({'ifindex': cfg.ifindex, 'handle': handle})
+
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
 def _group_under_netdev(cfg, nl_shaper, bw_max=None):
     r"""Group queues under a netdev-scope node; caller owns node teardown.
 
@@ -1293,6 +1351,7 @@ def main() -> None:
                   set_all_supported_attrs,
                   invalid_set_preserves_state,
                   mixed_parent_group_requires_parent,
+                  recursive_empty_node_cleanup,
                   basic_groups,
                   basic_groups_with_rate,
                   qgroups,
-- 
2.53.0-Meta

