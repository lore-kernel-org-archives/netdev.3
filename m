Received: from mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F346AED3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447893; cv=none; b=V5SwS3NEUBAHAilI/yZHW9S7oqkyxbdje8NJjKcrVliA6L0LS5fLlGS7c5s8VdIFaDl5bhnw/Tf2GSerVGsALr1ED1XVC0d8+wSmbi4Ej/9TVC2kyeprL0Sio7VyHfUtQz4EvjAhg4hthhesLQfcwV0jP676gCtALYPEPPZA75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447893; c=relaxed/simple;
	bh=EbHs7K1T+/vilbmfudzzAC+MPoJtTsQqpujfi+eh+ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NotaVXbbT2tA04Prk/eVvw7yZU2WIInlv/kW0in6VwmiLxQlTdaU2BuId0fZR0MoJc3DvCLkDXwdh5fD83khVtRg1y8/Tig6/I1NZN7BVmBk0rujrR5L5M1opkPzE5NYf+p/RwXLIXX92WafIryQ9QFs8B5XGo//DZ4iI29JNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rsGc/RPe; arc=none smtp.client-ip=95.215.58.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rsGc/RPe"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EbHs7K1T+/vilbmfudzzAC+MPoJtTsQqpujfi+eh+ck=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791447890; v=1; x=1792052690;
 b=rsGc/RPeDXbaAAQ6dezRbgzoyo9oDIFrKLCBdoWzNLzEfOi9rMNJ7FhB1naaWnWTmaZPcuLC
 bEzjBHfX0Cn5DTov8mFcNrWNqN7gPJbEmLSWI44mHUT+gX3CgfRVyBysuoj5my2Zt6F4NR6RmXh
 IOxYuSnmaH/80RaymKLidZJQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 5a9963d51d860ade;
	Thu, 08 Oct 2026 08:24:50 +0000
X-Mizu-Trace-ID: 5a9963d51d860ade
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 08 Oct 2026 16:24:06 +0800
Subject: [PATCH net-next v4 6/6] netlink: specs: rt-route: describe
 seg6-local attrs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ynl_rt_encap-v4-6-4ed2ccf7f949@kylinos.cn>
References: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
In-Reply-To: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Add SEG6 local actions enums, seg6-local-flv-ops flags.

Replace binary bpf/counters/flavors in seg6-local with
nested seg6-local-bpf, seg6-local-cnt and seg6-local-flv.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 93 ++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 82e59af56ecd..48d1659f20f3 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -116,6 +116,45 @@ definitions:
       - rpl
       - ioam6
       - xfrm
+  -
+    name: seg6-local-actions
+    type: enum
+    name-prefix: seg6-local-action-
+    enum-name:
+    entries:
+      - unspec
+      - end
+      - end-x
+      - end-t
+      - end-dx2
+      - end-dx6
+      - end-dx4
+      - end-dt6
+      - end-dt4
+      - end-b6
+      - end-b6-encap
+      - end-bm
+      - end-s
+      - end-as
+      - end-am
+      - end-bpf
+      - end-dt46
+  -
+    name: seg6-local-flv-ops
+    type: enum
+    name-prefix: seg6-local-flv-op-
+    enum-name:
+    entries:
+      -
+        name: unspec
+      -
+        name: psp
+      -
+        name: usp
+      -
+        name: usd
+      -
+        name: next-csid
 
 sub-messages:
   -
@@ -490,6 +529,7 @@ attribute-sets:
       -
         name: action
         type: u32
+        enum: seg6-local-actions
       -
         name: srh
         type: binary
@@ -513,16 +553,19 @@ attribute-sets:
         type: u32
       -
         name: bpf
-        type: binary
+        type: nest
+        nested-attributes: seg6-local-bpf
       -
         name: vrftable
         type: u32
       -
         name: counters
-        type: binary
+        type: nest
+        nested-attributes: seg6-local-cnt
       -
         name: flavors
-        type: binary
+        type: nest
+        nested-attributes: seg6-local-flv
   -
     name: rpl-iptunnel
     name-prefix: rpl-iptunnel-
@@ -618,6 +661,50 @@ attribute-sets:
         type: string
         checks:
           max-len: 256
+  -
+    name: seg6-local-bpf
+    name-prefix: seg6-local-bpf-
+    attr-max-name: seg6-local-bpf-prog-max
+    attributes:
+      -
+        name: prog
+        type: u32
+      -
+        name: prog-name
+        type: string
+        checks:
+          max-len: 256
+  -
+    name: seg6-local-cnt
+    name-prefix: seg6-local-cnt-
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: packets
+        type: u64
+      -
+        name: bytes
+        type: u64
+      -
+        name: errors
+        type: u64
+  -
+    name: seg6-local-flv
+    name-prefix: seg6-local-flv-
+    attributes:
+      -
+        name: operation
+        type: u32
+        enum: seg6-local-flv-ops
+        enum-as-flags: true
+      -
+        name: lcblock-bits
+        type: u8
+      -
+        name: lcnode-fn-bits
+        type: u8
 
 operations:
   enum-model: directional

-- 
2.55.0

