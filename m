Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED73C2B8F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899393; cv=none; b=s/FLzpZ8bOPauQIY2WJfCgSPQ+59iGCKfEL1/jRVPbNjWYMK25NguyKDC5iEhW5Ah5DTvh8SUJkrAaVsSL0oqGvs4rjDq+s3JPAS2qy4R9N4nysLsyBkQSPazLvz+Z72KAwM4QrWQTJHxQEwy0NdDBjku/Xpz2eDt2xE2317xpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899393; c=relaxed/simple;
	bh=XRFbGwBPH+VhcUUJQun7WEUilFRIAXetdV49cKT2ZsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL6NBYoyKuRNq4sJ/9K0dgt53/LEsTN0Sgsht7m9AFpuCXZsFq1eBQ4mVkt7je3FHYzZp8p2etamlIEh8I39OtXteuXktBafUCB0a/1q33LtsEALp6ChwQqnWHwj0oyKyOvCzgaPsQiX5PHGKVm/zsRxmEk2EF4gx5e5OhrbIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a02UEEks; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a02UEEks"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a43c2a126fso222057b6e.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899388; x=1786504188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHy5sGAOZy1JqOYJk5ores2aowoHjNjgJFZMFnGPHyE=;
        b=a02UEEksFWf7VoDG6peKCswahEDu+Wxlm73XYa/rya/kgotgyu+48nd4LcTn+5fHAg
         3QeQTwesRn+/azVHmspQsD4sX7qYmsHxrfBYO6AgmCt4SzJxzRX8zy4rldbFkrqpMao3
         Z+ledxb8IW+POtEO6Mq7PXPsAfChCzGc3oTpadsAcdHT4MtUXpHvi+6w47uTB+8Ll87g
         pIC9H0dsABLeGdL7VuKrtis5dcygVumpQNuJbcirb1KaV0s6J9V3QTr8DxVZh1hnyWic
         CKBI4XaCs7Pn+2FFR4wNLnYh0Oad+Xwg02MFJ662PcuMflD+CbCa9QmI1daY5lC4w5Ta
         Dl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899388; x=1786504188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kHy5sGAOZy1JqOYJk5ores2aowoHjNjgJFZMFnGPHyE=;
        b=ErJ6ttn6hkZT3OpiY4zHxy6bCA//Tfxlp6yD6iXnklT0Q26sZQBxgEGHJeaUnH+f6o
         VWvec3jojo2eD0llPbe+qckLTyoa987CY5CJYhEUzm9w2xe8smkKLDhYaVTBE2I615QF
         PDgUvl900vL3BaQGfx8b70pJwWW0A8tbPJ87s1MwyVrt7Q+OZ2CR7vMnPGc6eD++2JH0
         ZVl7i/WQtyKXq6lFLTNPOJlwAEPznQPTQu9YkxGH8/0xHledjQ/1QFxaoaxBHKJS/pQH
         98DOqRYuXUr4Gm4NuB1eyGr5nWVv8s6i8nh86jXM2cePLS/Bzj0vM4/RzdPqH1MpbKh2
         z0QA==
X-Gm-Message-State: AOJu0YxYRGmGQLe2KvmCnBnQ7NXuvfC47NWOR+3JunmKwG4IJmGSQUay
	xmuVp/0fWQ0g3RlyjyBbBr/B7d6Poh/bumuvoSkvyc3PWLCTl1cES/AFOpV8Ap2P
X-Gm-Gg: AR+sD139SRPlWkmqZuPBQJo4h/JTG8i8EAI0cCRdsDav8TpwBK4chLoEZDM2lbBwC48
	TFOWsWfGe57fsls+l5m9sLTY2JDdZHLX8I4posingQdGMnFlMWPy2yH5h6IMe94JTkD0ZsMZzr/
	3X4OH6IBXnVCaZdzUuKnx+4i8ZH67FtX/b24R9iQfdIbiSWuJZ9q2c5U1Y10hDXNbfqbnC29gp+
	I0e3lwPWDafYxXlyzuD9d7+oZ9cxAarxxutJjHiaiXV55oRg4SKEtRDMoCbPravBQa1HxuFIe+J
	p2AiChRk0KltSAtMZd8gN0tdIupQVGN0xaPiRSCKy9o2uEd0uZjEFYA9iaarB6aLh/+A9JzcOwV
	Nnh6gotCjuGNO7Dp7fGtOu4+Ln6wzTNBtdtKSO+fM/EKvc1MZAFQe/A9ahx2TGWSBn+FG8BDs0K
	Eu+p+gcxyZfg39MYRp29C9Nhk2b/vDJ/0Z+L+F1u9HkgHwbZfvqnbUpylTRg==
