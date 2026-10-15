Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31202F39B5
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792032112; cv=none; b=qNXnu2UGBVvN8lVSbLm53bl/ZhadIilOaePlsakOSu9TPvXBxGGGRx9K3a4sR9BpHIW2hIY70tmHkl6r5ogYGzBbSv5puyJT3+QdIOt5Y3jCkCxm2oj1ikErjfcspKwTygJ83T7GeZuIGlLJatnIh+ESyZAydxBvsnxctB+is4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792032112; c=relaxed/simple;
	bh=CUZyje4n78m4jdXPd4SAa+g8xkwZKgDYJT/HhjzS9/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWaQYgLW81DqiUXLgmyO8VDmxr+kI+s2quSKSY8Dh9upZncKVy6BBLxI92M2VnOnW5F6StrWvgCjI9eMSVP8QvYKV5hIyYVk5Eejl5AmhPNUgf4jV1Oib9+LZauU2Da1fa5vhO2ZwnLQcDKd6FY0uoQZPNu4qoVud4eH9HM1PvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih7Cs7d+; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih7Cs7d+"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82503732024so2441180a34.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792032109; x=1792636909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EOKISdkeff5znYeTft3P6Dn+hHPoZACNR8vzTbmw6w8=;
        b=ih7Cs7d+PjPw+KDXQTWQigJ0m4OHHCxffZBGKSlYRBXzzXes/aCgynbnB04ZcgQFC8
         hrxHyRP+1sTN28vD/x174Seru/UjfHsutHGHfQ/HCJKcemAwGebQXwc+aaTf+MuWQCe6
         k90WvciY4BiQJyMK93jUJVBxmzua+ZH3Xjzt0HLHqlcep2XNeyLfyQ722ZoaN3+4RgPm
         rY/EceRvKUpxRJly/B6xwWs8BoUYgLfNmKaHdYUJeb7FrE9fvWN/l6xva/CtR6of9yjS
         /sNEbT5woreTLdSbCM/bRFWDJLCQzJ2E4n5AvXVbv8colk7lKRYr/N3GUnsTLiSwRfVt
         qVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792032109; x=1792636909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EOKISdkeff5znYeTft3P6Dn+hHPoZACNR8vzTbmw6w8=;
        b=sZoQQCZ14baye6A7JDbJ3te6IUeF1UM6zYswlejQP5Gs+k/l/Qm4a192JgucbnPjIh
         IS+VLGTFPtWa0o+uZgtTMu8Y1MWdIQnRX5kKa4hdF08ylJoNaqeL3Q1DQgeUJdD8vXIT
         H+eJass2Fk/3Eyq1BjMeLcUbuQK9WqIIlRN0NKQskRA1Q4EvzjMkHCAoELmwu5h3aRI1
         K0aUuefrheZI9JhVhI6loHtIhMhYjlR8iOlomVIOKLdj88cpATsGoYbLaqLfb1k9n2r3
         KIIAkLnBpKyM1LEWIt8dPBciwczlhQGMC7+7OvskSniUbu3haTKxCOLoqnI4xpFcGuQC
         j8DQ==
X-Gm-Message-State: AFq9FYK4PlnN6A2CClC90ii2IQ67Zz6JA1Z3R2XG3Vol3o36bceex9Sn
	AN6QtGMB+k/Q21pYMbIVogjrY6dLGJYBN926o3cOEBSQ+bfZgjWJztwl+LhG6m/P51UUkg==
X-Gm-Gg: AYBFou0+7kduKmRFWKzSvRef6HtRd6dDn8UlAxATg+XXhoRnlPL3yvIkAoR6D82q8ZF
	nXzUjBIv/lldixuIHXUNAH8YRWrpyeiFqdRUfMkMDr9Nlqm5TVFNWsrfILnXhrlNOU+esijukcp
	wyydvW1Lf/4MHinswm15CO4aO/Ur047ohmxceOcclFi2RkkqKtVqeWFBFw8YNfz4Zx6BjNM5VLm
	6j+j/+wg8gMnrYYjAu95f18CduVtbX3b9iHqtIpORKASdckS5brb3yG3PRMPP3nkxYV4d9CA26g
	r+7VzF36QZCGjv7PPM703B2qbkQ6HVODBnOfDP05yxjV51lsbPC7z/7x0k+Zjzy99vaB0gq0Di0
	Be8ONDkzLMtOcRui3Xwr95s5KExScFiMF9YjkQX/2rcx3qq2Ozc1Ovci375diNOQaKUPGSRO2iL
	+akVabT0TK2mivy4qMTHDHCml/rrASPSjO9wSkDLM5X1KU0RgbdsG61fim8hh50xPDCfPSQGH3X
	Tu7
X-Received: by 2002:a05:6830:2e06:b0:7fa:ab72:9e05 with SMTP id 46e09a7af769-830980577damr24300855a34.29.1792032109454;
        Wed, 14 Oct 2026 19:41:49 -0700 (PDT)
Received: from houminxi ([61.170.152.244])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385b9cb0sm16720024a34.4.2026.10.14.19.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:41:49 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next v3 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Wed, 14 Oct 2026 22:41:31 -0400
Message-ID: <20261015024132.698658-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015024132.698658-1-houminxi@gmail.com>
References: <20261015024132.698658-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both families register a SET command that the spec never described, so
a YNL client could not modify an existing datapath or vport. The kernel
handlers take CAP_NET_ADMIN through GENL_UNS_ADMIN_PERM.

In the kernel, the datapath SET command changes the user features, the
masks cache size and the per-cpu upcall pids. The vport SET command
changes the upcall pid. The kernel rejects a type change and rejects
options.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 18 ++++++++++++++++++
 Documentation/netlink/specs/ovs_vport.yaml    | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index f7b3671991e6..9c33d6a2f05d 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -138,6 +138,7 @@ operations:
       doc: Create new OVS data path
       value: 1
       attribute-set: datapath
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -149,10 +150,27 @@ operations:
       doc: Delete existing OVS data path
       value: 2
       attribute-set: datapath
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
             - name
+    -
+      name: set
+      doc: |
+        Modify an existing OVS data path. The kernel treats a missing
+        user-features attribute as zero and clears the previously set
+        features.
+      value: 4
+      attribute-set: datapath
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - name
+            - user-features
+            - masks-cache-size
+            - per-cpu-pids
 
 mcast-groups:
   list:
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index fa975f8821b6..63a0a41a1199 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -128,6 +128,7 @@ operations:
       name: new
       doc: Create a new OVS vport
       attribute-set: vport
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -140,6 +141,7 @@ operations:
       name: del
       doc: Delete existing OVS vport from a data path
       attribute-set: vport
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -165,6 +167,19 @@ operations:
             - netnsid
             - upcall-stats
       dump: *vport-get-op
+    -
+      name: set
+      doc: Modify an existing OVS vport
+      value: 4
+      attribute-set: vport
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - name
+            - type
+            - options
+            - upcall-pid
 
 mcast-groups:
   list:
-- 
2.56.0

