Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC03C8C46
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899414; cv=none; b=VIUxs/bwyFv6gWQDTZvshlB998Q4869JQQJYSntX/M9gNCApvQhfH9KwpCIebvOIS8nr5bBUKe5EB+np0y1J77YpMoz/Bizz7KeDiv9ic8sSDQrJv8YcEdmXLHyCndAMMcP5OGsHKvJoOeueAAwVXG6p6FrDa5Ygl+d28Z/gFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899414; c=relaxed/simple;
	bh=oOK+6ucr5hFnvPa1Cyt6MMMW2Oz8T8PdrwBeO7VqXz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oibDt3Xh9kVG4bknJZJ7PcdPdOqKmCaZsBVquecRfp7A3Z2EfJ3/hGcQ8XZur4daMIIDX8C1amtB0infrhngX7bug083ioFczTTp2bUnUorFNgjdjnuwmFTMMCIFttIaxmFHFLEsnY31i5vNnTlVMvDQhj3WmbM8u8M572LdcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge5RN1e3; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge5RN1e3"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f0167e59a3so367118a34.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899411; x=1786504211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OyAL7vKiCo/6sYMJZ1fmy0xuR69l2pnMk9awj9AE7OI=;
        b=ge5RN1e3/0j9vNY5SSEMZE56WU74ok3jrFS9M6b1EqhnNt0UI8KdL0pK1j3wu6Wd7d
         wI+FjEJcnrIhfA+ytoVJv2YO9Fez0dM2OtVt9UBBv/1+5sPqds2CWkDSRKnP9QJ7sGL5
         sFY+goJomrh+a2V1iGyTCu1F1BqeQuit0ViP/cyMV+WSj+/U/QTBoMCcptB/uXs9Pz5E
         c3m9MidPEKaYO4QzlU14BmxzF3KiNSWAyroTTxa+H9pwYWcVp2wWBDsgoa1PH+jB5wxI
         rBYzPN11A9UitunZhfklSYCxTnXNs/rrLNPIOdAKh19lADyqfP3Im+mIQb2Nr2/4R/dj
         d7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899411; x=1786504211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyAL7vKiCo/6sYMJZ1fmy0xuR69l2pnMk9awj9AE7OI=;
        b=qJ5oZhbR+teT2O99pUgzbtPIMF/+7xlhtzbWI5dZOgZSoJRJz5sdWos7ME99/Qsx2E
         YYCga/v4L0dkMh0cBTlKLyXBFi2MMxnIya0r+IkWwjWSkM1FCAat0MyTkxzUtIdN3WyC
         vQYssuGU8i1sCbLkppOPhJvgv5+Z1lGDVSKfuJRr7j1uJM2AyKvzWyl0gsmqD5/kRGY6
         kmhb2A+i0q+P2OHkz/iw19SyM+w+t+bg8ltMBuhSmW4SMzeNAJXaJpEcni7LQ/CXghXP
         r6P6LCyqIvIyAxRn+KhHbqH3uWmXr/XXE3P4xCCOLFw7hxNfsMtEONCt+QLu2cioKK/x
         S7uA==
X-Gm-Message-State: AOJu0Yz9x3HJ//87w7ebrD0dR96O4Rw+X6WSBJaqHm7Yraxy2ZOHlI/e
	59WojBhRXkmcoS6RI0XcGlmYEKMmqRrGMGMwaWPVSks/pWJ2eIqLAUqRMHlT7Nov
X-Gm-Gg: AR+sD11ggZy42YP2KsdVlLrGzi6aHQAyyiItkQfnDGwokZNifSw4zAZQ02y1FbTzUAR
	IblWYdnMwz3PIn8PQqRYCTebMqMI2jNx3OQtaLCL7Yk/OC2xhDaCPjREHVcekSa0Rlf/r/6ze9V
	3KpX98JkoZl3DOpzWMOZTNg49dU/axS6d/qYtLfDcqsjd/NZQ9XEZedheK3bQAadJMkBNH5B87e
	FrGJ4zMxea4tvHz/xjxXUM6XVSqUhWDm5W/qY8nIL4RmhvMv5FeUW53HbbgMNQTqBULoVa78bgq
	LJyCitIfQxTJo/02vMlz+3nD4pAM0MuW8Exlt+94nrjegaohcj+it/WKgWQU7vNvjuJUia1T3eO
	U/YEOXI6BOOQ5wjtbMVn/uSOZ2mKfpDhstOJ+/NnHCaJTRDQatgbiY+4LcxqjvDYKYuUs8oaQk5
	jBqo+lxLcamaQZURDb+RbpXGHnxexOw/M9KWwrLRnNeaADQXC9H3MFf7yq8g==
