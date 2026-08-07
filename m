Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2347CA6F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117396; cv=none; b=YzNx3XJYl/mLPMzLz+n4dBKgQ7uZgkoRJGLVoKbguy/N+KCue2uxWKf92/YZ5spdvfzTmXndpw/L6aAMjRfGv0ZyKN448UO8AN6tOBehvLRcK8STC25y8oevF45hBzcxzs/0HpLyJgtw6ExBShttqnKFSPXQoz8kAl1w/igcwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117396; c=relaxed/simple;
	bh=ZGa/N+ZXV8gDJHfbuNaBNWz87dBtwmdRkv8OXKJFXig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4oFmH7ASdlJI3DyEo3LXuQsUw1dDN4QB9+D1by70jQgeyyO+XPzNHZpn9l5Qtl3rd53yQjXtCzIq2ll2JAzSHKYNZ/FRSCdGNtetbwbMZ/bYd1LCMQAR22/cAjZGEtT9wTqFGKqrpX0X31x3lJqYouMElhe/hogVulxVFQyI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=oHWeOpWs; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="oHWeOpWs"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8485ef63b68so5276491b3a.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786117394; x=1786722194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cOUsA9thim8+fLq4BFXTvks2c6JBwPjyyM7YQPhNOsM=;
        b=oHWeOpWs2olgHq7s82jOew3ME4qVRVEiiy04thQURn+SEmF4uRsja4VuWQYJzxkERa
         p4YvXej7nQ0no+exFtwCbSA8NGbY58WUvI1UCNy3UTwCUpKzfC9xZq1sHuEkwDU+Lftl
         1FzcoIL6IH+d1zN9Ak8vfvhSdfrMgknm1qF+wt/JExmieaCVYHPAKlSB/Mwtdw+qW2QG
         rPcv/0EciPjyLQWO/ufCLo2SEbiqooZejHl7OCPI4c0pjJoOzjiLnnXTUBV5p7B8csIj
         7Fa5g+bmIBOeQbiir7dHyDdJmgiuNsMsmUpO/B85xBKLKF4oawIMqboAnwNRODIJjq90
         YikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117394; x=1786722194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cOUsA9thim8+fLq4BFXTvks2c6JBwPjyyM7YQPhNOsM=;
        b=WUxuB2xSNf+Rs/NrEJCAxWw/4n1tPz4X4Nf6jpvwWGPfkDHv2XvcvT+AuoBcq2UOk5
         tPuG1wt6DtH17pyFjg6p4hVb/1ajDVM8C6gl3gvRFcirObub8xtEfMPC7gCHLXUpD/fr
         5/YlFu9bgRjlgcWQgZd9nJF8gRyRAig1c0bZbbbKBQSoD6tBHxSKkxIAfYaHkghtzzHw
         sJczdrg2dN3ryKK7uzNXlPcC7rPSrIGsx3ecXoUHJhPFbWr+wEgnMRCSMVKZHhe6Uhxs
         1+uw8g6u3jRjNcdqidr+ke22515JGQcTWgat4IqsNKnVzczpxx0B/5mHB9KfborT5pGq
         1MMQ==
X-Gm-Message-State: AOJu0Ywz1D3s2Jq78flurnHYxyXPWtHJEop1ICzhvZ8yXhsEPGIagJhi
	gwJjvqS8Yc9pGAv4IZD+kFJCEeXE1+0S/DyRbjeoDIIYVCZnQYPbM5dU6z0bjMSiUvl+FVm6SaC
	J7fSc
X-Gm-Gg: AR+sD119GwtkG4W8VHg4OnfTMhlB54D95sc64OzIEQ3Venss/hQSTFFdoMWAlbKItd4
	stzO5wIpFYPz8COHZ70NqSdRiNawzQ4faig97doS8TEY+e8F9Yg2itoZa/OrEJhkAPdP+lvqdRZ
	Pk8gZZvvZJCKr+iwm4+tiz2hm/Ia7Zprrd7DWK04jPQStmjxreoL2kWvOu8y9WZ0hSldXiuKwTn
	u/zQDNfIAJ4M45RTJ9F4htu41tJMMNNLMk9AjPTN2cNZyl0RnQXjrXK8vtMN0v7tGYE7N3OgkMi
	G/qEaEYJnNFX8K6H/UgoeF1wrd6MXcG9oY8uo3qQMn1+GneX65pwQKs6F7CE6BwfnTxNzOjSXcr
	DlA5JZFLN3TpeqH/cNj5v89iRysEZlbHTiCmTb8Dm9nnf4tz+SV701U0PxLATjf29hL8NXduu0y
	6CFLdrR3aKlXW917qldRZYHFgFnYjnWuFnWqdwuDqqPO8WH1K8COimN8UX5ou2Z8h6O+PjuGabT
	WebpXpPx0QKx8dxroF/ezjZU7Q=
