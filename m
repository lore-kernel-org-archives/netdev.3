Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513656;
	b=k4w5W66w9FXRrkaBX58pTNoa7GA9PWqkMjt9j2UP+ZEof5jsSbHZxXGNlY7o4nnljrAK
	 +vI6d6XpE6Weq/ZYfxfGJUJieA4v3a0VKPdd5fFUEMdPv/vOV1G89VEk8tkT36Q1Z5lf9
	 9ua/mIrvN29MgBR+AZYq8ujG1LIeSlTTtDuWnbosrssEbXIicYu7cHHYHKc+lKPeS2O8X
	 08mlWd824QdJm7XcQtwus4I71PGyGdvNOO4twAK5wB1eajExfSXlMMm0Za/OfW9JpTa0Y
	 fOWOxZE4GqM0qjakCQrsv8Zg+KsSSAAvG6hI9QSXW7woP/qi40dn2U7slH+8kyHhQYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AT90dIWtholrDKY4FOKu2oK87geOpoqbZrY5cxtsT3E=;
	b=Ud+v11HLsI4iC9LGbNF9015IQOCmTYtVGjd+miuDGrRZuulsVoV6NwXZDWmTlMiKMAmf
	 kBm88yJmrsKLgmyShUhcIauXxDgIMyaIujO87jjpiV7LQ3e/uLXhhoP9yhx/xZX8R7PkD
	 Lbfg7DdduWqMoKSTa/nimExY9KdjOTVT2NegswhMu2LA4f5ezBrjVvyx3Yaq25jInNwiQ
	 aCh/PZ7dsvr43dUFLMMznBiFmNXJHO9Fl08gWgsh00/beu9oJ1rutruGs7qkBGWMNNdgv
	 rTdkMMzes65T5ZrHvgqOZJXjbQxXbIkczZ75THSlx01acdGx2L8T/l4ZWnmOL/ewb+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AglUCQgq;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3C606A8AD
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB3C606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AglUCQgq
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so144561a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513656; x=1795118456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AT90dIWtholrDKY4FOKu2oK87geOpoqbZrY5cxtsT3E=;
        b=AglUCQgq/bOe9ggMF/NGiAlbezs7y+yW6XL5Van5njKT9HPtNKj9haPFuIeRZ/uTL5
         opnDZqvyDy7eLc98YVhlx0v4k2xn0Fd+RwTNaCMVTuAffwHedN7zKCxYXAse8lvLS+n1
         ZgeNAj6ypUnnykBJ5jkb+14q9yP8O8V6wECb9tHXMh44ojxOQPx8B1r3nub0M3p2OtIM
         Qrh2YRRHUot58n7yllkhiEy8McnEj2r3obBL4QQFp7e9BcoN6xnNomSSTiU+tSkOhp84
         sD+D2vHKz0548ptm+B8KFsq8H1Ycc26dgy6uOilciyPOc6Ruc5S4cq8Pr3iKQEQK/17y
         qa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513656; x=1795118456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AT90dIWtholrDKY4FOKu2oK87geOpoqbZrY5cxtsT3E=;
        b=Tzy+8EOHyF+7qw/MZT9qrViOBAhaA6/FosNpofmCEQA1UAZYk/QaGSAUw7awo9Nv8W
         EPAvOjbkZAerBXIavav+IZ6tPVwpsGPrM0bs0HubUQDYlVR2CPPADuy9NTeLejX7uYuL
         R3JtKc5K+vAMUAqw6s1K/xcqLe/Qn4Uuyyro0slX/Hr/zqUioWGXUofkZXj3xLt6a/V9
         aMi3iR4LtF9DUu94hwNtE4PNTw3lRxNCMyDu90rfLCJojRAK2ZYbpX6hASYSamM18SAF
         GL7jpSZkkAcmfQK9E9z1x/0SdJ2wVTSEMXKtcZudExlnCI23ZJaenT/dJXAAXcIk4t9i
         KQIg==
X-Gm-Message-State: APuU4Z8tc+IyeSHr2NxegRef4EQDCKOAImCmFRtiSGTxrAFuDfrEP84p
	hHfE79b7zKBfWXbS/XHpVGwZlhk1q3MnuVD5hKFg9o7oxmH/0XpLcv/Y4q/ZhA9NoCfRhJnvDnn
	SJUXimag=
