Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85603399364
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483057; cv=none; b=Zj7Qa/ea7mT8btbqZ2ZGxY2TswODve9IQm/W7vKgNHTKdNNBGTg4SNsXrXfgPu+J5IeaC3bwxi0goHugBHT9rMvnt2uQzan/8xlyimZdrrdmIypKHdwcPm17N/LWiKUqburzISw9IyGPK75y47Fg6m6RXxi/jykLF/iu7n8M/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483057; c=relaxed/simple;
	bh=GdwEpgAXRzdLPGLowuS38MRQbJCymEeH0/+Qr91J4hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYShaLG7s128ISDIFjXEoVYbzH0w5BOO4S0tFjmsVsjnnyeBlK+n2xJFzhSU8+Fjlhu80s6DMx0L3RMZmXPW5HaPp7C7mkADIumhXh/cY7A66QsaM9I7OmAitZUVZJ8BCuWc4GPx8IMaNRY7u/3nDqmlxtptTNVlIYf6vXHFfk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzWVL+Sd; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzWVL+Sd"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-34bb8b31647so8655767eec.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483056; x=1792087856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvGXiPiHpimUTJd3v9MQIw2AZILZ1+jCLyBE+b25BWk=;
        b=jzWVL+Sdcxv2GKk5A1fOJ4PRmfjCe+ee3dyhxFyjn7dK1nmHsB5rRMJrPDS3g2nHZ4
         yGaQWuNEoajNQGCxt+kIah3r+yqRh+5g6YkptL1vc7P0DMR6dtaJpifzKTQeRp9dXX3N
         clZYY63l7EAKw56qGyEgyUsc5I4chkVXa+5BLTJMaj/G0S/amOkkK5fCAw/wR7HwwsKm
         GDtRpGaFn3pvnXkE8qXXRH2HzSd2MGgOT/kS60Md3Q164zanSXYCC2MDq4AZM1sqMSZI
         NWRncidGFRN0oHKBDLb+lM/7A7btJhkjs1lbWPo69VCwjY2pJOAOmDGFTrmBzffcVCtH
         07XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483056; x=1792087856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvGXiPiHpimUTJd3v9MQIw2AZILZ1+jCLyBE+b25BWk=;
        b=lTc5O+UHVuUkKmAnxYR+HnDOcWeaHljCgXtvoa6yxdD+z3lpmEHXww+DAXxUN+bsQB
         MXHOoHWw2scZ0/kJsvPdwlFX1Ps+TqA6hw7rPifRWJKX58ow9sw1CmUN1G86fqqAW4Ri
         7RU9M64nlu5evKZQSl/z13bXpLYxrX5cvKuruXQgCLvCyElb9lUBwG0ntLbGH/upG2vY
         yPuMESo9JLZ5iLdsyE6c5qyqL4/LBnBXxOVY5ErB6ES1vg6WZZf4H35f38GkkWXCN27A
         X1jEBRZuGgnWGmryrO4GulRAYpLKiT+VkFPTV7Bgl99yU5Whr1hd7EbBmzE7u+vBiLqK
         /fsw==
X-Forwarded-Encrypted: i=1; AKwUvBzwa6VC+oXJj5zrDTMO+dodH+wcCZfw1xr3RBijEN5xW/9NwJ++Gv9BsRl1nnZ86Q3DKVcdFeU=@vger.kernel.org
X-Gm-Message-State: AFuF++nXGCUOqVZoEX9mcyJcRaQIuyrDCFxWg5u3NM4vixu1mfXmX5BJ
	aWk67+Y7Y+qcIWIJCd4l9GWUQIuj5KgdTmXeWR9ni1ZA1NsLAOs3So/E
X-Gm-Gg: AYBFou2bjwPL0VN6Cn5LINksMvY/u1yCOMLnOfeiGx75zSJcF0gpZfGeSddGK+i5ASd
	uKnsO4CJvt/zvsfoeURl4fTauHpTfYwtVUh3Qu+FXHaWKZsSlt4du4mkSWWiA9+YHb9WQfWvHD8
	ad7EnkxxaqZx3EXzkP2yiB3QWOxL6R9SGcrQTLUj2gyBG2M/5B8zrFg9epXrumX3zvQnC22fcgz
	r9Ej/d9PxYl9j1TVVmxSbB9XVfKOIPJubTnR5X80sHo/efR7dEPAV7qQBthEjW8BAVdeipsRo3M
	yvMoUBRkj72au1iz8nmyW3RGCe8F7fy+6S8xdLEGh9TDbg2s2X2FNwfuZSWwYQLPJ3VxqYKs/1I
	EPsrQJmu7WiVEBev+eRpdApvaXqTSdWewf/RKsGZCJwVawPDwiPFN4m7gd+WWwP0cue1GfyKsWk
	uUFMO21AtuoVqif86pWACXdLzOs72BlhBdHIUfTVDrGIvLtIuP+3dvIg31NscWxLiHzQkxhwBVG
	Q3Q69yvmbCH1X/brs8ykPD0CJvqSYwD+/Z4183uc33tG8lZjiBhjBrQ7zHBNFpkRVNlhQd/VzjD
	ByXwxflOPiYdERJrghpo8TyZhkE0ZMaFPwCZ3puEj6Q=
X-Received: by 2002:a05:7301:678f:b0:351:5af1:f53e with SMTP id 5a478bee46e88-3515df405e2mr11128340eec.29.1791483054914;
        Thu, 08 Oct 2026 11:10:54 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b479e76sm162161eec.26.2026.10.08.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:10:54 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v2 2/3] netlink: specs: add genetlink-legacy spec for GTP
