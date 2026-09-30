Received: from mta1.migadu.com (out-12.mta1.migadu.com [95.215.58.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A536921E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733086; cv=none; b=YEa1KHApesq+qmPXzwfJ+41WkvXA9xbS0QhZ6862nJbUX9pozFQd5XmYP1lOXEGka5ZHbgTBuYMJtsQ8Qg9fFHIfoOPB24g+NTMH9spvujKoE/eRlLjzRjm60E9OqVpZuMt5NRy7ebyuMzLOKijSPmouXYEVjYjZliZz1z5e+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733086; c=relaxed/simple;
	bh=XMBS+DNCowhgZpLJz3pLvPjdTByB7h9W1vtPFwUXlw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSVYA9X1q9m8Ym68xXfg9WRFax3LTTzQT5ahsHaErmgpr3TPBx1CKeqfDsucwRY9mQCFB4RXs8DWnE6MhKZzXP7nRyV9iynQtSlJtVc/Egz1hqEohKu69kYkbTiqk74Dl072mM+8Oc+j16LJl+QDoNBkKlqOe5fJs2BY+4PKMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cFMSG8lM; arc=none smtp.client-ip=95.215.58.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cFMSG8lM"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XMBS+DNCowhgZpLJz3pLvPjdTByB7h9W1vtPFwUXlw4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790733082; v=1; x=1791337882;
 b=cFMSG8lMRqNEqcjUvYv7Z+NVYAL6pbcSFukMNbVmXnjpmaGfBnJonnZ9+06AGOLdPKaReuO7
 3yyxwS8L5dNpGJ8mb9fIBt0QzYBabZz+ZQ39+0/P+53ORRxa/QsNkBkju5961Tax9fSs4xSUz8m
 w0hlK2n6Tcz6tte46GNA/h9M=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 796bb52390115919;
	Wed, 30 Sep 2026 01:51:22 +0000
X-Mizu-Trace-ID: 796bb52390115919
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 30 Sep 2026 09:50:56 +0800
Subject: [PATCH net-next v3 5/6] netlink: specs: rt-route: describe lwt BPF
 program options
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ynl_rt_encap-v3-5-4106c21b9ee7@kylinos.cn>
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

Replace binary BPF attributes with a nested lwt-bpf-prog to support
lwt bpf prog options.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 7649797602eb..afec0375661f 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -469,13 +469,16 @@ attribute-sets:
     attributes:
       -
         name: in
-        type: binary  # bpf prog
+        type: nest
+        nested-attributes: lwt-bpf-prog
       -
         name: out
-        type: binary
+        type: nest
+        nested-attributes: lwt-bpf-prog
       -
         name: xmit
-        type: binary
+        type: nest
+        nested-attributes: lwt-bpf-prog
       -
         name: xmit-headroom
         type: u32
@@ -621,6 +624,16 @@ attribute-sets:
       -
         name: hwid
         type: u8
+  -
+    name: lwt-bpf-prog
+    name-prefix: lwt-bpf-prog-
+    attributes:
+      -
+        name: fd
+        type: u32
+      -
+        name: name
+        type: string
 
 operations:
   enum-model: directional

-- 
2.55.0