X-Gm-Gg: AYBFou3wzz/10iYdywDp7QLKwyp9QZgol866I/VQWvIh5RN7+wY13rUAEB3jTQ443iu
	T1O5IPrjxAbGFgAxl8jk769tqD8PH6HAc3Y0bakLwYKMb59IyK89Hp/e7NfEg9zj8856gHGh1rc
	bZnrIByfBwZTQn3gIPaG7QW6A/bPhfvxAnjv6usGWVm/XZDNnaZi/GPSLC5VrpCVD7IoKNRzv4X
	1nyBxucGjyF6xTl4bDekqm8HRqJpf1Fnw73fDRFNQz3JabXmhhe9oc4427Q9h+BKDgmPcU27F2v
	RV+oMlwQ5WT/YPFvd7ewHXHgbpFN6dwv9PZrG3MK4czxob3AyfeeXE30mk+OqThxCbrQsz5/54a
	8iUmD3n/rD2JnFC/mPqP1Fwa+aG5UMEkdZQ7g8tg9Z5ck53ApMkz4CfQIeRpyfrEV62xYpce9Ex
	8QvPdKU/CB1L4wAyBi2VFLjzGeIIqg8FjDp41PqtTTIxtuVm2rPJG7dJ/Sncm6ybHhsa1dYbB22
	emVbE8gkZeWJ56zgOFYvPrTI9fYjIMMXm3Y2LdiJWpdwc8dJsF5ETGxo7j8kVGCFRYJEPC6zcdD
	ciyA3/UiP/J2rERtvs+4Z7c8I/NtOR1rRPvScDD0D/PU4qxOxgjnRlGeb2aicMwWELGJXO2D5uZ
	0/KGZ99zJBP7Z1gCq
X-Received: by 2002:a17:90b:58f0:b0:3b1:4eb6:b3a with SMTP id 98e67ed59e1d1-3b1b081887amr156909a91.8.1794513655679;
        Thu, 12 Nov 2026 12:00:55 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 08/11] ss: read socket SELinux context only for -z
Date: Thu, 12 Nov 2026 11:59:21 -0800
Message-ID: <20261112200046.2164391-9-stephen@networkplumber.org>
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

user_ent_hash_build_task() called getfilecon() on /proc/PID/fd/N
for every socket, even without -z, and the path was resolved again
after readlink() had seen a socket. The owner of the descriptor
could swap in a file on a FUSE mount it serves and hang ss -p
in getxattr.

Only look up the context for -z, and read it through an O_PATH
descriptor after checking with readlink(), which does not call into
the file's filesystem, that it is still the same socket.

Reported-by: Anthropic OSS scanner (ANT-2026-EPMKLNM2)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 5ecc5b5c..9d2f9891 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -533,6 +533,38 @@ static void user_ent_add(unsigned int ino, char *task,
 
 #define MAX_PATH_LEN	1024
 
+/* The owner of a descriptor can point $PROC_ROOT/$ID/fd/$FD elsewhere
+ * (e.g. at a file on a FUSE mount it serves) after readlink() saw a socket.
+ * Pin the object and check it is still that socket before reading its label.
+ * The check uses readlink(), which does not call into the filesystem of
+ * the pinned object.
+ */
+static int user_ent_sock_context(const char *path, unsigned int ino,
+				 char **context)
+{
+	unsigned int pinned;
+	char self[64];
+	char lnk[64];
+	ssize_t len;
+	int ret = -1;
+	int fd;
+
+	fd = open(path, O_PATH | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+
+	snprintf(self, sizeof(self), "/proc/self/fd/%d", fd);
+	len = readlink(self, lnk, sizeof(lnk) - 1);
+	if (len > 0) {
+		lnk[len] = '\0';
+		if (sscanf(lnk, "socket:[%u]", &pinned) == 1 && pinned == ino)
+			ret = getfilecon(self, context);
+	}
+
+	close(fd);
+	return ret;
+}
+
 static void user_ent_hash_build_task(char *path, int pid, int tid)
 {
 	const char *no_ctx = "unavailable";
@@ -580,7 +612,8 @@ static void user_ent_hash_build_task(char *path, int pid, int tid)
 		if (sscanf(lnk, "socket:[%u]", &ino) != 1)
 			continue;
 
-		if (getfilecon(path, &sock_context) <= 0)
+		if (!show_sock_ctx ||
+		    user_ent_sock_context(path, ino, &sock_context) <= 0)
 			sock_context = strdup(no_ctx);
 
 		if (task[0] == '\0') {
-- 
2.53.0

