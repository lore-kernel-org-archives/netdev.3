Received: from mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB633672B8
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733083; cv=none; b=Ed+607Sm/hwt/R8NMKgFrX3wTQQR/63qXP9ZUsWHM7TlvJXuOz+UpNzFwawiXakEXpKlWvvxwPOY7h0hfpAT4QuLhCuNu/wPAWk2k3i+sytxmxf3kLbmlUU/NXDg35E6Ekm9GOjdLin4AddqcWpOj3cranFjkxD3ZQgxZqZIDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733083; c=relaxed/simple;
	bh=+154pZCXiur55XN+2yuwLsLc+nMNBRa9e80C6ZT4+Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrpOY8jL5q9tcdtLsTdE5wQtnWoT+x09I8WDvgyC0mnR7eXFaMmkMx8tCEbaX74Cv4i+LEfoae5l2pDsADjzm705qJeXEfvyAcKmiQ+c4FD6G+NKvEH56GhGMyeecfhP4SLytU1LDEUaGCaIc0Z8eLIIKy3cvWNTls0clEZ63nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dkaDtBW9; arc=none smtp.client-ip=95.215.58.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dkaDtBW9"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+154pZCXiur55XN+2yuwLsLc+nMNBRa9e80C6ZT4+Fs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790733079; v=1; x=1791337879;
 b=dkaDtBW9Ro5d0hkuOX1yTVeu/WgVOUEH319zw8IWIrwTVhaCbBm4334Ht9Kp5xfTmo6tPPq8
 LyBpXGXfowABgygcQ4k5buAGjfm+muHdHnFJvIT/6a6rcsTlLstcPoTtQ/rucwVwUJrBZfL4Bro
 jyZdUB8SwzJKE8iYjLkQlubE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4bda53642577bff4;
	Wed, 30 Sep 2026 01:51:19 +0000
X-Mizu-Trace-ID: 4bda53642577bff4
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 30 Sep 2026 09:50:55 +0800
Subject: [PATCH net-next v3 4/6] netlink: specs: rt-route: describe
 lwtunnel IP options
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ynl_rt_encap-v3-4-4106c21b9ee7@kylinos.cn>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
In-Reply-To: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Replace binary opts in lwtunnel-ip and lwtunnel-ip6 with a nested
lwtunnel-ip-opts set. Add attribute sets for geneve, vxlan, and erspan
IP options to match linux/lwtunnel.h.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 63 ++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index dc842a786794..7649797602eb 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -377,7 +377,8 @@ attribute-sets:
         type: pad
       -
         name: opts
-        type: binary  # lwtunnel ip nest options
+        type: nest
+        nested-attributes: lwtunnel-ip-opts
   -
     name: ila-attrs
     name-prefix: ila-attr-
@@ -444,7 +445,8 @@ attribute-sets:
         type: pad
       -
         name: opts
-        type: binary  # lwtunnel ip nest options
+        type: nest
+        nested-attributes: lwtunnel-ip-opts
   -
     name: seg6-iptunnel
     name-prefix: seg6-iptunnel-
@@ -562,6 +564,63 @@ attribute-sets:
       -
         name: link
         type: u32
+  -
+    name: lwtunnel-ip-opts
+    name-prefix: lwtunnel-ip-opts-
+    attributes:
+      -
+        name: geneve
+        type: nest
+        nested-attributes: lwtunnel-ip-opt-geneve
+        multi-attr: true
+      -
+        name: vxlan
+        type: nest
+        nested-attributes: lwtunnel-ip-opt-vxlan
+      -
+        name: erspan
+        type: nest
+        nested-attributes: lwtunnel-ip-opt-erspan
+  -
+    name: lwtunnel-ip-opt-geneve
+    name-prefix: lwtunnel-ip-opt-geneve-
+    attributes:
+      -
+        name: class
+        type: u16
+        byte-order: big-endian
+      -
+        name: type
+        type: u8
+      -
+        name: data
+        type: binary
+        checks:
+          max-len: 127
+  -
+    name: lwtunnel-ip-opt-vxlan
+    name-prefix: lwtunnel-ip-opt-vxlan-
+    attributes:
+      -
+        name: gbp
+        type: u32
+  -
+    name: lwtunnel-ip-opt-erspan
+    name-prefix: lwtunnel-ip-opt-erspan-
+    attributes:
+      -
+        name: ver
+        type: u8
+      -
+        name: index
+        type: u32
+        byte-order: big-endian
+      -
+        name: dir
+        type: u8
+      -
+        name: hwid
+        type: u8
 
 operations:
   enum-model: directional

-- 
2.55.0

