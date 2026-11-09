Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259568;
	b=ckqnQnT0KUrpUQC7pL4sEeu+/re5JXLV+D7sD+3BB2gqfY4x9gcJkXDa3gy17IxwfZMU
	 7ONa1HAGbsF/k4wpdbgDl4r+niqV3s/y4ChCLZ4DnxFXoSNIstAFaWeRM8RGr/zkfuyQM
	 1V1/aA4969PDCcZ9ifNKBlRM2hVMRBVmBveHAuVG9L4FszBLe/fkIceBH71YHX8Dpkw4u
	 FWu1GeDAK+j+msGNDkgXi+YJ3flQSErnu5tY90VmuwxkA86dlyJYpoOoLAOAn0LhNazcS
	 2qb9ADTO7rqROsboBhC5EmfGxg41kt88R/1SkSa+qsFz4lpR7E6KlZAUBTBGJfudfjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xx17wf13SwjLtnf1RK71G+muIE4KEqr5H1clUaMohHY=;
	b=0Bmgs7YNROwO7qBGd+KGGsCQJ4H47GRkG0dwVF0/VDyHrtKyu0ZqrEr+4ImxU0xo9JPU
	 wRlKN7z+IGwM/ZXoj9gvoFHkDZFzGdIORq0rYZ6GiPw5B2m5GQFbTT4IsrrohskbCivig
	 MLwv9Dpr2RLZBHOC596gVlOyvWyCqOgOef1Y8l7+Ll2ITZg/N6peBbFKB1rG+/VVjXfYi
	 an/u6aUP+AJaeFxKuu2P3arIlnj8EptTyVEo5QmGSt7LgS+6aN+ak1hsEawRGWZn0PGt4
	 WfiEY/yybZJ6In7KuO9W3Q8NzW09qC26JITcq1I0ML2NB91I5JucHb2PyHuenF2QbYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Hb+z4J9O;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF084606A338
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF084606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Hb+z4J9O
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a594d313a3so760062b3a.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259567; x=1794864367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xx17wf13SwjLtnf1RK71G+muIE4KEqr5H1clUaMohHY=;
        b=Hb+z4J9OrZDo4w+C2ocf5l5qv04v76/Eb4UF4o63fOzzD/MOsOmreSGitr+x6ZUsCW
         o+JvMChAVXSDv1exJjHCcI9KykdkxsTUXCxi3rV++fIHX1D1ZDjh13SWnwBu2kqc2364
         qMKA2h7SNIEJINSZp8hYDQfuaIwFSfDADkOpDqHgtjLQWOYPN5aarBhaNZ5qxpWhZ4Bs
         NhWBFHYHVuYUPoxPefZw4ncixMI2eKGhwgWOiLX5ah2N8f+kxDIyyT7/OGF1TCWA0bHT
         OLNsspRNWDqBWRtjC61j8bKnO+kwbzXbd5pNTfmPIokmiZ+s662AmJxod4LlorxQVJId
         E6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259567; x=1794864367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xx17wf13SwjLtnf1RK71G+muIE4KEqr5H1clUaMohHY=;
        b=kJB5BEGV7ujSm2KP0BsDCB1e6Km3wxZbAP16hg79tBC0Y9mk4CKfbdztFBMT0vr6OI
         TpxNZ4U7QDvTFj1Qy72dZebSyWL4couubtT9L1djacr4tf8e880D5SzdUfh7jgwwobJn
         bdTCu77NqlUr7wtR1rtHyQRT6lgTMPd3+tEiFdVIvkCLQwRph16X1h1iPiJ8HGp3xIUv
         PCLuolBHcWy9Q90P800bjKkrrg64rurJFz44ovHn9KifPAp4M02QzOfZOUJwQ8HoG97L
         c9elO9iMzFhFKxhTVgUcTWaVXtVYzhWAvMo2KtVXk3+OYuOli1xn2LETapotTxvbqEXa
         2/mQ==
X-Gm-Message-State: APuU4Z/fadchgFcViLwjfymKwIdaRYcsRQP/aHDwP4DV1jDgrbGYPYiW
	jvzpDnasqZAdLaGU9mWcB6x3bX7qvBdYsigq1xmnY58aObMPK2e1ABxLTueKE5hM4JgBAbiKYy+
	C7b/TQws=
