Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513653;
	b=U7Q303LeWG8/uZMdM90VwO7pEFIom0TRICjnPFkgmd8dHkstsF+Ph6ZlPMb6pHkq8UWB
	 V3mq2Bx8imB0H7qNctcOeWxIiM/fcfY9p/R2QikZSZ5NXnRCPJEEgZLjMcbY2uZXdUoDT
	 n8I8S6BpSBKK/hb9t5aA0N41fgiSCObM9mDBIb+DiwoBZCPjJvEjGGI6fjUfcofO9RV78
	 +3ETrPx8cUU05VUKYL4ng1Z6l8BWRcdLuWP4EyHH1CbVpNtm4cF/C8sNQbGfYA0lQbLpw
	 EOwy9S4Vw75V9s0/DNe6rX7dMH7/jMnBSf/t0OclpCF7E59UuWnwLfUPl01/IYOE4og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lvvGCqh9mAL8pK4fm3Dj98YzlhoCn7sBO+aAv64F46Y=;
	b=kBjekw6+wlL/9h0ex2rZDiyVUN99481KNgpTwYefUBj40b3/0FUgydjggI1knkghAdRh
	 +zaEGQy+42cho7JYbJb068KUJ90RkW01xq8J5yp3loaWkpCGCUx2WmxIwH0fnKZu1FGaG
	 khY7egbktYe+q2HZgnu/Kxr6SsiAtoD8Az4Gy+MwxlKU0m4NQUvEIMpOdug6Im8sDiQJ+
	 XJt5pE5EfTzR34dVxph+h5a7xdSu427ySUmM/yteVwY8zXSKA2mtMpqO5yLHYXQXktoan
	 pOr+xHJJ0B+frSQ93LYaHwvnokD3sb3cEYH9CSYRH7ZvJy83+J6a/5NFWH08gCcMPpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BLNlPifX;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F55606A882
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F55606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BLNlPifX
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so223037b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513652; x=1795118452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvvGCqh9mAL8pK4fm3Dj98YzlhoCn7sBO+aAv64F46Y=;
        b=BLNlPifXOWyeUrqPfwx2p3DNb43HDiz7kAZCnlaFtgzzZIW0+TDWu4DHF9lUgf6qFf
         WXgx3RjFf8AAudzZ/j1K0YFQorD6SqSH3zSro/tXJUiIMaRVJybCx6DWrlMobOfwSZKm
         XvSP30h9qB2sdayT1v/+BKIwyCl06cM8gFdI1PIjX8gpU3x4e2PtHMcQAKLk0VwNnASi
         KaFrQivBHC4ZlgTzN1ruebBA4R5EJ4nbvz/vhGDcBBFzZB1DnGiF4PYK5mihWA7svbC1
         kAZEFAcZ9pyhxMtuoBIObwjwhWVXn7jhtgzJsSDZSQhANo+jWnCIkSXh0oXegKzmp6wD
         KcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513652; x=1795118452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvvGCqh9mAL8pK4fm3Dj98YzlhoCn7sBO+aAv64F46Y=;
        b=gGJsNKYebHmq5Uv83Avfzt/P4v8SJNrwJyKtgNKaY5X6iAVCNt5vLrDpItSEb2Darq
         eBpe6kVhIlF+p/xnhx/5vVRxEYlXEtWpkFi0NmcsW8RXCmMOtLz2oGLbtaH/H4HD8zyr
         zSQJQoW1Rcccvdzju8wmWARqffG7oQP1nv+KWp23+xrluAp2U+VTDzquPYtzAta3iJ9Z
         vSc/w3L5BivVCNoxCyQFxJ+fHv0djHe+K2crMjujfiAaH/QJW3KigTZbl4CFBRrrKMxd
         dphPthxq7jriU4MVoSWtUc8sdPG0GXv9yTd6jysHTCE6gWeOIbxN5kcu4xjWdJwzj0Tm
         Z5/A==
X-Gm-Message-State: APuU4Z+FUnHePnjSStaxV0TofRkAaYTpHlHC1TyXwp77hfhbuSnMuu2P
	E8D60KhOMD7PKnwuHtAupCWaLj3mytfTzl/lckkv8ULZK3qM3f6cXXWRYO1jhIXDAMSRfblm2fM
	9C/TM21k=
X-Gm-Gg: AYBFou0Vweb0pLfTr/OmPCZrEwnJPlDCpeBKlllbirEp5AvNLLbuL6Yc7v9SOVvuVMA
	uZG3ox5mqCuOqjA43SCRJDOprMspRYrNk+BLx45p6MnfBz9OtOPkCKIGaVNVRcit6uC52GWZvtF
	+ZAyYQAwuAoluB2kEWN+df3pPbHzXD61GR5xUv+5FGeDchBUcP81TcwuMLNdTC36P5jTncmeI/S
	+e7HdMnUftGkFNwEfmwvmfKppzkOl4z/22nu+KMbdC6aTZolRv9bCfnTzCYIeQZf0vEPIktQS2I
	pnSFYl1hd7o2u0fOCErxMwknsrSwboKyZUr1u2MEYyvzxgqDQdDSgE76hfMsU3krdy4cOvR/OzK
	nq+TjOvydfRPWEND9+RECIwmtSClPNrUq4ZnSzUnvutIFiI4vTZ0uENNabGFEJkpploMQe6dY0Z
	jrsMnUfKFrc8WaXMUyIqAtNd6hxT3jF9Mx1Oio7VVO8hcQmVgsE/r6pIeXvbrM6ocODaqwnPauP
	0Vz7fQGU9RTX7tHwy+Ft2Yu7gL4Xf5xW8vl+rojs02j0SznOVj2yFTdYDTaHFZed5TXCnd255GH
	+rLeibYu2atjdXgqaJo0bVAvKbucgzEl7SEEq8WU8a399nefSyHpkfJgAd/X+EcIKYb3K2B4
