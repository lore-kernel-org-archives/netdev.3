Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515600;
	b=FY8idZD/o4sVllWze/6+325VY5QxG+6iZbzlrR+RLU3SAPEWdygYka7LnsaZjkuOYh0m
	 7cjDAZtaM9hZPT2ZidkIA9N01IGPwGQYpFzLWMOKPa4FKwhazfFlA7EHLr2AH755O8yO7
	 8qnVN8HiALIBeRlTn7dkgktF7L9WErjJWrEgLtUorymqcBjW3b0y1wh9e8DiZJ5sscFFL
	 A3GhoLImcVJ2yemut9RP9czQ8/zAf+A9b1uUyFZj3V3WT5igZPCilsGCac4/AWfifsoie
	 CpKzYD/SaKJm5+2/hsS2w/rDZfVN48r4qrsBwCVQstK1jVtYiOjx1uF02H0WwLU4cew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=R3lUjOSVxAdoetqWs1KZCxCLCD9Jc25a4Rk+/Lo5Aic=;
	b=GU9U1mkNKn28uwKipfUp96gXJLsGj+NQ+ZncAeqJCs53L9Xb89c/cV4DND/KmX9bTxvb
	 j+4n+UbwTPQoBhdfZuqKqFilibp66ju8K3mWprrUZ23DUtugWs60478JXmXYhdf7thv7B
	 sUKNxi/zoFOseSaEzWAkUPt89pvMdVWp/bDcE311bviQdwOuaT5/13y5a8zhgs6bBewc6
	 oEN55DEmW6AnmQhqLpRWFvzHqmM4Y8mpqtqRpDcTMaYvKXdsHDlSdcdIgwoDkvYN5/Ep7
	 t8err/Iw3qmCfz2ChBg99plMAHVF8BdhTlzwYXryiso4Atp7xuYWuFomHFmpdyfkxcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="KckU/bgO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6760A2603
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F6760A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KckU/bgO
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so276a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515598; cv=none;
        d=google.com; s=arc-20260327;
        b=QWD+PRyj33++oYxUCtn9FzHnrztXARv1nVsIAvcKhANZ5yCv68R1PkzugrINh2jkem
         fO18WzJ0OhAmwnHnM7JmVLZFxv4+djliyhRykObaVvf3bjVG53hnjS6yhfJoiRW1gU+j
         aKKxQQHaC1Za7ExnNdrzC8k6uXK21FevXDPgYBF/bwY125iC8RLzQPRRqpYhjttMyYmF
         GT9dHmSC++uH/ikwAM5X7EB5lvVu9ipMowiX37ZzlOYYwhfZdDm/CleYl/bLysg+l/dV
         j5aOj+3FbJ1to2axUy9LQeb3ZDllfhhrdyrD8nT+Q/42yu/JFe1aVS1ZC2Z7lBIEZfX4
         +N9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=R3lUjOSVxAdoetqWs1KZCxCLCD9Jc25a4Rk+/Lo5Aic=;
        fh=xJq/2WXB/3/lV5Tzvrpx3oNsYcakw7E3oGHzwOSCbyA=;
        b=diU80qHb7wDL2w+9zVlhUJyUz8TI9HjArA5OZ4q2UZoida+Ym7hYs1CJtp/S25tX+/
         xwwS3Cauj7CMNc+shNbAv0dTLBUP/OhYNptybqMwMnRFY3Wk0SSV8h4Hibq56zLSkxeN
         ZSkVQ6FGzeOKNwlHAi64FQ1vtiZioctSEiuy1kzzA2Vrf5TfmFH5+CU22Tk+Zscxtd2H
         FHkfMDhecrn8EESpYlXoa42+rgLG+wDKBXs2rozPcdqCwaDal5qZVFY3KYPaZNy/y99E
         ocwzfep51wj15QO59a6kwrYH4/ZIUSC6ymBpU9PFjcHH41Fi0cWLt+2SiHP94/xWdr/l
         LYEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792515598; x=1793120398; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R3lUjOSVxAdoetqWs1KZCxCLCD9Jc25a4Rk+/Lo5Aic=;
        b=KckU/bgO44VFNsNBQofePiiulnZAHJcog7S1WrzZHiVKTNem/XS960IVWLw1G1/pr7
         dG0YPnxBvb/UFzH/JSE3q0RkECO43aDwN9VEjO/yAS8U1XMLjlkgeGK4CP9jjYPQzf+B
         xzonXRqM8gTGtGpKpKzxsZ5oRNw29tILxYb1N8UI1DqXZs9G1IMdWn5x0m1wI9Lba58P
         E0jsV9jbMmt1EjVDmPEztOvT2z6ONEJ5yeRIy5kqb66WZlKLI1zoRzmfLn7SghI//ByE
         39Q5VkcSp9uNsMcZ748MEMUvzWVC29H3cHz1LcRJxNDvENB2/XoxqG3+im1SPrV7bRdB
         9Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515598; x=1793120398;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R3lUjOSVxAdoetqWs1KZCxCLCD9Jc25a4Rk+/Lo5Aic=;
        b=EOOLDVP3c4Gw5xS/VGtCoJ7InIAE+U2huVver8KBZmn2ZUUf5BZcEMnnNfW3pYeSJJ
         obC8P092tw9EfAghft6rTe8wT+pyRWJkqwuNuB1AgSpPhrE7G0e5gS2GssJCyrs/6gKE
         hOzJf5fUZy82xY8r20NZek/JZfB03aB83oSI456pt2KlISCZU9sYXRWg0/fMnEbwgxX1
         FWTTWZNUHff3pJi5O7u3e2EZH2aZNb0+jsFfh5380oLNuC8RBmtA0gcDQfwRgdIbuq7w
         yaSQyQGNPMgpsqQJC4mDy2JN08HRy5SLoQm/6A+wGdcz1248+R+/jLBM9nRJJUdFQvj7
         Pt/Q==
