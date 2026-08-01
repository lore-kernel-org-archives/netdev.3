Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340CF2D5C7A
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785552059; cv=none; b=IvwcdSD0rOxKqBz2tb4swx3BBqg9x9lJAgsuMdFw+/74/Ma9K7RwvWJOgsd3AJLdd2o1VEgLgCWqbgAaeWpV2j9khRO1KEpfdIqgNEpsBBuxa7swJ8TBBicijNgwa9bxg9IB6QM3Z5Gd73xtq6kTI1UQqCzMAMcT1w2yvZ/47rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785552059; c=relaxed/simple;
	bh=bW/5cee2PMVaG7kTiYg+ZQNY7ZzKj+y6HNnrNNihhTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pAEat4NxmnyzSjasRsbu8O/2TdBxjNJIci9XEjOn0jD11q/Nt4M+y1wcprombj/mUV4qjF+pQEEpP0oB+0j/xfnTyGUqHci8GrIj+6+GMhf4Wy6F4egDT4ehsvRq8fluoIADpdDEe0ZOHxkxpdMnwfzx++iKVKpCTj7I3nFKPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAWvH7JS; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAWvH7JS"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-908239232adso8994676d6.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785552056; x=1786156856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r6f/OshbbwtV54V3T+ezmBV1Vtln+ExRpJyRLbR7NRY=;
        b=FAWvH7JSNXf7B5LHDuB4ocxo/pskw7RljNKDDXYWgOBeSsla5TRI1ytqh4kLhA2uyx
         5D/D3hUQOBmMuuYcIqM+yaaVqX/4LxD6Usrz6+BkE/gmWDRMiWJroKzTpeH+wgae5Kda
         xh1dpZ7KUIDWyE1l4m0biTGPRz/EJU8xt2eD7zHAqYyxatq9WGHSIsNVMAhIOdsHhjYl
         L/vYYo9qny87lkMfDHuegOT7K1jniBS7fNb88qZ4Me0y9NVtl8I9/9V1PsTIp7kprWTB
         sF0M+3Ovh+VxvsyYroie6YxIV2eKLjas/inCagSYvVkz2s5RNSTeJhOSslA0xrDYdaXn
         uhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785552056; x=1786156856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6f/OshbbwtV54V3T+ezmBV1Vtln+ExRpJyRLbR7NRY=;
        b=GTHXcJ7EuiswLEdRBy3nk2d3ZL9AwiO18/TruyotVljrHYtcV8Odly7KO3MyZYR9p6
         UZTYkY2hGJtIIP5uI4JiUAo2bQxZiGLdUqhMy7eitG7ogi1pFXFjNQned+Ywp5eoCLNU
         ONxUmjFwP/FqU3HAlLFOVL4+S/qRDpBH750SdITm3QRvipMKpUohWDJWiGOoTlIP4S+A
         ksfiKAR+4HicQgYQsP7MxiTPYzcglF++7tPQpzHoYHt98U0kOt511UMAmhtHCj+jiG7a
         v/eyo/1xInepaYJ+aiaEi+p2PQDEc87VAmAQSvDoudMgIYiKIqTZqRaeelGhkhamLT9p
         C/rQ==
X-Gm-Message-State: AOJu0YxcRUXmdjzJPPowQHSaYxy1z0KaLGjjfsT4NnfphjOho6dTq6vP
	37nQeqgXnnMrYLsL9c5IHRiVV7QNCZcySijCv/YAHELSXHlfpaTP48PCwBuoK+/c
