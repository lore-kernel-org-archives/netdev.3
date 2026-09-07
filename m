Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD004CA76E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785870; cv=none; b=qKElzi4bt/rPpicbHyBsjbTN2Ca0oGSZlB8P0ZnpahUJ0qQ1Qo4kltwns0EV4o6IYj+vwh42Mu4W4EiKlZXDpQstBoRWI3m32Ngc1ygbbn5/sAn87Wv0zO1m9FQON/POwJDCaF3mWA+tV/mWv9KYKBvewCruLsrqq4pjRs8o0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785870; c=relaxed/simple;
	bh=EEa5Zi9LqTTBtv+k4iS/Z6wcC+7GSoaaTpvJcBZVW74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GyecHN0TAkdZmUH1/Zlq2l/UfPBjzWX9N0F7mTw4AduTcuYXSuRqKfMPEq9HkDQ30uStnOg7umJBW1DDMbpq5l+gRzgeGSteLHz2lgM85yHpDvNSmnsCC3GXibrXcLqwLXM3iHIkmlaB2FarMOVLOtmKepSA9yU0ujrapP36yFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SJLGC5qf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X4qAgUmP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SJLGC5qf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X4qAgUmP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B43E1F78D;
	Mon,  7 Sep 2026 12:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788785854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0QT+LAkmdk5EzUCxU/xLcEaUjtu1mg3JSlcK6WoskWY=;
	b=SJLGC5qfLdfEYxmdYkP3eZfp5ykno6641a1vSt0wmkKOYnyEEI38xBn+uWqh5HYZqrZRtv
	fqcLc8z2d+RFHyNqZ8okp5QxlgOuVr4ejVSNNE3V1ykKa2fAvS/kteUc74mHSCyy/JPsF/
	K/cH/kbbw5avfak5cG5SL/hPuRIgqJI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788785850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0QT+LAkmdk5EzUCxU/xLcEaUjtu1mg3JSlcK6WoskWY=;
	b=X4qAgUmPn5EUs7WEJeTyGqiL44Z9t9jcnA5cMchcCQYabGO3GJJ7x3oGYHxf7KIPlwrWJE
	xmKB9/EK8KCF+Qll8ZYhkVRy6ob5fzTSojKaU8XglYUf0OvolyuPUCDgZItJNnrBWhTDa4
	uQg12eEEllm09ThVXgNQNyd4X4UgPfY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E0851339B;
	Mon,  7 Sep 2026 12:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3+XYDrq0nmp/SwAAD6G6ig
	(envelope-from <martin.jaburek@suse.com>); Mon, 07 Sep 2026 12:57:30 +0000
From: =?UTF-8?q?Martin=20Jab=C5=AFrek?= <martin.jaburek@suse.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuba@kernel.org,
	=?UTF-8?q?Martin=20Jab=C5=AFrek?= <martin.jaburek@suse.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next v2] selftests: net: add IPv4 and IPv6 address order check
Date: Mon,  7 Sep 2026 14:57:22 +0200
Message-ID: <20260907125722.9473-1-martin.jaburek@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO

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
v2: added tests for inter-scope addresses, created helper functions,
fixed linter errors for new code
---
 tools/testing/selftests/net/rtnetlink.py | 115 ++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index 5cc3ebdcf08d..5605be411f1a 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -314,11 +314,124 @@ def ipv6_route_del_reason_absent() -> None:
                         "user deletion must not carry del-reason")
 
 
+def _insert_and_get_addrs_ipv4(test_addrs: list[str], scopes: list[str]) -> list[str]:
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        dev_name = "dummy_dev"
+
+        ip(f"link add name {dev_name} type dummy", ns=str(ns))
+        for test_addr, scope in zip(test_addrs, scopes):
+            ip(f"address add {test_addr}/24 dev {dev_name} scope {scope}", ns=str(ns))
+        ip(f"link set dev {dev_name} up", ns=str(ns))
+
+        rtnl = RtnlAddrFamily()
+        addrs = rtnl.getaddr({"ifa-family": socket.AF_INET}, dump=True)
+        return [addr["address"] for addr in addrs]
+
+
+def ipv4_verify_same_scope_addr_order() -> None:
+    """
+    After inserting multiple same scope IPv4 addresses, their order
+    must be the same as the insertion order.
+    """
+
+    # Primary addresses of test subnets are inserted first.
+    test_addresses = [
+        "192.0.2.1", "203.0.113.1",
+        "192.0.2.2", "203.0.113.2", "192.0.2.3"
+    ]
+    scopes = ["global"] * 5
+
+    address_list = _insert_and_get_addrs_ipv4(test_addresses, scopes)
+    ksft_eq(test_addresses, address_list, "Unexpected IPv4 address order")
+
+
+def ipv4_verify_inter_scope_addr_order() -> None:
+    """
+    Checks the ordering of inter-scope addresses. This has also
+    been attempted to be patched, bringing in a new risk of a user-space
+    regression, similar to the same scope equivalent. This will further
+    consolidate the implementation differences of both protocols.
+    """
+
+    test_addresses = [
+        "192.0.2.1", "203.0.113.1",
+        "192.0.2.2", "203.0.113.2", "192.0.2.3"
+    ]
+    # IPv4 puts link local addresses before global ones.
+    scopes = [
+        "link", "global",
+        "link", "global", "link"
+    ]
+
+    address_list = _insert_and_get_addrs_ipv4(test_addresses, scopes)
+    ksft_eq(test_addresses, address_list, "Unexpected IPv4 address order across scopes")
+
+
+def _insert_and_get_addrs_ipv6(test_addrs: list[str], scopes: list[str]) -> list[str]:
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        dev_name = "dummy_dev"
+
+        ip(f"link add name {dev_name} type dummy", ns=str(ns))
+        for test_addr, scope in zip(test_addrs, scopes):
+            ip(f"address add {test_addr}/64 dev {dev_name} scope {scope}", ns=str(ns))
+        ip(f"link set dev {dev_name} up", ns=str(ns))
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
+    tested for to consolidate it as being expected and correct.
+    """
+
+    test_addresses = [
+        "2001:db8:a::1", "2001:db8:b::1",
+        "2001:db8:a::2", "2001:db8:b::2", "2001:db8:a::3"
+    ]
+    scopes = ["global"] * 5
+
+    address_list = _insert_and_get_addrs_ipv6(test_addresses, scopes)
+    # We ignore the link-local address present by default.
+    ksft_eq(test_addresses[::-1], address_list[:5], "Unexpected IPv6 address order")
+
+
+def ipv6_verify_inter_scope_addr_order() -> None:
+    """
+    To prevent potential user-space regressions with IPv6
+    addresses, the inter-scope insertion order is also being tested.
+
+    This again differs from IPv4, here global scope addresses have priority
+    against link local ones - the behaviours are opposite.
+    """
+    test_addresses = [
+        "2001:db8:a::1", "2001:db8:b::1",
+        "2001:db8:a::2", "2001:db8:b::2", "2001:db8:a::3"
+    ]
+    scopes = [
+        "global", "link",
+        "global", "link", "global"
+    ]
+
+    address_list = _insert_and_get_addrs_ipv6(test_addresses, scopes)
+    ksft_eq(test_addresses[::-1], address_list[:5], "Unexpected IPv6 address order across scopes")
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

