Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F147ACC7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117394; cv=none; b=KXqZmttfuOGG+xdWZ/zBKBl8+oWmFkW+Y/ROkWjtxtJwpHewH6sbr4rWvZdLso4fF/dIEACdm1knOXrvCf+EADlBqpMzj2KQpguliGGFzw37rnwmLrK2tqQ9t7orbppu57/YGholfMldd9MuqXKnc3FGSJVID5ImA3MJfzYWfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117394; c=relaxed/simple;
	bh=hK7GTJSFVejKew+Xp/iRZN/6iHvDpdiqOsE4Gn+MUKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry+WrMr/JldToPR5B6zGLjfhFfez4lcDvgsDQzgOYM8nFnEOrdstS/mvrsJsQ25jtxHRygHAxrr5Q9QsI51KXP+Zzhb4TVTwTrcxhErvmMd86k6T2R9AZbl6Tjlsufm5bKoldtea93UcsDjgyWNDCnE5v+qp7cDbfV8+PbZjS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=v1TiCgrA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="v1TiCgrA"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39266382df6so707866a91.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786117392; x=1786722192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0d1t7bCMN9eqDSFI2YXnmxbtBChKP1SQhS0obdCqyk=;
        b=v1TiCgrA9HOv5cF4vJiIx+jJa7INM+R2V7LQsqbqr+oHuET8ZAKi+T+gM33+o50xZN
         Vq4jpuYzYBj1uWjd/eHSpb/w7Qx3gQSP4loKEFVpb8xYALaENH98qjq0lJ0JdpaM8U18
         tKQu8KqPrrtB6IH75qu0MB+JOcAO6E7zv5LVVMV2tTeATKaTP89TNkKj5QbNfEJEcExS
         muhGiVzGXj+8v8YBnj9RKxhtchdWWmC/eHTaD4P+Uzc+Q0+DqsTWn76sCtl7A38UMH73
         6Hg47r29QNK4MtjFOKlxydtqjdIsy6acDixwfineXvDDTwJGkpg0ZcDuXcYjA3fHQiG+
         djWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117392; x=1786722192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0d1t7bCMN9eqDSFI2YXnmxbtBChKP1SQhS0obdCqyk=;
        b=EtyB2jnKlCAPMGydxVZQUW1Vkp+/haNnzaCWXbBc0/VcgPI30sFmBG0MkmIDU3xRls
         9//LCokAWPCZqDlH50F37w9lkcU0kVmG1M4lSZ09sjvDKrY9/M0BojaPIN0YQ9jH9++q
         DX/soakdIX7pmVcbnJamCzlnMo1kNzThyZ4tqny2FNfeVpQvPj4XfxpcwRxm5F8heQjA
         mntu/EVpdQ++YBUdZVKjv+T37igF+f2M/lv2fXtJ4DBXfCsem9SGrX49ede0chEka3/d
         zsZmcMeTlxcrLN9b24NGfe/pme7ba3I6dNbrtEh9BJOK0eU/zTrAL+7VyIX+z/Qlzr76
         g58g==
X-Gm-Message-State: AOJu0YzdWn20LKLWU8p4cmacCDag1ogGG6WS+5+6KRhibcDbucilRSYR
	CuYR2GeBtd8VQIQH+Nx7Z1XNzmp18ULor2vCmI271Ik+JDaZfonJmQe0PnBgLAQT3p1nSIP5HXD
	dd8Ju
X-Gm-Gg: AR+sD13hsBlcD8FzcLh01HhJt6HKbTW+3bxje7c/IGx5wMQaFZdLqNhLPYIHz94Io6G
	YA2GO7LnxsIzWanl0aEHWrL63i9zrnumw9ZIAbimkr6WKYApM7SIjHwuJHWq9wKFvcvV2ZFprPh
	n78u7/ca0SrVEETq2CGTe4hUIyM5oa17Kfj9FskMgVo+dBBI8RN1L6rMV5xN/Uo+WznZXvpIgG2
	Ub81EtRXduHjMWmhZTiyxGX8sdoJ73+i5SNs1ecU960dwreJbuJH0l65a/LCyiEaZ6Rc0gFMzAa
	0g+RzSZmmePBolYmY7CfNEgQ59hoty3sWsXtuAL/IQQOXaV52afA7m03D5Izpz5fRjpkEEeD5Bk
	QCk2u2EiIerts3U0LQFwNxfusotRWlFQpGu8rK1RA1GsSSVC9IK7WJtAkqnEyhpFpn/IhW/oxCn
	swzdr96BoYW/McRWWwRKacEe7PDaeJI7ZxdrfeZeaHSz7L7js3v3z3PlJi/7zpaFUV+ecb1QUeO
	FVCXSMRS/JlTwIG7UMaJQmYr9A=
X-Received: by 2002:a17:90a:fc47:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-3903c599361mr26821760a91.1.1786117392381;
        Fri, 07 Aug 2026 08:43:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm8213083c88.1.2026.08.07.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:43:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 3/7] misc: put help to stdout and usage to stderr
Date: Fri,  7 Aug 2026 08:42:26 -0700
Message-ID: <20260807154306.111200-4-stephen@networkplumber.org>
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
 misc/arpd.c   | 12 +++++++-----
 misc/ifstat.c | 44 ++++++++++++++++++++++----------------------
 misc/nstat.c  | 11 ++++++-----
 misc/rtacct.c | 13 ++++++-------
 4 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index a42603f6..230d3580 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -6,6 +6,7 @@
  */
 
 #include <stdio.h>
