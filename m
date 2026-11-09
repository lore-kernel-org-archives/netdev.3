Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259569;
	b=Pxjoji0FArrO0f6BdZyG9xRma4r6U4ZBaA3JyZKgw7RpAz2Nvk2PJqf63ikPLZxkSY4H
	 yNeP9ysBq014EcIyGdcjOw+QGaoVvMUoi0d8LxUbjXBKd6n+TTqkErHeM0iDyEKtk4P9r
	 WvwSArinZX+FtO6n0j10GhuM/nGyMKYH0bgiovn0PhpjHt7eDjkfyUf0tBTIRmusNzjWe
	 xpCI4D2yz38b8kAEeO06q4OtdVOmvsIckM6rpIUi1QdfJwi83W/saQcF2IVf4vGvP3sT3
	 8MN+sUtnjUTYWc+T02apRbikIIFlymGsAW3PRwaFU0Iti8X3Epjov1iQiqYlA/15HxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cv/SRO2Zxh1BOLALjK9YZ6NPU4IRjF0nq7U0g8LT0f4=;
	b=pfQa01XcLDneHkeKwcgvUM9wZHR+Ylko3RcqKfHmjRmzTX51EVh7dDC3+Rpb/MPy5Zh9
	 0eWtHg3jCy65qeisWsL0BgUQzcr9jRMLUyqan4pndCBTCr/67xOp9ckPrZh7ErmMov2nG
	 e1tpkxmiD55S8NpGL+yNN9SmzIwtDkVrpSwxsgQnvqXFfD7nFOb6mBZhFu9CmUTK5GutQ
	 W0uUizqaQIScTgFIWc2dvmre92eQhm9UAOssxXA5l1/7DWWZl8f1g1VqbQ1la2J7iJrDe
	 T7Q0EP4e783087UuMgpCLIbikbuUagDzdqEzHgK33qcKoKO6l2x/WDlDF83fvDkSWjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=s73AWTPm;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6506606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6506606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=s73AWTPm
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so1199820b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259568; x=1794864368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cv/SRO2Zxh1BOLALjK9YZ6NPU4IRjF0nq7U0g8LT0f4=;
        b=s73AWTPmbt3OFMOQs4MTFokN0+2dnNmN7mC0lOk1eGmTr5QZGPgQH+GHlHfk2c405G
         SbEXfnFDxq/mRw53MgBd/hjdir0246qFhaEAeNftH/M6OiZDf2jg9xbd9tFY7LfEjXaA
         g6/A/0t3vlDLYFDqZCOW47oYjmWhmRBJOOH67Plg8StzwmcA9XZxHYoI0n8TKTPjD5Gj
         lB9BfvkNSpNwsx5WhTXebSFh5b6vDxEKh91JEeAQaIqiasjQptirmxIK1tm2xHJR/lLN
         IuvEpNjsXebPn11AyxLljlj8WQTM4tq3ffIofmXqSBYk3zV1L67hRUGfaoYYThdjKchS
         aapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259568; x=1794864368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cv/SRO2Zxh1BOLALjK9YZ6NPU4IRjF0nq7U0g8LT0f4=;
        b=jK+GA+mmxfP4+nCglDaWBmOAdUVh4ltupnOH18jdvC08K9pu28YD9vbyfSSw73Pfm8
         vqqZMe6PQnzJqQqlAbyTiWQrnqqc/fQN+DIkgtvF3N9qj0pQuv2QsYMDRvgWAWrROTnQ
         tsOSIPGasEOH4ETf86SgATdXZpPs6sMHiQaDusjbrFgpWcWKKLk+wh7/NA/fREcqskYS
         HLWzTwORi5/9NGmnBm6olMQIiUaO7b7sTkEddHK2IgHcB/32sqyfAcS0SB7gGKVj8F4e
         BQDSKI2XbSnl/NqPEAOmixhrhBOUjANlEb97Hy/FGQ1ZrrsOChCLTamPkfMvY5DLgT3O
         eifg==
