Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513654;
	b=z6mFgSu27Spo4noHpeGCGKub90Uc8EXVs9Ev2F0w7rRBbGVOcIUwXb9eS/kJIa1srSXZ
	 1kR7xlGRL/rGsV1pCTR2gakLAtCbQpX/e3348n8yiBWJgFo0n2Cci3iRBPxThKFAE5kGy
	 wOTRqFgvtfjEFzJ1U6rWBHK0gAbjysJit+xK6C7Oew/s7ItFjJTjS+xbVgvRWPyquEHQc
	 8UL4kVGDYL3vqhEklOcRxNwJmwOobGLJnwteyfFm7wc3QZv0wzyGD/4fj5q5yiHsCjujm
	 vRKcVe/bubxqznV4/mp4sIsBrBlS9AWJXLT5KEb1SGPz8Oo+tRXCb5+3w6u1GN8p0nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D3ioM5FbqLAzMVzRmm6r4Dw7AFpHG1Pxcru1zd6kh6U=;
	b=Ygyzf3jzoe5Sc55q7JNtJr/QYvbpNaxh1I02yHLBBZ/NfhuSzddpIFY6chvLqfxwqCM6
	 7fC7fcXSSpTetOBPBEaOWwSRHGMf3Pf3U1yJKhBka6bhAajP6JhE4Z1KkyuiWmDfDv/Y2
	 IFtd+zBe32SkrhbI/qmqXVNDKJXtGRVBQjIfWDe27+wVo60FfVp0yw3TFIflZzsczdBHZ
	 fy7vCa+bHNOW2U42o5NUmK3pip2niaOhbchUDnZslm+0BvPJcxSGE6t57nayD88hRRwA8
	 3d2TUXpOEPj5KBK+uIsoT0zR2pi9N2dqmvxeFyZxwceEcCa/vhWsGf6nFvzro8E+8KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="H/25QXaI";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021B606A88D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C021B606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H/25QXaI
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso77997a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513653; x=1795118453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3ioM5FbqLAzMVzRmm6r4Dw7AFpHG1Pxcru1zd6kh6U=;
        b=H/25QXaICSksPkxFVMdUDQsaRlKgz3T8/++4u1/7c78Za6GwZ+98gb7whO/ZQvXZpp
         IrHApzoppxgMriRYCh/o8a47Oe4LYoT0x8+onhjE9eVnWGEILoqxtsPDMYULl+5+ek4y
         RoH6Bo2m1W3yQQFu2Bzuj6beXtdK154934mewqHIsc0VNCeOmEp+WXRF8LO7FRgWZjaY
         ibl6ZUVaZ1TtOvNrbBDu8wNxx7I9tKVs+Z6DHESR4M3H4xkFyQq3b720qF0IK0tk34kU
         /H2zX5Vkj1Gur1mdvZBNS1XFrCuMPw8S2igPE+Vv7Jr4zN+5igD+biJKRJ0ua/Z/8WxM
         7p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513653; x=1795118453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3ioM5FbqLAzMVzRmm6r4Dw7AFpHG1Pxcru1zd6kh6U=;
        b=ALS4sGxYTfRx104cS1C383Q0PE10Lm0uHdVhy8DZ/MDEH44agjYJ3TO4T2+PY1MnQJ
         f3BMgnL0toXrzEIpdey98jjKL+IWheoG2uzZGm8d733iyOE6Y+CgEUPLNkVeFj+ZJeEh
         s0C69ABu/qLpFeljwclSEERq3wb5K20BaA8TNAAB69Em2sA79J/ViLNJJe2E9x70I5iT
         cQMj4vbfr49YASOYaYsVOW5nOsFOXEHu0lq+RiGSkgjE3v4wKIQnHrzIIQ+4XHvQggHA
         d3iWbll8Uyg73Cnjk48xckaoFDG0dF0TSPQTdiqE5k1dRM93gqxSqFhjrc2If608064J
         oobA==
