Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8D3EC6B3
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143173; cv=none; b=VBputZu6NWHXDFVhRvl0W1rxhs/N7qO69qYCwiSFVr3nmd4clymrfu5ia+0XcRZZNgoqPxAnDYepU8TRT5GzIEa1keMGmSH0DSiJZnpna3g4zfFJeXbCXBEQ7icERQclD1b0/2AnsSmLYhPxSrk2GNCOlNTD6sN4gsuS1JTHoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143173; c=relaxed/simple;
	bh=k1OO8I8oTlXC08Pf52SlYo8UCf3RbYEZbxW46ue8Nyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F99Ss1B5QQEK81f5OJJmzmYtMNUeBtL1ssxW7mUe4mUnMuM1tlNUJYdFzjp8P9O2hqpq8/FK5wtSmD7VXu9Cta/whEuVTZQmZ8PuvzV4FaR959SbOqLzMoYsvfWix17I99zlCDaxOfHo6SV721OQG13IsfiSWQwjBnGqW1/hrII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aclsrkOG; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aclsrkOG"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35d7fa491deso817668eec.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143170; x=1792747970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBNZTD52c8ihTK0P5dKq1eTSDHb6U3yTOfoZI6TI0PI=;
        b=aclsrkOGp/fvWrfhd8yL0fPaXSWZ037W7lQeBp+P+5yDNX/4SFRosoTr0V7gGU3g9y
         /zT2xTFTQWabVHv3coax7K6sKAIuFMOamchvYD/TIn+0Y1nGG3MIQxWVwOU0+cMd9Xvz
         EKuKLjdOw/+2eJflKRrhHlbdYPePpUO8b2h9/GmYatQSVP10A3xwVzpJScR0YDA+3NN8
         /tU2cOOC+f3RLEO+yKcHiCFKfv+R8lqgHh/xljD+D+/Fd+EtpGM1ZtJlmkxr1w5QVc6S
         LFlJP3ESiBSw4Dbjsz86sCKLWwzEbKFROWeLYLJBsVO4J7fBh8TSFElzglwogfLkY+DT
         9CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143170; x=1792747970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBNZTD52c8ihTK0P5dKq1eTSDHb6U3yTOfoZI6TI0PI=;
        b=ielRP/3TTGwpE6cvO4b9ooQn/eXVz7qzp7h58hrwcVR2fXdING35oHIgPaA6sNmTuE
         CqybWgdBk6rXakufj23eFbCKYtU4oqx5Hk2UPvn7L3Wi1B+eKxX44pM8DGF1mU1pAB1f
         LwqWLIAw7YOp5aKJWrJwtX4MtSZ++28OhCPb3Js4eQC1G6in/lZ6Oj0eHSVfP53VroBH
         YQM13a1zx5Cy7U+snB3zesEHSpSOM5J67qgEtpzomlcx3B5xmATysneskAfc9+mcxMKF
         DBmlu3xO4WHGVcgxtcsAVTWbI+NkfV9fixSve80i/cQISHygD2InkJjNCz6ZX1MwzAld
         n4iA==
X-Forwarded-Encrypted: i=1; AKwUvBxdtsMC4SK4zQLjcgHHRCmDSeX27jxRMXPg85I9n+IgzH4RsrNMC/5AmbqlepEtDJ4xbRzoSak=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLkUbt9a6nHx+YTKrRA5vWZyAerEwFHFfmcafjdFdeX7BRu+dt
	fsDLhJh79kHyOYqkhRA4IHyvXjeLRtrS1aIph8/XQWYCs8BVxkGEazyd
X-Gm-Gg: AYBFou08gRHpdioSq2hBP3gjdy3M+1wFwKrwK+SmhgGHegQUVMYz03TLv+zskoQ/Uqa
	DKHx2M1+XWYobCGQ8NlHSG12IBAo+UstvN/Lm7k9lC0joNhPRQcsXpPHPYQ6PzhYFaH0DXme6FR
	VqBO0z/a5SvwZnI20xwTEB9noF5lzuNl1b2KpdupM3YJgQi0sUXtGtgxH3r08EdH5nNLKxsyIas
	x4TXjg1H7tpG7FbbSarC+nQLekhb+7MxgOiNi8mn3kgbbMvVE1R4OxgWtMnk5LRJVCJMcg6hC1L
	vpobhe5c1HIp+zc5pEIVUzR00Z1YbeHkMHXIfwmwQNy8e4b9F55EuAxXrUYET9vfigCJTLwdim3
	UwMSdtLngrqNyJrsPnWrlxRPTl6eFCqI9OGbdaAaTQWoQne6SHHRmsUGAly3vhAkHCt1CDEs2/y
	8ozSSM+bTKUZjLOt4JEKAe9W3KEH49h8WxrTz5teO5sHqFnCTkXw9gzgQgM97kavWXGX+ssphCD
	F3LHImEmkiscNbFU3v1llmKE/g5x02yXLPyklQN2SLCXdEMpMuaCfhpe85j3Py1oWuXXCtxibno
	2DJu9kJXI2QINmP77suDCH7V1dpfi7JEXHsUtplpyvS/dPzk3OldUA==
X-Received: by 2002:a05:7301:6486:b0:361:8d0:6c7a with SMTP id 5a478bee46e88-36108d07524mr800644eec.26.1792143170184;
        Fri, 16 Oct 2026 02:32:50 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm5157172eec.18.2026.10.16.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:32:49 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v7 3/4] netlink: specs: add genetlink-legacy spec for GTP
Date: Fri, 16 Oct 2026 09:32:24 +0000
Message-Id: <20261016093225.1036375-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016093225.1036375-1-anilkaushikwireless@gmail.com>
References: <20261016093225.1036375-1-anilkaushikwireless@gmail.com>
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
 Documentation/netlink/specs/gtp.yaml | 196 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 tools/net/ynl/Makefile.deps          |   1 +
 3 files changed, 198 insertions(+)
 create mode 100644 Documentation/netlink/specs/gtp.yaml

diff --git a/Documentation/netlink/specs/gtp.yaml b/Documentation/netlink/specs/gtp.yaml
new file mode 100644
index 000000000000..7871f5def054
--- /dev/null
+++ b/Documentation/netlink/specs/gtp.yaml
@@ -0,0 +1,196 @@
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
+definitions:
+  -
+    type: enum
+    name: version
+    name-prefix: gtp-
+    enum-name: gtp-version
+    header: linux/gtp.h
+    entries: [v0, v1]
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
+        enum: version
+        doc: GTP version of the context, GTPv0 or GTPv1-U.
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
+        doc: |
+          Address family (AF_INET or AF_INET6) of ms-address or ms-addr6,
+          AF_INET when absent. The peer address uses the family of the
+          tunnel socket.
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
index 23e9194483d9..42df33aea837 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11422,6 +11422,7 @@ M:	Harald Welte <laforge@gnumonks.org>
 L:	osmocom-net-gprs@lists.osmocom.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp.git
+F:	Documentation/netlink/specs/gtp.yaml
 F:	drivers/net/gtp.c
 
 GUID PARTITION TABLE (GPT)
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 3eee34e0efcf..70d308cf5039 100644
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

