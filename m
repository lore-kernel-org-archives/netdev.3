Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E93264DA
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786875158; cv=none; b=QwCbNUY+Y5NbEu/pFodCv869z8scxm8Ij8V9Ms/oZkhuoGIvck2BmxGtQBI5D2Nr8bcdkyOUXHCKkJm08df2mtm0XcBP3bKDF6hNMoxH73NW/ztCGvq95alEeyj6HrpTAMTQuKmbYMeu9DDmQx4+xFKF6JH/Dd8CLrChj2CTkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786875158; c=relaxed/simple;
	bh=hYCfcwTKoIoK462b8zttXXMNwiJJt2/c6k4Pmz2D6hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUJjRi8dEd61HHQ3jy2hvg6r7+F35RsmSKvYFTYpLyEWjVuu++yfN2XHQ6pMW+7jeqRaaJSXKbbHYjrXSIjHluUMb0mo8e72z93GVdv6vb3DGZX9oAqlvQRVunwZzvMQCS14JPXWR8WAqEct9PlcLEiTfqeSNqCBNW3MwyZ6NYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIlELqc5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIlELqc5"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1839512b3a.3
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786875156; x=1787479956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8UPLvvjMJjXNWe0UttpOsCFOyd1owNBi81dZYuJGIRs=;
        b=LIlELqc5VrHMH78yDErT1l5up5Xq2KVGilmLVuWiI7MqRaAfYIgzQF2bpjjsnk7vf1
         C6YVReKjoX0CzlaEBioe5ygdUq7ADQxfFIUjs3G7QOWsxC06y5+iObmsoJ5bpdcW5kuF
         LK8eT+jdDBGk/T2HuyOOG9iGxek2HCxxJjC7uKpZ/v63rcQERta3CO4OmXM5mRfIAlCv
         tWJQLLYpgQJsGV5D5N8YguhfLjlG8l9AydZx8ILa/Xs7ojUhsiGY1cscne5IimZ2VqGC
         mAUUat8/ZAlx0SB52ymqrIYpxUPYMhkivC5JAm3yE+dUGToCSFEpKZUbPYWEYnPhTDDF
         Q3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786875156; x=1787479956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8UPLvvjMJjXNWe0UttpOsCFOyd1owNBi81dZYuJGIRs=;
        b=GOMX722eKu6ygW27HDwUG+YCK1w7YbiIAfa7Pum87pVAl6lamelR+uRptjIqFdUnSl
         KaKqh4yrhcyzxvCm3l9UCXeR5WJHpAKl1+j+n3dfuH7nvYtYWoIbxQJMT9vM8urX21V7
         lyvrUZP9UJrksTXe7y//c6kfHaMMnyGf3haoqmxvwXpRuy3Fmh9DgLrmnzw6qy3zsLyN
         g4cVryhNfsi3mkAxM6RM9sgExb5QAt104r8FwadFmMJunsQzV5RhpkfBWzqiimS9l3v9
         faK221/Brovawxmrr9EF5mxb1VFd8hDffCxfjakwmpMQ/7iSLfaK9P5Xyruqssw5+LMc
         ljmw==
X-Forwarded-Encrypted: i=1; AHgh+RqDa/JLB9iI27wa61BWyOZmzb8BlNDsRI6UJoTTLKkMs4kSl/V60IIYJ5SY/Xwbb46CLHjBHfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaylNMPmPaC8XHnN+lt5e0ueVT7QZDkKAzTXsIfvvxxhVYg8ZE
	co78rs9ssCoec77JYeZNPCwiipZ5TUioumqEiAe11iAuKpxyQ4wn52gC
X-Gm-Gg: AR+sD135J3eCVyZNPrlEmktu6lUqe5+O3CnshEEUeAwJAAN+7xi5gWV9jBiIkWVsZs7
	ab/oyeAi4qM2xinMK31ySsL1uXX+dHgfWg+5iZLaXqWqo5JYAm2lC2eW+WSwUg5JUHAq82exPwJ
	Pks0YaEHHXb4kFWnAQyn+lMfarCc/70JqcF3ElLxKSN85yAJoUiAhMOstvaFyE1rvu60xRFZ6nM
	3s0vBHQZYcqxHqTVMeXuzJfFsfMQEwLWwY0KZyj9JEYhkF+JJTYqzFuKLGiWEaLRQvYQE3h9Zvx
	EBGEcEBEiOmLhyrqZLARX0BMuwk+3xHs18hZ3Y4TtYG7HH3Gr2TZr2N8qVc4yOvTu0WrU2yeR/U
	hweCm15gZQpF4WkVSMA/phDbRTB8eIPRYdwdW6lX+WPdNNfvEV21GvOyhJSZ/MuHIXjn5xZ4fBs
	984txJswCVwMWeo6PAJ1TeegGJatWxbbw0UO2lUwIMb9ENoeLbLNsC9FowE7r715+zjdUIvFQel
	cClvBzJi9bKNT9CvykOPmc=
X-Received: by 2002:a05:6a21:a89:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cc71acd3b3mr22587777637.14.1786875156430;
        Sun, 16 Aug 2026 03:12:36 -0700 (PDT)
Received: from Ellen ([114.5.110.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2f787fsm23902821eec.20.2026.08.16.03.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 03:12:35 -0700 (PDT)
From: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Cc: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
Subject: [PATCH net v3] wifi: nl80211: document sta-info nested attribute
Date: Sun, 16 Aug 2026 17:12:15 +0700
Message-ID: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
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
- Add double quote for numeric enum member
changes in v3:
- add missing he-gi attribute on rate-info-attrs
- fix sta-info attributes order

---
 Documentation/netlink/specs/nl80211.yaml | 351 ++++++++++++++++++++++-
 1 file changed, 350 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 802097128bda..4ad391db4a76 100644
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
@@ -1601,6 +1666,102 @@ attribute-sets:
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
+        name: he-gi
+        type: u8
+        enum: he-gi
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
@@ -1631,6 +1792,170 @@ attribute-sets:
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
+        name: rx-bytes64
+        type: u64
+      -
+        name: tx-bytes64
+        type: u64
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
@@ -1672,6 +1997,30 @@ attribute-sets:
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

