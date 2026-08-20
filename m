Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86D3C3F4F
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210516; cv=none; b=TbjW0Uj0BXrfw9bp885el81MYILPcS/MxNlpu8CXG886Hdd/brxGJeyeKmdwDFpz0txkKjSvofT5R3gO7XgUUyojbAYTikykuaTjuqUuoa7Aw5QCAvK/Gzzq2UmQ2Z4pKXhHilt+WMoqT5CnVPqjJmBY8MCy5n/yJMo5sHn+ITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210516; c=relaxed/simple;
	bh=/8Jr/wyVTiDbmFVxdFPSEUeGqZcDVc504xqdEqlbWdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pno3QVeiPqq2lC9eGgGB7w1w0gymp4YuYAaJP/mJjAaXCg/Hb9pmaql2iwFdKxVsGaMTu2c/ItYRNpH7uc5fC6kc88/BSbcmjbklwSJVY0Mudtnef9sETo5xKIlZkDXy+eYXRTcE2Y3/5toN7KjWrgcjhWEC8ZEXVunidkxDISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXT3T1jZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXT3T1jZ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso1234941a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787210513; x=1787815313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uiCGnvtF+0p3h1Jeoq8tYgPymZrdarjHEHWH2skPwEY=;
        b=PXT3T1jZzXnJ7tAvmB2uX8BaixPcyUVAuLxwvpXqJQXo+Bm9yVxQIDWhJd/yr0lzXh
         A8TwH71j2cXYphBXm+GSw7X1OqU/PwPRo2hy30TfhChMrw8jNch+nqYIoDqbkIhy4QQU
         hS49/WeC+sKiJazDTIa+4hm/J+rVUw6GK/TpATwg4dh7qNAkc/bd5z3COXC55oqnfVr+
         hWVHauWDdSF3TGrbliWDXE8dPJ8jn92wTKzWJ7nIiu0XN6jrS3o+oDUDWpywtKA1kTbL
         cewY1sEIQoXFvvQ2Nk4FZTcvKJrIcfE9bfwZdTANZQCmohtCUGHOeG0kAI5hsBJR3AH4
         6ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787210513; x=1787815313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uiCGnvtF+0p3h1Jeoq8tYgPymZrdarjHEHWH2skPwEY=;
        b=UAx1bVSDfEQU8v945/e+2XH4ECZp5nkxLV+yZlxms9IDsA99HXfTr6quXa+BHRTXXu
         +IsxDwibKJPxYIPfrfstw48ABGOCbOg39jH8frpNgj2R6S6lZeGzEickfxCppqHdpvME
         jbQSXPhQlwg8Z4dHqSoSCffQJBDU0LFtF2+MV25LZ4zD54CAppG+g25hFfZ0AsipWF2X
         gY4EemZVkMG09Usunw8xhWZrSIDrGHyAYHyyd3SYUyQN67Tam1CsTsEmioEKQL/8evOV
         OCp6khsGZ4d+6ccHnTzgGsR66gJqdOlCEjwR5Gy0fF6CUnetoFYbw06yVHslHFngJLck
         K42A==
X-Forwarded-Encrypted: i=1; AHgh+Rq7wgjW0Lzn0YJJrZuOq0OD1pdSN51L1cBeA13X+1MvhiiW33VUepT/xKubri2/1IzJTvOVsCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJT+2AQmJ/CztVRsqOEdF1fj8nbIYFKiws4wSMav67aHBoKo9
	vkvevIStMlhFadS0eMAmjYQQ/YQSf26QFE6awkwmTlCbBty4rJcLP2NX
