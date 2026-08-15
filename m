Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9953344031
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786780466; cv=none; b=hJ3DhwxdoazBr0hQJo3rZZxqDHaoyCXZygXGwuTh7bILDKuFA1Yu0QRhVs8n0vw0onwbATciE3B2ljLkky1BaUQZR4si/TtFY4gyTosfnrWDzXTy+4tSGt9C/U4GwHFlSJ8j1yZuBPYbEXVCo3gsugYu++WS/7FYnW9nAdGg2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786780466; c=relaxed/simple;
	bh=etoivgHRZLVfAK4Hxp8Ruvu9BsHvh0o8vHz44liCIZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZV6yNMCZt6qvRh3Qs4hkCt18nsPmMNjccG6WW0VvWEWy72jGBwmfKYsLGVXvZDewFnSCvqA4fKJo1vZ1IfF43/Mz6i/ovrLqVJ4jR5A3cRNM1m/oyyOeBucJm+2kdTKAEMAJ6l1tnSfv6iyUcKU0c8bdxQ8qwCihapWzr7RvxeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1pq+zEw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1pq+zEw"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1716099b3a.1
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786780464; x=1787385264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ci0zypAUOOF0XGhkC9Er/Ls5oK0h8JuL+LD8V/pWhD4=;
        b=A1pq+zEwgHpDopEXxjJLK9gqty6hhz8yvWrOc6uQfE8KMrjex6OzNx22ORyHSpSDQF
         NgUMmJ/sdO3J/FVPbdfmIP5EU8CmBbfbVfcoxV3LhlexooqgPtZmL+DK5vzmIQ2W0WDN
         rhX15BNpNYe1frIVJvb1XbvoCjhJxVeC/ClIR1cPy/BOYZ/K0u3l/u0ZQUJAgubHxEuI
         MZ9Fw/NZyvEurZAMqUSHhda7tuL5S6619Ylag+ZaS6GwWjVyF7vs0UrIcPhxjAADmTLk
         1ILv8EZh456jpYOOapVIe1dHin8bzZPuENBvP4md4lcednOykyC2XD7VZ0sTyfKHQW91
         fskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786780464; x=1787385264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ci0zypAUOOF0XGhkC9Er/Ls5oK0h8JuL+LD8V/pWhD4=;
        b=NpXH/mRQ5gzY7FdnQxlmLn7EaGHjY9o6LTgEw4BHXU3xdvoVXMEAwAjtriDSraAxpV
         odjr2+cd6+/2cOjGNYuactnTgLdBzKNZKvKUKkUaX1Wkh9PTc4mC/lORxTluo3XksJKu
         sczIymowqwPttQ5lzc7x6y0vm/xLkeffjvdbDW4vrV9eyQqT6/dZYC+S1YmK8MbxibHV
         Y+uCeJ9Dtq/NKbniAvdmPBwdAI7V7tDHjWYWninT56rw39a4RrNStqKP1yQK/Dv2ZMdq
         rji7Ejz6VPAgK9WB567n7KycVRfqRJtZmMLaE/w6MT/P5G7HQmJzladrc4tFfkZpmnmt
         7eYA==
X-Forwarded-Encrypted: i=1; AHgh+Rpt3bA/96NBicwVrqfuLkQkf8We2U3cS+ZVklBa+TvuRwN1gaZD/TTc9rBaFAXoFTMyALKBELE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuaPOEB+TVQuJ5/jlI6QL5lzy/zYlYRPzteBLebcbisXizSRR
	/2j0YTyBgLEbmTd5xpWc/sl31eXLxLnc7WLV5dLtQbmpZQXymfnF8gY4
X-Gm-Gg: AR+sD12tgLTKbWGVt58Aic2khazCoBN8YAyTam7YlwP9M2WmBKPiiD+pg9SFyYY8fjG
	/spAjg6bZxYdWe/1RMNOTDtuW2Q+eKArLYouAS5y0dI1+7PG7RRVayHRuWiqRX6MOXuz68gLdhL
	jX4e02ECzvnfnAfsQQR4G6XK/aASRLOSkBBJPxEnLRYj3ZKwg07zR0sapMv43XesRJ8f0iPyM9/
	214sM8MFBSG8QppLyl0fmrGu6larooZnt7nBBjC8+81NPs+XjUluxUreoCfqpKMU8oGCPTEcT+g
	0duLfK4Qqlb9+Y0E3Cc4/uPBJFlk19HmXaiU7Juid34SFptdBsAwT14ejE8OL2zdIZm40jRlSLB
	EbLw4H99DrjzK/QEf4weHlXXCt8f2GWSCXTmMJ1YhzUorYFmHvVXcsL2i/vyrnVYOoVXfzHc79p
	XtdYMdf9PMZ8eYPMQEVwoCJWHe7P+lm8VTqPy9HnvhPRiFIZqTXTNzVivObL5uI9/p9pIPknlNB
	5wwvxbEpG5p0Lq1qpYe2dU=
X-Received: by 2002:a05:6a00:3011:b0:84a:65e8:137e with SMTP id d2e1a72fcca58-84fc7d25091mr19056956b3a.17.1786780463814;
        Sat, 15 Aug 2026 00:54:23 -0700 (PDT)
Received: from Ellen ([114.8.222.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d2487e1sm1191281b3a.41.2026.08.15.00.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 00:54:22 -0700 (PDT)
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
Subject: [PATCH] wifi: nl80211: document sta-info nested attribute
Date: Sat, 15 Aug 2026 14:53:54 +0700
Message-ID: <20260815075356.144762-1-hilalrahmatullah11@gmail.com>
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
 Documentation/netlink/specs/nl80211.yaml | 347 ++++++++++++++++++++++-
 1 file changed, 346 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 802097128bda..0d54ffb314e8 100644
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
+      - 26
+      - 52
+      - 52p26
+      - 106
+      - 106p26
+      - 242
+      - 484
+      - 484p242
+      - 996
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
+      - 26
+      - 52
+      - 106
+      - 242
+      - 484
+      - 996
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
+        nested-attributes: sta-info
       -
         name: wiphy-bands
         type: nest
@@ -1601,6 +1666,98 @@ attribute-sets:
         name: nan
         type: nest
         nested-attributes: frame-type-attrs
+  -
+    name: rate-info
+    enum-name: nl80211-rate-info
+    name-prefix: nl80211-rate-info
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
+        name: s1g-msc
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
+    name: sta-bss-param
+    enum-name: nl80211-sta-bss-param
+    name-prefix: nl80211-bss-param-
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
+    name: sta-info
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
+        nested-attributes: rate-info
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
+        nested-attributes: rate-info
+      -
+        name: bss-param
+        type: nest
+        nested-attributes: sta-bss-param
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
+        nested-attributes: tid-stats  # TODO
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
+        name: link-metric
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
+    name: tid-stats
+    enum-name: nl80211-tid-stats
+    name-prefix: tid-stats-
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

