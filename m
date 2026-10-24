Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833983;
	b=ClCK1v2CPQMkEO91rma88Z5+1VZylFt6KZLyXXtA08gAfcBkxfrIXU5cojJLvtWQ4UEg
	 17us8WANRO+GtTcLC3h+vUzL2MnwxkcrUYxx6AYmFBMkPUStt0qltdArncAPUQcytKv5A
	 Y/X8/k1MOyd656LpzFiPekL7JOipal6EBxKbTbJC1msLW7SosuY8qmDtcyLy6dzXH2glK
	 5Bq2WYMZEb0H5mxPJohZNOgWLX4cWyePXSQE/9VoLjL6cDSXli7jjJZ4u/z46dgs+JfkT
	 OqSJJHKWQYKEgYghcyD6iq8NnYZF+Y/2hIDAOBwEMIBuRGrTX05tOpEuim4ztQu18CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833983;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=2a50pjgeX2yGMJrP20mXnZ3fhZPuQ/Judh9U7PKVmU4=;
	b=PSFLuG/4rrSLgJRKIaDAdwtYf3SOJQaDFCmAmI1lwPy3k5JWp82NNV/mcl0OlmwsZt4j
	 3E3M8zvBPPxnBM2FrTm3ncna5tsE9wdIb4seg3AUvRLkhu6PASSkQWsievq0/R3pLX5rA
	 cj3UJUQcppV1BCVa6jMs27zPDE25HWInmEhKUgFshX3WrZae9qpXCreNprqoCYaQ0/Cqa
	 +t7WNCf3K+beUqu5twSFID4169faBbLvyPIis5IUSPJrEICefytyLny+0eWZtNh1YZvSU
	 goM1IsoZGaZBLjr7b3U2n0ASKFrDmm7MZ0hvCpEyTtSR+pM6RXbQIvs0r7LuFg+JM+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=LHPvdrHM;
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45D60A2602;
	Sat, 24 Oct 2026 09:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B45D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=LHPvdrHM
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jBZJV51jXzNm0l;
	Sat, 24 Oct 2026 11:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1792833978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a50pjgeX2yGMJrP20mXnZ3fhZPuQ/Judh9U7PKVmU4=;
	b=LHPvdrHMYDkM9Dbx9Kjqh43hPIg6AmbU5WMEEQOr2Y7ommvBQgIWhCZ5fdX+FMDX+1pTOD
	JIUYuaco4E8LBqxGJB/+ygF2cD4txvbRIqFUi+JaV18a7LKCrakFdg+/bUTUWOhK/cq24+
	fC6UsTUjmQsmfp0VEf77SIMMgxDkpvLh1qQOMhYdNvSUDJDcYkVgV+9vh2J355r4YPuezg
	Bk+HrzrMo99lOogLlyp7DTXBiSH0GISuppW3tD1ieEgrwo21+6BSjagxIgyid8GGvlxp+b
	6Cvp4dac0HnlWPLJWWKXKv6riS+mBJilRRbXdyzN1Y30KCAsnjZnl7VFmv61fQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Xavier Hsinyuan <xavierhsinyuan@outlook.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 18/18] docs: networking: add ipxlat guide
Date: Sat, 24 Oct 2026 11:25:28 +0200
Message-ID: <20261024092532.172005-19-ralf@mandelbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024092532.172005-1-ralf@mandelbit.com>
References: <20261024092532.172005-1-ralf@mandelbit.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jBZJV51jXzNm0l

Document the route configuration model, address mapping, CLAT and
NAT64 examples, packet continuation, conntrack, fragmentation,
checksum handling and operational limitations.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since RFC v1 https://lore.kernel.org/netdev/20260319151230.655687-16-ralf@mandelbit.com/
- Rewrite the guide for the LWT route model and inline immutable
  configuration; remove netdevice, generic-netlink/YNL, device MTU, and
  device statistics documentation and the confusing receive-reinjection
  model. (Toke)
- Document EAM-before-RFC6052 endpoint conversion, both CLAT addressing
  models, and downstream source validation outside the engine.
  (Beniamino)
- Add end-to-end single-host CLAT, delegated-prefix CLAT, stateful NAT64,
  464XLAT, and SIIT border-router examples.
- Add short /96 examples which show both address-translation directions.
  (Xavier)
- Replace the broken v1 YNL example with iproute2 commands for LWT route
  configuration. (Xavier)
- Add the guide to Documentation/networking/index.rst. (Jonathan)
- Fix omitted route commands, inconsistent variable names, spelling, and
  RST problems in the v1 guide. (Sashiko)
