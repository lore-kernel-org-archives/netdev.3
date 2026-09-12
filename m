Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF523F4831
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225801; cv=none; b=hxdW/CCCozgHvtm+QJ4BJZEz5RcPq3EwW1rtjMOJJhktlFv6WrG1Bnzk1HbIpXOMej+AjZZDbpx34OzhcgMpvly+M3KjhzDR8gHhhwHPEoDQGsL/mV1OUbkF15O/QIGjxh3oKA0rQlmbXRCuZnLYlkzAWIReBS+hKKBoUnMmb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225801; c=relaxed/simple;
	bh=iVXpiG22XISSJCkVw23mgMfoBClDjhTGkhe5FMVNikw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n0icBJxSuOb7YESnmOfbCt6tSQhnxcLAWsxZYUkhjRm5b10eZnU/TqmMNVNmpXsCgosFAqWZ9MX6MwORWCte+XYdVhTzfuv9/CgyojD1vABysyyBdD6FvG50Js0EQ4zDbfCPQKyvqzc82iCkLy3AfmC4Nb46ZMrj8l+04/7GvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVJYuopf; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVJYuopf"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a05d645acso108787385a.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789225791; x=1789830591; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdcZ9Ym38TpT+aIRVhZ4u7RPhebC+0/lYyLX2oKzLys=;
        b=SVJYuopfHyzBk7ORyAAyFH5OIu++qW4ITUoPkTO/LZW1HEPwT2gQin7BE8E6CXiz6X
         HpqUEY1y5RWtzDXjEpzqUJXk+UxocXAd0KSzXBZ/lEroiPt7kNO0Xn9xP4dn4z7cwltx
         HFTC5IC9rav+8bvAfTuj1n0IXtTgTfiT2FWx3FVJbdQoHilblPeecGkqjYqwCkWTlPAs
         7dUSllLV+hc6hE3lCgujnUwj7bClKMJK82X4Ktv00/nKN1+gC3Yu21ZfrWYnuS284VMm
         PEf6flKbtHlgx9gF/P3AHSdgMM+DNo4qM2bvtzByOH55lDljJKQphq1yTWFyAEB+g6aI
         /lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789225791; x=1789830591;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdcZ9Ym38TpT+aIRVhZ4u7RPhebC+0/lYyLX2oKzLys=;
        b=a/joaoMv9zeQ3+hRqX481aKvEeO4X3XAlPrkAVNUwFoLj5LFyC4AyE1JHJUQajLLfP
         fmDyO4fMTdFil+00zijk2rkfHABjka4ONbngTTR+enzJzO/XkiRxpXiczdD4nLk/827K
         AxC+US8+prVYonBid4CmqyQPsbPrYp921tp+pIxvArzSiUHsoXodCuAAnQEWba2AegJg
         XTFLC67VZ89+QZ5UkSCGsAl7gK5P6eKpWW90zVJPUbKSGTLzPBVhEnyBQIzVgiI5ZYBc
         OETRBOjNuD6VfNaYd6oCV17DZuYkZn92UW3X9iVMX7sWblj5kotx+AcPWYyDNnrdYUye
         mbjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVJ97D/PdaxNGRo6IKPz67LQx+pvk+vg60eCw1UemH8upJni0nCHgeBHT9o27B2hoYzqDs7NY=@vger.kernel.org
X-Gm-Message-State: AFuF++lsIhJvQcm1mzyMJ7wDnTHqDCRE9p6MdkvLm2M0r89ocIoEkREF
	fCzfcCGZLgrmV8nPkVpBzIuFWVRtDAQpJh9Jh4qkBwgXABUmi4Za11iLWeTam45Rc5AWIPNaTzm
	31Jhipe4KuWOEQQ==
