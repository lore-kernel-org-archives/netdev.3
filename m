Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9138237F
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690514; cv=none; b=MH8zx9zRlxcMfVOayAHIfICulUESz29OQrdrfvkUrHvBqYTgNKoVsjO/Z1Xvmd2aHeuqLHttcqB4jgU3u5tpXCUffliaO5xG/lgqQos/2vG3Tx5b9KzUPC0fTqJ1sXk+7BuRn/ruNp9b4DWNWMDX28J7JZAJaLxgT2YgRLIgSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690514; c=relaxed/simple;
	bh=sFodNQNR9FelTC1V333RYUxhuvQ/oSTjBnSufIdGqAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ije5SZOSW5+1Ou6WfulBtqam6soyynBgKqrFyGbV2+GVdO1+T+VnnxpIFeLiXnwlDXa444GCCwRTsKJ9FigOcjIDLuDwSZN3pzRik7l4edKlDx6bnk7MwHpS+IBJGdYBQy0GM52AV/QWv9iAjZOl6LwKHVE7VvKGn3CaZSXt9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pub/69r6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pub/69r6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceb096e675so123373935ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784690513; x=1785295313; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WqDTimtURahvRYngRj8g81rBzj87HYHBmMRGWInTPFo=;
        b=pub/69r6FN0OL6oGoocEBKMCbf0+k9cGB4EfX1MCFlh/UxbLNuNfJjw7fHOGubMxGh
         P9TbSUuBXAGJRpUgDO/VXp/g9pWD5YbPhzG7sxSjWuvnK8oryda4uR2GH5gdgh9OU9/B
         a1ib5IAIbbX5y6CXlHqnduML16W3usgrYS0K/Tb2UKInBPKYlTYSECHqjwI8VnwN6QN7
         mnZb0qlQJt09kA7nW13ubKHUCZLY408hBn+A+27TqtXTLzLettEIF5S1Cgw7245Uqs27
         cfTQH0h7a97dN9VY846UIoOPv1nclg2OqiUOMskIV+LTVBqTCrzZo+19ZrIXKn6yXC/y
         5iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784690513; x=1785295313;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WqDTimtURahvRYngRj8g81rBzj87HYHBmMRGWInTPFo=;
        b=T9Q4hGgrhqTkKfEg7gy+RxGhy6+uN9qFGDY7J71/6r1tQiIIigJj5FqzC+h9OkfsRH
         UfaRsMe4FvAoeRrpZj8oaWSBj+XW8pR37l/xjjVEitl+gZnBkoezuGODuMtRZW2YjAPn
         TMb32jgK1+Xpq1nMc0h8bMw5a9mPZwxyCDFBwvtHP/BEk6qOTnEieuBhO1ORbMeV76XV
         sGUkkw2BIuMeOOOMAno3L4l5IjoIQF31fIaeFwGb+lmJIOAHMX3+7PUei21gbOsMVPE+
         4ga4fHrzB6RN6bhHCuX6srvBVt09SOGGOqxs6p/xHZAOY1Ag93ai8s0BrZx06BiUhG6I
         /FKg==
X-Gm-Message-State: AOJu0Yz14/v9hHRPhMrs1vmUNLgaQpbZuTor4ocZUfhlB1LQq/vt1+Cz
	KMHd1SRuoWxea2UScnxd5U8GfjAX0sgneNv9aTORggYu2PxNKDwPF7navbhLWQul
X-Gm-Gg: AR+sD10gqM/Ln9oTEReR4mkXEBgQ2CEdpQM49+pwEcdzTxQwmOMNQPBUF9cgS4fqMJC
	fYi64JO3ufhthifLZONU+JXCkkH2RIPtucNpUjKT5pshtz8aNMsk8QK0oVEbQCKYkVi8KjNTEEy
	nq3UH355EGqCp55RMXR0ai9RSvhI7HU3D3RrtS+PIti7T4ya+JkiMrkteGqlK7xWtR7DcSaPeRF
	pmc4sIHWMUM7zsa2AXWcVFJVSJER9nT2uzEy4eYjaxXq9Iswd5noEagItw0gvtrSWa1xhlu1GsV
	oVCzzig3xC4zSjee/BrX2LkLuySnNd0RvFGAuQ/VwcvqYQ9EoPVRl9DHwsSd+nWB+bGJan84RUC
	IAi8Mh0skmzF0aLWg36S8RHBflEJ25RMk85luOlYUx/P0o/5VZRZsx804uK6j9SxqdNpRFrBUt9
	Gt6LYveUI5udZ6jjQ=
