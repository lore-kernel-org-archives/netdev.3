Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259572;
	b=wWc/uqM/FqpApv+PIoyjR7etDOizAPGFwFoOQryztnfBuyAHhPLC/ccXao+NoXp39msE
	 hOb7aCSIbqVzePkK+7xIBl9eX9NkmHj091wktzWkcAmcAJZ6yMrsaUA5P8pn9nT0RAyOD
	 aoY8OR/jyJJne3IbHaP1+5w9hDs82dCJT2aH0m7JLsnhwotlLiQU5LLr3HMC9ZyK1tXVj
	 J0Zfs+vXmSNwFE5DI6q6olm3SG0uIypf5JQmxBc/Mt/2TBslSziefpZTiPC1dt//rt6Bp
	 0ql+IeV7jgfFLWKDwLHIdnpJi/wkfI4Y4IL8ymixCeRPI/0fHsRuDxd0T2Hn4Cweo3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TL0XXlxMki1a0bp6bZbxAAcouCZGrlzuovLgQQ30PI0=;
	b=08H7lWUupIXmZ6lcrJvzHxsYBCl6vyODr2b52O9zE/l0WgeSs59dQ08J3BM1TUmr5Gbv
	 1sL5+uFpV/CgdrnMlXCwyG6MjoOvxUp314DHmWMSSxl5QbVFvkRIk4GifTB6R+36uggX+
	 1O7Fm2+ag4DyAIdd3zrfsTS/CJq4POGCgRgvaz8hQPGWj750w1aVWsZsLec3WhaTEmDCm
	 CFn6Y/tohhPiWpyjbMXibyT2d5TFDdpXCe04bd73vVbWtFNobhcYZ1eb/Ll3nvStfpXmd
	 Q9FaglTZJj0y2PkbAQKC3qZuAVVtzT7VKYyJ0HVNVJOK8CcirqsH0letW/Uk4QOdI+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qm3ppeH9;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D160A2605
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4D160A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qm3ppeH9
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a058315c79so673636b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259571; x=1794864371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TL0XXlxMki1a0bp6bZbxAAcouCZGrlzuovLgQQ30PI0=;
        b=qm3ppeH9wm6ONcFQVC4biQP7jKniaFD/2/uYwgCg5IhymnDrqatLeKubcnUd2xTVSr
         Q1byY9Ri665mibCVCT3LFYxHQSP0XcBphiOQxJDl5MMHHo1naFqYQQDawAmqctL4Qixe
         8/GpUd5l5v5YlxWkjq3Z+CbsLRUT9AaUc6VpLZU5DGQx2bSYoVtqdYT2MEA6GZ9IFVxC
         YqtOvE2bsUylgpZuT7Bv4+zJoKgsG1eF5sXaioeDfh987jGPv8lFXx5tvu7Jz/4T5jpn
         f0gE7eP3DT9sruq7PJy4jtLhH2Ety14QrmlG89MkNCe7YKJWQ47mmue0vFW5+renyZfy
         oAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259571; x=1794864371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TL0XXlxMki1a0bp6bZbxAAcouCZGrlzuovLgQQ30PI0=;
        b=Ac5P0qJFvEb6QvUZ4F2gk9ApXEFjOyUKO0LX34kmgaqi8KBAEWD3uvYfI218oDlQ6O
         6fD/7ErPBKpirV+wS5f85VvGTYvV9b/2TeDIGCv6Ml1R95Ov2uya53+33iihBKMy3kDM
         3IDpUm6vS5FJCv3XAbAR+H6fmrZI0YeOhYK9PwZ0w6bBOdh3XEcLpcjfPcbWtr057ptG
         +OjqoTzju9ytARQHESiPDWCeJAcWX4iIRoOzo+wUexdUlp/8MfksPFb4U47giSTPmgCF
         hGlv8Ebx1pd98O59064tNqyA+VaYVbbj8Z6au+MrqpupMk/4UOxKxsKQs5PHgRHaIjhl
         4k7Q==
X-Gm-Message-State: APuU4Z8xibEXMHNcNzHdGEgtxx07eeodZo7rp7kDjYqwxL9e+fi61VIe
	ch7Rq8wvZ48l4mGuS5Xgmnex2tf2QtwA2DteNpsM+qWvzGfuM6tn/vM+jTpMaxoZwt9hWAI5lpu
	c0tTpuKU=
X-Gm-Gg: AYBFou0BCDDORM45QXn/NehiHvzCIWTnAfm27rPOJPRivU5WQ0fT+cFwjFqLf/MdRyo
	M6EihyBlvWtw85HYj7klYNd94aKkAVv9vIntMjICXzledgowNZ5DN03JCAF9WDwXd5XM3J5MATE
	N0Oyv7bJ5JxDXI9HuETFq4Len1Y1S0j+ESb9O2IBGh87iQE85phmLNqDT0bk9NXjKA7gPBKuuEc
	x3c5tNQJut2f9qKdrkiXWv2uvUUQeXYbvC2Q1Q1y//wMSeBuGrwfX6KPk4XG9alS5DEOI//gJzp
	v47rDhLaOO9KBfx/uIbqRIEHTlLXbWPUUpXObpeSBZGxhlBhx2XwSwz/+KLd22kWD2QtefC60jU
	pEkfifHBO/RCoYNzpEuvrnMZMu06WOvovxy2DukajXfgiQCH57Ywrw6qdy9rJXjEVESGHvXMc47
	k2c4E1fyjQ0e08cGPH8n7Rxof5o1T69aPKZhYB14gmISGZpWS/a+uip3X4PUGl+I/ts5DoJQSsI
	sjx2QuPXsNRYbsLkIoUo9LpSCZzRgytoTpMJrY4V/2mxMrMoluyNs8CfLfwJaKSmdzesN6tnMRG
	Tb+G62KO+Bu8Vnkx+S3vjfYPWu7c1+cFoVTwZKT+ME0IUVlT1Ee9+hps1lESHyEBzcgi
X-Received: by 2002:a05:6a00:e0e:b0:886:73c9:89d7 with SMTP id d2e1a72fcca58-8ba85237216mr792341b3a.11.1794259571544;
        Mon, 09 Nov 2026 13:26:11 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 08/11] ss: read socket SELinux context only for -z
Date: Mon,  9 Nov 2026 13:25:24 -0800
Message-ID: <20261109212559.39661-9-stephen@networkplumber.org>
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

user_ent_hash_build_task() called getfilecon() on /proc/PID/fd/N
for every socket, even without -z, and the path was resolved again
after readlink() had seen a socket. The owner of the descriptor
could swap in a file on a FUSE mount it serves and hang ss -p
in getxattr.

Only look up the context for -z, and read it through an O_PATH
descriptor after checking with readlink(), which does not call into
the file's filesystem, that it is still the same socket.

Reported-by: Anthropic OSS scanner (ANT-2026-EPMKLNM2)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 74cb3be1..4b3d1fa4 100644
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