X-Gm-Message-State: APuU4Z/1MNscikioir/R8vIoE0xQF76eqhuWS7ma+sJQzKI8zJGIikFr
	SK9eK8eA4LrUjIODv7zzLnkD4ub2V2whcl79ZKFmqBuFZmq0DKGXxlGNN89i//2BHUQKtRoY2/7
	BoAsMjjE=
X-Gm-Gg: AYBFou2dg/FUR6Xx0lIU5wX0VeO3xl+pChJKnQILbUqe3x0erDy2NZlpSDT25zgUhl2
	Q8Kl4/oC1/N/Rl66gP7EpkeX15u9UaFljg1Btq0ly/9mS9Z7G/MHJ9UQsZFiMIoWPLZD4VdrLXG
	cDY70HldKj+SADWDeTa7DJIBJuKJv2ZXarn/HtR2HXeM4W2/JDh+BkU5jR+WoSVZD8UbZng9f6X
	DrkOzA7hUojPxw+y+zK7ZsxIY0k1hQUjBjscM5avLdAf+mSWLNJf/g3+i+nKazGuAyY5g9qXvx1
	kHXt7N3N3bWQfvvs1aO69exilYmUGJzVPoD/myygCsvb4uP0MilagndT9cDXcUswLq8TZoLrx70
	UKsGmWod46Me+BI9JBCaFpPe0CTDaAcoYSNrnTjExsB1jkNwpVBRgH5M9dzPS2h60VZAF+Otcf5
	UoKMxKiQzeY1skGtcYfXd6VtVYzNUwoBopDyedMAoqBWAbTOLsT2ZYD8mJEN+rYw8jUGq0fqeZF
	Ysmt+OYuPSJM8aHgxj7QTMsIZpK3dhZbpS9fw7E731lERIFCFanXEoFuKUuxQhgb6B/dAlDaixJ
	ZLdW3lBdDns5z8CR3H7ofus8r0fObTGmhG57BLVBe0ElMh95Z2Hx43wln3BcNj9QLoLH
X-Received: by 2002:a05:6a00:ab87:b0:878:3783:8a88 with SMTP id d2e1a72fcca58-8ba8b192bdfmr826361b3a.52.1794259568221;
        Mon, 09 Nov 2026 13:26:08 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 05/11] ss: replay all dumps in TCPDIAG_FILE
Date: Mon,  9 Nov 2026 13:25:21 -0800
Message-ID: <20261109212559.39661-6-stephen@networkplumber.org>
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

ss -D records an IPv4 dump followed by an IPv6 dump, but the
replay stopped at the first NLMSG_DONE, so IPv6 sockets were never
shown. Keep reading until end of file, and apply the -4/-6 family
filter, which a live dump applies in the request. The family comes
from the file, so check its range.

The ssfilter test expected the IPv4-only output; add -4 where both
families match and add IPv6 cases.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c                     | 18 +++++++++++++-----
 testsuite/tests/ss/ssfilter.t | 26 +++++++++++++++++++-------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index e3a2e590..527725bd 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -444,6 +444,9 @@ static void filter_af_set(struct filter *f, int af)
 
 static int filter_af_get(struct filter *f, int af)
 {
+	if (af < 0 || af >= 64)
+		return 0;
+
 	return !!(f->families & FAMILY_MASK(af));
 }
 
@@ -3943,8 +3946,8 @@ static int tcp_show_netlink_file(struct filter *f)
 		if (status != sizeof(hdr)) {
 			if (ferror(fp))
 				perror("Reading header from $TCPDIAG_FILE");
-			if (feof(fp))
-				fprintf(stderr, "Unexpected EOF reading $TCPDIAG_FILE");
+			else if (status || err)
+				fprintf(stderr, "Unexpected EOF reading $TCPDIAG_FILE\n");
 			break;
 		}
 
@@ -3973,15 +3976,17 @@ static int tcp_show_netlink_file(struct filter *f)
 			if (ferror(fp))
 				perror("Reading $TCPDIAG_FILE");
 			if (feof(fp))