X-Gm-Gg: AR+sD13golxQq+Iltm10Pq9bznehJzlqmzjvZSaJ+gZIH9+x2lnwbCZ1Ae2/zbhBGdo
	qkYXwnkY0Zn5w9jR1ouLTyPfFmaAvJQ8N+6KM5cx+6Bt7hTclCPSHynQjHepHD/fAXivqEW2gjo
	BVmr3iKEhqyZof3xLsxp5y0r9d/3CuJUSUpOU+OctJRINfz4yQsKpfbi/CROp4ABujqibqVHp5i
	/7Oj1vG9SES98b0dnRiavNvoMx7tgVkdiv2TKQVcICrZSoB+EGxcwW9k+AbiIal6aba8I4ey42P
	IyQ5eT0vEkUQiciMuC3ICiShwpakehhkJ0eXlrs1kY242Vn64QtTZt48cfiSnlNYr1+KuvZERQS
	mk12EHl+IDz+j1yMvMvpxtS/ePzjlBrAB8BSvYODbVzKOdErioVniJzRDEz6wyr4M7xdtotVMFP
	uAyfR0qlwyzN6O24OPspNhnAjrnCKUb5EnTyFWh5uT23Psf5BapdPdN9Ul2Te9d9chNI1HYTNSp
	2akXGCm9zQnemF6myT7Iz4otn21FpkC+WD7pzgU104vJXsnL+8/pOLqR17b2HMITtgI1Ui252xW
	4iiALw==
X-Received: by 2002:a05:6214:1253:b0:8e0:c0f3:a2cb with SMTP id 6a1803df08f44-90842f45e39mr82282716d6.0.1785552055914;
        Fri, 31 Jul 2026 19:40:55 -0700 (PDT)
Received: from localhost.localdomain ([163.5.171.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908432a1688sm24395856d6.4.2026.07.31.19.40.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 19:40:55 -0700 (PDT)
From: William Gonzalez <gonzalez.williamalexander1@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	William Gonzalez <gonzalez.williamalexander1@gmail.com>
Subject: [PATCH] bridge: tighten VLAN parsing
Date: Fri, 31 Jul 2026 22:40:51 -0400
Message-Id: <20260801024051.10581-1-gonzalez.williamalexander1@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 bridge/fdb.c    |  45 +++++++++++--------
 bridge/mdb.c    |  21 ++++++---
 bridge/vlan.c   | 113 ++++++++++++++++++------------------------------
 include/utils.h |   2 +
 lib/utils.c     |  51 ++++++++++++++++++++++
 5 files changed, 136 insertions(+), 96 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 05f093b5..fadd82ae 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -364,10 +364,14 @@ static int fdb_show(int argc, char **argv)
 			NEXT_ARG();
 			br = *argv;
 		} else if (strcmp(*argv, "vlan") == 0) {
+			__u16 vid;
+
 			NEXT_ARG();
 			if (filter_vlan)
 				duparg("vlan", *argv);
-			filter_vlan = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
+			filter_vlan = vid;
 		} else if (strcmp(*argv, "state") == 0) {
 			unsigned int state;
 
@@ -474,7 +478,8 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	unsigned long src_vni = ~0;
 	unsigned int via = 0;
 	char *endptr;
-	short vid = -1;
+	__u16 vid = 0;
+	bool vid_set = false;
 	__u32 nhid = 0;
 
 	while (argc > 0) {
@@ -537,10 +542,12 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 			req.ndm.ndm_state |= NUD_REACHABLE;
 			req.ndm.ndm_state &= ~NUD_NOARP;
 		} else if (matches(*argv, "vlan") == 0) {
-			if (vid >= 0)
+			if (vid_set)
 				duparg2("vlan", *argv);
 			NEXT_ARG();
-			vid = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
+			vid_set = true;
 		} else if (matches(*argv, "use") == 0) {
 			req.ndm.ndm_flags |= NTF_USE;
 		} else if (matches(*argv, "extern_learn") == 0) {
@@ -595,7 +602,7 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	if (dst_ok)
 		addattr_l(&req.n, sizeof(req), NDA_DST, &dst.data, dst.bytelen);
 
-	if (vid >= 0)
+	if (vid_set)
 		addattr16(&req.n, sizeof(req), NDA_VLAN, vid);
 	if (nhid > 0)
 		addattr32(&req.n, sizeof(req), NDA_NH_ID, nhid);
@@ -644,7 +651,8 @@ static int fdb_get(int argc, char **argv)
 	char abuf[ETH_ALEN];
 	int br_ifindex = 0;
 	char *addr = NULL;
-	short vlan = -1;
+	__u16 vlan = 0;
+	bool vlan_set = false;
 	char *endptr;
 	int ret;
 
@@ -669,10 +677,12 @@ static int fdb_get(int argc, char **argv)
 		} else if (matches(*argv, "master") == 0) {
 			req.ndm.ndm_flags |= NTF_MASTER;
 		} else if (matches(*argv, "vlan") == 0) {
-			if (vlan >= 0)
+			if (vlan_set)
 				duparg2("vlan", *argv);
 			NEXT_ARG();
-			vlan = atoi(*argv);
+			if (get_vlan(&vlan, *argv))
+				invarg("invalid vlan", *argv);
+			vlan_set = true;
 		} else if (matches(*argv, "dynamic") == 0) {
 			filter_dynamic = 1;
 		} else {
@@ -702,7 +712,7 @@ static int fdb_get(int argc, char **argv)
 
 	addattr_l(&req.n, sizeof(req), NDA_LLADDR, abuf, ETH_ALEN);
 
-	if (vlan >= 0)
+	if (vlan_set)
 		addattr16(&req.n, sizeof(req), NDA_VLAN, vlan);
 
 	if (vni != ~0)
@@ -758,7 +768,9 @@ static int fdb_flush(int argc, char **argv)
 	};
 	unsigned short ndm_state_mask = 0;
 	unsigned short ndm_flags_mask = 0;
-	short vid = -1, brport_ifidx = -1;
+	short brport_ifidx = -1;
+	__u16 vid = 0;
+	bool vid_set = false;
 	char *d = NULL, *brport = NULL;
 	unsigned short ndm_flags = 0;
 	unsigned short ndm_state = 0;
@@ -832,10 +844,12 @@ static int fdb_flush(int argc, char **argv)
 			NEXT_ARG();
 			brport = *argv;
 		} else if (strcmp(*argv, "vlan") == 0) {
-			if (vid >= 0)
+			if (vid_set)
 				duparg2("vlan", *argv);
 			NEXT_ARG();
-			vid = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
+			vid_set = true;
 		} else if (strcmp(*argv, "src_vni") == 0) {
 			NEXT_ARG();
 			src_vni = strtoul(*argv, &endptr, 0);
@@ -901,11 +915,6 @@ static int fdb_flush(int argc, char **argv)
 		}
 	}
 
