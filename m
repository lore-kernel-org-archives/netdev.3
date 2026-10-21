Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598428;
	b=zC+LcCerKle4vY1SbLhwyF3yiS3rCqTGNDGbfiR03GXPtczc0ZWWe+KtTZja5RAsF2gm
	 UdB/bgR7/v0b0uMkzoX8zNynb5WMWMlAjxS7QRSA1R2SysPoi7VNfa/BxENbLlAgA6Jsq
	 auwsCpIzI+Po15rwcmEhg2GqNX+KxYUNL3S7RuB84v6BOLf1DLnzB88VUAEj+lE6Zxo8f
	 hqLoze1/V9jeYu4fQKUDqdoR4yPNPAtw43IsVfCKl+L0v0WWdEqQK6v3QFgw8vPuHEMKF
	 CvxAgiILB9ecRwXcZrWP+NzjdYE8NN34d0O5oQ01lerhxlFee2Gjdn4Grf52wCGbtuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZLY25osET7Ud5BVQB3IT5enVyQB3l06Y6fdSSU54YRM=;
	b=jKMvqxfGl+EGOvTfFtjK4hwKA302BXPM/oLD5mIL7U1AUucNE78shjHfg5CrinX+i5dw
	 zTroJNcdRMOpxgSwCi1WYwS/sVRuAlhJJKXaUy8tc9yssvA1clMnrVcjHm3/WNJtVEqss
	 1Gc3ff4UvrkXL8VMiJZfM2krzr/S6+oEwZicAhL/ac9Hz6e13Vf2pOfBE7YFdnrlT2KHu
	 +OznYhUY7rM0JmyegtmQfiT6Ul7/MraAYl6Vurt2E/XnI264WQMU5mf8ZYXTIcd06U+oU
	 PlDsxLaW5yVNbVVU/oppsCmJVGGT9KB/LfcvXMPCKJ6lScYphhhO1a0d2albwfN5/1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vrjmnFbm;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9F606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC9F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vrjmnFbm
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso778926a91.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792598427; x=1793203227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZLY25osET7Ud5BVQB3IT5enVyQB3l06Y6fdSSU54YRM=;
        b=vrjmnFbmoTfalG0odwGQ2ZUtjdDgXtvhDpTwNxF0nYvivTS/on6GAa2xPMdJJBuDUe
         Yfr5LPmNwvfWWzqKRfnTM/N64IJgY7r4qz/IVFnHAeZX5+1N+lBNkUb/6H4BpG3MpMFK
         AWyb9HnoahUXERisao0QCaVfXGQKq23nll3y4Gf2eA7FcP3KjdxEhw+K3nBSBlbACa/8
         EIJ313Q5epxI1KaDLasD7NryGFBg/S+39gsujXSB0JgDhAKrDbmuRJP0493LIAxJ8HA8
         +qJFXz6XwkJckIBlOzC7n4E6zCKcFYu7qH2aE4YjsB8MsZRXSFbeFZ8lGMkmqhNuwkEE
         HNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598427; x=1793203227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZLY25osET7Ud5BVQB3IT5enVyQB3l06Y6fdSSU54YRM=;
        b=VvaOOAummS8vFyCnDI9eDI5aYiLGYFq/tSWK6C8Du3CbnrM6jAABlZvtQY1ZM2H/+e
         YGM/hgbT3mAc3mPKfvVebOr3MdGzghbL0cmITg88jaM9IN4avAYp7KBcRYNjy6EZZ/4N
         XQ7aT+JkV8HEtdrTMwAYj4VzoPUJwXgt2q4ZCzV+GAZbhew0BLVUecXTgf6KrvHPzYUy
         vgkdZGp7rjpUyZASQHK++3OIARODTruxJzKpn9ifvbKmEmAUBbm1JTLFxUcC/zrmDD+z
         lVHwgnM+KmJhqvtlYHDiHmg1yxMjP5PeOCEKu3oHAZPXvdO5iwwb+qXi1sP5+oBQ+NJS
         GxSQ==
X-Gm-Message-State: AFq9FYKwpvJJ662ksq9pmRfQ6joELmqmQ2a0H34IzywZOuzT8e6qiIQF
	k0FPl82dE0b5oVX7EhxRgdqYEpetNhDB9nWd/YDb8tSrd7AMWPQyLTLJp1DN7nEMR57RGhiWWHq
	1r4Xg