+#include <stdbool.h>
 #include <syslog.h>
 #include <malloc.h>
 #include <string.h>
@@ -88,11 +89,12 @@ int broadcast_rate = 1000;
 int broadcast_burst = 3000;
 int poll_timeout = 30000;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: arpd [ -lkh? ] [ -a N ] [ -b dbase ] [ -B number ] [ -f file ] [ -n time ] [-p interval ] [ -R rate ] [ interfaces ]\n");
-	exit(1);
+
+	exit(help ? 0 : 1);
 }
 
 static int handle_if(int ifindex)
@@ -594,7 +596,7 @@ int main(int argc, char **argv)
 		case 'f':
 			if (do_load) {
 				fprintf(stderr, "Duplicate option -f\n");
-				usage();
+				usage(true);
 			}
 			do_load = optarg;
 			break;
@@ -633,7 +635,7 @@ int main(int argc, char **argv)
 		case 'h':
 		case '?':
 		default:
-			usage();
+			usage(opt == 'h');
 		}
 	}
 	argc -= optind;
diff --git a/misc/ifstat.c b/misc/ifstat.c
index ec59a9eb..c2ea5942 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -756,8 +756,8 @@ static int verify_forging(int fd)
 static void xstat_usage(void)
 {
 	fprintf(stderr,
-"Usage: ifstat supported xstats:\n"
-"       cpu_hits       Counts only packets that went via the CPU.\n");
+		"Usage: ifstat supported xstats:\n"
+		"       cpu_hits       Counts only packets that went via the CPU.\n");
 }
 
 struct extended_stats_options_t {
@@ -796,27 +796,27 @@ static const char *get_filter_type(const char *name)
 	return NULL;
 }
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
-"Usage: ifstat [OPTION] [ PATTERN [ PATTERN ] ]\n"
-"   -h, --help           this message\n"
-"   -a, --ignore         ignore history\n"
-"   -d, --scan=SECS      sample every statistics every SECS\n"
-"   -e, --errors         show errors\n"
-"   -j, --json           format output in JSON\n"
-"   -n, --nooutput       do history only\n"
-"   -p, --pretty         pretty print\n"
-"   -r, --reset          reset history\n"
-"   -s, --noupdate       don't update history\n"
-"   -t, --interval=SECS  report average over the last SECS\n"
-"   -V, --version        output version information\n"
-"   -z, --zeros          show entries with zero activity\n"
-"   -x, --extended=TYPE  show extended stats of TYPE\n");
-
-	exit(-1);
+	fprintf(help ? stdout : stderr,
+		"Usage: ifstat [OPTION] [ PATTERN [ PATTERN ] ]\n"
+		"   -h, --help           this message\n"
+		"   -a, --ignore         ignore history\n"
+		"   -d, --scan=SECS      sample every statistics every SECS\n"
+		"   -e, --errors         show errors\n"
+		"   -j, --json           format output in JSON\n"
+		"   -n, --nooutput       do history only\n"
+		"   -p, --pretty         pretty print\n"
+		"   -r, --reset          reset history\n"
+		"   -s, --noupdate       don't update history\n"
+		"   -t, --interval=SECS  report average over the last SECS\n"
+		"   -V, --version        output version information\n"
+		"   -z, --zeros          show entries with zero activity\n"
+		"   -x, --extended=TYPE  show extended stats of TYPE\n");
+
+	exit(help ? 0 : 1);
 }
 
 static const struct option longopts[] = {
@@ -898,7 +898,7 @@ int main(int argc, char *argv[])
 		case 'h':
 		case '?':
 		default:
-			usage();
+			usage(ch == 'h');
 		}
 	}
 
diff --git a/misc/nstat.c b/misc/nstat.c
index 4a9f3326..cd822ba2 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -7,6 +7,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
@@ -528,11 +529,11 @@ static int verify_forging(int fd)
 	return -1;
 }
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: nstat [OPTION] [ PATTERN [ PATTERN ] ]\n"
 		"   -h, --help          this message\n"
 		"   -a, --ignore        ignore history\n"
@@ -545,7 +546,7 @@ static void usage(void)
 		"   -t, --interval=SECS report average over the last SECS\n"
 		"   -V, --version       output version information\n"
 		"   -z, --zeros         show entries with zero activity\n");
-	exit(-1);
+	exit(help ? 0 : 1);
 }
 
 static const struct option longopts[] = {
@@ -612,7 +613,7 @@ int main(int argc, char *argv[])
 		case 'h':
 		case '?':
 		default:
-			usage();
+			usage(ch == 'h');
 		}
 	}
 
diff --git a/misc/rtacct.c b/misc/rtacct.c
index cd84b7f0..0e2c03af 100644
--- a/misc/rtacct.c
+++ b/misc/rtacct.c
@@ -412,14 +412,13 @@ static int verify_forging(int fd)
 	return -1;
 }
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
-"Usage: rtacct [ -h?vVzrnasd:t: ] [ ListOfRealms ]\n"
-		);
-	exit(-1);
+	fprintf(help ? stdout : stderr,
+		"Usage: rtacct [ -h?vVzrnasd:t: ] [ ListOfRealms ]\n");
+	exit(help ? 0 : 1);
 }
 
 int main(int argc, char *argv[])
@@ -469,7 +468,7 @@ int main(int argc, char *argv[])
 		case 'h':
 		case '?':
 		default:
-			usage();
+			usage(ch == 'h');
 		}
 	}
 
-- 
2.53.0