-	if (vid >= 4096) {
-		fprintf(stderr, "Invalid VLAN ID \"%hu\"\n", vid);
-		return -1;
-	}
-
 	/* if self and master were not specified assume self */
 	if (!(ndm_flags & (NTF_SELF | NTF_MASTER)))
 		ndm_flags |= NTF_SELF;
@@ -914,7 +923,7 @@ static int fdb_flush(int argc, char **argv)
 	req.ndm.ndm_state = ndm_state;
 	if (brport_ifidx > -1)
 		addattr32(&req.n, sizeof(req), NDA_IFINDEX, brport_ifidx);
-	if (vid > -1)
+	if (vid_set)
 		addattr16(&req.n, sizeof(req), NDA_VLAN, vid);
 	if (src_vni != ~0)
 		addattr32(&req.n, sizeof(req), NDA_SRC_VNI, src_vni);
diff --git a/bridge/mdb.c b/bridge/mdb.c
index 112deeb9..b1d6ec28 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -452,10 +452,14 @@ static int mdb_show(int argc, char **argv)
 				duparg("dev", *argv);
 			filter_dev = *argv;
 		} else if (strcmp(*argv, "vid") == 0) {
+			__u16 vid;
+
 			NEXT_ARG();
 			if (filter_vlan)
 				duparg("vid", *argv);
-			filter_vlan = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
+			filter_vlan = vid;
 		}
 		argc--; argv++;
 	}
@@ -706,7 +710,7 @@ static int mdb_modify(int cmd, int flags, int argc, char **argv)
 	char *src_list = NULL, *proto = NULL, *dst = NULL;
 	struct br_mdb_entry entry = {};
 	bool set_attrs = false;
