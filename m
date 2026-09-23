Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93B3B71DD
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135548; cv=none; b=GhDLAxP4N1RfQKsnywin6K5Yybxa0HC0NnWwVn5R1Hn0JpvNFd9IQ7QoMT3FoSawoRHb1WYKslHBBLTEoe0QF44JUSqKBivNJoghKtOfL9k8CcPdvGB6559Szr/StbCLuogenSQzEGvye1oDrwyrDNaz2BvR8CdSgOcPJDER0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135548; c=relaxed/simple;
	bh=1wDBcUfY5O8WxlKGalJMzzi3n8vTPv4IUdTBwkjU3rQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UiYnzdISNnJnrCq/0xcUDXdMOhhlAPjkGazsg4a9A0Ee6wHtBWgVV2s80AnyOZUyJ5HJR/u3FHgB6gM0jjBiwJNlezx5K0x44OYjFBPA0PQv3TJe2iGzS0GvL7ODtq/soXNElcWBsr/vZ5wMaaxdXm0ag3ypedW35DOo1x6dLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QpVA371+; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpVA371+"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936708f129aso92716085a.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790135546; x=1790740346; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hal8/RIom79DBDvcZhlDOMdnBBdeqQ0s89KAip8787Q=;
        b=QpVA371+AbTQeJZXVk1QSmRx2M57CNg11vqna7g/0XPGbi/y9753MvsrqMpnpnQX1t
         i6D11P7uXTdKlcenNem1KX24q7BSX72qe+9qgkIQ4ZmuFb3zVrc7C0oRz813g3ikAcM/
         3piueX4uHNHP9Y7gM4PNHmROj7LapG/6tK9xQ2yLoCqMHBTBPKeCFI8nsgkxqAXEVNMG
         qE3PBT3p4OTGbYniOytdkBTj1y2ON6eVCSd6fOO1i+Vxdz1YQgYKrxRHjY1cCVSKNjIY
         T87IhkToucXa49EXUD6eJc01yz5L+9sNZZT4gl8s2ezzP8ok3LP8Jdt47shOjAF8qUoR
         4L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790135546; x=1790740346;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hal8/RIom79DBDvcZhlDOMdnBBdeqQ0s89KAip8787Q=;
        b=fUGTigzoBboU5fF98h/z0XKMvKjibngbMKSjCMkboCtfKDrU+73wo1E2sA4gYi+AXZ
         UhAtJPmPbTqgriKGI8YFH/DgOzvA1Bb/w7ZBvhRhcArJIB4ZH18z4ZmncYKKG8SiQnRa
         sO91r5rS2/ZQZiOxLY8zmkzLX0nx0u5qZqWm+hWxVr/TrYzfhI/jLVzmsU7tfiLO8Ure
         7WDsnW/W958CO4kUgC1eYwi5T/aPAlSRgcZg2Jq05RLsfiaZdLy8MsuDIQCuJhFo00+2
         KdhfB8dWbsUL4cNEWZrJH9wG4wn3JJlYDkC2gB4cY+jxdNtp4XgqiTPxvzguA4ZaF32a
         3zlg==
X-Forwarded-Encrypted: i=1; AKwUvBx2MWWCaw0+gCoHucVwdurcxkgcQMw8BHeB6YpWene0xdAhI0RsSEoMXbXcSM2LXVI8d1A2qzM=@vger.kernel.org
X-Gm-Message-State: AFuF++m0TaoRqZA4VfTXhN/4kwBN6pTZZvHSkwLFGZFh4/60/Vc40Qjz
	fsQGck2eJgVbIOLvYIjJJGzR5fknDSZOdqJfTx+zNsk8L8YKz6NKcDdu/sRtoFdNCLtXsbtC8t3
	0z6Q9galS8SdGpg==
X-Received: from qkox7.prod.google.com ([2002:a05:620a:2587:b0:93a:f45:2374])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4891:b0:93c:16ee:ea03 with SMTP id af79cd13be357-93c251b2225mr222293885a.38.1790135545665;
 Tue, 22 Sep 2026 20:52:25 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:52:13 +0000
In-Reply-To: <20260923035217.179102-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923035217.179102-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923035217.179102-2-edumazet@google.com>
Subject: [PATCH net v3 1/5] ip_tunnel: do not clear the active encap before
 validating the new one
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, William Tu <u9012063@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip_tunnel_encap_setup() and ip6_tnl_encap_setup() zero out t->encap with
memset() before calling ip_encap_hlen() / ip6_encap_hlen() to validate
the requested encapsulation type and module availability.

When a changelink request supplies an invalid encapsulation type or an
encapsulation whose module is not loaded, ip[6]_encap_hlen() returns
-EINVAL after t->encap has already been cleared to TUNNEL_ENCAP_NONE,
while t->encap_hlen and t->hlen remain at their previous values. A
rejected netlink request thus permanently disables FOU/GUE on a working
tunnel while keeping its reduced MTU and extra headroom.

The memset() is redundant: struct ip_tunnel_encap has exactly four
fields, and all of them are assigned unconditionally once the length
check has passed. A tunnel being created starts from the zeroed private
area of alloc_netdev(). Simply remove it, so that a failed
ip_tunnel_encap_setup() or ip6_tnl_encap_setup() leaves the active
encapsulation untouched. (Callers still invoke ip[6]_tunnel_encap_setup()
before validating the rest of a changelink request.)

net-next already does this for the IPv4 side in commit 88b84cae6b94
("ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup"), which is not in
net. Removing the same lines here keeps the merge trivial, and extends
the fix to IPv6, which that commit did not touch.

Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp encapsulation")
Fixes: 058214a4d1df ("ip6_tun: Add infrastructure for doing encapsulation")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_tunnel.c  | 2 --
 net/ipv6/ip6_tunnel.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6bcf01411d0bcd12cc9a88e449d9283c4a83c64..2a313b18134e2f0bafd52d59d8e173fa1a084f03 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -491,8 +491,6 @@ int ip_tunnel_encap_setup(struct ip_tunnel *t,
 {
 	int hlen;
 
-	memset(&t->encap, 0, sizeof(t->encap));
-
 	hlen = ip_encap_hlen(ipencap);
 	if (hlen < 0)
 		return hlen;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01760acd1cb176c952f7113f733288..c918c2b0ad81b0161a2a98e4bd861436497c551c 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1818,8 +1818,6 @@ int ip6_tnl_encap_setup(struct ip6_tnl *t,
 {
 	int hlen;
 
-	memset(&t->encap, 0, sizeof(t->encap));
-
 	hlen = ip6_encap_hlen(ipencap);
 	if (hlen < 0)
 		return hlen;
-- 
2.55.0.1082.g2b9226bbc0-goog