Date: Thu,  8 Oct 2026 18:10:30 +0000
Message-Id: <20261008181031.4129029-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261008181031.4129029-1-anilkaushikwireless@gmail.com>
References: <20261008181031.4129029-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GTP (GPRS Tunnelling Protocol, user plane) generic netlink family
has no YAML specification under Documentation/netlink/specs/, so it
cannot be consumed by the ynl tooling used for user-space clients,
documentation and selftests.

Add a genetlink-legacy spec describing the existing family: the PDP
context management commands (NEWPDP, DELPDP, GETPDP) and the GTP-U echo
request (ECHOREQ), the GTPA_* attribute set, and the "gtp" multicast
group. The spec is derived directly from include/uapi/linux/gtp.h and
the gtp_genl_policy / gtp_genl_ops tables in drivers/net/gtp.c; command
and attribute values match the existing uapi one-to-one.

This only adds the description; there is no kernel code or uapi change.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 Documentation/netlink/specs/gtp.yaml | 170 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 171 insertions(+)
 create mode 100644 Documentation/netlink/specs/gtp.yaml

diff --git a/Documentation/netlink/specs/gtp.yaml b/Documentation/netlink/specs/gtp.yaml
new file mode 100644
index 000000000..7193f5e53
--- /dev/null
+++ b/Documentation/netlink/specs/gtp.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: gtp
+
+protocol: genetlink-legacy
+
+doc: |
+  GPRS Tunnelling Protocol, user plane (GTP-U).
+
+  The gtp netdevice encapsulates and decapsulates user plane packets in
+  GTP-U tunnels (GTPv0 and GTPv1-U, see 3GPP TS 29.060 and TS 29.281).
+  This family manages the PDP contexts that describe the tunnels and
+  triggers GTP-U echo requests. It is driven by user space control planes
+  such as those built on libgtpnl.
+
+kernel-policy: global
+
+attribute-sets:
+  -
+    name: gtp
+    name-prefix: gtpa-
+    attributes:
+      -
+        name: link
+        type: u32
+        doc: ifindex of the gtp netdevice the context is attached to.
+      -
+        name: version
+        type: u32
+        doc: GTP version of the context, 0 for GTPv0 or 1 for GTPv1-U.
+      -
+        name: tid
+        type: u64
+        doc: Tunnel identifier, GTPv0 only.
+      -
+        name: peer-address
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+        doc: |
+          IPv4 address of the remote GSN peer (GGSN or SGSN). Also known
+          as GTPA_SGSN_ADDRESS, kept for legacy user space.
+      -
+        name: ms-address
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+        doc: IPv4 address of the mobile subscriber served by the context.
+      -
+        name: flow
+        type: u16
+        doc: Flow label, GTPv0 only.
+      -
+        name: net-ns-fd
+        type: u32
+        doc: File descriptor of the network namespace of the gtp netdevice.
+      -
+        name: i-tei
+        type: u32
+        doc: Ingress Tunnel Endpoint Identifier, GTPv1-U only.
+      -
+        name: o-tei
+        type: u32
+        doc: Egress Tunnel Endpoint Identifier, GTPv1-U only.
+      -
+        name: pad
+        type: pad
+      -
+        name: peer-addr6
+        type: binary
+        checks:
+          exact-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+        doc: IPv6 address of the remote GSN peer (GGSN or SGSN).
+      -
+        name: ms-addr6
+        type: binary
+        checks:
+          exact-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+        doc: IPv6 address of the mobile subscriber served by the context.
+      -
+        name: family
+        type: u8
+        doc: Address family (AF_INET or AF_INET6) of the context addresses.
+
+operations:
+  list:
+    -
+      name: newpdp
+      doc: Create or update a PDP context.
+      attribute-set: gtp
+      value: 0
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
+      do:
+        request: &pdp-attrs
+          attributes:
+            - link
+            - version
+            - tid
+            - peer-address
+            - peer-addr6
+            - ms-address
+            - ms-addr6
+            - flow
+            - i-tei
+            - o-tei
+            - family
+            - net-ns-fd
+    -
+      name: delpdp
+      doc: Delete a PDP context.
+      attribute-set: gtp
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
+      do:
+        request: *pdp-attrs
+    -
+      name: getpdp
+      doc: Get or dump one or more PDP contexts.
+      attribute-set: gtp
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - link
+            - version
+            - tid
+            - ms-address
+            - ms-addr6
+            - i-tei
+            - family
+            - net-ns-fd
+        reply: &pdp-reply
+          attributes:
+            - version
+            - tid
+            - peer-address
+            - peer-addr6
+            - ms-address
+            - ms-addr6
+            - flow
+            - i-tei
+            - o-tei
+            - family
+      dump:
+        reply: *pdp-reply
+    -
+      name: echoreq
+      doc: Send a GTP-U echo request to a peer.
+      attribute-set: gtp
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - link
+            - version
+            - peer-address
+            - peer-addr6
+            - family
+
+mcast-groups:
+  list:
+    -
+      name: gtp
diff --git a/MAINTAINERS b/MAINTAINERS
index 51873349b..a6e43995e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11421,6 +11421,7 @@ M:	Harald Welte <laforge@gnumonks.org>
 L:	osmocom-net-gprs@lists.osmocom.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp.git
+F:	Documentation/netlink/specs/gtp.yaml
 F:	drivers/net/gtp.c
 
 GUID PARTITION TABLE (GPT)
-- 
2.25.1

