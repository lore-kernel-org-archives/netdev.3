Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B54E4310
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593051; cv=none; b=MLh7W5XlVCZFqefIdFRKnf4l71xUK9dBIJ3zJ7PO9K4O2lqTSFrrvK6v4fmqqO1gX/BCZeLkXQLKtnewkgz9gdSLcPQjOY92vcR72J6OhAMDigAiGc18lyBRkmwah4GNDXS7R3DRbAxECWEtoVhjBGizFkrbESmVR9gzwj3Zf3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593051; c=relaxed/simple;
	bh=ywhjiYa8sz83VLckyrtdhzFmvCtPRCP4Hc4K0b9W5kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvDv9LwGthICa4ChwO1LsLmDOdtfYYRB8j6/9ZZDdIZ1DY2NuYhs+DeV5b3YdY0ijLxjdtB005Z3UkwB+E3buGjVLHWNztrU8bU/oCOogwbi8tgkyi9x5CcAwdyIixAYtVvB3/krM4DKykUxv+2dLJRBMrZvIwL3eYPeIAGoVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8QoSzwK; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8QoSzwK"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482e1b429f7so26881f8f.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593035; x=1790197835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
        b=o8QoSzwKAJvAF95bDjle0Ra7fpr+vdC/oGehT6Y3AHFp893+jxprGKH417/+7jZiQL
         IQi9CuYbKxFk8Gvy2rEPnMIu2pVq3k9PpSDWT1PH/9TPyeLYvLwWeJLtpCtcdXwpdtsd
         ORjATGpjZ6cTg8fyrG5FG0jmx74ZAmL6bYeaTmobVE/M3vaVrvXTJ72C0AMiX57IO3In
         Ro1/lQxLunoGMmIb2sx3sgka7heSnWM4nO0qDyn/PzkL8tYZhdLLCWPiXZfwRNg/mAET
         3NaiaORC8hIfXPnGrBoiR5k4ZbgXysBD4GfMMq+kJUx9cvq8wiBi/CvRk/w/ICzE5lok
         DSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593035; x=1790197835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
        b=ZqcuGHou3uujQqkHvSU0ygAsmOAfFLc4o1lfK8tCjYT5PHD6lsmSa+qUm7BLAbei7d
         H+RCFM/XYB5OtbzISlku1CcETWKdgKvr8I6AsqbtW0ZLISt56cD2zN8YtqG2flWty+tN
         bh4l+YMUy1T5DitxKHiRUGY0a0M48v68fm2NJRyhZm7UCbyPkhAzY6UpNvFuEaGPV/nk
         eI/nGHI3WhmQk34qlVIYQoVDOD7qphcbPr+mJbUGJ8Y2dwJP46olmKGhKyCi23tfFJLX
         5zbcDgZQwbmkwlFRIjgPOa6m/wIxoGKNaCkRRxGPXeY6NZobjosuGFBC4MDAfE8zOVBb
         Ea0g==
X-Forwarded-Encrypted: i=1; AKwUvBxCNjfpUu1b8AaxPxNnC+XE2lCWzn1fQmA5z+npEwcJL/qb+HSMW+pDtzQMbdU1SHq2iOyWam4=@vger.kernel.org
X-Gm-Message-State: AFuF++lYqPkobqafcUVEwwgeyzOMPvTJwxoEvYti14ji9QKBHvcLlYKN
	m082g1KZRR8xdRr3K+J+Jba8nNtEHFAgJIvwKtY9owabN8EAeMUio/rP
X-Gm-Gg: AYBFou0lqGTZODe5Me03khmqrM1kXQm87EFyu5iH2grbtPgJCFSbbaHDI0EPS7ylC+V
	aS5iay7TPTDNVnXwKNbXL+amy7W3FUGVkdGnpbog7fNy7nTJnT73qZTgGJwu/qEJSrPZl8sjlwz
	vyivOMHF/598AEkGvdHZreLd0iq4jNACM6Me3DFE8q2f3QNoHJxA9hb0xuJNajavnQbHfP5rwVX
	wNBtQ6aPPr69qjSVTrOFwNoXHkrISBaQ3rqGfP2ruR1Fn6x+HtraZ67ALl5MJqfg3Efbgid611n
	yGKst/lDp1MltM8YDaCQhUAUemjVG3Sp6GS+30rc9maNfddpShD7sUtWl2EtiKezsCap7tYDMqi
	onUksL/Pbf3YkhqYAicy9lXZTTpVwqsJ0Aa6FQF5FvQzdbd3V+3SNJsUny/HMzBYiCq8yBNUwQV
	kxEE60XqOarGMxKx0YWYcG57SmMEPmbsPJbRil9oIdd8kuw1TVg/s3/INpV8Clsd6e8DLqgxe++
	urubXPozbDdvve+BXaf
