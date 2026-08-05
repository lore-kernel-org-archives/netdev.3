Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D73CFF6F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899417; cv=none; b=hfphawr5g9KMoCQu7YqItjGISyhvrLyCTVHUoxenzAc3nKC5HGmG9+HSA9AgXHxOJvlUILKfzQrsfGY0MyjTkFPwyzkrpgcaBRPU9zCzVtDic5jVkBqCuovIkcw71g8tNnSXfYOMGVDbNcUrKUY+bbZNPCMbaCJP4uhvEcwpzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899417; c=relaxed/simple;
	bh=BVyEg/yYgPSwLV5IwdhaQQaJYuhZyIaj0diGnbsjN/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXy7efxaIpYqBHZvASkjym2+0p2fMtCGYjHTN+av1A4joqNk+5ed1/A8u5ZOPFyY8mJbnrleDndzUeqqbEULTEu+hVHbbSqKX0cjICzaZ40UPR/b8yl63d8sZxBkSKSJiaEIsW2BvZ356xAtIRMPNJt2rmJQR6X+ZyZgcxeyrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG1uqBpM; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG1uqBpM"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f18c0e03e3so301452a34.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899414; x=1786504214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wP2lXcYocA4uRBulyzxXopr9bWkNcIAmOaQO5fndKNg=;
        b=BG1uqBpMFB6GxFqavNvHDRjYkU3K3+ij/6BoE+9kjINbb50QG9WuV7g1aUNOHvaH0L
         y78xHcwW9d38lPATELKAYlua53nLENkdynGyGb+EG8siIYBLrpMEQ7ojXTuEC7tSXrb+
         gKjlHsgQl5sBBSlT7a9AKSwItzzpqs0BaLxKoloYKT/LwmJfStyOSFh5UU5JY3HuaE3h
         6JKiFHDEF/9Tfri0gytvZ5MM17FVcOevNcXyME0pG0UeHrvxeQLteNVAb5KAfN+bRuus
         FQPr7pl5fUZaouVIiEVqcohPWd3oQhH8zo43LB5GNJkAcuyGOc6BX0lQj9ozuDM2mUHD
         Rk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899414; x=1786504214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wP2lXcYocA4uRBulyzxXopr9bWkNcIAmOaQO5fndKNg=;
        b=JfTRRMb57FHw1QUbaq55F0sMgvYT5cdH/qy9hMODHOzPNwqxUDA4rSDLElTeH5uD9l
         tF4XWnasOZev2Yr89vmSyLS5LkKLzZZVG3o/c6aJhxpdXTOE1YGiiUpCnHSTeU2iWc0J
         VTXhuRu7+hS46f1/p70yfy2BJfk6TrO3+VBOK4QCtlq1qBNocr9Nqg+Dxgpx2r5vi8fr
         PLRCnL/d0HMYSA4tpC8Br57FcSTrLjR3qCFe9HbWRc4/JRW27q1jb0S6iPEhhsPw4ilZ
         wBZYf/9c3TzdkOHDOHGCpENfSnwsDavn4OUclXqLG6ASrwyfeDbaQK+FZkF8z9yIIRrG
         m1Zg==
X-Gm-Message-State: AOJu0Yx9hw+wiP4BWuNcuREqMuo3MTb/FyVd2MU5i4BXnHOxWQEClJm2
	RCi4dcQJR8+/LtpI0TEdoXqVcke9SKdIXviiaRh8CiMMD7InNeC680jOfnDzWEkO
