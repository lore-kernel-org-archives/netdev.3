Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311308;
	b=HbkSxc+Dbg5fgmOiofx0yzU9YfA4WTQG+XGTIhDnIwsJrNAQFepi+UhG7JquSx1asvYZ
	 MXLmpjg9YAame338V7PFVmBwrWTk/i5iAkcH1qrBiYzGjZWuZ0JU6qwOWDElE3E7IWvMx
	 rzcnxqazl/dAo+6fQL8QoQjvZf0THoDmkaMsUALz/c4pPbgNyABnhz4pH8BAXbHNaHRw2
	 wm3TIUWRSTSF1X22DgGf1Ok28eDk+3Lr9Snl7xB6LuJffuPKj9pVP+/yp6PIBob8MO1i2
	 l4dSGwLhq0eZ2t+rJuxFi3z7c/1yvjEuFcSAJk59cUGgTWZ4w0K8qzZNLx47JfDQPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8Q/lW9fQYT21QznHQjvJzPQJl55ESH89M5aAdKeZYiU=;
	b=GB32ufWRgSZuxj5kbiyAuEEhqPxmoC9P9dXh3xN4ThUwJhr5okPEn4Ae2izgkoCvbnJy
	 kTnl08XrQeU0M6Kl7JlctlMnqmHqoy6FflHSqhO6VQmfiVU91BSIVnSFOHe7uGzm0tG6R
	 MbnjOrPPh739JdNc/8l5kXef6EXczDNEx2nrAx2KTe7hJOKHewz+py22ujwNM07ALO0Z6
	 LFxx2LkJwwhheHgebnN/TJhU8Ivuqp432h1WYyygZjXWeyGuCbqPGTYAOuOsEKaNwBDFp
	 IDkhuOvv/mM3gDaZn40QHxyJBPl2HwVdNqYeOBSu5eQKaDMtZYy4xu+ltj7Scd70b/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HCAjDS8P;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2F606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 22:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C2F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HCAjDS8P
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2af4c8d00so100445c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311307; x=1793916107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Q/lW9fQYT21QznHQjvJzPQJl55ESH89M5aAdKeZYiU=;
        b=HCAjDS8P9gVEmar346ebcMBuz87gARxPe/xf1qL6qqUQlhBC7UJUe7jLP9vJ6TJlKg
         aM/BfEfx/2F5bUKpkKM1Uyuq9rP33tCJmw4gTpTVBll16BqX39cSCskD5GmBjIjffrZ9
         2Bn8j+XR2vPmB5dQpovdQA87mUbQ+k4bmLF/+VisJ7d3RVvWRs0UqjIm4JwmxwhB2jCx
         PNrLJLqcVuRt2v+jvb0kri90HYfx9o8eSuAy2N3pE+DpBA32DiHNvaixs19DWLB+jI/9
         cs/dAolV6c01s5VO6/HXw78jtPSDFB/C2ZRs4J8Fi6WcWHR4PrBIq2IO77HrnkFg/FnG
         4iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311307; x=1793916107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Q/lW9fQYT21QznHQjvJzPQJl55ESH89M5aAdKeZYiU=;
        b=KzhJXi+DNm+LjTm2Y0b9W+rLJhBuxyqrtbvzHUuswyA340LtSD7SeDak7x/fqHiVB4
         BFaHUIKdUVEfJgrxePcO7zadFXfDz5+JnmpsM8iswbBcc4Ldhk/OGyv3HR67EDv2qXnE
         pNAnA5/xhXhyW7V+I6Tb3+Ibnhcr7W6JnwtHpc4ajqTuT9I9nXGlGpK3d4GGFkXKAdab
         d9jx2q09mc9e47oKZPMSnG/GEX81kTJ4+HbOwceMYubrFc5j+gyTWBzE7GN3AJdYB5ia
         CAqpL+1GMujiQ+sI18SsnoPF5N9XQobxcTzHvJrYF4JFfusZXr+tcJ8iQjUVD0O7Uw7j
         09/w==
X-Forwarded-Encrypted: i=1; AKwUvByo2mWE1z3lKp53mqdKMFOQjfxgpBnzHGesFsDjbNx2zGHsP4QjIymvRXJ7ITPYGvkfR6ClJ1k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdQYYnvYpns5IUbDPxtJvx3zeIn8sh4REiFNsEhz+uEzFVEO4M
	YrakiF63GI4w4t2094gEhKNaMLeyeNYS+szSCRGYw1VczyP1EBciFpH4
