Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221182;
	b=T6UCbbmLM3/cL9MBjTrN4e/PgjcDe1V689Wacl/aywPOAP+Dd6kVR6t6GKBBETEWP9m6
	 EyfbLmgK47BqZvya9JNJ6rcBmkAhD52bxy5xwYwgcTU9X3/HXOrYhwfnQKcbptt/xH8bF
	 G/7dGB50wKKPFs9fd5dj2pqQ1kJM8UVSw5IeHS+2cHJr4quoTROd1Yr+gI+ysaLXI9ePb
	 zOFxvaMYPjGBoLEzHCVPhQ6rapCxnageNwLgxqIpmoGc94xyH4vTA26dJZVQhZnjXNUOa
	 ES2jJsIF1r3ZiuUZU0MdccfP9CNfzG6UTfrKFl1yllZ0wFW0ru8gL7FaUm4Sc3gcwmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qaQSYGMYJjRHdqv1JNYADQndewpgit/Om11IjQW+ZUk=;
	b=U6HMGEk5dK9VIYi92cOZsSE617vMfa0YsuPmT+3C0/snDf61Vj/OiK+ikLD9ij6QbjRH
	 XNeZCuFYKnW+t3PV3MvQdIQei1ugAC2mkLoorzAHKsTBKlHi4ef+UX5bnQf1lRSdQdwLf
	 K8apac53KEO4W0pToLeo/wL29tJZnNgNjHFFZ0SU0slWaoz+FowjvzRpgRaDOiQrBI2Qp
	 3bMPaGoPLc+EtnlwOTzKknVhUC/WQS4P+g62xdM1yZZduDc2YquGpOc2pfnbpP4GU0rb+
	 KaEDvODo7OyGp9ubmarzlemydgR7abv9v1GxPEmpON1I2nrOmMkvSdl4KC9wp5ZZmZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5QKoSGG;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B5606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 20:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 464B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5QKoSGG
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so2724671eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793221181; x=1793825981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qaQSYGMYJjRHdqv1JNYADQndewpgit/Om11IjQW+ZUk=;
        b=u5QKoSGGKa5FcFqgzz2UgIWYWG2ytJgfO8emLPx2PdBSUJgRSZ5N50PG1CpEZfhRQx
         6nui0Ola6WQcunlDZLYRaLZ/2f/KoyJCo04OokKdxpFPaDvjBbC14iTopLpDIygIS4uL
         QSoGW/1kajxzKQrjTwe/04JOgas7wR/ROxlYVOt+upOmoaLrALsDZxElpL/v2pmsjfNX
         jAcEH9dZEairz3P9fCbq36OxGAt+bWhWv7OSP2V+/rIyV0TahtJsQMBleeuHQJKnmAf4
         OHSKPWcs9nfzUp7REDuP53RbFPkfDFZw3ywxQydWfMM8NElPvdtcaPC43iMqbq3GbiJY
         zD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221181; x=1793825981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qaQSYGMYJjRHdqv1JNYADQndewpgit/Om11IjQW+ZUk=;
        b=0LEORROiXCPMoeNpfZoVKLRW/XQGPtt9YmrF2dpaqLg69VYo661P3Ul+GRLdYbPUDg
         734KNQ+Af5NR/Q64SEONTBLzpMIAUF+Vbm6jouZVKauumnxcmwWjUj7LVdEyZvpHMLGi
         RxJjocKCJaWaJykM3EqGch3LSEpSFsN2x2xixCDWuGJiPKPNVAbsrqqO7z3xR4D7U6hj
         rEenY67emDI2kIg/lQBrfWifrSdlI8GM2LIOBKM+cZIWeAXkQm9PJ+usNWVS7rBhWPJB
         oLg6hoJgcQmRDcjW87c5VZyKSiM2djnPr8zQ18gkJzNbaYo8ydp1a5ZrMw2OD3AYyJCl
         rPpQ==
X-Forwarded-Encrypted: i=1; AKwUvByISILvgQxUfi0rMz3KxAoaj/f5KoZbNjjN6eoZdeDQWUOBXMYpAKX94LI+beMqpteVb2xkPLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+fwb2QnoiJLM7tnU0W/3iF/0gnnkSvGADdOPn01eAQv0dGC5O
	ZityYaj2w5puMz2pV4s08i3jnaKg6ls9ZT1abZHnPI0JhCDLshix2bN5