-				fprintf(stderr, "Unexpected EOF reading $TCPDIAG_FILE");
+				fprintf(stderr, "Unexpected EOF reading $TCPDIAG_FILE\n");
+			err = -1;
 			break;
 		}
 
-		/* The only legal exit point */
+		/* One dump per address family; the file ends after a DONE */
 		if (h->nlmsg_type == NLMSG_DONE) {
 			err = 0;
-			break;
+			continue;
 		}
+		err = -1;
 
 		if (h->nlmsg_type == NLMSG_ERROR) {
 			struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);
@@ -3998,6 +4003,9 @@ static int tcp_show_netlink_file(struct filter *f)
 		parse_diag_msg(h, &s);
 		s.type = IPPROTO_TCP;
 
+		if (f && !filter_af_get(f, s.local.family))
+			continue;
+
 		if (f && f->f && run_ssfilter(f->f, &s) == 0)
 			continue;
 
diff --git a/testsuite/tests/ss/ssfilter.t b/testsuite/tests/ss/ssfilter.t
index 4c2315ca..cc0f01a5 100755
--- a/testsuite/tests/ss/ssfilter.t
+++ b/testsuite/tests/ss/ssfilter.t
@@ -3,21 +3,27 @@
 . lib/generic.sh
 
 # % ./misc/ss -Htna
-# LISTEN  0    128    0.0.0.0:22       0.0.0.0:*
-# ESTAB   0    0     10.0.0.1:22      10.0.0.1:36266
-# ESTAB   0    0     10.0.0.1:36266   10.0.0.1:22
-# ESTAB   0    0     10.0.0.1:22      10.0.0.2:50312
+# LISTEN 0      128          0.0.0.0:22         0.0.0.0:*
+# ESTAB  0      0           10.0.0.1:22        10.0.0.1:36266
+# ESTAB  0      0           10.0.0.1:36266     10.0.0.1:22
+# ESTAB  0      0           10.0.0.1:22        10.0.0.2:50312
+# LISTEN 0      128             [::]:22            [::]:*
+# ESTAB  0      0      [fec0:42::24]:40520 [fec0:42::1]:22
+# ESTAB  0      0      [fec0:42::24]:22    [fec0:42::1]:44248
+#
+# Each test filters to one address family, so the address columns are
+# not padded for the wider IPv6 rows.
 export TCPDIAG_FILE="$(dirname $0)/ss1.dump"
 
 ts_log "[Testing ssfilter]"
 
-ts_ss "$0" "Match dport = 22" -Htna dport = 22
+ts_ss "$0" "Match dport = 22" -Htna4 dport = 22
 test_on "ESTAB 0      0      10.0.0.1:36266 10.0.0.1:22"
 
-ts_ss "$0" "Match dport 22" -Htna dport 22
+ts_ss "$0" "Match dport 22" -Htna4 dport 22
 test_on "ESTAB 0      0      10.0.0.1:36266 10.0.0.1:22"
 
-ts_ss "$0" "Match (dport)" -Htna '( dport = 22 )'
+ts_ss "$0" "Match (dport)" -Htna4 '( dport = 22 )'
 test_on "ESTAB 0      0      10.0.0.1:36266 10.0.0.1:22"
 
 ts_ss "$0" "Match src = 0.0.0.0" -Htna src = 0.0.0.0
@@ -46,3 +52,9 @@ test_on "ESTAB 0      0      10.0.0.1:22 10.0.0.2:50312"
 
 ts_ss "$0" "Match (src or src) and dst" -Htna '( src 0.0.0.0 or src 10.0.0.1 ) and dst 10.0.0.2'
 test_on "ESTAB 0      0      10.0.0.1:22 10.0.0.2:50312"
+
+ts_ss "$0" "Match IPv6 dport = 22" -Htna6 dport = 22
+test_on "ESTAB 0      0      \[fec0:42::24\]:40520 \[fec0:42::1\]:22"
+
+ts_ss "$0" "Match IPv6 src:port" -Htna 'src [fec0:42::24]:22'
+test_on "ESTAB 0      0      \[fec0:42::24\]:22 \[fec0:42::1\]:44248"
-- 
2.53.0

