Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7D337BBD
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786786673; cv=none; b=luJUY7cli7sTDq7cMBdK1dgV/Ui+oGgQTHEnUoPfQgR8Yctrag1MvS8MAbMPJ1vOiMI2V0GrjfxI8IO8hLKcTUOXE5ptIfDzb8HoXnnhJiKq9dOrbOrCmzxxQQ1J7opNUnEKIDTYUd8NGQ34peWXVzH31Bg1L7pddEIPHb6e/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786786673; c=relaxed/simple;
	bh=C60xoHz78mVIHVo6a9Ng+WxKZVa581Uh2S6njcyV4Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OH7OtAc5crT6qmWctf1A/yOwwNC2/UP93YHJ/+BiRK70LIGHzMdWrVEL/PrL8kGV1MsYXYteCN2bkGlws7qmOyayanSCVzTbYraWsFR/Cv39n1Rd4XVyHs/vkf3/XAffGvFqgtGNGgwY+Zh2z7GNZdFoXS4Ezs0w0sepkPznKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXp7rLTU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXp7rLTU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccf2360620so18961545ad.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786786671; x=1787391471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5x53/rxHYSkRal7lhppMKIPimu8T59g1z/jaHnIAFZc=;
        b=CXp7rLTUfKwNNkRa09Eggq58kecqjsLB0+ESWnTzFkUAQrNEXzMdUrEV7Y67iJ2t6v
         EDni5wY7Fl3+V1RkpXv5YCm4HXenBPCV00+4qht1GK27jHUqaAT4g9viz+2wieNHcbSB
         M57osyhnOlecrUxwFO6wdbcQPw42LNp/9lHCArfBpP9XulgfFDPLHrOkW2crkhFkAGzY
         PpBnPPkVTBeQcQZIGYUUdsrGdezquUa6O3yfxGZMuGiCt31cw8tpJf7F65+u6absEQ3b
         QG1JfzRDJBN9b4Tt8PFquafZGQGl/CHwsP7aNfyd+/+1EQdgY9TxRxKcXEHd6Ta42H/S
         GL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786786671; x=1787391471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5x53/rxHYSkRal7lhppMKIPimu8T59g1z/jaHnIAFZc=;
        b=Dc8aJEKJ79PILdSl0vJqym0coNjDyYV8RECFzP100LsHWLAskvUEsikH0d7WWhvbxN
         lEw2f7bdXH8drlDJoCPplsTwWNr8GlZ57oebY1QKze6QTsfudtHQQrIgdUAa9/56eUvQ
         JDHhYz1lpdZjcIGQETI9beEZmfz2nR9pM3+pKVhWWQGPAzDuSlyETIPaVZ/Lqza3aXZz
         FDQGDGGWzsCkxZWKZEb6udouQdjQOZos64o/5FL1RNfEsKTKj2HtA7ztc7NJSNq8lHy9
         V7WbeocTVj2BLumW24h9/SaiB73V0NFhrYD8eTz+60cpCLxaUMopqIOcNuSyKatSqHut
         zOlA==
X-Forwarded-Encrypted: i=1; AHgh+RrX9PUy3YD5HxAbM9CoaUe1jWFAaQhagfVTJbLmBpGVEoy2UUwwfZTMEZaDASPOhb3O3hU64rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiq84EW2MDkmQPlAxdJAt0uUK4PK8PU+rCuRksNoGyBjgnFGN
	3b5aCRnsxa6xmhkZTK8ek35Dcph7p+J27B0B7L4fUpgN/Vaq3ko5U/99Fff7Sd1M
X-Gm-Gg: AR+sD13Wc95fS8Hqd11cOQN5Ax3iscrmM6Ox1CWhczlRAhENaC+m7azJgObvu6Ty7oi
	6o4R8ple8xM49bH7WE9M21DVDw/lGQ6RPodn3eSxk/wO23ubLYw7+YA7luwYPe7PMc9g+M3HuTC
	Qeb1eD24n82STI98SIrRyxxESNtkoScCEnwIFHl36GQR9gjaLlljPi/jV0vV9D3sutD8za31BRS
	XHzoaVV58UcNQGdzsShQJ7Xd88DnvQDhWUFSNrKRUdKikHqcTolHgugWXwpt1sKtG3cxHJe46vU
	WKVTUMtU79fWdTriLDYwo88H0zcUAjf9RTLGzY8UV/iv0a67smjkXE2Y4M0vyf+j3/F5Sd5Quqi
	PJvHaAW8miZbjWHcYM37akKsGw8TwkdLrHImvwA1hshaEGJAPxxz4k3w7xZoJAj46eHzazryea8
	N7oom8j+zdAcNU3j3mKwbnKA2oxM6v4ygmDNNKc24/TFFWPfLDlJtUjAaaaPNrSIi13NLB6I5KV
	R0inMopPhThq6R+34gGfpKoyG4M