X-Received: by 2002:a05:6a20:d52c:b0:3c3:812a:2198 with SMTP id adf61e73a8af0-3cb85df190amr31128390637.4.1786117394211;
        Fri, 07 Aug 2026 08:43:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm8213083c88.1.2026.08.07.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:43:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 5/7] bridge: put help to stdout and usage to stderr
Date: Fri,  7 Aug 2026 08:42:28 -0700
Message-ID: <20260807154306.111200-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807154306.111200-1-stephen@networkplumber.org>
References: <20260807154306.111200-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar change to other iproute2 commands.
Syntax error should print to stderr and exit with non-zero.
Help command should print to stdout and exit with zero status.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bridge/bridge.c  | 20 ++++++++++----------
 bridge/fdb.c     | 18 +++++++++---------
 bridge/link.c    | 16 +++++++++++-----
 bridge/mdb.c     | 14 +++++++-------
 bridge/monitor.c | 11 ++++++-----
 bridge/mst.c     | 10 +++++-----
 bridge/vlan.c    | 10 +++++-----
 bridge/vni.c     | 10 +++++-----
 8 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index d993ba19..45504e7f 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -29,23 +29,23 @@ int timestamp;
 static const char *batch_file;
 int force;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 "Usage: bridge [ OPTIONS ] OBJECT { COMMAND | help }\n"
 "       bridge [ -force ] -batch filename\n"
 "where  OBJECT := { link | fdb | mdb | mst | vlan | vni | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
 "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
 "                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int do_help(int argc, char **argv)
 {
-	usage();
+	usage(true);
 }
 
 
@@ -118,7 +118,7 @@ main(int argc, char **argv)
 			opt++;
 
 		if (matches(opt, "-help") == 0) {
-			usage();
+			usage(true);
 		} else if (matches(opt, "-Version") == 0) {
 			printf("bridge utility, %s\n", version);
 			exit(0);
@@ -135,13 +135,13 @@ main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				usage(false);
 			if (strcmp(argv[1], "inet") == 0)
 				preferred_family = AF_INET;
 			else if (strcmp(argv[1], "inet6") == 0)
 				preferred_family = AF_INET6;
 			else if (strcmp(argv[1], "help") == 0)
-				usage();
+				usage(true);
 			else
 				invarg("invalid protocol family", argv[1]);
 		} else if (strcmp(opt, "-4") == 0) {
@@ -165,7 +165,7 @@ main(int argc, char **argv)
 			argc--;
 			argv++;
 			if (argc <= 1)
-				usage();
+				usage(false);
 			batch_file = argv[1];
 		} else {
 			fprintf(stderr,
@@ -192,5 +192,5 @@ main(int argc, char **argv)
 		return do_cmd(argv[1], argc-1, argv+1);
 
 	rtnl_close(&rth);
-	usage();
+	usage(false);
 }
diff --git a/bridge/fdb.c b/bridge/fdb.c
index 05f093b5..9338cf82 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -33,9 +33,9 @@
 static unsigned int filter_index, filter_dynamic, filter_master,
 	filter_state, filter_vlan;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: bridge fdb { add | append | del | replace } ADDR dev DEV\n"
 		"              [ self ] [ master ] [ use ] [ router ] [ extern_learn ]\n"
 		"              [ sticky ] [ local | static | dynamic ] [ vlan VID ]\n"
@@ -51,7 +51,7 @@ static void usage(void)
 		"	       [ master ] [ [no]permanent | [no]static | [no]dynamic ]\n"
 		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
 		"              [ [no]offloaded ] [ [no]router ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static const char *state_n2a(unsigned int s)
@@ -379,7 +379,7 @@ static int fdb_show(int argc, char **argv)
 			filter_dynamic = 1;
 		} else {
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 		}
 		argc--; argv++;
 	}