X-Gm-Gg: AYBFou0Cnt5+Eycx3KFifyP4kshGGQz8208gWMb9m4WMn1prCfjcNtlb0HzPXLaOAQt
	Sn/419ur7lP0sfYijFtzdPoBZ2Ma8w6ROtwmOoWK5WWwGnPzc1tPfbOr29gcqKRYadGHXaQWIyN
	3NEw/wiwehbxhOBeL/BbuuY35uk7RLQ/PybTeAg+0agh3NHDbIvDW/Cy0ibL+Ai0K7ayWQDleaL
	tZAW0c1keDKdU7rI2gYfptO/I83CWa+m0rPaZhY4n1Q2/+TFU3u4CJd5mmuVz0/EQdJNp/nvi2M
	MNWfvunHq9/buiOYavj0xuF1Dw+XEBJ6jmta3T5Gx1mKK4jV/6v5Gn/MwZHT8PYgk355TxRrfJ9
	xaFr05S3eHLCXQEIH2k/UKSp/6zb3a1LZGEVgIXNMnYZHnfZSqgEb9P09VfXxa0ZccInyJx3v2R
	VdlBKW1abrzBoPdeV22br5b/WyNdE+atXNThMfVlUr3BO7UhIhoEb61u05j8ZNQsJMnKSOEL150
	/IxMh/ymnMjizYoJabD132uD1yUMfof2CTU+77KXHkxXTNHQ6apHMSlRJHSIbq/JZbsP+nDeC6s
	8zrtabkezJ5KKQCBUhA=
X-Received: by 2002:a17:90b:48cb:b0:3ac:8527:3fcd with SMTP id 98e67ed59e1d1-3ad86f31d92mr2013837a91.39.1792598427362;
        Wed, 21 Oct 2026 09:00:27 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada493261asm85664a91.12.2026.10.21.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:00:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/2] ss: use get_task_name instead of parsing stat
Date: Wed, 21 Oct 2026 08:57:23 -0700
Message-ID: <20261021160020.3838946-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021160020.3838946-1-stephen@networkplumber.org>
References: <20261021160020.3838946-1-stephen@networkplumber.org>
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

Parsing /proc/<pid>/stat with fscanf("%*d (%[^)])") is fragile:
the conversion is unbounded and stops at the first ')', so a task
whose name contains ')' is reported truncated.

Use get_task_name() to read comm directly, for both the socket
owner (per-thread with -T) and the netlink socket owner.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 26520cee..cffee883 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -592,19 +592,15 @@ static void user_ent_hash_build_task(char *path, int pid, int tid)
 			sock_context = strdup(no_ctx);
 
 		if (task[0] == '\0') {
-			char stat[MAX_PATH_LEN];
+			char task_root[MAX_PATH_LEN];
 			char name[16];
-			FILE *fp;
 
-			strlcpy(stat, path, pos_id + 1);
-			snprintf(stat + pos_id, sizeof(stat) - pos_id, "stat");
+			/* $PROC_ROOT/$PID/task/$TID/comm */
+			snprintf(task_root, sizeof(task_root), "%s/%d/task",
+				 getenv("PROC_ROOT") ? : "/proc", pid);
 
-			fp = fopen(stat, "r");
-			if (fp) {
-				if (fscanf(fp, "%*d (%[^)])", name) == 1)
-					escape_str(task, name, sizeof(task));
-				fclose(fp);
-			}
+			if (get_task_name(task_root, tid, name, sizeof(name)) == 0)
+				escape_str(task, name, sizeof(task));
 		}
 
 		user_ent_add(ino, task, pid, tid, fd, task_context, sock_context);
@@ -5169,18 +5165,12 @@ static int netlink_show_one(struct filter *f,
 			done = 1;
 			strncpy(procname, "kernel", 7);
 		} else if (pid > 0) {
-			FILE *fp;
-
-			snprintf(procname, sizeof(procname), "%s/%d/stat",
-				getenv("PROC_ROOT") ? : "/proc", pid);
-			if ((fp = fopen(procname, "r")) != NULL) {
-				if (fscanf(fp, "%*d (%[^)])", procname) == 1) {
-					snprintf(procname+strlen(procname),
-						sizeof(procname)-strlen(procname),
-						"/%d", pid);
-					done = 1;
-				}
-				fclose(fp);
+			if (get_task_name(getenv("PROC_ROOT"), pid,
+					  procname, sizeof(procname)) == 0) {
+				snprintf(procname + strlen(procname),
+					 sizeof(procname) - strlen(procname),
+					 "/%d", pid);
+				done = 1;
 			}
 		}
 		if (!done)
-- 
2.53.0