X-Gm-Gg: AYBFou00XcGAetb7Lpxj3T34S2ZRXEk24Yl1sZcUr3Jooz8SNvK3i9S2YDBeuX3e2g3
	JdFDbixU8ax9B5bGSsoU1xHabamtd5zalw9Gf+qc6MpXGFVT5BNuZRVSDzU4dYbB16i3qvbxru/
	Dyv2nf6zrUi6P6qco1Dq99VOZ3ffzCDexhrgYRVVXm3b4SuVb3p/N7cHTxUDMBswQoh8vUIi4Xm
	s7UeVkG90vvQ7A1xb9co7GUE3iyMBY+6XIm8TNB+MvFP8eZJNa2neh4X23DZYtH76DQW4Q26Tcb
	+zoLx0x/mFQ8HzRzpkrbp80n5+pZRwiV+xebzArkRqw9d3DDmdrSMcm2v+sIJDYQDK3Tnv4VANI
	I2ozj8Mt3R7LzDrZK/yKwZmP1WkAaLwGFP6uZ6iTiZ5HFUo90ZyLF+qh/LdQ9SO4+w8xNjhevLy
	x247HDOO1Y1cEnb/HJAP3EpAHm4nvWXIurFtGd2mdtayUkuvSwmJZNhfH8nGPRRwYbePyKpXqpn
	hO9nitdvPV8Et85ThqP4LsAfo01p1E2tKxJprMSDjUFgIhPySWhW+MkpTDWPouAZJNaUVXuiwWY
	i/PBkwJ5XrfI8jjysjtqt8P0bFVVOoPU1LjdAODnrSmkTEUV1J/pxwwFm04bmhY7V6TKh9FplG4
	N
X-Received: by 2002:a05:701b:4589:b0:187:eb7f:bb4 with SMTP id a92af1059eb24-1ac5d88c4e4mr385234c88.46.1793311306922;
        Thu, 29 Oct 2026 15:01:46 -0700 (PDT)
Received: from samniyama.tailbcd61.ts.net ([76.20.4.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm1314661c88.20.2026.10.29.15.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:01:46 -0700 (PDT)
From: Koral Ilgun <koralilgun@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	fmancera@suse.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Koral Ilgun <koral.ilgun@adtran.com>
Subject: [PATCH nf-next v2] netfilter: nft_flow_offload: do not offload multicast
Date: Thu, 29 Oct 2026 15:01:44 -0700
Message-ID: <20261029220144.2474139-1-koralilgun@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koral Ilgun <koral.ilgun@adtran.com>

A flow holds one output per direction, which it resolves when it is
added. The outputs of a multicast route change when listeners join
or leave. So a multicast flow in the flowtable continues to send to
the output that it resolved, also after the last listener left, and
the counters of the multicast routing stop.

A ruleset can keep multicast out with a match before the flow
offload statement. Without one, IPv4 multicast stays out of the
flowtable only because the reverse route lookup in nft_flow_route()
refuses a multicast source address. The IPv6 route lookup has no such
check, so IPv6 multicast that ip6mr forwards goes into the flowtable.

Skip a multicast destination for both families in the flow offload
expression itself, so that the result no longer depends on the
ruleset or on the route lookup.

Signed-off-by: Koral Ilgun <koral.ilgun@adtran.com>
---
v2:
- Target nf-next, and drop the Fixes tag (Pablo).
- Use the shorter form that Fernando suggested; the result is the same.
- Say in the commit message that a ruleset can keep multicast out.
v1: https://lore.kernel.org/all/20261028205938.662312-1-koralilgun@gmail.com/

Tested with v1, which skips the same packets: on an arm64 router with
Linux 6.18.54, with an inet flowtable that offloads forwarded flows,
and IPv4 and IPv6 multicast routed from the WAN to one VLAN. Without
this change, the IPv6 flow went into the flowtable after its first
packets: the ip6mr vif counters showed 25 of 1,500 packets, and the
receiver still got all 400 packets after its leave. With it, the vif
counters showed 1,500 of 1,500, the flow stayed out of the flowtable,
and the stream stopped about 2.5 s after the leave. Unicast IPv4 and
IPv6 flows still went into the flowtable.

 net/netfilter/nft_flow_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index d3c5651dd699..530e20c7fd45 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -10,6 +10,7 @@
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/flow.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
@@ -33,6 +34,10 @@ static bool nft_flow_offload_skip(struct sk_buff *skb, int family)
 
 		if (unlikely(opt->optlen))
 			return true;
+
+		return ipv4_is_multicast(ip_hdr(skb)->daddr);
+	} else if (family == NFPROTO_IPV6) {
+		return ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr);
 	}
 
 	return false;

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.43.0

