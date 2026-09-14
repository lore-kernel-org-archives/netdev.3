Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002C35674E
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369144; cv=none; b=HGdBWJusgqmNfECBN7kYk9mem+J72+TqDKwmTtBvfO83Lh8QcZk0nL1/SmOYwZ8U4T7d4ynsb3LJMrLZD9tNszfRZIzS7myqrq8+gUeulPUSWGaAa2A9shSlv+nFe/yqUyqPl8uDUNE1eFHq2Lw0fPCGHG3QPbkM7hWxD8Thzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369144; c=relaxed/simple;
	bh=8Akt6V5469Cf7XdAtWoyY6TJ8I+8xcTW16lBErWmcPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJy5MaGa6iqKpoXO064mvGHSyVcrYQeZr47+72v0SgLhiUoyAjKgMelnxlgNEs0n34XLpekG7qBWS8sNxSWFbz7/LY/Dg1+K48b4i/X+pUeuRTwpk55GSlNQWwP7UNfAFta+I8KKNNCX8QwgLDjd6hIG6lonqaAu+JJEMYhP/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Rp6WjLas; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EY3a0cIy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Rp6WjLas";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EY3a0cIy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6479F1F78C;
	Mon, 14 Sep 2026 06:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789369136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eg4nkBrGz3L6zV4gKcYdJcm7rsYYuRw7RnqxYKCGXI8=;
	b=Rp6WjLasQMaO27eB0aFrFIzsMbn3Za45s+GTMCiJKxiOQ2zwasDc6654FSXSnzb7s1zWH8
	+3H5ct05N7EpamayELEjakAe9yCniyBrUDaDo2voAppuKutJv1r4l2e2P1dvRCIIH0WKJI
	GBepIU0qKYR3fSkOh0IcirFsaS0Pgdw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789369132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eg4nkBrGz3L6zV4gKcYdJcm7rsYYuRw7RnqxYKCGXI8=;
	b=EY3a0cIyf0ScoOkcGpoZE/8A0+XguboGCZ5A5q4Gw33b7FMCvx2hNkNCpoBJDgtOTY42jm
	usAaShE9RGcGiSxUj68MOhnEUw60oIMgftL716MezSWVQGpCqpiShVUmjjLIYhSXfyzxvJ
	N+/1fqesJrhwtwdBT2g1D//I8BL7FP8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32ED01368C;
	Mon, 14 Sep 2026 06:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iw+7BSybp2qhLAAAD6G6ig
	(envelope-from <martin.jaburek@suse.com>); Mon, 14 Sep 2026 06:58:52 +0000
From: =?UTF-8?q?Martin=20Jab=C5=AFrek?= <martin.jaburek@suse.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	=?UTF-8?q?Martin=20Jab=C5=AFrek?= <martin.jaburek@suse.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next v3] selftests: net: add IPv4 and IPv6 address order check
Date: Mon, 14 Sep 2026 08:58:48 +0200
Message-ID: <20260914065848.10518-1-martin.jaburek@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]

Introduce the following new tests: `ipv4_verify_same_scope_addr_order`,
`ipv4_verify_inter_scope_addr_order`, `ipv6_verify_same_scope_addr_order`,
`ipv6_verify_inter_scope_addr_order` to check the ordering of a
set of IP addresses after being inserted.

The implementations of these protocols are inconsistent
in regard to address ordering. IPv4 addresses stay in the
same order as inserted while IPv6 addresses appear in
reverse order. This inconsistency has prompted attempts
to unify the ordering, so both protocols act the same
(as IPv4). This however caused user-space regressions in
certain applications, which relied on the order as it
was prior to the change (particularly NetworkManager).
A similar inconsistency occurs when inserting different
scope addresses, where IPv4 puts link local ones before global
and IPv6 does the opposite. Attempts were already made
to unify this also, risking further regressions.

The addition of these tests aims to consolidate current
behaviour to prevent regressions in the future.
The expected behaviour is the initial one, where each
protocol acts differently. The same goes for inter scope
addresses.

Conversations detailing the decision processes for creating
these tests are linked below.

Link: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
Link: https://lore.kernel.org/netdev/20260529112357.5079-1-fmancera@suse.de/
Link: https://lore.kernel.org/netdev/20260721090114.GA2510713@shredder/
Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Martin Jabůrek <martin.jaburek@suse.com>
---
v3: added more test cases, corrected tests which would pass for
incorrect behaviour, removed unnecessary command to set dummy device "up",
no longer use scope parameter in IPv6 helper, now use actual link-local
addresses for IPv6, refactor comments and variable names
---
 tools/testing/selftests/net/rtnetlink.py | 113 ++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index 5cc3ebdcf08d..dc8c77db4897 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -314,11 +314,122 @@ def ipv6_route_del_reason_absent() -> None:
                         "user deletion must not carry del-reason")
 
 
