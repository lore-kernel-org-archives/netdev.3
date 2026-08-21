Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C416416102
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298474; cv=none; b=m6VpMQ8m6KgMgpuuiK5qQCoNfD6oZPMPBi5LSBy1J2z/noYYAsme1zrGuQCsCog10NMxIsW/UDowj+rDkwBKBV4A1XTa9rqKK1yd0eaoEWi4PJAGNovU3MaNvFKljlkDk/sZKpIm3HLnWsXa7dbrze7wH/0uTQY+70bWCRPVcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298474; c=relaxed/simple;
	bh=cD7umswusIn5QlB0XA5e9jYsyTJqh0u7+AqhPL63lOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/bhhv5bBVUkp+bR4dtKROc/3UDcvUJC7pcmllswtlR56jsnYYR0Ddo8NbocboTaMTs/vewHQzdKwYWR7YeQ3AEej22zd269m/YMWp+XPWi1zhjT0fb27W181naTgcMw8w3Pl4sOvXLm9cpaxJB1It+snLNaxNnifp8TzInrtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQEH5H1D; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQEH5H1D"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84830c774a0so613022b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787298472; x=1787903272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BB8SfPQkiB+xXAGlwY8sckGMfChjKijBKx9/NEKD8Nc=;
        b=YQEH5H1DwwC4Ag21HY06n0lCMeMBLexraCrC3WhXf2axyTks21r5Vn67vaCwAslmtU
         VFLPbSI1JVb3HNw+xmQALjs6E8QPnLB9CYju0C7o8TE0c2TQJ3Hpgz6kOMt9740Duey5
         uajlvchdcxEVSUNRRj4UY3A34vZlTT9unnJ7zdWe/4LmdFjGNBv4LEIu+ZjeIgGr9K+6
         rb3QKYkyK0e2HJPrW+L5BqqAubg0shewzQBExVIznAVTAsSFeUuMXzNq0vC7n7D79Yfl
         sKFFUSR4bIaMAZcNoKqmukz250vronJHUusKy9emjAxqJ66ToCqNeXhMNsHOGyg3VnSw
         L28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787298472; x=1787903272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BB8SfPQkiB+xXAGlwY8sckGMfChjKijBKx9/NEKD8Nc=;
        b=V3eXbAPCY0ahaXewPEFzbC8JrIrSp4QwvzpYBviWYMvAWL3zfiL8Ya5cZ4QlM67kIU
         ynuS9PHnhHYppOZ+5tM7bao2NNPKHeyK21C3XkBPxSYtWmKitht/4Zpv01PqXfm7qtUX
         KD/4oG8i9pEfMZh7J6DZ/EEEzTZl/qijLzWCYLQDFSikmD+I06YoxjtVoZc8E/B0CmGL
         HAx5a5hjHq8j11INJW10bqUUl/+reWhMlSKFweulhNdrlIMSZAcEK+V/7KM1E/ZcwbaZ
         ygxhVKy7QpdScsdyUJIBXSg7HxTeixOSGpjaJWy8mIK7fod4683iT8FY+K0AcYaEMcKG
         uAkA==
X-Gm-Message-State: AOJu0YxnBVyGLvzouGSuXm2t5R6SI2llxJY5WvveJ/G+4jY04bBlkDqz
	c93Bj/SrolZ4wGq7wtv/8SBTK1EPqtpGfabzg01ANzNmoN7ZTuj2eEDc
X-Gm-Gg: AR+sD10DizPouQu9/yzFDAjlAFa7gLQi0oD1nTYFs2tet7n+aLGrGEd4PLetZ10JR20
	pW/UPxxPWw0uiCKv+c8Xgm0yXNS8Om8rNk0dKtqDvtVeb+qqwgzb0XCvU9ICo/FaQ3fiiywYm4a
	8cj3A+D9sLM96fhJNvpFtu13ZQw4pXN7O0L3w/Ei24nQl8evsB7BWaE7UZGKgiBp17RhpGeMluJ
	If47SNmn7Vb5B5hIirn3utN1Ml/mt3wxKgBzrakjsLepCF8i1nhZAfrxsQk+ipjoA3ByGBOFLhp
	KH86Vna1349T+A/JIH2gtcEjKEqQm4wcctprKjf8WHPY02tNVe8Q5RGMvqrUPOtrLWoqWteLh+L
	4E6Mw/5AfvDuI29O5KPEd7RYtFMtOLbrFsEule0UNPJ5BXhB72qsE/0oYaA63ftVInLF9yuuqO6
	fEXrjHFeDBO2/jWUJMqQfce9zeI0sxK6Nx4EFAinD+VbH9S7PDChDR3NhxKtc8rgRvmfyd4z1nx
	j4mKEW7bL3Honx8EFoKs6XZ6Jr1b9EJp4jWQQ==
X-Received: by 2002:a05:6a21:918a:b0:3cc:841d:bb26 with SMTP id adf61e73a8af0-3cd301379e2mr8404054637.15.1787298471840;
        Fri, 21 Aug 2026 00:47:51 -0700 (PDT)
Received: from [10.201.216.236] ([114.8.222.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm24180253eec.25.2026.08.21.00.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:47:51 -0700 (PDT)
From: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
Date: Fri, 21 Aug 2026 14:47:13 +0700
Subject: [PATCH 1/2] wifi: nl80211: add sta-info nested attribute
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-work-v1-1-6a4ca4a92ee6@gmail.com>
References: <20260821-work-v1-0-6a4ca4a92ee6@gmail.com>
In-Reply-To: <20260821-work-v1-0-6a4ca4a92ee6@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787298463; l=8793;
 i=hilalrahmatullah11@gmail.com; s=20260821; h=from:subject:message-id;
 bh=cD7umswusIn5QlB0XA5e9jYsyTJqh0u7+AqhPL63lOY=;
 b=DheTvzii8kANQKm0RoGKek4t4q8CqZ2rJJDylc2tqqmekr2MVpEnjK1xM65lhu8qT7j0xW7Wl
 h8VU1mp3MRuBXshTojWtJeYYUQM3xvWLzk9wgg+wrvuE9k+ZfjpBbxZ
X-Developer-Key: i=hilalrahmatullah11@gmail.com; a=ed25519;
 pk=FhZxP6t1UkIekCkbKSGBN5a03xhQyE9h3bzSUhWYo3w=

Add NL80211_ATTR_STA_INFO nested attribute definition, along with
its related attributes and enum.

Signed-off-by: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
---
 Documentation/netlink/specs/nl80211.yaml | 368 ++++++++++++++++++++++++++++++-
 1 file changed, 367 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 802097128bda..cc5ef34f8dec 100644
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
@@ -1631,6 +1807,172 @@ attribute-sets:
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
+        type: indexed-array
+        sub-type: u8
+      -
+        name: chain-signal-avg
+        type: indexed-array
+        sub-type: u8
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
@@ -1672,6 +2014,30 @@ attribute-sets:
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

