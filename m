Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA702E612E
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769926; cv=none; b=K4mAR5Zp0q4AR8EVFEffLGDJrBVtRWCQN2JtzrbgSiU8/Va12MPeXVWNUizYdoJju/feWeU39v7ILIj+gmnrQu6F9QDRJIfORrl4/nhQflpataCFPUFO+jZbql1S9fi5O8fN7OGSo7K9QEq8lSOEBDZoNKMCI5BIOzSblxGm7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769926; c=relaxed/simple;
	bh=QBKcB8vDpw8nAcDjJgMyxPnh/GGweqUjqJ1ndZpwYGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tp7xLGr/tZh4IkKHIB324sU8jwYcXk2QgXpstXQlI+fs92qLjphB7Jf05UaxDwpgOmGgv9h+c6nOQGDjCXRhh2TaSS7HH1mjgLEZlj3VC1OHOd9u5UumG41y//9xUrxj3nX5gRMoxbqnmE1QbDzVpKJs85D/K0TJE3YxB5ZwoMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amlKJakg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amlKJakg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383cb94f742so76577a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784769924; x=1785374724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sepS/nPyN0OSPNQ7E7Pd6bFUHB6ygpVKYU1fxq8eels=;
        b=amlKJakgHHJ2QC0Fo3BAGppZ/AokUe4BAiUQytmksPBv1I+27dHr7vc5uIy4GqP35V
         T/iLKKiFfBf/pg2jg5GKhylwEDeSnNKf5qTFz5L9hEL9BttTguFgvHyg+F0LMiHlNuPd
         WPSVQ7pBMGrLwk/3bB7KWB+8JZOlegCeqpVByi+EYfqxOfn1tFC/cB2k8pI67Fuc3Oad
         GDCTG5uepILBeCaGaugyUmTl6SESaQqFQKZDYGXzdgC6TJx7IAuQENAMvQEDrb+rVYEH
         SSphMjh4tF3Lx1Cpz9J+JJrwGwLah/IEfjWetFAjRiD9NI0aoypZAeIxqTfMdWMoHE9o
         4rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784769924; x=1785374724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sepS/nPyN0OSPNQ7E7Pd6bFUHB6ygpVKYU1fxq8eels=;
        b=l7+kv/dXSrYuXZp9ppz94uyQ2AxAyZmCc4zPlmiMISuy5H5R10aWM/qaKZ5I+oZGOh
         HEdHinudHh6eIrg6jSTpaRoqYMeHnFkTWg8cKaK6sw6Jr4zpT1MgRj9zIRF3+MPyB4/d
         xsoJE91/Q3XezQd8y3iVQVqF0/UiHeqPFx9pmqJ0Rje+8A2apys6GF2Gr/Umxlj7NAmF
         250Z578ZKHgQhQadblSI/1REwTrfL4F/TPnz4rqg8BfoaJrM4Zofnti9kvUvNY1NS0qJ
         72wAJhToj2m9SUDQ6piZmhCn7Czh37k8Ikvy/L3sxHzLtJADIoMRnjyHqyIspa+D/Coq
         NMyw==
X-Gm-Message-State: AOJu0Yw+iUmyg/71HK6jnYLynfnGES54WZldGBRV2vQNDDQwBSvHr9lP
	d+owU3qbzWR0/mt3O5ZdUcgFkMzUcS8JrL+yK8OA5R4kgsojl7oJa2m7