X-Received: by 2002:a17:902:ce86:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2d3b0aeeb6cmr124415255ad.2.1786786671056;
        Sat, 15 Aug 2026 02:37:51 -0700 (PDT)
Received: from Ellen ([114.8.222.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebf17absm18004055ad.80.2026.08.15.02.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 02:37:50 -0700 (PDT)
From: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Cc: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
Subject: [PATCH v2] wifi: nl80211: document sta-info nested attribute
Date: Sat, 15 Aug 2026 16:37:28 +0700
Message-ID: <20260815093729.150037-1-hilalrahmatullah11@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NL80211_ATTR_STA_INFO nested attributes definition, from
the previous binary type.

Signed-off-by: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
---
changes in v2:
- Fix nested attribute name
- Add double for numeric enum member

---
 Documentation/netlink/specs/nl80211.yaml | 347 ++++++++++++++++++++++-
 1 file changed, 346 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 802097128bda..4068406a8875 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -211,6 +211,70 @@ definitions:
       - ht20
       - ht40minus
       - ht40plus
+  -
+    name: eht-gi
+    type: enum
+    entries:
+      - 0-8
+      - 1-6
+      - 3-2
+  -
+    name: eht-ru-alloc
+    type: enum
+    entries:
+      - "26"
+      - "52"
+      - 52p26
+      - "106"
+      - 106p26
+      - "242"
+      - "484"
+      - 484p242
+      - "996"
+      - 996p484
+      - 996p484p242
+      - 2x996
+      - 2x996p484
+      - 3x996
+      - 3x996p484
+      - 4x996
+  -
+    name: he-gi
+    type: enum
+    entries:
+      - 0-8
+      - 1-6
+      - 3-2
+  -
+    name: he-ru-alloc
+    type: enum
+    entries:
+      - "26"
+      - "52"
+      - "106"
+      - "242"
+      - "484"
+      - "996"
+      - 2x996
+  -
+    name: mesh-power-mode
+    type: enum
+    entries:
+      - unknown
+      - active
+      - light-sleep
+      - deep-sleep
+  -
+    name: plink-state
+    type: enum
+    entries:
+      - listen
+      - opn-snt
+      - opn-rcvd
+      - cnf-rcvd
+      - estab
+      - holding
+      - blocked
   -
     name: sta-flag-update
     type: struct
@@ -297,7 +361,8 @@ attribute-sets:
         type: u32
       -
         name: sta-info
-        type: binary  # TODO: nest
+        type: nest
+        nested-attributes: sta-info-attrs
       -
         name: wiphy-bands
         type: nest
@@ -1601,6 +1666,98 @@ attribute-sets:
         name: nan
         type: nest
         nested-attributes: frame-type-attrs
+  -
+    name: rate-info-attrs
+    enum-name: nl80211-rate-info
+    name-prefix: nl80211-rate-info-
+    attributes:
+      -
+        name: bitrate
+        type: u16
+      -
+        name: mcs
+        type: u8
+      -
+        name: 40-mhz-width
+        type: flag
+      -
+        name: short-gi
+        type: flag
+      -
+        name: bitrate32
+        type: u32
+      -
+        name: vht-mcs
+        type: u8
+      -
+        name: vht-nss
+        type: u8
+      -
+        name: 80-mhz-width
+        type: flag
+      -
+        name: 80p80-mhz-width
+        type: unused
+      -
+        name: 160-mhz-width
+        type: flag
+      -
+        name: 10-mhz-width
+        type: flag
+      -
+        name: 5-mhz-width
+        type: flag
+      -
+        name: he-mcs
+        type: u8
+      -
+        name: he-nss
+        type: u8
+      -
+        name: he-dcm
+        type: u8
+      -
+        name: he-ru-alloc
+        type: u8
+        enum: he-ru-alloc
+      -
+        name: 320-mhz-width
+        type: flag
+      -
+        name: eht-mcs
+        type: u8
+      -
+        name: eht-nss
+        type: u8
+      -
+        name: eht-gi
+        type: u8
+        enum: eht-gi
+      -
+        name: eht-ru-alloc
+        type: u8
+        enum: eht-ru-alloc
+      -
+        name: s1g-mcs
+        type: u8
+      -
+        name: s1g-nss
+        type: u8
+      -
+        name: 1-mhz-width
+        type: flag
+      -
+        name: 2-mhz-width
+        type: flag
+      -
+        name: 4-mhz-width
+        type: flag
+      -
+        name: 8-mhz-width
+        type: flag
+      -
+        name: 16-mhz-width
+        type: flag
   -
     name: sar-attributes
     enum-name: nl80211-sar-attrs
@@ -1631,6 +1788,170 @@ attribute-sets:
       -
         name: end-freq
         type: u32
+  -
+    name: sta-bss-param-attrs
+    enum-name: nl80211-sta-bss-param
+    name-prefix: nl80211-sta-bss-param-
+    attributes:
+      -
+        name: cts-prot
+        type: flag
+      -
+        name: short-preamble
+        type: flag
+      -
+        name: short-slot-time
+        type: flag
+      -
+        name: dtim-period
+        type: u8
+      -
+        name: beacon-interval
+        type: u16
+  -
+    name: sta-info-attrs
+    enum-name: nl80211-sta-info
+    name-prefix: nl80211-sta-info-
+    attributes:
+      -
+        name: inactive-time
+        type: u32
+      -
+        name: rx-bytes
+        type: u32
+      -
+        name: tx-bytes
+        type: u32
+      -
+        name: rx-bytes64
+        type: u64
+      -
+        name: tx-bytes64
+        type: u64
+      -
+        name: signal
+        type: u8
+      -
+        name: tx-bitrate
+        type: nest
+        nested-attributes: rate-info-attrs
+      -
+        name: rx-packets
+        type: u32
+      -
+        name: tx-packets
+        type: u32
+      -
+        name: tx-retries
+        type: u32
+      -
+        name: tx-failed
+        type: u32
+      -
+        name: signal-avg
+        type: u8
+      -
+        name: llid
+        type: u16
+      -
+        name: plid
+        type: u16
+      -
+        name: plink-state
+        type: u8
+        enum: plink-state
+      -
+        name: rx-bitrate
+        type: nest
+        nested-attributes: rate-info-attrs
+      -
+        name: bss-param
+        type: nest
+        nested-attributes: sta-bss-param-attrs
+      -
+        name: connected-time
+        type: u32
+      -
+        name: sta-flags
+        type: binary
+        struct: sta-flag-update
+      -
+        name: beacon-loss
+        type: u32
+      -
+        name: t-offset
+        type: s64
+      -
+        name: local-pm
+        type: u32
+        enum: mesh-power-mode
+      -
+        name: peer-pm
+        type: u32
+        enum: mesh-power-mode
+      -
+        name: nonpeer-pm
+        type: u32
+        enum: mesh-power-mode
+      -
+        name: chain-signal
+        type: u8
+      -
+        name: chain-signal-avg
+        type: u8
+      -
+        name: expected-throughput
+        type: u32
+      -
+        name: rx-drop-misc
+        type: u64
+      -
+        name: beacon-rx
+        type: u64
+      -
+        name: beacon-signal-avg
+        type: u8
+      -
+        name: tid-stats
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: tid-stats-attrs
+      -
+        name: rx-duration
+        type: u64
+      -
+        name: pad
+        type: binary
+      -
+        name: ack-signal
+        type: u8
+      -
+        name: ack-signal-avg
+        type: u8
+      -
+        name: rx-mpdus
+        type: u32
+      -
+        name: fcs-error-count
+        type: u32
+      -
+        name: connected-to-gate
+        type: u8
+      -
+        name: tx-duration
+        type: u64
+      -
+        name: airtime-weight
+        type: u16
+      -
+        name: airtime-link-metric
+        type: u32
+      -
+        name: assoc-at-boottime
+        type: u64
+      -
+        name: connected-to-as
+        type: u8
   -
     name: supported-iftypes
     enum-name: nl80211-iftype
@@ -1672,6 +1993,30 @@ attribute-sets:
       -
         name: nan
         type: flag
+  -
+    name: tid-stats-attrs
+    enum-name: nl80211-tid-stats
+    name-prefix: nl80211-tid-stats-
+    attributes:
+      -
+        name: rx-msdu
+        type: u64
+      -
+        name: tx-msdu
+        type: u64
+      -
+        name: tx-msdu-retries
+        type: u64
+      -
+        name: tx-msdu-failed
+        type: u64
+      -
+        name: pad
+        type: binary
+      -
+        name: txq-stats
+        type: nest
+        nested-attributes: txq-stats-attrs
   -
     name: txq-stats-attrs
     name-prefix: nl80211-txq-stats-
-- 
2.53.0