X-Gm-Gg: AR+sD108sVloXP0JPRfYaV06277U98c+JnEU8C0hmMB9IDCUYcUhMFos6Nm+cX2USUG
	Dp9Ev60zCI8fzhCtQV2mD/sv5pzt3JkiFHbLEnw4oDKCrSQJTyeDdvkNdkB1H4nTOx1P1K1aKta
	qWQFHWJznlbyeIB2wtWyHldJxbvPQjjqJRwEtOJKKTRPGzM4tUqmNJHVfKg7ufwjszQUNmd24Gu
	ow8XJh0MWo6Ou3ap69hLg5+prhCaGEM4D56RVp0d6qr3eMEMSTEFAMTcA2ajmJiWsjlhDdhQq+n
	9ju8BIoc14hZKNc/reYb/qmEZIs+3AEgWiTo2nGk7qC+k2kmLUQgznDUG3w1en4PgeAab8yj1Qc
	u1AAVtloET4WTuCgsCx82mfjUxE46ROP1pttoTNgKsKPamhOSIQ8TC/RRDBxrNmfd3CmVe2CUQS
	CKLe9x9aVgI45ZUJgn96vabPKVYZkBFAjMRyH5zxJBKzt55Mllk7eQrG7zFqBmbtrIgVwe
X-Received: by 2002:a05:6820:2083:b0:6aa:da04:b56f with SMTP id 006d021491bc7-6ae96c10163mr2164961eaf.3.1785899414376;
        Tue, 04 Aug 2026 20:10:14 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae94013615sm1584904eaf.10.2026.08.04.20.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:10:13 -0700 (PDT)
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
Subject: [PATCH net-next 12/14] selftests: net: shaper: Reject invalid set requests
Date: Tue,  4 Aug 2026 20:09:34 -0700
Message-ID: <20260805030936.1092907-13-mohsin.bashr@gmail.com>
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

Verify that invalid set requests fail without corrupting existing queue
shaper state. The test covers invalid node creation through set and invalid
queue identifiers, then confirms the original queue configuration remains
unchanged.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 tools/testing/selftests/drivers/net/shaper.py | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index 8dd4897e999e..02a11e6b9a05 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -235,6 +235,46 @@ def set_all_supported_attrs(cfg, nl_shaper) -> None:
     shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
     ksft_eq(len(shapers), 0)
 
+def invalid_set_preserves_state(cfg, nl_shaper) -> None:
+    """ Verify a rejected .set leaves the existing shaper configuration unchanged. """
+    nq = _require_queues(cfg, 1)
+    _require_caps(cfg, nl_shaper, 'queue',
+                  ['support-bw-max', 'support-metric-bps'],
+                  "device does not support queue scope bw_max with bps metric")
+
+    initial = {'ifindex': cfg.ifindex,
+               'parent': {'scope': 'netdev'},
+               'handle': {'scope': 'queue', 'id': 0},
+               'metric': 'bps',
+               'bw-max': 10000}
+    nl_shaper.set({'ifindex': cfg.ifindex,
+                   'handle': {'scope': 'queue', 'id': 0},
+                   'metric': 'bps',
+                   'bw-max': 10000})
+    defer(_delete_shaper, cfg, nl_shaper, {'scope': 'queue', 'id': 0})
+
+    with ksft_raises(NlError):
+        nl_shaper.set({'ifindex': cfg.ifindex,
+                       'handle': {'scope': 'node', 'id': 0},
+                       'metric': 'bps',
+                       'bw-max': 20000})
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 0}})
+    ksft_eq(shaper, initial)
+
+    with ksft_raises(NlError):
+        nl_shaper.set({'ifindex': cfg.ifindex,
+                       'handle': {'scope': 'queue', 'id': nq},
+                       'metric': 'bps',
+                       'bw-max': 20000})
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 0}})
+    ksft_eq(shaper, initial)
+
+    _delete_shaper(cfg, nl_shaper, {'scope': 'queue', 'id': 0})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
 def _group_under_netdev(cfg, nl_shaper, bw_max=None):
     r"""Group queues under a netdev-scope node; caller owns node teardown.
 
@@ -1152,6 +1192,7 @@ def main() -> None:
                   set_nshapers,
                   del_nshapers,
                   set_all_supported_attrs,
+                  invalid_set_preserves_state,
                   basic_groups,
                   basic_groups_with_rate,
                   qgroups,
-- 
2.53.0-Meta

