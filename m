Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471647607C
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117395; cv=none; b=TXtmptsHCn4Hhn4nNQVYczTEoV3MTGfCif/qPA7ebXAEK6q9/lIBJhnnjCwP0xw2SjvkFAExDSiqnsu8Lma657NbbusoFYWlMj8YA9ahA0TCJmN2OFYvkepeYwPEFXupRlvrI3SL9/hN7wmLZSnnyKFRegWq4d2Wy4LDuZqeEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117395; c=relaxed/simple;
	bh=UjLQd38PqzcLTfAo6BZo96chIw4QaBPXsalBXH8yxl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBVBfrOE6STUIFOnY/rNjT/R/MAXh3N9eWHzOJKIFKaQiQIq3wyogmqhjg3yIfIg9zJzerZUR7FLM7p6LPJtFQq2inaxMx4+GepdZs6YM0S+Yy9GUm90+q96r2RMETtUL3j5412twZsrH74vVo095HeZ3ENSLEGHV6jWaYtuFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=yyk7nBn4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="yyk7nBn4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ced3386430so40453195ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786117393; x=1786722193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCbDrWtXEHwmY+rPyvgNN6opcsqgC+mjsVSLtgTteYw=;
        b=yyk7nBn4BOu3nSWswzDWecp6RLiGcgqVnzZfCDoKEtlJV4khC2e/6QQHrqKoVDKREq
         n2Ez3PYAqiZp3zRoz+mikhhXMY5yo3uOo4bc2THZhLbypHoUYE/V0QWOMehAENMdkJ4S
         JrublCnwKc7JIwYj/4QfMnAErPG5rypA9Gudvhf3Q1KgZ3RLlrTDUZYtjAe5iwYyoZKT
         WG4ZKIZsyK6tGWpPWFf4b+tlVx8hpUpD4ysGCmrBqMMNtbTSgizTxRW9xmetuh405ciL
         /GU95SvOYjKGCohzn1CvmDEmr5LSsv94KPCxpj+u47684bE8DXm5o2K/Ip4khfy75fia
         0G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117394; x=1786722194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCbDrWtXEHwmY+rPyvgNN6opcsqgC+mjsVSLtgTteYw=;
        b=GgvRMREbL9QwYOxbh0ffDncJiDLDP/qeqPJiQ9CztQVr6jD5O9KvwSOoNL45ThjPqE
         DYUHrNk1LvsT2SpRRiXTK5qT06S0Yo+sGBIfl+uOQGQFgV1m0Yh0Ve39dW8pl1R43kGF
         e/9mzAFFcaQL3grJYYLnTSR8keBkItyILOIcVYpNcu7+8YO0+oarKMzh1gOm3wGJ5stM
         pX0okXHn6WtdyRXIAPpzskdMA57PnOmtKB1bTbuSELSTKrPJJdDDHNbnftDkLXQ/aSd1
         U65uf+jBBzlp2mD0j5GqVaWqwbqUpXYhFahgXRUfo/AAlWPwc+iW9+qxnvHMyGEeTu3U
         3Tpg==
X-Gm-Message-State: AOJu0YysDJUCqzQdEO753a4vJpgtIapAT66NIUOeuhraaHYcHZndK2dt
	U7Fx8xEZshaaAJPnQCJ4cDsNumbrZBxXgqD1nXtWcSRPoBEqWN5YBWn2ZR3R2HY/sJGjQbsyGjU
	hXnWq
X-Gm-Gg: AR+sD11+AAaYOihFIrcZ+jdTj6ZSQ5mP+F5ELlMnoAjqWECoIRsv4IG70AMcExlgBw9
	CkJx5xWlZ5YhAdd2yOPu7/HzczFzgnZskfp7wVKC/PCP2CA/rfNPGcNN/jOhlfYHn9RKjS+gegC
	vTkHk+iTCzqRW2bwhymx2+jaHKs6GSRLns9J8YYuIacU66Zr7IFPc9dvr7KiO+vlEgCaGoleGAy
	rHqMq3LsflqfIKVxsHUuSJm2mORWY0tstCWo4G8Xl3tTSXvohjnbQUpMjq9XMzBTr5ir95gcqlz
	GtvoJGhSbUgKIQ3RcfgMXFuHuIZCjiXByKI+15NLGWigUS2v8i+oZFVY7UM26iCURkEZ9ZWtPEZ
	cQvlOTAzRH9G7D68W7LMbzTDuKK5LNs7sMrKI13YPBz6OnQd/N/reRv40+NzgJqtj2PP/xuiTqK
	ERuu84g1j0VcuBBmJpE/iaT9KU9whpBEbKEy3v5+UuAbqg5PIF1ABtdP++a2rIJMxWOBV2c5b0M
	Ln2cmSQBcpkckm40YKpN33yIek=