X-Gm-Gg: AR+sD123nW+f6dg+kGoaTbAKkpCQW0FDU0J5x7u2IZ6CWBeYECMs5yRNL2e5+ynvgiW
	V6PasQYKQfEl+x8PMle8QqhbW3ebF2J7nmtgRZRYFE9/Bn1aa1GB+6NTEJJhLv6eF1sNx8V59+h
	p4TvkRofZXv47LecfERaZ7ff5fQ7krM51P3LZs0nTycgbqYzYGUnSR9d6z0QngYt6LEbPrlvPov
	JmaaaN5kNtIH7v4MplpttyJu5kwU5/ymDxssoCuZOO3CB5SeShALYoJTR2qTWTlQbYlfSjFD1yT
	xy9NRnQFhLXlfZGVhSWxg1RC1U1U/FzzEDP0sBXbBp7rZ2fuxhdarusoqYOA2e/o9KuBoz56/UR
	c+7osdn7yKr2nzPEc5RblYqMKgWYmBZlrP0ZhoNSn6AuzdLhjtGyX6vX15or9jjbMMSjaIwP3Fd
	9BI7IOimOrNKMjrz7g7Z1a9B+Awg==
X-Received: by 2002:a17:90b:3ccf:b0:37f:fda5:8d9a with SMTP id 98e67ed59e1d1-38ec6a5115dmr905028a91.25.1784769924329;
        Wed, 22 Jul 2026 18:25:24 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.localdomain ([70.37.26.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecaac56a7sm30896a91.11.2026.07.22.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:25:23 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
Date: Thu, 23 Jul 2026 01:25:08 +0000
Subject: [PATCH iproute2-next v2 2/2] ip nexthop: support fdb destination
 port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-vxlan-fdb-port-iproute2-v2-2-9012ac01b49e@gmail.com>
References: <20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com>
In-Reply-To: <20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Jakub Kicinski <kuba@kernel.org>, Jack Ma <jack4it@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784769921; l=4252;
 i=jack4it@gmail.com; s=20260712; h=from:subject:message-id;
 bh=QBKcB8vDpw8nAcDjJgMyxPnh/GGweqUjqJ1ndZpwYGk=;
 b=MtKCHTffevKooxud3wnisc8/c4YCLmJZ3ODSxELqmlPgV1qD6BAdc6hsNZN3ygaYMDsKoMrJg
 1058P1oqWsUCavwt5T0peTEbZPwTFTwDGqAlQ9/UTFsM/VOuRtCmL4O
X-Developer-Key: i=jack4it@gmail.com; a=ed25519;
 pk=x8xh2Md9yNDil0xBOA9WA/oqC3O4Eg4rdlIul4YUktU=

The kernel gained NHA_DST_PORT, an optional per-nexthop UDP destination
port for fdb nexthops.  VXLAN uses it to reach several receivers that
share an underlay IP but listen on different ports, load-balancing a
flow across (IP, port) legs of one nexthop group.

Wire it into `ip nexthop`:

  ip nexthop add id 1 via 192.0.2.1 fdb dst_port 4790

The port is parsed on add (sent as NHA_DST_PORT, __be16, network order)
and printed back on dump/get.  The kernel only accepts it together with
fdb and a gateway.

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
 ip/ipnexthop.c        | 18 ++++++++++++++++--
 ip/nh_common.h        |  1 +
 man/man8/ip-nexthop.8 | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index 14b525a..ad8ad0c 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -52,7 +52,7 @@ static void usage(void)
 		"SELECTOR := [ id ID ] [ dev DEV ] [ vrf NAME ] [ master DEV ]\n"
 		"            [ groups ] [ fdb ]\n"
 		"BUCKET_SELECTOR := SELECTOR | [ nhid ID ]\n"
-		"NH := { blackhole | [ via ADDRESS ] [ dev DEV ] [ onlink ]\n"
+		"NH := { blackhole | [ via ADDRESS ] [ dev DEV ] [ onlink ] [ dst_port PORT ]\n"
 		"        [ encap ENCAPTYPE ENCAPHDR ] |\n"
 		"        group GROUP [ fdb ] [ type TYPE [ TYPE_ARGS ] ] }\n"
 		"GROUP := [ <id[,weight]>/<id[,weight]>/... ]\n"
@@ -531,6 +531,8 @@ static int ipnh_parse_nhmsg(FILE *fp, const struct nhmsg *nhm, int len,
 
 	nhe->nh_blackhole = !!tb[NHA_BLACKHOLE];
 	nhe->nh_fdb = !!tb[NHA_FDB];
+	if (tb[NHA_DST_PORT])
+		nhe->nh_dst_port = rta_getattr_be16(tb[NHA_DST_PORT]);
 
 	nhe->nh_family = nhm->nh_family;
 	nhe->nh_protocol = nhm->nh_protocol;
@@ -593,7 +595,11 @@ static void __print_nexthop_entry(FILE *fp, const char *jsobj,
 	print_rt_flags(fp, nhe->nh_flags);
 
 	if (nhe->nh_fdb)
-		print_null(PRINT_ANY, "fdb", "fdb", NULL);
+		print_null(PRINT_ANY, "fdb", "fdb ", NULL);
+
+	if (nhe->nh_dst_port)
+		print_uint(PRINT_ANY, "dst_port", "dst_port %u ",
+			   nhe->nh_dst_port);
 
 	if ((show_details > 0 || show_stats) && nhe->nh_hw_stats_supported) {
 		open_json_object("hw_stats");
@@ -1112,6 +1118,14 @@ static int ipnh_modify(int cmd, unsigned int flags, int argc, char **argv)
 				req.nhm.nh_family = AF_INET;
 		} else if (!strcmp(*argv, "fdb")) {
 			addattr_l(&req.n, sizeof(req), NHA_FDB, NULL, 0);
+		} else if (!strcmp(*argv, "dst_port")) {
+			__u16 port;
+
+			NEXT_ARG();
+			if (get_u16(&port, *argv, 0))
+				invarg("\"dst_port\" value is invalid\n", *argv);
+			addattr16(&req.n, sizeof(req), NHA_DST_PORT,
+				  htons(port));
 		} else if (!strcmp(*argv, "onlink")) {
 			nh_flags |= RTNH_F_ONLINK;
 		} else if (!strcmp(*argv, "group")) {
diff --git a/ip/nh_common.h b/ip/nh_common.h
index afbd16b..f58bad4 100644
--- a/ip/nh_common.h
+++ b/ip/nh_common.h
@@ -33,6 +33,7 @@ struct nh_entry {
 
 	bool			nh_blackhole;
 	bool			nh_fdb;
+	__u16			nh_dst_port;
 
 	bool			nh_hw_stats_supported;
 	bool			nh_hw_stats_enabled;
diff --git a/man/man8/ip-nexthop.8 b/man/man8/ip-nexthop.8
index aad6869..f902c3c 100644
--- a/man/man8/ip-nexthop.8
+++ b/man/man8/ip-nexthop.8
@@ -65,7 +65,9 @@ ip-nexthop \- nexthop object management
 .BR onlink " ] [ "
 .B encap
 .IR ENCAP " ] [ "
-.BR fdb " ] | "
+.BR fdb " ] [ "
+.B dst_port
+.IR PORT " ] | "
 .B  group
 .IR GROUP " [ "
 .BR hw_stats " { "
@@ -210,6 +212,12 @@ A fdb nexthop group can only have fdb nexthops.
 Example: Used to represent a vxlan remote vtep ip. layer-2 vxlan
 fdb entry pointing to an ecmp nexthop group containing multiple
 remote vtep ips.
+.TP
+.BI dst_port " PORT"
+UDP destination port to use for an fdb nexthop, in place of the VXLAN
+device's default port. Only valid together with
+.B fdb
+and a gateway.
 .RE
 
 .TP
@@ -311,6 +319,11 @@ ip nexthop add id 5 via 192.168.1.2 fdb
 Adds a fdb nexthop with id 5.
 .RE
 .PP
+ip nexthop add id 6 via 192.168.1.2 fdb dst_port 4790
+.RS 4
+Adds a fdb nexthop with id 6 forwarding to 192.168.1.2 on UDP port 4790.
+.RE
+.PP
 ip nexthop add id 7 group 5/6 fdb
 .RS 4
 Adds a fdb nexthop group with id 7. A fdb nexthop group can only have

-- 
2.43.0