@@ -558,7 +558,7 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 				NEXT_ARG();
 
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (addr)
 				duparg2("to", *argv);
 			addr = *argv;
@@ -680,7 +680,7 @@ static int fdb_get(int argc, char **argv)
 				NEXT_ARG();
 
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (addr)
 				duparg2("to", *argv);
 			addr = *argv;
@@ -871,11 +871,11 @@ static int fdb_flush(int argc, char **argv)
 			get_addr(&dst, *argv, preferred_family);
 			dst_ok = 1;
 		} else if (strcmp(*argv, "help") == 0) {
-			NEXT_ARG();
+			usage(true);
 		} else {
 			fprintf(stderr, "bridge fdb: unknown command \"%s\"?\n",
 				*argv);
-			usage();
+			usage(false);
 			return -1;
 		}
 		argc--; argv++;
@@ -966,7 +966,7 @@ int do_fdb(int argc, char **argv)
 		if (strcmp(*argv, "flush") == 0)
 			return fdb_flush(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return fdb_show(0, NULL);
 
diff --git a/bridge/link.c b/bridge/link.c
index 370d7de4..1ceeaaac 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -298,9 +298,9 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: bridge link set dev DEV [ cost COST ] [ priority PRIO ] [ state STATE ]\n"
 		"                               [ guard {on | off} ]\n"
 		"                               [ hairpin {on | off} ]\n"
@@ -326,7 +326,7 @@ static void usage(void)
 		"                               [ backup_nhid NHID ]\n"
 		"                               [ self ] [ master ]\n"
 		"       bridge link show [dev DEV] [master DEVICE]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int brlink_modify(int argc, char **argv)
@@ -521,7 +521,13 @@ static int brlink_modify(int argc, char **argv)
 				invarg("invalid backup_nhid", *argv);
 			backup_nhid_set = true;
 		} else {
-			usage();
+			bool help = matches(*argv, "help") == 0;
+
+			if (!help)
+				fprintf(stderr,
+					"Error: argument \"%s\" is unknown.\n",
+					*argv);
+			usage(help);
 		}
 		argc--; argv++;
 	}
@@ -699,7 +705,7 @@ int do_link(int argc, char **argv)
 		    matches(*argv, "list") == 0)
 			return brlink_show(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return brlink_show(0, NULL);
 
diff --git a/bridge/mdb.c b/bridge/mdb.c
index 112deeb9..11b2bce9 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -30,9 +30,9 @@
 
 static unsigned int filter_index, filter_vlan;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: bridge mdb { add | del | replace } dev DEV port PORT grp GROUP [src SOURCE] [permanent | temp] [vid VID]\n"
 		"              [ filter_mode { include | exclude } ] [ source_list SOURCE_LIST ] [ proto PROTO ] [ dst IPADDR ]\n"
 		"              [ dst_port DST_PORT ] [ vni VNI ] [ src_vni SRC_VNI ] [ via DEV ]\n"
@@ -40,7 +40,7 @@ static void usage(void)
 		"       bridge mdb get dev DEV grp GROUP [ src SOURCE ] [ vid VID ] [ src_vni SRC_VNI ]\n"
 		"       bridge mdb flush dev DEV [ port PORT ] [ vid VID ] [ src_vni SRC_VNI ] [ proto PROTO ]\n"
 		"              [ [no]permanent ] [ dst IPADDR ] [ dst_port DST_PORT ] [ vni VNI ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static bool is_temp_mcast_rtr(__u8 type)
@@ -764,7 +764,7 @@ static int mdb_modify(int cmd, int flags, int argc, char **argv)
 			set_attrs = true;
 		} else {
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 		}
 		argc--; argv++;
 	}
@@ -891,7 +891,7 @@ static int mdb_get(int argc, char **argv)
 			get_attrs = true;
 		} else {
 			if (strcmp(*argv, "help") == 0)
-				usage();
+				usage(true);
 		}
 		argc--; argv++;
 	}
@@ -1005,7 +1005,7 @@ static int mdb_flush(int argc, char **argv)
 			set_attrs = true;
 		} else {
 			if (strcmp(*argv, "help") == 0)
-				usage();
+				usage(true);
 		}
 		argc--; argv++;
 	}
