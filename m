Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247717;
	b=SVYgCvq8IEQ0Yjs1gmKGZQVT6jjbwOzPPs0c1WZuh16SkSWAthdisavAOFrZpt2uFIjf
	 pDHmFvYi3Ugi4Xt89u//IgaWxunfOFK5S3IVwVc+dERBhRTvkZCNSSIioomOT5Rm5E7gj
	 /KEquGgdRyZBH9iW1ttFOtzk9j0UnMhi+PY7rgbY9/sjeSQUop0ltwak/bauIyKtPMApc
	 aE5b1LzaBLxkvMA2fdhC5f/gdg+TDGydZvIOPtsllVDjvdOcCj8HOultW4qNsglP/O2bF
	 +MEP3BjGLnjFIlv3wr/bT4wQ5at9TcmHdR9cCrOActsqDzbiN8ri6m6d4T8rSQc3TnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IsNyGyRNTFcxWGn3Qz0OssQxOJ6qSTsmetDcQj0Y/yM=;
	b=UDBlFP6yH7PmfbK6KErlDo8ewA8REp7aNt5kn1von/8a4mmC0LQAQfxfw1ke5qjhkMD9
	 aSFxVH8MrEARw6IMDeUaPechVGAY0F5XQ/vJj0ubOHVaNslcSFK/C7wOEKtDiMF96f9B/
	 aHGABLQNhlS2IA8qOH0qippwcVxPGFrql4CQhPV4VUilwAkYhHr9YTh34ysPaWLeLksUh
	 4MCw+ZR8DyWgqH1fi/UcaO+2p+1UmZxZRgqi1tGb5+qlHUeE/i+5Q6+H0UDU3WUCCpUUL
	 zFzBkqRCPiTYw3yy6ZEJORV4kxnCwKSdYuJONbup+BQaW2wjdSjtFhAgxPAFY3xwVqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bEeRBgG6;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E564606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E564606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bEeRBgG6
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso529419b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794247716; x=1794852516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IsNyGyRNTFcxWGn3Qz0OssQxOJ6qSTsmetDcQj0Y/yM=;
        b=bEeRBgG69XOH6nYcC1uacA2zNEZHqfTvLKMIugV83OBrnEe52T4IFspn06tUbL3EcA
         OqV+k9FJZgfW8p5pNBZgR5Brhh9MC7yf5gIiGnSACAAqkgoep6rdI4a9RPRQsjI5NW08
         0jqmxoEzsgwigBdICrUU5cw47hEKc46gLi1w2agyKQSEW9vy/NQaDn8NfYVz8s/vkdD0
         24H9rlP0yywSNSQKa5Y3nUhifoIv1hvmcjJpBpYY3z9Pcm1Me2aFRm3YhMczJ6jVgwxL
         mU9/vu8y8hyvtOPQm+VMJGpnM1000mRtpWXvZ7R7HSEALDEiVcMGw2BFb3tLuAmEYOcy
         RHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247716; x=1794852516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IsNyGyRNTFcxWGn3Qz0OssQxOJ6qSTsmetDcQj0Y/yM=;
        b=FKYzONk2HibBeTDOgttZuslMEM3gB0C9osBtIp3aDp1TuAySomLvORpOt7Xy6QzDwM
         QXAgn/XWsGQ+0ikukSLQU9kdTwDiHJCD/snvmwsgGeJncpuaRfS1LGS5SGnAZM/Q2he2
         5Wj+aBV1GIvWKNtBqBvTe4tn03evhEde0pU3VZatnruManj8nU7Y2Ermivoly7pMc+14
         kgVgvtAlnFFHMPm52pnlP2A+A3L+6mqVL5yMha4m4CGZHSiXdUZaVgk+1tEqfYr/IXgh
         hpHIhqp2FQ8jRtgHjFvVe+NzBgQPlUPHy490eNBgwd6GkaW8TwmwuWLomGamd1ztdskM
         jW4g==
X-Gm-Message-State: APuU4Z8RhiN4t+F9IL7l963DYZ/MKHFBKjxvUDHAmTdWlHB+0EiTRviV
	qZ1GmkOFMmdSsjLZ298VkekBWvJwtagJ7y5OS2zRygOudmS77A2r40JWMJedAbr3egkZBsK0Fl5
	lTP0beyk=
X-Gm-Gg: AYBFou0W6o6VcW/58uClXW5mNLt++6Uua7IR7eYPLGox4SC+QB14scx25M7XA3UMT6e
	8d/dVfTrCX5KN0NGvVrqTFOmkrHF/pfKy0LgkSG8uuPMcPduV+52nGE10xwMyjUPKEeWU9b0xif
	sNzJwwnBKOSrlDzndTMvEMs36QouJjGgq80FnaW3ORt1NqvM+LMWOEUE0s4cbI5Nat/S6LE2Fhu
	ZkD/VCwKRRiji/HSR916cAOQOsbU793ARGkgKDCroKSfwt65S68BDtpY+Y4luwjbIT/dnrURTAv
	1eNDNtAN7osTcrwcMjPjSjpPJGtZNoGdYtF8Cl3kadqg7om9P2GV3PAlC/QZOkvQRVZAKqjSV+R
	wZi5mmwtCeSeFnq7kd4ZSGhVuFbdiwP9REFsz3bT0tkPS559QBKDnGJyo+qggIix/ZFCd3QxP4B
	CcWax7D8fkzx29SJhblnF3GDJHeJ69X8t6Zltcj1uGJNcX1mOIpCoeUvsDc2BP6HhdDJzORbb2a
	feS4YnABFcI6UTsHxdDMrw8rXZUYBkEwIPCUVsQGfyJ38Gc2v5fipvEtPrCRsbkdBck2Tfl+8OF
	nl/tXTaufEFOvPOmKS4/Ruu7zUupntXaE+tEt1MAYQ9giJYYuKE084yzwqEpu6JOTAMT+lQ=
X-Received: by 2002:a05:6a20:258a:b0:3e9:1b8a:a646 with SMTP id adf61e73a8af0-3f172f407cbmr213572637.25.1794247715849;
        Mon, 09 Nov 2026 10:08:35 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7a244asm51746a12.20.2026.11.09.10.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:08:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] lib: bound the hostname cache in resolve_address
Date: Mon,  9 Nov 2026 10:08:32 -0800
Message-ID: <20261109180832.300754-1-stephen@networkplumber.org>
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