X-Received: by 2002:a05:6a21:35c4:b0:3e2:30c1:fe01 with SMTP id adf61e73a8af0-3f7a90e4708mr166744637.69.1794513651974;
        Thu, 12 Nov 2026 12:00:51 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 03/11] ss: escape names chosen by the socket owner
Date: Thu, 12 Nov 2026 11:59:16 -0800
Message-ID: <20261112200046.2164391-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
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

Unix socket names and process names are set by whoever owns the
socket and can contain newlines, control characters or a double
quote. They reached the output unchanged, so a local user could
split a row, insert a fake one, or, since -p prints the process name
inside double quotes, make a bogus pid appear:

  users:(("x",pid=1,fd=3",pid=268,fd=3))

Escape them with escape_str(), and replace the double quote
there like the other non-printing characters. Set LC_CTYPE from the
environment so UTF-8 names stay intact instead of having every
non-ASCII byte replaced.

Reported-by: Anthropic OSS scanner (ANT-2026-4X7MF603)
Reported-by: Anthropic OSS scanner (ANT-2026-CAAB6GZ9)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/escape.c |  7 ++++---
 misc/ss.c    | 13 +++++++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/lib/escape.c b/lib/escape.c
index b110f61b..e4646bc5 100644
--- a/lib/escape.c
+++ b/lib/escape.c
@@ -50,7 +50,7 @@ static const char UTF_tab[] = {
 
 static const unsigned char ESC_tab[] = {
 	"@..............................." // 0x00 - 0x1F
-	"||||||||||||||||||||||||||||||||" // 0x20 - 0x3F
+	"||?|||||||||||||||||||||||||||||" // 0x20 - 0x3F
 	"||||||||||||||||||||||||||||||||" // 0x40 - 0x5f
 	"|||||||||||||||||||||||||||||||." // 0x60 - 0x7F
 	"????????????????????????????????" // 0x80 - 0x9F
@@ -83,8 +83,9 @@ static void esc_ctl(unsigned char *str, int len)
 			esc_all(str);
 			return;
 		}
-		// and eliminate those non-printing control characters
-		if (*str < 0x20 || *str == 0x7f)
+		// and eliminate those non-printing control characters,
+		// plus double quote which callers use as a delimiter
+		if (*str < 0x20 || *str == 0x7f || *str == '"')
 			*str = '?';
 		str += n;
 		i += n;
diff --git a/misc/ss.c b/misc/ss.c
index b93df60f..4462a479 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -25,6 +25,7 @@
 #include <limits.h>
 #include <stdarg.h>
 #include <ctype.h>
+#include <locale.h>
 
 #include "ss_util.h"
 #include "utils.h"
@@ -4075,10 +4076,13 @@ static bool unix_type_skip(struct sockstat *s, struct filter *f)
 static void unix_stats_print(struct sockstat *s, struct filter *f)
 {
 	char port_name[30] = {};
+	char name[128];
 
 	sock_state_print(s);
 
-	sock_addr_print(s->name ?: "*", " ",
+	/* name is chosen by whoever bound the socket, may contain newlines */
+	escape_str(name, s->name ?: "*", sizeof(name));
+	sock_addr_print(name, " ",
 			uint_to_str(s->lport, port_name), NULL);
 	sock_addr_print(s->peer_name ?: "*", " ",
 			uint_to_str(s->rport, port_name), NULL);
@@ -4611,6 +4615,7 @@ static int netlink_show_one(struct filter *f,
 	if (pid == -1) {
 		procname[0] = '*';
 	} else if (!numeric) {
+		char task[16];
 		int done = 0;
 
 		if (!pid) {
@@ -4618,7 +4623,8 @@ static int netlink_show_one(struct filter *f,
 			strncpy(procname, "kernel", 7);
 		} else if (pid > 0) {
 			if (get_task_name(getenv("PROC_ROOT"), pid,
-					  procname, sizeof(procname)) == 0) {
+					  task, sizeof(task)) == 0) {
+				escape_str(procname, task, sizeof(procname));
 				snprintf(procname + strlen(procname),
 					 sizeof(procname) - strlen(procname),
 					 "/%d", pid);
@@ -5357,6 +5363,9 @@ int main(int argc, char *argv[])
 	int ch;
 	int state_filter = 0;
 
+	/* needed by escape_str() to pass through UTF-8 names */
+	setlocale(LC_CTYPE, "");
+
 	while ((ch = getopt_long(argc, argv,
 				 "halBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHQSO",
 				 long_opts, NULL)) != EOF) {
-- 
2.53.0