X-Gm-Message-State: APuU4Z8pnejR1yGOHKpGQHDBZ1Qozmyj1GXds8Pt+uZCLXXc5XchyHFV
	pPt+i3ihqR5rbN+g7zQYYf/4y0mQ8bqbULXcztaBexaMj6ro/NONCxqo03OjTU+CvIJ+5+nM0YU
	NJ+lO
X-Gm-Gg: AYBFou1zmjkrS4j5S6VIN8qFqfXo0IAFzdj4eTBD4yA1ij5BS4WSAX2WjQoER8q193y
	z6yW14B4RC7e5rmEafo/Onex1DGAQbLSHaw2nnXk+IzlzqeNkZzZetrqdN3Jz+eV1amGFY32bBq
	GG6pg3EAEKLZ24U+LYmQ0PBYoLShnjj7X+kzI823cQ09cg1zeCoTIidd3o/hW1JTKPJ2TRj8Bnm
	VrxedeU6H5i0FnJ7Lx5lpn6GK1twIaxmdRljqkX/RXoCnoqxfDVJAWAcxZ7QEMtCWeWarfd11U0
	ROb9757h9uHn4SyorDt7xZBMthhGJXQeEDLCP25FQfnx90R4ef9vaRTmzPDf+veqR6xwMkJMVIm
	xhlTEyxfyAKbvSmxDXkSqpVVEEtfX3YrUpbX+ALnovwl2+qDFkHNHBWyNtOxNO9TFEyb7CEKOQH
	KEmhPvvR4jlVexZrzY98BKX4RlLmXpjo1DbURjReyaz1nBheoPatLZzQbsGdvcwh0aMv9b8d2GX
	/K0iUWY4HZlqXZA+w+yuZVhseP8/W4L4dnodAeoz25Sho3I+x67IC54fgEsWELr9W4eEeAwMDVN
	6Gx45M0So8raxlgDcwPm27opCItf+/4OFfzV/S5p+Pf7jbQIWYHPHa62exmo3RsGaQPhGG0=
X-Received: by 2002:a17:90b:3985:b0:3ab:b39f:41c8 with SMTP id 98e67ed59e1d1-3b1b0b53626mr142499a91.46.1794513652759;
        Thu, 12 Nov 2026 12:00:52 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 04/11] ss: size the TCPDIAG_FILE buffer to the record
Date: Thu, 12 Nov 2026 11:59:17 -0800
Message-ID: <20261112200046.2164391-5-stephen@networkplumber.org>
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

tcp_show_netlink_file() read each record into a 16K stack buffer
using the length from the file, so a record over 16K, which the
kernel can produce (e.g. many TCP-MD5 keys), overflowed the stack.

Read into a heap buffer grown to the record instead. A length below
a netlink header is still rejected, since the size arithmetic would
underflow.

Reported-by: Anthropic OSS scanner (ANT-2026-RV0SH3JH)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 4462a479..3c538a4e 100644
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
@@ -3947,7 +3948,29 @@ static int tcp_show_netlink_file(struct filter *f)
 			break;
 		}
 
-		nitems = NLMSG_ALIGN(h->nlmsg_len - sizeof(*h));
+		/* NLMSG_ALIGN() is u32 arithmetic and wraps near UINT_MAX,
+		 * which would size the buffer below the record.
+		 */
+		if (hdr.nlmsg_len < sizeof(hdr) ||
+		    hdr.nlmsg_len > UINT32_MAX - NLMSG_ALIGNTO + 1) {
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
@@ -3976,6 +3999,12 @@ static int tcp_show_netlink_file(struct filter *f)
 			break;
 		}
 
+		if (h->nlmsg_len < NLMSG_LENGTH(sizeof(struct inet_diag_msg))) {
+			fprintf(stderr, "Malformed message in $TCPDIAG_FILE: len=%u\n",
+				h->nlmsg_len);
+			break;
+		}
+
 		parse_diag_msg(h, &s);
 		s.type = IPPROTO_TCP;
 
@@ -3989,6 +4018,7 @@ static int tcp_show_netlink_file(struct filter *f)
 		}
 	}
 
+	free(h);
 	fclose(fp);
 	return err;
 }
-- 
2.53.0