+def _insert_and_get_addrs_ipv4(test_addrs: list[str], scopes: list[str]) -> list[str]:
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        dev_name = "dummy_dev"
+
+        ip(f"link add name {dev_name} type dummy", ns=str(ns))
+        for test_addr, scope in zip(test_addrs, scopes):
+            ip(f"address add {test_addr}/24 dev {dev_name} scope {scope}", ns=str(ns))
+
+        rtnl = RtnlAddrFamily()
+        addrs = rtnl.getaddr({"ifa-family": socket.AF_INET}, dump=True)
+        return [addr["address"] for addr in addrs]
+
+
+def ipv4_verify_same_scope_addr_order() -> None:
+    """
+    After inserting multiple same scope IPv4 addresses, their order
+    must be the same as the insertion order. The only aspect affecting
+    this are primary addresses, which precede secondary ones.
+    """
+
+    primary_first = ["192.0.2.1", "203.0.113.1", "192.0.2.2", "203.0.113.2"]
+    scopes = ["global"] * 4
+    expected_result = primary_first
+    resulting_list = _insert_and_get_addrs_ipv4(primary_first, scopes)
+    ksft_eq(resulting_list, expected_result, "Unexpected IPv4 address order")
+
+    subnet_first = ["192.0.2.1", "192.0.2.2", "203.0.113.1", "203.0.113.2"]
+    # Scope and expected result stay the same.
+    resulting_list = _insert_and_get_addrs_ipv4(subnet_first, scopes)
+    ksft_eq(resulting_list, expected_result, "Unexpected IPv4 address order")
+
+
+def ipv4_verify_inter_scope_addr_order() -> None:
+    """
+    When IPv4 addresses from different scopes are inserted,
+    primary link local addresses must precede global ones.
+
+    Address ordering across different scopes has also
+    been attempted to be patched, bringing in a new risk of a user-space
+    regression, similar to the same scope equivalent. This will further
+    consolidate the implementation differences of both protocols.
+    """
+
+    test_addrs = ["192.0.2.1", "203.0.113.1", "192.0.2.2", "203.0.113.2"]
+
+    link_first = ["link", "global", "link", "global"]
+    expected_result = test_addrs
+    resulting_list = _insert_and_get_addrs_ipv4(test_addrs, link_first)
+    ksft_eq(resulting_list, expected_result, "Unexpected IPv4 address order across scopes")
+
+    global_first = ["global", "link", "global", "link"]
+    expected_result = ["203.0.113.1", "192.0.2.1", "192.0.2.2", "203.0.113.2"]
+    resulting_list = _insert_and_get_addrs_ipv4(test_addrs, global_first)
+    ksft_eq(resulting_list, expected_result, "Unexpected IPv4 address order across scopes")
+
+
+def _insert_and_get_addrs_ipv6(test_addrs: list[str]) -> list[str]:
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        dev_name = "dummy_dev"
+
+        ip(f"link add name {dev_name} type dummy", ns=str(ns))
+        for test_addr in test_addrs:
+            ip(f"address add {test_addr}/64 dev {dev_name}", ns=str(ns))
+
+        rtnl = RtnlAddrFamily()
+        addrs = rtnl.getaddr({"ifa-family": socket.AF_INET6}, dump=True)
+        return [addr["address"] for addr in addrs]
+
+
+def ipv6_verify_same_scope_addr_order() -> None:
+    """
+    After inserting multiple same scope IPv6 addresses, their order
+    must be the _reverse_ of the insertion order.
+
+    While this behaviour is different from how IPv4 acts,
+    updating the IPv6 implementation to act the same way
+    has proved to cause user-space application regressions
+    (particularly in NetworkManager). This behaviour is being
+    tested to consolidate it as being expected and correct.
+    """
+
+    addr_list = ["2001:db8::1", "2001:db8::2", "2001:db8::3"]
+    expected_result = addr_list[::-1]
+    resulting_list = _insert_and_get_addrs_ipv6(addr_list)
+    ksft_eq(resulting_list, expected_result, "Unexpected IPv6 address order")
+
+
+def ipv6_verify_inter_scope_addr_order() -> None:
+    """
+    Inserted IPv6 addresses from different scopes must have
+    global primary address precede link local ones. This again
+    is the _reverse_ of how IPv4 addresses are ordered.
+
+    To prevent potential user-space regressions with IPv6
+    addresses, the inter-scope insertion order is also being tested.
+    """
+
+    global_first = ["2001:db8::1", "fe80::1", "2001:db8::2", "fe80::2"]
+    # Not only must the global addresses be first, but their insertion order must be reversed.
+    expected_result = ["2001:db8::2", "2001:db8::1", "fe80::2", "fe80::1"]
+    resulting_list = _insert_and_get_addrs_ipv6(global_first)
+    ksft_eq(resulting_list, expected_result, "Unexpected IPv6 address order across scopes")
+
+    link_first = ["fe80::1", "2001:db8::1", "fe80::2", "2001:db8::2"]
+    # Expected result stays the same.
+    resulting_list = _insert_and_get_addrs_ipv6(link_first)
+    ksft_eq(resulting_list, expected_result, "Unexpected IPv6 address order across scopes")
+
+
 def main() -> None:
     ksft_run([dump_mcaddr_check, dump_mcaddr6_check, ipv4_devconf_notify,
               ipv6_route_del_reason_expired,
               ipv6_route_del_reason_ra_withdrawn,
-              ipv6_route_del_reason_absent])
+              ipv6_route_del_reason_absent,
+              ipv4_verify_same_scope_addr_order, ipv4_verify_inter_scope_addr_order,
+              ipv6_verify_same_scope_addr_order, ipv6_verify_inter_scope_addr_order])
     ksft_exit()
 
 if __name__ == "__main__":
-- 
2.55.0

