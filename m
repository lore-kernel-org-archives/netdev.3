Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361C4854E2
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401433; cv=none; b=mjpWL5q+yKaAanBi0igf77kpwUnK4iSoFjVYHnR0SptF7BVX2UlW9siG0q7pX280AGGtAxNqUn7tZSUJkRos3E4VGarE1hIR14x3KacNWz4xqJybyS93qtI5yw/igprmiJ5cok32IMf0ev7PBMbyStCWExpUgfuBLpLX87mbrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401433; c=relaxed/simple;
	bh=ywhjiYa8sz83VLckyrtdhzFmvCtPRCP4Hc4K0b9W5kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqNxy7jAII4zdNv875YSsHrkS5EN2bBxGuwy5GNIM9Rbm0fN/r1iXpXdgB6KA2iqZR5VZKC1HkZXJ6Jv5pzWJPSIqDLgzoCOuNcQ2/Kay+cxkQbJyCfuitq6pHbzmeQjbeDymdVcZNt4kZDiq0G1ynKbgVQ37y6zrRUjhtA87mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1omn6uf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1omn6uf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b0dd3e1d0so847065e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789401429; x=1790006229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
        b=Y1omn6ufOmc6TMlYctDhWyQL4V0fiPDtr4OPJz12u7h/dqorDa4z0/3veP3eVU+E2l
         lIHxTkyebhYrUB6SZfe5djhUOU/jPXiaGCj2GS8S6MffLUAKLRcQOYaoIxW2XuL9VqJd
         8xsXLe2klBnrDsYI4/BMvqAiPpTUJsE/gDefPij0GFMVkoqPqZ7+ps9uIg5TwvwkkGWU
         IiEmgzMJicqztKRML7fhbY6MLrBO+shWdig93H2IUoZEEsokg9LdeUYCmUdW1CXyZALa
         4HMEgoUsKRTMUQJSs8EEvf8dUJgrx/bFhtUz/0TLRMvDjNp2N05rIj1i1BB8JL4KtL5Y
         wFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401429; x=1790006229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tamt12O2uhKCFMMbIkEpJmlX30Wke4onDdSC/Kq2BvI=;
        b=SudoMKduifj63m8H1op5F6Ktno3VSSDjZdXm3DKlZSNDaYhsHStfeNlWQ3cSiRwiaH
         /fiRtZCM1G4cFicY1kFUwUtoqup0RkqvJ4mVNW/waDrx8b+fe+MsCreSHx/2j1ylj3+c
         kHdPo7cwNikzhewSNJH4/sXaqeDhBFXc5qvrKu31brwI7EWBF6NYTXmr/7WxQLDhX0aI
         crsfIbj5K/I2WH1EdCH2gSy5mosArxv26aah+Cs/rpMbkk7tuYGoEu6fmujKRzwnCMdL
         jFle8w4nCTa8Zfy4/MTLsCiagmlbMnL1YdYTpNNN8CfWQgHnrbQROBSto1/ESn0pnO4G
         ybaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtiE/jtZfSB1esAulpgTATTjw8E4SMpoAYMsOJun7IRNHqQ8DBRYoXVJpo2kbKXu46RSMPsR4=@vger.kernel.org
X-Gm-Message-State: AFuF++mOJlV6Z1b1XtFKpS7IY7wOsF3Ij3s1cSFOnFbttlypXwcv5+zo
	JrRWieSsgaD9PZ4Lz6/PX0nhAUZKiylrfPcYiVJEaBLxLJQZT5sFSypz
X-Gm-Gg: AYBFou0FXvaeRVuyiAUT/epN4K//Zrdf1Ek0RQByQ2kX3JxA13ZpeT0s6oWwMv9QwFj
	erYNneHJNVbNresT0WsWUTUgKh8Ui6kpU3t02nolR98O1qfX8/+lPG4hsunkuXQdyPWpcuxiWRh
	d6WiX0GJI2U8DefP83A3j41fvfrbZX7VIqIq4KYvr9TGVSH7tePOomI163dQ+B3zSycBNJMWExm
	yMWQdftm0rldekomC6m/6tivc9S8qnOBBjn72weLYQ+7bcuHyiP8EqO5RHdt5y79sow9hkxOeus
	JG1YJP6dFlkuySh8vaItsI+e1geeDqDkEJPXTv4stE8ORyAzQqNcxSnQq+z2gZvvLNkLWbMpbKQ
	ZLoMXywd4zent3G4UgVHXHh1G/OZCNG0BC2Ljpb5o5+Gu7X8Tlz2a2BuKl6Y5miIufAe7yko28w
	9zZTv9xVa3mDAm2ML5sNwsKZQZyuEhq/4jlSDxjRyRW+1E2nJ9RrG1stOBvYN4WkjfTGLulkI5n
	2NmfbOuZO0h6TAG1vVq
X-Received: by 2002:a05:600c:19c8:b0:49c:f9b8:bae0 with SMTP id 5b1f17b1804b1-49e7a68a919mr41608245e9.2.1789401428854;
        Mon, 14 Sep 2026 08:57:08 -0700 (PDT)
Received: from Nuel20.localdomain ([105.113.61.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6aa69csm787275e9.11.2026.09.14.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:57:08 -0700 (PDT)
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
Subject: [PATCH] docs: kdoc: fix struct_group_tagged() parsing regression
Date: Mon, 14 Sep 2026 16:51:27 +0100
Message-ID: <20260914155127.21515-1-emmaonana18@gmail.com>
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

