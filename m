Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A1437107
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788170; cv=none; b=GIxNEdOwRc2hNdJQ86iReWZNwNedC58Q0RUdKLzQb54MurMxPEdvlNJwX8qC4iqwAZYe9QogrUaYyHlPGzRwrU1ZJxvuAzt+bHjkiH57pSi+cuQFTbqMv/cjp4iwWBLLb+dWciUfTHv9eu6DUoOKWtGgUVgYDsjkMcYCIykhjFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788170; c=relaxed/simple;
	bh=BhQ1su3GLOvkp9tx55OqQniqMhtS9s4uUiSJ6x8BiH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t02EEk8PnE284CpWZSbfTEyp/v7qxS8Q3xfLifkqsgE+mErKO4ph6L+CGAPAO+nv1Cqk9xeKL6S6QRvaCLlwab+Oop7ku7Xa+UdKUVbqecj4hdt/21zKrI7PEjyzu+oJSQDaCfkFPdqzc7Yv7aGTcjBA26YWIfk03eqBOFmDqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6Syr/CX; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6Syr/CX"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679334baa1fso994705d50.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791788168; x=1792392968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arfHehwnVNWEiP/K3p3WQQQWME7GeLnPd5u890FVddA=;
        b=p6Syr/CXaKWC5HMxSW8gyBE1uYjx15AlrHLYzHC/6YJQaAhIlWpWU20iHmY+lQbHPw
         RWT7Hi5ex+U+A5DSl8To1K0Bbcuc7QM9NfXnMSaLurlEkQhXkDOtlBCmBvDhVodydnbS
         S0YsIQ8A51Kuc1yM1/ZnaDGaJciyr72Lyq5Dl80ttDf4sKuna1YiA83CdGTD2FjBLfXT
         iY5UTnG+1AWY6FGKUaC/3HWQuFiRTA2h1LUuIpc2e2/pe+zHxGJpcgcT+/5T1gtpOqXQ
         agg+Dx1v2tMdKatdrJSs/RwJsWXLI/sqyRtL9Rp3TI4Sh2menAYkFWmWSwLn+OQ6EysU
         Q1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791788168; x=1792392968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=arfHehwnVNWEiP/K3p3WQQQWME7GeLnPd5u890FVddA=;
        b=G+O37aMpGRu+ktDE1DMyR00XjbcZg2EpFcAm7JMAYFqtbPuJGWR2iHzx9U63AhDupB
         95GGY0BOzldUNr1XV0eNoFC5JyPmYX3D32tI6nsndiARkrd+0Nk4G/QeQzs5PF6WblYr
         It9HoOtj587iCjq4hDdXNVHIChV/HKrXD8XHHBboUuRbXxD7AEC3g6QLyqtj1V3a1gqs
         3LMAYLvjYsTSbHHhzG1tjtrRAdRYqxX+Hhd6uRhGkmWdHFcMzKYCl4aLYEzHdpQyYg5o
         jrzV91Uy663z3LoG8yRWnoou/qgb86bPzQddWT71lRwYe0Ge+84DPYbx9rNFg9dJpQQr
         UQ9A==
X-Gm-Message-State: AFq9FYLPgHPRQI64DW+HKRcWTKUuNB/fOREAB4Ng75tmLk3nQLpUp2Yz
	dpHk0csbuRYS4KTELKhfadLE5u3Ax/mMbJHx9M6HG7catDTmAr2e4kemuZ3esJvhpjAbgA==
X-Gm-Gg: AYBFou0AXztkDlzLOv0elqYRwrWw2AWVlnCHmylDsXrn3iEwUvNMNM4dOOUjCaIql0M
	GpMQyg7IIuRVCcJBWK4Z+RXVEUHW4cDDnGPCT0/965r3qGKjZHplvU2FdB/Wrza8ZGlXKGrolEu
	+YjiAUqC8XzigwhGowB4NQbr8qqJiXQ8f1KBUy8O+qzpnuHKU3Ptw55otEL4B3K8eil0D3Sfkmw
	tWQWr9JiIAYkNqbxqcDm+OICFf019DBXSqgdEucir/Ixat4syh6krr7ZjS93cXDQUqHVz9vfV7B
	TGjdA/Hr5+szjZGxdfikvOADUqKk5oULstLPIlz8QhXie4B5mmTQPWv/t/zrKS7hhj9kL4xEksI
	ljIAGnfy7G+RMx6wqHVNNQiQqFBZicqPDlJq7ZojLpme/1b6FJwHD3OI7GPwrGdzFwq97vMedz5
	F5KtPZGvx+I9o4FipmLynpjuj4wPrS/dSwIaOC0tyix9rFDp45u9bPq+DB16igZfWh
X-Received: by 2002:a05:690e:4186:b0:668:9230:e266 with SMTP id 956f58d0204a3-6793628261amr2312732d50.46.1791788168531;
        Sun, 11 Oct 2026 23:56:08 -0700 (PDT)
Received: from houminxi ([61.170.159.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f25ae62sm32256867b3.43.2026.10.11.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:56:08 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next v2 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Mon, 12 Oct 2026 02:55:52 -0400
Message-ID: <20261012065552.2426415-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012065552.2426415-1-houminxi@gmail.com>
References: <20261012065552.2426415-1-houminxi@gmail.com>
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

Datapath set changes user features, the masks cache size and the
per-cpu upcall pids. Vport set changes the upcall pid; the kernel
rejects a type change and rejects options.

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
2.55.0

