Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AC2D7DDB
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167859; cv=none; b=EAwTZwsqjjdA3da02bAuqzsmD0HuOOtpLn7SoSkkx9lruY8X0fFlbAog0JKE9c7/xXfXvARmK/Rf3Qe9cAgHfwGyN1UbR5658toqtjoCbEgNWQ8sP5HdlxYyplISuW59Llmj6/KLRYYsDD6+G4nSJknbql+J0yUbkX/lSgjEpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167859; c=relaxed/simple;
	bh=bqh/aOs2Su0vJ1rWIqIWhM35qPbEc2yVo47bAbMyows=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uZ4ZfvUpSCBsYV+oE/V+7Sqt/ISM5U77vkrbGJwnyZWJ/vUMMaVbEX8L0umrMjx+pdqbnug5gNHCBRiP7nlwfBjo/D2APFZt0YZoGSz29qHDyPxpUVuaU6RxtKYPgz4rSHsyW02s+yPMWp/z6a/EaHjRAYl7vrxOM76eafz/M1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bd5Kh/oL; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bd5Kh/oL"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-92e62e3459fso931892685a.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 19:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784167857; x=1784772657; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SZbr+S9RWgdH/gQT19pT8e3/RgX8euaAYxCSCSxmPII=;
        b=Bd5Kh/oL6o/sc8AUiV3pFBvGPEYoDBV0B3DVGdm4uqGlikU21SfTmNsYssmPuT6N3b
         3iuKVHzH9907R7oikJq2yKVELpgT5pBlsywb7EIFcw80DA7+UScwmj2i+tSS2EUgV806
         jJoSBUZW3qmsCxUWkRLPtR0cZKjqj+SSzFlF8rnuA9d/Zamzvpfh5YM34IleJD7WHZ6F
         lRebvzJsSjFEeUgdx9bMmM1nttwrHuq7S7xB+Sgyl1W1GxgF0qYSSBpDSeyoNP+Rx8Oo
         arkhlwHsquzj8o5z03VyCdRC3MEYNk9QyjNTDZD6AgnVKDwF7u3lTAjitQ9z0Xv1+DLg
         u9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784167857; x=1784772657;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZbr+S9RWgdH/gQT19pT8e3/RgX8euaAYxCSCSxmPII=;
        b=D5HPcuwaVrfcQcRVIktB7W4EsbTpOW3xtG92mlWqYqj+mZApiWRhA+yPNucv5iepOr
         GzGZrCFNZKEP2qp0g4tidAzWqWBmv8LKNnrGVMa3xmKzIl9MfP+wcTnSbrQ0GtTxP0hG
         +vcZoppVFSG+JZQY5b7N89YdObwleTKh+pnBs/bwG8PTofhxAiwK/fJybYFAl4x60dFo
         8sLhj5usLZys5VmDeSpJ4GGbdCYISAQUpVD2qBgbOoY6P9KPFjx01gs6QJ6dawVU44Jl
         23s0Ivj9jcrdk+/wm7ccWh+c3dnO5PmhiTLuVy81hDdszLzGNiPxRsyJpLq1vE1koMsR
         xVng==
X-Forwarded-Encrypted: i=1; AHgh+Ropa0+ZSk+yZtOoHIiKszUifO5xrQddEBbMAMTd7p2ilK+DoXPO6e0DtgYiYMvJv5paVTqQBgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxprPK/VNxFdKqAPaavrLdyy5MBNS5sOXqDRaxy6HQS6t4kJFwn
	fyRTzC/hpy1f9Z0Wf52anytCEeLhNOGDLxJiEBz+KbJ8eJsT+q7RSiaFw4zXaeNEP8B1Y/40cX2
	DfKwJFey783R7oA==
X-Received: from qknvy8.prod.google.com ([2002:a05:620a:4908:b0:92e:6709:3a5c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4148:b0:92e:e307:e24a with SMTP id af79cd13be357-930961c3a27mr544713085a.15.1784167856682;
 Wed, 15 Jul 2026 19:10:56 -0700 (PDT)
Date: Thu, 16 Jul 2026 02:10:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716021049.2124921-1-edumazet@google.com>
Subject: [PATCH net] ipv4: icmp: fill flow parameters in icmp_route_lookup
 decoy lookup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Muhammad Ziad <muhzi100@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When Linux forwards a packet and needs to generate an ICMP error,
icmp_route_lookup() performs a reverse-path relookup. For non-local
destinations, it performs a decoy lookup via ip_route_output_key() to
find the expected egress interface (rt2->dst.dev) before validating the
path with ip_route_input().

Currently, the decoy flow structure (fl4_2) only sets .daddr = fl4_dec.saddr,
leaving .saddr, .flowi4_dscp, .flowi4_proto, .flowi4_mark, and
.flowi4_uid zeroed out.

When policy routing rules (such as ip rule add from $SRC lookup 100, or
dscp/fwmark/ipproto rules) are configured:
1. ip_route_output_key() fails to match the policy rule because saddr and
   other key flow selectors are missing in fl4_2.
2. It resolves a route using the default table instead, returning an incorrect
   egress netdev.
3. Passing the wrong netdev to ip_route_input() causes strict reverse-path
   filtering (rp_filter=1) to fail, logging false-positive "martian source"
   warnings and causing the relookup to fail.

Fix this by populating fl4_2 with .saddr = fl4_dec.daddr, .flowi4_dscp,
.flowi4_proto = IPPROTO_ICMP, .flowi4_mark, and .flowi4_uid so that
ip_route_output_key() selects the correct egress interface matching policy
routing rules.

Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
Reported-by: Muhammad Ziad <muhzi100@gmail.com>
Closes: https://lore.kernel.org/netdev/CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b36b00d8ae5e14846527220c9db32b..2259f643cb0d43ea54819dd831c79807413e0d69 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -548,10 +548,16 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		if (IS_ERR(rt2))
 			err = PTR_ERR(rt2);
 	} else {
-		struct flowi4 fl4_2 = {};
+		struct flowi4 fl4_2 = {
+			.daddr = fl4_dec.saddr,
+			.saddr = fl4_dec.daddr,
+			.flowi4_dscp = dscp,
+			.flowi4_proto = IPPROTO_ICMP,
+			.flowi4_mark = mark,
+			.flowi4_uid = sock_net_uid(net, NULL),
+		};
 		unsigned long orefdst;
 
-		fl4_2.daddr = fl4_dec.saddr;
 		rt2 = ip_route_output_key(net, &fl4_2);
 		if (IS_ERR(rt2)) {
 			err = PTR_ERR(rt2);
-- 
2.55.0.141.g00534a21ce-goog