X-Gm-Gg: AYBFou0ILUULn7ExsGF++lkTLOQQhL5HvRn4N+L68XZPeHCJBibdoAlP14y4HIOQ/6+
	ohDbeOnfTHoXh48fKPd6oHkNktbLGecV/WeAaU8ZsGNLCtC/DVNN6iescmRTcjj3RRdIOftJhJc
	Py0yhIgbEruKCtoCSC4mkBZyXFxWHl+m0jgmHUnO1bi6xzum6UD3NUvonNXmzA/VoONQqWLqvC7
	0iExn/wxX8u85lblSSGIBzl8nOrpU65fHHvQ0eiOLovz79cs0y5dedF1WCFG2jSDG0UpRakBFTX
	0l0R0tnfotqQbYs809Q5BGyfYTtJaBHgjzaZD2eFIWPHz+00K1bhbJ2R6I/TUzYtY8cVhaT9Qpz
	orqSSIMb0r6RN/GPUwWrUdIktVtX3F7BW1OrWEoZQtY9uMaNL6ZCuoXBhEIUd6I+kgQ0POTRDki
	vzm6SeFoBl03ZIRcBO+kIugdtnlqAxdjOdM6ZMAlUCSAVzSY/hssV+m84uhLf7VkOEOBLhYGpFh
	mNtUKZa/LlI0kUkpIk5EJEPoDrr30wbnsv47+L1VK3r2k/PDaCU9tgdRx7LyCKT/mHaYsHxR+iL
	7n3vLlBjkZOb8K2ncAJpBRDxU08x08NDte3r/l0FXezbYHpD6nBfmPYToVs4UdapI2vSb16pcUo
	R
X-Received: by 2002:a05:701b:4583:20b0:185:b157:f271 with SMTP id a92af1059eb24-1a6ce113ee5mr4231317c88.23.1793221181020;
        Wed, 28 Oct 2026 13:59:41 -0700 (PDT)
Received: from samniyama.tailbcd61.ts.net ([76.20.4.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm7954568c88.10.2026.10.28.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:59:40 -0700 (PDT)
From: Koral Ilgun <koralilgun@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Koral Ilgun <koral.ilgun@adtran.com>
Subject: [PATCH nf] netfilter: nft_flow_offload: do not offload multicast
Date: Wed, 28 Oct 2026 13:59:38 -0700
Message-ID: <20261028205938.662312-1-koralilgun@gmail.com>
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

IPv4 multicast stays out of the flowtable only because the reverse
route lookup in nft_flow_route() refuses a multicast source address.
The IPv6 route lookup has no such check, so IPv6 multicast that
ip6mr forwards goes into the flowtable.

Skip a multicast destination for both families, so that the result
no longer depends on the route lookup.

Fixes: a3c90f7a2323 ("netfilter: nf_tables: flow offload expression")
Signed-off-by: Koral Ilgun <koral.ilgun@adtran.com>
---
Tested on an arm64 router with Linux 6.18.54, with an inet flowtable
that offloads forwarded flows, and IPv4 and IPv6 multicast routed from
the WAN to one VLAN. Without this change, the IPv6 flow went into the
flowtable after its first packets: the ip6mr vif counters showed 25 of
1,500 packets, and the receiver still got all 400 packets after its
leave. With it, the vif counters showed 1,500 of 1,500, the flow stayed
out of the flowtable, and the stream stopped about 2.5 s after the
leave. IPv4 multicast stayed out of the flowtable before and after.
Unicast IPv4 and IPv6 flows still went into the flowtable.

 net/netfilter/nft_flow_offload.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index d3c5651dd699..1fc755e594b0 100644
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
@@ -35,6 +36,16 @@ static bool nft_flow_offload_skip(struct sk_buff *skb, int family)
 			return true;
 	}
 
+	/* A flow keeps the output it resolved at offload time, but the
+	 * outputs of a multicast route change when listeners join or leave.
+	 */
+	switch (family) {
+	case NFPROTO_IPV4:
+		return ipv4_is_multicast(ip_hdr(skb)->daddr);
+	case NFPROTO_IPV6:
+		return ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr);
+	}
+
 	return false;
 }
 

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.43.0