X-Received: by 2002:a05:600c:4ec7:b0:49b:9241:7ff0 with SMTP id 5b1f17b1804b1-49f1d516b6fmr45330575e9.0.1789593034942;
        Wed, 16 Sep 2026 14:10:34 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.73.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd226ef3sm19858565e9.1.2026.09.16.14.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:10:34 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mchehab@kernel.org,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	tudor.ambarus@linaro.org,
	emmaonana18@gmail.com,
	bvanassche@acm.org
Subject: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing regression
Date: Wed, 16 Sep 2026 22:10:12 +0100
Message-ID: <20260916211012.16821-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc reports struct_group_tagged() members as excess because
the macro transformation rewrites it to an anonymous struct and drops their
member names.

Keep the tag and member name when transforming struct_group_tagged(). The
nested members are then recorded as names such as fast.order; accept the
existing unqualified @order documentation tag during validation.

Add a regression test based on struct page_pool_params.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/all/0cf8ea5f-418f-45f0-907c-3d1ed4f03e9f@infradead.org/
Fixes: 2f07ddbd5793 ("docs: xforms_lists: better evaluate struct_group macros")
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 tools/lib/python/kdoc/kdoc_parser.py  |  4 ++-
 tools/lib/python/kdoc/xforms_lists.py |  2 +-
 tools/unittests/test_kdoc_parser.py   | 37 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index d9ad1ddc87dd..ced09504f3d7 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -635,7 +635,9 @@ class KernelDoc:
                 continue
             if param_name.startswith("{unnamed_"):
                 continue
-            if param_name in self.entry.parameterlist:
+            if param_name in self.entry.parameterlist or \
+               any(actual.endswith('.' + param_name)
+                   for actual in self.entry.parameterlist):
                 continue
 
             hint = self.get_suggestions_hint(param_name, self.entry.parameterlist)
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e3dda2fe8a53..9e8b3a6b1da1 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -60,7 +60,7 @@ class CTransforms:
         #
         (CMatch("struct_group"), r"struct { \2+ };"),
         (CMatch("struct_group_attr"), r"struct { \3+ };"),
-        (CMatch("struct_group_tagged"), r"struct { \3+ };"),
+        (CMatch("struct_group_tagged"), r"struct \1 { \3+ } \2;"),
         (CMatch("__struct_group"), r"struct { \4+ };"),
     ]
 
diff --git a/tools/unittests/test_kdoc_parser.py b/tools/unittests/test_kdoc_parser.py
index c4a76ed13dbc..1a8287e99f2e 100755
--- a/tools/unittests/test_kdoc_parser.py
+++ b/tools/unittests/test_kdoc_parser.py
@@ -418,6 +418,43 @@ class TestSelfValidate(GenerateKdocItem):
         """
         self.run_test(self.SOURCE, [self.DEFAULT.copy()], self.EXPORTS)
 
+
+class TestStructGroupTagged(GenerateKdocItem):
+    def test_nested_struct_group_tagged_members(self):
+        source = """
+            /**
+             * struct page_pool_params - page pool parameters
+             * @fast: Fast path parameters.
+             * @order: Order of pages.
+             * @pool_size: Number of pages.
+             * @slow: Slow path parameters.
+             * @netdev: Net device pointer.
+             * @queue_idx: Queue index.
+             * @flags: Flags.
+             */
+            struct page_pool_params {
+                struct_group_tagged(page_pool_params_fast, fast,
+                                    unsigned int order;
+                                    unsigned int pool_size;
+                );
+                struct_group_tagged(page_pool_params_slow, slow,
+                                    struct net_device *netdev;
+                                    unsigned int queue_idx;
+                                    unsigned int flags;
+                );
+            };
+        """
+
+        kernel_doc = KernelDoc(self.config, "test.c", self.xforms)
+        patcher = patch('builtins.open', new_callable=mock_open,
+                        read_data=dedent(source))
+        with patcher:
+            _, entries = kernel_doc.parse_kdoc()
+
+        self.assertEqual(len(entries), 1)
+        self.assertEqual(entries[0].warnings, [])
+
+
 #
 # Class and logic to create dynamic tests from YAML
 #
-- 
2.43.0