-	short vid = 0;
+	__u16 vid = 0;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -725,7 +729,8 @@ static int mdb_modify(int cmd, int flags, int argc, char **argv)
 			;/* nothing */
 		} else if (strcmp(*argv, "vid") == 0) {
 			NEXT_ARG();
-			vid = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
 		} else if (strcmp(*argv, "src") == 0) {
 			NEXT_ARG();
 			src = *argv;
@@ -868,7 +873,7 @@ static int mdb_get(int argc, char **argv)
 	struct br_mdb_entry entry = {};
 	struct nlmsghdr *answer;
 	bool get_attrs = false;
-	short vid = 0;
+	__u16 vid = 0;
 	int ret = 0;
 
 	while (argc > 0) {
@@ -880,7 +885,8 @@ static int mdb_get(int argc, char **argv)
 			grp = *argv;
 		} else if (strcmp(*argv, "vid") == 0) {
 			NEXT_ARG();
-			vid = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
 		} else if (strcmp(*argv, "src") == 0) {
 			NEXT_ARG();
 			src = *argv;
@@ -963,7 +969,7 @@ static int mdb_flush(int argc, char **argv)
 	struct br_mdb_entry entry = {};
 	unsigned short state_mask = 0;
 	bool set_attrs = false;
-	short vid = 0;
+	__u16 vid = 0;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -974,7 +980,8 @@ static int mdb_flush(int argc, char **argv)
 			p = *argv;
 		} else if (strcmp(*argv, "vid") == 0) {
 			NEXT_ARG();
-			vid = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
 		} else if (strcmp(*argv, "src_vni") == 0) {
 			NEXT_ARG();
 			src_vni = *argv;
diff --git a/bridge/vlan.c b/bridge/vlan.c
index 09c01153..0f0c8333 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -165,8 +165,10 @@ static int vlan_modify(int cmd, int argc, char **argv)
 		.ifm.ifi_family = PF_BRIDGE,
 	};
 	char *d = NULL;
-	short vid = -1;
-	short vid_end = -1;
+	__u16 vid = 0;
+	__u16 vid_end = 0;
+	bool vid_set = false;
+	bool vid_range = false;
 	struct rtattr *afspec;
 	struct bridge_vlan_info vinfo = {};
 	bool tunnel_info_set = false;
@@ -179,19 +181,15 @@ static int vlan_modify(int cmd, int argc, char **argv)
 			NEXT_ARG();
 			d = *argv;
 		} else if (strcmp(*argv, "vid") == 0) {
-			char *p;
-
 			NEXT_ARG();
-			p = strchr(*argv, '-');
-			if (p) {
-				*p = '\0';
-				p++;
-				vid = atoi(*argv);
-				vid_end = atoi(p);
+			if (vid_set)
+				duparg2("vid", *argv);
+			if (get_vlan_range(&vid, &vid_end, *argv))
+				invarg("invalid vlan", *argv);
+			vid_set = true;
+			vid_range = vid_end != vid;
+			if (vid_range)
 				vinfo.flags |= BRIDGE_VLAN_INFO_RANGE_BEGIN;
-			} else {
-				vid = atoi(*argv);
-			}
 		} else if (strcmp(*argv, "self") == 0) {
 			flags |= BRIDGE_FLAGS_SELF;
 		} else if (strcmp(*argv, "master") == 0) {
@@ -213,7 +211,7 @@ static int vlan_modify(int cmd, int argc, char **argv)
 		argc--; argv++;
 	}
 
-	if (d == NULL || vid == -1) {
+	if (d == NULL || !vid_set) {
 		fprintf(stderr, "Device and VLAN ID are required arguments.\n");
 		return -1;
 	}
@@ -224,13 +222,8 @@ static int vlan_modify(int cmd, int argc, char **argv)
 		return -1;
 	}
 
