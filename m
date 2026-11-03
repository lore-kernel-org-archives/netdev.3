Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730821;
	b=Xb3uWJX4bBT8dbgOXfK2auntUZA3S+8050prww350GT53BvzmaClKQ8lcs6A9mR0d9qj
	 2y/XQYhObfYuiy1beIbtdRK+fqAGoko7H2li7OcPAOI8ZfOXtKJ2akwy4YVVUg9DmF+TW
	 sxZNkFAdz68a/J3+Lvw/qryrXQcW/OzWrhGg/k4XjqpUTU2Hkp0qRo7ZSrYBZz/Vfjn4X
	 fZkf/Y3eEt1pe3V7gubEAPPyFQnnqdzrFpohu8RqcfE3dp3eID18ReTge+pHw0ft4O7lC
	 vffrV6T7dcbKBLCZJnEOQpcavuGxbljk94bAozSo7uebc9i0DD3sNRys5BZllbvqZXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=deCUmomb53WAE18wkw9/aqLCnkJ8waH6qvWSys2hmGU=;
	b=lUBYHGoo9MpBvS0yNac5VRRhkOGgRZYsX3gMD5Jd6+t/GzApQw4vS1cWT3jWGUxnCjS9
	 bl1DmNWSmwQlb0RzYTCowdTK15aoAiLxrpqaORDyz93Fgsu+SsE4VPY/gNKAUxAy88Iwi
	 N7pOzqGSL//sKi7tozbLfIpt64xXX7bZJWiVMulEyiu1iYFexioVnnQnZyrIUr8BpOKk3
	 ZgWRdjOPy40BjJdBItOOP47LzKrB3eVw0Oc3lle6KuXTwgW1EwCy42vJK6pf2WVGgMdQY
	 ostKjhjfF6A5DUtQAUL+tik55CYCCkHWCi9MVEqezSDxRQBAJZ7nNIXV6PCLpd1Twbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGQ1srqZ;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B301606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B301606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGQ1srqZ
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93cb9e9405fso235311085a.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730819; x=1794335619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=deCUmomb53WAE18wkw9/aqLCnkJ8waH6qvWSys2hmGU=;
        b=aGQ1srqZ7O5av2G/ajuN8h4tP79BcVgvh4jkFvekSlG6AzXDIZbPxBc4R7nkR77JYm
         ct6H4qnu5aNnNDTOMfwPM908mlgaHdSORC/rXOiKlVCLk4q6eLX7wsWoQMmyd16s0ikM
         rAS00MEiSVnUW5P4mi7pob8alXy1HIT3jqggUM4wZz38MWJDkplC/iGrgkt691yjwnMA
         aLasRKwv7PdKTdVMImiw53hlXuVZ18XIkD3Y8vUWBAPxTy0CruddXWzXCq1tNzubHfDx
         VGW9/H2yymXuqyiIZ847wnfjx9XFnHc3P3oKT+/3ItR5O05qla+mx/Yx/RagOlKBsbJP
         XSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730819; x=1794335619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=deCUmomb53WAE18wkw9/aqLCnkJ8waH6qvWSys2hmGU=;
        b=B0ho5v5EFkj+6xXkNnbSiUlIob56oVpPlhKu7n2cGGBD2YBqMJ4GdNl1dk5eCLYjLt
         M1GZNOUc4dul0304rCppjXP3TzInDr1TPlQKJubUHB6rxxbRNFGsDSQfDtKW3v3Pn61p
         9xWkg+62TIpu2zGvBdh+sVwAvmtMPJF6SF+xeetuiIjaaF6QfocfpQ75D2Ac1cwvhZwo
         5U4uZ8clhdEMnwtS0MnMZyYPmVr3qKlAlEglIe7vh/BEpnBgeFuApqT/WHLp23w08wBf
         jb9AxRIVzuFchMFjrU82NqxiF73HVPhrjDjjHffXuBICShtB23I/PqhWoS0dDa7RBwc8
         KNMQ==
X-Gm-Message-State: APuU4Z9z40svmdxVI2ks5Tffhvy9VENvxs96ItM+RM68afsqvdI4bXVm
	rci2hF/TPLgwgoM9xXfyFktE8RZCr2GtxcOwcl5jOekSxDQDlz5ndmyykBW0AIU/
X-Gm-Gg: AYBFou0h7jbnL9G2pVruDnmZjyCh7jNjo0G7FxkoeZOVxrJY+UETWskcxuLNb5MhXac
	+GXTBbuL0SRbSY8CR31MjLyyXPewI1ogRzS7N5g2PeL5QmraToGAEE54hDtwHjMP52+oqC0h0/e
	45wpzh6+NsTxx4I6qNIVsTO1NcHWuatlzHviYsedImbdXDVzAtv8R1HyS+CXvGZllyQPUDtl73Y
	IJBCDxDyoZ6DyExwG4Cii8r931ZcDpTOV/tQTOYFeIXrvxDV+b/9Fm5B/tSBLn/FD0CNlnoLt6R
	sZI4lsVJWYb2s2r7zhRF10UVXyDhhpejoHoK6ucUvTdhMxFTaLfJuXe9wCQO8q5tKP/2rAlPa8t
	CEm+7sflYuUV4EZ9Lxjhd/hn2ASUmuyhQRUlUN31hi7npMeta+Lr5dQBUe2NSdZSGQjVDJYFzB+
	c4fT/1DguatxABaSh/Ko4WhWURw74enbc7BTQvjSDy6oxWylblQlo7/WLmT1SSbs4jnakZgtZZD
	MAWmDBOrZ3dzoSs+WuJLY/X4ia0EPng962t4qm2vr7I9uMUv1k3+UDreKcwbDjxIKfF8+nUpJzm
	u81Rvu+ReE6vMnRH5mEnB+g4
X-Received: by 2002:a05:620a:2989:b0:93f:5e6d:880f with SMTP id af79cd13be357-944217a1992mr2455156385a.74.1793730819424;
        Tue, 03 Nov 2026 10:33:39 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468fbe9sm1912585a.3.2026.11.03.10.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:33:39 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Tue,  3 Nov 2026 13:33:19 -0500
Message-ID: <20261103183319.2730567-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103183319.2730567-1-houminxi@gmail.com>
References: <20261103183319.2730567-1-houminxi@gmail.com>
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

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 27 ++++++++++++++++++-
 Documentation/netlink/specs/ovs_vport.yaml    | 22 +++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index f7b3671991e6..8a8adf3820e6 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -135,24 +135,49 @@ operations:
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
+        features. per-cpu-pids takes effect only when the same request
+        sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU in user-features.
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
index fa975f8821b6..e3971bbab4c5 100644
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
@@ -165,6 +167,26 @@ operations:
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