X-Received: by 2002:a05:6820:f012:b0:6ae:87e3:e306 with SMTP id 006d021491bc7-6ae96ecc5e5mr1905385eaf.20.1785899388158;
        Tue, 04 Aug 2026 20:09:48 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df5a4f9bsm2087653a34.23.2026.08.04.20.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:09:47 -0700 (PDT)
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
Subject: [PATCH net-next 03/14] selftests: net: shaper: Decouple basic_groups from netdev rate limiting
Date: Tue,  4 Aug 2026 20:09:25 -0700
Message-ID: <20260805030936.1092907-4-mohsin.bashr@gmail.com>
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

Decouple basic_groups from the set_nshapers test dependency. The
test was gated on cfg.netdev which is set by set_nshapers. Replace
with direct capability checks: netdev scope support (required for
grouping under netdev handle) and queue scope nesting + weight.

Remove bw-max and metric from the .group call so the test validates
pure queue grouping without rate limiting. The rate-limited variant is
restored in the following patch, which adds a dedicated
basic_groups_with_rate test.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 tools/testing/selftests/drivers/net/shaper.py | 40 ++++++++-----------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index 1954f3263f25..45a4bf42995e 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -168,19 +168,11 @@ def del_nshapers(cfg, nl_shaper) -> None:
     ksft_eq(len(shapers), 0)
 
 def basic_groups(cfg, nl_shaper) -> None:
-    if not cfg.netdev:
-        raise KsftSkipEx("netdev shaper not supported by the device")
     _require_queues(cfg, 3)
 
-    try:
-        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
-                                  'scope':'queue'})
-    except NlError as e:
-        if e.error == 95:
-            raise KsftSkipEx("shapers not supported by the device")
-        raise
-    if not 'support-weight' in caps:
-        raise KsftSkipEx("device does not support queue scope shapers with weight")
+    _require_caps(cfg, nl_shaper, 'netdev', [], "netdev scope not supported by the device")
+    _require_caps(cfg, nl_shaper, 'queue', ['support-nesting', 'support-weight'],
+                  "queue scope not supported with nesting and weight")
 
     node_handle = nl_shaper.group({
                         'ifindex': cfg.ifindex,
@@ -188,31 +180,31 @@ def basic_groups(cfg, nl_shaper) -> None:
                                    'weight': 1},
                                   {'handle': {'scope': 'queue', 'id': 2},
                                    'weight': 2}],
-                         'handle': {'scope':'netdev'},
-                         'metric': 'bps',
-                         'bw-max': 10000})
+                         'handle': {'scope':'netdev'}})
     ksft_eq(node_handle, {'ifindex': cfg.ifindex,
                           'handle': {'scope': 'netdev'}})
 
+    del_node = defer(_delete_shaper, cfg, nl_shaper, {'scope': 'netdev'})
+    del_queues = [defer(_delete_shaper, cfg, nl_shaper,
+                        {'scope': 'queue', 'id': qid})
+                  for qid in (1, 2)]
+
     shaper = nl_shaper.get({'ifindex': cfg.ifindex,
                             'handle': {'scope': 'queue', 'id': 1}})
     ksft_eq(shaper, {'ifindex': cfg.ifindex,
                      'parent': {'scope': 'netdev'},
                      'handle': {'scope': 'queue', 'id': 1},
                      'weight': 1 })
+    for dq in del_queues:
+        dq.exec()
 
-    nl_shaper.delete({'ifindex': cfg.ifindex,
-                      'handle': {'scope': 'queue', 'id': 2}})
-    nl_shaper.delete({'ifindex': cfg.ifindex,
-                      'handle': {'scope': 'queue', 'id': 1}})
-
-    # Deleting all the leaves shaper does not affect the node one
-    # when the latter has 'netdev' scope.
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
-    ksft_eq(len(shapers), 1)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'handle': {'scope': 'netdev'}}])
 
-    nl_shaper.delete({'ifindex': cfg.ifindex,
-                      'handle': {'scope': 'netdev'}})
+    del_node.exec()
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
 
 def qgroups(cfg, nl_shaper) -> None:
     _require_queues(cfg, 4)
-- 
2.53.0-Meta