X-Received: by 2002:a05:6a21:3391:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3cbc03b56b6mr6325584637.21.1786117393279;
        Fri, 07 Aug 2026 08:43:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm8213083c88.1.2026.08.07.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:43:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 4/7] netshaper: put help to stdout and usage to stderr
Date: Fri,  7 Aug 2026 08:42:27 -0700
Message-ID: <20260807154306.111200-5-stephen@networkplumber.org>
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
 netshaper/netshaper.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 3b47d43d..85999dd5 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -26,9 +26,11 @@
 static struct rtnl_handle gen_rth = { .fd = -1 };
 static int genl_family = -1;
 
-static void usage(void)
+static void usage(bool help) __attribute__((noreturn));
+
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: netshaper [ OPTIONS ] { COMMAND | help }\n"
 		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
 		"COMMAND := { set | get | delete | group } dev DEVNAME\n"
@@ -46,6 +48,8 @@ static void usage(void)
 		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
 		"       BW_MIN/BW_MAX   := UINT{ kbit | mbit | gbit }\n"
 		"       WEIGHT          := UINT\n");
+
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
@@ -243,7 +247,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 
 			if (strcmp(*argv, "scope") != 0) {
 				fprintf(stderr, "What is \"%s\"\n", *argv);
-				usage();
+				usage(false);
 				return -1;
 			}
 			NEXT_ARG();
@@ -270,7 +274,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 				NEXT_ARG();
 				if (strcmp(*argv, "id") != 0) {
 					fprintf(stderr, "What is \"%s\"\n", *argv);
-					usage();
+					usage(false);
 					return -1;
 				}
 				NEXT_ARG();
@@ -282,7 +286,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 			}
 		} else {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
-			usage();
+			usage(false);
 			return -1;
 		}
 		argc--;
@@ -363,7 +367,7 @@ static int parse_scope_id(const char *what, int *argcp, char ***argvp, int *scop
 		NEXT_ARG();
 		if (strcmp(*argv, "id") != 0) {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
-			usage();
+			usage(false);
 			return -1;
 		}
 		NEXT_ARG();
@@ -517,7 +521,7 @@ static int do_group(int argc, char **argv)
 			continue;
 		} else {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
-			usage();
+			usage(false);
 			goto free_leaves;
 		}
 		argc--;
@@ -609,8 +613,7 @@ int main(int argc, char **argv)
 			opt++;
 
 		if (strcmp(opt, "-help") == 0) {
-			usage();
-			exit(0);
+			usage(true);
 		} else if (strcmp(opt, "-Version") == 0 ||
 			   strcmp(opt, "-V") == 0) {
 			printf("netshaper utility, %s\n", version);
@@ -627,6 +630,9 @@ int main(int argc, char **argv)
 
 	check_enable_color(color, 0);
 
+	if (argc > 1 && strcmp(argv[1], "help") == 0)
+		usage(true);
+
 	if (genl_init_handle(&gen_rth, NET_SHAPER_FAMILY_NAME, &genl_family))
 		exit(1);
 
@@ -642,15 +648,10 @@ int main(int argc, char **argv)
 			return do_cmd(argc - 1, argv + 1, NET_SHAPER_CMD_GET);
 		if (strcmp(*argv, "group") == 0)
 			return do_group(argc - 1, argv + 1);
-		if (strcmp(*argv, "help") == 0) {
-			usage();
-			return 0;
-		}
 		fprintf(stderr,
 			"Command \"%s\" is unknown, try \"netshaper help\".\n",
 			*argv);
 		exit(-1);
 	}
-	usage();
-	exit(-1);
+	usage(false);
 }
-- 
2.53.0