X-Gm-Message-State: AFq9FYLSUvrFWBIWfuljcCsefnXtlTKKihVTzOvnArEwTWXh9z9uQ1Yh
	neyQgqTxvzRl2dp4I6fZm4BNZvP8K4MkV9GCuZEwMGecImxQv/GtJXIwDEDhbRxefWjbHrloEg9
	t2rDq2ycycnJIGifGZgj4/GZZTNCQpEBRQtOSsFlssBy+SU2UhYRXla7j
X-Gm-Gg: AYBFou2rfaBOEc2ME/HA35FIapDs3T8jjjepvrM5O0oSeefh0kmoiks8/coZGhcXj7x
	JI4skQ45h7yFSY7IoZ9cUUuUWTbQ+pUc1b5cNvP4skzeszZpvaHnBb0UCZSooGqGeNJL58dDgT2
	rR0zbmINTwQGszlVAwQ6y/03h+254hagG+8/XMyTWFdIh7F/gpyPAcfyPLu4kp+RUgZDMCQdCGp
	Bsbhs59RL+L/NSN/qOMrKav+m9ZNWEfLhpNYWaX5qqwNHHhvXfovoEcHltnwh6YdxzXUd7bC6t3
	KBDbQFonUIsOaT3Z+xYC8HWcLi0VG5cWUszI6Pefw85S4aXDdJkqSxL97m+HPeOksJDqrozdnzD
	GMyaZiJqhpLQ/KWVYWNY9
X-Received: by 2002:aa7:d654:0:b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b3e7717bc5mr50075a12.13.1792515597591; Tue, 20 Oct 2026
 09:59:57 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 09:59:56 -0700
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 09:59:56 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Prashanth Swaminathan <prashanthsw@google.com>
Date: Tue, 20 Oct 2026 09:59:56 -0700
X-Gm-Features: AclHuK8RJaG3oJEK2XVIMTMgabOoN16i9c-kEVWErS3t8_cHBZO0NOkaXOY_Aw4
Message-ID: <CAHdA9BwQPp9ciwB4RxUd79AOkcFo6gb2t52NTtWq_52=K15p=Q@mail.gmail.com>
Subject: [PATCH iproute2] ss: bound fscanf width when reading comm in user_ent_hash_build_task
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, dsahern@kernel.org, maze@google.com, 
	yuyanghuang@google.com
Content-Type: text/plain; charset="UTF-8"

user_ent_hash_build_task() reads the process comm name from
/proc/<pid>/stat into a 16-byte stack buffer (char name[16]) using an
unbounded fscanf("%*d (%[^)])", name).

Although the Linux kernel bounds the comm field to TASK_COMM_LEN - 1
(15) bytes, bound the conversion specifier to %15[^)] so a malformed
stat entry (e.g., via PROC_ROOT or non-standard procfs implementations)
cannot overflow the stack buffer.

Signed-off-by: Prashanth Swaminathan <prashanthsw@google.com>
---
 misc/ss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 26520cee..bc30d950 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -601,7 +601,7 @@ static void user_ent_hash_build_task(char *path,
int pid, int tid)

 			fp = fopen(stat, "r");
 			if (fp) {
-				if (fscanf(fp, "%*d (%[^)])", name) == 1)
+				if (fscanf(fp, "%*d (%15[^)])", name) == 1)
 					escape_str(task, name, sizeof(task));
 				fclose(fp);
 			}
-- 
2.56.0.212.g129ede20d9-goog
