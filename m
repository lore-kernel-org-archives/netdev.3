Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657939A06D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773300; cv=none; b=ZQMXD+W6aZlODUKNfzq9t8KSp+sJ2vH7HU3WB6/avOrwpTkANJZLjkQ8FDu1GihYXY9nR5AEy5kLjEDLGBMl6m1L5xnRsihYuK0QTy/VXGsrm+Gho1b7iyWrhDhfAZQJy2Jian5IxHJSz1VKYP/bBQ/j6bWAInn1QwyUgYOxH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773300; c=relaxed/simple;
	bh=/3PjWfkzM/efN0wGN7Z5YGi740qr4COct1iZN2vYT3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5RJXC2J0aiLa1LTxQ8glSpajdMoVjmqBMDHpUtK4eipgcSu3FjxlwI4bSWpf5+WKboiOekpBkxGM95zulTa7n4PcmcT79L9G5oP212aS0580QUrt8qEdolO13eyxSb5pMomZv/hurQxgSgy4K3x2HYl+1oYec/R7Uw/58vEJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcpWS2L6; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcpWS2L6"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso3665307eec.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 19:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773298; x=1792378098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TRzywdSur3zmqfmDlLuRL61gI+LM9+nqup6UgMDQquQ=;
        b=LcpWS2L6hydH6PkijkfyBHFBNDFgB/sX+jrdykRt8TJH+vtv4hl7mLM3t1b1vH+7BG
         6eGBCvEd0LfElSg4T4sm7XxdoK+RxQbbUyfoM+gsCCFdAriLQWRCh5H9IwHWKLLWa1df
         2Ti7JwvDz/vj5N4TgcxNVSrM1ckPbXXpJZsIObZ8EsMP5QHGGbk282mC8sC1XSjjUssR
         tqt/7iHXWC3b3ruDCwQ3xQL5aprFy/0WA8V6rNNfOoRIs++L3gYa/hAAZc7mqjmyyBoN
         1MhdXbD+OlHYIr0RuuNy+5JkOlqopmInf8U3DLD9VFeuwaVwQH6BHZWaSYQ5p5ShNmQF
         fOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773298; x=1792378098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TRzywdSur3zmqfmDlLuRL61gI+LM9+nqup6UgMDQquQ=;
        b=Bvm6ArITYDIMfk1KVxqizEzhP3vNSXu0VeXf0F1uPx9V0Y4fzH9kk5H2+nx+m53r6f
         qGunGLobO32bqVKgoARE/vLRQJ/cr91PKG3Upj+j9h6J2kqSrFQlQMXpR01AIWF1LsNX
         epHETOnB18/zbf69PLi/LM1GdH4Sc/d25w0SlZmaFPJagHVo4Y9PS9BzUMrFoTzmYGZ8
         ugLzlRD4YCAfOY5qgaw5Q0oOqNIxc1Hx2abx5C6LAsk9AaG+spkuiY8VTMq2JvM3jlDP
         J+Eg63HZyRnqZtXJKbN5PEh6eaO5wYhG7/RerSZCbBkVHxqcj/bWM6vwWqeGSovp4IX1
         auNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTrQEA1pZ7+hu3qRTpVuIgy4ASgz5fyTwHShvwH2k3sCcf16dJojvFwbfvOjgSCnMr8aFD51k=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2/i14cwn97OoMh5X7CNibzFD6QnF35kssgP6+vnHs6hJif58X
	kDA+NZCUn+kSXVw8BgHTl2bSVg/KbVrMZDRMqeDcCcE/EcZY5lOfzxtn
X-Gm-Gg: AYBFou1cEfJOwLSyUwRfWkqzDOMzcbRE5JITPXTIpmV80x45ZH1cmKtvh1vIlZj5o3Q
	ApGaqEhbbRWBSdEwiCAJ+s39wghRKtNywpfOrEtkGXrCMKd6Y9iZ3HDJMVqBdz6K6QmTZJqh3+i
	JV5DbRtbkqGAXvGaCXs6rB0sQRlrCPMyurAbCykMCGKQcPgS5QAqdJ4wGDazmwxNqSXq2URfiRw
	7/bfRdevAuDjPqjDPpgynDIvuecHAOHgjlw/1bUDQFeTY9Z5ckVhgnR4ZLzsqtkEz9X6uC+upZy
	haPnzvb3Bccdm7HEGceaLbBNtlZlumLiMmz0GZWWi/V4f+WCnQz7nVeTm/V9GwmE/yGm0mD0sds
	C+FLRe7F3oQgH6l2RVZTrrCsxa4+nX0vC3jKp94TXnTQVjl5XprlBMhYnzZUOsAVI5vsU+CbSd2
	Z+Gj5RIGCRnvSqTStJHr+JxJx5KE2xM7rQCEpxL7s2Xf/Tb1iyIQMKrntyNKW1hMjFnwcIj+j8J
	KI/f+1HGxSv8IAUupDDj//XVWL91hFX5nIqoqntss98UlemKXSUJqlj+n2cl+T8QTwA96g7jLU/
	NlOnVnjEWOa8SIQZgdtk0Q7+DB7+b+ieAxebYUvl8nHBIqmHoVAkvA==
