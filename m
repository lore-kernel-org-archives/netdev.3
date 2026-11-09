Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259567;
	b=BY3ErmkJOnDko2kw7An4fFvNF63fQxNy6td8XO+BEJO1yYToX2tZfJpLUtgL2O9LEoWO
	 mWNLOtIKktNdBaB54B4veDV4llsSt/aGLxiy1IoH0vgdam80Ix3Ani7hWUjBoA61S5NBV
	 ca94FEhTkOlNLTqbVwWel2Jod6PBMjoEWuVBz2THV5lC+PJQ87C02NBw50sjJvm+2p8pH
	 FIu32ktRKjEEOgxSrPbBBr0AeYM0DNbp6NNPl1T5siRj6v3LXY2WAddkz5gSi5LSByImX
	 U6AmNu1T6zChziMZN4PKF+fGfwATZD0tUdk0Wmgu3mHEet0XS5sSHo9bC/Mm3bACa6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q3zcQMqDEH3O4I4+hR+PZsKAFNrSci/jyKXEhYKAnVI=;
	b=XpabKrE2e6BeXvy4xRBUVEwbRlyRN8KYHsMfHmZWYn30QXXtyVXRhI9aii4DQUsSeQ6Q
	 F2+bxtLB4PpJxxzjOun5m3H5xI4zdYYlOY8fozR/SNhqR9TfnR5GhGlg8vLe+APYu4lyB
	 zZHUtLTxvlzaYL5jrawu02O72LG53tKVqCN7LS650R3b34cDJaWFnerqo063rVcHl67Cn
	 1/Stq0jmRXh4fHezst/FZmA1tG+eWdXhr2omJGudnYg4JC4guo2sAwETXJQRaoGlhoqS2
	 giynVuHSTnNAVa2r7S837DP/IHeSAivXX0SWLgYbikF8AL1e7lXo+dwt8vqRu3ndUsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Lfk8B9sr;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BA606A33E
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814BA606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Lfk8B9sr
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso568336b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259566; x=1794864366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q3zcQMqDEH3O4I4+hR+PZsKAFNrSci/jyKXEhYKAnVI=;
        b=Lfk8B9sr0lgKElu4HJrNBUGqjjuLEZkfJ+b4qjFZX0Z7Y1kKVwmX3TR2Lc4/sJFDIo
         bv+9IWdCZoVBsz6R52w9rvBjaah7N3U4GlmqAi1f2oxXuIyTFB7eg3/YjuQBp20LftAM
         UzxhMacm2o4gAHAjFEz1I2jFbqHFMqoDL+HzebaY/WqxTSZbL3Qxq8qp8R6BRBaR6Fzy
         PNdIBQgeukA8BblI8OZhrS9yfbD2/hZH/o/S/k795aaJQlX9vfVebGfgOMJHclPkQVMb
         HjnTH0Cv86KXzdFIfk7dApluKhrei+CjEtjHfegefJ/JPK+8jciA0Aa51EoWF3NMaw0z
         RDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259566; x=1794864366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q3zcQMqDEH3O4I4+hR+PZsKAFNrSci/jyKXEhYKAnVI=;
        b=SYRW+fQaBMmb4yoebZLfR5CpLzJQrxxGeYf16LH4bX98M8MaxtXSsTUGev3hDKVHdV
         /nu80EcMNBGpFCcdClMGaxfIG6VaEu71p7OCIeoaGwRwh8SzOhscD728t+xY9KOYWIaP
         D4rHniZMVYuOeX4DRieGpPCvaXYzxOtIxnrEy+VJitvjcopiwhg//rAQ1EwDin4Dn1mQ
         /lb3ftuHp41o8Cl9owMq0QSFhgaj4zADXCgnhlobSEU96iKSBIOnrEbBzQ0lbkoDaCFY
         ORlQ+MXliu3/BUlPOMiUTg9FKJ2zrYWldZeY5VcjHAkqLGcHyrNl5ikUFmT8A4xLwL43
         vMRg==
X-Gm-Message-State: APuU4Z8JrCGtPazPO4lrvqTlEqlPxcUHNU03oP2xHH/BHwab74o4a7wt
	9w/gt5BtWaR/EXeatJx+zqwfh5/7YRVqXQVLzEyixO3wDDEvWD8kYbMKXuokUvZMdkDZ4X+G6ho
	mNgAZbMk=
X-Gm-Gg: AYBFou0pbaz2imgqeWVATU2JBzuBIkeT/1xVQwcRHcl6muknOiRQZXT3a2IHTgbAB7o
	c8m//OsNlV16rL1nKkvSX0s0kq12ZUNzVk8xhc7HUTLXSqdRRjPReimzp+i7HvvSwWDLKEyfhUw
	DbPEUgQfZ17gViifVSyLnEMzJLU2PHHjHkfyOC4uQ0j52MhwBa4UQkemOv/V3Feu9AKUpcgCnBW
	hgSQkV3W9ysNz/HGayhGIJqJsoFSzPym5KxNuBgTjIjgiaarymCGh3etQIQ8IzJ3iolvZ6HYX+u
	EUmFiyj2XpX3yG/pFJ89dkgU6wHSIyadom+cL7AIUNEN4rnFbbzMZNN5mmLNReVsqPrLTHJhbvq
	/19XXCg+pQX8JG9TJHbby/wO8lrISm9VErmfq1RrWIVofGbC29MNNbzJMrDtzwzfA8SCezHR0nV
	3FFzM7ty7wtIX9TMclVuKBvsRW1bQvZuUYiVutvuDb51z7SVoPgz3CP2v8oUCy9UHUCh/fU8cwJ
	j9KyUfzvrWLe6I0+hCPfGNyZlmrui2iHInvxdSBG6IXt6kcApmo/WTnTKfNlgEEBFr3C8R6Dbeb
	NcCyszraE7dnFwuHBx6vuPtM7A5n//Y+OtQMmU0sxcYVroKSaKMK9V60Ts6S/URbqYuc
X-Received: by 2002:aa7:9312:0:b0:89e:43ee:6549 with SMTP id d2e1a72fcca58-8ba83bcfdaamr807414b3a.5.1794259565881;
        Mon, 09 Nov 2026 13:26:05 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 03/11] ss: escape names chosen by the socket owner
Date: Mon,  9 Nov 2026 13:25:19 -0800
Message-ID: <20261109212559.39661-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109212559.39661-1-stephen@networkplumber.org>
References: <20261109212559.39661-1-stephen@networkplumber.org>
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
Assisted-by: Claude:claude-opus-5
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

