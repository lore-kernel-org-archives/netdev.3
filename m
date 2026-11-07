Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053235;
	b=rebEZrNqLGcD6/5SkTtuitinAzR62BYf8Uv8GNbr2RVISW1PN3RZTpSbWZswqWa73c/L
	 rfVYId/duq3i6g+hchTMmsRQ3jLSW1pympEeO2du2MZxMtOPBhH704shV66Brk4sq3Uti
	 5YSWAz/VmLLmYMBmgN1HiicQpYILoclZB78VSNxohw4Wpg3uc9WP92c++9I3LPe9Fkriq
	 nXe5Xfv740a1Ef4NSLYD3b94tRe9whhRwtMxxOOuxfLAU3EyVzDh5jZZ4pI+G6h9Y3OVN
	 2V/WjDjclAALIe4JRLxpqbVhaRPSN29S3IBx9mL4iQijW2YkENM+qacyDYyeTHV+gmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hzFXEXNSyVdO8nmplWkGl/yE85KGTTppFIXownWFxls=;
	b=wGUCeKZk7xdn4aLztXRgjnJjuz7WGjfsjwhgIGIgfFc6lRAfm/DloPMWXjqamUUcg/lF
	 wLd4ztT8Q1EvEKEkOKxxt4blKdmYktpnqIrVqmPKZ0F9a/sMOfGPLdRyuULsVPgSySqXe
	 bUYwIuiE3pjfdWc73u0PQcn9TNleUcFEiyC2qTRbcLkLEUQXPpHwMjVSedH8hG0z6DLDa
	 KcgPdNjdFN7Y6jFcfEfdV8nhURL8IglDYWT005iA191EqThPpefuM+zrg1XJJisGDAOxs
	 CYhsIelm2roSrpUKHdbg33aXxrEFBYtCXU62B1Hu6fYcjldfFT1p2esyn9qXqDpIFYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVPlriDL;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84021606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84021606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVPlriDL
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b2d14968c9so13795847b3.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053234; x=1794658034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzFXEXNSyVdO8nmplWkGl/yE85KGTTppFIXownWFxls=;
        b=PVPlriDLaeCCOivJpcsFsuxCReGYaxcmODnO1mkUgeswngBgGn3hStmNcjSM+9GoAS
         qSnPllP+WyCpvPwtOoaQ/2tCsDg1uF5sUUN4g4po602v4wHn/Ukp0iXc/ne289xs7eQA
         feah+8lnlySy615rXieglKY2LiVsNEyvhBNRlxscIiKxF64O1ZljYAHYaHDIuje8fxvD
         u57eJJZQncMEL30Vd10NfUyBjcRnzFyveNVVXarOjNuz/zIV6GzmWdDXRYLhhR2mSMub
         H37MQGgvVvvkf9n9qnCmB6CzWu1CMUvLQropNDl2AIRFoOk+uH9yJl5EvIOA3RCLhP4K
         pQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053234; x=1794658034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzFXEXNSyVdO8nmplWkGl/yE85KGTTppFIXownWFxls=;
        b=ZgSyj2BjExlugRZVo3QN8nnWyaCgRTE4fCOxIjiT8x73l+zCM/FMp1Tt57ZKwrRfGF
         nKg65AHpkuc5lsoaep0nOFrcIvLiifkAQ5nMHSHriXE20DJAE6KfdIAOdQ2hveL1k4R9
         uxwQbmvZvSLct+2jP2B8t6l5P8Po4ahYzy2IVsi7R/wraqBtD5JjQoHQC3NIgf5fiAz7
         rqkJbsUEI7ui4DPH6xccHJHk/65fTnwtmWeTrVYa802e4xnaSqj67vDUkzHCdmm2K/0a
         vhfNNe/RBQEsXL3vtNYhF+/3EFwmL3WA69lOLba8THM/Q+WqtjPt0a5mwktLpQWRzHOF
         hl2Q==
X-Gm-Message-State: APuU4Z/h567b2mdMArdRC+drnYvzwyzTToBadIxetfJYaueQaVuv5kOs
	c0p0InokPOJMwnU30BFYffVnqAXAEerhcYWcD216rjvBDpkDHQxovHZjqA9KFxZ5
X-Gm-Gg: AYBFou2KaDKfJczlDEvDc+TU0auaKhYVCHyCPbpCE2ySEn9TeV1hTVyTlTLTQpWeCyK
	rYHSZvkPGIkFTkv0NgvvRLULnJs5i7AeLB7KV5LtGNMMNyWEhRUpySf/PLZ7cILLB/+n8l+yQGE
	DXEwAheceXA5aASouW3dwhhN6kpVrlqKEHPCKeCiQ5HrmDq+c+T3A289R7LUi1KOafGq/E7+cc1
	q3vL0rB4xS/AIm1W09RdZt4bhYFcRRSHObirN8721OTP5j4AJff0GLh9NQ4xImaOnH4Gr+Y2fiU
	VkkiSoSWXVR7bJQyEdsSQeD0eTXkzOdw2LHHedv3+LyC3FMmAG9FUhappYvz3luZojH0ubvgkut
	NfH3ghAVrPFTgGrelavdo7vAQrxtPodFpTFUUsjfjRkFXFaiys14hQCxySe8EFraLo1kSzp9fIv
	ImiKxYwvLL3DUbjvgD6mB5i7Sk7N0ud6pCxH7ldoqr21bTKWfcLkOlMlUlvp7fzEClvzDvkPzjM
	peABb5HHosWqeSs83d7iDgMTE0PFTBEkvIIrRYhuLM1J7DREjTqiZausQ+iU1uoY6ezj6sCDvI7
	g84aLq4hE+nEp707VO75hu2b