X-Received: by 2002:a17:902:d4c3:b0:2cf:30a9:93fb with SMTP id d9443c01a7336-2cf349cf7a8mr231370725ad.34.1784690512761;
        Tue, 21 Jul 2026 20:21:52 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.localdomain ([70.37.26.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2eb72csm6419635ad.46.2026.07.21.20.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 20:21:52 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
Date: Wed, 22 Jul 2026 03:21:33 +0000
Subject: [PATCH iproute2-next] ip nexthop: support fdb destination port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-b4-vxlan-fdb-port-iproute2-v1-1-45199b1ee240@gmail.com>
X-B4-Tracking: v=1; b=H4sIADw3YGoC/z2NQQrCMBBFr1Jm7UATayJeRVwk7VRHJAmTtARK7
 25UcPl4n/c3yCRMGS7dBkIrZ46hgTp0MD5cuBPy1Bh0r01vtUY/4FpfLuA8eUxRCnKSuBTSqI7
 KnM7WejcYaIEkNHP9xq/wXwWqBW4/nRf/pLF8DmDf386hx9CNAAAA
X-Change-ID: 20260722-b4-vxlan-fdb-port-iproute2-13165877ba46
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Jakub Kicinski <kuba@kernel.org>, Jack Ma <jack4it@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784690511; l=3830;
 i=jack4it@gmail.com; s=20260712; h=from:subject:message-id;
 bh=sFodNQNR9FelTC1V333RYUxhuvQ/oSTjBnSufIdGqAQ=;
 b=kEVIuAqsNAZ0mC0rJ8xZBNu695MajLL0dOdAjPKizhNZFAWoNbe+9zcvHhXy/6bMDGkMY+HF9
 uGDfDz0XZ3nAe76KpEZi/56Fb35S1db2OTlUhdliUG1l0fR6k1L1VBX
X-Developer-Key: i=jack4it@gmail.com; a=ed25519;
 pk=x8xh2Md9yNDil0xBOA9WA/oqC3O4Eg4rdlIul4YUktU=

The kernel gained NHA_FDB_PORT, an optional per-nexthop UDP destination
port for fdb nexthops.  VXLAN uses it to reach several receivers that
share an underlay IP but listen on different ports, load-balancing a
flow across (IP, port) legs of one nexthop group.

Add the matching uapi value and wire it into `ip nexthop`:

  ip nexthop add id 1 via 192.0.2.1 fdb port 4790

The port is parsed on add (sent as NHA_FDB_PORT, __be16, network order)
and printed back on dump/get.

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
Kernel side (net-next), which adds NHA_FDB_PORT and is the reason for
this change:

  [PATCH net-next v3 0/3] net: nexthop: per-nexthop UDP dst port for fdb
  (VXLAN) nexthops
  https://lore.kernel.org/netdev/20260721-b4-vxlan-fdb-port-v3-0-9aa0a543a78a@gmail.com/
---
 include/uapi/linux/nexthop.h |  2 ++
 ip/ipnexthop.c               | 16 +++++++++++++++-
 ip/nh_common.h               |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index afbd064..e1e1a66 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -83,6 +83,8 @@ enum {
 	/* u32; read-only; whether any driver collects HW stats */
 	NHA_HW_STATS_USED,
 
+	NHA_FDB_PORT,	/* be16; UDP dst port for an fdb nexthop (VXLAN) */
+
 	__NHA_MAX,
 };
 
diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index 14b525a..4c33361 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -52,7 +52,7 @@ static void usage(void)
 		"SELECTOR := [ id ID ] [ dev DEV ] [ vrf NAME ] [ master DEV ]\n"
 		"            [ groups ] [ fdb ]\n"
 		"BUCKET_SELECTOR := SELECTOR | [ nhid ID ]\n"
-		"NH := { blackhole | [ via ADDRESS ] [ dev DEV ] [ onlink ]\n"
+		"NH := { blackhole | [ via ADDRESS ] [ dev DEV ] [ onlink ] [ fdb [ port PORT ] ]\n"
 		"        [ encap ENCAPTYPE ENCAPHDR ] |\n"
 		"        group GROUP [ fdb ] [ type TYPE [ TYPE_ARGS ] ] }\n"
 		"GROUP := [ <id[,weight]>/<id[,weight]>/... ]\n"
@@ -531,6 +531,8 @@ static int ipnh_parse_nhmsg(FILE *fp, const struct nhmsg *nhm, int len,
 
 	nhe->nh_blackhole = !!tb[NHA_BLACKHOLE];
 	nhe->nh_fdb = !!tb[NHA_FDB];
+	if (tb[NHA_FDB_PORT])
+		nhe->nh_fdb_port = rta_getattr_be16(tb[NHA_FDB_PORT]);
 
 	nhe->nh_family = nhm->nh_family;
 	nhe->nh_protocol = nhm->nh_protocol;
@@ -595,6 +597,10 @@ static void __print_nexthop_entry(FILE *fp, const char *jsobj,
 	if (nhe->nh_fdb)
 		print_null(PRINT_ANY, "fdb", "fdb", NULL);
 
+	if (nhe->nh_fdb_port)
+		print_uint(PRINT_ANY, "port", " port %u",
+			   nhe->nh_fdb_port);
+
 	if ((show_details > 0 || show_stats) && nhe->nh_hw_stats_supported) {
 		open_json_object("hw_stats");
 		print_on_off(PRINT_ANY, "enabled", "hw_stats %s ",
@@ -1112,6 +1118,14 @@ static int ipnh_modify(int cmd, unsigned int flags, int argc, char **argv)
 				req.nhm.nh_family = AF_INET;
 		} else if (!strcmp(*argv, "fdb")) {
 			addattr_l(&req.n, sizeof(req), NHA_FDB, NULL, 0);
+		} else if (!strcmp(*argv, "port")) {
+			__u16 port;
+
+			NEXT_ARG();
+			if (get_u16(&port, *argv, 0))
+				invarg("\"port\" value is invalid\n", *argv);
+			addattr16(&req.n, sizeof(req), NHA_FDB_PORT,
+				  htons(port));
 		} else if (!strcmp(*argv, "onlink")) {
 			nh_flags |= RTNH_F_ONLINK;
 		} else if (!strcmp(*argv, "group")) {
diff --git a/ip/nh_common.h b/ip/nh_common.h
index afbd16b..759c0c4 100644
--- a/ip/nh_common.h
+++ b/ip/nh_common.h
@@ -33,6 +33,7 @@ struct nh_entry {
 
 	bool			nh_blackhole;
 	bool			nh_fdb;
+	__u16			nh_fdb_port;
 
 	bool			nh_hw_stats_supported;
 	bool			nh_hw_stats_enabled;

---
base-commit: 35a237091c24858cac6c6679175bb6a628cbe400
change-id: 20260722-b4-vxlan-fdb-port-iproute2-13165877ba46

Best regards,
--  
Jack Ma <jack4it@gmail.com>

