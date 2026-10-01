Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B94AA031
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845381; cv=none; b=Wg0ra9w/jCv/uO+4jrIwiK3Pl6fNcIFG5w+r/SlSmGNIflg3hHOJFX9UeJHfihxu53Jz1efBrRarV/5kie9fG2gWV8CP4B/NvM6pkoDTfazTxUpsNwslIoRuEz9ysAkPLgW9kYYBMBYalgN+H7mdGU2pJX+UhdaZpv6m/CKc8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845381; c=relaxed/simple;
	bh=GdwEpgAXRzdLPGLowuS38MRQbJCymEeH0/+Qr91J4hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=coeKdNGVor+fRbpL5YB5kSOLkE5a6vwzJ9ccSUKlVDKKOXnO/mglhogEhnYxGZvBoh9WjNNf1SnY/uelHnLysA6RL9xw4+Qqa+pUQga3FcS8l2wWIzBRaefWf04zSV68Lcsl0Q2QfzqdtBa0v0FMtJicWT0NAB7PGigN3pvpDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRrbyHHY; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRrbyHHY"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd025d06so4611100c88.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790845377; x=1791450177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvGXiPiHpimUTJd3v9MQIw2AZILZ1+jCLyBE+b25BWk=;
        b=SRrbyHHYbNUH4trURoQ5tTR6CtFKshAH9WfwsNlny0L3gt+iXM8i3wtvXuMffy99eS
         Fg2gowljmiQqXON/ni1FesKLjk5cQAg9evadJkT4cb1DOvLlcdQE67XddaZpaOv0mGNd
         ui3SSO0cSkruQA9BTCDVYhQqY7T6IfAQabKQqM6bxezYMruShY/8kZYAac/M9Zc6OknV
         kYN+YtVgDG3Fipc06Br7+mZOQn5ao0PqGvntE3V4d+B6GeQjx8A1SJxmIcuEkUAlMymb
         9oRymK7GLGaynxYVqlkKen9gfuSLjXVsqLqlkWFv/Grf7CHGsgs4uFHMVFj+EyTNvhb3
         OGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790845377; x=1791450177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvGXiPiHpimUTJd3v9MQIw2AZILZ1+jCLyBE+b25BWk=;
        b=j2oWSw1GZYZL9TfktLkBCm+aukz4eM92Vrw3dntk8hcx5aZs6BjyKVWiFJjHO0GV0M
         dtGiohbIA4JtcL8BuFVPpLGH9WW4FKwo6y9zpr6dvvOBrJOiO8TinIHtFTYF4++uCU4F
         AVTAJ9FaJlfF11D+FmzoSaaReQ5Wom8D8/sNP1M1/FgIet/hnMBAer0xSwwHU0+us9aK
         xwhsBsvWHZLlgzTeJK/BRf32/L/Uo0ADnfrMJ4CSSVIsYKyv8IfRU+Z3yQdKq25hxCuL
         TXhF8fGb+gUO9O0+U7SU+MysAt9YyQ13EA+c9TmjHPgwXcm+FBVUSmgZ3Vka5UIrkiXn
         R/dw==
X-Forwarded-Encrypted: i=1; AKwUvByNfVWLmbz0ysg1Ta3yr78AW7jDX02twA0ys3GpBaeO3ZlJTMviPaWE6N7MLEAqLYpc76PXpwU=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ/Ddj/FbKFPFROrR0svIadGjDScRp737ILPsMBFD6YrnmMS0O
	pb0e9hyZyj1Mq1o3VtcQOeAm1Mg7BWeVWECWWOiIJxNp+ieOScamKQ6h
X-Gm-Gg: AYBFou2c+KitzDb12ESAXMZ+4MRgtx4JsPyWY7rRsebSoi6As/oewM7SUoZaZyrMG+9
	MFQASVK1i2AqmRI3hJqBWODH3PbsM0V0W5duz7YBQ2LjQPSmOINfcLNtpC5/IcOvlT6QWnwgvF/
	fjTLz2Yg6GoQEp2iq6zSoV+BJd6evdqri7OpELsG5g2ALENuNMz4oky22dfoSCVffWPsGhXiWfj
	NfK8paOaZcmlXPQv80nz3AfJdsh/VuC5+fX3j8nfy2HSNe+U5jz+QBGL2xbJsZ/xODci3Ws+z7m
	X2aoa+pE9ZPqCkqVrXKd+fYvFe0uaXc9We1h/L3qgYvKCBiHBd7cSuJpY043ufQvRt1G13nEsB9
	Wj+v2HMgTJvx9+ZhgB8pCUyiF5hBovCno8uT3DJMk93ptfGINMh6x/t9IQGvcAkUxey2gE1gjeC
	PpgIcNlQ6wTEAisx4bPY64tgqbJExmecxgCC544PGqf9rAUjTZ1UK0WcN+fWuO/b7bbUKr4OpcG
	RuDrWqGF/wfoUhPUpewAwgkxA9rSHqroZz/+TDPciqSTGygX+mXHbjyVwvm7TornNoaFYXu1rrW
	LVcUegqGT9QQotvHKn0viuZW3D42+nvhl8il5+1nynw=
X-Received: by 2002:a05:701b:2810:b0:14e:9cd7:9324 with SMTP id a92af1059eb24-14e9cd796c3mr543230c88.9.1790845377305;
        Thu, 01 Oct 2026 02:02:57 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14df40e8d49sm4659068c88.13.2026.10.01.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:02:56 -0700 (PDT)
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
Subject: [RFC net-next] netlink: specs: add genetlink-legacy spec for GTP
Date: Thu,  1 Oct 2026 09:02:50 +0000
Message-Id: <20261001090250.3395779-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
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