-	if (vid < 1 || vid > 4094) {
-		fprintf(stderr, "Invalid VLAN ID \"%d\"\n", vid);
-		return -1;
-	}
-
-	if (vinfo.flags & BRIDGE_VLAN_INFO_RANGE_BEGIN) {
-		if (vid_end == -1 || vid_end >= 4096 || vid >= vid_end) {
+	if (vid_range) {
+		if (vid_end <= vid) {
 			fprintf(stderr, "Invalid VLAN range \"%hu-%hu\"\n",
 				vid, vid_end);
 			return -1;
@@ -248,10 +241,12 @@ static int vlan_modify(int cmd, int argc, char **argv)
 		addattr16(&req.n, sizeof(req), IFLA_BRIDGE_FLAGS, flags);
 
 	if (tunnel_info_set)
-		add_tunnel_info_range(&req.n, sizeof(req), vid, vid_end,
+		add_tunnel_info_range(&req.n, sizeof(req), vid,
+				      vid_range ? vid_end : -1,
 				      tun_id_start, tun_id_end);
 	else
-		add_vlan_info_range(&req.n, sizeof(req), vid, vid_end,
+		add_vlan_info_range(&req.n, sizeof(req), vid,
+				    vid_range ? vid_end : -1,
 				    vinfo.flags);
 
 	addattr_nest_end(&req.n, afspec);
@@ -277,7 +272,7 @@ static int vlan_option_set(int argc, char **argv)
 	struct bridge_vlan_info vinfo = {};
 	struct rtattr *afspec;
 	char *d = NULL;
-	short vid = -1;
+	__u16 vid = 0;
 
 	afspec = addattr_nest(&req.n, sizeof(req), BRIDGE_VLANDB_ENTRY);
 	afspec->rta_type |= NLA_F_NESTED;
@@ -293,35 +288,19 @@ static int vlan_option_set(int argc, char **argv)
 				return -1;
 			}
 		} else if (strcmp(*argv, "vid") == 0) {
-			short vid_end = -1;
-			char *p;
+			__u16 vid_end = 0;
+			bool vid_range = false;
 
 			NEXT_ARG();
-			p = strchr(*argv, '-');
-			if (p) {
-				*p = '\0';
-				p++;
-				vid = atoi(*argv);
-				vid_end = atoi(p);
-				if (vid >= vid_end || vid_end >= 4096) {
-					fprintf(stderr, "Invalid VLAN range \"%hu-%hu\"\n",
-						vid, vid_end);
-					return -1;
-				}
-			} else {
-				vid = atoi(*argv);
-			}
-			if (vid >= 4096) {
-				fprintf(stderr, "Invalid VLAN ID \"%hu\"\n",
-					vid);
-				return -1;
-			}
+			if (get_vlan_range(&vid, &vid_end, *argv))
+				invarg("invalid vlan", *argv);
+			vid_range = vid_end != vid;
 
 			vinfo.flags = BRIDGE_VLAN_INFO_ONLY_OPTS;
 			vinfo.vid = vid;
 			addattr_l(&req.n, sizeof(req), BRIDGE_VLANDB_ENTRY_INFO,
 				  &vinfo, sizeof(vinfo));
-			if (vid_end != -1)
+			if (vid_range)
 				addattr16(&req.n, sizeof(req),
 					  BRIDGE_VLANDB_ENTRY_RANGE, vid_end);
 		} else if (strcmp(*argv, "state") == 0) {
@@ -400,9 +379,9 @@ static int vlan_global_option_set(int argc, char **argv)
 		.bvm.family = PF_BRIDGE,
 	};
 	struct rtattr *afspec;
-	short vid_end = -1;
+	__u16 vid_end = 0;
 	char *d = NULL;
-	short vid = -1;
+	__u16 vid = 0;
 	__u64 val64;
 	__u32 val32;
 	__u16 val16;
@@ -422,31 +401,15 @@ static int vlan_global_option_set(int argc, char **argv)
 				return -1;
 			}
 		} else if (strcmp(*argv, "vid") == 0) {
-			char *p;
+			bool vid_range = false;
 
 			NEXT_ARG();
-			p = strchr(*argv, '-');
-			if (p) {
-				*p = '\0';
-				p++;
-				vid = atoi(*argv);
-				vid_end = atoi(p);
-				if (vid >= vid_end || vid_end >= 4096) {
-					fprintf(stderr, "Invalid VLAN range \"%hu-%hu\"\n",
-						vid, vid_end);
-					return -1;
-				}
-			} else {
-				vid = atoi(*argv);
-			}
-			if (vid >= 4096) {
-				fprintf(stderr, "Invalid VLAN ID \"%hu\"\n",
-					vid);
-				return -1;
-			}
+			if (get_vlan_range(&vid, &vid_end, *argv))
+				invarg("invalid vlan", *argv);
+			vid_range = vid_end != vid;
 			addattr16(&req.n, sizeof(req), BRIDGE_VLANDB_GOPTS_ID,
 				  vid);
-			if (vid_end != -1)
+			if (vid_range)
 				addattr16(&req.n, sizeof(req),
 					  BRIDGE_VLANDB_GOPTS_RANGE, vid_end);
 		} else if (strcmp(*argv, "mcast_snooping") == 0) {
@@ -1102,10 +1065,14 @@ static int vlan_show(int argc, char **argv, int subject)
 				duparg("dev", *argv);
 			filter_dev = *argv;
 		} else if (strcmp(*argv, "vid") == 0) {
+			__u16 vid;
+
 			NEXT_ARG();
 			if (filter_vlan)
 				duparg("vid", *argv);
-			filter_vlan = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
+			filter_vlan = vid;
 		}
 		argc--; argv++;
 	}
@@ -1219,10 +1186,14 @@ static int vlan_global_show(int argc, char **argv)
 				duparg("dev", *argv);
 			filter_dev = *argv;
 		} else if (strcmp(*argv, "vid") == 0) {
+			__u16 vid;
+
 			NEXT_ARG();
 			if (filter_vlan)
 				duparg("vid", *argv);
-			filter_vlan = atoi(*argv);
+			if (get_vlan(&vid, *argv))
+				invarg("invalid vlan", *argv);
+			filter_vlan = vid;
 		}
 		argc--; argv++;
 	}