@@ -1099,7 +1099,7 @@ int do_mdb(int argc, char **argv)
 		if (strcmp(*argv, "flush") == 0)
 			return mdb_flush(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return mdb_show(0, NULL);
 
diff --git a/bridge/monitor.c b/bridge/monitor.c
index 552614d7..ac7ade23 100644
--- a/bridge/monitor.c
+++ b/bridge/monitor.c
@@ -21,13 +21,14 @@
 #include "br_common.h"
 
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 static int prefix_banner;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr, "Usage: bridge monitor [file | link | fdb | mdb | vlan | vni | all]\n");
-	exit(-1);
+	fprintf(help ? stdout : stderr,
+		"Usage: bridge monitor [file | link | fdb | mdb | vlan | vni | all]\n");
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int accept_msg(struct rtnl_ctrl_data *ctrl,
@@ -111,7 +112,7 @@ int do_monitor(int argc, char **argv)
 			lvni = 1;
 			prefix_banner = 1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			fprintf(stderr, "Argument \"%s\" is unknown, try \"bridge monitor help\".\n", *argv);
 			exit(-1);
diff --git a/bridge/mst.c b/bridge/mst.c
index df242c9d..e1c5d141 100644
--- a/bridge/mst.c
+++ b/bridge/mst.c
@@ -22,12 +22,12 @@
 
 static unsigned int filter_index;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: bridge mst set dev DEV msti MSTI state STATE\n"
 		"       bridge mst {show} [ dev DEV ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static void print_mst_entry(struct rtattr *a, FILE *fp)
@@ -190,7 +190,7 @@ static int mst_set(int argc, char **argv)
 			s = *argv;
 		} else {
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 		}
 		argc--; argv++;
 	}
@@ -254,7 +254,7 @@ int do_mst(int argc, char **argv)
 		    matches(*argv, "list") == 0)
 			return mst_show(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return mst_show(0, NULL);
 
diff --git a/bridge/vlan.c b/bridge/vlan.c
index ff03ac86..a3628bce 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -29,9 +29,9 @@ enum vlan_show_subject {
 
 #define VLAN_ID_LEN 9
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: bridge vlan { add | del } vid VLAN_ID dev DEV [ tunnel_info id TUNNEL_ID ]\n"
 		"                                                     [ pvid ] [ untagged ]\n"
 		"                                                     [ self ] [ master ]\n"
@@ -57,7 +57,7 @@ static void usage(void)
 		"                      [ mcast_query_response_interval QUERY_RESPONSE_INTERVAL ]\n"
 		"                      [ msti MSTI ]\n"
 		"       bridge vlan global { show } [ dev DEV ] [ vid VLAN_ID ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_tunnel_info(int *argcp, char ***argvp, __u32 *tun_id_start,
@@ -1332,7 +1332,7 @@ static int vlan_global(int argc, char **argv)
 		else if (strcmp(*argv, "set") == 0)
 			return vlan_global_option_set(argc-1, argv+1);
 		else
-			usage();
+			usage(matches(*argv, "help") == 0);
 	} else {
 		return vlan_global_show(0, NULL);
 	}
@@ -1362,7 +1362,7 @@ int do_vlan(int argc, char **argv)
 		if (strcmp(*argv, "global") == 0)
 			return vlan_global(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else {
 		return vlan_show(0, NULL, VLAN_SHOW_VLAN);
 	}
diff --git a/bridge/vni.c b/bridge/vni.c
index b28647fd..7a4c0084 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -27,9 +27,9 @@ static unsigned int filter_index;
 /* max len of "<start>-<end>" */
 #define VXLAN_ID_LEN 17
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: bridge vni { add | del } vni VNI\n"
 		"		[ { group | remote } IP_ADDRESS ]\n"
 		"		dev DEV\n"
@@ -37,7 +37,7 @@ static void usage(void)
 		"\n"
 		"Where:	VNI	:= 0-16777215\n"
 	       );
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_vni_filter(const char *argv, struct nlmsghdr *n, int reqsize,
@@ -121,7 +121,7 @@ static int vni_modify(int cmd, int argc, char **argv)
 			daddr_present = true;
 		} else {
 			if (strcmp(*argv, "help") == 0)
-				usage();
+				usage(true);
 		}
 		argc--; argv++;
 	}
@@ -399,7 +399,7 @@ int do_vni(int argc, char **argv)
 		    strcmp(*argv, "list") == 0)
 			return vni_show(argc-1, argv+1);
 		if (strcmp(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else {
 		return vni_show(0, NULL);
 	}
-- 
2.53.0

