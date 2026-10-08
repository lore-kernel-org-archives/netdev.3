Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAC4ACC93;
	Thu,  8 Oct 2026 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470004; cv=none; b=cVfY2QPrNlOjoI5n0LRXAuRWvwNwb5aqO0LDyPp5NldbBeTKLxDfBJavy3ThKsckgdGeD9opMGbzVvIg43Y8f9bUq5vnDwKXok6pkodmC3hODNYfEQbsWIzVeisZH3Kecb+BqvYrSj/muAj23EtoLHYMLS6o58Y6g8JGEAMxHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470004; c=relaxed/simple;
	bh=a2orRDrG/G5UklM1m+5/g02DewxafPhYRBpqpINqyfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGMpJpFxoGOC5P4tsAtElWbhZgXN1z4xr9Zk8BbVndG62PoUguFDeDUnIJddwOtvM19NFsdszSI5/z5HMS9UGUiJcqSHT7qwA8QozA2bnFcirDFAHaBvJrQLIdZ0z51kYKNMMBIUxOlRQMswG0n4QISlTl1AlAPHTYUssNUyQ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:26fc:ddc6:af15:b0f7:2808] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xEpBB-000l4X-1w;
	Thu, 08 Oct 2026 16:33:05 +0200
From: John Crispin <john@phrozen.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [RFC net-next 01/12] net: pon: add the netlink specification of the pon family
Date: Thu,  8 Oct 2026 16:32:38 +0200
Message-Id: <20261008143249.3439762-2-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008143249.3439762-1-john@phrozen.org>
References: <20261008143249.3439762-1-john@phrozen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pon generic netlink family configures the ONU side of an ITU-T
passive optical network. The kernel owns activation (which the MAC
driver runs) and the datapath objects. Userspace owns OMCI (the
management plane) and expresses what the OLT asks for through this
family.

The family carries the identity and the activation state of a device,
the T-CONTs, the GEM ports, the upstream classifier rules and the OMCI
channel. Notifications are levels, so a listener that loses one reads
the state again. A write operation answers with the netlink ACK only.
No key material crosses the family.

The mode enum lists gpon, xg-pon and xgs-pon. No driver runs gpon or
xg-pon yet. The enum keeps them so that the uapi order stays clean for
the drivers that add them later. The core refuses them through the mode
capability of the device: dev-set refuses a mode the device does not
list, with an extack message and a line in the kernel log.

pon.yaml is the source. The uapi header is generated from it with
ynl-gen. The Makefile.deps of tools/net/ynl gets a line for the family,
so that the header of the tree wins over an older copy that a
distribution ships. The kernel side follows with the subsystem.

Assisted-by: LLM
Signed-off-by: John Crispin <john@phrozen.org>
---
 Documentation/netlink/specs/pon.yaml | 604 +++++++++++++++++++++++++++
 include/uapi/linux/pon.h             | 166 ++++++++
 tools/net/ynl/Makefile.deps          |   1 +
 3 files changed, 771 insertions(+)
 create mode 100644 Documentation/netlink/specs/pon.yaml
 create mode 100644 include/uapi/linux/pon.h