X-Received: by 2002:a05:690c:6a04:b0:8b1:8aba:afe5 with SMTP id 00721157ae682-8b34197511fmr26248167b3.28.1794053234368;
        Sat, 07 Nov 2026 04:07:14 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f77055bsm39518927b3.8.2026.11.07.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:07:13 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next v6 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Sat,  7 Nov 2026 07:06:47 -0500
Message-ID: <20261107120647.874906-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107120647.874906-1-houminxi@gmail.com>
References: <20261107120647.874906-1-houminxi@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both families register a SET command that the spec never described, so a
YNL client could not change an existing datapath or vport. The datapath
NEW command also gains the masks cache size, the per-cpu upcall pids and
the ifindex, which its handler reads. new, del and set take
CAP_NET_ADMIN, which is GENL_UNS_ADMIN_PERM in the kernel.

The datapath SET command changes the user features, the masks cache size
and the per-cpu upcall pids. A request that leaves out user-features is
read as zero, which clears the features set earlier. per-cpu-pids takes
effect only when the same request sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU
in user-features; without that bit the pids are dropped and the request
still succeeds. The new operation reads per-cpu-pids the same way, so its
doc says so too.

The vport SET command changes the upcall pid. It finds the vport by name
or by port number, and rejects an ifindex with -EOPNOTSUPP before it
looks at the type or the options. A type that differs from the vport's
type is rejected with -EINVAL, and options with -EOPNOTSUPP.

The ifindex attribute is signed in both policies, which read it with
nla_get_s32_default() and reject anything below zero, so declare it as
s32 with a minimum of 0 rather than u32. A generated client would
otherwise offer a setter for values the kernel rejects with -ERANGE.

The ops in both families skip strict and dump validation in the kernel,
so the spec says so for get, new, del and set.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 35 +++++++++++++++++--
 Documentation/netlink/specs/ovs_vport.yaml    | 30 +++++++++++++++-
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index f7b3671991e6..4a64985633c4 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -108,7 +108,9 @@ attribute-sets:
         sub-type: u32
       -
         name: ifindex
-        type: u32
+        type: s32
+        checks:
+          min: 0
 
 operations:
   fixed-header: ovs-header
@@ -119,6 +121,7 @@ operations:
       doc: Get / dump OVS data path configuration and state
       value: 3
       attribute-set: datapath
+      dont-validate: [strict, dump]
       do: &dp-get-op
         request:
           attributes:
@@ -135,24 +138,52 @@ operations:
       dump: *dp-get-op
     -
       name: new
-      doc: Create new OVS data path
+      doc: |
+        Create new OVS data path. per-cpu-pids takes effect only when
+        user-features in the same request sets
+        OVS_DP_F_DISPATCH_UPCALL_PER_CPU.
       value: 1
       attribute-set: datapath
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
             - name
             - upcall-pid
             - user-features
+            - masks-cache-size
+            - per-cpu-pids
+            - ifindex
     -
       name: del
       doc: Delete existing OVS data path
       value: 2
       attribute-set: datapath
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - name
+    -
+      name: set
+      doc: |
+        Modify an existing OVS data path. The kernel treats a missing
+        user-features attribute as zero and clears the previously set
+        features. per-cpu-pids takes effect only when the same request
+        sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU in user-features.
+      value: 4
+      attribute-set: datapath
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
             - name
+            - user-features
+            - masks-cache-size
+            - per-cpu-pids
 
 mcast-groups:
   list:
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index fa975f8821b6..16b21c42cac8 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -111,7 +111,9 @@ attribute-sets:
         type: unused
       -
         name: ifindex
-        type: u32
+        type: s32
+        checks:
+          min: 0
       -
         name: netnsid
         type: u32
@@ -128,6 +130,8 @@ operations:
       name: new
       doc: Create a new OVS vport
       attribute-set: vport
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -140,6 +144,8 @@ operations:
       name: del
       doc: Delete existing OVS vport from a data path
       attribute-set: vport
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -150,6 +156,7 @@ operations:
       name: get
       doc: Get / dump OVS vport configuration and state
       attribute-set: vport
+      dont-validate: [strict, dump]
       do: &vport-get-op
         request:
           attributes:
@@ -165,6 +172,27 @@ operations:
             - netnsid
             - upcall-stats
       dump: *vport-get-op
+    -
+      name: set
+      doc: |
+        Modify an existing OVS vport. The vport is picked by name or by
+        port number. The kernel rejects an ifindex with -EOPNOTSUPP, before
+        it looks at the type or the options. It rejects a type that differs
+        from the vport's type with -EINVAL, and rejects options with
+        -EOPNOTSUPP. The only attribute that changes state is upcall-pid.
+      value: 4
+      attribute-set: vport
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - name
+            - type
+            - options
+            - upcall-pid
+            - port-no
+            - ifindex
 
 mcast-groups:
   list:
-- 
2.56.0