X-Received: by 2002:a05:6871:df:b0:43c:44c9:b87e with SMTP id 586e51a60fabf-4599ebe0291mr1927971fac.3.1785899411436;
        Tue, 04 Aug 2026 20:10:11 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:34::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e1bc01csm1331966fac.4.2026.08.04.20.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:10:10 -0700 (PDT)
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
Subject: [PATCH net-next 11/14] selftests: net: shaper: Cover scalar attributes
Date: Tue,  4 Aug 2026 20:09:33 -0700
Message-ID: <20260805030936.1092907-12-mohsin.bashr@gmail.com>
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

Exercise queue-scope scalar shaper attributes reported by the device,
including rate limits, burst, priority and weight. Build the set request
from advertised capabilities so devices are tested for the attributes they
claim rather than skipped for missing unrelated fields.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 tools/testing/selftests/drivers/net/shaper.py | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index e7af94264409..8dd4897e999e 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -168,6 +168,73 @@ def del_nshapers(cfg, nl_shaper) -> None:
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(len(shapers), 0)
 
+def set_all_supported_attrs(cfg, nl_shaper) -> None:
+    """ Set every queue-scope attribute the device advertises and verify the read-back. """
+    _require_queues(cfg, 1)
+
+    _require_caps(cfg, nl_shaper, 'queue', [],
+                  "queue scope shapers not supported by the device")
+    caps = _cap_get(cfg, nl_shaper, 'queue')
+
+    attrs = {'ifindex': cfg.ifindex,
+             'handle': {'scope': 'queue', 'id': 0}}
+    expected = {'ifindex': cfg.ifindex,
+                'parent': {'scope': 'netdev'},
+                'handle': {'scope': 'queue', 'id': 0}}
+
+    rate_attrs = {'support-bw-min': ('bw-min', 10000, 100),
+                  'support-bw-max': ('bw-max', 20000, 200),
+                  'support-burst': ('burst', 3000, 30)}
+    rate_attr_supported = any(cap in caps for cap in rate_attrs)
+    bps_supported = 'support-metric-bps' in caps
+    pps_supported = 'support-metric-pps' in caps
+
+    def add_rate_attrs(metric, value_idx) -> None:
+        attrs['metric'] = metric
+        expected['metric'] = metric
+        for cap, (attr, bps_value, pps_value) in rate_attrs.items():
+            if cap not in caps:
+                continue
+
+            value = bps_value if value_idx == 0 else pps_value
+            attrs[attr] = value
+            expected[attr] = value
+
+    if rate_attr_supported:
+        if bps_supported:
+            add_rate_attrs('bps', 0)
+        elif pps_supported:
+            add_rate_attrs('pps', 1)
+
+    if 'support-priority' in caps:
+        attrs['priority'] = 1
+        expected['priority'] = 1
+    if 'support-weight' in caps:
+        attrs['weight'] = 2
+        expected['weight'] = 2
+
+    if len(attrs) == 2:
+        raise KsftSkipEx("device does not advertise any supported queue shaper attributes")
+
+    nl_shaper.set(attrs)
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': 0})
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 0}})
+    ksft_eq(shaper, expected)
+
+    if rate_attr_supported and bps_supported and pps_supported:
+        add_rate_attrs('pps', 1)
+        nl_shaper.set(attrs)
+
+        shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                                'handle': {'scope': 'queue', 'id': 0}})
+        ksft_eq(shaper, expected)
+
+    _delete_shaper(cfg, nl_shaper, {'scope': 'queue', 'id': 0})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
 def _group_under_netdev(cfg, nl_shaper, bw_max=None):
     r"""Group queues under a netdev-scope node; caller owns node teardown.
 
@@ -1084,6 +1151,7 @@ def main() -> None:
                   del_qshapers,
                   set_nshapers,
                   del_nshapers,
+                  set_all_supported_attrs,
                   basic_groups,
                   basic_groups_with_rate,
                   qgroups,
-- 
2.53.0-Meta