X-Gm-Gg: AYBFou3ozu+8Ev16APJK3NY9e0AY/uEQmzwgy55WZz3DkbcF/7suTbjSGhsB8AsHE3H
	q6S9yfXrM7bzD60kw8rI/in2hKeQK1CnS2zdaLz4BjpwQnc9+nQLScogVwuZYi2YtTENgrpVoWb
	fJteIMtd7nvw/PQF8UstpRLWmYlP0zO5NaK/DB8CdjjzFgyEyYhq86WAtoCGDXlLHxuP1FYFJK/
	gMnCP2cPMGaZuNn2rgefbpVSCzg0qRuZUCk/nM5FtZeUQTZUujXU12jNj50FSowY7Z0ofd8j7t9
	qTh+WO8izbHdSmJDNW/SXrHUGoPODx6ezCL0yNi2lkF/ZDgmrmJRVgfHs976SqLsFtRmP35MQj+
	1I0sk/SP7GQU4Iw28A0BmEyvWt5TZ5mbJ1GbhZiGfQdGzIHpHV/WasA3L6aQ8E/GpJ5EZjiYURa
	EsRutUwDz29xzoAFwxlrKIpRz/L5cR5fuIVbeEX5OfX9v7Gak5DivRAgIcVBD3zlOYiT+XZiAtz
	Nre3Xgm0nnuRrcq1Iw2NWI8qZbcxGEextwWuPxyhGd9CBxOgW0tNbTSHuMouuhgeHwPFf6YzNBZ
	SLCqWyDR4LzWiNM5HDEaJGQLApCcT37LzhF+FN/fHUpyX93n8riu1iv920/IftxpsFgy
X-Received: by 2002:a05:6a00:3cd1:b0:8a5:97ca:1389 with SMTP id d2e1a72fcca58-8ba860d3c91mr864506b3a.15.1794259567117;
        Mon, 09 Nov 2026 13:26:07 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 04/11] ss: size the TCPDIAG_FILE buffer to the record
Date: Mon,  9 Nov 2026 13:25:20 -0800
Message-ID: <20261109212559.39661-5-stephen@networkplumber.org>
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

tcp_show_netlink_file() read each record into a 16K stack buffer
using the length from the file, so a record over 16K, which the
kernel can produce (e.g. many TCP-MD5 keys), overflowed the stack.

Read into a heap buffer grown to the record instead. A length below
a netlink header is still rejected, since the size arithmetic would
underflow.

Reported-by: Anthropic OSS scanner (ANT-2026-RV0SH3JH)
Assisted-by: Claude:claude-opus-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 4462a479..e3a2e590 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3923,8 +3923,9 @@ Exit:
 
 static int tcp_show_netlink_file(struct filter *f)
 {
+	struct nlmsghdr *h = NULL;
+	size_t buflen = 0;
 	FILE	*fp;
-	char	buf[16384];
 	int	err = -1;
 
 	if ((fp = fopen(getenv("TCPDIAG_FILE"), "r")) == NULL) {
@@ -3935,11 +3936,11 @@ static int tcp_show_netlink_file(struct filter *f)
 	while (1) {
 		int err2;
 		size_t status, nitems;
-		struct nlmsghdr *h = (struct nlmsghdr *)buf;
+		struct nlmsghdr hdr;
 		struct sockstat s = {};
 
-		status = fread(buf, 1, sizeof(*h), fp);
-		if (status != sizeof(*h)) {
+		status = fread(&hdr, 1, sizeof(hdr), fp);
+		if (status != sizeof(hdr)) {
 			if (ferror(fp))
 				perror("Reading header from $TCPDIAG_FILE");
 			if (feof(fp))
@@ -3947,7 +3948,25 @@ static int tcp_show_netlink_file(struct filter *f)
 			break;
 		}
 
-		nitems = NLMSG_ALIGN(h->nlmsg_len - sizeof(*h));
+		if (hdr.nlmsg_len < sizeof(hdr)) {
+			fprintf(stderr, "Malformed message in $TCPDIAG_FILE: len=%u\n",
+				hdr.nlmsg_len);
+			break;
+		}
+
+		if (NLMSG_ALIGN(hdr.nlmsg_len) > buflen) {
+			void *nbuf = realloc(h, NLMSG_ALIGN(hdr.nlmsg_len));
+
+			if (!nbuf) {
+				perror("Reading $TCPDIAG_FILE");
+				break;
+			}
+			h = nbuf;
+			buflen = NLMSG_ALIGN(hdr.nlmsg_len);
+		}
+		*h = hdr;
+
+		nitems = NLMSG_ALIGN(h->nlmsg_len) - sizeof(*h);
 		status = fread(h+1, 1, nitems, fp);
 
 		if (status != nitems) {
@@ -3989,6 +4008,7 @@ static int tcp_show_netlink_file(struct filter *f)
 		}
 	}
 
+	free(h);
 	fclose(fp);
 	return err;
 }
-- 
2.53.0

