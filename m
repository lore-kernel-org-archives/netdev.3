Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542C471D10
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250952; cv=none; b=Es9aGEzN97dSQxDCPFTIoY+Z5oMxcPxZhNm+E1n/PfGGKHheqbkF8IJODhxgrjYrAR3eXMOD12HdD+2KAt3QhZA4QuHu1YXwSM5PAGKNDqRdhf7pVPvF5d6j5b/IV/MCbi0u2vcUUcPmho/ojP3j24imnLEOJn5ZEDicBeVVdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250952; c=relaxed/simple;
	bh=tPt/FyQcW+i5RLBQdus/kxnmAsoRq32J/jJLjz3EYDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5ljCORrCetTRf2/MuAQe29r95qHif+AviBlNEh1Brsd5swH1qxW/pY1XjflrOqhItto0EKpKJ0Bx91/SHVGM41vczKBxRHDqFGX58yQsY6LWeABHAT9ddr2p/Ic2bvBdR52igSE6WpleJVrLEJCZNJi8VtMQpGtVjOv6BrNypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VUgKaIuZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UdlhFetD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VUgKaIuZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UdlhFetD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 260B71FDB4;
	Tue,  1 Sep 2026 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788250945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vcsk5ckCyNuHPT28pnPTUIk/YOQEZ/SQrIyW/V9QAzw=;
	b=VUgKaIuZHWpbGOS1XJZcs0Ya077Bh6WcmrKuOo10P3tOcsBovlfJVe3lRMdCmJkb+lA6Uv
	gkFFD4ZSqnQR2sBh2w7WxN1id9tdQPFJszFQ2QwqX2BxVbJ5M4JgGrtFmagB3vfm03847F
	JzA369MsAi65beT5J4Lk3sRhG2HhzVI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1788250941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vcsk5ckCyNuHPT28pnPTUIk/YOQEZ/SQrIyW/V9QAzw=;
	b=UdlhFetDE8jHkExVoMJfr2K6PcdEg3V3IP1/Bj8vKHFSh/CoMtHwQ5NcuQMQzWNAYKA8Vy
	NL5hmNCegSuXqhKrk6Axkqr5ZE7SwDY+ERLyHRmrV4FQlid2ZpbJQ/OFEfS99WaHD7AjWb
	9BVmbjtqlmsjVRVBHW5pYIgjr/pf8K8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECC8E13515;
	Tue,  1 Sep 2026 08:22:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOZ6OTyLlmrLfQAAD6G6ig
	(envelope-from <martin.jaburek@suse.com>); Tue, 01 Sep 2026 08:22:20 +0000
From: =?UTF-8?q?Martin=20Jab=C5=AFrek?= <martin.jaburek@suse.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	=?UTF-8?q?Martin=20Jab=C5=AFrek?= <martin.jaburek@suse.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next] selftests: net: add IPv4 and IPv6 same scope address order check
Date: Tue,  1 Sep 2026 10:22:00 +0200
Message-ID: <20260901082200.15570-1-martin.jaburek@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

Introduce two new tests `ipv4_verify_addr_order` and
`ipv6_verify_addr_order`, to check the ordering of
a set of IP addresses after insertion.

The implementations of these protocols are inconsistent
in regard to address ordering. IPv4 addresses stay in the
same order as inserted while IPv6 addresses appear in
reverse order. This incosistency has prompted attempts
to unify the ordering, so both protocols act the same
(as IPv4). This however caused user-space regressions in
certain applications, which relied on the order as it
was prior to the change (particularly NetworkManager).

The addition of these tests aims to consolidate the
behaviour to prevent regressions in the future.
The expected behaviour is the initial one, where each
protocol acts differently.

Tests were verified on a recent commit with the expected
behaviour (61eb236c41c2) and a commit making both protocols
act the same way (cb3de96eea66). Tests respectively pass
and not pass as expected.

Conversations detailing the decision process for creating
these tests are linked below.

Link: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
Link: https://lore.kernel.org/netdev/20260529112357.5079-1-fmancera@suse.de/
Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Martin Jabůrek <martin.jaburek@suse.com>
---
 tools/testing/selftests/net/rtnetlink.py | 58 +++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selftests/net/rtnetlink.py
index 5cc3ebdcf08d..1ee604e4e5f6 100755
--- a/tools/testing/selftests/net/rtnetlink.py
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -314,11 +314,67 @@ def ipv6_route_del_reason_absent() -> None:
                         "user deletion must not carry del-reason")
 
 
+def ipv4_verify_addr_order() -> None:
+    """
+    After inserting multiple same scope IPv4 addresses, their order
+    must be the same as the insertion order.
+
+    See function ipv6_verify_addr_order in this file for further details.
+    """
+
+    DEV_NAME = "dummy_dev"
+    TEST_ADDRESSES = ["192.0.2.1", "192.0.2.2", "192.0.2.3"]
+
+    with NetNS() as ns:
+        with NetNSEnter(str(ns)):
+            ip(f"link add name {DEV_NAME} type dummy", ns=str(ns))
+            for addr in TEST_ADDRESSES:
+                ip(f"address add {addr}/24 dev {DEV_NAME}", ns=str(ns))
+            ip(f"link set dev {DEV_NAME} up", ns=str(ns))
+
+            rtnl = RtnlAddrFamily()
+            addrs = rtnl.getaddr({"ifa-family": socket.AF_INET}, dump=True)
+            address_list = [addr["address"] for addr in addrs]
+
+            ksft_eq(TEST_ADDRESSES, address_list, "Incorrect IPv4 address order")
+
+
+def ipv6_verify_addr_order() -> None:
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
+    DEV_NAME = "dummy_dev"
+    TEST_ADDRESSES = ["2001:db8::1", "2001:db8::2", "2001:db8::3"]
+
+    with NetNS() as ns:
+        with NetNSEnter(str(ns)):
+            ip(f"link add name {DEV_NAME} type dummy", ns=str(ns))
+            for addr in TEST_ADDRESSES:
+                ip(f"address add {addr}/32 dev {DEV_NAME}", ns=str(ns))
+            ip(f"link set dev {DEV_NAME} up", ns=str(ns))
+
+            rtnl = RtnlAddrFamily()
+            addrs = rtnl.getaddr({"ifa-family": socket.AF_INET6}, dump=True)
+            address_list = [addr["address"] for addr in addrs]
+
+            # We ignore the link-local address present by default.
+            ksft_eq(TEST_ADDRESSES[::-1], address_list[:3], "Incorrect IPv6 address order")
+
+
 def main() -> None:
     ksft_run([dump_mcaddr_check, dump_mcaddr6_check, ipv4_devconf_notify,
               ipv6_route_del_reason_expired,
               ipv6_route_del_reason_ra_withdrawn,
-              ipv6_route_del_reason_absent])
+              ipv6_route_del_reason_absent,
+              ipv4_verify_addr_order, ipv6_verify_addr_order])
     ksft_exit()
 
 if __name__ == "__main__":
-- 
2.55.0

