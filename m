Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF93FA5FD
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117402; cv=none; b=gPDG2ONlm+55wDfg+wXhB/iOvPowvV6RZVwrMERIN6ejwV63lxNVzcPMSuS4Zsh8MU22ESUSZtq08M3uQ+92R303U8nwALC50aehq/P7zbhlZe9gEKBgPgX+auH7kvDNU8FRqcRQYyRJV/huKFqDB4nsmjnjReU6n3PfkgjO0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117402; c=relaxed/simple;
	bh=oRpx5KtAzDEt8Pl7MkT033lkLTqgE+FY4cPCaO9Rrok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqg0mrAEdJqx3LV/1HDbdRguq2PrKPgadrpPKdYFLABB/eP58LHhe6S9OT3JswsXrv9rRSINzPYZe7OncZNRAweGta73pq5Js+UFsSkNyowDIss4T7o4plZFSEZsaG3YhPNHX+PMpD9xkxF6McKe2tf8eboH6BiDkWx9xQLViXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=z+mkuY5y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="z+mkuY5y"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc891373e0so43379545ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786117397; x=1786722197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+ik1tTkM4dxeptQYE+gVZY7hnOTCUtfNGnYUbZ9sXI=;
        b=z+mkuY5y9C/L5nEhfcRds7rjcf2fQtvHDgR1tJExUPeybxjnQ2CSTrt7h4bSnDkMSg
         lLHVn6KGp0OCvOTdxHr3JIsIDYFj/Bzv8g3Sdu5x5GLO3b/PsdK5b8snfKFOB5Wfzv5A
         i34SU8SMn2nOkICRwsz/yaYV2CoB3TAPFh1qKcxy1bkemZ7kqXUnMLs4xnddSltDLdU1
         NjqlOWvdO019LEsXASeGOJ3QCCd0rK+L+TfvXGCKhUuhgj7DU42F7j6TkZDuHDip2u7e
         6nhXM9TvYdIEhXmQjxfjQ0vka5flNWEzb11mFx2mDlnWzJ03B+esfeMxdfHBNIYfI4YE
         kYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117397; x=1786722197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+ik1tTkM4dxeptQYE+gVZY7hnOTCUtfNGnYUbZ9sXI=;
        b=scTTGoY5FMjj93Av0SpoA6KQBl53K9NkKIKZsC27jjEEGLLigJRsJZbllAsXvwYKQl
         Rv0RIqCNTgQrJq1oDok+L1Y0hSP2HHWZUkN/Vhj93YH2N50CiVO/jvlM9H4ZC7G5x2Zw
         ii0iVN84NN+zB8l87Xquw+gJRpgdfKakmYKqdzANqSYT9+HxyIzJFYO1IpGoVz+kDrPa
         qO1cdgh8AqFlFqNmO0tWEqMiZ8DOhFyJoT8fQhgZ3F3aEftXBjamfbPkf5EVLE4hqdg6
         kwc6L/cc6lcZK/trtpp5nj3U8yfwYVQOdUxuNfBOdpcFjgDCI3isFlcPVQLjKzxBRaf1
         VPug==
X-Gm-Message-State: AOJu0YyFETD7Uc9Sf6T2rteAGqSRoxyruflQAxHtbjXvhsPQa/Ya2q6h
	OmCHv/L54+x2FllGow960GGyEopMmQWbw7hKE9ZHNiXjlwTLeGYHMa6To0f/mnssUL9o+dZPKLl
	Pd5wl
X-Gm-Gg: AR+sD133MzUk92yPYNISp9rhSM/K37kMdvvzPUh1A4m00OVg9Wa0QFY6RifzyXkwQd0
	APBgfGDYKJYXvp8WsohdBbKSAaxQ3F7p3MyMO1xboMbcX2GrojuTSxOU+mgNk0WhpkQ08WqIYj9
	ulrDPsf4m40TAqFVU0Ct4ACYZOxh/pYT5qzcLgTUDPU6ZfuHHwv2FdM36xBa2qWn4lXOfosSmf/
	z1S/HyY/IxnD2qlPe5DyPuYt8Gxs5S75d7tL+GoIP0V5+Xo20rKmpJ9ObZwhRXFdqhdrP0dO048
	rclDRlNyz6oLEMFEitNN74klr8SPZslmGDcmqqIRWT+WH3rrsi7LVFS53rafEpPk9C5rOpcRuRg
	HW41MO6XFs/84zmnGUppEw0Aa7M/NhEvNoXZDJUpu6eVu9li2874Ter+0bIp021Rmdd2pjFZRCD
	UD98Pke4Z1h+xVmVQvCkycBeWj3RAJBgSP71KFfHTUv/SDPjX2d6Xis1VMIvJMWM26dgEW2HiNu
	JJ0Q9tL7Z8daDzuv2nXC0kYLKs=
X-Received: by 2002:a05:6a20:ce4d:b0:3c6:3c5b:f2e3 with SMTP id adf61e73a8af0-3cb8607680fmr30616380637.33.1786117396250;
        Fri, 07 Aug 2026 08:43:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm8213083c88.1.2026.08.07.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:43:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 7/7] tc: put help to stdout and usage to stderr
Date: Fri,  7 Aug 2026 08:42:30 -0700
Message-ID: <20260807154306.111200-8-stephen@networkplumber.org>
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

The qdisc, class and filter parsers used to print the usage message
and then carry on and execute the command; asking for help now stops
before the command is run. Add the missing help keyword to the htb
qdisc, sfb, ingress and clsact parsers, and handle it in the gact and
nat actions where it was being eaten by the argument parser.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/e_bpf.c        | 15 ++++++++++-----
 tc/f_basic.c      | 12 +++++++-----
 tc/f_bpf.c        | 12 +++++++-----
 tc/f_cgroup.c     | 16 ++++++++++------
 tc/f_flow.c       | 12 +++++++-----
 tc/f_flower.c     | 13 +++++++++----
 tc/f_fw.c         | 12 +++++++-----
 tc/f_matchall.c   | 12 +++++++-----
 tc/f_route.c      | 12 +++++++-----
 tc/f_u32.c        | 12 +++++++-----
 tc/m_action.c     | 23 ++++++++++-------------
 tc/m_bpf.c        | 10 ++++++----
 tc/m_connmark.c   | 16 +++++++++-------
 tc/m_csum.c       | 18 ++++++++++--------
 tc/m_ct.c         | 12 +++++++-----
 tc/m_ctinfo.c     | 16 +++++++++-------
 tc/m_estimator.c  | 12 +++++++-----
 tc/m_gact.c       | 27 ++++++++++++++++-----------
 tc/m_gate.c       | 14 ++++++++------
 tc/m_ife.c        | 16 +++++++++-------
 tc/m_mirred.c     | 14 ++++++++------
 tc/m_mpls.c       | 16 +++++++++-------
 tc/m_nat.c        | 22 +++++++++++++---------
 tc/m_pedit.c      | 22 ++++++++++++----------
 tc/m_police.c     | 10 ++++++----
 tc/m_sample.c     | 24 +++++++++++++-----------
 tc/m_simple.c     | 16 +++++++++-------
 tc/m_skbedit.c    | 17 ++++++++++-------
 tc/m_skbmod.c     | 16 +++++++++-------
 tc/m_tunnel_key.c | 20 +++++++++++---------
 tc/m_vlan.c       | 24 +++++++++++++-----------
 tc/q_cake.c       | 12 +++++++-----
 tc/q_cbs.c        | 12 +++++++-----
 tc/q_choke.c      | 12 +++++++-----
 tc/q_clsact.c     | 14 ++++++++++----
 tc/q_codel.c      | 12 +++++++-----
 tc/q_drr.c        | 24 ++++++++++++++----------
 tc/q_dualpi2.c    | 38 +++++++++++++++++++++-----------------
 tc/q_etf.c        | 12 +++++++-----
 tc/q_ets.c        | 29 +++++++++++++++++------------
 tc/q_fifo.c       | 13 ++++++++-----
 tc/q_fq.c         | 12 +++++++-----
 tc/q_fq_codel.c   | 12 +++++++-----
 tc/q_fq_pie.c     | 12 +++++++-----
 tc/q_gred.c       | 19 ++++++++++---------
 tc/q_hfsc.c       | 28 ++++++++++++++++------------
 tc/q_hhf.c        | 12 +++++++-----
 tc/q_htb.c        | 19 ++++++++++++-------
 tc/q_ingress.c    | 14 ++++++++++----
 tc/q_mqprio.c     | 10 ++++++----
 tc/q_multiq.c     | 12 +++++++-----
 tc/q_netem.c      | 21 +++++++++++++--------
 tc/q_pie.c        | 12 +++++++-----
 tc/q_plug.c       | 13 ++++++++-----
 tc/q_prio.c       | 15 +++++++++------
 tc/q_qfq.c        | 26 +++++++++++++++++---------
 tc/q_red.c        | 12 +++++++-----
 tc/q_sfb.c        | 14 ++++++++++----
 tc/q_sfq.c        | 12 +++++++-----
 tc/q_skbprio.c    | 13 ++++++++-----
 tc/q_taprio.c     | 10 ++++++----
 tc/q_tbf.c        | 14 ++++++++------
 tc/tc.c           | 12 ++++++------
 tc/tc_class.c     | 20 ++++++++++++--------
 tc/tc_exec.c      |  6 +++---
 tc/tc_filter.c    | 31 ++++++++++++++++++-------------
 tc/tc_monitor.c   | 11 ++++++-----
 tc/tc_qdisc.c     | 14 +++++++-------
 tc/tc_stab.c      | 13 +++++++------
 69 files changed, 635 insertions(+), 455 deletions(-)

diff --git a/tc/e_bpf.c b/tc/e_bpf.c
index cca853f9..113b0341 100644
--- a/tc/e_bpf.c
+++ b/tc/e_bpf.c
@@ -20,9 +20,9 @@
 
 static char *argv_default[] = { BPF_DEFAULT_CMD, NULL };
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... bpf [ import UDS_FILE ] [ run CMD ]\n"
 		"       ... bpf [ debug ]\n"
 		"       ... bpf [ graft MAP_FILE ] [ key KEY ]\n"
@@ -37,6 +37,9 @@ static void explain(void)
 		"\'cls\' is default. KEY is optional and can be inferred from the\n"
 		"section name, otherwise it needs to be provided.\n",
 		BPF_DEFAULT_CMD);
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int bpf_num_env_entries(void)
@@ -94,7 +97,9 @@ static int parse_bpf(const struct exec_util *eu, int argc, char **argv)
 			return bpf_graft_map(bpf_map_path, has_key ?
 					     &key : NULL, argc, argv);
 		} else {
-			explain();
+			bool help = strcmp(*argv, "help") == 0;
+
+			explain(help);
 			return -1;
 		}
 
