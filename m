Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168848;
	b=OZqAxpu3FzAKum4BRnPInGBgVd9vs+c3Za1BB3nE61wwokS6brLYaXAvRho3XssWea2g
	 XId9ycVbJbJ3gbg/DKuMU2ANMxchKDpepcLy3ywxE3cPsgWJClaWwAW4mXki+tpQcSukP
	 oDb0YmiWYuzDRP5WRLdLaA9gGT6Zsdxd7gz0wsw7QBnvBWwZsRiML4G36auzgBW+Vw4M/
	 +6CYRbxmgX00hJ0xANPfQnVwF6VFBh3aBvJgWkWOrtYsqyXnXH+0bUTQaT3wDlg44sPPf
	 8aoVfMapC94QpNDkhZIyYGGoI/Ql6DrSCIqbCTpvs+Ko+1UkbRcGYQffgYOtsQasOCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IsNyGyRNTFcxWGn3Qz0OssQxOJ6qSTsmetDcQj0Y/yM=;
	b=3OJMJaFUpxICx/YpM4RMGyayDDu0MoB30O+E+qRVmLrFpbYJ//GxGw6omdJnS0mlEw+o
	 dJNNiOyaUU06s4gINiQN8yFfua/Er9SRUtugmovc46oZ3bP475pcjnSyjEgNwO2KjreHI
	 uJ+AbGaFZsruZB+4HhMuut6RAn38UjLOEQ2QYwGXI4w3q8SSRbIYo8+nn8tvaE+Yn2wCS
	 tA3rMk+3O54f0ibVDhJ6EuHKi5FZlOk/UB7pwy6Yl8bKztlqfGjjw/MOkcvIDLWG/e5FK
	 yyThwwFzV1nsuIiVl1mV1bfMzNg6YICQ8o1adBe+lAqTaa4ziq6M80HfB/cOpRHiicQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nKqNxiZn;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93001606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93001606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nKqNxiZn
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso120780a91.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 12:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794168847; x=1794773647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IsNyGyRNTFcxWGn3Qz0OssQxOJ6qSTsmetDcQj0Y/yM=;
        b=nKqNxiZnBY8DH0fkKdkvrcecYxQiU453RHD9QVFhR1HM9QDK8dTDnJON8MwH49TJIs
         Kh4JGFrUpYMUyiJzRXvZ7RkZd0GylMPd0by1+BjoJ8D1uGuxCxHBGhBd5LiN9QZ6Rgyi
         PDxN/wZVl/dyetRFLqF7nUw/mM/I4U/2+NZwys/7P2BHU2TJURhBLoz+jA/oOzZvIG5w
         +rDxTP/2Xqgk+COJZ0L6pssyyT6d3Kmo3xXjCZuRfOFVTctO6opk+nz2FlwwHfmiGQ/+
         STrArmDbojKMIPbXaWzXcYjV7PkfmeobbrW5GEc9s9QbvC1wDQ/pFNaPBBWnBS/AkscI
         Gecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794168847; x=1794773647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IsNyGyRNTFcxWGn3Qz0OssQxOJ6qSTsmetDcQj0Y/yM=;
        b=v8bLXYwYSaMwdVkNWZj3gan6EES1iVHYaGiDi9++7jfSQu8X44a6O+q55pRfm899k0
         BsL5kAZ/YQKmKbunZ7Z5XSwOoPpFizTqItaL3M+JV6HJ+tAtWTZ9+IW6GsHsD/udAv0c
         FTCRXEG7+6N6F8iAdcd4Y3SiIqLU2OzUbFH5kOPXoR22qh4fd2d5cDBjGQp8i93FrdUB
         KulclSYSBU7vCoQtx9tfEUAwWGpsVzpzRuAc74jG7vT3Wqi+YeZErh50nN3QLRSxGDP+
         lM1TjuLNmsYfPfoOACM/G0mSl/vBu7Dt9O4vtHDTRUGnWdljWLR7nfk84dcxTel2gTFo
         /+aQ==