- Document native fallback, family-switch continuation, conntrack/NAT,
  XFRM, TTL/Hop Limit, target-route fragmentation, checksumless UDP, and
  protocol handling.

 Documentation/networking/index.rst  |   1 +
 Documentation/networking/ipxlat.rst | 333 ++++++++++++++++++++++++++++
 net/ipxlat/Kconfig                  |   2 +
 3 files changed, 336 insertions(+)
 create mode 100644 Documentation/networking/ipxlat.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 44a422ad3b05..5f5e2aa61d3c 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -66,6 +66,7 @@ Contents:
    ipv6
    ipvlan
    ipvs-sysctl
+   ipxlat
    kcm
    l2tp
    lapb-module
diff --git a/Documentation/networking/ipxlat.rst b/Documentation/networking/ipxlat.rst
new file mode 100644
index 000000000000..50d5447e18b3
--- /dev/null
+++ b/Documentation/networking/ipxlat.rst
@@ -0,0 +1,333 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026- Mandelbit SRL
+.. Copyright (C) 2026- Daniel Gröber <dxld@darkboxed.org>
+.. Author: Antonio Quartulli <antonio@mandelbit.com>
+.. Author: Daniel Gröber <dxld@darkboxed.org>
+.. Author: Ralf Lici <ralf@mandelbit.com>
+
+======
+IPXLAT
+======
+
+ipxlat translates IPv4 packets into IPv6 packets and IPv6 packets into IPv4
+packets. It replaces the IP header, maps the source and destination addresses,
+updates transport checksums, and translates ICMP messages and quoted packets.
+It also handles the fragment and offload details needed to preserve the packet
+across the family change. This is a building block for establishing layer 3
+connectivity between otherwise uncommunicative IPv6-only and/or IPv4-only
+networks.
+
+The translation is stateless: the result is determined by the packet and the
+configured address mappings while transport ports are not translated. This
+implements the SIIT algorithm from RFC 7915, RFC 6052 address embedding, and
+optional RFC 7757 Explicit Address Mappings.
+
+The implementation consists of a reusable translation engine and a
+lightweight-tunnel (LWT) attachment. A route carrying the ``ipxlat``
+encapsulation selects packets for translation. The engine is controlled by
+``CONFIG_NET_IPXLAT`` and the LWT attachment by ``CONFIG_NET_IPXLAT_LWT``.
+
+The family before translation is referred to below as the original family and
+the family after translation as the translated family. Received packets enter
+the translated family's ``PRE_ROUTING`` hook and undergo a new route lookup.
+Locally originated packets enter the translated family's ``LOCAL_OUT`` path
+without carrying the original socket. Translated-family routing and XFRM
+therefore use the kernel-originated UID and global policy; socket, cgroup, and
+per-socket XFRM identity do not cross the family switch. If a selected packet
+is not supported by the translator, the LWT passes it back to the route's
+normal input or output path unchanged. Malformed packets and failures
+encountered during translation are dropped.
+
+Configuration
+=============
+
+Each route has one immutable configuration:
+
+* ``eam`` configures an optional RFC 7757 Explicit Address Mapping. It is
+  encoded as one element of the ``EAMT`` nested list, which accepts at most one
+  element. The EAM contains one canonical IPv4 prefix and one canonical IPv6
+  prefix. For an IPv4 prefix length ``M`` and an IPv6 prefix length ``N``, the
+  IPv6 prefix must have room for every IPv4 host bit::
+
+      128 - N >= 32 - M
+
+  Equivalently, ``N`` must be no greater than ``M + 96``. Equality gives both
+  prefixes the same number of host addresses. A shorter IPv6 prefix is also
+  accepted, but additional IPv6 host bits have no IPv4 representation and are
+  discarded during 6-to-4 translation. At most one EAM is supported per route,
+  and RFC 7757 hairpinning is not implemented.
+* ``rfc6052-prefix6`` is the required RFC 6052 fallback prefix. It is used for
+  every address which does not match the EAM, so it normally identifies the
+  far-side NAT64 service in a CLAT configuration. It must have length /32,
+  /40, /48, /56, /64, or /96. Non-canonical host bits are normalized in the
+  route state and in dumps, and the reserved octet at bits 64-71 must be zero.
+
+Each source and destination address is translated independently. If an address
+matches the EAM in its original family, the paired EAM prefix is used. An
+address which does not match the EAM is translated with ``rfc6052-prefix6``.
+This lets one configuration use an explicit mapping for the nearby IPv4 host
+or network while using an RFC 6052 prefix for remote IPv4 addresses. Without
+an EAM every endpoint uses the symmetric RFC 6052 mapping.
+
+There is one exception for ICMP errors. An IPv6 router can generate an ICMPv6
+error from an address outside both configured mappings. If the destination is
+translatable, the engine represents the source with the RFC 7600 dummy IPv4
+address ``192.0.0.8``. Before local output, the LWT attachment asks the IPv4
+route to select a real local source address. If routing cannot select one, it
+falls back to ``192.0.0.8`` and permits that reserved, unassigned source for
+this error only. This use of the dummy address for an untranslatable ICMPv6
+source is described by ``draft-ietf-v6ops-icmpext-xlat-v6only-source``. The
+dummy address is never used for an ordinary packet or for an untranslatable
+destination.
+
+ipxlat does not add the Node Identification ICMP extension proposed by that
+draft. Diagnostic tools may consequently show the selected IPv4 source, or
+``192.0.0.8`` when routing cannot select one, instead of the IPv6 address of
+the router which generated the error.
+
+ipxlat validates the address format but leaves prefix selection to the
+operator. RFC 6052 restricts the well-known prefix ``64:ff9b::/96`` to global
+IPv4 addresses. Local-use deployments can use ``64:ff9b:1::/48`` or a
+more-specific prefix as described by RFC 8215, or use a network-specific
+prefix. The examples below use documentation addresses only.
+
+The companion iproute2 support uses the following grammar (the kernel UAPI is
+in ``include/uapi/linux/ipxlat.h``)::
+
+    encap ipxlat rfc6052-prefix6 PREFIX/LEN
+        [eam IPV4_PREFIX/LEN IPV6_PREFIX/LEN]
+
+The encapsulation can be carried directly by a route or by the normal multipath
+and nexthop-object forms supported by LWT.
+
+The ``dev`` parameter belongs to the original-family selecting route. After
+translation, a new lookup in the translated family chooses the next hop and
+egress interface. The selected output may therefore use a different interface.
+
+CLAT control plane
+==================
+
+ipxlat only performs packet translation. A network manager must discover or
+configure the NAT64 prefix, choose the CLAT addresses, and install and remove
+the corresponding addresses, rules, and routes. The NAT64 prefix is commonly
+learned from the PREF64 option in an IPv6 Router Advertisement as specified by
+RFC 8781. RFC 7050 DNS discovery is another possible source.
+
+Each IPv6-only interface needs its own CLAT configuration and IPv4 routing
+policy. Userspace must keep the chosen NAT64 prefix, dedicated CLAT IPv6
+address, and IPv6 route on the same network attachment. It also decides whether
+to disable or deprioritize CLAT when native IPv4 connectivity becomes
+available. None of this policy is inferred by the kernel attachment.
+
+Single-host CLAT
+================
+
+The example below gives a host the CLAT IPv4 address ``192.0.0.2`` on an
+IPv6-only network. ``wan0`` is the upstream interface,
+``2001:db8:100::2`` is an additional IPv6 address used only by this CLAT
+instance, and ``64:ff9b::/96`` is the prefix used by the far-side NAT64
+service::
+
+    ip addr replace 192.0.0.2/32 dev lo
+    ip -6 addr replace 2001:db8:100::2/128 dev wan0 noprefixroute
+
+    ip rule add priority 10000 from 192.0.0.2/32 lookup 464
+    ip route replace default table 464 dev wan0 \
+        encap ipxlat rfc6052-prefix6 64:ff9b::/96 \
+        eam 192.0.0.2/32 2001:db8:100::2/128 \
+        src 192.0.0.2
+
+The CLAT IPv4 address is placed on ``lo`` because it identifies the local
+translator rather than an IPv4 neighbor on the IPv6-only link. It may instead
+be assigned as a /32 to ``wan0``. This is a deployment choice, not an ipxlat
+requirement.
+
+Within one routing domain, use a distinct /32 from the ``192.0.0.0/29`` range
+for each active CLAT. This range is reserved for IPv4 continuity mechanisms,
+and traffic sourced from it should always be sent through translation rather
+than native IPv4 routing.
+
+The IPv6 address must be distinct from addresses used by applications for
+native IPv6 connections. It is nevertheless an ordinary address from the IPv6
+network's point of view: userspace must perform Duplicate Address Detection and
+the host must answer normal Neighbor Solicitations for it. Keeping the address
+out of ordinary native IPv6 source-address selection is also a userspace
+responsibility.
+
+For an outgoing packet, the EAM translates the local source
+``192.0.0.2`` into ``2001:db8:100::2``. A remote IPv4 destination does not
+match that EAM, so it is embedded in ``64:ff9b::/96``. A reply applies the
+same rules in reverse: its source is extracted from ``64:ff9b::/96`` and its
+destination is translated by the EAM back to ``192.0.0.2``. Both mappings are
+therefore needed for this configuration.
+
+The well-known prefix ``64:ff9b::/96`` is only correct when it is also used by
+the upstream NAT64 service. A network-specific NAT64 prefix must be configured
+explicitly instead.
+
+Address assignment creates a metric-zero local-table route even with
+``noprefixroute``. That route would take precedence over a separately added
+route, so remove it before installing the translated-family local route
+carrying the same configuration::
+
+    ip -6 route del local 2001:db8:100::2/128 table local
+    ip -6 route add local 2001:db8:100::2/128 table local dev wan0 \
+        encap ipxlat rfc6052-prefix6 64:ff9b::/96 \
+        eam 192.0.0.2/32 2001:db8:100::2/128
+
+The configuration is stored independently in the outgoing IPv4 route and the
+return IPv6 local route. When the CLAT address changes, a network manager must
+update both attachments. It should first add the new address and its translated
+local route, then switch the outgoing route, and finally remove the old route
+and address. This avoids a complete connectivity gap while changing addresses.
+
+The address subsystem does not own the manually installed LWT local route. A
+network manager must therefore remove that route when removing the address. If
+translation is disabled while the IPv6 address remains assigned, it must
+replace the LWT route with an ordinary local route so native IPv6 traffic can
+still reach the host.
+
+Delegated-prefix CLAT
+=====================
+
+For IPv4 clients on ``lan0`` and an IPv6 uplink on ``wan0``, reserve
+``2001:db8:200::/96`` inside a prefix delegated to the CLAT. The EAM below
+pairs the downstream ``192.0.2.0/24`` with
+``2001:db8:200::c000:200/120``. Both prefixes have eight host bits, and the
+IPv6 form was chosen by embedding ``192.0.2.0`` in the reserved /96::
+
+    ip rule add priority 9000 iif lan0 from 192.0.2.0/24 lookup 464
+    ip route replace default table 464 dev wan0 \
+        encap ipxlat rfc6052-prefix6 64:ff9b::/96 \
+        eam 192.0.2.0/24 2001:db8:200::c000:200/120
+
+The rule sends only IPv4 packets received from the downstream network, with a
+source inside its assigned range, to the translating default route. For
+example, a packet from ``192.0.2.37`` to ``203.0.113.9`` leaves the CLAT with
+these addresses::
+
+    2001:db8:200::c000:225 -> 64:ff9b::cb00:7109
+
+The source used the EAM while the remote destination used the far-side NAT64
+prefix. The delegated prefix must be routed to the CLAT by its upstream
+network.
+
+If downstream source validation is required, enforce it on ``lan0`` with the
+normal routing or firewall facilities. ipxlat deliberately does not decide
+which IPv4 sources are authorized.
+
+The return direction needs an IPv6 selecting route for the EAM prefix carrying
+the same configuration::
+
+    ip -6 route replace 2001:db8:200::c000:200/120 dev lan0 \
+        encap ipxlat rfc6052-prefix6 64:ff9b::/96 \
+        eam 192.0.2.0/24 2001:db8:200::c000:200/120
+
+A reply maps the two endpoints in reverse. The new IPv4 route lookup then
+sends the packet to ``192.0.2.37`` through ``lan0``.
+
+When DHCPv6-PD renumbers the delegated prefix, userspace must update the EAM
+and both selecting routes. The make-before-break ordering described for the
+single-host case also applies here.
+
+Stateful NAT64 and 464XLAT
+==========================
+
+ipxlat can provide the stateless part of a PLAT while ordinary IPv4 conntrack
+and NAT provide the stateful part. In this example ``lan6`` connects an IPv6
+client network, ``wan4`` has normal IPv4 Internet connectivity,
+``64:ff9b::/96`` is the advertised NAT64 prefix, and the EAM gives clients in
+``2001:db8:300::/120`` intermediate IPv4 identities from ``192.0.2.0/24``::
+
+    sysctl -w net.ipv4.ip_forward=1
+    sysctl -w net.ipv6.conf.all.forwarding=1
+
+    ip -6 route replace 64:ff9b::/96 dev wan4 \
+        encap ipxlat rfc6052-prefix6 64:ff9b::/96 \
+        eam 192.0.2.0/24 2001:db8:300::/120
+
+    ip route replace 192.0.2.0/24 dev lan6 \
+        encap ipxlat rfc6052-prefix6 64:ff9b::/96 \
+        eam 192.0.2.0/24 2001:db8:300::/120
+
+After 6-to-4 translation, the packet enters the normal IPv4 forwarding path.
+The intermediate IPv4 source can then be translated to the public address on
+``wan4``::
+
+    nft -f - <<'EOF'
+    table ip ipxlat_nat64 {
+        chain postrouting {
+            type nat hook postrouting priority srcnat; policy accept;
+            oifname "wan4" ip saddr 192.0.2.0/24 masquerade
+        }
+    }
+    EOF
+
+IPv4 conntrack reverses the NAT on replies before routing. The resulting
+destination in ``192.0.2.0/24`` selects the return ipxlat route, and the new
+IPv6 route lookup sends the translated packet to ``lan6``. No conntrack entry
+is carried across either family change.
+
+Putting one of the CLAT configurations above in front of this PLAT forms a
+complete 464XLAT path. The CLAT's near-side IPv6 mapping must fall within an
+IPv6 EAM configured by the PLAT.
+
+SIIT border router
+==================
+
+Pure stateless SIIT needs one selecting route in each direction: the IPv6
+mapping prefix for 6-to-4 and the corresponding IPv4 range for 4-to-6. The
+routes carry the translation configuration, while the translated-family route
+lookups choose the next hops. Conntrack and NAT are not required.
+
+Packet handling
+===============
+
+Translation itself does not decrement TTL or Hop Limit. Forwarded packets lose
+one hop in the normal translated-family forwarding path. Locally originated
+or locally terminated traffic is not forwarded, so translation does not
+decrement its TTL or Hop Limit.
+
+No conntrack object crosses the family switch. Metadata associated with the
+original family is discarded before the packet enters translated-family
+hooks. Ordinary translated-side conntrack and NAT can then be used, for
+example on the IPv4 side of a NAT64 sandwich.
+
+IPv4 packets with DF clear are translated first and may then be fragmented by
+IPv6 output using the translated route PMTU. IPv4 packets which were already
+fragments can be fragmented again while preserving their translated fragment
+identity. DF packets cannot be fragmented and use normal Packet Too Big
+feedback.
+
+If Packet Too Big feedback is lost on a known path, configure an MTU metric on
+the translated-family route. It acts as an administrative ceiling while still
+allowing PMTU discovery to learn a smaller value::
+
+    ip -6 route replace 64:ff9b::/96 via 2001:db8::1 dev wan0 mtu 1280
+
+A CLAT can also advertise a smaller IPv4 MTU to downstream clients, for
+example with the DHCP interface-MTU option. TCP MSS clamping is another
+possible operational workaround.
+
+IPv4 permits a UDP checksum of zero while ordinary IPv6 UDP does not. ipxlat
+accepts an unfragmented zero-checksum IPv4 UDP datagram and computes the
+checksum required by IPv6. An ICMP, ICMPv6, or zero-checksum UDPv4 datagram
+must be reassembled before translation if it is fragmented because generating
+the translated checksum requires the complete datagram.
+
+Protocol handling
+=================
+
+TCP, UDP, and ICMP receive the protocol-specific checksum handling required by
+translation. Other upper-layer protocol numbers are preserved and their
+payload is left unchanged. Such protocols work only when their own semantics
+remain valid across the family and address change. A checksum-neutral address
+mapping can help protocols that use an IP pseudo-header but are not understood
+by ipxlat. An AH-protected packet cannot remain valid across translation
+because AH authenticates IP-header fields changed by ipxlat.
+
+IPv4 options are not copied to IPv6. An active IPv4 source route is rejected.
+IPv6 Hop-by-Hop Options, Destination Options, and inactive Routing Headers are
+skipped rather than represented in IPv4, while an active Routing Header is
+rejected. The IPv6 Fragment Header is translated; an extension header after a
+Fragment Header is not supported.
diff --git a/net/ipxlat/Kconfig b/net/ipxlat/Kconfig
index b73a443eef0f..16c9e334e678 100644
--- a/net/ipxlat/Kconfig
+++ b/net/ipxlat/Kconfig
@@ -11,6 +11,8 @@ config NET_IPXLAT
 	  RFC 7915. Useful for IPv6 focused networks. Particularly NAT64,
 	  SIIT-DC, 464XLAT network architectures.
 
+	  See also <file:Documentation/networking/ipxlat.rst>.
+
 	  To compile this engine as a module, choose M here.
 
 config NET_IPXLAT_LWT
-- 
2.55.0