X-Received: by 2002:a05:693c:8954:20b0:351:8cc4:e18b with SMTP id 5a478bee46e88-3537dfb8632mr10825080eec.20.1791773297259;
        Sun, 11 Oct 2026 19:48:17 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm26075299eec.6.2026.10.11.19.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:48:16 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v5 2/3] netlink: specs: add genetlink-legacy spec for GTP
Date: Mon, 12 Oct 2026 02:47:59 +0000
Message-Id: <20261012024800.400616-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261012024800.400616-1-anilkaushikwireless@gmail.com>
References: <20261012024800.400616-1-anilkaushikwireless@gmail.com>
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
group. Command and attribute values are taken from
include/uapi/linux/gtp.h and match it one-to-one. The request
attributes of each command are the ones its handler in
drivers/net/gtp.c reads, and the reply attributes the ones
gtp_genl_fill_info() emits.

The notifications sent on the "gtp" group are not described: they reuse
the command values of the NEWPDP, DELPDP and ECHOREQ requests, which
the ynl code generator cannot express with the existing uapi header.
The family doc says so.

Add the matching CFLAGS_gtp entry to tools/net/ynl/Makefile.deps, so
the generated code is built against the tree's gtp.h instead of an
older one installed on the host.

This only adds the description; there is no kernel code or uapi change.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 Documentation/netlink/specs/gtp.yaml | 183 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 tools/net/ynl/Makefile.deps          |   1 +
 3 files changed, 185 insertions(+)
 create mode 100644 Documentation/netlink/specs/gtp.yaml

diff --git a/Documentation/netlink/specs/gtp.yaml b/Documentation/netlink/specs/gtp.yaml
new file mode 100644
index 000000000000..6a6b49ad2f06
--- /dev/null
+++ b/Documentation/netlink/specs/gtp.yaml
@@ -0,0 +1,183 @@
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
+  The kernel registers the family with version 0, which the
+  genetlink-legacy schema cannot express.
+
+  The notifications multicast on the "gtp" group are not described: PDP
+  context additions and deletions, and GTP-U echo responses, reuse the
+  NEWPDP, DELPDP and ECHOREQ command values of the requests.
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
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+        doc: IPv6 address of the remote GSN peer (GGSN or SGSN).
+      -
+        name: ms-addr6
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+        doc: |
+          IPv6 prefix of the mobile subscriber served by the context: a /64
+          prefix, with the lower 64 bits set to zero.
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
+        request: &pdp-find
+          attributes:
+            - link
+            - version
+            - tid
+            - ms-address
+            - ms-addr6
+            - i-tei
+            - family
+            - net-ns-fd
+    -
+      name: getpdp
+      doc: Get or dump one or more PDP contexts.
+      attribute-set: gtp
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
+      do:
+        request: *pdp-find
+        reply: &pdp-reply
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
+      dump:
+        reply: *pdp-reply
+    -
+      name: echoreq
+      doc: |
+        Send a GTP-U echo request to a peer. ms-address is not a mobile
+        subscriber address here, but the local IPv4 address used as source
+        of the request.
+      attribute-set: gtp
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - link
+            - version
+            - peer-address
+            - ms-address
+            - net-ns-fd
+
+mcast-groups:
+  list:
+    -
+      name: gtp
diff --git a/MAINTAINERS b/MAINTAINERS
index 51873349ba91..a6e43995ea58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11421,6 +11421,7 @@ M:	Harald Welte <laforge@gnumonks.org>
 L:	osmocom-net-gprs@lists.osmocom.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp.git
+F:	Documentation/netlink/specs/gtp.yaml
 F:	drivers/net/gtp.c
 
 GUID PARTITION TABLE (GPT)
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 1e746e25e2bc..9fd8f3321680 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -24,6 +24,7 @@ CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_TYPELIMITS_H,typelimits.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generated.h)
+CFLAGS_gtp:=$(call get_hdr_inc,_LINUX_GTP_H_,gtp.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_lockd_netlink:=$(call get_hdr_inc,_LINUX_LOCKD_NETLINK_H,lockd_netlink.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
-- 
2.25.1