X-Gm-Gg: AR+sD10XPhpCF2Q4acDTBZCQgLqEw0H+TYEf1/HmnZ+QBAD8dVHXxzxHtjpumY0pGmY
	DYLoYd1tWGZVN4VCF0KEB/VNsWo3UMdd4AkgabAndECgBjn+LJknWTj70cYByNmMwC7s39A2NnG
	xu2F15wk5UhTADqbzYnnVQMxUzBQmXdwoTFQXgDPuGtRVBmHjo4Vt3zveVKpDOjLKbCMmQawCmR
	9kPWjUS5wgf8dDyRgPN2KRr4Q7T0VHJ93nM9OPXCqhgRltv0jC3YVKhW6Uv9fL22kQCiABK6JGK
	LChpLhnDkw2LYvlfPlI9HQb+qNBtLbEa0+D2+W+/I1KZJ+sU41J8HrvdoxAxsVVgW5dLnmdSq/M
	xzTBwPkHquz5IPLlRdk55slIPMK83TxJ9rRIUpNWqtro4qiu4HQ94eYtZypYiFo1Fg1p3prLCDz
	MYRlLnQO0t63al8iFyHd8GacLSnP3PWkVQNiRsEz7C0iPOsT6pfSwl2XuSZ2CUsQihs6Gj5JGaZ
	oxxRh4+KWeVIsIPL/2Cb5Y=
X-Received: by 2002:a05:6300:2285:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3cd017c44afmr22096519637.13.1787210512714;
        Thu, 20 Aug 2026 00:21:52 -0700 (PDT)
Received: from Ellen ([114.8.219.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77bfcsm12491963eec.9.2026.08.20.00.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:21:51 -0700 (PDT)
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
Subject: [PATCH net v4] wifi: nl80211: document sta-info nested attribute
Date: Thu, 20 Aug 2026 14:21:40 +0700
Message-ID: <20260820072141.15779-1-hilalrahmatullah11@gmail.com>
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
changes in v3:
- add missing he-gi attribute on rate-info-attrs
- fix sta-info attributes order
changes in v4:
- add uhr-mcs, uhr-elr, and uhr-im attributes of rate-info
- fix chain-signal field type
- add optional prefix-name for enum, avoid upsetting Sashiko

---
 Documentation/netlink/specs/nl80211.yaml | 366 ++++++++++++++++++++++-
 1 file changed, 365 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 802097128bda..9ac34ee44e0d 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -211,6 +211,76 @@ definitions:
       - ht20
       - ht40minus
       - ht40plus
+  -
+    name: eht-gi
+    type: enum
+    name-prefix: nl80211-rate-info-eht-gi-
+    entries:
+      - 0-8
+      - 1-6
+      - 3-2
+  -
+    name: eht-ru-alloc
+    type: enum
+    name-prefix: nl80211-rate-info-he-ru-alloc-
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
+    name-prefix: nl80211-rate-info-he-gi-
+    entries:
+      - 0-8
+      - 1-6
+      - 3-2
+  -
+    name: he-ru-alloc
+    type: enum
+    name-prefix: nl80211-rate-info-he-ru-alloc-
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
+    name-prefix: nl80211-mesh-power-
+    entries:
+      - unknown
+      - active
+      - light-sleep
+      - deep-sleep
+  -
+    name: plink-state
+    type: enum
+    name-prefix: nl80211-plink-
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
@@ -297,7 +367,8 @@ attribute-sets:
         type: u32
       -
         name: sta-info
-        type: binary  # TODO: nest
+        type: nest
+        nested-attributes: sta-info-attrs
       -
         name: wiphy-bands
         type: nest
@@ -1601,6 +1672,111 @@ attribute-sets:
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
+      -
+        name: uhr-mcs
+        type: u8
+      -
+        name: uhr-elr
+        type: flag
+      -
+        name: uhr-im
+        type: flag
   -
     name: sar-attributes
     enum-name: nl80211-sar-attrs
@@ -1631,6 +1807,170 @@ attribute-sets:
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
+        type: binary  #TODO indexed array of u8
+      -
+        name: chain-signal-avg
+        type: binary  #TODO indexed array of u8
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
+        type: s8
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
@@ -1672,6 +2012,30 @@ attribute-sets:
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