@@ -103,13 +108,13 @@ static int parse_bpf(const struct exec_util *eu, int argc, char **argv)
 
 	if (!bpf_uds_name) {
 		fprintf(stderr, "bpf: No import parameter provided!\n");
-		explain();
+		explain(false);
 		return -1;
 	}
 
 	if (argv_run != argv_default && argc == 0) {
 		fprintf(stderr, "bpf: No run command provided!\n");
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/f_basic.c b/tc/f_basic.c
index eac9d19a..29916e72 100644
--- a/tc/f_basic.c
+++ b/tc/f_basic.c
@@ -19,9 +19,9 @@
 #include "tc_util.h"
 #include "m_ematch.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... basic [ match EMATCH_TREE ]\n"
 		"                 [ action ACTION_SPEC ] [ classid CLASSID ]\n"
 		"\n"
@@ -30,6 +30,9 @@ static void explain(void)
 		"	ACTION_SPEC := ... look at individual actions\n"
 		"\n"
 		"NOTE: CLASSID is parsed as hexadecimal input.\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int basic_parse_opt(const struct filter_util *qu, char *handle,
@@ -89,11 +92,10 @@ static int basic_parse_opt(const struct filter_util *qu, char *handle,
 			}
 			continue;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/f_bpf.c b/tc/f_bpf.c
index 50fe01ca..c19114c7 100644
--- a/tc/f_bpf.c
+++ b/tc/f_bpf.c
@@ -17,9 +17,9 @@
 
 static const enum bpf_prog_type bpf_type = BPF_PROG_TYPE_SCHED_CLS;
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... bpf ...\n"
 		"\n"
 		"BPF use case:\n"
@@ -51,6 +51,9 @@ static void explain(void)
 		"ACTION_SPEC := ... look at individual actions\n"
 		"NOTE: CLASSID is parsed as hexadecimal input.\n",
 		bpf_prog_to_default_section(bpf_type));
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void bpf_cbpf_cb(void *nl, const struct sock_filter *ops, int ops_len)
@@ -153,14 +156,13 @@ opt_bpf:
 			}
 			continue;
 		} else if (matches(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			if (!seen_run)
 				goto opt_bpf;
 
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 
diff --git a/tc/f_cgroup.c b/tc/f_cgroup.c
index 9b94b62e..3828f429 100644
--- a/tc/f_cgroup.c
+++ b/tc/f_cgroup.c
@@ -11,10 +11,15 @@
 #include "tc_util.h"
 #include "m_ematch.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... cgroup [ match EMATCH_TREE ]\n");
-	fprintf(stderr, "                  [ action ACTION_SPEC ]\n");
+	fprintf(help ? stdout : stderr,
+		"Usage: ... cgroup [ match EMATCH_TREE ]\n");
+	fprintf(help ? stdout : stderr,
+		"                  [ action ACTION_SPEC ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int cgroup_parse_opt(const struct filter_util *qu, char *handle,
@@ -62,11 +67,10 @@ static int cgroup_parse_opt(const struct filter_util *qu, char *handle,
 			}
 			continue;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 	}
diff --git a/tc/f_flow.c b/tc/f_flow.c
index 1a1faa90..4cdf6735 100644
--- a/tc/f_flow.c
+++ b/tc/f_flow.c
@@ -14,9 +14,9 @@
 #include "tc_util.h"
 #include "m_ematch.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... flow ...\n"
 		"\n"
 		" [mapping mode]: map key KEY [ OPS ] ...\n"
@@ -33,6 +33,9 @@ static void explain(void)
 		"OPS      := [ or NUM | and NUM | xor NUM | rshift NUM | addend NUM ]\n"
 		"ID       := X:Y\n"
 	);
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static const char *flow_keys[FLOW_KEY_MAX+1] = {
@@ -233,11 +236,10 @@ static int flow_parse_opt(const struct filter_util *fu, char *handle,
 			}
 			continue;
 		} else if (matches(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argv++, argc--;
diff --git a/tc/f_flower.c b/tc/f_flower.c
index 6fc2c6a1..d44ebd72 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -44,9 +44,9 @@ enum flower_icmp_field {
 	FLOWER_ICMP_FIELD_CODE
 };
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... flower	[ MATCH-LIST ] [ verbose ]\n"
 		"			[ skip_sw | skip_hw ]\n"
 		"			[ action ACTION-SPEC ] [ classid CLASSID ]\n"
@@ -118,6 +118,9 @@ static void explain(void)
 		"NOTE:	CLASSID, IP-PROTO are parsed as hexadecimal input.\n"
 		"NOTE:	There can be only used one mask per one prio. If user needs\n"
 		"	to specify different mask, he has to use different prio.\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 /* prints newline, two spaces, name/value */
@@ -2287,9 +2290,11 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
 				return -1;
 			continue;
 		} else {
-			if (strcmp(*argv, "help") != 0)
+			bool help = strcmp(*argv, "help") == 0;
+
+			if (!help)
 				fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(help);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/f_fw.c b/tc/f_fw.c
index c9b4e179..bba934a7 100644
--- a/tc/f_fw.c
+++ b/tc/f_fw.c
@@ -17,9 +17,9 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... fw [ classid CLASSID ] [ indev DEV ] [ action ACTION_SPEC ]\n"
 		"	CLASSID := Push matching packets to the class identified by CLASSID with format X:Y\n"
 		"		CLASSID is parsed as hexadecimal input.\n"
@@ -27,6 +27,9 @@ static void explain(void)
 		"	ACTION_SPEC := Apply an action on matching packets.\n"
 		"	NOTE: handle is represented as HANDLE[/FWMASK].\n"
 		"		FWMASK is 0xffffffff by default.\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int fw_parse_opt(const struct filter_util *qu, char *handle, int argc, char **argv, struct nlmsghdr *n)
@@ -99,11 +102,10 @@ static int fw_parse_opt(const struct filter_util *qu, char *handle, int argc, ch
 			strncpy(d, *argv, sizeof(d) - 1);
 			addattr_l(n, MAX_MSG, TCA_FW_INDEV, d, strlen(d) + 1);
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/f_matchall.c b/tc/f_matchall.c
index e595ac38..29e7369a 100644
--- a/tc/f_matchall.c
+++ b/tc/f_matchall.c
@@ -18,9 +18,9 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... matchall [skip_sw | skip_hw]\n"
 		"                 [ action ACTION_SPEC ] [ classid CLASSID ]\n"
 		"\n"
@@ -29,6 +29,9 @@ static void explain(void)
 		"       ACTION_SPEC := ... look at individual actions\n"
 		"\n"
 		"NOTE: CLASSID is parsed as hexadecimal input.\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int matchall_parse_opt(const struct filter_util *qu, char *handle,
@@ -83,11 +86,10 @@ static int matchall_parse_opt(const struct filter_util *qu, char *handle,
 			flags |= TCA_CLS_FLAGS_SKIP_SW;
 			continue;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/f_route.c b/tc/f_route.c
index c234ddf0..08f5fab3 100644
--- a/tc/f_route.c
+++ b/tc/f_route.c
@@ -19,15 +19,18 @@
 #include "tc_common.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... route [ from REALM | fromif TAG ] [ to REALM ]\n"
 		"                [ classid CLASSID ] [ action ACTION_SPEC ]\n"
 		"       ACTION_SPEC := ... look at individual actions\n"
 		"       CLASSID := X:Y\n"
 		"\n"
 		"NOTE: CLASSID is parsed as hexadecimal input.\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int route_parse_opt(const struct filter_util *qu, char *handle, int argc, char **argv, struct nlmsghdr *n)
@@ -114,11 +117,10 @@ static int route_parse_opt(const struct filter_util *qu, char *handle, int argc,
 				return -1;
 			}
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/f_u32.c b/tc/f_u32.c
index 088d744e..083f1af6 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -22,9 +22,9 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... u32 [ match SELECTOR ... ] [ link HTID ] [ classid CLASSID ]\n"
 		"               [ action ACTION_SPEC ] [ offset OFFSET_SPEC ]\n"
 		"               [ ht HTID ] [ hashkey HASHKEY_SPEC ]\n"
@@ -36,6 +36,9 @@ static void explain(void)
 		"                 SAMPLE_ARGS [ divisor DIVISOR ]\n"
 		"       FILTERID := X:Y:Z\n"
 		"\nNOTE: CLASSID is parsed at hexadecimal input.\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int get_u32_handle(__u32 *handle, const char *str)
@@ -1189,11 +1192,10 @@ static int u32_parse_opt(const struct filter_util *qu, char *handle,
 		} else if (strcmp(*argv, "skip_sw") == 0) {
 			flags |= TCA_CLS_FLAGS_SKIP_SW;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/m_action.c b/tc/m_action.c
index bbc8e6a6..b75c1bfa 100644
--- a/tc/m_action.c
+++ b/tc/m_action.c
@@ -30,7 +30,9 @@ static int gact_ld; /* f*ckin backward compatibility */
 #endif
 static int tab_flush;
 
-static void act_usage(void)
+static void act_usage(bool help) __attribute__((noreturn));
+
+static void act_usage(bool help)
 {
 	/*XXX: In the near future add a action->print_help to improve
 	 * usability
@@ -39,7 +41,7 @@ static void act_usage(void)
 	 * does that, they would know how to fix this ..
 	 *
 	 */
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"usage: tc actions <ACTSPECOP>*\n"
 		"Where:		ACTSPECOP := ACR | GD | FL\n"
 		"	ACR := add | change | replace <ACTSPEC>*\n"
@@ -56,7 +58,7 @@ static void act_usage(void)
 		"		Each action has its own parameters (ACTPARAMS)\n"
 		"\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int print_noaopt(const struct action_util *au, FILE *f, struct rtattr *opt)
@@ -893,28 +895,23 @@ int do_action(int argc, char **argv)
 		} else if (matches(*argv, "list") == 0 ||
 			   matches(*argv, "show") == 0 ||
 			   matches(*argv, "lst") == 0) {
-			if (argc <= 2) {
-				act_usage();
-				return -1;
-			}
+			if (argc <= 2)
+				act_usage(false);
 
 			argc -= 2;
 			argv += 2;
 			return tc_act_list_or_flush(&argc, &argv,
 						    RTM_GETACTION);
 		} else if (matches(*argv, "flush") == 0) {
-			if (argc <= 2) {
-				act_usage();
-				return -1;
-			}
+			if (argc <= 2)
+				act_usage(false);
 
 			argc -= 2;
 			argv += 2;
 			return tc_act_list_or_flush(&argc, &argv,
 						    RTM_DELACTION);
 		} else if (matches(*argv, "help") == 0) {
-			act_usage();
-			return -1;
+			act_usage(true);
 		} else {
 			fprintf(stderr,
 				"Command \"%s\" is unknown, try \"tc actions help\".\n",
diff --git a/tc/m_bpf.c b/tc/m_bpf.c
index 83b21b57..0653fda2 100644
--- a/tc/m_bpf.c
+++ b/tc/m_bpf.c
@@ -19,9 +19,9 @@
 
 static const enum bpf_prog_type bpf_type = BPF_PROG_TYPE_SCHED_ACT;
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... bpf ... [ index INDEX ]\n"
 		"\n"
 		"BPF use case:\n"
@@ -49,6 +49,9 @@ static void explain(void)
 		"Where optionally INDEX points to an existing action, or\n"
 		"explicitly specifies an action index upon creation.\n",
 		bpf_prog_to_default_section(bpf_type));
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void bpf_cbpf_cb(void *nl, const struct sock_filter *ops, int ops_len)
@@ -111,8 +114,7 @@ opt_bpf:
 			bpf_obj = cfg.object;
 			bpf_uds_name = cfg.uds;
 		} else if (matches(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else if (matches(*argv, "index") == 0) {
 			break;
 		} else {
diff --git a/tc/m_connmark.c b/tc/m_connmark.c
index fa5ae79b..c7c63d83 100644
--- a/tc/m_connmark.c
+++ b/tc/m_connmark.c
@@ -14,9 +14,9 @@
 #include <linux/tc_act/tc_connmark.h>
 
 static void
-explain(void)
+explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... connmark [zone ZONE] [CONTROL] [index <INDEX>]\n"
 		"where :\n"
 		"\tZONE is the conntrack zone\n"
@@ -24,11 +24,13 @@ explain(void)
 		"\t           goto chain <CHAIN_INDEX>\n");
 }
 
+static void usage(bool help) __attribute__((noreturn));
+
 static void
-usage(void)
+usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int
@@ -47,7 +49,7 @@ parse_connmark(const struct action_util *a, int *argc_p, char ***argv_p, int tca
 			argc--;
 			argv++;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
@@ -55,7 +57,7 @@ parse_connmark(const struct action_util *a, int *argc_p, char ***argv_p, int tca
 	}
 
 	if (!ok) {
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/m_csum.c b/tc/m_csum.c
index f558d979..afb41e55 100644
--- a/tc/m_csum.c
+++ b/tc/m_csum.c
@@ -16,19 +16,21 @@
 #include "tc_util.h"
 
 static void
-explain(void)
+explain(bool help)
 {
-	fprintf(stderr, "Usage: ... csum <UPDATE>\n"
+	fprintf(help ? stdout : stderr, "Usage: ... csum <UPDATE>\n"
 			"Where: UPDATE := <TARGET> [<UPDATE>]\n"
 			"       TARGET := { ip4h | icmp | igmp | tcp | udp | udplite | sctp | <SWEETS> }\n"
 			"       SWEETS := { and | or | \'+\' }\n");
 }
 
+static void usage(bool help) __attribute__((noreturn));
+
 static void
-usage(void)
+usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int
@@ -99,20 +101,20 @@ parse_csum(const struct action_util *a, int *argc_p,
 			} else if (parse_csum_args(&argc, &argv, &sel)) {
 				fprintf(stderr, "Illegal csum construct (%s)\n",
 					*argv);
-				explain();
+				explain(false);
 				return -1;
 			}
 			ok++;
 			continue;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
 	}
 
 	if (!ok) {
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/m_ct.c b/tc/m_ct.c
index e549cb9c..12045cf5 100644
--- a/tc/m_ct.c
+++ b/tc/m_ct.c
@@ -16,10 +16,12 @@
 #include "rt_names.h"
 #include <linux/tc_act/tc_ct.h>
 
+static void usage(bool help) __attribute__((noreturn));
+
 static void
-usage(void)
+usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ct clear\n"
 		"	ct commit [force] [zone ZONE] [mark MASKED_MARK] [label MASKED_LABEL] [nat NAT_SPEC] [helper HELPER]\n"
 		"	ct [nat] [zone ZONE]\n"
@@ -27,7 +29,7 @@ usage(void)
 		"	NAT_SPEC is {src|dst} addr addr1[-addr2] [port port1[-port2]]\n"
 		"	HELPER is family-proto-name such as ipv4-tcp-ftp\n"
 		"\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int ct_parse_nat_addr_range(const char *str, struct nlmsghdr *n)
@@ -262,7 +264,7 @@ parse_ct(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 
 			NEXT_ARG();
 			if (matches(*argv, "addr") != 0)
-				usage();
+				usage(false);
 
 			NEXT_ARG();
 			ret = ct_parse_nat_addr_range(*argv, n);
@@ -310,7 +312,7 @@ parse_ct(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 				return -1;
 			}
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else if (matches(*argv, "helper") == 0) {
 			NEXT_ARG();
 
diff --git a/tc/m_ctinfo.c b/tc/m_ctinfo.c
index 41449c11..bfd77cea 100644
--- a/tc/m_ctinfo.c
+++ b/tc/m_ctinfo.c
@@ -14,9 +14,9 @@
 #include <linux/tc_act/tc_ctinfo.h>
 
 static void
-explain(void)
+explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... ctinfo [dscp mask [statemask]] [cpmark [mask]] [zone ZONE] [CONTROL] [index <INDEX>]\n"
 		"where :\n"
 		"\tdscp   MASK bitmask location of stored DSCP\n"
@@ -27,11 +27,13 @@ explain(void)
 		"\t           goto chain <CHAIN_INDEX>\n");
 }
 
+static void usage(bool help) __attribute__((noreturn));
+
 static void
-usage(void)
+usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int
@@ -52,7 +54,7 @@ parse_ctinfo(const struct action_util *a, int *argc_p, char ***argv_p, int tca_i
 			ok = 1;
 			NEXT_ARG_FWD();
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
@@ -60,7 +62,7 @@ parse_ctinfo(const struct action_util *a, int *argc_p, char ***argv_p, int tca_i
 	}
 
 	if (!ok) {
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/m_estimator.c b/tc/m_estimator.c
index 98fc5e73..efceb067 100644
--- a/tc/m_estimator.c
+++ b/tc/m_estimator.c
@@ -18,15 +18,17 @@
 #include "tc_util.h"
 #include "tc_common.h"
 
-static void est_help(void);
+static void est_help(bool help) __attribute__((noreturn));
 
-static void est_help(void)
+static void est_help(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... estimator INTERVAL TIME-CONST\n"
 		"  INTERVAL is interval between measurements\n"
 		"  TIME-CONST is averaging time constant\n"
 		"Example: ... est 1sec 8sec\n");
+
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 int parse_estimator(int *p_argc, char ***p_argv, struct tc_estimator *est)
@@ -39,12 +41,12 @@ int parse_estimator(int *p_argc, char ***p_argv, struct tc_estimator *est)
 	if (est->ewma_log)
 		duparg("estimator", *argv);
 	if (matches(*argv, "help") == 0)
-		est_help();
+		est_help(true);
 	if (get_time(&A, *argv))
 		invarg("estimator", "invalid estimator interval");
 	NEXT_ARG();
 	if (matches(*argv, "help") == 0)
-		est_help();
+		est_help(true);
 	if (get_time(&time_const, *argv))
 		invarg("estimator", "invalid estimator time constant");
 	if (tc_setup_estimator(A, time_const, est) < 0) {
diff --git a/tc/m_gact.c b/tc/m_gact.c
index 854d823e..1b003de4 100644
--- a/tc/m_gact.c
+++ b/tc/m_gact.c
@@ -34,11 +34,12 @@ static const char *prob_n2a(int p)
 #endif
 
 static void
-explain(void)
+explain(bool help)
 {
+	FILE *fp = help ? stdout : stderr;
 #ifdef CONFIG_GACT_PROB
-	fprintf(stderr, "Usage: ... gact <ACTION> [RAND] [INDEX]\n");
-	fprintf(stderr,
+	fprintf(fp, "Usage: ... gact <ACTION> [RAND] [INDEX]\n");
+	fprintf(fp,
 		"Where: \tACTION := reclassify | drop | continue | pass | pipe |\n"
 		"       \t          goto chain <CHAIN_INDEX> | jump <JUMP_COUNT>\n"
 			"\tRAND := random <RANDTYPE> <ACTION> <VAL>\n"
@@ -48,7 +49,7 @@ explain(void)
 			"\tINDEX := index value used\n"
 			"\n");
 #else
-	fprintf(stderr, "Usage: ... gact <ACTION> [INDEX]\n"
+	fprintf(fp, "Usage: ... gact <ACTION> [INDEX]\n"
 		"Where: \tACTION := reclassify | drop | continue | pass | pipe |\n"
 		"       \t          goto chain <CHAIN_INDEX> | jump <JUMP_COUNT>\n"
 		"\tINDEX := index value used\n"
@@ -58,11 +59,13 @@ explain(void)
 }
 
 
+static void usage(bool help) __attribute__((noreturn));
+
 static void
-usage(void)
+usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int
@@ -83,11 +86,13 @@ parse_gact(const struct action_util *a, int *argc_p, char ***argv_p,
 
 	if (!matches(*argv, "gact"))
 		NEXT_ARG();
+	if (matches(*argv, "help") == 0)
+		usage(true);	/* does not return */
 	/* we're binding existing gact action to filter by index. */
 	if (!matches(*argv, "index"))
 		goto skip_args;
 	if (parse_action_control(&argc, &argv, &p.action, false))
-		usage();	/* does not return */
+		usage(false);	/* does not return */
 
 #ifdef CONFIG_GACT_PROB
 	if (argc > 0) {
@@ -107,7 +112,7 @@ parse_gact(const struct action_util *a, int *argc_p, char ***argv_p,
 
 			if (parse_action_control(&argc, &argv,
 						 &pp.paction, false) == -1)
-				usage();
+				usage(false);
 			if (get_u16(&pp.pval, *argv, 10)) {
 				fprintf(stderr,
 					"Illegal probability val 0x%x\n",
@@ -123,7 +128,7 @@ parse_gact(const struct action_util *a, int *argc_p, char ***argv_p,
 			argc--;
 			argv++;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		}
 	}
 #endif
@@ -139,7 +144,7 @@ skip_args:
 			argc--;
 			argv++;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		}
 	}
 
diff --git a/tc/m_gate.c b/tc/m_gate.c
index d71dd609..678a2e0b 100644
--- a/tc/m_gate.c
+++ b/tc/m_gate.c
@@ -20,9 +20,9 @@ struct gate_entry {
 	int32_t maxoctets;
 };
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: gate [ priority PRIO-SPEC ] [ base-time BASE-TIME ]\n"
 		"       [ cycle-time CYCLE-TIME ]\n"
 		"       [ cycle-time-ext CYCLE-TIME-EXT ]\n"
@@ -45,10 +45,12 @@ static void explain(void)
 		"                  goto chain <CHAIN_INDEX>\n");
 }
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static void explain_entry_format(void)
@@ -304,7 +306,7 @@ create_entry:
 			list_add_tail(&e->list, &gate_entries);
 			entry_num++;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
diff --git a/tc/m_ife.c b/tc/m_ife.c
index 90bc7a5b..cc7a8d74 100644
--- a/tc/m_ife.c
+++ b/tc/m_ife.c
@@ -20,9 +20,9 @@
 #include "tc_util.h"
 #include <linux/tc_act/tc_ife.h>
 
-static void ife_explain(void)
+static void ife_explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:... ife {decode|encode} [{ALLOW|USE} ATTR] [dst DMAC] [src SMAC] [type TYPE] [CONTROL] [index INDEX]\n"
 		"\tALLOW := Encode direction. Allows encoding specified metadata\n"
 		"\t\t e.g \"allow mark\"\n"
@@ -38,10 +38,12 @@ static void ife_explain(void)
 		"decode is used for receiving IFE packets\n");
 }
 
-static void ife_usage(void)
+static void ife_usage(bool help) __attribute__((noreturn));
+
+static void ife_usage(bool help)
 {
-	ife_explain();
-	exit(-1);
+	ife_explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_ife(const struct action_util *a, int *argc_p, char ***argv_p,
@@ -136,7 +138,7 @@ static int parse_ife(const struct action_util *a, int *argc_p, char ***argv_p,
 			}
 			fprintf(stderr, "src MAC address <%s>\n", saddr);
 		} else if (matches(*argv, "help") == 0) {
-			ife_usage();
+			ife_usage(true);
 		} else {
 			break;
 		}
@@ -162,7 +164,7 @@ static int parse_ife(const struct action_util *a, int *argc_p, char ***argv_p,
 
 	if (!ok) {
 		fprintf(stderr, "IFE requires decode/encode specified\n");
-		ife_usage();
+		ife_usage(false);
 	}
 
 	tail = addattr_nest(n, MAX_MSG, tca_id);
diff --git a/tc/m_mirred.c b/tc/m_mirred.c
index e9ae5199..d148be3a 100644
--- a/tc/m_mirred.c
+++ b/tc/m_mirred.c
@@ -21,9 +21,9 @@
 #include <linux/tc_act/tc_mirred.h>
 
 static void
-explain(void)
+explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: mirred <DIRECTION> <ACTION> [index INDEX] <TARGET>\n"
 		"where:\n"
 		"\tDIRECTION := <ingress | egress>\n"
@@ -36,11 +36,13 @@ explain(void)
 		"\tBLOCKID := 32-bit unsigned block ID\n");
 }
 
+static void usage(bool help) __attribute__((noreturn));
+
 static void
-usage(void)
+usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static const char *mirred_n2a(int action)
@@ -287,7 +289,7 @@ parse_mirred(const struct action_util *a, int *argc_p, char ***argv_p,
 		}
 
 	} else if (matches(*argv, "help") == 0) {
-		usage();
+		usage(true);
 	} else {
 		fprintf(stderr, "mirred option not supported %s\n", *argv);
 	}
diff --git a/tc/m_mpls.c b/tc/m_mpls.c
index 89137456..e5055ce8 100644
--- a/tc/m_mpls.c
+++ b/tc/m_mpls.c
@@ -20,9 +20,9 @@ static const char * const action_names[] = {
 	[TCA_MPLS_ACT_MAC_PUSH] = "mac_push",
 };
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: mpls pop [ protocol MPLS_PROTO ] [CONTROL]\n"
 		"       mpls push [ protocol MPLS_PROTO ] [ label MPLS_LABEL ] [ tc MPLS_TC ]\n"
 		"                 [ ttl MPLS_TTL ] [ bos MPLS_BOS ] [CONTROL]\n"
@@ -37,10 +37,12 @@ static void explain(void)
 		"                  goto chain <CHAIN_INDEX>\n");
 }
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static bool can_modify_mpls_fields(unsigned int action)
@@ -68,7 +70,7 @@ static bool check_double_action(unsigned int action, const char *arg)
 	fprintf(stderr,
 		"Error: got \"%s\" but action already set to \"%s\"\n",
 		arg, action_names[action]);
-	explain();
+	explain(false);
 	return true;
 }
 
@@ -151,7 +153,7 @@ static int parse_mpls(const struct action_util *a, int *argc_p, char ***argv_p,
 			if (ll_proto_a2n(&proto, *argv))
 				invarg("protocol is invalid", *argv);
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
diff --git a/tc/m_nat.c b/tc/m_nat.c
index 0ec3fd11..69d79047 100644
--- a/tc/m_nat.c
+++ b/tc/m_nat.c
@@ -18,20 +18,22 @@
 #include <linux/tc_act/tc_nat.h>
 
 static void
-explain(void)
+explain(bool help)
 {
-	fprintf(stderr, "Usage: ... nat NAT\n"
+	fprintf(help ? stdout : stderr, "Usage: ... nat NAT\n"
 			"NAT := DIRECTION OLD NEW\n"
 			"DIRECTION := { ingress | egress }\n"
 			"OLD := PREFIX\n"
 			"NEW := ADDRESS\n");
 }
 
+static void usage(bool help) __attribute__((noreturn));
+
 static void
-usage(void)
+usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int
@@ -88,18 +90,20 @@ parse_nat(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	while (argc > 0) {
 		if (matches(*argv, "nat") == 0) {
 			NEXT_ARG();
-			if (strcmp(*argv, "index") == 0) {
+			if (matches(*argv, "help") == 0) {
+				usage(true);
+			} else if (strcmp(*argv, "index") == 0) {
 				goto skip_args;
 			} else if (parse_nat_args(&argc, &argv, &sel)) {
 				fprintf(stderr, "Illegal nat construct (%s)\n",
 					*argv);
-				explain();
+				explain(false);
 				return -1;
 			}
 			ok++;
 			continue;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
@@ -107,7 +111,7 @@ parse_nat(const struct action_util *a, int *argc_p, char ***argv_p, int tca_id,
 	}
 
 	if (!ok) {
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/m_pedit.c b/tc/m_pedit.c
index 040d6168..5d8bf0df 100644
--- a/tc/m_pedit.c
+++ b/tc/m_pedit.c
@@ -27,9 +27,9 @@
 static struct m_pedit_util *pedit_list;
 static int pedit_debug;
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... pedit munge [ex] <MUNGE> [CONTROL]\n"
 		"Where: MUNGE := <RAW>|<LAYERED>\n"
 		"\t<RAW>:= <OFFSETC>[ATC]<CMD>\n \t\tOFFSETC:= offset <offval> <u8|u16|u32>\n"
@@ -46,10 +46,12 @@ static void explain(void)
 
 }
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int pedit_parse_nopopt(int *argc_p, char ***argv_p,
@@ -641,7 +643,7 @@ static int parse_pedit(const struct action_util *a, int *argc_p, char ***argv_p,
 				if (ok > 1) {
 					fprintf(stderr,
 						"'ex' must be before first 'munge'\n");
-					explain();
+					explain(false);
 					return -1;
 				}
 				sel.extended = true;
@@ -650,12 +652,12 @@ static int parse_pedit(const struct action_util *a, int *argc_p, char ***argv_p,
 
 			continue;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else if (matches(*argv, "munge") == 0) {
 			if (!ok) {
 				fprintf(stderr, "Bad pedit construct (%s)\n",
 					*argv);
-				explain();
+				explain(false);
 				return -1;
 			}
 			NEXT_ARG();
@@ -663,7 +665,7 @@ static int parse_pedit(const struct action_util *a, int *argc_p, char ***argv_p,
 			if (parse_munge(&argc, &argv, &sel)) {
 				fprintf(stderr, "Bad pedit construct (%s)\n",
 					*argv);
-				explain();
+				explain(false);
 				return -1;
 			}
 			ok++;
@@ -674,7 +676,7 @@ static int parse_pedit(const struct action_util *a, int *argc_p, char ***argv_p,
 	}
 
 	if (!ok) {
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/m_police.c b/tc/m_police.c
index f5c538c9..ce1de40c 100644
--- a/tc/m_police.c
+++ b/tc/m_police.c
@@ -27,9 +27,11 @@ struct action_util police_action_util = {
 	.print_aopt = print_police,
 };
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... police [ rate BPS burst BYTES[/BYTES] ] \n"
 		"		[ pkts_rate RATE pkts_burst PACKETS ] [ mtu BYTES[/BYTES] ]\n"
 		"		[ peakrate BPS ] [ avrate BPS ] [ overhead BYTES ]\n"
@@ -39,7 +41,7 @@ static void usage(void)
 		"		  or conform (<NOTEXCEEDACT>) the configured bandwidth limit.\n"
 		"       EXCEEDACT/NOTEXCEEDACT := { pipe | ok | reclassify | drop | continue |\n"
 		"				   goto chain <CHAIN_INDEX> }\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int act_parse_police(const struct action_util *a, int *argc_p, char ***argv_p,
@@ -152,7 +154,7 @@ static int act_parse_police(const struct action_util *a, int *argc_p, char ***ar
 			if (get_u64(&ppsburst64, *argv, 10))
 				invarg("pkts_burst", *argv);
 		} else if (strcmp(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
diff --git a/tc/m_sample.c b/tc/m_sample.c
index 44ba859f..cec2cc9a 100644
--- a/tc/m_sample.c
+++ b/tc/m_sample.c
@@ -11,9 +11,9 @@
 #include "tc_common.h"
 #include <linux/tc_act/tc_sample.h>
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: sample SAMPLE_CONF\n"
 		"where:\n"
 		"\tSAMPLE_CONF := SAMPLE_PARAMS | SAMPLE_INDEX\n"
@@ -25,10 +25,12 @@ static void explain(void)
 		"\tINDEX := integer index of the sample action\n");
 }
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_sample(const struct action_util *a, int *argc_p, char ***argv_p,
@@ -60,7 +62,7 @@ static int parse_sample(const struct action_util *a, int *argc_p, char ***argv_p
 			NEXT_ARG();
 			if (get_u32(&rate, *argv, 10) != 0) {
 				fprintf(stderr, "Illegal rate %s\n", *argv);
-				usage();
+				usage(false);
 				return -1;
 			}
 			rate_set = true;
@@ -69,7 +71,7 @@ static int parse_sample(const struct action_util *a, int *argc_p, char ***argv_p
 			if (get_u32(&group, *argv, 10) != 0) {
 				fprintf(stderr, "Illegal group num %s\n",
 					*argv);
-				usage();
+				usage(false);
 				return -1;
 			}
 			group_set = true;
@@ -78,12 +80,12 @@ static int parse_sample(const struct action_util *a, int *argc_p, char ***argv_p
 			if (get_u32(&trunc, *argv, 10) != 0) {
 				fprintf(stderr, "Illegal truncation size %s\n",
 					*argv);
-				usage();
+				usage(false);
 				return -1;
 			}
 			trunc_set = true;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
@@ -106,12 +108,12 @@ static int parse_sample(const struct action_util *a, int *argc_p, char ***argv_p
 
 	if (!p.index && !group_set) {
 		fprintf(stderr, "param \"group\" not set\n");
-		usage();
+		usage(false);
 	}
 
 	if (!p.index && !rate_set) {
 		fprintf(stderr, "param \"rate\" not set\n");
-		usage();
+		usage(false);
 	}
 
 	tail = addattr_nest(n, MAX_MSG, tca_id);
diff --git a/tc/m_simple.c b/tc/m_simple.c
index a3afc12e..96d1da53 100644
--- a/tc/m_simple.c
+++ b/tc/m_simple.c
@@ -74,19 +74,21 @@
 #ifndef SIMP_MAX_DATA
 #define SIMP_MAX_DATA   32
 #endif
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:... simple [sdata STRING] [index INDEX] [CONTROL]\n"
 		"\tSTRING being an arbitrary string\n"
 		"\tINDEX := optional index value used\n"
 		"\tCONTROL := reclassify|pipe|drop|continue|ok\n");
 }
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int
@@ -110,7 +112,7 @@ parse_simple(const struct action_util *a, int *argc_p, char ***argv_p, int tca_i
 			argc--;
 			argv++;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
@@ -134,7 +136,7 @@ parse_simple(const struct action_util *a, int *argc_p, char ***argv_p, int tca_i
 	}
 
 	if (!ok) {
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/m_skbedit.c b/tc/m_skbedit.c
index 5c9b2f24..0fe73e3f 100644
--- a/tc/m_skbedit.c
+++ b/tc/m_skbedit.c
@@ -16,9 +16,10 @@
 #include <linux/tc_act/tc_skbedit.h>
 #include <linux/if_packet.h>
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... skbedit <[QM] [PM] [MM] [PT] [IF]>\n"
+	fprintf(help ? stdout : stderr,
+		"Usage: ... skbedit <[QM] [PM] [MM] [PT] [IF]>\n"
 		"QM = queue_mapping QUEUE_MAPPING\n"
 		"PM = priority PRIORITY\n"
 		"MM = mark MARK[/MASK]\n"
@@ -33,11 +34,13 @@ static void explain(void)
 		"note: inheritdsfield maps DS field to skb->priority\n");
 }
 
+static void usage(bool help) __attribute__((noreturn));
+
 static void
-usage(void)
+usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int
@@ -121,7 +124,7 @@ parse_skbedit(const struct action_util *a, int *argc_p, char ***argv_p, int tca_
 			pure_flags |= SKBEDIT_F_INHERITDSFIELD;
 			ok++;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
@@ -146,7 +149,7 @@ parse_skbedit(const struct action_util *a, int *argc_p, char ***argv_p, int tca_
 	}
 
 	if (!ok) {
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/m_skbmod.c b/tc/m_skbmod.c
index a13581be..a75cb0f5 100644
--- a/tc/m_skbmod.c
+++ b/tc/m_skbmod.c
@@ -20,9 +20,9 @@
 #include "tc_util.h"
 #include <linux/tc_act/tc_skbmod.h>
 
-static void skbmod_explain(void)
+static void skbmod_explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:... skbmod { set <SETTABLE> | swap <SWAPPABLE> | ecn } [CONTROL] [index INDEX]\n"
 		"where SETTABLE is: [dmac DMAC] [smac SMAC] [etype ETYPE]\n"
 		"where SWAPPABLE is: \"mac\" to swap mac addresses\n"
@@ -34,10 +34,12 @@ static void skbmod_explain(void)
 		"\tINDEX := skbmod index value to use\n");
 }
 
-static void skbmod_usage(void)
+static void skbmod_usage(bool help) __attribute__((noreturn));
+
+static void skbmod_usage(bool help)
 {
-	skbmod_explain();
-	exit(-1);
+	skbmod_explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_skbmod(const struct action_util *a, int *argc_p, char ***argv_p,
@@ -110,7 +112,7 @@ static int parse_skbmod(const struct action_util *a, int *argc_p, char ***argv_p
 			p.flags |= SKBMOD_F_ECN;
 			ok += 1;
 		} else if (matches(*argv, "help") == 0) {
-			skbmod_usage();
+			skbmod_usage(true);
 		} else {
 			break;
 		}
@@ -136,7 +138,7 @@ static int parse_skbmod(const struct action_util *a, int *argc_p, char ***argv_p
 
 	if (!ok) {
 		fprintf(stderr, "skbmod requires at least one option\n");
-		skbmod_usage();
+		skbmod_usage(false);
 	}
 
 	tail = addattr_nest(n, MAX_MSG, tca_id);
diff --git a/tc/m_tunnel_key.c b/tc/m_tunnel_key.c
index b65d88e0..ea593e4f 100644
--- a/tc/m_tunnel_key.c
+++ b/tc/m_tunnel_key.c
@@ -15,9 +15,9 @@
 #include "tc_util.h"
 #include <linux/tc_act/tc_tunnel_key.h>
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: tunnel_key unset\n"
 		"       tunnel_key set <TUNNEL_KEY>\n"
 		"Where TUNNEL_KEY is a combination of:\n"
@@ -30,10 +30,12 @@ static void explain(void)
 		"nofrag\n");
 }
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int tunnel_key_parse_ip_addr(const char *str, int addr4_type,
@@ -336,7 +338,7 @@ static int parse_tunnel_key(const struct action_util *a, int *argc_p, char ***ar
 			if (action) {
 				fprintf(stderr, "unexpected \"%s\" - action already specified\n",
 					*argv);
-				explain();
+				explain(false);
 				return -1;
 			}
 			action = TCA_TUNNEL_KEY_ACT_RELEASE;
@@ -344,7 +346,7 @@ static int parse_tunnel_key(const struct action_util *a, int *argc_p, char ***ar
 			if (action) {
 				fprintf(stderr, "unexpected \"%s\" - action already specified\n",
 					*argv);
-				explain();
+				explain(false);
 				return -1;
 			}
 			action = TCA_TUNNEL_KEY_ACT_SET;
@@ -429,7 +431,7 @@ static int parse_tunnel_key(const struct action_util *a, int *argc_p, char ***ar
 		} else if (strcmp(*argv, "nofrag") == 0) {
 			nofrag = 1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
@@ -459,7 +461,7 @@ static int parse_tunnel_key(const struct action_util *a, int *argc_p, char ***ar
 	if (action == TCA_TUNNEL_KEY_ACT_SET &&
 	    (!has_src_ip || !has_dst_ip)) {
 		fprintf(stderr, "set needs tunnel_key parameters\n");
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/m_vlan.c b/tc/m_vlan.c
index 5ff8c712..0cb8b8af 100644
--- a/tc/m_vlan.c
+++ b/tc/m_vlan.c
@@ -23,9 +23,9 @@ static const char * const action_names[] = {
 	[TCA_VLAN_ACT_PUSH_ETH] = "push_eth",
 };
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: vlan pop [CONTROL]\n"
 		"       vlan push [ protocol VLANPROTO ] id VLANID [ priority VLANPRIO ] [CONTROL]\n"
 		"       vlan modify [ protocol VLANPROTO ] id VLANID [ priority VLANPRIO ] [CONTROL]\n"
@@ -37,10 +37,12 @@ static void explain(void)
 		"                  goto chain <CHAIN_INDEX>\n");
 }
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	explain();
-	exit(-1);
+	explain(help);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static bool has_push_attribs(int action)
@@ -53,7 +55,7 @@ static void unexpected(const char *arg)
 	fprintf(stderr,
 		"unexpected \"%s\" - action already specified\n",
 		arg);
-	explain();
+	explain(false);
 }
 
 static int parse_vlan(const struct action_util *a, int *argc_p, char ***argv_p,
@@ -152,7 +154,7 @@ static int parse_vlan(const struct action_util *a, int *argc_p, char ***argv_p,
 				invarg("src_mac is invalid", *argv);
 			src_mac_set = 1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			break;
 		}
@@ -178,7 +180,7 @@ static int parse_vlan(const struct action_util *a, int *argc_p, char ***argv_p,
 	if (has_push_attribs(action) && !id_set) {
 		fprintf(stderr, "id needs to be set for %s\n",
 			action_names[action]);
-		explain();
+		explain(false);
 		return -1;
 	}
 
@@ -186,12 +188,12 @@ static int parse_vlan(const struct action_util *a, int *argc_p, char ***argv_p,
 		if (!dst_mac_set) {
 			fprintf(stderr, "dst_mac needs to be set for %s\n",
 				action_names[action]);
-			explain();
+			explain(false);
 			return -1;
 		} else if (!src_mac_set) {
 			fprintf(stderr, "src_mac needs to be set for %s\n",
 				action_names[action]);
-			explain();
+			explain(false);
 			return -1;
 		}
 	}
@@ -205,7 +207,7 @@ static int parse_vlan(const struct action_util *a, int *argc_p, char ***argv_p,
 		if (proto != htons(ETH_P_8021Q) &&
 		    proto != htons(ETH_P_8021AD)) {
 			fprintf(stderr, "protocol not supported\n");
-			explain();
+			explain(false);
 			return -1;
 		}
 
diff --git a/tc/q_cake.c b/tc/q_cake.c
index 250cc8b6..dfc749c4 100644
--- a/tc/q_cake.c
+++ b/tc/q_cake.c
@@ -68,9 +68,9 @@ static struct cake_preset *find_preset(char *argv)
 	return NULL;
 }
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... cake [ bandwidth RATE | unlimited* | autorate-ingress ]\n"
 		"                [ rtt TIME | datacentre | lan | metro | regional |\n"
 		"                  internet* | oceanic | satellite | interplanetary ]\n"
@@ -86,6 +86,9 @@ static void explain(void)
 		"                [ ptm | atm | noatm* ] [ overhead N | conservative | raw* ]\n"
 		"                [ mpu N ] [ ingress | egress* ]\n"
 		"                (* marks defaults)\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int cake_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -341,11 +344,10 @@ static int cake_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 				return -1;
 			}
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_cbs.c b/tc/q_cbs.c
index 5adfee7f..cf9015a7 100644
--- a/tc/q_cbs.c
+++ b/tc/q_cbs.c
@@ -17,11 +17,14 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... cbs hicredit BYTES locredit BYTES sendslope BPS idleslope BPS\n"
 		"	   [offload 0|1]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void explain1(const char *arg, const char *val)
@@ -87,11 +90,10 @@ static int cbs_parse_opt(const struct qdisc_util *qu, int argc,
 				return -1;
 			}
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "cbs: unknown parameter \"%s\"\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_choke.c b/tc/q_choke.c
index a16f5f68..94b961d5 100644
--- a/tc/q_choke.c
+++ b/tc/q_choke.c
@@ -20,11 +20,14 @@
 
 #include "tc_red.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... choke limit PACKETS bandwidth KBPS [ecn]\n"
 		"		 [ min PACKETS ] [ max PACKETS ] [ burst PACKETS ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int choke_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -92,11 +95,10 @@ static int choke_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 				return -1;
 			}
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_clsact.c b/tc/q_clsact.c
index 5bd9eb20..53f2b2c7 100644
--- a/tc/q_clsact.c
+++ b/tc/q_clsact.c
@@ -5,17 +5,23 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... clsact\n");
+	fprintf(help ? stdout : stderr, "Usage: ... clsact\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int clsact_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			    struct nlmsghdr *n, const char *dev)
 {
 	if (argc > 0) {
-		fprintf(stderr, "What is \"%s\"?\n", *argv);
-		explain();
+		bool help = strcmp(*argv, "help") == 0;
+
+		if (!help)
+			fprintf(stderr, "What is \"%s\"?\n", *argv);
+		explain(help);
 		return -1;
 	}
 
diff --git a/tc/q_codel.c b/tc/q_codel.c
index 15029b4c..20a8ee3f 100644
--- a/tc/q_codel.c
+++ b/tc/q_codel.c
@@ -20,12 +20,15 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... codel [ limit PACKETS ] [ target TIME ]\n"
 		"		 [ interval TIME ] [ ecn | noecn ]\n"
 		"		 [ ce_threshold TIME ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int codel_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -68,11 +71,10 @@ static int codel_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 		} else if (strcmp(*argv, "noecn") == 0) {
 			ecn = 0;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_drr.c b/tc/q_drr.c
index add684d5..277fda7b 100644
--- a/tc/q_drr.c
+++ b/tc/q_drr.c
@@ -17,14 +17,20 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... drr\n");
+	fprintf(help ? stdout : stderr, "Usage: ... drr\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
-static void explain2(void)
+static void explain2(bool help)
 {
-	fprintf(stderr, "Usage: ... drr quantum SIZE\n");
+	fprintf(help ? stdout : stderr, "Usage: ... drr quantum SIZE\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 
@@ -33,11 +39,10 @@ static int drr_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 {
 	while (argc) {
 		if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 	}
@@ -61,11 +66,10 @@ static int drr_parse_class_opt(const struct qdisc_util *qu, int argc, char **arg
 			}
 			addattr_l(n, 1024, TCA_DRR_QUANTUM, &tmp, sizeof(tmp));
 		} else if (strcmp(*argv, "help") == 0) {
-			explain2();
-			return -1;
+			explain2(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain2();
+			explain2(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_dualpi2.c b/tc/q_dualpi2.c
index dab74203..087051a1 100644
--- a/tc/q_dualpi2.c
+++ b/tc/q_dualpi2.c
@@ -76,21 +76,26 @@ static const char *get_ecn_type_json(uint8_t ect)
 	}
 }
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... dualpi2\n");
-	fprintf(stderr, "               [limit PACKETS]\n");
-	fprintf(stderr, "               [memlimit BYTES]\n");
-	fprintf(stderr, "               [coupling_factor NUMBER]\n");
-	fprintf(stderr, "               [step_thresh TIME|PACKETS]\n");
-	fprintf(stderr, "               [min_qlen_step PACKETS]\n");
-	fprintf(stderr, "               [drop_on_overload|overflow]\n");
-	fprintf(stderr, "               [drop_enqueue|drop_dequeue]\n");
-	fprintf(stderr, "               [classic_protection PERCENTAGE]\n");
-	fprintf(stderr, "               [max_rtt TIME [typical_rtt TIME]]\n");
-	fprintf(stderr, "               [target TIME] [tupdate TIME]\n");
-	fprintf(stderr, "               [alpha ALPHA] [beta BETA]\n");
-	fprintf(stderr, "               [split_gso|no_split_gso]\n");
+	FILE *fp = help ? stdout : stderr;
+
+	fprintf(fp, "Usage: ... dualpi2\n"
+		"               [limit PACKETS]\n"
+		"               [memlimit BYTES]\n"
+		"               [coupling_factor NUMBER]\n"
+		"               [step_thresh TIME|PACKETS]\n"
+		"               [min_qlen_step PACKETS]\n"
+		"               [drop_on_overload|overflow]\n"
+		"               [drop_enqueue|drop_dequeue]\n"
+		"               [classic_protection PERCENTAGE]\n"
+		"               [max_rtt TIME [typical_rtt TIME]]\n"
+		"               [target TIME] [tupdate TIME]\n"
+		"               [alpha ALPHA] [beta BETA]\n"
+		"               [split_gso|no_split_gso]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int get_packets(uint32_t *val, const char *arg)
@@ -272,11 +277,10 @@ static int dualpi2_parse_opt(const struct qdisc_util *qu, int argc,
 				return -1;
 			}
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		--argc;
diff --git a/tc/q_etf.c b/tc/q_etf.c
index 4e89f723..b6c07272 100644
--- a/tc/q_etf.c
+++ b/tc/q_etf.c
@@ -19,11 +19,14 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... etf delta NANOS clockid CLOCKID [offload] [deadline_mode]\n"
 		"CLOCKID must be a valid SYS-V id (i.e. CLOCK_TAI)\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void explain1(const char *arg, const char *val)
@@ -90,11 +93,10 @@ static int etf_parse_opt(const struct qdisc_util *qu, int argc,
 
 			opt.flags |= TC_ETF_SKIP_SOCK_CHECK;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "etf: unknown parameter \"%s\"\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_ets.c b/tc/q_ets.c
index dea5f044..5a5aa24e 100644
--- a/tc/q_ets.c
+++ b/tc/q_ets.c
@@ -16,14 +16,21 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... ets [bands NUMBER] [strict NUMBER] [quanta Q1 Q2...] [priomap P1 P2...]\n");
+	fprintf(help ? stdout : stderr,
+		"Usage: ... ets [bands NUMBER] [strict NUMBER] [quanta Q1 Q2...] [priomap P1 P2...]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
-static void cexplain(void)
+static void cexplain(bool help)
 {
-	fprintf(stderr, "Usage: ... ets [quantum Q1]\n");
+	fprintf(help ? stdout : stderr, "Usage: ... ets [quantum Q1]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static unsigned int parse_quantum(const char *arg)
@@ -109,8 +116,7 @@ static int ets_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			quanta_mode = false;
 			goto parse_priomap;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else if (quanta_mode) {
 			unsigned int quantum;
 
@@ -134,7 +140,7 @@ parse_priomap:
 			priomap[nprio++] = band;
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
@@ -144,12 +150,12 @@ parse_priomap:
 		nbands = nquanta + nstrict;
 	if (!nbands) {
 		fprintf(stderr, "One of \"bands\", \"quanta\" or \"strict\" needs to be specified\n");
-		explain();
+		explain(false);
 		return -1;
 	}
 	if (nstrict + nquanta > nbands) {
 		fprintf(stderr, "Not enough total bands to cover all the strict bands and quanta\n");
-		explain();
+		explain(false);
 		return -1;
 	}
 	for (tmp = 0; tmp < nprio; tmp++) {
@@ -199,11 +205,10 @@ static int ets_parse_copt(const struct qdisc_util *qu, int argc, char **argv,
 			if (!quantum)
 				return -1;
 		} else if (strcmp(*argv, "help") == 0) {
-			cexplain();
-			return -1;
+			cexplain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			cexplain();
+			cexplain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_fifo.c b/tc/q_fifo.c
index 489208dc..b61e6d8c 100644
--- a/tc/q_fifo.c
+++ b/tc/q_fifo.c
@@ -17,9 +17,13 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... <[p|b]fifo | pfifo_head_drop> [ limit NUMBER ]\n");
+	fprintf(help ? stdout : stderr,
+		"Usage: ... <[p|b]fifo | pfifo_head_drop> [ limit NUMBER ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int fifo_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -37,11 +41,10 @@ static int fifo_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			}
 			ok++;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "%s: unknown parameter \"%s\"\n", qu->id, *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_fq.c b/tc/q_fq.c
index 13c5a896..56bfa58a 100644
--- a/tc/q_fq.c
+++ b/tc/q_fq.c
@@ -18,9 +18,9 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... fq	[ limit PACKETS ] [ flow_limit PACKETS ]\n"
 		"		[ quantum BYTES ] [ initial_quantum BYTES ]\n"
 		"		[ maxrate RATE ] [ buckets NUMBER ]\n"
@@ -34,6 +34,9 @@ static void explain(void)
 		"		[ horizon TIME ]\n"
 		"		[ horizon_{cap|drop} ]\n"
 		"		[ offload_horizon TIME ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static unsigned int ilog2(unsigned int val)
@@ -278,11 +281,10 @@ static int fq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			}
 			set_weights = true;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_fq_codel.c b/tc/q_fq_codel.c
index a619d2b3..415780ba 100644
--- a/tc/q_fq_codel.c
+++ b/tc/q_fq_codel.c
@@ -17,9 +17,9 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... fq_codel	[ limit PACKETS ] [ flows NUMBER ]\n"
 					"[ memory_limit BYTES ]\n"
 					"[ target TIME ] [ interval TIME ]\n"
@@ -27,6 +27,9 @@ static void explain(void)
 					"[ ce_threshold TIME ]\n"
 					"[ ce_threshold_selector VALUE/MASK ]\n"
 					"[ drop_batch SIZE ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int fq_codel_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -117,11 +120,10 @@ static int fq_codel_parse_opt(const struct qdisc_util *qu, int argc, char **argv
 		} else if (strcmp(*argv, "noecn") == 0) {
 			ecn = 0;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_fq_pie.c b/tc/q_fq_pie.c
index dc2710cd..635d0750 100644
--- a/tc/q_fq_pie.c
+++ b/tc/q_fq_pie.c
@@ -22,15 +22,18 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... fq_pie [ limit PACKETS ] [ flows NUMBER ]\n"
 		"                  [ target TIME ] [ tupdate TIME ]\n"
 		"                  [ alpha NUMBER ] [ beta NUMBER ]\n"
 		"                  [ quantum BYTES ] [ memory_limit BYTES ]\n"
 		"                  [ ecn_prob PERCENTAGE ] [ [no]ecn ]\n"
 		"                  [ [no]bytemode ] [ [no_]dq_rate_estimator ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 #define ALPHA_MAX 32
@@ -124,11 +127,10 @@ static int fq_pie_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 		} else if (strcmp(*argv, "no_dq_rate_estimator") == 0) {
 			dq_rate_estimator = 0;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 
diff --git a/tc/q_gred.c b/tc/q_gred.c
index 95573218..b829c878 100644
--- a/tc/q_gred.c
+++ b/tc/q_gred.c
@@ -29,14 +29,17 @@
 #define DPRINTF(format, args...)
 #endif
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: tc qdisc { add | replace | change } ... gred setup vqs NUMBER\n"
 		"           default DEFAULT_VQ [ grio ] [ limit BYTES ] [ecn] [harddrop]\n"
 		"       tc qdisc change ... gred vq VQ [ prio VALUE ] limit BYTES\n"
 		"           min BYTES max BYTES avpkt BYTES [ burst PACKETS ]\n"
 		"           [ probability PROBABILITY ] [ bandwidth KBPS ] [ecn] [harddrop]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int init_gred(const struct qdisc_util *qu, int argc, char **argv,
@@ -88,11 +91,10 @@ static int init_gred(const struct qdisc_util *qu, int argc, char **argv,
 		} else if (strcmp(*argv, "harddrop") == 0) {
 			opt.flags |= TC_RED_HARDDROP;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
@@ -214,18 +216,17 @@ static int gred_parse_opt(const struct qdisc_util *qu, int argc, char **argv, st
 		} else if (strcmp(*argv, "harddrop") == 0) {
 			flags |= TC_RED_HARDDROP;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
 	}
 
 	if (!ok) {
-		explain();
+		explain(false);
 		return -1;
 	}
 	if (opt.DP == MAX_DPs || !opt.limit || !opt.qth_min || !opt.qth_max ||
diff --git a/tc/q_hfsc.c b/tc/q_hfsc.c
index f68e8351..ec143080 100644
--- a/tc/q_hfsc.c
+++ b/tc/q_hfsc.c
@@ -22,19 +22,22 @@ static int hfsc_get_sc(int *, char ***,
 		       struct tc_service_curve *, const char *);
 
 static void
-explain_qdisc(void)
+explain_qdisc(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... hfsc [ default CLASSID ]\n"
 		"\n"
 		" default: default class for unclassified packets\n"
 	);
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void
-explain_class(void)
+explain_class(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... hfsc [ [ rt SC ] [ ls SC ] | [ sc SC ] ] [ ul SC ]\n"
 		"\n"
 		"SC := [ [ m1 BPS ] d SEC ] m2 BPS\n"
@@ -56,6 +59,9 @@ explain_class(void)
 		" - 'ul' can only be specified with 'ls' or 'sc'\n"
 		"\n"
 	);
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void
@@ -82,11 +88,10 @@ hfsc_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 				return -1;
 			}
 		} else if (matches(*argv, "help") == 0) {
-			explain_qdisc();
-			return -1;
+			explain_qdisc(true);
 		} else {
 			fprintf(stderr, "HFSC: What is \"%s\" ?\n", *argv);
-			explain_qdisc();
+			explain_qdisc(false);
 			return -1;
 		}
 		argc--, argv++;
@@ -178,11 +183,10 @@ hfsc_parse_class_opt(const struct qdisc_util *qu, int argc, char **argv,
 			}
 			usc_ok = 1;
 		} else if (matches(*argv, "help") == 0) {
-			explain_class();
-			return -1;
+			explain_class(true);
 		} else {
 			fprintf(stderr, "HFSC: What is \"%s\" ?\n", *argv);
-			explain_class();
+			explain_class(false);
 			return -1;
 		}
 		argc--, argv++;
@@ -190,12 +194,12 @@ hfsc_parse_class_opt(const struct qdisc_util *qu, int argc, char **argv,
 
 	if (!(rsc_ok || fsc_ok || usc_ok)) {
 		fprintf(stderr, "HFSC: no parameters given\n");
-		explain_class();
+		explain_class(false);
 		return -1;
 	}
 	if (usc_ok && !fsc_ok) {
 		fprintf(stderr, "HFSC: Upper-limit Service Curve without Link-Share Service Curve\n");
-		explain_class();
+		explain_class(false);
 		return -1;
 	}
 
diff --git a/tc/q_hhf.c b/tc/q_hhf.c
index 939e4909..aa62228f 100644
--- a/tc/q_hhf.c
+++ b/tc/q_hhf.c
@@ -15,15 +15,18 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... hhf	[ limit PACKETS ] [ quantum BYTES]\n"
 		"		[ hh_limit NUMBER ]\n"
 		"		[ reset_timeout TIME ]\n"
 		"		[ admit_bytes BYTES ]\n"
 		"		[ evict_timeout TIME ]\n"
 		"		[ non_hh_weight NUMBER ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int hhf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -82,11 +85,10 @@ static int hhf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 				return -1;
 			}
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_htb.c b/tc/q_htb.c
index a3ad4215..1b746eda 100644
--- a/tc/q_htb.c
+++ b/tc/q_htb.c
@@ -21,9 +21,10 @@
 #error "Different kernel and TC HTB versions"
 #endif
 
-static void explain(void)
+static void explain(FILE *fp)
 {
-	fprintf(stderr, "Usage: ... qdisc add ... htb [default N] [r2q N]\n"
+	fprintf(fp,
+		"Usage: ... qdisc add ... htb [default N] [r2q N]\n"
 		"                      [direct_qlen P] [offload]\n"
 		" default  minor id of class to which unclassified packets are sent {0}\n"
 		" r2q      DRR quantums are computed as rate in Bps/r2q {10}\n"
@@ -50,7 +51,8 @@ static void explain(void)
 static void explain1(char *arg)
 {
 	fprintf(stderr, "Illegal \"%s\"\n", arg);
-	explain();
+	explain(stderr);
+	exit(EXIT_FAILURE);
 }
 
 static int htb_parse_opt(const struct qdisc_util *qu, int argc,
@@ -89,9 +91,12 @@ static int htb_parse_opt(const struct qdisc_util *qu, int argc,
 			}
 		} else if (matches(*argv, "offload") == 0) {
 			offload = true;
+		} else if (strcmp(*argv, "help") == 0) {
+			explain(stdout);
+			exit(EXIT_SUCCESS);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(stderr);
 			return -1;
 		}
 		argc--; argv++;
@@ -202,11 +207,11 @@ static int htb_parse_class_opt(const struct qdisc_util *qu, int argc, char **arg
 				return -1;
 			}
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(stdout);
+			exit(EXIT_SUCCESS);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(stderr);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_ingress.c b/tc/q_ingress.c
index 294b0051..5dad5aea 100644
--- a/tc/q_ingress.c
+++ b/tc/q_ingress.c
@@ -11,9 +11,12 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... ingress\n");
+	fprintf(help ? stdout : stderr, "Usage: ... ingress\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int ingress_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -24,8 +27,11 @@ static int ingress_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			NEXT_ARG();
 			argc--; argv++;
 		} else {
-			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			bool help = strcmp(*argv, "help") == 0;
+
+			if (!help)
+				fprintf(stderr, "What is \"%s\"?\n", *argv);
+			explain(help);
 			return -1;
 		}
 	}
diff --git a/tc/q_mqprio.c b/tc/q_mqprio.c
index 493c6eb5..a1500197 100644
--- a/tc/q_mqprio.c
+++ b/tc/q_mqprio.c
@@ -17,9 +17,9 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... mqprio	[num_tc NUMBER] [map P0 P1 ...]\n"
 		"			[queues count1@offset1 count2@offset2 ...] "
 		"[hw 1|0]\n"
@@ -28,6 +28,9 @@ static void explain(void)
 		"			[shaper bw_rlimit SHAPER_PARAMS]\n"
 		"Where: SHAPER_PARAMS := { min_rate MIN_RATE1 MIN_RATE2 ...|\n"
 		"			  max_rate MAX_RATE1 MAX_RATE2 ... }\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void add_tc_entries(struct nlmsghdr *n, __u32 fp[TC_QOPT_MAX_QUEUE],
@@ -198,8 +201,7 @@ static int mqprio_parse_opt(const struct qdisc_util *qu, int argc,
 			}
 			flags |= TC_MQPRIO_F_MAX_RATE;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			invarg("unknown argument", *argv);
 		}
diff --git a/tc/q_multiq.c b/tc/q_multiq.c
index 0e8e2f9e..84f75112 100644
--- a/tc/q_multiq.c
+++ b/tc/q_multiq.c
@@ -23,9 +23,12 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... multiq [help]\n");
+	fprintf(help ? stdout : stderr, "Usage: ... multiq [help]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int multiq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -35,11 +38,10 @@ static int multiq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 
 	if (argc) {
 		if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 	}
diff --git a/tc/q_netem.c b/tc/q_netem.c
index 0e47765b..7051aa98 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -20,9 +20,9 @@
 #include "tc_util.h"
 #include "tc_common.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... netem [ limit PACKETS ]\n"
 		"                 [ delay TIME [ JITTER [ CORRELATION ] ] ]\n"
 		"                 [ distribution {uniform|normal|pareto|paretonormal} ]\n"
@@ -38,6 +38,9 @@ static void explain(void)
 		"                 [ slot MIN_DELAY [ MAX_DELAY ] [ packets MAX_PACKETS ] [ bytes MAX_BYTES ] ]\n"
 		"                 [ slot distribution {uniform|normal|pareto|paretonormal|custom}\n"
 		"                   DELAY JITTER [ packets MAX_PACKETS ] [ bytes MAX_BYTES ] ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void explain1(const char *arg)
@@ -531,9 +534,11 @@ random_loss_model:
 				NEXT_ARG();
 			}
 		} else {
-			if (strcmp(*argv, "help") != 0)
+			bool help = strcmp(*argv, "help") == 0;
+
+			if (!help)
 				fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(help);
 			return -1;
 		}
 	}
@@ -543,28 +548,28 @@ random_loss_model:
 	if (reorder.probability) {
 		if (latency64 == 0) {
 			fprintf(stderr, "reordering not possible without specifying some delay\n");
-			explain();
+			explain(false);
 			return -1;
 		}
 		if (opt.gap == 0)
 			opt.gap = 1;
 	} else if (opt.gap > 0) {
 		fprintf(stderr, "gap specified without reorder probability\n");
-		explain();
+		explain(false);
 		return -1;
 	}
 
 	if (present[TCA_NETEM_ECN]) {
 		if (opt.loss <= 0 && loss_type == NETEM_LOSS_UNSPEC) {
 			fprintf(stderr, "ecn requested without loss model\n");
-			explain();
+			explain(false);
 			return -1;
 		}
 	}
 
 	if (dist_data && (latency64 == 0 || jitter64 == 0)) {
 		fprintf(stderr, "distribution specified but no latency and jitter values\n");
-		explain();
+		explain(false);
 		return -1;
 	}
 
diff --git a/tc/q_pie.c b/tc/q_pie.c
index 04c9aa61..e5c99432 100644
--- a/tc/q_pie.c
+++ b/tc/q_pie.c
@@ -18,13 +18,16 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... pie [ limit PACKETS ] [ target TIME ]\n"
 		"               [ tupdate TIME ] [ alpha ALPHA ] [ beta BETA ]\n"
 		"               [ bytemode | nobytemode ] [ ecn | noecn ]\n"
 		"               [ dq_rate_estimator | no_dq_rate_estimator ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 #define ALPHA_MAX 32
@@ -89,11 +92,10 @@ static int pie_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 		} else if (strcmp(*argv, "no_dq_rate_estimator") == 0) {
 			dq_rate_estimator = 0;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--;
diff --git a/tc/q_plug.c b/tc/q_plug.c
index 257735a2..3757f72f 100644
--- a/tc/q_plug.c
+++ b/tc/q_plug.c
@@ -17,9 +17,13 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... plug [block | release | release_indefinite | limit NUMBER]\n");
+	fprintf(help ? stdout : stderr,
+		"Usage: ... plug [block | release | release_indefinite | limit NUMBER]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int plug_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -47,11 +51,10 @@ static int plug_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			}
 			ok++;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "%s: unknown parameter \"%s\"\n", qu->id, *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_prio.c b/tc/q_prio.c
index 41bd98a5..aee6301f 100644
--- a/tc/q_prio.c
+++ b/tc/q_prio.c
@@ -17,9 +17,13 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... prio bands NUMBER priomap P1 P2...[multiqueue]\n");
+	fprintf(help ? stdout : stderr,
+		"Usage: ... prio bands NUMBER priomap P1 P2...[multiqueue]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int prio_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -34,7 +38,7 @@ static int prio_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	while (argc > 0) {
 		if (strcmp(*argv, "bands") == 0) {
 			if (pmap_mode)
-				explain();
+				explain(false);
 			NEXT_ARG();
 			if (get_integer(&opt.bands, *argv, 10)) {
 				fprintf(stderr, "Illegal \"bands\"\n");
@@ -49,14 +53,13 @@ static int prio_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 		} else if (strcmp(*argv, "multiqueue") == 0) {
 			mq = 1;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			unsigned int band;
 
 			if (!pmap_mode) {
 				fprintf(stderr, "What is \"%s\"?\n", *argv);
-				explain();
+				explain(false);
 				return -1;
 			}
 			if (get_unsigned(&band, *argv, 10)) {
diff --git a/tc/q_qfq.c b/tc/q_qfq.c
index 04061fcc..62d01c29 100644
--- a/tc/q_qfq.c
+++ b/tc/q_qfq.c
@@ -15,9 +15,12 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... qfq\n");
+	fprintf(help ? stdout : stderr, "Usage: ... qfq\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void explain1(const char *arg)
@@ -25,18 +28,24 @@ static void explain1(const char *arg)
 	fprintf(stderr, "Illegal \"%s\"\n", arg);
 }
 
-static void explain_class(void)
+static void explain_class(bool help)
 {
-	fprintf(stderr, "Usage: ... qfq weight NUMBER maxpkt BYTES\n");
+	fprintf(help ? stdout : stderr,
+		"Usage: ... qfq weight NUMBER maxpkt BYTES\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int qfq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
 	if (argc > 0) {
-		if (matches(*argv, "help") != 0)
+		bool help = matches(*argv, "help") == 0;
+
+		if (!help)
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-		explain();
+		explain(help);
 		return -1;
 	}
 
@@ -65,11 +74,10 @@ static int qfq_parse_class_opt(const struct qdisc_util *qu, int argc, char **arg
 			}
 			addattr32(n, 4096, TCA_QFQ_LMAX, tmp);
 		} else if (strcmp(*argv, "help") == 0) {
-			explain_class();
-			return -1;
+			explain_class(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain_class();
+			explain_class(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_red.c b/tc/q_red.c
index 1aa6d2b1..468f8afc 100644
--- a/tc/q_red.c
+++ b/tc/q_red.c
@@ -21,13 +21,16 @@
 
 #include "tc_red.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... red	limit BYTES [min BYTES] [max BYTES] avpkt BYTES [burst PACKETS]\n"
 		"		[adaptive] [probability PROBABILITY] [bandwidth KBPS]\n"
 		"		[ecn] [harddrop] [nodrop]\n"
 		"		[qevent early_drop block IDX] [qevent mark block IDX]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 #define RED_SUPPORTED_FLAGS (TC_RED_HISTORIC_FLAGS | TC_RED_NODROP)
@@ -122,11 +125,10 @@ static int red_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 				return -1;
 			continue;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_sfb.c b/tc/q_sfb.c
index 6a26b71a..e2be0eef 100644
--- a/tc/q_sfb.c
+++ b/tc/q_sfb.c
@@ -17,13 +17,16 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... sfb [ rehash SECS ] [ db SECS ]\n"
 		"	    [ limit PACKETS ] [ max PACKETS ] [ target PACKETS ]\n"
 		"	    [ increment FLOAT ] [ decrement FLOAT ]\n"
 		"	    [ penalty_rate PPS ] [ penalty_burst PACKETS ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int get_prob(__u32 *val, const char *arg)
@@ -109,8 +112,11 @@ static int sfb_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 				return -1;
 			}
 		} else {
-			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			bool help = strcmp(*argv, "help") == 0;
+
+			if (!help)
+				fprintf(stderr, "What is \"%s\"?\n", *argv);
+			explain(help);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_sfq.c b/tc/q_sfq.c
index 37ebd977..29560532 100644
--- a/tc/q_sfq.c
+++ b/tc/q_sfq.c
@@ -19,15 +19,18 @@
 #include "tc_util.h"
 #include "tc_red.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... sfq	[ limit NUMBER ] [ perturb SECS ] [ quantum BYTES ]\n"
 		"		[ divisor NUMBER ] [ flows NUMBER] [ depth NUMBER ]\n"
 		"		[ headdrop ]\n"
 		"		[ redflowlimit BYTES ] [ min BYTES ] [ max BYTES ]\n"
 		"		[ avpkt BYTES ] [ burst PACKETS ] [ probability P ]\n"
 		"		[ ecn ] [ harddrop ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int sfq_parse_opt(const struct qdisc_util *qu, int argc, char **argv, struct nlmsghdr *n, const char *dev)
@@ -138,11 +141,10 @@ static int sfq_parse_opt(const struct qdisc_util *qu, int argc, char **argv, str
 			opt.flags |= TC_RED_HARDDROP;
 			red++;
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_skbprio.c b/tc/q_skbprio.c
index 910ea998..03406a3e 100644
--- a/tc/q_skbprio.c
+++ b/tc/q_skbprio.c
@@ -18,9 +18,13 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr, "Usage: ... <skbprio> [ limit NUMBER ]\n");
+	fprintf(help ? stdout : stderr,
+		"Usage: ... <skbprio> [ limit NUMBER ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static int skbprio_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
@@ -41,13 +45,12 @@ static int skbprio_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 			ok++;
 		}
 		else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr,
 				"%s: unknown parameter \"%s\"\n",
 				qu->id, *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index 689c7a8f..945e1edf 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -29,9 +29,9 @@ struct sched_entry {
 	uint8_t cmd;
 };
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... taprio clockid CLOCKID\n"
 		"		[num_tc NUMBER] [map P0 P1 ...]\n"
 		"		[queues COUNT@OFFSET COUNT@OFFSET COUNT@OFFSET ...]\n"
@@ -40,6 +40,9 @@ static void explain(void)
 		"		[fp FP0 FP1 FP2 ...]\n"
 		"\n"
 		"CLOCKID must be a valid SYS-V id (i.e. CLOCK_TAI)\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void explain_clockid(const char *val)
@@ -328,8 +331,7 @@ static int taprio_parse_opt(const struct qdisc_util *qu, int argc,
 			}
 
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "Unknown argument\n");
 			return -1;
diff --git a/tc/q_tbf.c b/tc/q_tbf.c
index cbe11025..dc7f2d90 100644
--- a/tc/q_tbf.c
+++ b/tc/q_tbf.c
@@ -17,12 +17,15 @@
 #include "utils.h"
 #include "tc_util.h"
 
-static void explain(void)
+static void explain(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... tbf limit BYTES burst BYTES[/BYTES] rate KBPS [ mtu BYTES[/BYTES] ]\n"
 		"	[ peakrate KBPS ] [ latency TIME ] "
 		"[ overhead BYTES ] [ linklayer TYPE ]\n");
+
+	if (help)
+		exit(EXIT_SUCCESS);
 }
 
 static void explain1(const char *arg, const char *val)
@@ -155,11 +158,10 @@ static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 				explain1("linklayer", *argv); return -1;
 			}
 		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
+			explain(true);
 		} else {
 			fprintf(stderr, "tbf: unknown parameter \"%s\"\n", *argv);
-			explain();
+			explain(false);
 			return -1;
 		}
 		argc--; argv++;
@@ -192,7 +194,7 @@ static int tbf_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	}
 
 	if (verdict != 0) {
-		explain();
+		explain(false);
 		return verdict;
 	}
 
diff --git a/tc/tc.c b/tc/tc.c
index 7d69e4d5..89723f77 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -186,9 +186,9 @@ noexist:
 	return q;
 }
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:	tc [ OPTIONS ] OBJECT { COMMAND | help }\n"
 		"	tc [-force] -batch filename\n"
 		"where  OBJECT := { qdisc | class | filter | chain |\n"
@@ -217,7 +217,7 @@ static int do_cmd(int argc, char **argv)
 	if (matches(*argv, "exec") == 0)
 		return do_exec(argc-1, argv+1);
 	if (matches(*argv, "help") == 0) {
-		usage();
+		usage(true);
 		return 0;
 	}
 
@@ -282,7 +282,7 @@ int main(int argc, char **argv)
 		} else if (matches(argv[1], "-iec") == 0) {
 			++use_iec;
 		} else if (matches(argv[1], "-help") == 0) {
-			usage();
+			usage(true);
 			return 0;
 		} else if (matches(argv[1], "-force") == 0) {
 			++force;
@@ -335,8 +335,8 @@ int main(int argc, char **argv)
 		return batch(batch_file);
 
 	if (argc <= 1) {
-		usage();
-		return 0;
+		usage(false);
+		return 1;
 	}
 
 	tc_core_init();
diff --git a/tc/tc_class.c b/tc/tc_class.c
index 82f0f85e..49fa1873 100644
--- a/tc/tc_class.c
+++ b/tc/tc_class.c
@@ -34,11 +34,11 @@ struct graph_node {
 static struct hlist_head cls_list = {};
 static struct hlist_head root_cls_list = {};
 
-static void usage(void);
+static void usage(bool help);
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: tc class [ add | del | change | replace | show ] dev STRING\n"
 		"       [ classid CLASSID ] [ root | parent CLASSID ]\n"
 		"       [ [ QDISC_KIND ] [ help | OPTIONS ] ]\n"
@@ -103,7 +103,8 @@ static int tc_class_modify(int cmd, unsigned int flags, int argc, char **argv)
 			if (parse_estimator(&argc, &argv, &est))
 				return -1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
+			return 0;
 		} else {
 			strncpy(k, *argv, sizeof(k)-1);
 
@@ -128,8 +129,10 @@ static int tc_class_modify(int cmd, unsigned int flags, int argc, char **argv)
 			return 1;
 	} else {
 		if (argc) {
-			if (matches(*argv, "help") == 0)
-				usage();
+			if (matches(*argv, "help") == 0) {
+				usage(true);
+				return 0;
+			}
 			fprintf(stderr, "Garbage instead of arguments \"%s ...\". Try \"tc class help\".", *argv);
 			return -1;
 		}
@@ -434,7 +437,8 @@ static int tc_class_list(int argc, char **argv)
 				invarg("invalid parent ID", *argv);
 			req.t.tcm_parent = handle;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
+			return 0;
 		} else {
 			fprintf(stderr, "What is \"%s\"? Try \"tc class help\".\n", *argv);
 			return -1;
@@ -484,7 +488,7 @@ int do_class(int argc, char **argv)
 	    || matches(*argv, "lst") == 0)
 		return tc_class_list(argc-1, argv+1);
 	if (matches(*argv, "help") == 0) {
-		usage();
+		usage(true);
 		return 0;
 	}
 	fprintf(stderr, "Command \"%s\" is unknown, try \"tc class help\".\n", *argv);
diff --git a/tc/tc_exec.c b/tc/tc_exec.c
index fe9fdb1b..edc3c982 100644
--- a/tc/tc_exec.c
+++ b/tc/tc_exec.c
@@ -17,9 +17,9 @@
 static struct exec_util *exec_list;
 static void *BODY;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: tc exec [ EXEC_TYPE ] [ help | OPTIONS ]\n"
 		"Where:\n"
 		"EXEC_TYPE := { bpf | etc. }\n"
@@ -89,7 +89,7 @@ int do_exec(int argc, char **argv)
 	}
 
 	if (matches(*argv, "help") == 0) {
-		usage();
+		usage(true);
 		return 0;
 	}
 
diff --git a/tc/tc_filter.c b/tc/tc_filter.c
index 7b504029..36d51222 100644
--- a/tc/tc_filter.c
+++ b/tc/tc_filter.c
@@ -20,9 +20,9 @@
 #include "tc_util.h"
 #include "tc_common.h"
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: tc filter [ add | del | change | replace | show ] [ dev STRING ]\n"
 		"       tc filter [ add | del | change | replace | show ] [ block BLOCK_INDEX ]\n"
 		"       tc filter get dev STRING parent CLASSID protocol PROTO handle FILTERID pref PRIO FILTER_TYPE\n"
@@ -40,9 +40,9 @@ static void usage(void)
 		"OPTIONS := ... try tc filter add <desired FILTER_KIND> help\n");
 }
 
-static void chain_usage(void)
+static void chain_usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: tc chain [ add | del | get | show ] [ dev STRING ]\n"
 		"       tc chain [ add | del | get | show ] [ block BLOCK_INDEX ] ]\n");
 }
@@ -166,7 +166,7 @@ static int tc_filter_modify(int cmd, unsigned int flags, int argc, char **argv)
 			if (parse_estimator(&argc, &argv, &est) < 0)
 				return -1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 			return 0;
 		} else {
 			strncpy(k, *argv, sizeof(k)-1);
@@ -211,8 +211,10 @@ static int tc_filter_modify(int cmd, unsigned int flags, int argc, char **argv)
 			return -1;
 		}
 		if (argc) {
-			if (matches(*argv, "help") == 0)
-				usage();
+			if (matches(*argv, "help") == 0) {
+				usage(true);
+				return 0;
+			}
 			fprintf(stderr,
 				"Garbage instead of arguments \"%s ...\". Try \"tc filter help\".\n",
 				*argv);
@@ -491,7 +493,7 @@ static int tc_filter_get(int cmd, unsigned int flags, int argc, char **argv)
 				invarg("invalid chain index value", *argv);
 			chain_index_set = 1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 			return 0;
 		} else {
 			if (!**argv)
@@ -562,8 +564,10 @@ static int tc_filter_get(int cmd, unsigned int flags, int argc, char **argv)
 	}
 
 	if (argc) {
-		if (matches(*argv, "help") == 0)
-			usage();
+		if (matches(*argv, "help") == 0) {
+			usage(true);
+			return 0;
+		}
 		fprintf(stderr,
 			"Garbage instead of arguments \"%s ...\". Try \"tc filter help\".\n",
 			*argv);
@@ -689,7 +693,8 @@ static int tc_filter_list(int cmd, int argc, char **argv)
 			filter_chain_index_set = 1;
 			filter_chain_index = chain_index;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
+			return 0;
 		} else {
 			fprintf(stderr,
 				" What is \"%s\"? Try \"tc filter help\"\n",
@@ -769,7 +774,7 @@ int do_filter(int argc, char **argv)
 	    || matches(*argv, "lst") == 0)
 		return tc_filter_list(RTM_GETTFILTER, argc-1, argv+1);
 	if (matches(*argv, "help") == 0) {
-		usage();
+		usage(true);
 		return 0;
 	}
 	fprintf(stderr, "Command \"%s\" is unknown, try \"tc filter help\".\n",
@@ -794,7 +799,7 @@ int do_chain(int argc, char **argv)
 		   matches(*argv, "lst") == 0) {
 		return tc_filter_list(RTM_GETCHAIN, argc - 1, argv + 1);
 	} else if (matches(*argv, "help") == 0) {
-		chain_usage();
+		chain_usage(true);
 		return 0;
 	}
 	fprintf(stderr, "Command \"%s\" is unknown, try \"tc chain help\".\n",
diff --git a/tc/tc_monitor.c b/tc/tc_monitor.c
index 5b9bccbe..c2c8a43c 100644
--- a/tc/tc_monitor.c
+++ b/tc/tc_monitor.c
@@ -20,12 +20,13 @@
 #include "tc_common.h"
 
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr, "Usage: tc [-timestamp [-tshort] monitor\n");
-	exit(-1);
+	fprintf(help ? stdout : stderr,
+		"Usage: tc [-timestamp [-tshort] monitor\n");
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 
@@ -77,7 +78,7 @@ int do_tcmonitor(int argc, char **argv)
 			file = *argv;
 		} else {
 			if (matches(*argv, "help") == 0) {
-				usage();
+				usage(true);
 			} else {
 				fprintf(stderr, "Argument \"%s\" is unknown, try \"tc monitor help\".\n", *argv);
 				exit(-1);
diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
index 7c3e7cb3..f089c2fc 100644
--- a/tc/tc_qdisc.c
+++ b/tc/tc_qdisc.c
@@ -21,9 +21,9 @@
 #include "tc_util.h"
 #include "tc_common.h"
 
-static int usage(void)
+static int usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: tc qdisc [ add | del | replace | change | show ] dev STRING\n"
 		"       [ handle QHANDLE ] [ root | ingress | clsact | parent CLASSID ]\n"
 		"       [ estimator INTERVAL TIME_CONSTANT ]\n"
@@ -37,7 +37,7 @@ static int usage(void)
 		"OPTIONS := ... try tc qdisc add <desired QDISC_KIND> help\n"
 		"STAB_OPTIONS := ... try tc qdisc add stab help\n"
 		"QDISC_ID := { root | ingress | handle QHANDLE | parent CLASSID }\n");
-	return -1;
+	return help ? 0 : -1;
 }
 
 static int tc_qdisc_modify(int cmd, unsigned int flags, int argc, char **argv)
@@ -131,7 +131,7 @@ static int tc_qdisc_modify(int cmd, unsigned int flags, int argc, char **argv)
 			if (get_u32(&egress_block, *argv, 0) || !egress_block)
 				invarg("invalid egress block index value", *argv);
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			return usage(true);
 		} else {
 			strncpy(k, *argv, sizeof(k)-1);
 
@@ -165,7 +165,7 @@ static int tc_qdisc_modify(int cmd, unsigned int flags, int argc, char **argv)
 	} else {
 		if (argc) {
 			if (matches(*argv, "help") == 0)
-				usage();
+				return usage(true);
 
 			fprintf(stderr, "Garbage instead of arguments \"%s ...\". Try \"tc qdisc help\".\n", *argv);
 			return -1;
@@ -397,7 +397,7 @@ static int tc_qdisc_list(int argc, char **argv)
 				invarg("invalid handle ID", *argv);
 			filter_handle = handle;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			return usage(true);
 		} else if (strcmp(*argv, "invisible") == 0) {
 			dump_invisible = true;
 		} else {
@@ -459,7 +459,7 @@ int do_qdisc(int argc, char **argv)
 	    || matches(*argv, "lst") == 0)
 		return tc_qdisc_list(argc-1, argv+1);
 	if (matches(*argv, "help") == 0) {
-		usage();
+		usage(true);
 		return 0;
 	}
 	fprintf(stderr, "Command \"%s\" is unknown, try \"tc qdisc help\".\n", *argv);
diff --git a/tc/tc_stab.c b/tc/tc_stab.c
index a7733726..7cdef0ef 100644
--- a/tc/tc_stab.c
+++ b/tc/tc_stab.c
@@ -22,9 +22,11 @@
 #include "tc_core.h"
 #include "tc_common.h"
 
-static void stab_help(void)
+static void stab_help(bool help) __attribute__((noreturn));
+
+static void stab_help(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ... stab [ mtu BYTES ] [ tsize SLOTS ] [ mpu BYTES ]\n"
 		"                [ overhead BYTES ] [ linklayer TYPE ] ...\n"
 		"   mtu       : max packet size we create rate map for {2047}\n"
@@ -34,6 +36,7 @@ static void stab_help(void)
 		"   linklayer : adapting to a linklayer e.g. atm\n"
 		"Example: ... stab overhead 20 linklayer atm\n");
 
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 int check_size_table_opts(struct tc_sizespec *s)
@@ -49,10 +52,8 @@ int parse_size_table(int *argcp, char ***argvp, struct tc_sizespec *sp)
 	struct tc_sizespec s = {};
 
 	NEXT_ARG();
-	if (matches(*argv, "help") == 0) {
-		stab_help();
-		return -1;
-	}
+	if (matches(*argv, "help") == 0)
+		stab_help(true);
 	while (argc > 0) {
 		if (matches(*argv, "mtu") == 0) {
 			NEXT_ARG();
-- 
2.53.0