X-Received: from qkbi6.prod.google.com ([2002:a05:620a:5206:b0:93a:f30:25a2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a18b:20b0:939:fa1e:d6fe with SMTP id af79cd13be357-939fa1ee2a1mr727571085a.25.1789225791082;
 Sat, 12 Sep 2026 08:09:51 -0700 (PDT)
Date: Sat, 12 Sep 2026 15:09:42 +0000
In-Reply-To: <20260912150944.3470971-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912150944.3470971-2-edumazet@google.com>
Subject: [PATCH net 1/3] ip_gre: validate netlink attributes before changing
 the tunnel
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipgre_netlink_parms() and erspan_netlink_parms() write into the live
tunnel before all attributes have been validated, so a rejected
changelink leaves it half updated.

A request carrying IFLA_GRE_COLLECT_METADATA and an invalid
IFLA_GRE_IGNORE_DF returns -EINVAL, but dev->type has already become
ARPHRD_NONE, breaking the interface for good.

Parse the ERSPAN attributes into local variables and commit them only
once everything is validated, hence erspan_netlink_parms() now calls
ipgre_netlink_parms() last. Same reason for moving
IFLA_GRE_COLLECT_METADATA after the IFLA_GRE_IGNORE_DF validation.

Only the parsers become all-or-nothing: ip_tunnel_encap_setup() still
runs before them, ip_tunnel_changelink() after them.

Fixes: e271c7b4420d ("gre: do not keep the GRE header around in collect medata mode")
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c | 52 +++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 82309efd417e0f1f6554e7028be8e05d769e932d..40b922362a7ca4e8ee0c3ee6c0af8d4a9fdc42d3 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1233,12 +1233,6 @@ static int ipgre_netlink_parms(struct net_device *dev,
 		parms->iph.frag_off = htons(IP_DF);
 	}
 
-	if (data[IFLA_GRE_COLLECT_METADATA]) {
-		t->collect_md = true;
-		if (dev->type == ARPHRD_IPGRE)
-			dev->type = ARPHRD_NONE;
-	}
-
 	if (data[IFLA_GRE_IGNORE_DF]) {
 		if (nla_get_u8(data[IFLA_GRE_IGNORE_DF])
 		  && (parms->iph.frag_off & htons(IP_DF)))
@@ -1246,6 +1240,13 @@ static int ipgre_netlink_parms(struct net_device *dev,
 		t->ignore_df = !!nla_get_u8(data[IFLA_GRE_IGNORE_DF]);
 	}
 
+	/* All attributes have been validated, we can change @dev and @t. */
+	if (data[IFLA_GRE_COLLECT_METADATA]) {
+		t->collect_md = true;
+		if (dev->type == ARPHRD_IPGRE)
+			dev->type = ARPHRD_NONE;
+	}
+
 	if (data[IFLA_GRE_FWMARK])
 		*fwmark = nla_get_u32(data[IFLA_GRE_FWMARK]);
 
@@ -1259,40 +1260,51 @@ static int erspan_netlink_parms(struct net_device *dev,
 				__u32 *fwmark)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	u8 erspan_ver = t->erspan_ver;
+	u32 index = t->index;
+	u16 hwid = t->hwid;
+	u8 dir = t->dir;
 	int err;
 
-	err = ipgre_netlink_parms(dev, data, tb, parms, fwmark);
-	if (err)
-		return err;
 	if (!data)
-		return 0;
+		return ipgre_netlink_parms(dev, data, tb, parms, fwmark);
 
 	if (data[IFLA_GRE_ERSPAN_VER]) {
-		t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
+		erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
 
-		if (t->erspan_ver > 2)
+		if (erspan_ver > 2)
 			return -EINVAL;
 	}
 
-	if (t->erspan_ver == 1) {
+	if (erspan_ver == 1) {
 		if (data[IFLA_GRE_ERSPAN_INDEX]) {
-			t->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
-			if (t->index & ~INDEX_MASK)
+			index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
+			if (index & ~INDEX_MASK)
 				return -EINVAL;
 		}
-	} else if (t->erspan_ver == 2) {
+	} else if (erspan_ver == 2) {
 		if (data[IFLA_GRE_ERSPAN_DIR]) {
-			t->dir = nla_get_u8(data[IFLA_GRE_ERSPAN_DIR]);
-			if (t->dir & ~(DIR_MASK >> DIR_OFFSET))
+			dir = nla_get_u8(data[IFLA_GRE_ERSPAN_DIR]);
+			if (dir & ~(DIR_MASK >> DIR_OFFSET))
 				return -EINVAL;
 		}
 		if (data[IFLA_GRE_ERSPAN_HWID]) {
-			t->hwid = nla_get_u16(data[IFLA_GRE_ERSPAN_HWID]);
-			if (t->hwid & ~(HWID_MASK >> HWID_OFFSET))
+			hwid = nla_get_u16(data[IFLA_GRE_ERSPAN_HWID]);
+			if (hwid & ~(HWID_MASK >> HWID_OFFSET))
 				return -EINVAL;
 		}
 	}
 
+	err = ipgre_netlink_parms(dev, data, tb, parms, fwmark);
+	if (err)
+		return err;
+
+	/* All attributes have been validated, we can change @t. */
+	t->erspan_ver = erspan_ver;
+	t->index = index;
+	t->hwid = hwid;
+	t->dir = dir;
+
 	return 0;
 }
 
-- 
2.55.0.1007.g17ff1f9808-goog