diff --git a/include/utils.h b/include/utils.h
index e4e318e2..06d5242f 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -151,6 +151,8 @@ int get_u32(__u32 *val, const char *arg, int base);
 int get_s32(__s32 *val, const char *arg, int base);
 int get_u16(__u16 *val, const char *arg, int base);
 int get_u8(__u8 *val, const char *arg, int base);
+int get_vlan(__u16 *val, const char *arg);
+int get_vlan_range(__u16 *start, __u16 *end, const char *arg);
 int get_be64(__be64 *val, const char *arg, int base);
 int get_be32(__be32 *val, const char *arg, int base);
 int get_be16(__be16 *val, const char *arg, int base);
diff --git a/lib/utils.c b/lib/utils.c
index 1215fe31..debba751 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -387,6 +387,57 @@ int get_u16(__u16 *val, const char *arg, int base)
 	return 0;
 }
 
+int get_vlan(__u16 *val, const char *arg)
+{
+	if (get_u16(val, arg, 10))
+		return -1;
+
+	if (*val < 1 || *val > 4094)
+		return -1;
+
+	return 0;
+}
+
+int get_vlan_range(__u16 *start, __u16 *end, const char *arg)
+{
+	char *start_arg;
+	const char *sep;
+	size_t len;
+	int ret;
+
+	if (!arg)
+		return -1;
+
+	sep = strchr(arg, '-');
+	if (!sep) {
+		ret = get_vlan(start, arg);
+		if (!ret)
+			*end = *start;
+		return ret;
+	}
+
+	len = sep - arg;
+	if (!len || !sep[1])
+		return -1;
+
+	start_arg = malloc(len + 1);
+	if (!start_arg)
+		return -1;
+
+	memcpy(start_arg, arg, len);
+	start_arg[len] = '\0';
+
+	ret = get_vlan(start, start_arg) || get_vlan(end, sep + 1);
+	free(start_arg);
+	if (ret)
+		return -1;
+
+	if (*start >= *end)
+		return -1;
+
+	return 0;
+}
+
 int get_u8(__u8 *val, const char *arg, int base)
 {
 	unsigned long res;
-- 
2.39.3 (Apple Git-145)