X-Gm-Message-State: APuU4Z9SRpq6Rt57NwmbCM6L349OvF34f/HJbwuzN7xUJV0+OEGwTvVG
	BdSjRCTpVnBpRBrJ7X60WWAOX3zItY7rZg2tOnFcqpTOBn2TPn5I4uY/83oR6Ebnnv/2NwbA5Ba
	mRgpmaL0=
X-Gm-Gg: AYBFou3SllryzMWRd4hDkQxtEwdzsF5dGKE+uQUKpkxorYVX9CRo02Jlj4NoqLEe2YR
	aHl6Ns79kFNKBWavoE9jWODYLCAkc80W1sMtVV/ISUw5SL8t4Y+TMg70iaZ5KKOxELBq1ih9fM4
	bL7tuyQAGKyKhzL5njBnZdqTh+GS/t77cc2/aiYGDRNXRA1ZVH2vIlN4KEbkhbT/+FFNZHLj8CH
	aAd4F0ujMEeVAD/gRdpILowW0zC9NCSSqLpsSOYmjs2zA0TGY6VcIAnJ15lvKLVIPJqZiHsepCF
	sK6forxn6oSIETcQufBmpPgJZ6VLmDxS1bE+tk0Y9Q/eP8CBfHXRW4xK3GDAL27HCWdPcHrDTG0
	wuN3efolV+BnhqUecKzHifV1+c5VcSX+xD9ner55ojWK15m2XqHx5Jwgi3HPkzC0ndrkt0TqQGu
	pFwu4PduNYnR0vM5GZPjXez1SBw/LWPML+nOs+UFxNE5ukh1vNNVp5BY3XpCVKHUSKDDtz8DjtS
	vIfmQ6iBvd1TpUAjQYJKtdcZnwTKi/41R5fBWQdNpcwlSaMNAvq3KH5EOcMNbnisnH2lVA35VYZ
	MQiVtGt1htMq8mD2GiMMElKnl19cNUosq4bARXcvZxGhrLPVtrYr0pxiZPPnFb84MsnwOw==
X-Received: by 2002:a17:90b:498b:b0:3a8:699f:959d with SMTP id 98e67ed59e1d1-3b12d305b7bmr1966251a91.31.1794168846766;
        Sun, 08 Nov 2026 12:14:06 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127fad1d3sm4013208a91.11.2026.11.08.12.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:14:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/2] lib: bound the hostname cache in resolve_address
Date: Sun,  8 Nov 2026 12:14:03 -0800
Message-ID: <20261108201404.1133079-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The reverse lookup cache in resolve_address() grows without bound,
including negative entries, so a long running "ip -r monitor" can be
made to consume memory by churning addresses.

Replace it with a small fixed size open addressed table (32 slots,
multiplicative hash, oldest entry in the probe window is replaced)
and use getnameinfo() instead of the obsolete gethostbyaddr().

Reported-by: Anthropic OSS scanner (ANT-2026-XBIHX07L)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/utils.c | 119 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 36 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index c4cd3c3d..f4bd53ff 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1092,57 +1092,104 @@ const char *family_name(int family)
 }
 
 #ifdef RESOLVE_HOSTNAMES
+/*
+ * Small fixed size cache of reverse lookups (including failures).
+ * Open addressing, the oldest entry in the probe window is replaced,
+ * so memory stays bounded for long running ip monitor.
+ */
+#define NHASH_BITS	5
+#define NHASH		(1u << NHASH_BITS)
+#define NPROBE		4
+
 struct namerec {
-	struct namerec *next;
-	const char *name;
-	inet_prefix addr;
+	unsigned int	stamp;
+	__u8		family;		/* 0 = unused */
+	__u8		len;
+	__u8		addr[16];
+	char		name[256];	/* "" = lookup failed */
 };
 
-#define NHASH 257
-static struct namerec *nht[NHASH];
+static struct namerec nht[NHASH];
+static unsigned int nstamp;
 
