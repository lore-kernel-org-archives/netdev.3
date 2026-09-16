Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613D4BB28D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552924; cv=none; b=q0PyNZ4hdMONdU4QnebDsT+MSj+W1ifz2oM7cxeKf6ZITeIX+YO/a21MA98ccrmkgIg82pUu/CktMNQ3yk0LlBypzhnzW6fcQvGB8Q4wbDtF/nSzg/AWeXQBO1dZ5yJcIZDE4SFsnRmsHgav5BsTlKgvwV1PCscj7XwyHTDUTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552924; c=relaxed/simple;
	bh=OsLCv4qp+ee4APhiBYUSeObsLQT11TAzLFWwa4ThwZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n9YSWCY+6RpN6FKRrPJWDN8XrMnBW49q3H0wXxHBoK7rRm30XK+Ft3cnQPkDLIYzJ10Z1IfiuCQTjAAXp6o+H8fsh4aqqXadMy5nkPIlsn58hdg+GqDsQY7l3Q0WuIueqT15zLgH9S5LOA7HdWEdEsvO2K8Hmq2OUKkRLZtSYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HFq6fBXF; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFq6fBXF"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0050a554so1089200885a.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789552917; x=1790157717; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46+7XoS2nMh+AM0wGAbAWhy3nji8ABFTk4EsbxJUzpI=;
        b=HFq6fBXFkJjELT7z9hSf+ia/ZR5zOu0iJhaC64mEJC0K5sKjuWQu3Mhb9ZteARscLZ
         HSCzugFFzm7zB18rc7+pvK0mZcDh/KbMlE15ZeKeQ+wQRrySuvNRF858iGXcich/v3rM
         +tLXZNTWUjMvXSJ9xD9sj83Bd7XAfyry8VBrhxEfQVX8P3gE/E/R8rSAn5LF09uZ9S+t
         96GMoMDVLLDMwEI9F4x1Ntnec2OwBz9fJE551Hmd0f+bKNbhu+EpfkykF5pTs6Li53Nj
         spGKRmlAY1dE6J8HfB+l5KdbIOYoWIvVFElATFeGjFcG4FnIiYWw21Djs6K8BZaFNVfr
         Nw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552917; x=1790157717;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=46+7XoS2nMh+AM0wGAbAWhy3nji8ABFTk4EsbxJUzpI=;
        b=v90H3GIqfZo0XWiIzcMfSuI0PiJ1mmEo3x7Eke9dzbNulU8upAZ6/9K1ZJqCACQt4m
         RpZL1oHOK9PvtPNwDPdWBRWwaB7TGK//Ddy5k2IzpOweTMSLf9iO9hbyB8x6d8RFyt4K
         yXjShdXr2l+thV1T4D28Ounyrz1zwYjPO2H/P8mAM72x7C73CHYUNyDpOIjRfCiCayny
         t9C/m0gRx0xZ0dC6g5ONGZp/B6xruuNBtYayy1SXCH7r1CItxEs2iFCau9TnHP2q7N/i
         H9PpVRBSPMLErBW2BHU54Se/igkpml5Si3RJwS0NW5JQxHGpOnGVz4BASBqmw67ROxGb
         Ovtw==
X-Forwarded-Encrypted: i=1; AKwUvByug09ie12Hzx8c8r7FwTkh1XyvzdnaOK/VYB9oVQ6N4dv1r5FCaenkoBsliZQ2/wf+Zxyr2rs=@vger.kernel.org
X-Gm-Message-State: AFuF++lHVOaknSzArjHMNe2nYMqE9ZHO8tbs8p+g8hWN2UcOWpKFGP5e
	rkjMe/oqGGXL0jxvSuIXHMSiolZLhaBUw+LJ0bE5jq2Bbof8MtneSGAm9DVp2cnkRrbSjwOXa7Z
	wHVGG5d+wxiHJzw==
X-Received: from qkbbk23.prod.google.com ([2002:a05:620a:1a17:b0:93a:1f34:dd1e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4620:b0:93a:1101:a21c with SMTP id af79cd13be357-93bb7899f8fmr273929585a.25.1789552916615;
 Wed, 16 Sep 2026 03:01:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:01:51 +0000
In-Reply-To: <20260916100155.1398403-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com> <20260916100155.1398403-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916100155.1398403-2-edumazet@google.com>
Subject: [PATCH net v2 1/5] ip_tunnel: do not clear the active encap before
 validating the new one
From: Eric Dumazet <edumazet@google.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
area of alloc_netdev(). Simply remove it, so that a failed changelink
leaves the active encapsulation untouched.

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
2.55.0.1032.g73a4cd73de-goog