diff --git a/Documentation/netlink/specs/pon.yaml b/Documentation/netlink/specs/pon.yaml
new file mode 100644
index 000000000000..45780c179613
--- /dev/null
+++ b/Documentation/netlink/specs/pon.yaml
@@ -0,0 +1,604 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: pon
+
+doc:
+  Passive Optical Network device configuration over generic netlink.
+
+  A PON device represents the ONU-side MAC of a GPON or XG(S)-PON link. The
+  kernel owns activation (the PLOAM state machine, ranging and the key
+  hierarchy run in hardware or in the driver, driven by MAC interrupts) and
+  the datapath objects (T-CONTs and GEM ports). Userspace owns the management
+  plane, OMCI, whose PDUs this family carries between the OMCC and the one
+  socket that registered for them. This family also carries identity,
+  datapath object configuration, state notifications and counters.
+
+  An operation is a set when it can change an object that already exists
+  and a new when it can only create one. A tcont-set rebinds a T-CONT, while
+  a gem-new refuses a GEM port that exists with other attributes.
+
+definitions:
+  -
+    type: enum
+    name: mode
+    doc: PON operating mode.
+    entries: [gpon, xg-pon, xgs-pon]
+  -
+    type: enum
+    name: ploam-state
+    doc: |
+      ITU-T G.9807.1 / G.984.3 ONU activation state. O5 is the only state in
+      which the OMCC carries traffic. G.9807.1 has one Serial Number state,
+      O2-3 (Table C.12.1), reported as o2. Only a G.984.3 device reports o3.
+    entries: [unknown, o1, o2, o3, o4, o5, o6, o7]
+  -
+    type: enum
+    name: gem-dir
+    doc: |
+      GEM port direction. The values are those of the direction attribute of
+      the GEM port network CTP managed entity of ITU-T G.988: UNI-to-ANI (1),
+      ANI-to-UNI (2) or bidirectional (3). An OMCI stack passes the value
+      through.
+    entries:
+      -
+        name: upstream
+        value: 1
+      -
+        name: downstream
+        value: 2
+      -
+        name: bidir
+        value: 3
+  -
+    type: enum
+    name: gem-key-ring
+    doc: |
+      Whether a GEM port is encrypted and with which keys, as the
+      encryption key ring attribute of the GEM port network CTP managed
+      entity of ITU-T G.988 clause 9.2.3 defines it.
+    entries:
+      -
+        name: none
+        doc: No encryption. Upstream is sent with key index 0.
+      -
+        name: unicast
+        doc: |
+          Unicast encryption in both directions, with the keys the ONU
+          generates.
+      -
+        name: broadcast
+        doc: |
+          Broadcast encryption, with the keys the OLT distributes over the
+          OMCI.
+      -
+        name: unicast-downstream
+        doc: |
+          Unicast encryption of the downstream only, with the keys the ONU
+          generates.
+  -
+    type: enum
+    name: gem-map-tag
+    doc: VLAN tag state an upstream classifier rule matches.
+    entries: [untagged, tagged]
+
+attribute-sets:
+  -
+    name: dev
+    attributes:
+      -
+        name: id
+        doc: PON device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: ifindex
+        doc: ifindex of the PON data network device (the PON MAC port).
+        type: u32
+      -
+        name: mode
+        doc: Active PON mode.
+        type: u32
+        enum: mode
+      -
+        name: modes-cap
+        doc: Bitmask of the modes the device supports.
+        type: u32
+        enum: mode
+        enum-as-flags: true
+      -
+        name: serial
+        doc: |
+          ONU serial number, 8 bytes: the 4 ASCII characters of the Vendor_ID
+          of ITU-T G.9807.1 clause C.11.2.6.1, then the 4 byte VSSN of clause
+          C.11.2.6.2. Eight 0x00 bytes address every ONU (Table C.11.23A) and
+          are refused.
+        type: binary
+        checks:
+          exact-len: 8
+      -
+        name: registration-id
+        doc: |
+          Registration_ID of the Registration message of ITU-T G.9807.1
+          (Table C.11.25), 1 to 36 bytes. An empty value is refused. The
+          kernel pads a shorter value with 0x00 bytes to 36, as the note of
+          the table recommends. Write only: it is a credential.
+        type: binary
+        checks:
+          max-len: 36
+      -
+        name: ploam-state
+        doc: Current activation state.
+        type: u32
+        enum: ploam-state
+      -
+        name: max-tconts
+        doc: Number of T-CONTs the device supports.
+        type: u32
+      -
+        name: max-gems
+        doc: |
+          Number of GEM ports gem-new can create, not counting the GEM port
+          of the OMCC. gem-new answers -ENOSPC beyond it.
+        type: u32
+      -
+        name: enable
+        doc: |
+          1 starts the ONU upstream link, 0 stops it. In a reply, whether the
+          link was last started.
+        type: u8
+        checks:
+          max: 1
+  -
+    name: tcont
+    attributes:
+      -
+        name: dev-id
+        doc: PON device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: index
+        doc: |
+          T-CONT index in the device, 0 based and below the max-tconts of
+          the device.
+        type: u32
+        checks:
+          max: 65534
+      -
+        name: alloc-id
+        doc: |
+          Alloc-ID bound to the T-CONT, as assigned by the OLT. ITU-T
+          G.9807.1 clause C.6.1.5.7 bounds it at 16383.
+        type: u32
+        checks:
+          max: 16383
+  -
+    name: gem
+    attributes:
+      -
+        name: dev-id
+        doc: PON device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: id
+        doc: |
+          GEM port ID, as the OLT assigns it over the OMCI. ITU-T G.9807.1
+          Table C.6.6 reserves 0 to 1020 for the default Port-ID (equal
+          to the ONU-ID, OMCC only) and 65535 for the idle Port-ID, so an
+          assigned GEM port is 1021 to 65534.
+        type: u32
+        checks:
+          min: 1021
+          max: 65534
+      -
+        name: dir
+        doc: Direction.
+        type: u32
+        enum: gem-dir
+      -
+        name: tcont-index
+        doc: |
+          T-CONT the upstream half rides. Required for an upstream or
+          bidirectional GEM port. A downstream GEM port rides no T-CONT and
+          is refused with this attribute.
+        type: u32
+        checks:
+          max: 65534
+      -
+        name: key-ring
+        doc: |
+          Encryption key ring of the GEM port. Absent means none. The
+          kernel refuses broadcast, since it takes no broadcast key.
+        type: u32
+        enum: gem-key-ring
+  -
+    name: gem-map
+    attributes:
+      -
+        name: dev-id
+        doc: PON device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: gem-id
+        doc: GEM port the matching frames map to, 1021 to 65534 as for gem id.
+        type: u32
+        checks:
+          min: 1021
+          max: 65534
+      -
+        name: tag
+        doc: Match the frame VLAN tag state. Absent matches either.
+        type: u32
+        enum: gem-map-tag
+      -
+        name: vid
+        doc: Match the outer VLAN ID. Absent matches any.
+        type: u32
+        checks:
+          max: 4094
+      -
+        name: pbit
+        doc: Match the outer VLAN priority. Absent matches any.
+        type: u32
+        checks:
+          max: 7
+      -
+        name: dscp
+        doc: Match the IP DSCP field. Absent matches any.
+        type: u32
+        checks:
+          max: 63
+  -
+    name: omci
+    attributes:
+      -
+        name: dev-id
+        doc: PON device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: pdu
+        doc: |
+          One OMCI PDU, from the transaction correlation id to the end of the
+          message contents: 44 bytes for the baseline format, the 10 byte
+          header and the contents for the extended format of ITU-T G.988
+          annex B. It carries no integrity field in either direction. The
+          MAC adds the MIC upstream and checks it downstream. Upstream the
+          device identifier selects the format and the length must match
+          it: 44 bytes for 0x0a, 10 bytes plus the message contents length
+          of the header for 0x0b. Any other PDU is refused.
+        type: binary
+        checks:
+          max-len: 1976
+
+operations:
+  list:
+    -
+      name: dev-get
+      doc: Get or dump PON devices.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+        reply: &dev-all
+          attributes:
+            - id
+            - ifindex
+            - mode
+            - modes-cap
+            - serial
+            - ploam-state
+            - max-tconts
+            - max-gems
+            - enable
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+      dump:
+        reply: *dev-all
+    -
+      name: dev-set
+      doc: |
+        Set the identity of a PON device, start or stop its upstream link, or
+        any combination. While the link is enabled, a mode or a serial number
+        other than the one the device holds is refused with EBUSY.
+        The settings are applied before the link moves.
+      attribute-set: dev
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - id
+            - mode
+            - serial
+            - registration-id
+            - enable
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: dev-add-ntf
+      doc: Notification about a PON device appearing.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: dev-del-ntf
+      doc: |
+        Notification about a PON device disappearing. Every T-CONT, GEM port
+        and classifier rule of the device goes with it, without a
+        notification of its own.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: dev-change-ntf
+      doc: Notification about a PON device configuration change.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: ploam-ntf
+      doc: |
+        The activation state changed. Every transition is reported, so the
+        O5 edge, which is the OMCC becoming usable or unusable, is visible.
+      attribute-set: dev
+      mcgrp: state
+      event:
+        attributes:
+          - id
+          - ploam-state
+
+    -
+      name: tcont-get
+      doc: |
+        Get or dump T-CONTs. A dump with a device ID lists the T-CONTs of
+        that device only.
+      attribute-set: tcont
+      do:
+        request:
+          attributes:
+            - dev-id
+            - index
+        reply: &tcont-all
+          attributes:
+            - dev-id
+            - index
+            - alloc-id
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+      dump:
+        request:
+          attributes:
+            - dev-id
+        reply: *tcont-all
+    -
+      name: tcont-set
+      doc: |
+        Bind an alloc-id to a T-CONT, or rebind it. A rebind moves the GEM
+        ports of the T-CONT too. If the driver refuses one, the old alloc-id
+        stays on the T-CONT and on its GEM ports and the request fails.
+      attribute-set: tcont
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - dev-id
+            - index
+            - alloc-id
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: tcont-del
+      doc: |
+        Release a T-CONT. Fails with -EBUSY while a GEM port names the
+        T-CONT. Delete the GEM ports first.
+      attribute-set: tcont
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - dev-id
+            - index
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: tcont-add-ntf
+      doc: A T-CONT object was created.
+      notify: tcont-get
+      mcgrp: mgmt
+    -
+      name: tcont-change-ntf
+      doc: A T-CONT object changed.
+      notify: tcont-get
+      mcgrp: mgmt
+    -
+      name: tcont-del-ntf
+      doc: A T-CONT object was removed.
+      notify: tcont-get
+      mcgrp: mgmt
+
+    -
+      name: gem-get
+      doc: |
+        Get or dump GEM ports. A dump with a device ID lists the GEM ports
+        of that device only.
+      attribute-set: gem
+      do:
+        request:
+          attributes:
+            - dev-id
+            - id
+        reply: &gem-all
+          attributes:
+            - dev-id
+            - id
+            - dir
+            - tcont-index
+            - key-ring
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+      dump:
+        request:
+          attributes:
+            - dev-id
+        reply: *gem-all
+    -
+      name: gem-new
+      doc: |
+        Create a GEM port. A GEM port that exists with the same attributes
+        is accepted. One that exists with other attributes is refused.
+      attribute-set: gem
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - dev-id
+            - id
+            - dir
+            - tcont-index
+            - key-ring
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: gem-del
+      doc: Destroy a GEM port.
+      attribute-set: gem
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - dev-id
+            - id
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: gem-add-ntf
+      doc: A GEM port object was created.
+      notify: gem-get
+      mcgrp: mgmt
+    -
+      name: gem-del-ntf
+      doc: A GEM port object was removed.
+      notify: gem-get
+      mcgrp: mgmt
+
+    -
+      name: gem-map-get
+      doc: |
+        Dump the upstream classifier rules. The core keeps a copy of each
+        rule that the driver took. A dump with a device ID lists the rules of
+        that device only.
+      attribute-set: gem-map
+      dump:
+        request:
+          attributes:
+            - dev-id
+        reply:
+          attributes:
+            - dev-id
+            - gem-id
+            - tag
+            - vid
+            - pbit
+            - dscp
+    -
+      name: gem-map-new
+      doc: |
+        Add one upstream classifier rule mapping frames onto a GEM port.
+        A rule matches on the attributes it carries. A more specific rule
+        wins over a less specific one.
+      attribute-set: gem-map
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - dev-id
+            - gem-id
+            - tag
+            - vid
+            - pbit
+            - dscp
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: gem-map-del
+      doc: Remove one upstream classifier rule.
+      attribute-set: gem-map
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - dev-id
+            - gem-id
+            - tag
+            - vid
+            - pbit
+            - dscp
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: gem-map-add-ntf
+      doc: An upstream classifier rule was created.
+      notify: gem-map-get
+      mcgrp: mgmt
+    -
+      name: gem-map-del-ntf
+      doc: An upstream classifier rule was removed.
+      notify: gem-map-get
+      mcgrp: mgmt
+
+
+    -
+      name: omci-register
+      doc: |
+        Receive the OMCI PDUs of one device on this socket, as omci-ntf.
+        One socket at a time owns the OMCI channel of a device. Another
+        socket is refused with EBUSY until the owner closes. A registration
+        ends only when its socket closes.
+      attribute-set: omci
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - dev-id
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: omci-tx
+      doc: |
+        Send one OMCI PDU to the OLT. Only the socket that owns the OMCI
+        channel of the device may send and the MAC refuses a PDU while the
+        ONU is not in O5.
+      attribute-set: omci
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - dev-id
+            - pdu
+        pre: pon-device-get-locked
+        post: pon-device-unlock
+    -
+      name: omci-ntf
+      doc: |
+        One OMCI PDU from the OLT, sent only to the socket that owns the
+        OMCI channel of the device. A PDU that finds no room on that socket
+        is lost. The OLT retries.
+      attribute-set: omci
+      event:
+        attributes:
+          - dev-id
+          - pdu
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
+    -
+      name: state
+
+...
diff --git a/include/uapi/linux/pon.h b/include/uapi/linux/pon.h
new file mode 100644
index 000000000000..1fedadb44305
--- /dev/null
+++ b/include/uapi/linux/pon.h
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/pon.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_PON_H
+#define _UAPI_LINUX_PON_H
+
+#define PON_FAMILY_NAME		"pon"
+#define PON_FAMILY_VERSION	1
+
+/*
+ * PON operating mode.
+ */
+enum pon_mode {
+	PON_MODE_GPON,
+	PON_MODE_XG_PON,
+	PON_MODE_XGS_PON,
+};
+
+/*
+ * ITU-T G.9807.1 / G.984.3 ONU activation state. O5 is the only state in which
+ * the OMCC carries traffic. G.9807.1 has one Serial Number state, O2-3 (Table
+ * C.12.1), reported as o2. Only a G.984.3 device reports o3.
+ */
+enum pon_ploam_state {
+	PON_PLOAM_STATE_UNKNOWN,
+	PON_PLOAM_STATE_O1,
+	PON_PLOAM_STATE_O2,
+	PON_PLOAM_STATE_O3,
+	PON_PLOAM_STATE_O4,
+	PON_PLOAM_STATE_O5,
+	PON_PLOAM_STATE_O6,
+	PON_PLOAM_STATE_O7,
+};
+
+/*
+ * GEM port direction. The values are those of the direction attribute of the
+ * GEM port network CTP managed entity of ITU-T G.988: UNI-to-ANI (1),
+ * ANI-to-UNI (2) or bidirectional (3). An OMCI stack passes the value through.
+ */
+enum pon_gem_dir {
+	PON_GEM_DIR_UPSTREAM = 1,
+	PON_GEM_DIR_DOWNSTREAM,
+	PON_GEM_DIR_BIDIR,
+};
+
+/**
+ * enum pon_gem_key_ring - Whether a GEM port is encrypted and with which keys,
+ *   as the encryption key ring attribute of the GEM port network CTP managed
+ *   entity of ITU-T G.988 clause 9.2.3 defines it.
+ * @PON_GEM_KEY_RING_NONE: No encryption. Upstream is sent with key index 0.
+ * @PON_GEM_KEY_RING_UNICAST: Unicast encryption in both directions, with the
+ *   keys the ONU generates.
+ * @PON_GEM_KEY_RING_BROADCAST: Broadcast encryption, with the keys the OLT
+ *   distributes over the OMCI.
+ * @PON_GEM_KEY_RING_UNICAST_DOWNSTREAM: Unicast encryption of the downstream
+ *   only, with the keys the ONU generates.
+ */
+enum pon_gem_key_ring {
+	PON_GEM_KEY_RING_NONE,
+	PON_GEM_KEY_RING_UNICAST,
+	PON_GEM_KEY_RING_BROADCAST,
+	PON_GEM_KEY_RING_UNICAST_DOWNSTREAM,
+};
+
+/*
+ * VLAN tag state an upstream classifier rule matches.
+ */
+enum pon_gem_map_tag {
+	PON_GEM_MAP_TAG_UNTAGGED,
+	PON_GEM_MAP_TAG_TAGGED,
+};
+
+enum {
+	PON_A_DEV_ID = 1,
+	PON_A_DEV_IFINDEX,
+	PON_A_DEV_MODE,
+	PON_A_DEV_MODES_CAP,
+	PON_A_DEV_SERIAL,
+	PON_A_DEV_REGISTRATION_ID,
+	PON_A_DEV_PLOAM_STATE,
+	PON_A_DEV_MAX_TCONTS,
+	PON_A_DEV_MAX_GEMS,
+	PON_A_DEV_ENABLE,
+
+	__PON_A_DEV_MAX,
+	PON_A_DEV_MAX = (__PON_A_DEV_MAX - 1)
+};
+
+enum {
+	PON_A_TCONT_DEV_ID = 1,
+	PON_A_TCONT_INDEX,
+	PON_A_TCONT_ALLOC_ID,
+
+	__PON_A_TCONT_MAX,
+	PON_A_TCONT_MAX = (__PON_A_TCONT_MAX - 1)
+};
+
+enum {
+	PON_A_GEM_DEV_ID = 1,
+	PON_A_GEM_ID,
+	PON_A_GEM_DIR,
+	PON_A_GEM_TCONT_INDEX,
+	PON_A_GEM_KEY_RING,
+
+	__PON_A_GEM_MAX,
+	PON_A_GEM_MAX = (__PON_A_GEM_MAX - 1)
+};
+
+enum {
+	PON_A_GEM_MAP_DEV_ID = 1,
+	PON_A_GEM_MAP_GEM_ID,
+	PON_A_GEM_MAP_TAG,
+	PON_A_GEM_MAP_VID,
+	PON_A_GEM_MAP_PBIT,
+	PON_A_GEM_MAP_DSCP,
+
+	__PON_A_GEM_MAP_MAX,
+	PON_A_GEM_MAP_MAX = (__PON_A_GEM_MAP_MAX - 1)
+};
+
+enum {
+	PON_A_OMCI_DEV_ID = 1,
+	PON_A_OMCI_PDU,
+
+	__PON_A_OMCI_MAX,
+	PON_A_OMCI_MAX = (__PON_A_OMCI_MAX - 1)
+};
+
+enum {
+	PON_CMD_DEV_GET = 1,
+	PON_CMD_DEV_SET,
+	PON_CMD_DEV_ADD_NTF,
+	PON_CMD_DEV_DEL_NTF,
+	PON_CMD_DEV_CHANGE_NTF,
+	PON_CMD_PLOAM_NTF,
+	PON_CMD_TCONT_GET,
+	PON_CMD_TCONT_SET,
+	PON_CMD_TCONT_DEL,
+	PON_CMD_TCONT_ADD_NTF,
+	PON_CMD_TCONT_CHANGE_NTF,
+	PON_CMD_TCONT_DEL_NTF,
+	PON_CMD_GEM_GET,
+	PON_CMD_GEM_NEW,
+	PON_CMD_GEM_DEL,
+	PON_CMD_GEM_ADD_NTF,
+	PON_CMD_GEM_DEL_NTF,
+	PON_CMD_GEM_MAP_GET,
+	PON_CMD_GEM_MAP_NEW,
+	PON_CMD_GEM_MAP_DEL,
+	PON_CMD_GEM_MAP_ADD_NTF,
+	PON_CMD_GEM_MAP_DEL_NTF,
+	PON_CMD_OMCI_REGISTER,
+	PON_CMD_OMCI_TX,
+	PON_CMD_OMCI_NTF,
+
+	__PON_CMD_MAX,
+	PON_CMD_MAX = (__PON_CMD_MAX - 1)
+};
+
+#define PON_MCGRP_MGMT	"mgmt"
+#define PON_MCGRP_STATE	"state"
+
+#endif /* _UAPI_LINUX_PON_H */
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 1e746e25e2bc..fc84485b2c8b 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -38,6 +38,7 @@ CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_packet:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_pon:=$(call get_hdr_inc,_LINUX_PON_H,pon.h)
 CFLAGS_psp:=$(call get_hdr_inc,_LINUX_PSP_H,psp.h)
 CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
-- 
2.34.1

