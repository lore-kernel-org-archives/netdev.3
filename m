Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917237F8D7
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789256623; cv=none; b=tbzDVAEc63PXUua6tD5QRQkyQRxt0/3JlTz2zle9qQ5g3YluWyP6onVvDA0AQqrAj8aAB+TqWqNpuSU5+5RJ8HbA9XlI8oQfFo5e/+0OwI16htiEPrHZlugwpjlpix1VVr8fHlvQdQdZ/M3UByIFjeL1iJtFTSWJXjTCgUO5MXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789256623; c=relaxed/simple;
	bh=LrHXRFYSe0aYGDj4jlu/Flt9518+74agOYlM3OCS8Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKMg+bqN4oqs3ut/ehWVTPTZqFGl690NMKAh0xu3aCZ4hz0qrbzfDVFxJ+1ZsC4gyPY9U4NELTTtYSeJmoyRXXZDBhxzhHzqc8SaF2zucWYUPLFbG5L/IfuH9i6uuHN6fi8JXhgzHwOMGhiSHmliXrHgWJacsZR0ffvv2YJ8ULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYYr0Eay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYYr0Eay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DAE1F000FF;
	Sat, 12 Sep 2026 23:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789256622;
	bh=VG2+lGA45/SRMZxH+IcnUh9wzttOb1s9lHzWaYdGbj4=;
	h=From:To:Cc:Subject:Date;
	b=dYYr0Eayn4MxmMbw846AEwPUu+mHvN0eIR3ji7/iQffk8l7P2wxQhBG55KjXGEUdJ
	 oPpVtGvC+MPJuht7is/sb8dma5F6EU4P43ZdLds+wsxgM6hMNmy/HxXS9SxuKPQADQ
	 mSrw3l9RVvEDjkG9Hc9XZU7ahEUdbPec9AMavAS5iNtFJIPdad32Si09KcizIVDCCu
	 CXPFtA2w8bzjWqW16g8sAZoH82yxXrjSrmlmxVKlhuTnzlHjvsE+TyL9noDTaAL/Jy
	 QnbQhvjXAKb4v/V7aL07gKmyBUdFdkEc6yEI8Yp2NJsk8BAG8mn6n3Ze9+vPbCSkHG
	 GcZukCNPdN6Rg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] netlink: specs: tcp_metrics: fix the attribute length checks
Date: Sat, 12 Sep 2026 16:43:36 -0700
Message-ID: <20260912234337.308298-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP_FASTOPEN_COOKIE_MAX is the longest cookie we accept, not the shortest
one. Cookies are even sized, from 4 bytes up, and the ones Linux itself
generates are 8 bytes, so a 16 byte minimum declares all but the longest
cookie invalid. The reference policy kept under #if 0 in tcp_metrics.c
spells it as a maximum, which is what .len means for NLA_BINARY.

The IPv6 addresses err the other way. The policy uses
NLA_POLICY_EXACT_LEN() for both, so a request carrying a longer address is
rejected with -ERANGE, even though the spec advertises 16 bytes as a mere
minimum. Were the policy generated from this spec, as kernel-policy: global
promises, the check would turn into NLA_POLICY_MIN_LEN() and start
accepting over-long addresses, of which nla_get_in6_addr() would take the
first 16 bytes.

Nothing generated changes. fopen-cookie is reply-only so it never gets a
policy entry, and exact-len only feeds the policy (and the fixed size array
form, which needs a sub-type).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tcp_metrics.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
index 13144aeed31a..1d365908084d 100644
--- a/Documentation/netlink/specs/tcp_metrics.yaml
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -32,7 +32,7 @@ kernel-policy: global
         name: addr-ipv6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
         byte-order: big-endian
         display-hint: ipv6
       -
@@ -63,7 +63,7 @@ kernel-policy: global
         name: fopen-cookie
         type: binary
         checks:
-          min-len: tcp-fastopen-cookie-max
+          max-len: tcp-fastopen-cookie-max
       -
         name: saddr-ipv4
         type: u32
@@ -73,7 +73,7 @@ kernel-policy: global
         name: saddr-ipv6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
         byte-order: big-endian
         display-hint: ipv6
       -
-- 
2.55.0