-static const char *resolve_address(const void *addr, int len, int af)
+static unsigned int name_hash(const void *addr, int len)
 {
-	struct namerec *n;
-	struct hostent *h_ent;
-	unsigned int hash;
-	static int notfirst;
+	__u32 h = 0, w;
+	int i;
 
+	for (i = 0; i < len; i += 4) {
+		memcpy(&w, addr + i, 4);
+		h ^= w;
+	}
+	return (h * 0x9e3779b1u) >> (32 - NHASH_BITS);
+}
+
+static void name_lookup(struct namerec *n)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_in sin;
+		struct sockaddr_in6 sin6;
+	} u = { };
+	socklen_t salen;
+
+	if (n->family == AF_INET) {
+		u.sin.sin_family = AF_INET;
+		memcpy(&u.sin.sin_addr, n->addr, 4);
+		salen = sizeof(u.sin);
+	} else {
+		u.sin6.sin6_family = AF_INET6;
+		memcpy(&u.sin6.sin6_addr, n->addr, 16);
+		salen = sizeof(u.sin6);
+	}
 
-	if (af == AF_INET6 && ((__u32 *)addr)[0] == 0 &&
-	    ((__u32 *)addr)[1] == 0 && ((__u32 *)addr)[2] == htonl(0xffff)) {
+	fflush(stdout);
+	if (getnameinfo(&u.sa, salen, n->name, sizeof(n->name),
+			NULL, 0, NI_NAMEREQD))
+		n->name[0] = '\0';
+}
+
+static const char *resolve_address(int af, int len, const void *addr,
+				   char *buf, int buflen)
+{
+	struct namerec *n, *victim = NULL;
+	unsigned int hash, i;
+
+	if (af == AF_INET6 && len == 16 &&
+	    IN6_IS_ADDR_V4MAPPED((const struct in6_addr *)addr)) {
 		af = AF_INET;
 		addr += 12;
 		len = 4;
 	}
 
-	hash = *(__u32 *)(addr + len - 4) % NHASH;
+	if (!((af == AF_INET && len == 4) || (af == AF_INET6 && len == 16)))
+		return NULL;
+
+	hash = name_hash(addr, len);
+	for (i = 0; i < NPROBE; i++) {
+		n = &nht[(hash + i) % NHASH];
+
+		if (n->family == af && n->len == len &&
+		    memcmp(n->addr, addr, len) == 0)
+			goto found;
 
-	for (n = nht[hash]; n; n = n->next) {
-		if (n->addr.family == af &&
-		    n->addr.bytelen == len &&
-		    memcmp(n->addr.data, addr, len) == 0)
-			return n->name;
+		if (!victim || (victim->family &&
+				(!n->family || n->stamp < victim->stamp)))
+			victim = n;
 	}
-	n = malloc(sizeof(*n));
-	if (n == NULL)
-		return NULL;
-	n->addr.family = af;
-	n->addr.bytelen = len;
-	n->name = NULL;
-	memcpy(n->addr.data, addr, len);
-	n->next = nht[hash];
-	nht[hash] = n;
-	if (++notfirst == 1)
-		sethostent(1);
-	fflush(stdout);
 
-	h_ent = gethostbyaddr(addr, len, af);
-	if (h_ent != NULL)
-		n->name = strdup(h_ent->h_name);
+	n = victim;
+	n->family = af;
+	n->len = len;
+	memcpy(n->addr, addr, len);
+	name_lookup(n);
+found:
+	n->stamp = ++nstamp;
+	if (n->name[0] == '\0' ||
+	    strlcpy(buf, n->name, buflen) >= (size_t)buflen)
+		return NULL;
 
-	/* Even if we fail, "negative" entry is remembered. */
-	return n->name;
+	return buf;
 }
 #endif
 
@@ -1156,7 +1203,7 @@ const char *format_host_r(int af, int len, const void *addr,
 		len = len <= 0 ? af_byte_len(af) : len;
 
 		if (len > 0 &&
-		    (n = resolve_address(addr, len, af)) != NULL)
+		    (n = resolve_address(af, len, addr, buf, buflen)) != NULL)
 			return n;
 	}
 #endif
-- 
2.53.0

